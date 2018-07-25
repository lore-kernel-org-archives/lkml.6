Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74FAC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E3E20671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QuKEToOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E3E20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbeGYKry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:47:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42590 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbeGYKrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zhstDJvlMR88y/n8HDcByIWkATqEMA8LcEPCSwC7STA=; b=QuKEToOslYFimeb5qIWIKr5Kk
        o9ARM6mGjTAw6hoPAKo+bd7DGJs1oRTu5XRlxGGFii58x+EP2sJjckzCikMgA1hH6SxXf0NDFtzG/
        8Ox022zSYvFJq7dZ+6pw7qFkP0du7Ck3FAkeWa6J9vVtqPVb/8y2ZuLw11YJL7aefsKxPrxyp+272
        SPdd1BdYHNKK6LqX7sFFQzR5r0d7eiGeL+yShBSIPc/APqqQP2bTIAaBY/UHuz5DKzCY+VfkxZ/g2
        rwlj2l34j6QqwIvjbgCTs5KGfNUj5PZ0HoBZ9p0W8AjE4G3ENDlovtj4e6PS3JLbmixPXOd3dG+SB
        PO2Dh/0ng==;
Received: from [91.112.108.175] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fiGE1-0005EC-EN; Wed, 25 Jul 2018 09:36:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     tglx@linutronix.de, palmer@sifive.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
Subject: RISC-V irqchip drivers
Date:   Wed, 25 Jul 2018 11:36:43 +0200
Message-Id: <20180725093649.32332-1-hch@lst.de>
X-Mailer: git-send-email 2.18.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RISC-V ISA mandantes the presence of a simple, per-hart (hardware
thread) interrupt controller availiable to supervisor mode.  In addition
the RISC-V specification contains the definition of a programmable
interrupt controller that is present on all current RISC-V cores (at
least as far as a I know).

This series adds both of them.  For the per-hart controller this series
tries to address all comments vs the last posting from Palmr in June,
and for the PLIC it has a lot of cleanups which I think should address
all outstanding comments, but it has been a while since it was last
posted.

Without these irqchip drivers the RISC-V port in mainline is rather
useless as it can't boot on any SOC or emulator.  With it it still is
almost as useless as a clocksource driver is still missing, but at least
we're only a patch or two away from a booting system, and the
clocksource  driver will need the per-hart interrupt driver to work as
well.

Palmer: I assume you are ok with me pushing this forward.  If not I'll
happily drop this series.

A git tree with the patches in this series, the missing clocksource
driver a few pending patches to allow booting a RISC-V kernel in qemu
is available here:

    git://git.infradead.org/users/hch/riscv.git riscv-linux-4.18

Gitweb:

    http://git.infradead.org/users/hch/riscv.git/shortlog/refs/heads/riscv-linux-4.18
