Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4169BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFE42077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A2qwhAHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFFE42077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeIECD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 22:03:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34086 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbeIECD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 22:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xNyK8kgZjsF4LDwa4XGMoZ980Hde8h6PyNptYxL8Zsk=; b=A2qwhAHdnwZzY1aPUkd7dNpYW
        +dCMZ+uZ5ZKDGIt/GKPMAbUlwLr+sVpQGazDmkYlhGC8WU9IztkYMosqxQ8aXu0JR812h/rEPdaQm
        VAu834ufd6N1SoaW1JZoP+3YbhNBvvjpcAjiwjdsNtlp0DU6yR4xkOmzR3SQPn7m3qbdIGlr3IPMH
        BX+PyOgD1pGdHzHkK+sM5iejheXO3RyiEBitrhZJqL51TJSrX4Pms3ksG7sbO/IpvgC0Hhst0oGEQ
        hcfI1tEnl//Axb0rVGsNhqUvWl9wU5hJFcNnHc3f4yuXPLAYUKbZjZei+Nhs0MgnR4gcdZI+yzwQx
        7K1nXR0HQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxJ0I-0002aZ-Dr; Tue, 04 Sep 2018 21:36:54 +0000
Date:   Tue, 4 Sep 2018 14:36:54 -0700
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
Subject: Re: [PATCH v2 2/3] RISC-V: Use Linux logical cpu number instead of
 hartid
Message-ID: <20180904213654.GB2078@infradead.org>
References: <1535445370-19004-1-git-send-email-atish.patra@wdc.com>
 <1535445370-19004-3-git-send-email-atish.patra@wdc.com>
 <20180831061104.GB19292@infradead.org>
 <ec0819d5-9dc6-6b25-47a9-cd9d9e5099a8@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec0819d5-9dc6-6b25-47a9-cd9d9e5099a8@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 01:35:10PM -0700, Atish Patra wrote:
> sure. How about this ?

That would work, but why not just keep calling sbi_remove_sfence_vma
directly from flush_tlb_all?
