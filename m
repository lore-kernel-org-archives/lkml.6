Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A373C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02136223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 08:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fnircg+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02136223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732391AbeKNSZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 13:25:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49234 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732129AbeKNSZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 13:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KpJjv0Wi01S+sHeNOvB16YI4ImnEjEiDtzAmouanCt4=; b=Fnircg+yjGQAJ9C/I73HqgGpC
        J1b+VfVluffdUc1wX4VfssrS7JKzkKB8Jrp34c6km8VcL8e7t0xezFLrKAxn/TbMkH/Y+1Fb9CY/A
        s1amkaMmvMwp/XLPdsiZztHLDmlsz+0vzoY3Pj/hw764iDrW8nD+myL1GbwP6UmhEVu+FRGxVtA//
        jMNqPxkz6wg8N1RqdJSvpczKIE6N7cwz0k3u3UIqA/aYov7Dh02HY0Y/HLD95eFGm+gpy7I51lI81
        0o8yyrbgvzhUM3Lh/QVnFFg+UbNp7z8N513+n7KDztvUPSrc4x0YbUEEjT9wWARqC+Atkg9YmM6uN
        /S7uo3Yyw==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMqSC-0004Ya-B1; Wed, 14 Nov 2018 08:23:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: use generic DMA mapping code in powerpc V4
Date:   Wed, 14 Nov 2018 09:22:40 +0100
Message-Id: <20181114082314.8965-1-hch@lst.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series switches the powerpc port to use the generic swiotlb and
noncoherent dma ops, and to use more generic code for the coherent
direct mapping, as well as removing a lot of dead code.

As this series is very large and depends on the dma-mapping tree I've
also published a git tree:

    git://git.infradead.org/users/hch/misc.git powerpc-dma.4

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.4

Changes since v3:
 - rebase on the powerpc fixes tree
 - add a new patch to actually make the baseline amigaone config
   configure without warnings
 - only use ZONE_DMA for 64-bit embedded CPUs, on pseries an IOMMU is
   always present
 - fix compile in mem.c for one configuration
 - drop the full npu removal for now, will be resent separately
 - a few git bisection fixes

The changes since v1 are to big to list and v2 was not posted in public.

