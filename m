Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F633C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C885C2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C885C2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbeIYWCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:02:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60848 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728598AbeIYWCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:02:04 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 78DC81109240A;
        Tue, 25 Sep 2018 23:53:53 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Tue, 25 Sep 2018
 23:53:46 +0800
CC:     Linuxarm <linuxarm@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
From:   John Garry <john.garry@huawei.com>
Subject: perf segmentation fault from NULL dereference
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Message-ID: <712b7c31-f681-7737-71e7-c028b8d2bba5@huawei.com>
Date:   Tue, 25 Sep 2018 16:53:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am seeing this perf crash on my arm64-based system:

root@localhost:~# ./perf_debug_ record -e armv8_pmuv3_0/br_mis_pred/ sleep 1
perf: Segmentation fault
Obtained 9 stack frames.
./perf_debug_() [0x4c5ef8]
[0xffff82ba267c]
./perf_debug_() [0x4bc5a8]
./perf_debug_() [0x419550]
./perf_debug_() [0x41a928]
./perf_debug_() [0x472f58]
./perf_debug_() [0x473210]
./perf_debug_() [0x4070f4]
/lib/aarch64-linux-gnu/libc.so.6(__libc_start_main+0xe0) [0xffff8294c8a0]
Segmentation fault (core dumped)

I find 'cycles' event is fine.

I bisected the issue to here:
commit bfd8f72c2778f5bd63dc9eb6d23bd7a0d99cff6d (HEAD, refs/bisect/bad)
Author: Andi Kleen <ak@linux.intel.com>
Date:   Fri Nov 17 13:42:58 2017 -0800

     perf record: Synthesize unit/scale/... in event update

     Move the code to synthesize event updates for scale/unit/cpus to a
     common utility file, and use it both from stat and record.

     This allows to access scale and other extra qualifiers from perf 
script.

     Signed-off-by: Andi Kleen <ak@linux.intel.com>
     Acked-by: Jiri Olsa <jolsa@kernel.org>
     Link: 
http://lkml.kernel.org/r/20171117214300.32746-2-andi@firstfloor.org
     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

I am suspicious that this is a real issue, as this patch has been in 
mainline for some time...

This simple change fixes the issue me:
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 91e6d9c..f4fd826 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3576,7 +3576,7 @@ int perf_event__process_feature(struct perf_tool 
*tool,
      int max, err;
      u16 type;

-    if (!evsel->own_cpus)
+    if (!evsel->own_cpus || !(evsel->attr.read_format & 
PERF_FORMAT_ID)) // roundabout check for !evsel->id
          return 0;

      ev = cpu_map_data__alloc(evsel->own_cpus, &size, &type, &max);

It turns out that evsel->id is NULL on a call to 
perf_event__process_feature(), which upsets this code:

     ev->header.type = PERF_RECORD_EVENT_UPDATE;
     ev->header.size = (u16)size;
     ev->type = PERF_EVENT_UPDATE__CPUS;
     ev->id   = evsel->id[0];

Please me let me know if a valid issue so we can get a fix in.

Apologies for crying wolf if I'm off the mark.

Cheers,
John

