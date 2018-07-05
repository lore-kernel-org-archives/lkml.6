Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7CDC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA55240D3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA55240D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754155AbeGEQdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:33:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43352 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753804AbeGEQdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:33:41 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 022C5CB2;
        Thu,  5 Jul 2018 16:33:40 +0000 (UTC)
Date:   Thu, 5 Jul 2018 18:33:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     xiubli@redhat.com
Cc:     linux-kernel@vger.kernel.org, pkalever@redhat.com,
        pkarampu@redhat.com, atumball@redhat.com, sabose@redhat.com,
        mchristi@redhat.com
Subject: Re: [PATCH 1/2] uio: change to use the mutex lock instead of the
 spin lock
Message-ID: <20180705163338.GA14941@kroah.com>
References: <1530808048-9494-1-git-send-email-xiubli@redhat.com>
 <1530808048-9494-2-git-send-email-xiubli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530808048-9494-2-git-send-email-xiubli@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 12:27:27PM -0400, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> We are hitting a regression with the following commit:
> 
> commit a93e7b331568227500186a465fee3c2cb5dffd1f
> Author: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
> Date:   Mon May 14 13:32:23 2018 +1200
> 
>     uio: Prevent device destruction while fds are open
> 
> The problem is the addition of spin_lock_irqsave in uio_write. This
> leads to hitting  uio_write -> copy_from_user -> _copy_from_user ->
> might_fault and the logs filling up with sleeping warnings.
> 
> I also noticed some uio drivers allocate memory, sleep, grab mutexes
> from callouts like open() and release and uio is now doing
> spin_lock_irqsave while calling them.
> 
> Reported-by: Mike Christie <mchristi@redhat.com>
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  drivers/uio/uio.c          | 33 ++++++++++++++-------------------
>  include/linux/uio_driver.h |  2 +-
>  2 files changed, 15 insertions(+), 20 deletions(-)

Any specific reason you did not also cc: the author of the above patch
to review this one?

Please fix up and resend.

greg k-h
