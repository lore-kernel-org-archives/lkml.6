Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF35C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6C0214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F6C0214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbeKUVyA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 16:54:00 -0500
Received: from mga04.intel.com ([192.55.52.120]:35650 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbeKUVyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 16:54:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 03:19:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,261,1539673200"; 
   d="scan'208";a="110121056"
Received: from jlahtine-desk.ger.corp.intel.com (HELO localhost) ([10.251.84.195])
  by orsmga001.jf.intel.com with ESMTP; 21 Nov 2018 03:19:55 -0800
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Pavel Machek <pavel@ucw.cz>, bp@alien8.de, hpa@zytor.com,
        kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        tglx@linutronix.de, x86@kernel.org
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
In-Reply-To: <20181108175803.GA10785@amd>
Cc:     jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
        intel-gfx@lists.freedesktop.org, chris@chris-wilson.co.uk
References: <20181108175803.GA10785@amd>
Message-ID: <154279919462.20217.14259089584802660420@jlahtine-desk.ger.corp.intel.com>
User-Agent: alot/0.6
Subject: Re: v4.20-rc1: list_del corruption on thinkpad x220
Date:   Wed, 21 Nov 2018 13:19:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Chris

Quoting Pavel Machek (2018-11-08 19:58:03)
> Hi!
> 
> My machine locked hard (thinkpad x220). After reboot, I found this in
> syslog:
> 
> Sounds like memory corruption..? Does not sound like easy to debug.

Were you doing something GPU intense when you experienced the hard hang?

And if so, have you been able to hit the issue more than once? At this
point it doesn't look like anything we've hit previously, so would be
great to have some more insight into how we could reproduce.

There's one similar for nouveau in Bugzilla, but it seems like a genuine
memory corruption (1 bit flipped):

https://bugs.freedesktop.org/show_bug.cgi?id=84880

Any extra information would be of use :)

Regards, Joonas

PS. Could you open a bug to Bugzilla, it'll help to collect the
information in one consolidated place:

https://01.org/linuxgraphics/documentation/how-report-bugs

