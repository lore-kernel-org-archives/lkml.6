Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04D6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873522087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfARPhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:37:32 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:54644 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727542AbfARPhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:37:31 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id F40E113F8D5;
        Fri, 18 Jan 2019 16:36:59 +0100 (CET)
Subject: Re: kmemleak panic
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Qian Cai <cai@lca.pw>, LKML <linux-kernel@vger.kernel.org>
References: <f6fbf528-8213-e3b8-6990-9fcf9dec04d6@free.fr>
 <20190118143434.GE118707@arrakis.emea.arm.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <b7629ecf-757c-f8b5-df83-ba83d7036b2f@free.fr>
Date:   Fri, 18 Jan 2019 16:36:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190118143434.GE118707@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2019 15:34, Catalin Marinas wrote:

> On Fri, Jan 18, 2019 at 02:36:46PM +0100, Marc Gonzalez wrote:
>
>> Trying to diagnose a separate issue, I enabled a raft of debugging options,
>> including kmemleak. However, it looks like kmemleak itself is crashing?
>>
>> We seem to be crashing on this code:
>>
>> 		kasan_disable_current();
>> 		pointer = *ptr;
>> 		kasan_enable_current();
> 
> There was another regression reported recently:
> 
> http://lkml.kernel.org/r/51e79597-21ef-3073-9036-cfc33291f395@lca.pw
> 
> See if reverting commit 9f1eb38e0e113 (mm, kmemleak: little optimization while
> scanning) fixes it.
> 

[Drop LAKML, add LKML, add recipients]

Bug is easy to reproduce:

boot
mount -t debugfs nodev /sys/kernel/debug/ 
echo scan > /sys/kernel/debug/kmemleak

Unable to handle kernel paging request at virtual address ffffffc021e00000
Mem abort info:
  ESR = 0x96000006
  Exception class = DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
swapper pgtable: 4k pages, 39-bit VAs, pgdp = (____ptrval____)
[ffffffc021e00000] pgd=000000017e3ba803, pud=000000017e3ba803, pmd=0000000000000000
Internal error: Oops: 96000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 635 Comm: exe Not tainted 5.0.0-rc1 #16
Hardware name: Qualcomm Technologies, Inc. MSM8998 v1 MTP (DT)
pstate: 80000085 (Nzcv daIf -PAN -UAO)
pc : scan_block+0x70/0x190
lr : scan_block+0x6c/0x190
sp : ffffff80133b3b20
x29: ffffff80133b3b20 x28: ffffffc0fdbaf018 
x27: ffffffc022000000 x26: 0000000000000080 
x25: ffffff80118bdf70 x24: ffffffc0f8cc8000 
x23: ffffff8010bd8000 x22: ffffff8010bd8830 
x21: ffffffc021e00ff9 x20: ffffffc0f8cc8050 
x19: ffffffc021e00000 x18: 00000000000025fd 
x17: 0000000000000200 x16: 0000000000000000 
x15: ffffff8010c24dd8 x14: 00000000000025f9 
x13: 00000000445b0e6c x12: ffffffc0f5a96658 
x11: 0000000000000001 x10: ffffff8010bae688 
x9 : ffffff8010baf000 x8 : ffffff8010bae688 
x7 : 0000000000000003 x6 : 0000000000000000 
x5 : ffffff801133ad60 x4 : 0000000000002878 
x3 : ffffff8010c24d88 x2 : 7c512d102eca1300 
x1 : ffffffc0f5a81b00 x0 : 0000000000000000 
Process exe (pid: 635, stack limit = 0x(____ptrval____))
Call trace:
 scan_block+0x70/0x190
 scan_gray_list+0x108/0x1c0
 kmemleak_scan+0x33c/0x7c0
 kmemleak_write+0x410/0x4b0
 full_proxy_write+0x68/0xa0
 __vfs_write+0x60/0x190
 vfs_write+0xac/0x1a0
 ksys_write+0x6c/0xe0
 __arm64_sys_write+0x24/0x30
 el0_svc_handler+0xc0/0x160
 el0_svc+0x8/0xc
Code: f9000fb4 d503201f 97ffffd2 35000580 (f9400260) 
---[ end trace 8797ac2fea89abd6 ]---
note: exe[635] exited with preempt_count 2



Reverting 9f1eb38e0e1131e75cc4ac684391b25d70282589 does not help:

Unable to handle kernel paging request at virtual address ffffffc021e00000
Mem abort info:
  ESR = 0x96000006
  Exception class = DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
swapper pgtable: 4k pages, 39-bit VAs, pgdp = (____ptrval____)
[ffffffc021e00000] pgd=000000017e3ba803, pud=000000017e3ba803, pmd=0000000000000000
Internal error: Oops: 96000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 636 Comm: exe Not tainted 5.0.0-rc1 #18
Hardware name: Qualcomm Technologies, Inc. MSM8998 v1 MTP (DT)
pstate: 80000085 (Nzcv daIf -PAN -UAO)
pc : scan_block+0x70/0x190
lr : scan_block+0x6c/0x190
sp : ffffff8013303b20
x29: ffffff8013303b20 x28: ffffffc0fdbaf018 
x27: ffffffc022000000 x26: 0000000000000080 
x25: ffffff80118bdf70 x24: ffffffc0f8cc8000 
x23: ffffff8010bd8000 x22: ffffff8010bd8830 
x21: ffffffc021e00ff9 x20: ffffffc0f8cc8050 
x19: ffffffc021e00000 x18: 0000000000002704 
x17: 0000000000000200 x16: 0000000000000000 
x15: ffffff8010c24dd8 x14: 0000000000002700 
x13: 0000000068ed2dfa x12: ffffffc0f5a39a58 
x11: 0000000000000001 x10: ffffff8010bae688 
x9 : ffffff8010baf000 x8 : ffffff8010bae688 
x7 : 0000000000000003 x6 : 0000000000000000 
x5 : ffffff80113223a0 x4 : 00000000000029c8 
x3 : ffffff8010c24d88 x2 : 7c512d102eca1300 
x1 : ffffffc0f59f9200 x0 : 0000000000000000 
Process exe (pid: 636, stack limit = 0x(____ptrval____))
Call trace:
 scan_block+0x70/0x190
 scan_gray_list+0x108/0x1c0
 kmemleak_scan+0x338/0x7c0
 kmemleak_write+0x410/0x4b0
 full_proxy_write+0x68/0xa0
 __vfs_write+0x60/0x190
 vfs_write+0xac/0x1a0
 ksys_write+0x6c/0xe0
 __arm64_sys_write+0x24/0x30
 el0_svc_handler+0xc0/0x160
 el0_svc+0x8/0xc
Code: f9000fb4 d503201f 97ffffd2 35000580 (f9400260) 
---[ end trace 65933b4754c5cee7 ]---
note: exe[636] exited with preempt_count 2


Regards.
