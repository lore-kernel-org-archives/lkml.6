Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076D1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A252146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 10:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A252146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbeKUVVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 16:21:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbeKUVVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 16:21:06 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 89DC9308626A;
        Wed, 21 Nov 2018 10:47:12 +0000 (UTC)
Received: from krava (unknown [10.43.17.92])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0BEF05C221;
        Wed, 21 Nov 2018 10:47:10 +0000 (UTC)
Date:   Wed, 21 Nov 2018 11:47:10 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "wangnan0@huawei.com" <wangnan0@huawei.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: perf tools: remove option --tail-synthesize ?
Message-ID: <20181121104710.GA9402@krava>
References: <89AC26A9-5A18-4608-8889-9C3C9C1C69D3@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89AC26A9-5A18-4608-8889-9C3C9C1C69D3@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 21 Nov 2018 10:47:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 07:45:28AM +0000, Song Liu wrote:
> Hi,
> 
> I found perf-record --tail-synthesize without --overwrite breaks symbols
> for perf-script, perf-report, etc. For example:
> 
> [root@]# ~/perf record -ag --tail-synthesize -- sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 1.129 MB perf.data (3531 samples) ]
> [root@]# ~/perf script | head
> swapper     0 [000] 1250675.051971:          1 cycles:ppp:
>         ffffffff81009e15 [unknown] ([unknown])
>         ffffffff81196b19 [unknown] ([unknown])
>         ffffffff81196579 [unknown] ([unknown])
>         ffffffff81110ca7 [unknown] ([unknown])
>         ffffffff81a01f4a [unknown] ([unknown])
>         ffffffff81a017bf [unknown] ([unknown])
>         ffffffff8180e17a [unknown] ([unknown])
> 
> perf-record with --overwrite does NOT have this issue.

actualy I think that now it works properly, if you turn on
task and mmap events, you'll see the samples get resolved
right after aux events are processed:

	[root@krava perf]# ./perf script --show-info --show-task-events --show-mmap-events
	...
	swapper     0 [007] 620566.187355:      64821 cycles:ppp:
		ffffffffab0b4d7c [unknown] ([unknown])
		ffffffffaba01b1f [unknown] ([unknown])
		ffffffffab75d567 [unknown] ([unknown])
		ffffffffab0e1f56 [unknown] ([unknown])
		ffffffffab0e216f [unknown] ([unknown])
		ffffffffab050dc7 [unknown] ([unknown])
		ffffffffab0000d5 [unknown] ([unknown])

	swapper     0 [000]     0.000000: PERF_RECORD_MMAP -1/0: [0xffffffffab000000(0x152c8000) @ 0xffffffffab000000]: x [kernel.kallsyms]_text
	swapper     0 [000]     0.000000: PERF_RECORD_MMAP -1/0: [0xffffffffc02c8000(0x4000) @ 0]: x /lib/modules/4.18.17-200.fc28.x86_64/kernel/drivers/thermal/int340x_thermal/int3403_thermal.ko.xz
	swapper     0 [000]     0.000000: PERF_RECORD_MMAP -1/0: [0xffffffffc02cd000(0x4000) @ 0]: x /lib/modules/4.18.17-200.fc28.x86_64/kernel/drivers/thermal/intel_pch_thermal.ko.xz
	...
	ext4-rsv-conver     0 [000]     0.000000: PERF_RECORD_COMM: ext4-rsv-conver:989/989
	perf 20063 [005] 620566.187438:    1056712 cycles:ppp:
		ffffffffab1f605d filemap_map_pages+0x9d (/usr/lib/debug/lib/modules/4.18.17-200.fc28.x86_64/vmlinux)
		ffffffffab23aaa8 __handle_mm_fault+0x1018 (/usr/lib/debug/lib/modules/4.18.17-200.fc28.x86_64/vmlinux)
		ffffffffab23ae7a handle_mm_fault+0xda (/usr/lib/debug/lib/modules/4.18.17-200.fc28.x86_64/vmlinux)
		ffffffffab06ac90 __do_page_fault+0x240 (/usr/lib/debug/lib/modules/4.18.17-200.fc28.x86_64/vmlinux)
		ffffffffab06af62 do_page_fault+0x32 (/usr/lib/debug/lib/modules/4.18.17-200.fc28.x86_64/vmlinux)
		ffffffffaba010ee page_fault+0x1e (/usr/lib/debug/lib/modules/4.18.17-200.fc28.x86_64/vmlinux)
	...

if you record with --overwrite and --tail-synthesize the aux events
will go to the top of the perf.data, so all's good

> 
> After digging into this, I found this issue is introduced by commit
> a73e24d240bc136619d382b1268f34d75c9d25ce.

right, we got rid of that, because it will store the 'current/live'
server mmaps for report/script, which is not what you want

> Reverting this commit does fix this issue. However, on a second thought,
> I feel it is probably better just drop --tail-synthesize, as it doesn't
> make much sense without --overwrite. All we need is to do tail_synthesize
> when --overwrite is set.
> 
> Thoughts?

maybe we should make --tail-synthesize non optionable for --overwrite,
and get rid of that option completely.. Wang, any idea?

but definitelly not allow that for non overwrite

thanks,
jirka
