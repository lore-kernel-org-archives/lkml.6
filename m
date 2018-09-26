Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9946C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988C2208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kdab.com header.i=@kdab.com header.b="nzEdnxYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988C2208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kdab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeIZULa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:11:30 -0400
Received: from mail.kdab.com ([176.9.126.58]:32799 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbeIZULa (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:11:30 -0400
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Sep 2018 16:11:28 EDT
Authentication-Results: mail.kdab.com (amavisd-new); dkim=pass (1024-bit key)
 reason="pass (just generated,
 assumed good)" header.d=kdab.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdab.com; h=
 content-transfer-encoding:mime-version:message-id:date:date
 :subject:subject:from:from; s=dkim; t=1537969941; x=1538833942;
 bh=i1Qtlkpx+6Z8imN6l1q1mTZGSu/ZqG0b/MQLOJ4rM04=; b=nzEdnxYjmPvW
 FPi1r69URrjkopwUBmABC1tL6gm+5R8VccgWWfp5dgaI5jTWG5R+UXM7lTDQZMid
 cnTKLL1ysrZH0kkhBXfDQUqToODfRn+g6O2dNmQH6IxgS7SbrhkfFEWkS5IfTso+
 gskzoVwXoz0C4sbH0JtjiGmR1w1gTqA=
X-Virus-Scanned: amavisd-new at kdab.com
From:   Milian Wolff <milian.wolff@kdab.com>
To:     acme@kernel.org, jolsa@kernel.org, yao.jin@linux.intel.com,
        namhyung@kernel.org
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Milian Wolff <milian.wolff@kdab.com>,
        Sandipan Das <sandipan@linux.ibm.com>
Subject: [PATCH 1/3] perf report: don't try to map ip to invalid map
Date:   Wed, 26 Sep 2018 15:52:05 +0200
Message-Id: <20180926135207.30263-1-milian.wolff@kdab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a crash when the report encounters an address that
could not be associated with an mmaped region:

#0  0x00005555557bdc4a in callchain_srcline (ip=3D<error reading variable=
: Cannot access memory at address 0x38>, sym=3D0x0, map=3D0x0) at util/ma=
chine.c:2329
#1  unwind_entry (entry=3Dentry@entry=3D0x7fffffff9180, arg=3Darg@entry=3D=
0x7ffff5642498) at util/machine.c:2329
#2  0x00005555558370af in entry (arg=3D0x7ffff5642498, cb=3D0x5555557bdb5=
0 <unwind_entry>, thread=3D<optimized out>, ip=3D18446744073709551615) at=
 util/unwind-libunwind-local.c:586
#3  get_entries (ui=3Dui@entry=3D0x7fffffff9620, cb=3D0x5555557bdb50 <unw=
ind_entry>, arg=3D0x7ffff5642498, max_stack=3D<optimized out>) at util/un=
wind-libunwind-local.c:703
#4  0x0000555555837192 in _unwind__get_entries (cb=3D<optimized out>, arg=
=3D<optimized out>, thread=3D<optimized out>, data=3D<optimized out>, max=
_stack=3D<optimized out>) at util/unwind-libunwind-local.c:725
#5  0x00005555557c310f in thread__resolve_callchain_unwind (max_stack=3D1=
27, sample=3D0x7fffffff9830, evsel=3D0x555555c7b3b0, cursor=3D0x7ffff5642=
498, thread=3D0x555555c7f6f0) at util/machine.c:2351
#6  thread__resolve_callchain (thread=3D0x555555c7f6f0, cursor=3D0x7ffff5=
642498, evsel=3D0x555555c7b3b0, sample=3D0x7fffffff9830, parent=3D0x7ffff=
fff97b8, root_al=3D0x7fffffff9750, max_stack=3D127) at util/machine.c:237=
8
#7  0x00005555557ba4ee in sample__resolve_callchain (sample=3D<optimized =
out>, cursor=3D<optimized out>, parent=3Dparent@entry=3D0x7fffffff97b8, e=
vsel=3D<optimized out>, al=3Dal@entry=3D0x7fffffff9750,
    max_stack=3D<optimized out>) at util/callchain.c:1085

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Cc: Sandipan Das <sandipan@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 tools/perf/util/machine.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index c4acd2001db0..0cb4f8bf3ca7 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2312,7 +2312,7 @@ static int unwind_entry(struct unwind_entry *entry,=
 void *arg)
 {
 	struct callchain_cursor *cursor =3D arg;
 	const char *srcline =3D NULL;
-	u64 addr;
+	u64 addr =3D entry->ip;
=20
 	if (symbol_conf.hide_unresolved && entry->sym =3D=3D NULL)
 		return 0;
@@ -2324,7 +2324,8 @@ static int unwind_entry(struct unwind_entry *entry,=
 void *arg)
 	 * Convert entry->ip from a virtual address to an offset in
 	 * its corresponding binary.
 	 */
-	addr =3D map__map_ip(entry->map, entry->ip);
+	if (entry->map)
+		addr =3D map__map_ip(entry->map, entry->ip);
=20
 	srcline =3D callchain_srcline(entry->map, entry->sym, addr);
 	return callchain_cursor_append(cursor, entry->ip,
--=20
2.19.0
