Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CFBC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA5C208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kdab.com header.i=@kdab.com header.b="W44/EnlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA5C208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kdab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeIZULa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:11:30 -0400
Received: from mail.kdab.com ([176.9.126.58]:32805 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbeIZULa (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:11:30 -0400
Authentication-Results: mail.kdab.com (amavisd-new); dkim=pass (1024-bit key)
 reason="pass (just generated,
 assumed good)" header.d=kdab.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdab.com; h=
 content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:date:subject:subject:from:from; s=dkim; t=
 1537969946; x=1538833947; bh=CKU3sroLg/xVbno9whZqQARK4Pt5xiViU1j
 OO1D2dq4=; b=W44/EnlOTy5Re+7Q/GhAoDX81Tf8w898dwqRfmG9/m4K6Z8iA9V
 IgKzf4rX3iOKp9MnrXDEhHl6+rznTKqwdC2TTPbKiNVRNevNTVqz3cHBiXhuWrUn
 f+E1yctw1y1Te9FYkZJeGZkdHFr856Ui5yKV1CT4JCyn8qiHBzclYa8U=
X-Virus-Scanned: amavisd-new at kdab.com
From:   Milian Wolff <milian.wolff@kdab.com>
To:     acme@kernel.org, jolsa@kernel.org, yao.jin@linux.intel.com,
        namhyung@kernel.org
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Milian Wolff <milian.wolff@kdab.com>,
        Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH 2/3] perf report: use the offset address to find inline frames
Date:   Wed, 26 Sep 2018 15:52:06 +0200
Message-Id: <20180926135207.30263-2-milian.wolff@kdab.com>
In-Reply-To: <20180926135207.30263-1-milian.wolff@kdab.com>
References: <20180926135207.30263-1-milian.wolff@kdab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To correctly find inlined frames, we have to use the file offset
instead of the virtual memory address. This was already fixed for
displaying srcline information while displaying in commit
2a9d5050dc84fa20 ("perf script: Show correct offsets for DWARF-based
unwinding"). We just need to use the same corrected address also when
trying to find inline frames.

This is another follow-up to commit 19610184693c ("perf script: Show
virtual addresses instead of offsets").

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Cc: Sandipan Das <sandipan@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 tools/perf/util/machine.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 0cb4f8bf3ca7..73a651f10a0f 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2317,9 +2317,6 @@ static int unwind_entry(struct unwind_entry *entry,=
 void *arg)
 	if (symbol_conf.hide_unresolved && entry->sym =3D=3D NULL)
 		return 0;
=20
-	if (append_inlines(cursor, entry->map, entry->sym, entry->ip) =3D=3D 0)
-		return 0;
-
 	/*
 	 * Convert entry->ip from a virtual address to an offset in
 	 * its corresponding binary.
@@ -2327,6 +2324,9 @@ static int unwind_entry(struct unwind_entry *entry,=
 void *arg)
 	if (entry->map)
 		addr =3D map__map_ip(entry->map, entry->ip);
=20
+	if (append_inlines(cursor, entry->map, entry->sym, addr) =3D=3D 0)
+		return 0;
+
 	srcline =3D callchain_srcline(entry->map, entry->sym, addr);
 	return callchain_cursor_append(cursor, entry->ip,
 				       entry->map, entry->sym,
--=20
2.19.0
