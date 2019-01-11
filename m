Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF171C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A093E2184A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217569;
	bh=TER1GEcS4QCncjinHm00ubyUoS5AeUcMr/ZWmO8Cr5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GRQUfDQD1mqd5i0tSdFwHYnwBIlI4lghz6hJUz8iBPZQUTJAi+9B+dWtDwq3v83Eu
	 boo6XQas6VfeQSJfvwaYIN6x2vNmSpFnrC32lFJn4zaPZ96ROWG7+vbaK/1D+VcOog
	 lHF8zJE97aGmu/+u2RAIdJuJeWzAlJORogTk4y9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391043AbfAKOj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:39:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:60218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391029AbfAKOj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:39:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 176AC21841;
        Fri, 11 Jan 2019 14:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217565;
        bh=TER1GEcS4QCncjinHm00ubyUoS5AeUcMr/ZWmO8Cr5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hz86qjCF6QqIZFKKP4vzDK7PeiVhQ+EE1zaAfGXZCMogsfk2LXZGlQsnf/6tvSr/5
         tTNh6l3mVpYUvyCKHJ1SBP6QkbbFhINSKPr35FyTIDVutgCui0qwRR6LV668f/J7jG
         W4aK+NYafKShMGXKb3QPQNEe2YdBm5h0JCJKlv0E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 069/148] virtio: fix test build after uio.h change
Date:   Fri, 11 Jan 2019 15:14:07 +0100
Message-Id: <20190111131116.999447654@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c5c08bed843c2b2c048c16d1296d7631d7c1620e ]

Fixes: d38499530e5 ("fs: decouple READ and WRITE from the block layer ops")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/virtio/linux/kernel.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index fb22bccfbc8a..7ef45a4a3cba 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -23,6 +23,10 @@
 #define PAGE_MASK (~(PAGE_SIZE-1))
 #define PAGE_ALIGN(x) ((x + PAGE_SIZE - 1) & PAGE_MASK)
 
+/* generic data direction definitions */
+#define READ                    0
+#define WRITE                   1
+
 typedef unsigned long long phys_addr_t;
 typedef unsigned long long dma_addr_t;
 typedef size_t __kernel_size_t;
-- 
2.19.1



