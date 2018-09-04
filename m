Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDBCC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE34320867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMfGg0hq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE34320867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeIDUu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:50:27 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36759 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbeIDUu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:50:27 -0400
Received: by mail-pl1-f196.google.com with SMTP id e11-v6so1879621plb.3;
        Tue, 04 Sep 2018 09:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qo3hwmycA7l83BSPEtXvvL9HFR0BRjJRnFoW3Y3LmYQ=;
        b=YMfGg0hq2uWXgPbyCXZ/lIL0ugwzjwLFBW/r/H2BLV9A2i5wAvHBkHkvJezjBlUh2X
         QmxODjYD1zn+7QSKpU2ST05uapJDXDzkNHRgVoH3Cb2vWn7fQdIG5s20/ArUoC7bxl3K
         xokVB2K0Wu9GdWV2zInMacnDAJ9N3yMtb4rsYDgoIgChlSBMrFYeQY2S/69S0Nz/qqRD
         NjFWG/yjTmKNDW3YnOu0V9jS/0FIoYg49xTiatq3j1yOhAXEc3aJvwHe1hY6wMPidJba
         VEQz8GD7YMkFAKWFR2ck3pjFGRnHLE8d3tsTUuUI599fa0wMV2id32bnYvubhv7sS28c
         1mNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qo3hwmycA7l83BSPEtXvvL9HFR0BRjJRnFoW3Y3LmYQ=;
        b=hJ7YNxyq6PIGteov+MqzjuTqkHq1TDDfruVJqMo+OhtHdC+KQwNTuPjsjtQWwIpv9R
         U77jrRGU0vt168Y3bs4JuCCtIZRCeXNSqBWiwYxU+2QjdhvxvIFz5saw6hm4prx8ulUy
         v1l12RJ9d51mBkOrbtjuhe3ACPKmx1ZgmUoYASj8Wtce7dVqrhuahdYcRML/E6NeclQQ
         3AS+GovSNVOGMPezsueM/bGW0+Wpo+WTIv0z9qKv+mpnIp5aw8zvlepe83XJ28BGKS9Y
         uuX2innxBOzHkbEPXjaxgE0yS7DIDSO06F49cpxBX4DRpk+OqD27TWpcC5fU/PtKX8k+
         hFuw==
X-Gm-Message-State: APzg51B21cIKcb3PSeEHHtJ/zdI7CiUhZ5olxPJPROQUDTc6RLG7LVAj
        39sV7QbZ1oFMiYdhb1u5ow5qxTBU
X-Google-Smtp-Source: ANB0VdZgcYDrzIwvcPgPKA+nw8JsJQJnGmnN5KRjAsY/m/cF5awp9f4/X8dYF+vVdvon73j6vgcGbQ==
X-Received: by 2002:a17:902:bb08:: with SMTP id l8-v6mr33936539pls.71.1536078276965;
        Tue, 04 Sep 2018 09:24:36 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id o62-v6sm28006598pfb.0.2018.09.04.09.24.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 09:24:36 -0700 (PDT)
Date:   Tue, 4 Sep 2018 09:24:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.18 000/123] 4.18.6-stable review
Message-ID: <20180904162434.GA16396@roeck-us.net>
References: <20180903165719.499675257@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 06:55:44PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.18.6 release.
> There are 123 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Sep  5 16:56:53 UTC 2018.
> Anything received after that time might be too late.
> 

Not directly related to v4.18.6-rc1. I have seen the following hang
several times with v4.18.5. It happens on a quite regular basis after
a suspend-resume cycle. CPU is Ryzen 1700X.

Guenter

---
[ 9990.754641] watchdog: BUG: soft lockup - CPU#5 stuck for 22s! [kworker/5:1:155]
[ 9990.762549] Modules linked in: ipt_REJECT nf_reject_ipv4 xt_multiport sp5100_tco squashfs iptable_filter snd_hda_codec_hdmi binfmt_misc edac_mce_amd kvm snd_hda_codec_realtek irqbypass snd_hda_codec_generic snd_seq_midi snd_seq_midi_event crct10dif_pclmul ghash_clmulni_intel snd_rawmidi aesni_intel snd_hda_intel aes_x86_64 crypto_simd cryptd glue_helper snd_hda_codec snd_hda_core wmi_bmof snd_hwdep snd_seq snd_pcm k10temp snd_seq_device snd_timer snd soundcore sch_fq_codel parport_pc sunrpc ppdev lp parport ip_tables x_tables autofs4 hid_generic nouveau mxm_wmi video ttm drm_kms_helper usbhid syscopyarea sysfillrect hid sysimgblt igb fb_sys_fops dca drm i2c_algo_bit i2c_piix4 i2c_core r8169 ahci mii libahci wmi
[ 9990.762589] CPU: 5 PID: 155 Comm: kworker/5:1 Tainted: G             L    4.18.5+ #1
[ 9990.762591] Hardware name: Gigabyte Technology Co., Ltd. AB350M-Gaming 3/AB350M-Gaming 3-CF, BIOS F23 08/08/2018
[ 9990.762596] Workqueue: events free_work
[ 9990.762601] RIP: 0010:smp_call_function_many+0x208/0x270
[ 9990.762601] Code: e8 0d d1 77 00 3b 05 cb f0 24 01 0f 83 86 fe ff ff 48 63 d0 49 8b 0c 24 48 03 0c d5 00 f7 11 a7 8b 51 18 83 e2 01 74 0a f3 90 <8b> 51 18 83 e2 01 75 f6 eb c7 0f b6 4d d0 4c 89 f2 4c 89 ee 44 89 
[ 9990.762626] RSP: 0018:ffff95ebc3effd20 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
[ 9990.762628] RAX: 000000000000000c RBX: ffff94eeded63cc8 RCX: ffff94eedef27bc0
[ 9990.762629] RDX: 0000000000000001 RSI: 0000000000000100 RDI: ffff94eeded63cc8
[ 9990.762630] RBP: ffff95ebc3effd60 R08: 00000000fffffff0 R09: 00000000000000ff
[ 9990.762631] R10: ffff94eeded63ce8 R11: ffff94eeded63cc8 R12: ffff94eeded63cc0
[ 9990.762632] R13: ffffffffa6076150 R14: 0000000000000000 R15: 0000000000000100
[ 9990.762633] FS:  0000000000000000(0000) GS:ffff94eeded40000(0000) knlGS:0000000000000000
[ 9990.762635] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9990.762636] CR2: 0000000000a67000 CR3: 00000006f120c000 CR4: 00000000003406e0
[ 9990.762637] Call Trace:
[ 9990.762642]  ? load_new_mm_cr3+0xe0/0xe0
[ 9990.762644]  on_each_cpu+0x2d/0x60
[ 9990.762647]  flush_tlb_kernel_range+0x4b/0x80
[ 9990.762648]  ? vunmap_page_range+0x1fe/0x310
[ 9990.762650]  __purge_vmap_area_lazy+0x50/0xb0
[ 9990.762652]  free_vmap_area_noflush+0x7d/0x90
[ 9990.762654]  remove_vm_area+0x74/0x80
[ 9990.762656]  __vunmap+0x3b/0xc0
[ 9990.762657]  free_work+0x25/0x40
[ 9990.762660]  process_one_work+0x15e/0x3f0
[ 9990.762662]  worker_thread+0x4a/0x440
[ 9990.762664]  kthread+0x105/0x140
[ 9990.762666]  ? process_one_work+0x3f0/0x3f0
[ 9990.762668]  ? kthread_destroy_worker+0x50/0x50
[ 9990.762670]  ret_from_fork+0x22/0x40
