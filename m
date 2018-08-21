Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A079C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 18:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8189214C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 18:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8189214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeHUV6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 17:58:45 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:54796 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726813AbeHUV6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 17:58:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01429;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0T7-GkVw_1534876624;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T7-GkVw_1534876624)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Aug 2018 02:37:07 +0800
To:     gregkh@linuxfoundation.org, ak@linux.intel.com, tglx@linutronix.de,
        dave.hansen@intel.com, dwmw@amazon.co.uk
Cc:     stable@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, YangShi <yang.shi@linux.alibaba.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Subject: [BUG] madvise05 leads kernel panic on 4.9.122
Message-ID: <b205fec4-a1ed-dd44-7ba4-7b78f7429689@linux.alibaba.com>
Date:   Tue, 21 Aug 2018 11:37:03 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,


I just ran some regression test on stable 4.9.122 with LTP. madvise05 
triggers the below kernel panic:


[ 6785.089994] BUG: unable to handle kernel paging request at 
ffffeaff44488020
[ 6785.097952] IP: [] page_remove_rmap+0x27/0x580
[ 6785.104810] PGD 0
[ 6785.106859]
[ 6785.108526] Oops: 0000 [#1] SMP
[ 6785.112029] Modules linked in: mptctl(E) mptbase(E) tun(E) fuse(E) 
vfat(E) fat(E) btrfs(E) xor(E) raid6_pq(E) xfs(E)
[ 6785.123905] CPU: 14 PID: 77983 Comm: madvise05 Tainted: G E 
4.9.122-001.ali3000_nightly_cov_20180820_193.test.alios7.x86_64 #1
[ 6785.137880] Hardware name: Dell Inc. PowerEdge R720xd/0X6FFV, BIOS 
1.3.6 09/11/2012
[ 6785.146425] task: ffff882daeb78000 task.stack: ffffc9001b438000
[ 6785.153031] RIP: 0010:[] [] page_remove_rmap+0x27/0x580
[ 6785.162461] RSP: 0018:ffffc9001b43bc50 EFLAGS: 00010246
[ 6785.168388] RAX: 0000000000000000 RBX: ffffeaff44488000 RCX: 
0000000000000080
[ 6785.176351] RDX: ffffeaff44488000 RSI: 0000000000000001 RDI: 
ffffeaff44488000
[ 6785.184315] RBP: ffffc9001b43bc80 R08: ffff882f9d4a6540 R09: 
ffffffff84bcdf60
[ 6785.192277] R10: 0000000000000000 R11: 0000000000000000 R12: 
0000000000000001
[ 6785.200241] R13: ffff882db6996910 R14: ffffea00b6da65b0 R15: 
00003fffffe00000
[ 6785.208205] FS: 00002ae5a3dfbb80(0000) GS:ffff882fbf180000(0000) 
knlGS:0000000000000000
[ 6785.217234] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6785.223646] CR2: ffffeaff44488020 CR3: 0000002f9d51c000 CR4: 
00000000000606f0
[ 6785.231610] Stack:
[ 6785.233851] 0000000000000000 00003ffffd6b3320 0434f9415ac47f2c 
ffffeaff44488000
[ 6785.242143] ffffc9001b43bdd8 ffff882db6996910 ffffc9001b43bcc0 
ffffffff81355aaa
[ 6785.250438] ffff882f9d4a6540 00002ae5a4400000 00002ae5a4600000 
ffffffff84bcd7a0
[ 6785.258728] Call Trace:
[ 6785.261460] [] zap_huge_pmd+0x28a/0x640
[ 6785.267585] [] unmap_page_range+0x532/0x630
[ 6785.274087] [] unmap_single_vma+0xa9/0x160
[ 6785.280501] [] unmap_vmas+0x5f/0xe0
[ 6785.286236] [] unmap_region+0xe4/0x1e0
[ 6785.292263] [] ? blk_finish_plug+0x3c/0x60
[ 6785.298669] [] ? SYSC_madvise+0x69b/0xed0
[ 6785.304985] [] do_munmap+0x39b/0x5b0
[ 6785.310818] [] SyS_munmap+0x78/0xb0
[ 6785.316552] [] do_syscall_64+0xf4/0x350
[ 6785.322676] [] entry_SYSCALL_64_after_swapgs+0x58/0xca
[ 6785.330244] Code: 00 00 00 00 66 66 66 66 90 55 <48> 8b 57 20 48 89 
f8 f6 c2 01 0f
[ 6785.339011] RIP [] page_remove_rmap+0x27/0x580
[ 6785.345825] RSP
[ 6785.349715] CR2: ffffeaff44488020


The same test case works well on both 4.9.119 and the latest Linus's 
tree. So, it looks it is caused by the L1TF patches on the stable tree.


And, the madvise05 test case can be simplified to the below test program:


#include <sys/mman.h>
#include <stdio.h>

void main()
{
         void *addr;
         int err;

         addr = mmap(NULL, 32 * 1024 * 1024, PROT_READ,
                     MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE, -1, 0);

         if (addr == MAP_FAILED) {
                 printf("mmap failed\n");
                 return;
         }

         err = mprotect(addr, 32 * 1024 * 1024, PROT_NONE);
         if (err < 0) {
                 printf("mprotect failed\n");
                 return;
         }

         munmap(addr, 32 * 1024 * 1024);
}


You may be already aware of this problem or any hint is appreciated.


Thanks,

Yang

