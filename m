Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE58C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 585A520644
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MlH7LSYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 585A520644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbeJIW5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:57:32 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56557 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeJIW5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:57:32 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181009154001euoutp026cbcd8a721634e9d7a84d5f6d0adc335~b_u7PT-eq0533705337euoutp02y
        for <linux-kernel@vger.kernel.org>; Tue,  9 Oct 2018 15:40:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181009154001euoutp026cbcd8a721634e9d7a84d5f6d0adc335~b_u7PT-eq0533705337euoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539099601;
        bh=j+1ktKK4v9x1DIoL+CN8o3jyYXrimvGfL9PqJuuprMc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=MlH7LSYBnD7CKwm0yGBPFcWlaQo7G3rt+/cEvltqqzp0aPisbItXmuz83Wn8NXpPz
         YVyulpvZVnDkrySZIkUiMCf869CEJQkTJKuy9+K8FVB7zpNUcPpotLR8pun3fBdiD8
         Oc2YjuukmmK+TgVHjli5584IXm7jrhNOmeHC23og=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181009154000eucas1p13370f6e0e27b4e8f74dc9d50f0a046d0~b_u6j71MV3131231312eucas1p1M;
        Tue,  9 Oct 2018 15:40:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4F.0B.04294.0DBCCBB5; Tue,  9
        Oct 2018 16:40:00 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181009153959eucas1p1ab3c10ba4868a4e97a1bff24d8f34c41~b_u5xrZ3z3130331303eucas1p1U;
        Tue,  9 Oct 2018 15:39:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181009153959eusmtrp20359a1e029e4e6558befd3a05b4fd641~b_u5gw9wq0203702037eusmtrp29;
        Tue,  9 Oct 2018 15:39:59 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-0c-5bbccbd09f3b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 72.34.04128.FCBCCBB5; Tue,  9
        Oct 2018 16:39:59 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181009153959eusmtip2920e6eefca083791ada6ea5746439023~b_u5PSQRx1402814028eusmtip2Q;
        Tue,  9 Oct 2018 15:39:59 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     l.luba@partner.samsung.com, b.zolnierkie@samsung.com,
        longman@redhat.com, mingo@redhat.com
