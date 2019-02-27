Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D511C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05569213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 12:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbfB0Ml1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 07:41:27 -0500
Received: from mga18.intel.com ([134.134.136.126]:64132 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbfB0Ml1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 07:41:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 04:41:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,419,1544515200"; 
   d="scan'208";a="127633306"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.56]) ([10.237.72.56])
  by fmsmga008.fm.intel.com with ESMTP; 27 Feb 2019 04:41:23 -0800
Subject: Re: [bug report][stable] perf probe: failed to add events
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        luto@kernel.org, Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Xu Yu <xuyu@linux.alibaba.com>, peterz@infradead.org,
        mingo@redhat.com
References: <1a4240a8-288b-45d0-073d-d5cb8f0c63eb@linux.alibaba.com>
 <20190226090505.GA24409@kroah.com>
 <c7ccd9cb-3a66-98a9-faa1-7ee5ed20ff88@linux.alibaba.com>
 <20190226130802.GA10343@kroah.com> <20190226142009.GC26786@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3b233ff2-e87a-1c61-d516-6c4cdecb4f01@intel.com>
Date:   Wed, 27 Feb 2019 14:39:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190226142009.GC26786@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/19 4:20 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Feb 26, 2019 at 02:08:02PM +0100, Greg KH escreveu:
>> On Tue, Feb 26, 2019 at 08:32:34PM +0800, Joseph Qi wrote:
>>>
>>>
>>> On 19/2/26 17:05, Greg KH wrote:
>>>> On Tue, Feb 26, 2019 at 03:31:14PM +0800, Joseph Qi wrote:
>>>>> Hi,
>>>>>
>>>>> I'm using kernel v4.19.24 and have found that there is an issue when
>>>>> using perf probe to define a new dynamic tracepoint.
>>>>>
>>>>> $ perf probe -a handle_mm_fault
>>>>> Failed to write event: Numerical result out of range
>>>>>   Error: Failed to add events.
>>>>>
>>>>> I've also tried kernel v4.20, and it can pass.
>>>>
>>>> Ick, has this ever worked on the 4.19 stable tree?  If so, any chance
>>>> you can run 'git bisect' to find the offending commit?
>>>>
>>> >From my test, v4.19.0 also has this issue.
>>> Bisect locates that it is introduced by commit bf904d2762ee
>>> "x86/pti/64: Remove the SYSCALL64 entry trampoline".
>>
>> But that commit was in 4.20, not 4.19.  So if this never worked, it's
>> not a regression?
>>
>> confused,
> 
> Adrian, Ideas?
> 

Seems to be fixed by this:

From: Adrian Hunter <adrian.hunter@intel.com>
Date: Wed, 27 Feb 2019 05:35:25 +0200
Subject: [PATCH] perf probe: Fix getting the kernel map

Since commit 4d99e4136580 ("perf machine: Workaround missing maps for x86
PTI entry trampolines"), perf tools has been creating more than one kernel
map, however 'perf probe' assumed there could be only one.

Fix by using machine__kernel_map() to get the main kernel map.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: 4d99e4136580 ("perf machine: Workaround missing maps for x86 PTI entry trampolines")
---
 tools/perf/util/probe-event.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index e86f8be89157..6cd96f9b346d 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -157,8 +157,10 @@ static struct map *kernel_get_module_map(const char *module)
 	if (module && strchr(module, '/'))
 		return dso__new_map(module);
 
-	if (!module)
-		module = "kernel";
+	if (!module) {
+		pos = machine__kernel_map(host_machine);
+		return map__get(pos);
+	}
 
 	for (pos = maps__first(maps); pos; pos = map__next(pos)) {
 		/* short_name is "[module]" */
-- 
2.19.1
