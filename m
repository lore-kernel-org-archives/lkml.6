Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA556C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B99C2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wyD+nQzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B99C2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732720AbeJICGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:06:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729253AbeJICGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:06:24 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 697012087D;
        Mon,  8 Oct 2018 18:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024797;
        bh=1a3KgHOl0HYUol6glTiiVGXwbqWadMqBp8Aj4EAsnsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wyD+nQzLJathr8f2pjjbtmbwuErnqHkIOFWxTqBNzqd5JrOBhgcW0/uHJSEpxThWi
         tqL4imXhZcwVhf0jyr3DdhNQ8VLekpdBiGNmrDxQq3CRUzjzlZfvlGVa0wG0Fxp6cZ
         CbJzDufZLawFlnqhk1vfEHQJCKK0UUgg34rc4o1M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <andrew.murray@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 139/168] asm-generic: io: Fix ioport_map() for !CONFIG_GENERIC_IOMAP && CONFIG_INDIRECT_PIO
Date:   Mon,  8 Oct 2018 20:31:59 +0200
Message-Id: <20181008175625.318696719@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Murray <andrew.murray@arm.com>

[ Upstream commit 500dd232449e7c07500e713dc6970aa713f8e4f1 ]

The !CONFIG_GENERIC_IOMAP version of ioport_map uses MMIO_UPPER_LIMIT to
prevent users from making I/O accesses outside the expected I/O range -
however it erroneously treats MMIO_UPPER_LIMIT as a mask which is
contradictory to its other users.

The introduction of CONFIG_INDIRECT_PIO, which subtracts an arbitrary
amount from IO_SPACE_LIMIT to form MMIO_UPPER_LIMIT, results in ioport_map
mangling the given port rather than capping it.

We address this by aligning more closely with the CONFIG_GENERIC_IOMAP
implementation of ioport_map by using the comparison operator and
returning NULL where the port exceeds MMIO_UPPER_LIMIT. Though note that
we preserve the existing behavior of masking with IO_SPACE_LIMIT such that
we don't break existing buggy drivers that somehow rely on this masking.

Fixes: 5745392e0c2b ("PCI: Apply the new generic I/O management on PCI IO hosts")
Reported-by: Will Deacon <will.deacon@arm.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/asm-generic/io.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1026,7 +1026,8 @@ static inline void __iomem *ioremap_wt(p
 #define ioport_map ioport_map
 static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
 {
-	return PCI_IOBASE + (port & MMIO_UPPER_LIMIT);
+	port &= IO_SPACE_LIMIT;
+	return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
 }
 #endif
 


