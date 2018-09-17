Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8207DECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC54214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GiE5emYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC54214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbeIQTun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 15:50:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58546 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbeIQTun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 15:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6tBWE85R2ILzm13UaxFxXmD91sWMmvqz6SQDGAZV1jk=; b=GiE5emYloAm3kF9Eb8fOuDGSA
        NfHKmAROjGgkQewjZN+yj7snpz0ONMr/KZHm58PHaYOjbidheolumKpHGEY/L9aZqsstc+ip2AAkq
        +ZNmf1k6MpmHCSqU2RgZ4HWFqHF6rOxnJivqKyOyGv/iVAoxFbWCKvevjEnJ3+ViQTXSF+kHXiP7V
        +fuc6m0q1ZvfTCV9PhoDfzLdlN63hH7pP0zs4UBNO/rZWuxOtd/CtSAtU5NyJC43w10+y09u2H2xo
        OvF5tyFbuXx6Aed9H8wLBD0XV5n7cEIs/sflJTi7KSo6aHJISQbq5b0pBuDJ9BivS7vP7EinaHIAt
        EcroDhz8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g1uQe-0005uA-LF; Mon, 17 Sep 2018 14:23:08 +0000
Date:   Mon, 17 Sep 2018 07:23:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        hch@infradead.org, mark.rutland@arm.com, robh@kernel.org,
        Damien.LeMoal@wdc.com, marc.zyngier@arm.com, anup@brainfault.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [RFC 2/3] RISC-V:Support per-hart timebase-frequency
Message-ID: <20180917142308.GB15588@infradead.org>
References: <1536962096-233842-1-git-send-email-atish.patra@wdc.com>
 <1536962096-233842-3-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536962096-233842-3-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 02:54:55PM -0700, Atish Patra wrote:
> Follow the updated DT specs and read the timebase-frequency
> from the boot cpu. Keep the old DT reading as well for backward
> compatibility. This patch is rework of old patch from Palmer.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

This setup looks a bit odd because it keeps blindly overwriting
riscv_timebase for every cpu found.  Shouldn't we at least check that
they all match for now as the rest of the port assumes that?
