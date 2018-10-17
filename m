Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C8AECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA882151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sQxDaA2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA882151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeJQQD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:03:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33022 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbeJQQD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jzYlRwHwg9bxqQsoY9qpvMVgXBxodh6duTLqLab96Ds=; b=sQxDaA2svfX10ouTelbgFrRl2
        cXVGLhY6cOkG/VGGDlA+WGpmINdE8IZ83q/h6iuipDA9NzcsetSa2tV8MYaDJhLQ1huR13pSXm6NK
        Daq8fpMACfdM/+JuEo16tPQjOsCSwjpH/FnufbK6KCksNEceZPwD58huOMnNDcHUsxVwttuoteCZ1
        YVk2HpLnKe5PQAjWx59yypKoYA5jSxjRIrsxXrqdvDjXDIWgUYe/mOvB56TCbr+4ttuQJWngkjd+h
        V7yPV/ggU7YZr7kldUnx3yRGwhMLv/qVHsK8rFCdubOI//Jg8cWEdAGzoNgiNqaktY0vu9I2uz8rZ
        77E1Gcrfg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCgsw-0006SG-DH; Wed, 17 Oct 2018 08:08:54 +0000
Date:   Wed, 17 Oct 2018 01:08:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-scsi@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] esp_scsi: De-duplicate PIO routines
Message-ID: <20181017080854.GB24540@infradead.org>
References: <cover.1539497520.git.fthain@telegraphics.com.au>
 <d5fe773ea8c922631836dad2ef2dbb952672c7c7.1539497520.git.fthain@telegraphics.com.au>
 <35ac9f31-7068-ab93-4629-363ee0bb4c70@suse.de>
 <alpine.LNX.2.21.1810151717520.10@nippy.intranet>
 <2b48c925-73f0-0ca0-2f3c-3c35d90010ba@suse.de>
 <alpine.LNX.2.21.1810161014080.10@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.21.1810161014080.10@nippy.intranet>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 10:52:26AM +1100, Finn Thain wrote:
> True enough. We agree that this #ifdef is undesirable. And yet when I 
> tried it, I found an unexpected readability benefit to your suggestion:
> 
> #ifdef CONFIG_SCSI_ESP_PIO
>         u8 __iomem              *fifo_reg;
>         int                     send_cmd_error;
>         u32                     send_cmd_residual;
> #endif
> 
> This grouping does help convey the purpose of these struct members, even 
> though the #ifdef is meant for the compiler not for the human reader.
> 
> So maybe it makes sense to group these definitions (they are all the same 
> size):
> 
>         /* These are used by esp_scsi_send_pio_cmd() */
>         u8 __iomem              *fifo_reg;
>         int                     send_cmd_error;
>         u32                     send_cmd_residual;

I like the grouping, and in fact the ifdef sounds fine to me as well.

> Do static checkers really complain about this? I think the validity of an 
> extern can't be known until the final linkage is done.

None that I know of does, and as said before this patterns is very
common all over the kernel.
