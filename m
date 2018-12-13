Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20F0C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB3620873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 07:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544686605;
	bh=X+S18UUtHo6wXC42+u8c4Vx/NfkM19yGBVk6povlXgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N8ToSWNGorYa6bSR295CQhOCRD53sIAkVBohSWuwM7IX4wzl7MsNEAEyUbRe0RNIS
	 pkNjnWc5ddmdcMGb+EPlCCbK9vLFsk4KfmfHISJk/QZym001DB8aMsJ9c/rQ+nJLA1
	 vNleVhCKmNzpQSh2uFWWh2poy5amR5zR/n5mNa08=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB3620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbeLMHgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 02:36:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:35356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbeLMHgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 02:36:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8F8A2080F;
        Thu, 13 Dec 2018 07:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544686603;
        bh=X+S18UUtHo6wXC42+u8c4Vx/NfkM19yGBVk6povlXgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wCRXg0AGiqA6BcTlB5ing3v6uZFPYmGNyUIKnRHm8uAunzoGoqcBTfvNtgD26n6VG
         lIS5I0MJkAFqqXF9l7lPqdkhsBk0uVX7Gweh7H8pFc2G/H84ip1xtLiGvE7g97Hseg
         locvYS8DFTp9cIytsv0V4osM9bLFsz2vFGze5Kfw=
Date:   Thu, 13 Dec 2018 08:36:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Zeitlhofer <thomas.zeitlhofer@ze-it.at>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 4.19 014/110] usb: xhci: Prevent bus suspend if a port
 connect change or polling state is detected
Message-ID: <20181213073640.GA31371@kroah.com>
References: <20181129135921.231283053@linuxfoundation.org>
 <20181129135921.817957465@linuxfoundation.org>
 <20181212225334.GA2651@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212225334.GA2651@x1>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 11:53:34PM +0100, Thomas Zeitlhofer wrote:
> Hello,
> 
> On Thu, Nov 29, 2018 at 03:11:45PM +0100, Greg Kroah-Hartman wrote:
> > 4.19-stable review patch.  If anyone has any objections, please let me
> > know.
> > 
> > ------------------
> > 
> > From: Mathias Nyman <mathias.nyman@linux.intel.com>
> > 
> > commit 2f31a67f01a8beb22cae754c53522cb61a005750 upstream.
> [...]
> 
> on a current Thinkpad X1 Yoga, this breaks resume from hibernate such
> that opening the lid has (in the regular use case, see below) no effect
> any more: 
> 
> The system is configured to hibernate when the lid is closed. So, the
> expected behavior, which is restored by reverting this patch, is:
> 
> 	close lid => system hibernates
> 	open lid => system resumes
> 
> With this patch, the following two cases are observed:
> 
> 	1)
> 		close lid => system hibernates
> 		open lid => system stays off
> 		press power button => system boots and resumes
> 
> 	2)
> 		# systemctl hibernate => system hibernates
> 		close lid 
> 		open lid => system resumes
> 

So this is a problem in Linus's tree?  If so, let's work to get this
fixed there first.

If not, then we have other issues :)

thanks,

greg k-h
