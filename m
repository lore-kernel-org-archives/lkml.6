Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4284C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 02:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A20020672
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 02:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="IN1thfNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A20020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maine.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbeLICIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 21:08:36 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34987 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbeLICIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 21:08:36 -0500
Received: by mail-qt1-f195.google.com with SMTP id v11so8795751qtc.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 18:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=0rF/WjAItrk8K4ajFskKX1TEkAl5p2pRV8B8uQdh7vg=;
        b=IN1thfNG581qcM6CId5mvDta8tsJ2ASqIB/nOqXZIdBurgUuOpl+BqfH0925G81Y4d
         U/NnnCm+K9qKQqOKg3S6oPI3Vi6SVhvbkl0p5wVxdaa4CydnzeBWKFHO6K9w747LL0iR
         vs5gOI8r4OFNHPV1V0ydXpJtvoUZBSOlrofgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=0rF/WjAItrk8K4ajFskKX1TEkAl5p2pRV8B8uQdh7vg=;
        b=P3dU0ZWTymB1YSyhU/61ocKjCEkbS5ls7qguyqGAyfR5nyUzZyW88FG78+MYmn1NYF
         5dJ4W9VdGzLsRUi7lFp7sRhwbHo5fbuZkL3wNvr/ekrSJszOW658ZnOTZVpKPmxN/ZNm
         /zhdg8NKWj+hZYFeHk3cjv8gs8DpISsUsOXeoJnWPopaNqGrTAynuurw/WTK1qYacudu
         9GhcHoBwOiMye9XTuhrqZc8O426BIcBqB5SVu+uWqWqxPKf5X3lmQo8q50k40WjG6qpz
         Qe7XtJf42u0QGAmUMQ/n6Uxx74pCH8pOgNCuY84UIc7k/DuecMZouhcb5GVgeLCiKNWO
         c0MQ==
X-Gm-Message-State: AA+aEWYR9yke2ehaTleuSSQyUmFQorFJvjxZVuUZ6799sICiN83yiQgh
        KHGgUHi1gEg3p0kPHVx/bvhyAw==
X-Google-Smtp-Source: AFSGD/XsPbR8Yyo5lBhRDxV4g6EE6Gh7ztdwZEif0Z3DFTjb/+4b8hXWBpd26Jorko7/5LjTRRmr+Q==
X-Received: by 2002:a0c:8382:: with SMTP id k2mr7258303qva.0.1544321314407;
        Sat, 08 Dec 2018 18:08:34 -0800 (PST)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id h35sm4574467qth.59.2018.12.08.18.08.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Dec 2018 18:08:33 -0800 (PST)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Sat, 8 Dec 2018 21:08:28 -0500 (EST)
X-X-Sender: vince@macbook-air
To:     Jiri Olsa <jolsa@redhat.com>
cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <andi@firstfloor.org>
Subject: Re: perf: perf_fuzzer triggers GPF in perf_prepare_sample
In-Reply-To: <20181206154425.GA21381@krava>
Message-ID: <alpine.DEB.2.21.1812082105500.12282@macbook-air>
References: <alpine.DEB.2.21.1812041039220.19558@macbook-air> <20181205124538.GA19343@krava> <20181205163838.GA3836@krava> <alpine.DEB.2.21.1812051208580.29892@macbook-air> <20181205183326.GE3836@krava> <alpine.DEB.2.21.1812061033180.2368@macbook-air>
 <20181206154425.GA21381@krava>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018, Jiri Olsa wrote:

