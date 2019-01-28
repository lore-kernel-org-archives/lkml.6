Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1052C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D2C2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691357;
	bh=NV9YqKHG/dhtUcjgFT1Az3syI48Ld/NntZKhT0dyb3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zOvzMfzjWBhFawrJwKZznZTrmoqf93JaVd02Fa15Nid/ugOF7bxWRlV+bGnYHtUIs
	 Z8buwiHT27zVvhHZKH4ENlQFP7pf1J37pY8qW4R/h/WrtMXXMUFY4WykTbsLcMPXcm
	 DZkfR1NOwOBh5JgZtatJl0blAqfGmNR0MF1+Pfqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731253AbfA1QCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:02:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:47880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731242AbfA1QCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:02:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 646172175B;
        Mon, 28 Jan 2019 16:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691352;
        bh=NV9YqKHG/dhtUcjgFT1Az3syI48Ld/NntZKhT0dyb3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UF8UKb3f8ZdwG3SZsOQXj3qSNwQYkn032Rv93o6a7cXMidCKTcDmTK5HxYTAVg7H9
         0E6klOumkBpk6bIe38IqiRpv9nx0AdlID8HUu2cXGOjnCYELtUe8iWKfL47qDmtFUV
         VnZRo690OJDXV2E277qn23beLvZveZ/UEhi93jc0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mathieu Malaterre <malat@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.19 065/258] powerpc/32: Add .data..Lubsan_data*/.data..Lubsan_type* sections explicitly
Date:   Mon, 28 Jan 2019 10:56:11 -0500
Message-Id: <20190128155924.51521-65-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Malaterre <malat@debian.org>

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
index 07ae018e550e..53016c753f3c 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -296,6 +296,10 @@ SECTIONS
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

