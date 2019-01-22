Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8036AC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DF92084C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=areca-com-tw.20150623.gappssmtp.com header.i=@areca-com-tw.20150623.gappssmtp.com header.b="A3pRS5iC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfAVIDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 03:03:47 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38596 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfAVIDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 03:03:46 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so11071916plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 00:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=lbei1CJuI9LetJ1+gUu/nSqFU0EXpxJDd7FS+RXpRY0=;
        b=A3pRS5iCqTImQAj8ptBufClVgQ8f18TAMvyIQk0zW2U9JgU7ipnmKvvQoLU79743al
         3IEPJYbRyBzC4JCo+DLXy0BoxVR8nLBlBjuLKtjKkPt00nmvWLPLfTYvj9auq8soAbKB
         AXRQPQwk9c3nUmz7biVLFW8cJwA0TjvLgbDX9i+Se//GqGxp1i+wNuOebQ8yJDSRVA+Y
         R0ajWEUCoHSnCGSdWXM64marecPkgErn5xGk0UgX8A1lAxQ9Xelvgwh1FtriZsh9Y/aV
         IEXyw+YBhtPatszIjpOCOG7W/L/QOLPhS0gurILuYDLk/RRd0HAGdnXR88GvYo4mxTFd
         pw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=lbei1CJuI9LetJ1+gUu/nSqFU0EXpxJDd7FS+RXpRY0=;
        b=JmmxojhOo2uNv5Bpf9rZJYVWy5WBrC7+GfQt0BQH+rsttm2jO0EN4BAGi/so9Kb2Zf
         c6jv3yRKB1KZpwaqcxNyHuWr8UVSh9jmxjqtRo7+XtGYx9W2s1drIoeyem+CLv3Xr7dI
         lVbuqVFRxaLwzxqCug2wueMmp0dC8WzBaLparph6cduLE+mvY3dKq6WrmOCxCs4tU8+K
         M6NT9UCHAe9x/OHrm32BJSL5t/TJfEzEWREWx3X8CsJ9CRvMHjJDqcPBrsK9iwxvhdAH
         E9YeNMsmHU1Iqujy3uxs5xYm4wj4DFMUY6JWHGDuWjdFBI7EMjEjtPE7GVLEMehZYgCs
         XeEw==
X-Gm-Message-State: AJcUukdwRQRjMJv5kmTQn7UC+mVjKFPYFGx85QQkchzmAgMoBt+y02b0
        Y1pAwabp1nGXekON1GqeAZR43A==
X-Google-Smtp-Source: ALg8bN5TNvIVucmUPB17j0pvHn6vzZIS5LMQyoQ+FcsVAhMtFglIaX3vVvYNOjxO2oVUuhJUoa/RJA==
X-Received: by 2002:a17:902:7296:: with SMTP id d22mr33891055pll.265.1548144225285;
        Tue, 22 Jan 2019 00:03:45 -0800 (PST)
Received: from [192.168.0.97] (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id g15sm62096094pfj.131.2019.01.22.00.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 00:03:44 -0800 (PST)
Subject: Re: [PATCH 2/3] scsi: arcmsr: Fix suspend/resume of
 ACB_ADAPTER_TYPE_B part 2
From:   Ching Huang <ching2048@areca.com.tw>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, colin.king@canonical.com
In-Reply-To: <20190122074816.GC11828@kadam>
References: <1547696703.4339.21.camel@Centos6.3-64>
         <20190117070227.GM4504@kadam> <1547714827.5079.19.camel@Centos6.3-64>
         <20190117091646.GA11828@kadam> <1547718748.5079.34.camel@Centos6.3-64>
         <20190122074816.GC11828@kadam>
Content-Type: text/plain; charset="UTF-8"
Date:   Tue, 22 Jan 2019 08:03:42 +0800
Message-ID: <1548115422.4292.1.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-22 at 10:48 +0300, Dan Carpenter wrote:
> On Thu, Jan 17, 2019 at 05:52:28PM +0800, Ching Huang wrote:
> > On Thu, 2019-01-17 at 12:16 +0300, Dan Carpenter wrote:
> > > On Thu, Jan 17, 2019 at 04:47:07PM +0800, Ching Huang wrote:
> > > > On Thu, 2019-01-17 at 10:59 +0300, Dan Carpenter wrote:
> > > > > On Thu, Jan 17, 2019 at 11:45:03AM +0800, Ching Huang wrote:
> > > > > > >From Ching Huang <ching2048@areca.com.tw>
> > > > > > 
> > > > > > Fix suspend/resume of ACB_ADAPTER_TYPE_B part 2.
> > > > > > 
> > > > > 
> > > > > What does this look like from a user perspective?  Does it fail every
> > > > > time or does it only fail sometimes?
> > > > > 
> > > > > What's the bug exactly?
> > > > > 
> > > > > There is no Fixes tag...
> > > > >From user's perspective, hibernate/resume are OK.
> > > > But following IO may cause 'isr get an illegal ccb command' in
> > > > log/messages sometime.
> > > > > 
> > > 
> > > 
> > > You will need to resend with that information included in the commit
> > > message.
> > OK. I will resend this patch later.
> > > 
> > > > > > Signed-off-by: Ching Huang <ching2048@areca.com.tw>
> > > > > > ---
> > > > > > 
> > > > > > diff --git a/drivers/scsi/arcmsr/arcmsr.h b/drivers/scsi/arcmsr/arcmsr.h
> > > > > > index a94c513..b98c632 100755
> > > > > > --- a/drivers/scsi/arcmsr/arcmsr.h
> > > > > > +++ b/drivers/scsi/arcmsr/arcmsr.h
> > > > > > @@ -508,9 +508,9 @@ struct MessageUnit_A
> > > > > >  struct MessageUnit_B
> > > > > >  {
> > > > > >  	uint32_t	post_qbuffer[ARCMSR_MAX_HBB_POSTQUEUE];
> > > > > > -	uint32_t	done_qbuffer[ARCMSR_MAX_HBB_POSTQUEUE];
> > > > > > +	volatile uint32_t	done_qbuffer[ARCMSR_MAX_HBB_POSTQUEUE];
> > > > > 
> > > > > There is a well known rule of thumb that when someone uses "volatile"
> > > > > in the kernel it means there is a locking problem...  Is this __iomem or
> > > > > something?
> > > > The done_qbuffer was a command completion queue, it was an area written
> > > > by IO processor and read by device driver. So, ...
> > > 
> > > I'm not totally positive I understand this sentence.  I can find a bunch
> > > of places which read from this buffer, but I haven't immediately found
> > > which place writes to it.  Can you give me a function name that I should
> > > read?
> > Well, we allocate memory for struct MessageUnit_B in
> > arcmsr_alloc_ccb_pool(), by assign to acb->dma_coherent_handle2.
> > Then we tell IO controller its DMA address in arcmsr_iop_confirm().
> > When a command was completed, controller's firmware program will write a
> > completion ccb in done_qbuffer through DMA. So, you can't see any driver
> > funtion write to it.
> 
> DMA memory doesn't need to be marked as volatile.
I see. So I have removed the volatile in patch v2.
> 
> regards,
> dan carpenter
> 


