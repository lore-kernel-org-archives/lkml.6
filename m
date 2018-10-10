Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC02C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 271E52087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fjgk8FBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 271E52087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeJJUfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 16:35:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52506 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbeJJUfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 16:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1GX9ob6juG43I8l/oqCDbkxIrQD4/fh1p0IruqcsEtM=; b=Fjgk8FBlFDBCDkIaw9r5+Zpvo
        h7OAxx7L5SBiT2RzVv5xmABhr8L2Sb9t7bZBewKRtFvHh2PzsFAK6o50AC2kzV2Cb+tN4GNiIoxV2
        y+utMlXSGeyx5y5dHbLw7Tdc6/txyY5raPlU0nI406mQYQDRwD8Ejt4Yp9mGHERUrz77WVU9EUAd7
        fhWCm1JFZ19OqP+TAR0pa9GnBnjX8JTkMRQaF/ZGV0vthbnYDxnf0GxmsSQynYeyJ/uDxbcXmym4D
        Ds4AOub3M5aISJIniRSykE5DeNMfheylaihYvxSHpCLBjEvcwCC6ckI1IZLBPqnbfpR2vvTUdtlkm
        rrGjL6x8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAEIJ-0001wU-NE; Wed, 10 Oct 2018 13:12:55 +0000
Date:   Wed, 10 Oct 2018 06:12:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Schwab <schwab@suse.de>
Cc:     Atish Patra <atish.patra@wdc.com>, palmer@sifive.com,
        linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, thierry.reding@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, hch@infradead.org
Subject: Re: [RFC 4/4] gpio: sifive: Add GPIO driver for SiFive SoCs
Message-ID: <20181010131255.GB29142@infradead.org>
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
 <1539111085-25502-5-git-send-email-atish.patra@wdc.com>
 <mvmo9c22bx2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mvmo9c22bx2.fsf@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 03:01:29PM +0200, Andreas Schwab wrote:
> On Okt 09 2018, Atish Patra <atish.patra@wdc.com> wrote:
> 
> > +static void sifive_set_ie(struct sifive_gpio *chip, unsigned int offset)
> > +{
> > +	unsigned long flags;
> > +	unsigned int trigger;
> > +
> > +	raw_spin_lock_irqsave(&chip->lock, flags);
> > +	trigger = (chip->enabled & BIT(offset)) ? chip->trigger[offset] : 0;
> 
> This should use test_bit instead.

Given that this apparently needs the spinlock for atomciy with more than
just the bitmap test_bit would be rather pointless.
