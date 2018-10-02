Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6116C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B5620878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kdab.com header.i=@kdab.com header.b="okyBIlgt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B5620878
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kdab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbeJBOWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:22:00 -0400
Received: from mail.kdab.com ([176.9.126.58]:7480 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbeJBOWA (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:22:00 -0400
Authentication-Results: mail.kdab.com (amavisd-new); dkim=pass (1024-bit key)
 reason="pass (just generated,
 assumed good)" header.d=kdab.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdab.com; h=
 content-transfer-encoding:mime-version:message-id:date:date
 :subject:subject:from:from; s=dkim; t=1538466004; x=1539330005;
 bh=fSNSN0ifXjv0HqkVLvT/ifNvgE6kJOXSVwYBJ3eY+Zk=; b=okyBIlgt+1VN
 jrG+wBNLam4aL9ASD65k0OjjeldB/mSPLBlck4tpdO26s89wUdpJfHJTNgLBeFak
 i7XqR8b6Ns8JsXAO1QnEni9rNV1NsDLpa4vOxMM7NU8fI/WOLHT8IjF/z0kj8iMq
 uFZF551UrFjUzvTDAxyhvGjtVkwNpeA=
X-Virus-Scanned: amavisd-new at kdab.com
From:   Milian Wolff <milian.wolff@kdab.com>
To:     acme@kernel.org, jolsa@kernel.org,
        Jin Yao <yao.jin@linux.intel.com>
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH] perf record: use unmapped IP for inline callchain cursors
Date:   Tue,  2 Oct 2018 09:39:49 +0200
Message-Id: <20181002073949.3297-1-milian.wolff@kdab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only use the mapped IP to find inline frames, but keep
using the unmapped IP for the callchain cursor. This
ensures we properly show the unmapped IP when displaying
a frame we received via the dso__parse_addr_inlines API
for a module which does not contain sufficient debug symbols
to show the srcline.

Before:
$ perf record -e cycles:u --call-graph ls
$ perf script
...
ls 12853  2735.563911:      43354 cycles:u:
                   17878 __GI___tunables_init+0xffff01d1d63a0118 (/usr/li=
b/ld-2.28.so)
                   19ee9 _dl_sysdep_start+0xffff01d1d63a02e9 (/usr/lib/ld=
-2.28.so)
                    3087 _dl_start+0xffff01d1d63a0287 (/usr/lib/ld-2.28.s=
o)
                    2007 _start+0xffff01d1d63a0007 (/usr/lib/ld-2.28.so)

After:

$ perf script
...
ls 12853  2735.563911:      43354 cycles:u:
            7f1714e46878 __GI___tunables_init+0x118 (/usr/lib/ld-2.28.so)
            7f1714e48ee9 _dl_sysdep_start+0x2e9 (/usr/lib/ld-2.28.so)
            7f1714e32087 _dl_start+0x287 (/usr/lib/ld-2.28.so)
            7f1714e31007 _start+0x7 (/usr/lib/ld-2.28.so)

For frames with sufficient debug symbols, the behavior is
still sane and works as expected in my tests.

This patch series shows that we desperately need
an automated test for inline frame resolution. I'll try to
come up with something for the various regressions in the future.

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Reported-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
# Tested-by:
# Reviewed-by:
# Suggested-b:
Fixes: bfe16b0653 ("perf report: Don't crash on invalid inline debug info=
rmation")
---
 tools/perf/util/machine.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 73a651f10a0f..111ae858cbcb 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2286,7 +2286,8 @@ static int append_inlines(struct callchain_cursor *=
cursor,
 	if (!symbol_conf.inline_name || !map || !sym)
 		return ret;
=20
-	addr =3D map__rip_2objdump(map, ip);
+	addr =3D map__map_ip(map, ip);
+	addr =3D map__rip_2objdump(map, addr);
=20
 	inline_node =3D inlines__tree_find(&map->dso->inlined_nodes, addr);
 	if (!inline_node) {
@@ -2317,6 +2318,9 @@ static int unwind_entry(struct unwind_entry *entry,=
 void *arg)
 	if (symbol_conf.hide_unresolved && entry->sym =3D=3D NULL)
 		return 0;
=20
+	if (append_inlines(cursor, entry->map, entry->sym, entry->ip) =3D=3D 0)
+		return 0;
+
 	/*
 	 * Convert entry->ip from a virtual address to an offset in
 	 * its corresponding binary.
@@ -2324,9 +2328,6 @@ static int unwind_entry(struct unwind_entry *entry,=
 void *arg)
 	if (entry->map)
 		addr =3D map__map_ip(entry->map, entry->ip);
=20
-	if (append_inlines(cursor, entry->map, entry->sym, addr) =3D=3D 0)
-		return 0;
-
 	srcline =3D callchain_srcline(entry->map, entry->sym, addr);
 	return callchain_cursor_append(cursor, entry->ip,
 				       entry->map, entry->sym,
--=20
2.19.0
