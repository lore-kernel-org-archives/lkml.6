Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18245C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36822084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vjRv+KZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D36822084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeJEEkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:40:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbeJEEkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:40:42 -0400
Received: from localhost (unknown [198.217.64.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 064042084D;
        Thu,  4 Oct 2018 21:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538689524;
        bh=InnsUdNwXqlAxLJplMNU2wpUq83rkSw/pIrdNPKH5TI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=vjRv+KZPcs8g/HZVkhiNpiiUiOJmpAm1778Kc74mlwFuV+G/Hdntb6myBLuhcsAQN
         o55VuHGgXsnIn7kEpj7znDLTmfr+BVrKZ64xFFsVYFkk9BfCGD90ZnelnfG/08toBE
         E8lqyUfNDENVnz3Ii24wcyYDUPy8uxq42Ix0fi7Y=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 3/3] x86/vdso: Document vgtod_ts better
Date:   Thu,  4 Oct 2018 14:44:45 -0700
Message-Id: <f66f53d81150bbad47d7b282c9207a71a3ce1c16.1538689401.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1538689401.git.luto@kernel.org>
References: <cover.1538689401.git.luto@kernel.org>
In-Reply-To: <cover.1538689401.git.luto@kernel.org>
References: <cover.1538689401.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After reading do_hres() and do_course() and scratching my head a
bit, I figured out why the arithmetic is strange.  Document it.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/asm/vgtod.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index d17b092b9f1b..69d05c6d47f5 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -13,6 +13,15 @@ typedef u64 gtod_long_t;
 typedef unsigned long gtod_long_t;
 #endif
 
+/*
+ * There is one of these objects in the vvar page for each
+ * vDSO-accelerated clockid.  For high-resolution clocks, this encodes
+ * the time corresponding to vsyscall_gtod_data.cycle_last.  For coarse
+ * clocks, this encodes the actual time.
+ *
+ * To confuse the reader, for high-resolution clocks, nsec is left-shifted
+ * by vsyscall_gtod_data.shift.
+ */
 struct vgtod_ts {
 	u64		sec;
 	u64		nsec;
-- 
2.17.1

