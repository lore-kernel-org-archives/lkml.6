Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B972C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C4C21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37C4C21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbeIXTN4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 15:13:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729307AbeIXTN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 15:13:56 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DEF02098A;
        Mon, 24 Sep 2018 13:11:47 +0000 (UTC)
Date:   Mon, 24 Sep 2018 09:11:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     He Zhe <zhe.he@windriver.com>
Cc:     <pmladek@suse.com>, <sergey.senozhatsky@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] printk: Fix panic caused by passing log_buf_len
 to command line
Message-ID: <20180924091140.18c1cea7@vmware.local.home>
In-Reply-To: <e8d31c43-145b-df78-6e78-9e6ad26c3a31@windriver.com>
References: <1537630852-247674-1-git-send-email-zhe.he@windriver.com>
        <20180922121905.3e4159eb@vmware.local.home>
        <e8d31c43-145b-df78-6e78-9e6ad26c3a31@windriver.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Sep 2018 14:51:12 +0800
He Zhe <zhe.he@windriver.com> wrote:

> On 2018年09月23日 00:19, Steven Rostedt wrote:
> > On Sat, 22 Sep 2018 23:40:51 +0800
> > <zhe.he@windriver.com> wrote:
> >  
> >> From: He Zhe <zhe.he@windriver.com>
> >>
> >> log_buf_len_setup does not check input argument before passing it to
> >> simple_strtoull. The argument would be a NULL pointer if "log_buf_len",
> >> without its value, is set in command line and thus causes the following
> >> panic.
> >>
> >> PANIC: early exception 0xe3 IP 10:ffffffffaaeacd0d error 0 cr2 0x0
> >> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc4-yocto-standard+ #1
> >> [    0.000000] RIP: 0010:_parse_integer_fixup_radix+0xd/0x70
> >> ...
> >> [    0.000000] Call Trace:
> >> [    0.000000]  simple_strtoull+0x29/0x70
> >> [    0.000000]  memparse+0x26/0x90
> >> [    0.000000]  log_buf_len_setup+0x17/0x22
> >> [    0.000000]  do_early_param+0x57/0x8e
> >> [    0.000000]  parse_args+0x208/0x320
> >> [    0.000000]  ? rdinit_setup+0x30/0x30
> >> [    0.000000]  parse_early_options+0x29/0x2d
> >> [    0.000000]  ? rdinit_setup+0x30/0x30
> >> [    0.000000]  parse_early_param+0x36/0x4d
> >> [    0.000000]  setup_arch+0x336/0x99e
> >> [    0.000000]  start_kernel+0x6f/0x4ee
> >> [    0.000000]  x86_64_start_reservations+0x24/0x26
> >> [    0.000000]  x86_64_start_kernel+0x6f/0x72
> >> [    0.000000]  secondary_startup_64+0xa4/0xb0
> >>
> >> This patch adds a check to prevent the panic.
> >>
> >> Signed-off-by: He Zhe <zhe.he@windriver.com>
> >> Cc: stable@vger.kernel.org  
> > I just tried this on a 2.6.32 kernel, and it crashes there. I guess
> > this goes farther back than git history goes.
> >
> > Perhaps it should be commented that this bug has been here since
> > creation of (git) time.  
> 
> I did a try on 2.6.32. It passed. Actually this bug only happens on
> early_param(not __setup) which is introduced since v3.0. The oldest

Really? This is what I got:

