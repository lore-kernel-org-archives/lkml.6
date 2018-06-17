Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E02C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 11:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC201208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 11:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEKkxZyf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC201208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755205AbeFQLW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 07:22:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:53250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755106AbeFQLW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 07:22:26 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D82FD20693;
        Sun, 17 Jun 2018 11:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529234546;
        bh=vbVyhv3iFIDQ2PrmPIS+uKY5KPqoEEIrCIWf2knCXN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CEKkxZyfWwaLbVD0YqEHtfAvMKYIebCRW3W0cMBagxr+Cjri6OPnCGUFZ64Sx/mgb
         lDTCSnBqt3FvHRrpRqRPTashqpA20Jc9jtnf7DsfyIh4BnYqutzO57VDleqLqEg+6L
         Wg7AZNUzkjoDol0tGRjjDTiXTL34sqA3587tZxp8=
Date:   Sun, 17 Jun 2018 13:22:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     oleg.drokin@intel.com, andreas.dilger@intel.com,
        jsimmons@infradead.org, lustre-devel@lists.lustre.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: lustre: Use kmemdup() instead of kzalloc and
 memcpy
Message-ID: <20180617112203.GA9357@kroah.com>
References: <1529234215-4010-1-git-send-email-shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529234215-4010-1-git-send-email-shreeya.patel23498@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 04:46:55PM +0530, Shreeya Patel wrote:
> Replace calls to kzalloc or kmalloc followed by a memcpy with
> a direct call to kmemdup to shorten the code.
> 
> The Coccinelle semantic patch used to make this change is as follows:
> @@
> expression from,to,size,flag;
> statement S;
> @@
> 
> -  to = \(kmalloc\|kzalloc\)(size,flag);
> +  to = kmemdup(from,size,flag);
>    if (to==NULL || ...) S
> -  memcpy(to, from, size);
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> ---
>  drivers/staging/lustre/lnet/lnet/api-ni.c | 5 ++---

Always work off of the latest kernel tree.  Ideally linux-next or the
staging.git staging-next tree.  Worse case, Linus's tree.  But never off
of an old kernel tree, that will only cause you to duplicate work that
others have done :(

Please resync against 4.18-rc1 and see why I say this when trying to
apply your patch...

thanks,

greg k-h