> On Thu, Dec 06, 2018 at 10:35:28AM -0500, Vince Weaver wrote:
> > On Wed, 5 Dec 2018, Jiri Olsa wrote:
> > Maybe it is a corruption issue.  I had applied my own debug patch that 
> > would dump some info if data->callchain was NULL.
> > 
> > But my debug code didn't trigger this time because it looks like 
> > data->callchain was "1" rather than "0".
> > 
> > [27764.840179] BUG: unable to handle kernel NULL pointer dereference at 0000000000000001
> > [27764.840179] PGD 0 P4D 0 
> > [27764.840180] Oops: 0000 [#1] SMP PTI
> > [27764.840180] CPU: 1 PID: 18687 Comm: perf_fuzzer Tainted: G        W         4.20.0-rc5+ #125
> > [27764.840180] Hardware name: LENOVO 10AM000AUS/SHARKBAY, BIOS FBKT72AUS 01/26/2014
> 
> actually, you could try that patch from my previous email?
> 
still crashes with your patch (see below)

I've also been able to replicate this crash on a skylake machine in 
addition to the haswell machine.

Vince

[28269.147232] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
[28269.155628] PGD 0 P4D 0 
[28269.158360] Oops: 0000 [#1] SMP PTI
[28269.162087] CPU: 0 PID: 1189 Comm: perf_fuzzer Tainted: G        W         4.20.0-rc5+ #128
[28269.171011] Hardware name: LENOVO 10AM000AUS/SHARKBAY, BIOS FBKT72AUS 01/26/2014
[28269.178935] RIP: 0010:perf_prepare_sample+0x82/0x4a0
[28269.184239] Code: 06 4c 89 ea 4c 89 e6 e8 3c 54 ff ff 40 f6 c5 01 0f 85 28 01 00 00 40 f6 c5 20 74 1c 48 85 ed 0f 89 04 01 00 00 49 8b 44 24 70 <48> 8b 00 8d 04 c5 08 00 00 00 66 01 43 06 f7 c5 00 04 00 00 74 41
[28269.204249] RSP: 0000:ffffc9000aca7a40 EFLAGS: 00010082
[28269.209832] RAX: 0000000000000000 RBX: ffffc9000aca7a98 RCX: ffffc9000aca7ad8
[28269.217484] RDX: 0000000000000000 RSI: ffffc9000aca7b80 RDI: ffffc9000aca7a9e
[28269.225129] RBP: 80000000000bb068 R08: 0000000000000002 R09: 00000000000215c0
[28269.232760] R10: ffff8880ce552000 R11: 0000000000000000 R12: ffffc9000aca7b80
[28269.240380] R13: ffff88803696c800 R14: ffffc9000aca7ad8 R15: ffffe8ffffc06300
[28269.248014] FS:  00007f5927fe7500(0000) GS:ffff88811aa00000(0000) knlGS:0000000000000000
[28269.256606] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[28269.262739] CR2: 0000000000000000 CR3: 0000000116d98001 CR4: 00000000001607f0
[28269.270349] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[28269.277968] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
[28269.285639] Call Trace:
[28269.288266]  intel_pmu_drain_bts_buffer+0x151/0x220
[28269.293476]  ? radix_tree_delete_item+0x69/0xc0
[28269.298378]  x86_pmu_stop+0x3b/0x90
[28269.302113]  x86_pmu_del+0x57/0x160
[28269.305840]  event_sched_out.isra.106+0x81/0x170
[28269.310780]  group_sched_out.part.108+0x51/0xc0
[28269.315634]  ctx_sched_out+0xf8/0x220
[28269.319551]  __perf_event_task_sched_out+0x18d/0x3f0
[28269.324866]  ? pick_next_task_fair+0x60a/0x660
[28269.329639]  __schedule+0x4b9/0x820
[28269.333367]  ? kill_pid_info+0x34/0x50
[28269.337360]  schedule+0x28/0x80
[28269.340725]  exit_to_usermode_loop+0x4e/0xc0
[28269.345272]  prepare_exit_to_usermode+0x53/0x80
[28269.350109]  retint_user+0x8/0x8
[28269.353541] RIP: 0033:0x56154980b6c3
[28269.357346] Code: 01 d0 48 c1 e0 06 48 89 c2 48 8d 05 cf 93 23 00 48 8b 04 02 48 85 c0 74 11 8b 45 f8 3b 45 f4 75 05 8b 45 fc eb 16 83 45 f8 01 <83> 45 fc 01 81 7d fc 9f 86 01 00 7e 96 b8 ff ff ff ff c9 c3 55 48
[28269.377462] RSP: 002b:00007ffc6a1540a0 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
[28269.385562] RAX: 0000000000000000 RBX: 000000000000000c RCX: 000000000000003c
[28269.393182] RDX: 0000000000b895c0 RSI: 00007ffc6a154074 RDI: 00007f5927fe0740
[28269.400835] RBP: 00007ffc6a1540b0 R08: 00007f5927fe01f0 R09: 00007f5927fe0240
[28269.408452] R10: 0000000000000000 R11: 0000000000000246 R12: 000056154980b4c0
[28269.416080] R13: 00007ffc6a156510 R14: 0000000000000000 R15: 0000000000000000
[28269.423723] Modules linked in: snd_hda_codec_hdmi intel_rapl x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm i915 irqbypass crct10dif_pclmul crc32_pclmul iosf_mbi ghash_clmulni_intel drm_kms_helper aesni_intel snd_hda_codec_realtek aes_x86_64 crypto_simd drm cryptd snd_hda_codec_generic i2c_algo_bit snd_hda_intel evdev glue_helper snd_hda_codec snd_hda_core iTCO_wdt mei_me mei wmi_bmof tpm_tis snd_hwdep tpm_tis_core pcc_cpufreq pcspkr iTCO_vendor_support snd_pcm tpm sg rng_core button snd_timer video snd soundcore wmi binfmt_misc ip_tables x_tables autofs4 sr_mod sd_mod cdrom ahci xhci_pci ehci_pci libahci xhci_hcd ehci_hcd libata usbcore lpc_ich mfd_core e1000e scsi_mod i2c_i801 crc32c_intel usb_common fan thermal
[28269.492702] CR2: 0000000000000000
[28269.496246] ---[ end trace 6775846bfda0f18b ]---
[28269.501186] RIP: 0010:perf_prepare_sample+0x82/0x4a0
[28269.506482] Code: 06 4c 89 ea 4c 89 e6 e8 3c 54 ff ff 40 f6 c5 01 0f 85 28 01 00 00 40 f6 c5 20 74 1c 48 85 ed 0f 89 04 01 00 00 49 8b 44 24 70 <48> 8b 00 8d 04 c5 08 00 00 00 66 01 43 06 f7 c5 00 04 00 00 74 41
[28269.526587] RSP: 0000:ffffc9000aca7a40 EFLAGS: 00010082
[28269.532176] RAX: 0000000000000000 RBX: ffffc9000aca7a98 RCX: ffffc9000aca7ad8
[28269.539805] RDX: 0000000000000000 RSI: ffffc9000aca7b80 RDI: ffffc9000aca7a9e
[28269.547450] RBP: 80000000000bb068 R08: 0000000000000002 R09: 00000000000215c0
[28269.555075] R10: ffff8880ce552000 R11: 0000000000000000 R12: ffffc9000aca7b80
[28269.562694] R13: ffff88803696c800 R14: ffffc9000aca7ad8 R15: ffffe8ffffc06300
[28269.570329] FS:  00007f5927fe7500(0000) GS:ffff88811aa00000(0000) knlGS:0000000000000000
[28269.578960] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[28269.585123] CR2: 0000000000000000 CR3: 0000000116d98001 CR4: 00000000001607f0
[28269.592740] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[28269.600358] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