Linux version 2.6.32-565.el6.x86_64 (mockbuild@x86-022.build.eng.bos.redhat.com) (gcc version 4.4.7 20120313 (Red Hat 4.4.7-16) (GCC) ) #1 SMP Tue Jun 2 14:53:05 EDT 2015
Command line: ro root=UUID=b6bbd80c-a321-4350-9d87-ba8ec1f45917 LANG=en_US.UTF-8 SYSFONT=latarcyrheb-sun16 KEYTABLE=us console=ttyS0,115200 crashkernel=auto selinux=0 earlyprintk=ttyS0,115200 log_buf_len
KERNEL supported cpus:
  Intel GenuineIntel
  AMD AuthenticAMD
  Centaur CentaurHauls
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009d800 (usable)
 BIOS-e820: 000000000009d800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000c69ee000 (usable)
 BIOS-e820: 00000000c69ee000 - 00000000c69f5000 (ACPI NVS)
 BIOS-e820: 00000000c69f5000 - 00000000c6e38000 (usable)
 BIOS-e820: 00000000c6e38000 - 00000000c73c9000 (reserved)
 BIOS-e820: 00000000c73c9000 - 00000000d8dac000 (usable)
 BIOS-e820: 00000000d8dac000 - 00000000d8e44000 (reserved)
 BIOS-e820: 00000000d8e44000 - 00000000d8e95000 (usable)
 BIOS-e820: 00000000d8e95000 - 00000000d8fc8000 (ACPI NVS)
 BIOS-e820: 00000000d8fc8000 - 00000000d9fff000 (reserved)
 BIOS-e820: 00000000d9fff000 - 00000000da000000 (usable)
 BIOS-e820: 00000000db000000 - 00000000df200000 (reserved)
 BIOS-e820: 00000000f8000000 - 00000000fc000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fed00000 - 00000000fed04000 (reserved)
 BIOS-e820: 00000000fed1c000 - 00000000fed20000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 000000021ee00000 (usable)
bootconsole [earlyser0] enabled
PANIC: early exception 0e rip 10:ffffffff812a1a4d error 0 cr2 0
Pid: 0, comm: swapper Not tainted 2.6.32-565.el6.x86_64 #1
Call Trace:
 [<ffffffff81043069>] ? native_read_cr2+0x9/0x10
 [<ffffffff81c3719e>] ? early_idt_handler+0x5e/0x71
 [<ffffffff812a1a4d>] ? _parse_integer_fixup_radix+0xd/0x70
 [<ffffffff8129b29a>] ? simple_strtoull+0x1a/0x50
 [<ffffffff8128fde7>] ? memparse+0x17/0x90
 [<ffffffff81c58166>] ? log_buf_len_setup+0x15/0x47
 [<ffffffff81c37790>] ? do_early_param+0x5d/0x89
 [<ffffffff8109dcc7>] ? parse_args+0x197/0x340
 [<ffffffff81c37733>] ? do_early_param+0x0/0x89
 [<ffffffff81c377da>] ? parse_early_options+0x1e/0x20
 [<ffffffff81c37cf2>] ? parse_early_param+0x31/0x3d
 [<ffffffff81c3d548>] ? setup_arch+0x36f/0xc69
 [<ffffffff8153783d>] ? printk+0x41/0x44
 [<ffffffff81c37dda>] ? start_kernel+0xdc/0x431
 [<ffffffff81c3733a>] ? x86_64_start_reservations+0x125/0x129
 [<ffffffff81c37453>] ? x86_64_start_kernel+0x115/0x124
RIP _parse_integer_fixup_radix+0xd/0x70

> LTS version is 3.16 now. Should I send v4 and add a statement about
> the supported version range in commit log?

Fixes tags and stable info can be added by the maintainer that pulls in
the patch. I was just commenting on it for them.

> 
> >
> >  
> >> Cc: pmladek@suse.com
> >> Cc: sergey.senozhatsky@gmail.com
> >> Cc: rostedt@goodmis.org
> >> ---
> >> v2:
> >> Split out the addition of pr_fmt and the unsigned update  
> > Which unsigned update? As it does switch to unsigned to "unsigned int",
> > but that change is fine to me with this.  
> 
> No problem. It's the history of v2.
> 
> In v1 you suggested "unsigned int size" should be in a separate patch and
> I did that in v2. Then Sergey suggested "unsigned int size" should be in the
> 1/2 patch to avoid checkpatch.pl warning. With your conformation, I add it
> back here in v3.
> 

Yeah, I'm fine with the addition. It should still be stated in the
main change log. The version history is cut from git commits.

Thanks!

-- Steve
