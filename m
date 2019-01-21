Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5674CC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24CFF2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=scalemp.com header.i=@scalemp.com header.b="VolZ7hua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfAUMiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 07:38:07 -0500
Received: from www.scalemp.com ([169.44.78.149]:33743 "EHLO scalemp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728163AbfAUMiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 07:38:06 -0500
X-Greylist: delayed 3020 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Jan 2019 07:38:06 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=scalemp.com
        ; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2RuoEBro7lruH8W/TCfuvcf8xN9e9vNbT+hFmAOZrS4=; b=VolZ7hua96nkIn0Z4GVDi+AVXw
        EqTBNkZv2kzdagbkiPrZqiCZy6oAlZNrGQPMuJoT4CJDvHEHvuPFK3+8qqNR2Kr6JMWc/O+uMGJT9
        21d9Kj9oHoiURG7g/8ALLGhFH1inoD+XuxQV2Osh4sbPJTJB18WYTwofiqPM4g7swQwQ=;
Received: from bzq-80-45-146.red.bezeqint.net ([82.80.45.146]:23449 helo=eial.scalemp)
        by hosting.virtualsmp.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-SHA256:128)
        (Exim 4.91)
        (envelope-from <eial@scalemp.com>)
        id 1glY3N-000KGh-9W; Mon, 21 Jan 2019 06:47:45 -0500
From:   Eial Czerwacki <eial@scalemp.com>
To:     linux-kernel@vger.kernel.org
Cc:     Eial Czerwacki <eial@scalemp.com>,
        Shai Fultheim <shai@scalemp.com>, Oren Twaig <oren@scalemp.com>
Subject: [PATCH] percpu/module resevation: change resevation size iff X86_VSMP is set
Date:   Mon, 21 Jan 2019 13:47:31 +0200
Message-Id: <1548071251-1849-1-git-send-email-eial@scalemp.com>
X-Mailer: git-send-email 2.7.4
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hosting.virtualsmp.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalemp.com
X-Get-Message-Sender-Via: hosting.virtualsmp.com: authenticated_id: eial@scalemp.com
X-Authenticated-Sender: hosting.virtualsmp.com: eial@scalemp.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

as reported in bug #201339 (https://bugzilla.kernel.org/show_bug.cgi?id=201339)
by enabling X86_VSMP, INTERNODE_CACHE_BYTES's definition differs from the default one
causing the struct size to exceed the size ok 8KB.

in order to avoid such issue, increse PERCPU_MODULE_RESERVE to 64KB if CONFIG_X86_VSMP is set.

the value was caculated on linux 4.20.3, make allmodconfig all and the following oneliner:
for f in `find -name *.ko`; do echo $f; readelf -S $f  |grep perc; done |grep data..percpu -B 1 |grep ko |while read r; do echo -n "$r: "; objdump --syms --section=.data..percpu $r|grep data |sort -n  |awk '{c++; d=strtonum("0x" $1) + strtonum("0x" $5); if (m < d) m = d;} END {printf("%d vars-> last addr 0x%x ( %d )\n", c, m, m)}' ; done |column -t |sort -k 8 -n | awk '{print $8}'| paste -sd+ | bc

Signed-off-by: Eial Czerwacki <eial@scalemp.com>
Signed-off-by: Shai Fultheim <shai@scalemp.com>
Signed-off-by: Oren Twaig <oren@scalemp.com>
---
 include/linux/percpu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 70b7123..6b79693 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -14,7 +14,11 @@
 
 /* enough to cover all DEFINE_PER_CPUs in modules */
 #ifdef CONFIG_MODULES
+#ifdef X86_VSMP
+#define PERCPU_MODULE_RESERVE		(1 << 16)
+#else
 #define PERCPU_MODULE_RESERVE		(8 << 10)
+#endif
 #else
 #define PERCPU_MODULE_RESERVE		0
 #endif
-- 
2.7.4

