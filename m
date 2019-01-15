Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3201CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0B720645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547571243;
	bh=jnYErAN+63vh7i9QlfZ4O+HWC/qDlb0XxZToPNgolW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ywysHqeYBIqvNTnsnlz79sWzyhmJYxHilBK36b7i53EX7PEUz9yh0tAzMMrmb+0u+
	 FNE9F2E53JYaBiSxPxHO0XDK2swWEcZp3N5Tlvo9SlcCngjLmMNI9Ui85C+LT0/lN/
	 XsUuP0wN4zpH4SevQSe0JFL2G3i8IuGlbzo5ggeM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388037AbfAOQyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:54:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:39354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388025AbfAOQx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:53:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4DE120657;
        Tue, 15 Jan 2019 16:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547571238;
        bh=jnYErAN+63vh7i9QlfZ4O+HWC/qDlb0XxZToPNgolW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ut5zjPp7w0E5nGmZJ4ffC3RU0zqDUh5u3samocPJ3zrIIhzV+p55Xe3F39s+oXjey
         EO/pGs4G88SmBEnZBihDV6Zwqll/uiPDoWNKQTuLgeSbanS2Ilc3c/y6H2gNqB9DIN
         vwKSdHG7tDIncQU1kT0gbQLeAsB3zNg97pYzwkpw=
Date:   Tue, 15 Jan 2019 17:40:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nikolay Yakimov <root@livid.pp.ru>
Cc:     Saranya Gopal <saranya.gopal@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: Fix configuration selection issues introduced in
 v4.20.0
Message-ID: <20190115164016.GA25341@kroah.com>
References: <20190115161354.6806-1-root@livid.pp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115161354.6806-1-root@livid.pp.ru>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 07:13:54PM +0300, Nikolay Yakimov wrote:
> Commit f13912d3f014a introduced changes to the usb_choose_configuration function
> to better support USB Audio UAC3-compatible devices. However, there are a few
> problems with this patch. First of all, it adds new "if" clauses in the middle
> of an existing "if"/"else if" tree, which obviously breaks pre-existing logic.
> Secondly, since it continues iterating over configurations in one of the branches,
> other code in the loop can choose an unintended configuration. Finally,
> if an audio device's first configuration is UAC3-compatible, and there
> are multiple UAC3 configurations, the second one would be chosen, due to
> the first configuration never being checked for UAC3-compatibility.
> 
> Commit ff2a8c532c14 tries to fix the second issue, but it goes about it in a
> somewhat unnecessarily convoluted way, in my opinion, and does nothing
> to fix the first or the last one.
> 
> This patch tries to rectify problems described by essentially rewriting
> code introduced in f13912d3f014a. Notice the code was moved to *before*
> the "if"/"else if" tree.
> 
> Signed-off-by: Nikolay Yakimov <root@livid.pp.ru>
> ---
>  drivers/usb/core/generic.c | 44 ++++++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 19 deletions(-)

Were you able to test this on one of the devices that ff2a8c532c14
("usbcore: Select only first configuration for non-UAC3 compliant
devices") was created to fix?

thanks,

greg k-h
