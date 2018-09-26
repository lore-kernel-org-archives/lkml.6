Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10159C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF5D208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NnGtBmWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF5D208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbeIZSZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:25:15 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48467 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbeIZSZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:25:02 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180926121218euoutp01519c4378f42b5fce0f3a31d104c2d470~X8g3MbA082985529855euoutp01a;
        Wed, 26 Sep 2018 12:12:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180926121218euoutp01519c4378f42b5fce0f3a31d104c2d470~X8g3MbA082985529855euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537963938;
        bh=dopKgwRjnoxoneEsFhRql8G8EkPvDHZLfdkh/oKWUks=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=NnGtBmWnLJLyTThB23YQ0r3OOMmKcU0+BrJ5oXrKc+fut1bTDpJ7gUANrm6Iq7mc6
         yOY6cMJtCuL2UokHhJZSkSktFiptiKBO/gxi5F96xAWSWWJ2vVAwgc891tmpszMd6v
         yeY/0zOtpgNn1+uqJduV/plUteVCqqKccdt532qw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180926121218eucas1p1e24ac10b14c1cdfad7129373599071c3~X8g2t0WN30975409754eucas1p1T;
        Wed, 26 Sep 2018 12:12:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 33.3E.04806.1A77BAB5; Wed, 26
        Sep 2018 13:12:17 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180926121217eucas1p198d96ed637d1aa8a98c1b90466dde745~X8g18MWcq1639616396eucas1p1q;
        Wed, 26 Sep 2018 12:12:17 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-99-5bab77a1f5c9
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EB.0B.04128.1A77BAB5; Wed, 26
        Sep 2018 13:12:17 +0100 (BST)
