Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id q+oiIyExGVtjMgAAmS7hNA
	; Thu, 07 Jun 2018 13:20:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 78229606DD; Thu,  7 Jun 2018 13:20:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8A97C601C3;
	Thu,  7 Jun 2018 13:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8A97C601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932630AbeFGNUa (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:20:30 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:40310 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932568AbeFGNU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:20:28 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w57DJFOt091278;
        Thu, 7 Jun 2018 22:19:15 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Thu, 07 Jun 2018 22:19:15 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w57DJ8oq091222
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 7 Jun 2018 22:19:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: task hung in blk_queue_enter
To: Ming Lei <tom.leiming@gmail.com>, Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        alan.christopher.jenkins@gmail.com,
        syzbot+c4f9cebf9d651f6e54de@syzkaller.appspotmail.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        martin@lichtvoll.de, Hannes Reinecke <hare@suse.com>,
        syzkaller-bugs@googlegroups.com,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        "open list:EXT4 FILE SYSTEM" <linux-ext4@vger.kernel.org>
References: <25708e84-6f35-04c3-a2e4-6854f0ed9e78@I-love.SAKURA.ne.jp>
 <dc9862c7-ec16-8b11-04e4-422b435d41ef@kernel.dk>
 <201806050027.w550RfJl010157@www262.sakura.ne.jp>
 <20180605004128.GA28826@ming.t460p>
 <CACVXFVNcJ+tC6RUT+JUA3iw+STB+q4P_u+AvoOSrt04zEw8TZA@mail.gmail.com>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <927ef9f9-4f4d-185e-b86f-10bd18fa92d4@i-love.sakura.ne.jp>
Date: Thu, 7 Jun 2018 22:19:06 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVNcJ+tC6RUT+JUA3iw+STB+q4P_u+AvoOSrt04zEw8TZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/06/07 12:29, Ming Lei wrote:
>> The vfs_fsync() isn't necessary in loop_update_dio() since both
>> generic_file_write_iter() and generic_file_read_iter() can handle
>> buffered io vs dio well.
>>
>> I will send one patch to remove the vfs_sync() later.
> 
> Hi Tetsuo,
> 
> The issue might be fixed by removing this vfs_sync(), but I'd like to
> understand the idea behind since vfs_sync() shouldn't have caused
> any IO to this loop queue.
> 
> I also tried to do the test via the following c syzbot, but can't reproduce
> it yet after running it for several hours.
> 
> https://syzkaller.appspot.com/x/repro.c?id=4727023951937536
> 
> Could you share us how you reproduce it?

I just reported that syzbot started hitting vfs_sync() case.
I haven't succeeded reproducing vfs_sync() case in my environment.

But in general, I modify "any reproducer provided by syzbot that loops
forever" to call exit() if open() etc. failed, for continuing the loop
unlikely helps after hitting "Too many open files" error.

   res = syscall(__NR_memfd_create, 0x200002c0, 0);
   if (res != -1)
     r[1] = res;
+  else
+    exit(1);

Thus, I restart the reproducer in a loop from shell
rather than keep running for hours.

   while :; do echo -n .; ./a.out; done
