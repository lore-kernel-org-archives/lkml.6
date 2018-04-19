Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753922AbeDSX7T (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 19:59:19 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:52590 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753769AbeDSX7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 19:59:18 -0400
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Fri, 20 Apr 2018 08:59:15 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Kim Phillips <kim.phillips@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com
Subject: Re: [PATCH] perf tools: set kernel end address properly
Message-ID: <20180419235915.GA19067@sejong>
References: <20180416092345.GA23274@krava>
 <20180416135125.GA23802@kernel.org>
 <20180416110730.1dd12801e43be66ea5d0cc48@arm.com>
 <20180416165800.GD3202@kernel.org>
 <20180416122407.0d90863b69fed80166384850@arm.com>
 <20180416174811.1aca9106364effe435f363c8@arm.com>
 <20180417022726.GA31947@sejong>
 <20180418193759.b63912fe5e5b8a9023ec80a8@arm.com>
 <20180419023712.GB13370@sejong>
 <20180419182024.5d3bc71deef99551cc19fc55@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180419182024.5d3bc71deef99551cc19fc55@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 06:20:24PM -0500, Kim Phillips wrote:
> On Thu, 19 Apr 2018 11:37:12 +0900
> Namhyung Kim <namhyung@kernel.org> wrote:
> > I think the problem is perf assumes the kernel is the
> > first map in the kmaps.  When it calls maps_groups__insert() it uses
> > start address of 0 for the kernel map.  It seems always true for x86
> > but not for ARM64.
> > 
> > While it changes the start address in machine__set_kernel_mmap() it
> > doesn't change the order in the kmaps.
> > 
> > Could you please test below patch (on top) then?
> 
> Much better, thank you!  Together with the "module_emit_adrp_veneer not
> on kallsyms" mitigation diff, test 1 now passes on arm64 systems both
> with modules loaded, and without, and with and without RANDOMIZE_BASE.
> 
> I would send a patch (From: you), but I think you'd do a better job on
> writing the commit text, so would you care to, please?

Sure, what about this?

Thanks,
Namhyung


>From 1d9fa3b21bd7a964af43dcc9d486a09917d795e9 Mon Sep 17 00:00:00 2001
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 19 Feb 2018 19:05:45 +0900
Subject: [PATCH] perf tools: set kernel end address properly

The map_groups__fixup_end() was called to set end addresses of kernel
map and module maps.  But now machine__create_modules() is set the end
address of modules properly, the only remaining piece is the kernel map.
We can set it with adjacent module's address directly instead of calling
the map_groups__fixup_end().  If there's no module after the kernel map,
the end address will be ~0ULL.

Since it also changes the start address of the kernel map, it needs to
re-insert the map to the kmaps in order to keep a correct ordering.  Kim
reported that it caused problems on ARM64.

Reported-by: Kim Phillips <kim.phillips@arm.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/machine.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 2eca8478e24f..32d50492505d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1019,13 +1019,6 @@ int machine__load_vmlinux_path(struct machine *machine, enum map_type type)
 	return ret;
 }
 
-static void map_groups__fixup_end(struct map_groups *mg)
-{
-	int i;
-	for (i = 0; i < MAP__NR_TYPES; ++i)
-		__map_groups__fixup_end(mg, i);
-}
-
 static char *get_kernel_version(const char *root_dir)
 {
 	char version[PATH_MAX];
@@ -1233,6 +1226,7 @@ int machine__create_kernel_maps(struct machine *machine)
 {
 	struct dso *kernel = machine__get_kernel(machine);
 	const char *name = NULL;
+	struct map *map;
 	u64 addr = 0;
 	int ret;
 
@@ -1259,13 +1253,25 @@ int machine__create_kernel_maps(struct machine *machine)
 			machine__destroy_kernel_maps(machine);
 			return -1;
 		}
-		machine__set_kernel_mmap(machine, addr, 0);
+
+		/* we have a real start address now, so re-order the kmaps */
+		map = machine__kernel_map(machine);
+
+		map__get(map);
+		map_groups__remove(&machine->kmaps, map);
+
+		/* assume it's the last in the kmaps */
+		machine__set_kernel_mmap(machine, addr, ~0ULL);
+
+		map_groups__insert(&machine->kmaps, map);
+		map__put(map);
 	}
 
-	/*
-	 * Now that we have all the maps created, just set the ->end of them:
-	 */
-	map_groups__fixup_end(&machine->kmaps);
+	/* update end address of the kernel map using adjacent module address */
+	map = map__next(machine__kernel_map(machine));
+	if (map)
+		machine__set_kernel_mmap(machine, addr, map->start);
+
 	return 0;
 }
 
-- 
2.16.2
