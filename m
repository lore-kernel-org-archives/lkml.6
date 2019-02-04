Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4030CC282D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102E1214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oTTqzGUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfBDIOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:14:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50816 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfBDIOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cikljhOjspF4i3CFEUmyxOIcshbl32BwRgMwFL93Gqk=; b=oTTqzGUk4eFqDzd8OKICiE4mC
        T3sYTRxuaDLJGy8FdnEvxE1IRK3ssWFzjyEj9uBQUvOOxBEXFKtRR/vmLHn5nxlD9vQDtWE5cGce9
        5wYnDXjZGM7FnCi3n7nJQnRqhQjEVYNn2cIgcCS0lWKjBBf8FL5O9643fYjQ8kBR+pcIf8a6sTu4L
        Uz8qkcUpsR6h+RCIEA+JOlhWqOPLnvJnMuMuxdO4vUTKbDI4ZmL9PPOfrSYTtHcTOTwZzfVYVnp/c
        FQ3H3V1OO/AkTivPXqi+s2c2htI9AsCeiFe98+D1PEvGXJ5Mjv9vTGeYhTt5B3tM7EUZ4XfJO7KCM
        PRqNRf/ug==;
Received: from 089144212163.atnat0021.highway.a1.net ([89.144.212.163] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqZOZ-0008Om-Ii; Mon, 04 Feb 2019 08:14:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Paul Burton <paul.burton@mips.com>
Cc:     linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: add config symbols for arch_{setup,teardown}_dma_ops
Date:   Mon,  4 Feb 2019 09:14:18 +0100
Message-Id: <20190204081420.15083-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series adds kconfig symbols to indicate that the architecture
provides the arch_setup_dma_ops and arch_teardown_dma_ops hooks.

This avoids polluting dma-mapping.h which is included by just about
every driver with implementation details, and also removes some
clutter.
