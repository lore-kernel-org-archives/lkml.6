Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549ABC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D4E2086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLrA3JeI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D4E2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeIEUFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 16:05:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37799 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeIEUFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 16:05:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id 2-v6so3627020pgo.4;
        Wed, 05 Sep 2018 08:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zjuC1oj59UuapYMF6AbU3o5VRGd8S5HvraxNfMUY4G4=;
        b=iLrA3JeIrT3KQey4zTbo4pTvHLNDYabBFdQoM1DR6M3sTkcq3J7I+1GZ6YusWRMHZe
         YxFYOZniDKBg453iby254bUe9yzbmZGiXKboRApJBS5oER2+ZB15kcvAve9bpuLfbjDA
         JkVW3erLpDcji3HcOSSyAMySZltVMPgUcgpukDJ1zutjhwojUbIRoydVklf/BcqXpKTQ
         VduHrTnNSWNGzHZQKtqQIW0jrmNV0ljjGR9IcNofBXeg4RMmujH9WvrkgzyrLWouiB1F
         TO7v0i3ZhgD9M46H+OnH5CYWnujcBMVg2cdCykgJ2nK+KCyCdBobUsCNATNOCuBL8YkP
         NiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zjuC1oj59UuapYMF6AbU3o5VRGd8S5HvraxNfMUY4G4=;
        b=ZG+1RwljkTNgNQvVrBmRkyjq09djaEeQFx8vbAFvYA7TDT9VAy5IXEEEuHwUgn7TnJ
         V2c0CUQrEW2S+Qj7eGG1co9kYUyTnKm/hyv2ROdEB5MsAicY0tjCyjEyvD11WoQLbRI8
         pQnJ7ElneD2Lp0AQaAzhSQHqMC6u6JHGE4wRMPyTW7esu30Qch+XxQBzFML1V8ImrthE
         Gt3b4hAJNGPETDQjIobcgYC6RfQLWq0JfknpLJ18H8HmxsX1kr+3A88wg2/4VWyT6l8m
         4aJy2F8IyFiwohaa17o5V2ZAnSo55OxB7hrQFTgMrs0nsVbIWDo4Sj4PU3h1e7gvjIoO
         ldDA==
X-Gm-Message-State: APzg51DYa6qK0LettdwfTwV02LhbiL6P3urRvRFUdByWpIYrbr5UJA1T
        xE8oIw+2vaUsJjeQMbFXwviYP3k6
X-Google-Smtp-Source: ANB0VdYNCfwCx+7EQDiG7uW7+ZgZhgI+cLCjsMGr6zQEjX9ex5CXmI2WE4qFp1czaRB0+lt4Z+vz/g==
X-Received: by 2002:a62:5d89:: with SMTP id n9-v6mr41394749pfj.102.1536161666727;
        Wed, 05 Sep 2018 08:34:26 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id u83-v6sm7812208pfj.37.2018.09.05.08.34.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 08:34:25 -0700 (PDT)
Subject: Re: [PATCH 4.18 000/123] 4.18.6-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180903165719.499675257@linuxfoundation.org>
 <20180904162434.GA16396@roeck-us.net> <20180905090110.GC30538@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <7d4d11ab-c769-44b4-0037-d1be7f45e2c8@roeck-us.net>
