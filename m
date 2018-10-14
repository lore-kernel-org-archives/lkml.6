Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBB2C169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319852083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319852083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbeJPRiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:38:17 -0400
Received: from foss.arm.com ([217.140.101.70]:60866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727148AbeJPRiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:38:15 -0400
Received: by usa-sjc-mx-foss1.foss.arm.com (Postfix, from userid 105)
        id 9D2103646; Tue, 16 Oct 2018 03:23:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97EB83293;
        Sun, 14 Oct 2018 11:00:39 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C6823F5D3;
        Sun, 14 Oct 2018 11:00:23 -0700 (PDT)
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, lorenzo.pieralisi@arm.com,
        John Stultz <john.stultz@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Guodong Xu <guodong.xu@linaro.org>,
        Quentin Perret <quentin.perret@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Subject: [BUG] hikey960: psci: Failure to boot CPU after hotplug
Message-ID: <cf313cf7-c416-2693-8a9d-0d6f122f2018@arm.com>
Date:   Sun, 14 Oct 2018 19:00:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I was cleaning up some hotplug torture test, and happened to run that on my
HiKey960 which resulted in a failure.

Turns out just a few hotplug operations are needed to trigger this, so I
boiled it down to this small script:

for ((i = 0; i < 4; i++)); do
    echo "OFF $i"
    echo 0 > /sys/devices/system/cpu/cpu$i/online
    echo "ON $i"
    echo 1 > /sys/devices/system/cpu/cpu$i/online
    echo
done

Running this results in:

----->8-----
OFF 0
[   80.819925] CPU0: shutdown
[   80.823851] psci: CPU0 killed.
ON 0
[   80.841609] Detected VIPT I-cache on CPU0
[   80.845730] CPU0: Booted secondary processor 0x0000000000 [0x410fd034]

OFF 1
[   80.927340] CPU1: shutdown
[   80.930204] psci: CPU1 killed.
ON 1
[   80.948701] Detected VIPT I-cache on CPU1
[   80.952810] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]

OFF 2
[   81.023079] CPU2: shutdown
[   81.026465] psci: CPU2 killed.
ON 2
[   81.036281] Detected VIPT I-cache on CPU2
[   81.040402] CPU2: Booted secondary processor 0x0000000002 [0x410fd034]

OFF 3
[   81.103528] CPU3: shutdown
[   81.106382] psci: CPU3 killed.
ON 3
[   81.121835] Detected VIPT I-cache on CPU3
[   81.125975] CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
----->8-----


Now, if I run this for CPUs [4-7], I eventually get this (takes a few tries):


----->8-----
OFF 4
[   73.149855] CPU4: shutdown
[   73.152628] psci: CPU4 killed.
ON 4
[   73.157491] Detected VIPT I-cache on CPU4
[   73.161509] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1. Boot CPU: 0x00000000001122, CPU4: 0x00000000101122
[   73.173813] arch_timer: CPU4: Trapping CNTVCT access
[   73.178782] CPU4: Booted secondary processor 0x0000000100 [0x410fd091]

OFF 5
[   73.261245] CPU5: shutdown
[   73.264043] psci: CPU5 killed.
ON 5
[   74.272375] CPU5: failed to come online
[   74.276264] CPU5: failed in unknown state : 0x0
./hotplug.sh: line 8: echo: write error: Input/output error

OFF 6
[   74.311066] CPU6: shutdown
[   74.313829] psci: CPU6 killed.
ON 6
[   74.318544] Detected VIPT I-cache on CPU6
[   74.322590] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1. Boot CPU: 0x00000000001122, CPU6: 0x00000000101122
[   74.334884] arch_timer: CPU6: Trapping CNTVCT access
[   74.339854] CPU6: Booted secondary processor 0x0000000102 [0x410fd091]

OFF 7
[   74.394989] CPU7: shutdown
[   74.397770] psci: CPU7 killed.
ON 7
[   74.402295] Detected VIPT I-cache on CPU7
[   74.406475] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64MMFR0_EL1. Boot CPU: 0x00000000001122, CPU7: 0x00000000101122
[   74.418748] arch_timer: CPU7: Trapping CNTVCT access
[   74.423709] CPU7: Booted secondary processor 0x0000000103 [0x410fd091]
----->8-----


Trying to online CPU5 yet again yields a slightly different result:


----->8-----
[   74.528657] psci: failed to boot CPU5 (-22)
[   74.534577] CPU5: failed to boot: -22
[   74.538291] CPU5: failed in unknown state : 0x0
./hotplug.sh: line 8: echo: write error: Invalid argument
----->8-----

It doesn't seem tied to any particular big CPU - I've that happen for 4 & 7.
It happens both on mainline (4.19-rc7, 3a27203102eb) and on linux-next
(774ea0551a29). I tried bisecting this but it's a bit tricky since the
mainline support for HiKey960 is relatively recent - as far as I can tell,
that issue has always been there on this board.

I wanted to have a bit of fun and investigate that myself, but psci is alien
to me and I don't really know where to look at past "psci_cpu_on()".

I'm running UEFI/ATF on that board, if that's of any help.


Cheers,
Valentin