Subject: [PATCH] lib/Kconfig.debug: add a comment to PROVE_LOCKING impact
Date:   Tue,  9 Oct 2018 17:39:50 +0200
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWy7djPc7oXTu+JNri0jM9i44z1rBa3GmQs
        Lu+aw2Zx+tgJFotLBxYwObB6HHy3h8nj/b6rbB59W1YxenzeJBfAEsVlk5Kak1mWWqRvl8CV
        cXjvHLaCTTwVf/b8YG5g7OfqYuTkkBAwkbj7+yVTFyMXh5DACkaJL79mMUI4XxglWp/dYoVw
        PjNKTFncyAjT8uPULxaIxHJGib9vb7LAtfxp+szWxcjBwSagJ7FjVSFIg4iAgsTm3mesIDaz
        QILEh/1tLCAlwgKeEv1PxEDCLAKqEld+/YaaLydx81wnM8hICYE9bBIvHq5iAknwCpRJ3Opq
        YIEocpHoeHqJCcIWlnh1fAs7hC0j8X/nfKh4scTZjlVsEHaNRPvJHVA11hKHj19kBbmBWUBT
        Yv0ufYiwo8SGP68YQcISAnwSN94KQlzMJzFp23RmiDCvREebEES1hsSWngtQi8Qklq+Zxg5R
        4iHx/ZU5SFhIIFZi3fF5jBMY5WYhrFrAyLiKUTy1tDg3PbXYKC+1XK84Mbe4NC9dLzk/dxMj
        MMpP/zv+ZQfjrj9JhxgFOBiVeHhn5O2OFmJNLCuuzD3EKMHBrCTCK7p9V7QQb0piZVVqUX58
        UWlOavEhRmkOFiVx3mXzNkYLCaQnlqRmp6YWpBbBZJk4OKUaGFn8/z0UuRG7mq8u9Izy0sfv
        i/4/L7hmvPuSfW1T6+tPNnWbX5Q+MNP8lh8XM69n4r3jO0TchNfPE53hLPlyW+2Osv5jy7uk
        eX8K3rV5t+SEVFz1f8Hb8aGvOov3XbOW9NhV2mzA79fNGHPzDofX44Kt6zneilz0NN96VvFX
        /+7bpyf+O+nHF6rEUpyRaKjFXFScCADjjwlp7gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsVy+t/xe7rnT++JNmjaI26xccZ6VotbDTIW
        l3fNYbM4fewEi8WlAwuYHFg9Dr7bw+Txft9VNo++LasYPT5vkgtgidKzKcovLUlVyMgvLrFV
        ija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLOLx3DlvBJp6KP3t+MDcw9nN1
        MXJySAiYSPw49YsFxBYSWMoosfGRHURcTGLSvu3sELawxJ9rXWxdjFxANZ8YJTadX8baxcjB
        wSagJ7FjVSFIjYiAgsTm3mesIDazQIrEtsN7GEFKhAU8JfqfiIGEWQRUJa78+s0IYvMChX9s
        mgE1Xk7i5rlO5gmMPAsYGVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIEhte2Yz+37GDsehd8
        iFGAg1GJh3dG3u5oIdbEsuLK3EOMEhzMSiK8ott3RQvxpiRWVqUW5ccXleakFh9iNAVaPpFZ
        SjQ5Hxj6eSXxhqaG5haWhubG5sZmFkrivOcNKqOEBNITS1KzU1MLUotg+pg4OKUaGOdlKR12
        Zj5q11Z8f8knuxfvS+7L861ddbzM+8dTZvd0C+v3d6ZMS0q0nGXLX6Qv6z3dmNUzZRr3C9WM
        ffo3g+T0Jsts3D3horzyzfdHe+3Dg6MfvoxlaOpUeb2qRXXHgUWivyb9PFiSYnLXyF3SSiV0
        885Nlj7vuZSeKzj6icrmLfKLzG84ocRSnJFoqMVcVJwIAJamGrRFAgAA
Message-Id: <20181009153959eucas1p1ab3c10ba4868a4e97a1bff24d8f34c41~b_u5xrZ3z3130331303eucas1p1U@eucas1p1.samsung.com>
X-CMS-MailID: 20181009153959eucas1p1ab3c10ba4868a4e97a1bff24d8f34c41
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181009153959eucas1p1ab3c10ba4868a4e97a1bff24d8f34c41
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181009153959eucas1p1ab3c10ba4868a4e97a1bff24d8f34c41
References: <CGME20181009153959eucas1p1ab3c10ba4868a4e97a1bff24d8f34c41@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add some comment related to performance impact,
which can be really big (x3 times slower context switch).

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 lib/Kconfig.debug | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 4966c4f..9e67a2a3 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1088,6 +1088,9 @@ config PROVE_LOCKING
 	 the proof of observed correctness is also maintained for an
 	 arbitrary combination of these separate locking variants.
 
+	 This feature enables LOCKDEP which can harm system performance
+	 even x3 times.
+
 	 For more details, see Documentation/locking/lockdep-design.txt.
 
 config LOCK_STAT
@@ -1112,6 +1115,10 @@ config LOCK_STAT
 	 CONFIG_LOCK_STAT defines "contended" and "acquired" lock events.
 	 (CONFIG_LOCKDEP defines "acquire" and "release" events.)
 
+	 This feature enables LOCKDEP which can harm system performance
+	 even x3 times.
+	 For more details, see Documentation/locking/lockdep-design.txt.
+
 config DEBUG_RT_MUTEXES
 	bool "RT Mutex debugging, deadlock detection"
 	depends on DEBUG_KERNEL && RT_MUTEXES
@@ -1175,6 +1182,10 @@ config DEBUG_LOCK_ALLOC
 	 spin_lock_init()/mutex_init()/etc., or whether there is any lock
 	 held during task exit.
 
+	 This feature enables LOCKDEP which can harm system performance
+	 even x3 times.
+	 For more details, see Documentation/locking/lockdep-design.txt.
+
 config LOCKDEP
 	bool
 	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
-- 
2.7.4