Date:   Wed, 5 Sep 2018 08:34:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905090110.GC30538@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2018 02:01 AM, Greg Kroah-Hartman wrote:
> On Tue, Sep 04, 2018 at 09:24:34AM -0700, Guenter Roeck wrote:
>> On Mon, Sep 03, 2018 at 06:55:44PM +0200, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 4.18.6 release.
>>> There are 123 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Wed Sep  5 16:56:53 UTC 2018.
>>> Anything received after that time might be too late.
>>>
>>
>> Not directly related to v4.18.6-rc1. I have seen the following hang
>> several times with v4.18.5. It happens on a quite regular basis after
>> a suspend-resume cycle. CPU is Ryzen 1700X.
>>
>> Guenter
>>
>> ---
>> [ 9990.754641] watchdog: BUG: soft lockup - CPU#5 stuck for 22s! [kworker/5:1:155]
>> [ 9990.762549] Modules linked in: ipt_REJECT nf_reject_ipv4 xt_multiport sp5100_tco squashfs iptable_filter snd_hda_codec_hdmi binfmt_misc edac_mce_amd kvm snd_hda_codec_realtek irqbypass snd_hda_codec_generic snd_seq_midi snd_seq_midi_event crct10dif_pclmul ghash_clmulni_intel snd_rawmidi aesni_intel snd_hda_intel aes_x86_64 crypto_simd cryptd glue_helper snd_hda_codec snd_hda_core wmi_bmof snd_hwdep snd_seq snd_pcm k10temp snd_seq_device snd_timer snd soundcore sch_fq_codel parport_pc sunrpc ppdev lp parport ip_tables x_tables autofs4 hid_generic nouveau mxm_wmi video ttm drm_kms_helper usbhid syscopyarea sysfillrect hid sysimgblt igb fb_sys_fops dca drm i2c_algo_bit i2c_piix4 i2c_core r8169 ahci mii libahci wmi
>> [ 9990.762589] CPU: 5 PID: 155 Comm: kworker/5:1 Tainted: G             L    4.18.5+ #1
>> [ 9990.762591] Hardware name: Gigabyte Technology Co., Ltd. AB350M-Gaming 3/AB350M-Gaming 3-CF, BIOS F23 08/08/2018
>> [ 9990.762596] Workqueue: events free_work
>> [ 9990.762601] RIP: 0010:smp_call_function_many+0x208/0x270
>> [ 9990.762601] Code: e8 0d d1 77 00 3b 05 cb f0 24 01 0f 83 86 fe ff ff 48 63 d0 49 8b 0c 24 48 03 0c d5 00 f7 11 a7 8b 51 18 83 e2 01 74 0a f3 90 <8b> 51 18 83 e2 01 75 f6 eb c7 0f b6 4d d0 4c 89 f2 4c 89 ee 44 89
>> [ 9990.762626] RSP: 0018:ffff95ebc3effd20 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
>> [ 9990.762628] RAX: 000000000000000c RBX: ffff94eeded63cc8 RCX: ffff94eedef27bc0
>> [ 9990.762629] RDX: 0000000000000001 RSI: 0000000000000100 RDI: ffff94eeded63cc8
>> [ 9990.762630] RBP: ffff95ebc3effd60 R08: 00000000fffffff0 R09: 00000000000000ff
>> [ 9990.762631] R10: ffff94eeded63ce8 R11: ffff94eeded63cc8 R12: ffff94eeded63cc0
>> [ 9990.762632] R13: ffffffffa6076150 R14: 0000000000000000 R15: 0000000000000100
>> [ 9990.762633] FS:  0000000000000000(0000) GS:ffff94eeded40000(0000) knlGS:0000000000000000
>> [ 9990.762635] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 9990.762636] CR2: 0000000000a67000 CR3: 00000006f120c000 CR4: 00000000003406e0
>> [ 9990.762637] Call Trace:
>> [ 9990.762642]  ? load_new_mm_cr3+0xe0/0xe0
>> [ 9990.762644]  on_each_cpu+0x2d/0x60
>> [ 9990.762647]  flush_tlb_kernel_range+0x4b/0x80
>> [ 9990.762648]  ? vunmap_page_range+0x1fe/0x310
>> [ 9990.762650]  __purge_vmap_area_lazy+0x50/0xb0
>> [ 9990.762652]  free_vmap_area_noflush+0x7d/0x90
>> [ 9990.762654]  remove_vm_area+0x74/0x80
>> [ 9990.762656]  __vunmap+0x3b/0xc0
>> [ 9990.762657]  free_work+0x25/0x40
>> [ 9990.762660]  process_one_work+0x15e/0x3f0
>> [ 9990.762662]  worker_thread+0x4a/0x440
>> [ 9990.762664]  kthread+0x105/0x140
>> [ 9990.762666]  ? process_one_work+0x3f0/0x3f0
>> [ 9990.762668]  ? kthread_destroy_worker+0x50/0x50
>> [ 9990.762670]  ret_from_fork+0x22/0x40
> 
> Odd.  Do you see this on Linus's tree?
> 

Not tested, but I see it in v4.17.19 and in v4.18.6-rc2. Turns out it is
related to heavy load, not to suspend/resume. At this point I suspect that
it may be an AMD/Ryzen specific problem - it looks like it disappears if I
add "kernel.randomize_va_space = 0" to /etc/sysctl.conf. No idea if it is a
CPU bug or some AMD specific code problem. I'll try to analyze it further.

Either case, it is not a concern for the current release since it affects
other kernel versions.

Guenter
