Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbeENE2N (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 00:28:13 -0400
Received: from gandharva.secretlabs.de ([5.9.72.18]:37240 "EHLO
        gandharva.secretlabs.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeENE2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 00:28:08 -0400
From: Holger Freyther <automatic+kernel@freyther.de>
To: linux-kernel@vger.kernel.org
Cc: Holger Hans Peter Freyther <holgar+kernel@google.com>
Subject: [RFC 6/6] perf probe: Make it possible to add a C++ uprobe
Date: Mon, 14 May 2018 12:19:40 +0800
Message-Id: <20180514041940.96126-7-automatic+kernel@freyther.de>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180514041940.96126-1-automatic+kernel@freyther.de>
References: <20180514041940.96126-1-automatic+kernel@freyther.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Holger Hans Peter Freyther <holgar+kernel@google.com>

If the linkage name looks like a common C++ ABI name use it instead of
the original function name. This makes adding a uprobe for a C++ symbol
possible.

./perf probe -x ./cxx-example  "std::vector<int, std::allocator<int> >::at"
Added new event:
  probe_foo:_ZNSt6vectorIiSaIiEE2atEm (on _ZN... in /cxx-example)

You can now use it in all perf tools, such as:

	perf record -e probe_foo:_ZNSt6vectorIiSaIiEE2atEm -aR sleep 1

Signed-off-by: Holger Hans Peter Freyther <holgar+kernel@google.com>
---
 tools/perf/util/probe-finder.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 4ba4b18..4cfa3de 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1317,6 +1317,7 @@ static int add_probe_trace_event(Dwarf_Die *sc_die, struct probe_finder *pf)
 	struct perf_probe_point *pp = &pf->pev->point;
 	struct probe_trace_event *tev;
 	struct perf_probe_arg *args = NULL;
+	const char *linkage_name;
 	int ret, i;
 
 	/* Check number of tevs */
@@ -1333,6 +1334,16 @@ static int add_probe_trace_event(Dwarf_Die *sc_die, struct probe_finder *pf)
 	if (ret < 0)
 		goto end;
 
+	/*
+	 * Adding a C++ name like std::vector<int, std::allocator<int> >::at
+	 * will fail. Check if we want to use the linkage name instead.
+	 */
+	linkage_name = die_get_linkage_name(&pf->sp_die);
+	if (linkage_name && strncmp(linkage_name, "_Z", 2) == 0) {
+		free(pp->function);
+		pp->function = strdup(linkage_name);
+	}
+
 	tev->point.realname = strdup(dwarf_diename(sc_die));
 	if (!tev->point.realname) {
 		ret = -ENOMEM;
-- 
2.7.4
