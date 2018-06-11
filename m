Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id zLa0K+FYHltyCAAAmS7hNA
	; Mon, 11 Jun 2018 11:11:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A41F260792; Mon, 11 Jun 2018 11:11:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E8DA4607E4;
	Mon, 11 Jun 2018 11:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E8DA4607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932887AbeFKLL0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 07:11:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:46342 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932405AbeFKLLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:11:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2018 04:11:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,501,1520924400";
   d="scan'208";a="46215217"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by fmsmga007.fm.intel.com with ESMTP; 11 Jun 2018 04:11:23 -0700
Subject: Re: linux 4.17, drivers/mmc/host/sdhci-pci-o2micro.c, crash with
 sdcard >128G
To: jean-luc malet <jeanluc.malet@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAMjKNNM=f5pKgYh+ZAB+hvxeDG5B_5PsYX8YWZMZrmF9qS2DZA@mail.gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <e6ab8c4a-2371-c4a4-a95e-4c72cefa8696@intel.com>
Date: Mon, 11 Jun 2018 14:10:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAMjKNNM=f5pKgYh+ZAB+hvxeDG5B_5PsYX8YWZMZrmF9qS2DZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/18 11:38, jean-luc malet wrote:
> Hi everybody!
> thanks for adding support to my O2 Micro, Inc. Device 8620 in last kernel!!!
> I was looking for it since long time!!!!
> 
> # lspci -kv
> 02:00.0 SD Host controller: O2 Micro, Inc. Device 8620 (rev 01) (prog-if 01)
> Subsystem: Lenovo Device 3800
> Flags: bus master, fast devsel, latency 0, IRQ 17
> Memory at a1001000 (32-bit, non-prefetchable) [size=4K]
> Memory at a1000000 (32-bit, non-prefetchable) [size=2K]
> Capabilities: [6c] Power Management version 3
> Capabilities: [48] MSI: Enable- Count=1/1 Maskable+ 64bit+
> Capabilities: [80] Express Endpoint, MSI 00
> Capabilities: [100] Virtual Channel
> Capabilities: [200] Advanced Error Reporting
> Capabilities: [230] Latency Tolerance Reporting
> Capabilities: [240] L1 PM Substates
> Kernel driver in use: sdhci-pci
> Kernel modules: sdhci_pci
> 
> it works fine with sdcard up to 128G but crash on my samsung 256G evo plus
> card
> (https://www.samsung.com/fr/memory-storage/evo-plus-microsd-card-with-sd-adapter/MB-MC256DAEU/)
> 
> insert 256G card
> #dmesg
> 
>     [94815.892525] mmc0: Tuning timeout, falling back to fixed sampling clock
>     [94815.892627] mmc0: new ultra high speed SDR104 SDXC card at address 0001
>     [94815.893398] mmcblk0: mmc0:0001 EE8QT 239 GiB 
>     [94815.945330] mmc0: Tuning timeout, falling back to fixed sampling clock
> 
> # dd if=/dev/mmcblk0 of=test bs=512 count=1
> 
>     dd: error reading '/dev/mmcblk0': Input/output error
>     0+0 records in
>     0+0 records out
>     0 bytes copied, 42.829 s, 0.0 kB/s
> 
> #dmesg
> 
>     [94825.956285] mmc0: Timeout waiting for hardware interrupt.
>     [94825.956289] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
>     [94825.956297] mmc0: sdhci: Sys addr:  0x00000008 | Version:  0x00000603
>     [94825.956304] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000008
>     [94825.956310] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x0000003b
>     [94825.956316] mmc0: sdhci: Present:   0x01ff0000 | Host ctl: 0x00000017
>     [94825.956322] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
>     [94825.956327] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
>     [94825.956333] mmc0: sdhci: Timeout:   0x0000000a | Int stat: 0x00000000
>     [94825.956339] mmc0: sdhci: Int enab:  0x02ff008b | Sig enab: 0x02ff008b
>     [94825.956344] mmc0: sdhci: AC12 err:  0x00000004 | Slot int: 0x00000000
>     [94825.956350] mmc0: sdhci: Caps:      0x25fcc8bf | Caps_1:   0x00002077
>     [94825.956356] mmc0: sdhci: Cmd:       0x0000123a | Max curr: 0x005800c8
>     [94825.956362] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00000000
>     [94825.956368] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00001b00
>     [94825.956371] mmc0: sdhci: Host ctl2: 0x0000800b
>     [94825.956378] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xfffff208
>     [94825.956380] mmc0: sdhci: ============================================
>     [94826.007314] mmc0: Tuning timeout, falling back to fixed sampling clock
> 
> remove card
> insert 128G card (http://www.toshiba-sdcard.com/microsd/microsd_m302.html)
> #dmesg
> 
>     [95214.753428] mmc0: Tuning timeout, falling back to fixed sampling clock
>     [95214.753530] mmc0: new ultra high speed SDR104 SDXC card at address 1234
>     [95214.754399] mmcblk0: mmc0:1234 SA128 116 GiB 
>     [95214.756474]  mmcblk0: p1
> 
> 
>     # dd if=/dev/mmcblk0 of=test bs=512 count=1
>     1+0 records in
>     1+0 records out
>     512 bytes copied, 0.00209609 s, 244 kB/s
> 
> 
> remove card 
> insert 128G card (samsung 128Gb evo U1 card)
> #dmseg
> 
>     [95438.053427] mmc0: Tuning timeout, falling back to fixed sampling clock
>     [95438.053552] mmc0: new ultra high speed DDR50 SDXC card at address 59b4
>     [95438.054139] mmcblk0: mmc0:59b4 00000 120 GiB 
>     [95438.056451]  mmcblk0: p1
> 
> 
> # dd if=/dev/mmcblk0 of=test bs=512 count=1
> 
>     1+0 records in
>     1+0 records out
>     512 bytes copied, 0.0346192 s, 14.8 kB/s
> 
> 
> since the toshiba a 256G samsung are both U3 this seems not related to this
> since one of the samsung card works, this don't seems to be related to the
> brand....
> so this seems related to the size of the card....
> if you need more information, I'll try to provide the best accurate ones :)

Tuning fails for all the cards, it is just some of them still work with
fixed sampling.  You need to find someone who knows about the O2 Micro
controllers. but no one has touched the driver since 2015.
