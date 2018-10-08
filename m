Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E4DC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C67204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WExYn2Gv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C67204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731779AbeJICCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:02:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbeJICCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:02:03 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88688214C4;
        Mon,  8 Oct 2018 18:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024536;
        bh=mWjvlSQLvqOGjIot+fijj9vgQ8nmhDWLO9sGIWetaJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WExYn2Gv1JtbDL0Tpvmy+mShBgnJmX49Xi3RougYfnrCgl1/+iXbYqic4Flr8xAcg
         p9CNRaOcTZQOE7ley8YaKt3rX6HYFy9pWwbTZf/xoBNy0ITvjLTBXyapbblD+GGYZY
         U9tgq79X5lL0+qb4oXxIAuYL73r9zujIC3vXdsnQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Greentime Hu <greentime@andestech.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 073/168] nds32: linker script: GCOV kernel may refers data in __exit
Date:   Mon,  8 Oct 2018 20:30:53 +0200
Message-Id: <20181008175622.847413184@linuxfoundation.org>
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

From: Greentime Hu <greentime@andestech.com>

[ Upstream commit 3350139c0ff3c95724b784f7109987d533cb3ecd ]

This patch is used to fix nds32 allmodconfig/allyesconfig build error
because GCOV kernel embeds counters in the kernel for each line
and a part of that embed in __exit text. So we need to keep the
EXIT_TEXT and EXIT_DATA  if CONFIG_GCOV_KERNEL=y.

Link: https://lkml.org/lkml/2018/9/1/125
Signed-off-by: Greentime Hu <greentime@andestech.com>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/nds32/kernel/vmlinux.lds.S |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/arch/nds32/kernel/vmlinux.lds.S
+++ b/arch/nds32/kernel/vmlinux.lds.S
@@ -13,14 +13,26 @@ OUTPUT_ARCH(nds32)
 ENTRY(_stext_lma)
 jiffies = jiffies_64;
 
+#if defined(CONFIG_GCOV_KERNEL)
+#define NDS32_EXIT_KEEP(x)	x
+#else
+#define NDS32_EXIT_KEEP(x)
+#endif
+
 SECTIONS
 {
 	_stext_lma = TEXTADDR - LOAD_OFFSET;
 	. = TEXTADDR;
 	__init_begin = .;
 	HEAD_TEXT_SECTION
+	.exit.text : {
+		NDS32_EXIT_KEEP(EXIT_TEXT)
+	}
 	INIT_TEXT_SECTION(PAGE_SIZE)
 	INIT_DATA_SECTION(16)
+	.exit.data : {
+		NDS32_EXIT_KEEP(EXIT_DATA)
+	}
 	PERCPU_SECTION(L1_CACHE_BYTES)
 	__init_end = .;
 