Received: from AMDC3482.DIGITAL.local ([106.120.51.30]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PFN0028YWK7Q120@eusync4.samsung.com>;
        Wed, 26 Sep 2018 13:12:17 +0100 (BST)
From:   Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux@armlinux.org.uk, oleg@redhat.com, catalin.marinas@arm.com,
        will.deacon@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, k.lewandowsk@samsung.com,
        m.slodczyk2@partner.samsung.com
Subject: [PATCH v2 6/7] arm64: change arm_probe_decode_insn() function name
Date:   Wed, 26 Sep 2018 14:12:04 +0200
Message-id: <1537963925-25313-7-git-send-email-m.slodczyk2@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1537963925-25313-1-git-send-email-m.slodczyk2@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTYRjG+85tx9XiMBU/LRTWBZI0o9sxKwK7HCpI+0dodll5UnGbsuNm
        BpHKknmppUtUrKUma22KOOeF8tZItzKvK0uhIpLCyFaa2cUs59H/fg/v87zv9728JCqexILI
        ZGU6q1LK5BJCiDX3/OoPq8qwSiN6B3fT+W9aCVpnK8fphrJ6nPaYCgHd3fcXobOnbqO07f0I
        Trsf3CJoR0k7oNv0VoKue/xaQA93VSJ0jqkJo5s6rwLaea0LoSe+ubD9FFNrrAWMe2QIZRrN
        oYzNkkcwxiexTGPNFebRlzaE8XS8IJjrdgtgpm3BMcKTwj0JrDxZw6q27DsrTJotseJpZv+L
        LS8LiSzQLs4HPiSktkNz428sHwhJMWUG0D1gRHgxDaDJWIsvu6qelQO+YAKw3vNBwIt/AGpH
        ioHXRVC7YEu3FvOyH3UIvsrWLbZCKTcC3a6CBUGSvtRR2HMnwevBqA3Q2du+mBVRx+HU7E2C
        nxYMR/vzUC/7UDHQUWpGvX0g5SGgXVeO8KYDMKt5HOXZF35y2gU8r4VuQwHGcwZ86BoV8GEt
        gCXZXUvhKDhnKVqchlKrYXFzKep9HKREUJe7tBgGTs5U4Pwv7wLotI3iN0BgJVhhAQGsmlMk
        stw2JZsRzskUnFqZGH4+VWEDC0fQO++caQUdc+ccgCKBZJWI3GuRinGZhstUOAAkUYmfaKXG
        KhWLEmSZl1hV6hmVWs5yDrCGxCQBotWhF6RiKlGWzqawbBqrWq4ipE9QFjg4SAh0ZP/9yQFD
        tis+zhg2vt58+DL6vfNrU1Fgf8jYyFS0Jla/w+1K/pg2euyevuy0iXmekrNz+F3uvBxP32Su
        HDqRbnAof278Ex3p/7Qv70j1uomhqiT9j5AuV8Pn1Pg2bVRIXfXYZrt00NcelWKIOxVpr6ip
        xLRvTb4R+WoJxiXJtoaiKk72H3DG39kAAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsVy+t/xa7oLy1dHG9xdJmvRdW8Hm0XHppms
        FhtnrGe1eL+sh9Hi6Nm/TBaNn+YyW2x6fI3V4vKuOWwWh6buZbTY07+azWLtkbvsFpcOLGCy
        aFq2lcVi6/5WRovjvQeYLF5+PMHiIOCxZt4aRo/L1y4ye2xeoeWxaVUnm8e8k4Eem5fUexx8
        t4fJ4/2+q2wefVtWMXp83iQXwBXFZZOSmpNZllqkb5fAlfF96mrWghWiFduv97A1MO4V6mLk
        5JAQMJFYeGYmYxcjF4eQwBJGic/LZrBDOI1MEteO7WcHqWITMJfYfrSFBcQWEXCTuNHYwQRS
        xCxwmUni84K9rF2MHBzCAt4Sx+angNSwCKhKHD+9lxHE5hXwl/j0fQobxDY5iZvnOplBbE6B
        AIlD01eA2UJANVdOzmSZwMizgJFhFaNIamlxbnpusZFecWJucWleul5yfu4mRmAIbzv2c8sO
        xq53wYcYBTgYlXh4OWxXRQuxJpYVV+YeYpTgYFYS4eUuWx0txJuSWFmVWpQfX1Sak1p8iFGa
        g0VJnPe8QWWUkEB6YklqdmpqQWoRTJaJg1OqgdHq749Fbd1vtGfvd1j9TD69wV/zs+7Kr1G8
        XGf/Tin6ejMuJ0xx8uGXCSaOSRu+cSzseiu+PPt01bVlRoZZVzIezbM42n/grbjv8V0hVoIH
        bZj9JGUmOrzWVjjYcsn8SGbg5Pc6l4tq8lYrcjn3MeaGaMwrnjOb/1hfwFulZ/K5eywr9D70
        rVdiKc5INNRiLipOBAAS6N7lXQIAAA==
X-CMS-MailID: 20180926121217eucas1p198d96ed637d1aa8a98c1b90466dde745
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180926121217eucas1p198d96ed637d1aa8a98c1b90466dde745
References: <1537963925-25313-1-git-send-email-m.slodczyk2@partner.samsung.com>
        <CGME20180926121217eucas1p198d96ed637d1aa8a98c1b90466dde745@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM probe decoding function has similar name in arm32 -
arm_probes_decode_insn(), and arm64 - arm_probe_decode_insn(). Change arm64
probes decoding function name from arm_probe_decode_insn() to
arm64_probes_decode_insn() to minimize the risk of confusion.

Signed-off-by: Maciej Slodczyk <m.slodczyk2@partner.samsung.com>
---
 arch/arm64/kernel/probes/decode-insn.c | 4 ++--
 arch/arm64/kernel/probes/decode-insn.h | 2 +-
 arch/arm64/kernel/probes/uprobes.c     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/probes/decode-insn.c b/arch/arm64/kernel/probes/decode-insn.c
index a0597a2..37be1a9 100644
--- a/arch/arm64/kernel/probes/decode-insn.c
+++ b/arch/arm64/kernel/probes/decode-insn.c
@@ -78,7 +78,7 @@ static bool __kprobes aarch64_insn_is_steppable(u32 insn)
  *   INSN_GOOD_NO_SLOT If instruction is supported but doesn't use its slot.
  */
 enum probes_insn __kprobes
-arm_probe_decode_insn(probes_opcode_t insn, struct arch_probes_insn *api)
+arm64_probes_decode_insn(probes_opcode_t insn, struct arch_probes_insn *api)
 {
 	/*
 	 * Instructions reading or modifying the PC won't work from the XOL
@@ -162,7 +162,7 @@ arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_insn *asi)
 		else
 			scan_end = addr - MAX_ATOMIC_CONTEXT_SIZE;
 	}
-	decoded = arm_probe_decode_insn(insn, &asi->api);
+	decoded = arm64_probes_decode_insn(insn, &asi->api);
 
 	if (decoded != INSN_REJECTED && scan_end)
 		if (is_probed_address_atomic(addr - 1, scan_end))
diff --git a/arch/arm64/kernel/probes/decode-insn.h b/arch/arm64/kernel/probes/decode-insn.h
index 93e021f..e6c7b9e 100644
--- a/arch/arm64/kernel/probes/decode-insn.h
+++ b/arch/arm64/kernel/probes/decode-insn.h
@@ -32,7 +32,7 @@ enum probes_insn __kprobes
 arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_insn *asi);
 #endif
 enum probes_insn __kprobes
-arm_probe_decode_insn(probes_opcode_t insn, struct arch_probes_insn *asi);
+arm64_probes_decode_insn(probes_opcode_t insn, struct arch_probes_insn *asi);
 
 extern const union decode_action uprobes_probes_actions[];
 #endif /* _ARM_KERNEL_KPROBES_ARM64_H */
diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
index f99b50b..e7b8912 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -47,7 +47,7 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 
 	insn = *(probes_opcode_t *)(&auprobe->insn[0]);
 
-	switch (arm_probe_decode_insn(insn, &auprobe->api)) {
+	switch (arm64_probes_decode_insn(insn, &auprobe->api)) {
 	case INSN_REJECTED:
 		return -EINVAL;
 
-- 
2.7.4

