Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D8EC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115E220850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 115E220850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeLEMpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:45:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbeLEMpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:45:41 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C9CE8307B960;
        Wed,  5 Dec 2018 12:45:40 +0000 (UTC)
Received: from krava (unknown [10.43.17.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 492F6105B1E4;
        Wed,  5 Dec 2018 12:45:39 +0000 (UTC)
Date:   Wed, 5 Dec 2018 13:45:38 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: perf: perf_fuzzer triggers GPF in perf_prepare_sample
Message-ID: <20181205124538.GA19343@krava>
References: <alpine.DEB.2.21.1812041039220.19558@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812041039220.19558@macbook-air>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 05 Dec 2018 12:45:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 10:54:55AM -0500, Vince Weaver wrote:
> Hello,
> 
> I was able to trigger another oops with the perf_fuzzer with current git.
> 
> This is 4.20-rc5 after the fix for the very similar oops I previously 
> reported got committed.
> 
> It seems to be pointing to the same location in the source as 
> before, I guess maybe triggered a different way?

nice.. yep, looks the same

> 
> Unfortunately this crash is not easily reproducible like the last one was.

will check

jirka

> 
> kernel/events/core.c:6393
> 
> if (sample_type & PERF_SAMPLE_CALLCHAIN) {
>                 int size = 1;
> 
>                 if (!(sample_type & __PERF_SAMPLE_CALLCHAIN_EARLY))
>                         data->callchain = perf_callchain(event, regs);
> 
> >>>>>>>>>       size += data->callchain->nr;
> 
>                 header->size += size * sizeof(u64);
>         }
> 
> 
> Vince
> 
> [45050.698745] general protection fault: 0000 [#1] SMP PTI
> [45050.698745] CPU: 5 PID: 13475 Comm: perf_fuzzer Tainted: G        W         4.20.0-rc5 #124
> [45050.698746] Hardware name: LENOVO 10AM000AUS/SHARKBAY, BIOS FBKT72AUS 01/26/2014
> [45050.698746] RIP: 0010:perf_prepare_sample+0x82/0x4a0
> [45050.698746] Code: 06 4c 89 ea 4c 89 e6 e8 3c 54 ff ff 40 f6 c5 01 0f 85 28 01 00 00 40 f6 c5 20 74 1c 48 85 ed 0f 89 04 01 00 00 49 8b 44 24 70 <48> 8b 00 8d 04 c5 08 00 00 00 66 01 43 06 f7 c5 00 04 00 00 74 41
> [45050.698747] RSP: 0000:ffffc900206bfb00 EFLAGS: 00010082
> [45050.698747] RAX: dead000000000200 RBX: ffffc900206bfb58 RCX: 000000000000001f
> [45050.698747] RDX: 0000000000000000 RSI: 0000000025bbf56f RDI: 0000000000000000
> [45050.698748] RBP: 8000000000000275 R08: 0000000000000002 R09: 00000000000215c0
> [45050.698748] R10: 00008b25b2e2f5c8 R11: 0000000000000000 R12: ffffc900206bfc40
> [45050.698748] R13: ffff8880cf6d7800 R14: ffffc900206bfb98 R15: ffff88811ab4f420
> [45050.698748] FS:  00007fab66133500(0000) GS:ffff88811ab40000(0000) knlGS:0000000000000000
> [45050.698749] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [45050.698749] CR2: 00007fab66133480 CR3: 00000000811aa004 CR4: 00000000001607e0
> [45050.698749] DR0: 0000000000000000 DR1: 000000008e8e8000 DR2: 0000000000000000
> [45050.698749] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
> [45050.698750] Call Trace:
> [45050.698750]  intel_pmu_drain_bts_buffer+0x151/0x220
> [45050.698750]  ? mem_cgroup_commit_charge+0x7a/0x510
> [45050.698750]  ? wp_page_copy+0x39e/0x650
> [45050.698750]  ? reuse_swap_page+0x129/0x340
> [45050.698751]  ? _raw_spin_unlock+0xa/0x10
> [45050.698751]  ? do_wp_page+0x30f/0x4d0
> [45050.698751]  ? finish_mkwrite_fault+0x140/0x140
> [45050.698751]  ? __handle_mm_fault+0xb22/0x12c0
> [45050.698751]  intel_pmu_handle_irq+0x6d/0x160
> [45050.698752]  perf_event_nmi_handler+0x2d/0x50
> [45050.698752]  nmi_handle+0x63/0x110
> [45050.698752]  default_do_nmi+0x4e/0x100
> [45050.698752]  do_nmi+0x112/0x170
> [45050.698752]  nmi+0x8b/0xd4
> [45050.698753] RIP: 0033:0x558a6a6366c3
> [45050.698753] Code: 01 d0 48 c1 e0 06 48 89 c2 48 8d 05 cf 93 23 00 48 8b 04 02 48 85 c0 74 11 8b 45 f8 3b 45 f4 75 05 8b 45 fc eb 16 83 45 f8 01 <83> 45 fc 01 81 7d fc 9f 86 01 00 7e 96 b8 ff ff ff ff c9 c3 55 48
> [45050.698753] RSP: 002b:00007ffc9f521660 EFLAGS: 00000246
> [45050.698754] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000030
> [45050.698754] RDX: 000000000000e740 RSI: 00007ffc9f521634 RDI: 00007fab6612c740
> [45050.698754] RBP: 00007ffc9f521670 R08: 00007fab6612c1f0 R09: 00007fab6612c240
> [45050.698754] R10: 00007fab661337d0 R11: 0000000000000246 R12: 0000558a6a6364c0
> [45050.698755] R13: 00007ffc9f523ad0 R14: 0000000000000000 R15: 0000000000000000
> [45050.698755] Modules linked in: intel_rapl x86_pkg_temp_thermal intel_powerclamp snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_intel coretemp tpm_tis snd_hda_codec snd_hda_core kvm_intel tpm_tis_core i915 snd_hwdep kvm tpm snd_pcm rng_core wmi_bmof mei_me sg iosf_mbi irqbypass drm_kms_helper evdev crct10dif_pclmul drm mei iTCO_wdt i2c_algo_bit iTCO_vendor_support snd_timer pcc_cpufreq crc32_pclmul ghash_clmulni_intel aesni_intel snd video aes_x86_64 crypto_simd cryptd glue_helper soundcore pcspkr wmi button binfmt_misc ip_tables x_tables autofs4 sr_mod sd_mod cdrom ahci libahci ehci_pci xhci_pci libata xhci_hcd ehci_hcd lpc_ich mfd_core crc32c_intel scsi_mod e1000e i2c_i801 usbcore usb_common fan thermal[45051.027024] ---[ end trace 9565944010fbdf23 ]---
> [45051.027024] RIP: 0010:perf_prepare_sample+0x82/0x4a0
> [45051.027025] Code: 06 4c 89 ea 4c 89 e6 e8 3c 54 ff ff 40 f6 c5 01 0f 85 28 01 00 00 40 f6 c5 20 74 1c 48 85 ed 0f 89 04 01 00 00 49 8b 44 24 70 <48> 8b 00 8d 04 c5 08 00 00 00 66 01 43 06 f7 c5 00 04 00 00 74 41
> [45051.027025] RSP: 0000:ffffc900206bfb00 EFLAGS: 00010082
> [45051.027025] RAX: dead000000000200 RBX: ffffc900206bfb58 RCX: 000000000000001f
> [45051.027025] RDX: 0000000000000000 RSI: 0000000025bbf56f RDI: 0000000000000000
> [45051.027026] RBP: 8000000000000275 R08: 0000000000000002 R09: 00000000000215c0
> [45051.027026] R10: 00008b25b2e2f5c8 R11: 0000000000000000 R12: ffffc900206bfc40
> [45051.027026] R13: ffff8880cf6d7800 R14: ffffc900206bfb98 R15: ffff88811ab4f420
> [45051.027027] FS:  00007fab66133500(0000) GS:ffff88811ab40000(0000) knlGS:0000000000000000
> [45051.027027] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [45051.027027] CR2: 00007fab66133480 CR3: 00000000811aa004 CR4: 00000000001607e0
> [45051.027027] DR0: 0000000000000000 DR1: 000000008e8e8000 DR2: 0000000000000000
> [45051.027027] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
> [45051.027028] Kernel panic - not syncing: Fatal exception in interrupt
> [45051.027051] Kernel Offset: disabled
> [45051.149441] ---[ end Kernel panic - not syncing: Fatal exception in interrupt]---
