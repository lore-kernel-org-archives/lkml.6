Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEA5ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7535C2151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r2ZexZJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7535C2151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbeJQQD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:03:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33126 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbeJQQD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rJrI2j69eN6/HmnToQAGKaT7C7ls83agIo2TyKHiiEw=; b=r2ZexZJjtOvcljsd0NkNx0nbS
        VZMqRnPwuxAvEbdUDJVuCQAk1RoESz99qxp7igVIGKJ+pUC0vmH7TnJjVkDr3Ml8BoHicpZnTjmFq
        ji4ym+uPzCl6XwsEqD/4woRSvG+xXaOJk5MfnMoIfVhMlQtaAzbQAIhUyY8W1JVPjtnA0JJ9+tYFK
        hdeZ9aG0JunwyP8jsilbQTS3FQOG95PgEj2Cxy+0/yEKAQlpMtOtdcSZMmbUN5MwhK6sA9hNUlZTD
        2/lKkOY8LuYKQKAeAVB3T4GXe3eDHcWHegfR5X8482jg7EpL/2+s80qlEWSIi1ccjJC831qhzNMxr
        E99RfBVOg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCgtQ-0006UA-4K; Wed, 17 Oct 2018 08:09:24 +0000
Date:   Wed, 17 Oct 2018 01:09:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-scsi@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] esp_scsi: De-duplicate PIO routines
Message-ID: <20181017080923.GC24540@infradead.org>
References: <cover.1539497520.git.fthain@telegraphics.com.au>
 <d5fe773ea8c922631836dad2ef2dbb952672c7c7.1539497520.git.fthain@telegraphics.com.au>
 <35ac9f31-7068-ab93-4629-363ee0bb4c70@suse.de>
 <alpine.LNX.2.21.1810151717520.10@nippy.intranet>
 <2b48c925-73f0-0ca0-2f3c-3c35d90010ba@suse.de>
 <alpine.LNX.2.21.1810161611150.130@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.21.1810161611150.130@nippy.intranet>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 04:39:07PM +1100, Finn Thain wrote:
> 
> Perhaps I've misunderstood your concern here. Is it a problem that 
> esp_scsi.ko may or may not export the function, depending on .config?
> 
> For example, if esp_scsi.ko came from a build with CONFIG_SUN3X_ESP=y && 
> !CONFIG_SCSI_ZORRO_ESP && !CONFIG_SCSI_MAC_ESP, then it would export no 
> esp_send_pio_cmd() symbol.
> 
> A dummy function (mentioned above) might then avoid a link error from 
> "modprobe zorro_esp" or "modprobe mac_esp" in this scenario. (The modules 
> would load but fail to work properly.)
> 
> This seems a bit too contrived so I'll post v3 for you to consider.

Please leave the possibly unused exports as-is.
