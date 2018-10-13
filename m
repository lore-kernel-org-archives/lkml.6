Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23579C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE2B20859
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nMIHYrII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE2B20859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbeJMP2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 11:28:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54586 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeJMP2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 11:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=41rgIXCvoc+6p0nlIP9dNXjAIPdobmfRti0ssT5LNJs=; b=nMIHYrIIdXO+qRXomL+kRNYVL
        NRoZeP68gwP46KYAqfjgco+ZWrrHkMBsIlEvxqG862fACIrhlg79WtOtlBQl5waBvEjzjjXeASbCV
        83iXbVPepSIfeHWDtDOiWP0S0HeW1hiyuLXdnza6SCMYb/ELVXoT1ha1NsCSet323xKrvkqsQ4PcA
        KfKE4o+13xyADWGuwztp4LJFdHHf2LmnzbL1A78jeJY78Jp3k/mmtM88Io52qh5rFKl1nzVr5zB14
        yQbg2I49go1WTy07voSwrTpNvbkjBUrVfQ5iV8Ej7YCdYd2vHLkglXEgRpdF7O6/GIcuRA5wiF4gr
        Fnhr8RADQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBEia-00034w-Cz; Sat, 13 Oct 2018 07:52:12 +0000
Date:   Sat, 13 Oct 2018 00:52:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] esp_scsi: De-duplicate PIO routines
Message-ID: <20181013075212.GA23437@infradead.org>
References: <cover.1539391876.git.fthain@telegraphics.com.au>
 <09d3a141dc16af63921f5414263069e9b4f97222.1539391876.git.fthain@telegraphics.com.au>
 <20181013070508.GA15008@infradead.org>
 <alpine.LNX.2.21.1810131817540.375@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.21.1810131817540.375@nippy.intranet>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 06:22:18PM +1100, Finn Thain wrote:
> > > +	pr_err("FIFO is empty (sreg %02x)\n", esp_read8(ESP_STATUS));
> > 
> > This should probably use dev_err (at least with my series).
> > 
> 
> How about shost_printk()? That would be consistent with the rest of 
> esp_scsi.c. It also means my series need not depend on yours which would 
> complicate things.

Yes, that sounds even better.
