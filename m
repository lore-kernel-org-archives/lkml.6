Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB78BC282C5
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 07:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76991218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 07:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbfAZHzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 02:55:16 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:60939 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfAZHzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 02:55:15 -0500
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0Q7tD7O006811;
        Sat, 26 Jan 2019 16:55:13 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp);
 Sat, 26 Jan 2019 16:55:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0Q7tCD3006805
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 26 Jan 2019 16:55:13 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: pids.current with invalid value for hours [5.0.0 rc3 git]
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     =?UTF-8?Q?Arkadiusz_Mi=c5=9bkiewicz?= <a.miskiewicz@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Aleksa Sarai <asarai@suse.de>, Jay Kamat <jgkamat@fb.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <df806a77-3327-9db5-8be2-976fde1c84e5@gmail.com>
 <20190117122535.njcbqhlmzozdkncw@mikami>
 <1d36b181-cbaf-6694-1a31-2f7f55d15675@gmail.com>
 <96ef6615-a5df-30af-b4dc-417a18ca63f1@gmail.com>
 <1cdbef13-564d-61a6-95f4-579d2cad243d@gmail.com>
 <20190125163731.GJ50184@devbig004.ftw2.facebook.com>
 <a95d004a-4358-7efc-6d21-12aac4411b32@gmail.com>
 <480296c4-ed7a-3265-e84a-298e42a0f1d5@I-love.SAKURA.ne.jp>
 <6da6ca69-5a6e-a9f6-d091-f89a8488982a@gmail.com>
 <72aa8863-a534-b8df-6b9e-f69cf4dd5c4d@i-love.sakura.ne.jp>
Message-ID: <33a07810-6dbc-36be-5bb6-a279773ccf69@i-love.sakura.ne.jp>
Date:   Sat, 26 Jan 2019 16:55:13 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <72aa8863-a534-b8df-6b9e-f69cf4dd5c4d@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/26 15:10, Tetsuo Handa wrote:
> On 2019/01/26 11:41, Arkadiusz Miśkiewicz wrote:
>> dmesg:
>> http://ixion.pld-linux.org/~arekm/cgroup-oom-2.txt

OK. There is a refcount leak bug in wake_oom_reaper()
which became visible by enabling oom_group setting.

static void wake_oom_reaper(struct task_struct *tsk)
{
	/* tsk is already queued? */
	if (tsk == oom_reaper_list || tsk->oom_reaper_list)
		return;

	get_task_struct(tsk);

	spin_lock(&oom_reaper_lock);
	tsk->oom_reaper_list = oom_reaper_list;
	oom_reaper_list = tsk;
	spin_unlock(&oom_reaper_lock);
	trace_wake_reaper(tsk->pid);
	wake_up(&oom_reaper_wait);
}

(1) oom_reaper_list and tsk(*)->oom_reaper_list are initially NULL.
(2) Since tsk(2160) != oom_reaper_list && tsk(2160)->oom_reaper_list == NULL,
    get_task_struct(tsk(2160)) is called.
(3) tsk(2160)->oom_reaper_list = oom_reaper_list (which is NULL).
(4) oom_reaper_list = tsk(2160) (which is not NULL).
(5) Since tsk(2150) != oom_reaper_list (which is tsk(2160)) && tsk(2150)->oom_reaper_list == NULL,
    get_task_struct(tsk(2150)) is called.
(6) Step (5) repeats on tsk(2153, 2164. 2166, 2163, 2159, 2161, 2154).
(7) Since tsk(2160) != oom_reaper_list (which is tsk(2154)) && tsk(2160)->oom_reaper_list == NULL
    (because it was NULL as of (2)), get_task_struct(tsk(2160)) is called again.
(8) oom_reap_task() calls put_task_struct(tsk(2160)) for only once because
    tsk(2160) appears on the oom_reaper_list for only once; leaking refcount.

