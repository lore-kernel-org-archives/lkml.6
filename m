Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B2FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BD6213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJZ0HGPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5BD6213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbeKZVkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:40:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:53000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbeKZVkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:40:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D1BB2089F;
        Mon, 26 Nov 2018 10:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229201;
        bh=pVLCYl4Lwd52MoDjpGlb2JNm/253u5YvAF66I3g7MxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dJZ0HGPcEN8WSwAVMKHz58YdCXWbYY1i8G4nBxTeW4SUdSvcyyen6usSEkXVk41b0
         yE/TZ83psjj9vel5dTxpWBhPgxrRyP4jN7aqqO8KWkKnGMVq+7JPlX63MAFkk0o/bB
         90P8ErwdzqvlmeucV73Og7a6w88PSFftxlagutCA=
Date:   Mon, 26 Nov 2018 11:46:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] thunderbolt: Prevent root port runtime suspend
 during NVM upgrade
Message-ID: <20181126104639.GA29089@kroah.com>
References: <20181126094746.65030-1-mika.westerberg@linux.intel.com>
 <20181126094746.65030-2-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126094746.65030-2-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 12:47:46PM +0300, Mika Westerberg wrote:
> During NVM upgrade process the host router is hot-removed for a short
> while. During this time it is possible that the root port is moved into
> D3cold which would be fine if the root port could trigger PME on itself.
> However, many systems actually do not implement it so what happens is
> that the root port goes into D3cold and never wakes up unless userspace
> does PCI config space access, such as running 'lscpi'.
> 
> For this reason we explicitly prevent the root port from runtime
> suspending during NVM upgrade.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/thunderbolt/switch.c | 40 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)

Is this a regression?  If so, should it go to stable kernels?

If not, and this never worked, should this just wait until 4.21-rc1?

thanks,

greg k-h
