Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7580AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F1120844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895051;
	bh=V4cF9xRQvtxI5sMUGfiiKcoBjZZqtpF8AsfX55LWtFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZI3uIM/lPPDciLYSohjq1KDHCqscAd/J6wv8ZENspkj6Q1/Wmlwdb0M9u5TAvcs3f
	 pDQbe6LQWqM6hPSxj7ZVwOhtcBFVArDlGM+jovtmpj/gQC0yhxfHHKDRm1XuZjxfp3
	 ucmkjuM/gaoMpJeucc8WniindCkd5yR2VAUdnXEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfBKOYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:24:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:57218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbfBKOYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:24:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAF3620838;
        Mon, 11 Feb 2019 14:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895044;
        bh=V4cF9xRQvtxI5sMUGfiiKcoBjZZqtpF8AsfX55LWtFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N5qeXzgwxK74xbvR1Bg5yL6T7HfRlvNpciSXvmJE5jVc/STu42bx3tN+uZDHMQegy
         AKQQTauPEBe+pFg6j0sVB4iSofcKCHgLx5qhlvR3YZQvcF72GscPdmKXy4cdAW3hIR
         RkVKn8PAy3Waz/eHpQzR8Z/cOOLrfVbYXJwTgjoQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Malaterre <malat@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 072/352] powerpc/32: Add .data..Lubsan_data*/.data..Lubsan_type* sections explicitly
Date:   Mon, 11 Feb 2019 15:14:59 +0100
Message-Id: <20190211141850.662693552@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit beba24ac59133cb36ecd03f9af9ccb11971ee20e ]

When both `CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y` and `CONFIG_UBSAN=y`
are set, link step typically produce numberous warnings about orphan
section:

  + powerpc-linux-gnu-ld -EB -m elf32ppc -Bstatic --orphan-handling=warn --build-id --gc-sections -X -o .tmp_vmlinux1 -T ./arch/powerpc/kernel/vmlinux.lds --who
  le-archive built-in.a --no-whole-archive --start-group lib/lib.a --end-group
  powerpc-linux-gnu-ld: warning: orphan section `.data..Lubsan_data393' from `init/main.o' being placed in section `.data..Lubsan_data393'.
  powerpc-linux-gnu-ld: warning: orphan section `.data..Lubsan_data394' from `init/main.o' being placed in section `.data..Lubsan_data394'.
  ...
  powerpc-linux-gnu-ld: warning: orphan section `.data..Lubsan_type11' from `init/main.o' being placed in section `.data..Lubsan_type11'.
  powerpc-linux-gnu-ld: warning: orphan section `.data..Lubsan_type12' from `init/main.o' being placed in section `.data..Lubsan_type12'.
  ...

This commit remove those warnings produced at W=1.

Link: https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg135407.html
Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/vmlinux.lds.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 434581bcd5b4..1148c3c60c3b 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -308,6 +308,10 @@ SECTIONS
 #ifdef CONFIG_PPC32
 	.data : AT(ADDR(.data) - LOAD_OFFSET) {
 		DATA_DATA
+#ifdef CONFIG_UBSAN
+		*(.data..Lubsan_data*)
+		*(.data..Lubsan_type*)
+#endif
 		*(.data.rel*)
 		*(SDATA_MAIN)
 		*(.sdata2)
-- 
2.19.1



