Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610E7C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8A221571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8A221571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeI0RBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:01:16 -0400
Received: from mail02.iobjects.de ([188.40.134.68]:48716 "EHLO
        mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbeI0RBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:01:16 -0400
Received: from tux.wizards.de (p3EE2F45F.dip0.t-ipconnect.de [62.226.244.95])
        by mail02.iobjects.de (Postfix) with ESMTPSA id 01EA9416066B;
        Thu, 27 Sep 2018 12:43:34 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.wizards.de (Postfix) with ESMTP id 96F0AF0160B;
        Thu, 27 Sep 2018 12:43:33 +0200 (CEST)
Subject: Re: [PATCH 4.18 74/88] drm/atomic: Use drm_drv_uses_atomic_modeset()
 for debugfs creation
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>
References: <20180927090300.631426620@linuxfoundation.org>
 <20180927090309.614592493@linuxfoundation.org>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <42cbbf9c-3076-0c49-36c2-b6fd09628694@applied-asynchrony.com>
Date:   Thu, 27 Sep 2018 12:43:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927090309.614592493@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/27/18 11:03, Greg Kroah-Hartman wrote:
> 4.18-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Lyude Paul <lyude@redhat.com>
> 
> commit 3c499ea0c662e2f38aafbd4f516b08aab8cfa0e5 upstream.
> 
> As pointed out by Daniel Vetter, we should be usinng
> drm_drv_uses_atomic_modeset() for determining whether or not we want to
> make the debugfs nodes for atomic instead of checking DRIVER_ATOMIC, as
> the former isn't an accurate representation of whether or not the driver
> is actually using atomic modesetting internally (even though it might
> not be exposing atomic capabilities).
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: stable@vger.kernel.org
> Reviewed-by: Sean Paul <seanpaul@chromium.org>
> Link: https://patchwork.freedesktop.org/patch/msgid/20180917173733.21293-1-lyude@redhat.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This patch breaks switching the console to high resolution during boot on my
workstation with a Radeon card; it worked fine with 4.18.10 and reverting it
fixes the problem:

Sep 27 12:21:49 ragnarok kernel: [drm] radeon kernel modesetting enabled.
Sep 27 12:21:49 ragnarok kernel: checking generic (e0000000 500000) vs hw (e0000000 10000000)
Sep 27 12:21:49 ragnarok kernel: fb: switching to radeondrmfb from VESA VGA
Sep 27 12:21:49 ragnarok kernel: Console: switching to colour dummy device 80x25
Sep 27 12:21:49 ragnarok kernel: BUG: unable to handle kernel NULL pointer dereference at 0000000000000028
Sep 27 12:21:49 ragnarok kernel: PGD 0 P4D 0
Sep 27 12:21:49 ragnarok kernel: Oops: 0000 [#1] SMP
Sep 27 12:21:49 ragnarok kernel: CPU: 2 PID: 2157 Comm: systemd-udevd Not tainted 4.18.11 #1
Sep 27 12:21:49 ragnarok kernel: Hardware name: Gigabyte Technology Co., Ltd. P67-DS3-B3/P67-DS3-B3, BIOS F1 05/06/2011
Sep 27 12:21:49 ragnarok kernel: RIP: 0010:drm_debugfs_init+0xa6/0x1b0 [drm]
Sep 27 12:21:49 ragnarok kernel: Code: 00 48 89 d9 48 89 c2 be 03 00 00 00 48 c7 c7 40 9d 15 a0 e8 8c fb ff ff 89 c5 85 c0 0f 85 84 00 00 00 49 8b 84 24 90 03 00 00 <48> 83 78 28 00 74 10 48 89 df e8 fb 06 ff ff 85 c0 0f 85 92 00 00
Sep 27 12:21:49 ragnarok kernel: RSP: 0018:ffffc900020dfaa0 EFLAGS: 00010246
Sep 27 12:21:49 ragnarok kernel: RAX: 0000000000000000 RBX: ffff8805fdbe64e0 RCX: 0000000000000000
Sep 27 12:21:49 ragnarok kernel: RDX: ffff8806033fe780 RSI: 0000000000000100 RDI: ffff8805fdbe6510
Sep 27 12:21:49 ragnarok kernel: RBP: 0000000000000000 R08: ffff880600d87c38 R09: 0000000000000000
Sep 27 12:21:49 ragnarok kernel: R10: ffffc900020dfa20 R11: ffffc900020dfaab R12: ffff8806000ee800
Sep 27 12:21:49 ragnarok kernel: R13: 0000000000000080 R14: 0000000000000000 R15: ffff8805fdbe6408
Sep 27 12:21:49 ragnarok kernel: FS:  00007fc81fb3c800(0000) GS:ffff88061f480000(0000) knlGS:0000000000000000
Sep 27 12:21:49 ragnarok kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Sep 27 12:21:49 ragnarok kernel: CR2: 0000000000000028 CR3: 00000006003bf002 CR4: 00000000000606e0
Sep 27 12:21:49 ragnarok kernel: Call Trace:
Sep 27 12:21:49 ragnarok kernel:  ? pci_conf1_read+0xa4/0x100
Sep 27 12:21:49 ragnarok kernel:  ? pci_bus_read_config_word+0x43/0x70
Sep 27 12:21:49 ragnarok kernel:  drm_minor_register+0x4c/0xe0 [drm]
Sep 27 12:21:49 ragnarok kernel:  drm_dev_register+0x32/0x140 [drm]
Sep 27 12:21:49 ragnarok kernel:  drm_get_pci_dev+0x90/0x170 [drm]
Sep 27 12:21:49 ragnarok kernel:  pci_device_probe+0xc8/0x140
Sep 27 12:21:49 ragnarok kernel:  driver_probe_device+0x21e/0x2d0
Sep 27 12:21:49 ragnarok kernel:  __driver_attach+0xb1/0xd0
Sep 27 12:21:49 ragnarok kernel:  ? driver_probe_device+0x2d0/0x2d0
Sep 27 12:21:49 ragnarok kernel:  bus_for_each_dev+0x73/0xb0
Sep 27 12:21:49 ragnarok kernel:  bus_add_driver+0x19c/0x1e0
Sep 27 12:21:49 ragnarok kernel:  ? 0xffffffffa02b3000
Sep 27 12:21:49 ragnarok kernel:  driver_register+0x6b/0xb0
Sep 27 12:21:49 ragnarok kernel:  ? 0xffffffffa02b3000
Sep 27 12:21:49 ragnarok kernel:  do_one_initcall+0x43/0x1af
Sep 27 12:21:49 ragnarok kernel:  ? _cond_resched+0x15/0x30
Sep 27 12:21:49 ragnarok kernel:  ? kmem_cache_alloc_trace+0x15c/0x1c0
Sep 27 12:21:49 ragnarok kernel:  do_init_module+0x5a/0x210
Sep 27 12:21:49 ragnarok kernel:  load_module+0x2149/0x2660
Sep 27 12:21:49 ragnarok kernel:  ? xfs_file_read_iter+0x64/0xc0
Sep 27 12:21:49 ragnarok kernel:  ? __se_sys_finit_module+0xb1/0xd0
Sep 27 12:21:49 ragnarok kernel:  __se_sys_finit_module+0xb1/0xd0
Sep 27 12:21:49 ragnarok kernel:  do_syscall_64+0x3e/0xe0
Sep 27 12:21:49 ragnarok kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Sep 27 12:21:49 ragnarok kernel: RIP: 0033:0x7fc81e999cc9
Sep 27 12:21:49 ragnarok kernel: Code: 00 00 00 75 05 48 83 c4 18 c3 e8 92 98 01 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 97 91 2c 00 f7 d8 64 89 01 48
Sep 27 12:21:49 ragnarok kernel: RSP: 002b:00007ffe7ab81f58 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
Sep 27 12:21:49 ragnarok kernel: RAX: ffffffffffffffda RBX: 0000556a340e2ae0 RCX: 00007fc81e999cc9
Sep 27 12:21:49 ragnarok kernel: RDX: 0000000000000000 RSI: 00007fc81f75211d RDI: 0000000000000017
Sep 27 12:21:49 ragnarok kernel: RBP: 00007fc81f75211d R08: 0000000000000000 R09: 00007ffe7ab82070
Sep 27 12:21:49 ragnarok kernel: R10: 0000000000000017 R11: 0000000000000246 R12: 0000000000000000
Sep 27 12:21:49 ragnarok kernel: R13: 0000556a340ebdf0 R14: 0000000000020000 R15: 000000000aba9500
Sep 27 12:21:49 ragnarok kernel: Modules linked in: videobuf2_vmalloc x86_pkg_temp_thermal videobuf2_memops videobuf2_v4l2 snd_hwdep coretemp snd_usbmidi_lib videodev snd_rawmidi radeon(+) kvm_intel videobuf2_common snd_seq_device usbhid(+) i2c_algo_bit kvm drm_kms_helper snd_hda_codec_realtek irqbypass syscopyarea snd_hda_codec_generic sysfillrect snd_hda_codec_hdmi sysimgblt pcbc fb_sys_fops mq_deadline aesni_intel snd_hda_intel ttm aes_x86_64 crypto_simd cryptd glue_helper snd_hda_codec drm snd_hda_core i2c_i801 snd_pcm drm_panel_orientation_quirks i2c_core snd_timer parport_pc backlight snd r8169 soundcore mii parport
Sep 27 12:21:49 ragnarok kernel: CR2: 0000000000000028
Sep 27 12:21:49 ragnarok kernel: ---[ end trace 2f2cb8be562d405e ]---
Sep 27 12:21:49 ragnarok kernel: RIP: 0010:drm_debugfs_init+0xa6/0x1b0 [drm]
Sep 27 12:21:49 ragnarok kernel: Code: 00 48 89 d9 48 89 c2 be 03 00 00 00 48 c7 c7 40 9d 15 a0 e8 8c fb ff ff 89 c5 85 c0 0f 85 84 00 00 00 49 8b 84 24 90 03 00 00 <48> 83 78 28 00 74 10 48 89 df e8 fb 06 ff ff 85 c0 0f 85 92 00 00
Sep 27 12:21:49 ragnarok kernel: RSP: 0018:ffffc900020dfaa0 EFLAGS: 00010246
Sep 27 12:21:49 ragnarok kernel: RAX: 0000000000000000 RBX: ffff8805fdbe64e0 RCX: 0000000000000000
Sep 27 12:21:49 ragnarok kernel: RDX: ffff8806033fe780 RSI: 0000000000000100 RDI: ffff8805fdbe6510
Sep 27 12:21:49 ragnarok kernel: RBP: 0000000000000000 R08: ffff880600d87c38 R09: 0000000000000000
Sep 27 12:21:49 ragnarok kernel: R10: ffffc900020dfa20 R11: ffffc900020dfaab R12: ffff8806000ee800
Sep 27 12:21:49 ragnarok kernel: R13: 0000000000000080 R14: 0000000000000000 R15: ffff8805fdbe6408
Sep 27 12:21:49 ragnarok kernel: FS:  00007fc81fb3c800(0000) GS:ffff88061f480000(0000) knlGS:0000000000000000
Sep 27 12:21:49 ragnarok kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Sep 27 12:21:49 ragnarok kernel: CR2: 0000000000000028 CR3: 00000006003bf002 CR4: 00000000000606e0
Sep 27 12:21:49 ragnarok kernel: it87: Found IT8728F chip at 0x290, revision 1

Full logs available on request.

cheers,
Holger
