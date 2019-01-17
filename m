Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF88AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29AB20856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=areca-com-tw.20150623.gappssmtp.com header.i=@areca-com-tw.20150623.gappssmtp.com header.b="R4H4eZK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbfAQIrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:47:12 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43212 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfAQIrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:47:11 -0500
Received: by mail-pl1-f196.google.com with SMTP id gn14so4413512plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 00:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=SMjyxVO96ufy+MDnu9cOhcSR3VU/U5kGWHzGfodeu7M=;
        b=R4H4eZK98fYUasU3oxkVFgteZ/L9jHSnuPImkviWe28rxGVAZZj29V7ycnXvvdmspf
         kVgkpN8NWXC4Ecz311OfFIHViXhXoQckxHXH8rmN/a3s+DESstHC4pbxKQBZzGRG1kZv
         fMjjeZ7VeikdSBdiNUL2OFlW2LL7wHfspdfRzAiuscOv4rsZKRlPnPllKvHOC2KoXh+H
         NpERjNwhlq8EoYLcH3liJUc2sHG39ddMOAoFS/HJkq24jlwwLo+a4OpCs0SbxmRsM3RX
         DW9NJT+yoHr4VDl59cVXj5tK1SwwiSoC7rrCENXc6fNZtieQgWFhLX3qUsnUTgEkGuJS
         M/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=SMjyxVO96ufy+MDnu9cOhcSR3VU/U5kGWHzGfodeu7M=;
        b=I8gRRf7eU3LL2gu0xtebdr/1WshvDDifHm1nFl/mHsEGjcuEGNH1gs7/+n2ve7egvu
         IkXtngQcehn898ZAqIjDiU8SN4drIzZdVnNP9+6BSH2tXpQsfYUMMW/BC+wWPaUBsl/Z
         TsZUnKE52W6m1ysQeCS4fdsA00AmmH9u2cOT16dPNDBOwE4VU4hEc1K0Sfl0vpGTUYJz
         pecRHVz85ql4oKLIEzfrNFeoi6f1z25lm9UJ1p2Ft7gIQ0CLRrCxLdvXXZHUEBE4NYIG
         ejkcOWJkKc3CeIJN8iQttFb9Y3+kipefdux6kfeydjFucbLiu7exHRYkANHIMwo2SmIK
         7A7g==
X-Gm-Message-State: AJcUukeNCBBphTHJmdqHPdqwyhG9NlHCHr+IornOk66Txev8vTfdQ0nO
        CTqha1n5Z6QyvmesjDuXrnZiHA==
X-Google-Smtp-Source: ALg8bN5l3u3X0B1TD+otqia586flOzL9O2D14+iKmpkaYe1AMUWaoj+AIZKCdweFAo1Ou4FC+uxW6w==
X-Received: by 2002:a17:902:6b83:: with SMTP id p3mr13933199plk.118.1547714830768;
        Thu, 17 Jan 2019 00:47:10 -0800 (PST)
Received: from [192.168.0.79] (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id d11sm1912038pgi.25.2019.01.17.00.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 00:47:09 -0800 (PST)
Subject: Re: [PATCH 2/3] scsi: arcmsr: Fix suspend/resume of
 ACB_ADAPTER_TYPE_B part 2
From:   Ching Huang <ching2048@areca.com.tw>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, colin.king@canonical.com
In-Reply-To: <20190117070227.GM4504@kadam>
References: <1547696703.4339.21.camel@Centos6.3-64>
         <20190117070227.GM4504@kadam>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 17 Jan 2019 16:47:07 +0800
Message-ID: <1547714827.5079.19.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-17 at 10:59 +0300, Dan Carpenter wrote:
> On Thu, Jan 17, 2019 at 11:45:03AM +0800, Ching Huang wrote:
> > >From Ching Huang <ching2048@areca.com.tw>
> > 
> > Fix suspend/resume of ACB_ADAPTER_TYPE_B part 2.
> > 
> 
> What does this look like from a user perspective?  Does it fail every
> time or does it only fail sometimes?
> 
> What's the bug exactly?
> 
> There is no Fixes tag...
From user's perspective, hibernate/resume are OK.
But following IO may cause 'isr get an illegal ccb command' in
log/messages sometime.
> 
> > Signed-off-by: Ching Huang <ching2048@areca.com.tw>
> > ---
> > 
> > diff --git a/drivers/scsi/arcmsr/arcmsr.h b/drivers/scsi/arcmsr/arcmsr.h
> > index a94c513..b98c632 100755
> > --- a/drivers/scsi/arcmsr/arcmsr.h
> > +++ b/drivers/scsi/arcmsr/arcmsr.h
> > @@ -508,9 +508,9 @@ struct MessageUnit_A
> >  struct MessageUnit_B
> >  {
> >  	uint32_t	post_qbuffer[ARCMSR_MAX_HBB_POSTQUEUE];
> > -	uint32_t	done_qbuffer[ARCMSR_MAX_HBB_POSTQUEUE];
> > +	volatile uint32_t	done_qbuffer[ARCMSR_MAX_HBB_POSTQUEUE];
> 
> There is a well known rule of thumb that when someone uses "volatile"
> in the kernel it means there is a locking problem...  Is this __iomem or
> something?
The done_qbuffer was a command completion queue, it was an area written
by IO processor and read by device driver. So, ...
> 
> >  	uint32_t	postq_index;
> > -	uint32_t	doneq_index;
> > +	volatile uint32_t	doneq_index;
> >  	uint32_t	__iomem *drv2iop_doorbell;
> >  	uint32_t	__iomem *drv2iop_doorbell_mask;
> >  	uint32_t	__iomem *iop2drv_doorbell;
> > diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
> > index 5736434..88053b1 100755
> > --- a/drivers/scsi/arcmsr/arcmsr_hba.c
> > +++ b/drivers/scsi/arcmsr/arcmsr_hba.c
> > @@ -1113,7 +1113,11 @@ static int arcmsr_resume(struct pci_dev *pdev)
> >  	switch (acb->adapter_type) {
> >  	case ACB_ADAPTER_TYPE_B: {
> >  		struct MessageUnit_B *reg = acb->pmuB;
> > -		reg->post_qbuffer[0] = 0;
> > +		uint32_t i;
> > +		for (i = 0; i < ARCMSR_MAX_HBB_POSTQUEUE; i++) {
> > +			reg->post_qbuffer[i] = 0;
> > +			reg->done_qbuffer[i] = 0;
> > +		}
> 
> Is this cause by patch 1 changing the zalloc to regular alloc??  If so
> then it should be folded into that patch instead of sent separately.
These fully clear delivery and completion queues are for fixing 
'isr get an illegal ccb command'. It is nothing related to Zalloc or alloc.
> 
> regards,
> dan carpenter
> 
> 