Jan 26 03:33:49 xps kernel: Memory cgroup out of memory: Kill process 2160 (python3) score 66 or sacrifice child
Jan 26 03:33:49 xps kernel: Killed process 2160 (python3) total-vm:272176kB, anon-rss:31668kB, file-rss:3248kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Tasks in /test_2149 are going to be killed due to memory.oom.group set
Jan 26 03:33:49 xps kernel: Killed process 2150 (python3) total-vm:272176kB, anon-rss:27572kB, file-rss:3248kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2153 (python3) total-vm:261936kB, anon-rss:17396kB, file-rss:3188kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2164 (python3) total-vm:272176kB, anon-rss:27572kB, file-rss:3248kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2166 (python3) total-vm:261936kB, anon-rss:15088kB, file-rss:3188kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2163 (python3) total-vm:261936kB, anon-rss:21496kB, file-rss:3188kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2159 (python3) total-vm:282420kB, anon-rss:23944kB, file-rss:3128kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2161 (python3) total-vm:251692kB, anon-rss:11172kB, file-rss:3060kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2154 (python3) total-vm:261936kB, anon-rss:15084kB, file-rss:3188kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2160 (python3) total-vm:272176kB, anon-rss:31668kB, file-rss:3248kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2155 (python3) total-vm:261936kB, anon-rss:17364kB, file-rss:3056kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2168 (python3) total-vm:272176kB, anon-rss:29620kB, file-rss:3108kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2156 (python3) total-vm:251692kB, anon-rss:11204kB, file-rss:3188kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2157 (python3) total-vm:251692kB, anon-rss:11172kB, file-rss:3088kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2169 (python3) total-vm:261936kB, anon-rss:19448kB, file-rss:3188kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2158 (python3) total-vm:272176kB, anon-rss:23944kB, file-rss:3192kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2170 (python3) total-vm:251692kB, anon-rss:13252kB, file-rss:3188kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2171 (python3) total-vm:261936kB, anon-rss:17396kB, file-rss:3188kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2173 (python3) total-vm:251692kB, anon-rss:11204kB, file-rss:3188kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2152 (python3) total-vm:261936kB, anon-rss:13724kB, file-rss:3100kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2174 (python3) total-vm:251692kB, anon-rss:11160kB, file-rss:3120kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2172 (python3) total-vm:251692kB, anon-rss:9128kB, file-rss:3116kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2187 (python3) total-vm:261936kB, anon-rss:23516kB, file-rss:3116kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2184 (python3) total-vm:251692kB, anon-rss:13500kB, file-rss:3188kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2151 (python3) total-vm:251692kB, anon-rss:9108kB, file-rss:3096kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2182 (python3) total-vm:251692kB, anon-rss:12196kB, file-rss:3140kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2175 (python3) total-vm:261936kB, anon-rss:13996kB, file-rss:3124kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2183 (python3) total-vm:251692kB, anon-rss:9124kB, file-rss:3112kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2177 (python3) total-vm:251692kB, anon-rss:9148kB, file-rss:3140kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2186 (python3) total-vm:261936kB, anon-rss:15336kB, file-rss:3152kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2189 (python3) total-vm:251692kB, anon-rss:9156kB, file-rss:3188kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2178 (python3) total-vm:251692kB, anon-rss:11204kB, file-rss:3188kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2185 (python3) total-vm:261936kB, anon-rss:15084kB, file-rss:3188kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2190 (python3) total-vm:251692kB, anon-rss:11204kB, file-rss:3188kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2179 (python3) total-vm:251692kB, anon-rss:9156kB, file-rss:3188kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2180 (python3) total-vm:251692kB, anon-rss:5060kB, file-rss:3188kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2181 (python3) total-vm:261936kB, anon-rss:21492kB, file-rss:3188kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2176 (python3) total-vm:261936kB, anon-rss:15348kB, file-rss:3188kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2188 (python3) total-vm:251692kB, anon-rss:7108kB, file-rss:3188kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2191 (python3) total-vm:261936kB, anon-rss:14556kB, file-rss:3188kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: Killed process 2192 (python3) total-vm:241448kB, anon-rss:3456kB, file-rss:2712kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2163 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2192 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2191 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2188 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2176 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2181 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2180 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2179 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2190 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2185 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2178 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2189 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2186 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2177 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2175 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2182 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2151 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2184 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2187 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2172 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2174 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2173 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2171 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2158 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2169 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2157 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2156 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2168 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2155 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2160 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2154 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:49 xps kernel: oom_reaper: reaped process 2161 (python3), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
Jan 26 03:33:50 xps kernel: python3 invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), order=0, oom_score_adj=0
Jan 26 03:33:50 xps kernel: CPU: 1 PID: 2217 Comm: python3 Tainted: G            E   T 5.0.0-rc3-00104-gc04e2a780caf-dirty #289

Since we assumed that wake_oom_reaper() is called for only once
for one out_of_memory() request,

	/* tsk is already queued? */
	if (tsk == oom_reaper_list || tsk->oom_reaper_list)
		return;

no longer works.
