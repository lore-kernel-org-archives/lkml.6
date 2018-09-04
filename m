Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C93C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E3F20652
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WrWUWOMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E3F20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeIECD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 22:03:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33928 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbeIECD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 22:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UA3ALT7bsP3i2XR4sqn/YEQyA8tBsG62C1tUE+UnJ54=; b=WrWUWOMVB4Imbpvd8qyktjvvM
        FvF+dNG3e/StmZ/329WRJfkxA6prle4NZPcIP8P5/00N5ljAcCE4Srp8zLFkwzlHW0WM+aY0XGpH/
        1MxWxVqWwWiqOB979gGiWmG4VAWiuxvlgZNN2hHm/w1ne7OiOzQAx35Syq45qXW7VkyxXEPbn/cOa
        y5pM5wc9BaD380tdVJTq29LR950ae/JHqYCBTxQCBSP0i6maQSw3l8Vxr//VJNYTwN/Vw9FCX7MQI
        Wl+2Kbxjwcds9nqMAmWx48qgLGk9wydTZ4JBlQhfybEn8hpnWlclDABsBNPJEN+U2wl5GUrh5WVaa
        tdgFI5ZyA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxIzn-0002VQ-Id; Tue, 04 Sep 2018 21:36:23 +0000
Date:   Tue, 4 Sep 2018 14:36:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "damein@vger.kernel.org" <damein@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] RISC-V: Support cpu hotplug.
Message-ID: <20180904213623.GA2078@infradead.org>
References: <1535445370-19004-1-git-send-email-atish.patra@wdc.com>
 <1535445370-19004-4-git-send-email-atish.patra@wdc.com>
 <20180831061859.GC19292@infradead.org>
 <0d439b9d-b3d0-7d2c-117b-abb37adf769c@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d439b9d-b3d0-7d2c-117b-abb37adf769c@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 11:08:35AM -0700, Atish Patra wrote:
> 
> I have kept it here to match all other arch. Same goes for all hotplug
> functions in smpboot.c
> 
> I can move them to a separate file if you think that provides better code
> readability and structure.

I don't really have a strong opinion, but keeping this code together
and reducing the ifdef maze seems worthwile to me.
