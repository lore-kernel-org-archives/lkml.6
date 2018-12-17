Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6969C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B055320874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeLQKwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:52:13 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:65353 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbeLQKwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:52:13 -0500
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wBHApWsQ055613;
        Mon, 17 Dec 2018 19:51:32 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp);
 Mon, 17 Dec 2018 19:51:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wBHApSOk055586
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 17 Dec 2018 19:51:32 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [PATCH] squashfs: enable __GFP_FS in ->readpage to prevent hang
 in mem alloc
To:     Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Hou Tao <houtao1@huawei.com>, phillip@squashfs.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20181204020840.49576-1-houtao1@huawei.com>
 <20181215143824.GJ10600@bombadil.infradead.org>
 <69457a5a-79c9-4950-37ae-eff7fa4f949a@huawei.com>
 <20181217035157.GK10600@bombadil.infradead.org>
 <20181217093337.GC30879@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <00ff5d2d-a50f-4730-db8a-cea3d7a3eef7@I-love.SAKURA.ne.jp>
Date:   Mon, 17 Dec 2018 19:51:27 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181217093337.GC30879@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/12/17 18:33, Michal Hocko wrote:
> On Sun 16-12-18 19:51:57, Matthew Wilcox wrote:
> [...]
>> Ah, yes, that makes perfect sense.  Thank you for the explanation.
>>
>> I wonder if the correct fix, however, is not to move the check for
>> GFP_NOFS in out_of_memory() down to below the check whether to kill
>> the current task.  That would solve your problem, and I don't _think_
>> it would cause any new ones.  Michal, you touched this code last, what
>> do you think?
> 
> What do you mean exactly? Whether we kill a current task or something
> else doesn't change much on the fact that NOFS is a reclaim restricted
> context and we might kill too early. If the fs can do GFP_FS then it is
> obviously a better thing to do because FS metadata can be reclaimed as
> well and therefore there is potentially less memory pressure on
> application data.
> 

I interpreted "to move the check for GFP_NOFS in out_of_memory() down to
below the check whether to kill the current task" as

@@ -1077,15 +1077,6 @@ bool out_of_memory(struct oom_control *oc)
 	}
 
 	/*
-	 * The OOM killer does not compensate for IO-less reclaim.
-	 * pagefault_out_of_memory lost its gfp context so we have to
-	 * make sure exclude 0 mask - all other users should have at least
-	 * ___GFP_DIRECT_RECLAIM to get here.
-	 */
-	if (oc->gfp_mask && !(oc->gfp_mask & __GFP_FS))
-		return true;
-
-	/*
 	 * Check if there were limitations on the allocation (only relevant for
 	 * NUMA and memcg) that may require different handling.
 	 */
@@ -1104,6 +1095,19 @@ bool out_of_memory(struct oom_control *oc)
 	}
 
 	select_bad_process(oc);
+
+	/*
+	 * The OOM killer does not compensate for IO-less reclaim.
+	 * pagefault_out_of_memory lost its gfp context so we have to
+	 * make sure exclude 0 mask - all other users should have at least
+	 * ___GFP_DIRECT_RECLAIM to get here.
+	 */
+	if ((oc->gfp_mask && !(oc->gfp_mask & __GFP_FS)) && oc->chosen &&
+	    oc->chosen != (void *)-1UL && oc->chosen != current) {
+		put_task_struct(oc->chosen);
+		return true;
+	}
+
 	/* Found nothing?!?! */
 	if (!oc->chosen) {
 		dump_header(oc, NULL);

which is prefixed by "the correct fix is not".

Behaving like sysctl_oom_kill_allocating_task == 1 if __GFP_FS is not used
will not be the correct fix. But ...

Hou Tao wrote:
> There is no need to disable __GFP_FS in ->readpage:
> * It's a read-only fs, so there will be no dirty/writeback page and
>   there will be no deadlock against the caller's locked page

is read-only filesystem sufficient for safe to use __GFP_FS?

Isn't "whether it is safe to use __GFP_FS" depends on "whether fs locks
are held or not" rather than "whether fs has dirty/writeback page or not" ?