> 
> ...otoh, it still looks like an addres, so maybe it is "just" race in
> GPU drivers?
> 
> Any ideas?
>                                                                 Pavel
> 
> Nov  8 18:35:01 duo CRON[28511]: (root) CMD (command -v debian-sa1 >
> /dev/null && debian-sa
> 1 1 1)
> Nov  8 18:42:57 duo kernel: list_del corruption. prev->next should be
> ffff8801742b8178, but
>  was ffffc9000192fec8
>  Nov  8 18:42:57 duo kernel: ------------[ cut here ]------------
>  Nov  8 18:42:57 duo kernel: kernel BUG at
>  /data/fast/l/k/lib/list_debug.c:53!
>  Nov  8 18:42:57 duo kernel: invalid opcode: 0000 [#1] SMP PTI
>  Nov  8 18:42:57 duo kernel: CPU: 2 PID: 1082 Comm: i915/signal:1 Not
>  tainted 4.20.0-rc1+ #3
>  Nov  8 18:42:57 duo kernel: Hardware name: LENOVO 42872WU/42872WU,
>  BIOS 8DET74WW (1.44 ) 03
>  /13/2018
>  Nov  8 18:42:57 duo kernel: RIP:
>  0010:__list_del_entry_valid+0x8e/0x90
>  Nov  8 18:42:57 duo kernel: Code: 66 88 d1 ff 0f 0b 48 89 fe 31 c0 48
>  c7 c7 90 74 5e 85 e8
>  53 88 d1 ff 0f 0b 48 89 fe 31 c0 48 c7 c7 c8 74 5e 85 e8 40 88 d1 ff
>  <0f> 0b 55 48 89 d0 48
>   8b 52 08 48 89 e5 48 39 f2 75 19 48 8b 32 48
>   Nov  8 18:42:57 duo kernel: RSP: 0000:ffffc9000196be78 EFLAGS:
>   00210086
>   Nov  8 18:42:57 duo kernel: RAX: 0000000000000054 RBX:
>   ffff8801742b8178 RCX: 00000000000000
>   00
>   Nov  8 18:42:57 duo kernel: RDX: 0000000000000000 RSI:
>   ffff88019e2a53d8 RDI: ffff88019e2a53
>   d8
>   Nov  8 18:42:57 duo kernel: RBP: ffffc9000196be78 R08:
>   ffff880196e2cd10 R09: 00000000000000
>   00
>   Nov  8 18:42:57 duo kernel: R10: 00000000e7684eb9 R11:
>   3863656632393101 R12: ffffc9000196be
>   c8
>   Nov  8 18:42:57 duo kernel: R13: ffff88019707e000 R14:
>   ffff8801742b8080 R15: ffffc9000192fd
>   d0
>   Nov  8 18:42:57 duo kernel: FS:  0000000000000000(0000)
>   GS:ffff88019e280000(0000) knlGS:000
>   0000000000000
>   Nov  8 18:42:57 duo kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
>   0000000080050033
>   Nov  8 18:42:57 duo kernel: CR2: 00000000ed2bf000 CR3:
>   000000000581e001 CR4: 00000000000606a0
>   Nov  8 18:42:57 duo kernel: Call Trace:
>   Nov  8 18:42:57 duo kernel: intel_breadcrumbs_signaler+0x162/0x330
>   Nov  8 18:42:57 duo kernel: kthread+0x116/0x150
>   Nov  8 18:42:57 duo kernel: ? intel_engine_wakeup+0x40/0x40
>   Nov  8 18:42:57 duo kernel: ? kthread_park+0x90/0x90
>   Nov  8 18:42:57 duo kernel: ret_from_fork+0x35/0x40
>   Nov  8 18:42:57 duo kernel: Modules linked in:
>   Nov  8 18:42:57 duo kernel: ---[ end trace 2f8da183a56f80f6 ]---
>   Nov  8 18:42:57 duo kernel: RIP:
>   0010:__list_del_entry_valid+0x8e/0x90
>   Nov  8 18:42:57 duo kernel: Code: 66 88 d1 ff 0f 0b 48 89 fe 31 c0
>   48 c7 c7 90 74 5e 85 e8 53 88 d1 ff 0f 0b 48 89 fe 31 c0 48 c7 c7 c8
>   74 5e 85 e8 40 88 d1 ff <0f> 0b 55 48 89 d0 48 8b 52 08 48 89 e5 48
>   39 f2 75 19 48 8b 32 48
>   Nov  8 18:42:57 duo kernel: RSP: 0000:ffffc9000196be78 EFLAGS:
>   00210086
>   Nov  8 18:42:57 duo kernel: RAX: 0000000000000054 RBX:
>   ffff8801742b8178 RCX: 0000000000000000
>   Nov  8 18:42:57 duo kernel: RDX: 0000000000000000 RSI:
>   ffff88019e2a53d8 RDI: ffff88019e2a53d8
>   Nov  8 18:42:57 duo kernel: RBP: ffffc9000196be78 R08:
>   ffff880196e2cd10 R09: 0000000000000000
>   Nov  8 18:42:57 duo kernel: R10: 00000000e7684eb9 R11:
>   3863656632393101 R12: ffffc9000196bec8
>   Nov  8 18:42:57 duo kernel: R13: ffff88019707e000 R14:
>   ffff8801742b8080 R15: ffffc9000192fdd0
>   Nov  8 18:42:57 duo kernel: FS:  0000000000000000(0000)
>   GS:ffff88019e280000(0000) knlGS:0000000000000000
>   Nov  8 18:42:57 duo kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
>   0000000080050033
>   Nov  8 18:42:57 duo kernel: CR2: 00000000ed2bf000 CR3:
>   000000000581e001 CR4: 00000000000606a0
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
