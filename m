Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46774C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F088120844
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MEc2zvz8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F088120844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbeGZPyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:54:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57260 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbeGZPyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ocXrQec0oLhDiwtCXIb0Qh8KvflUULsfS4Yd+58q6mM=; b=MEc2zvz84QeRpTgqPHZBz20cv
        gTrXXmFgUbgwN+j4wISYylhC3D7PsU7h+zxWoh4Ozw2kxh5xnxH4GvuMt7gr4XxIrnQCO+DknBFcD
        o1CUSc62zWkHHOckQyxMLXYi2qPScwZd1Y1JsKlFU6ZILmobm/caki+Sc6r2kIlynV1eOKzB4AZk4
        jHm0ulq6XdBqNtcUs7iGSJx5rGWTBwL1sIM/Gv9+ZaJDn3D+dtLlOssxtGW/QG7zWoPV9lNnoYJNH
        6YZtXJX71XpgKAkRX3Za0XvWD/DMvFWNcO0djURKEID4zAvwjh5JRQcn2W65+d+eY4O+hBGKIh/J3
        6PcQ00YrQ==;
Received: from 213-225-8-157.nat.highway.a1.net ([213.225.8.157] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fihOS-0005fm-Dg; Thu, 26 Jul 2018 14:37:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     tglx@linutronix.de, palmer@sifive.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     anup@brainfault.org, atish.patra@wdc.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
Subject: RFC: simplified RISC-V interrupt and clocksource handling
Date:   Thu, 26 Jul 2018 16:37:14 +0200
Message-Id: <20180726143723.16585-1-hch@lst.de>
X-Mailer: git-send-email 2.18.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series tries adds support for interrupt handling and timers
for the RISC-V architecture.

The basic per-hart interrupt handling implemented by the scause
and sie CSRs is extremely simple and implemented directly in
arch/riscv/kernel/irq.c.  In addition there is a irqchip driver
for the PLIC external interrupt controller, which is called through
the set_handle_irq API, and a clocksource driver that gets its
timer interrupt directly from the low-level interrupt handling.

Compared to previous iterations this version does not try to use an
irqchip driver for the low-level interrupt handling.  This saves
a couple indirect calls and an additional read of the scause CSR
in the hot path, makes the code much simpler and last but not least
avoid the dependency on a device tree for a mandatory architectural
feature.

A git tree is available here (contains a few more patches before
the ones in this series)

    git://git.infradead.org/users/hch/riscv.git riscv-irq-simple

Gitweb:

    http://git.infradead.org/users/hch/riscv.git/shortlog/refs/heads/riscv-irq-simple
