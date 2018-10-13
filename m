Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19063C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 11:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F2320895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 11:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F2320895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbeJMSqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 14:46:22 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59096 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbeJMSqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 14:46:21 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9DB9dat097725;
        Sat, 13 Oct 2018 20:09:39 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp);
 Sat, 13 Oct 2018 20:09:39 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w9DB9X0O097652
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 13 Oct 2018 20:09:38 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH] memcg, oom: throttle dump_header for memcg ooms
 without eligible tasks
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        rientjes@google.com, yang.s@alibaba-inc.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <000000000000dc48d40577d4a587@google.com>
 <20181010151135.25766-1-mhocko@kernel.org>
 <20181012112008.GA27955@cmpxchg.org> <20181012120858.GX5873@dhcp22.suse.cz>
 <9174f087-3f6f-f0ed-6009-509d4436a47a@i-love.sakura.ne.jp>
 <20181012124137.GA29330@cmpxchg.org>
 <0417c888-d74e-b6ae-a8f0-234cbde03d38@i-love.sakura.ne.jp>
Message-ID: <bb2074c0-34fe-8c2c-1c7d-db71338f1e7f@i-love.sakura.ne.jp>
Date:   Sat, 13 Oct 2018 20:09:30 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0417c888-d74e-b6ae-a8f0-234cbde03d38@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/12 21:58, Tetsuo Handa wrote:
> On 2018/10/12 21:41, Johannes Weiner wrote:
>> On Fri, Oct 12, 2018 at 09:10:40PM +0900, Tetsuo Handa wrote:
>>> On 2018/10/12 21:08, Michal Hocko wrote:
>>>>> So not more than 10 dumps in each 5s interval. That looks reasonable
>>>>> to me. By the time it starts dropping data you have more than enough
>>>>> information to go on already.

Not reasonable at all.

>>>>
>>>> Yeah. Unless we have a storm coming from many different cgroups in
>>>> parallel. But even then we have the allocation context for each OOM so
>>>> we are not losing everything. Should we ever tune this, it can be done
>>>> later with some explicit examples.
>>>>
>>>>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>>>>
>>>> Thanks! I will post the patch to Andrew early next week.
>>>>

One thread from one cgroup is sufficient. I don't think that Michal's patch
is an appropriate mitigation. It still needlessly floods kernel log buffer
and significantly defers recovery operation.

Nacked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

---------- Testcase ----------

#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
	FILE *fp;
	const unsigned long size = 1048576 * 200;
	char *buf = malloc(size);
	mkdir("/sys/fs/cgroup/memory/test1", 0755);
	fp = fopen("/sys/fs/cgroup/memory/test1/memory.limit_in_bytes", "w");
	fprintf(fp, "%lu\n", size / 2);
	fclose(fp);
	fp = fopen("/sys/fs/cgroup/memory/test1/tasks", "w");
	fprintf(fp, "%u\n", getpid());
	fclose(fp);
	fp = fopen("/proc/self/oom_score_adj", "w");
	fprintf(fp, "-1000\n");
	fclose(fp);
	fp = fopen("/dev/zero", "r");
	fread(buf, 1, size, fp);
	fclose(fp);
	return 0;
}

---------- Michal's patch ----------

73133 lines (5.79MB) of kernel messages per one run

[root@ccsecurity ~]# time ./a.out

real    3m44.389s
user    0m0.000s
sys     3m42.334s

[root@ccsecurity ~]# time ./a.out

real    3m41.767s
user    0m0.004s
sys     3m39.779s

---------- My v2 patch ----------

50 lines (3.40 KB) of kernel messages per one run

[root@ccsecurity ~]# time ./a.out

real    0m5.227s
user    0m0.000s
sys     0m4.950s

[root@ccsecurity ~]# time ./a.out

real    0m5.249s
user    0m0.000s
sys     0m4.956s

