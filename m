Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03953C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D145520823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfARJbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:31:35 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:19461 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfARJbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:31:34 -0500
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0I9VWtF019278;
        Fri, 18 Jan 2019 18:31:32 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp);
 Fri, 18 Jan 2019 18:31:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav302.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0I9VQFh019150
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 18 Jan 2019 18:31:31 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: BUG: sleeping function called from invalid context at
 kernel/locking/mutex.c:908
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        intel-wired-lan@lists.osuosl.org
References: <CABXGCsOLF48xC30CofbJQMkiRa7vS8pGKu8T0Drskc4QxLy24A@mail.gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Bernhard Kaindl <bernhard.kaindl@thalesgroup.com>,
        Jan Jablonsky <jan.jablonsky@thalesgroup.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <a743c273-fe13-0e96-a162-8d15b005ad94@I-love.SAKURA.ne.jp>
Date:   Fri, 18 Jan 2019 18:31:25 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CABXGCsOLF48xC30CofbJQMkiRa7vS8pGKu8T0Drskc4QxLy24A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is not a MM bug. ;-)
And this change is made by below commit.

commit 59361316afcb08569af21e1af83e89c7051c055a
Author: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date:   Thu Aug 2 10:13:10 2018 -0700

    igb: reduce CPU0 latency when updating statistics


On 2019/01/18 18:21, Mikhail Gavrilov wrote:
> Hi folks.
> 
> Starting from 5.0 rc1 every time after launch atop I see subject error message.
> 
> And this issue afle negatively impact on system performance.
> 
> Unclear on which subsystem it related but I hope here in mm list
> somebody help clarify what is happened.
> 
> Thanks.
> 
> Full dmesg also attached.
> 
> [ 2164.694709] BUG: sleeping function called from invalid context at
> kernel/locking/mutex.c:908
> [ 2164.694724] in_atomic(): 1, irqs_disabled(): 0, pid: 10498, name: atop
> [ 2164.694729] 2 locks held by atop/10498:
> [ 2164.694732]  #0: 0000000061e564e5 (&p->lock){+.+.}, at: seq_read+0x41/0x430
> [ 2164.694753]  #1: 0000000081e34167 (rcu_read_lock){....}, at:
> dev_seq_start+0x5/0x120
> [ 2164.694762] CPU: 10 PID: 10498 Comm: atop Tainted: G         C
>   5.0.0-0.rc2.git1.2.fc30.x86_64 #1
> [ 2164.694765] Hardware name: System manufacturer System Product
> Name/ROG STRIX X470-I GAMING, BIOS 1103 11/16/2018
> [ 2164.694768] Call Trace:
> [ 2164.694773]  dump_stack+0x85/0xc0
> [ 2164.694778]  ___might_sleep.cold.73+0xac/0xbc
> [ 2164.694783]  __mutex_lock+0x55/0x9a0
> [ 2164.694788]  ? seq_vprintf+0x30/0x50
> [ 2164.694792]  ? seq_printf+0x53/0x70
> [ 2164.694806]  ? igb_get_stats64+0x29/0x80 [igb]
> [ 2164.694813]  igb_get_stats64+0x29/0x80 [igb]
> [ 2164.694818]  dev_get_stats+0x5b/0xc0
> [ 2164.694822]  dev_seq_printf_stats+0x32/0xe0
> [ 2164.694836]  dev_seq_show+0x10/0x30
> [ 2164.694840]  seq_read+0x2fd/0x430
> [ 2164.694847]  proc_reg_read+0x39/0x60
> [ 2164.694852]  __vfs_read+0x36/0x1a0
> [ 2164.694861]  vfs_read+0x9f/0x160
> [ 2164.694866]  ksys_read+0x52/0xc0
> [ 2164.694872]  do_syscall_64+0x60/0x1f0
> [ 2164.694876]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [ 2164.694880] RIP: 0033:0x7fa0f51bd255
> [ 2164.694883] Code: fe ff ff 50 48 8d 3d 2a 03 0a 00 e8 35 01 02 00
> 0f 1f 44 00 00 f3 0f 1e fa 48 8d 05 c5 94 0d 00 8b 00 85 c0 75 0f 31
> c0 0f 05 <48> 3d 00 f0 ff ff 77 53 c3 66 90 41 54 49 89 d4 55 48 89 f5
> 53 89
> [ 2164.694886] RSP: 002b:00007ffe79288db8 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000000
> [ 2164.694890] RAX: ffffffffffffffda RBX: 0000000000a55260 RCX: 00007fa0f51bd255
> [ 2164.694892] RDX: 0000000000000400 RSI: 0000000000a55490 RDI: 0000000000000004
> [ 2164.694895] RBP: 0000000000000d68 R08: 0000000000000001 R09: 0000000000000000
> [ 2164.694898] R10: 00007fa0f50a3740 R11: 0000000000000246 R12: 00007fa0f528d740
> [ 2164.694900] R13: 00007fa0f528e340 R14: 00000000000007ff R15: 0000000000a55260
> 
> 
> 
> --
> Best Regards,
> Mike Gavrilov.
> 

