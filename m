Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091ACC07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94E72086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ahnLICui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbfARRij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:38:39 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]:33491 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbfARRii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:38:38 -0500
Received: by mail-qk1-f172.google.com with SMTP id d15so8545639qkj.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 09:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m9TdNsiJWv8ps/qWNdEuapktg7N9Z9Bh3MKk9GYgQJA=;
        b=ahnLICuiL8HGdatwwi3KmOfCb7eDucXWps0Xo1esufeMcSpw0tXRF+6HvgYezQVJJc
         xqA1nDva/BRwhsHqAO6my5hAKB3oWddFzBNiX4bD4MekqRnwxP/VOdHa/xzd0gCkrzJ9
         lsQs51Ug8459PJx2Bqyy/P8GVWueB3xtGoblG142bpIpU5TmG4s0/7bwg7iUHKRQ+y08
         esiBQ/5ueSct4DQ9zR7pz+ehu668TvnEsmqJRYj26XuTrJZiPAzanmb0mSpR0qaSAV+W
         tc+smwXIQE4j7bLHu8fPOLticeKTjCJInsar+31E32CrR97j73nskLSLGHlvT0bj/fpL
         FF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m9TdNsiJWv8ps/qWNdEuapktg7N9Z9Bh3MKk9GYgQJA=;
        b=s7PGZbL7smhpKb3gAbu+eTF2gMiwGfOctGIiPwpsXsKbuY+UUrmLdiAbIhA40uZ9SM
         m8I/I5Jf0j4MrtkXdZ7ne1EUtmWzenLtkRAM08k8KVSAQ6YdjNpvnl/G0fuYhjDT3UzG
         mFzEo2QU8ZDW8S1Nnb5V2LH+vvo+1G0FQM8I8qCQlJNkzimvFMnBHCltlUqi9ommqG2f
         4bTZPwUrcEEeHf+zngCScbmX3cUIdu3TRxksx21oF0mwRQyTgG7QbSM1lOp/PAaVAeWE
         ZWgLATQck1uMKwtMs28/7GHAWUVHURUrv+CG7IOqwFLpmN1j3NomuzPKaY4VUZYor9tS
         GaZA==
X-Gm-Message-State: AJcUukcRAdn6jGMptxwLiJFU8/JsHwKdhie5t4igoPB+kgTcepAjcJz/
        /CsqrL9mtpfywaQHnSQPXGhzAJfNBKZW2Q==
X-Google-Smtp-Source: ALg8bN7wB3OvTEHIJZUObRE+u1jCUob9NBcL6Ym8lBLywE92+LgdzBMziQIaB93dLX8ybvfin45cJQ==
X-Received: by 2002:a37:6e43:: with SMTP id j64mr11963489qkc.278.1547833116957;
        Fri, 18 Jan 2019 09:38:36 -0800 (PST)
Received: from ovpn-124-227.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id n71sm65027068qkh.59.2019.01.18.09.38.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 09:38:36 -0800 (PST)
Subject: Re: kmemleak panic
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Catalin Marinas <catalin.marinas@arm.com>
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
        LKML <linux-kernel@vger.kernel.org>
References: <f6fbf528-8213-e3b8-6990-9fcf9dec04d6@free.fr>
 <20190118143434.GE118707@arrakis.emea.arm.com>
 <b7629ecf-757c-f8b5-df83-ba83d7036b2f@free.fr>
 <5fe89adc-c95b-ca89-d043-c380e2ba8cb3@lca.pw>
 <8edcc205-0e55-7988-5729-7b75e47e9b32@free.fr>
From:   Qian Cai <cai@lca.pw>
Message-ID: <fd0a8e39-b258-6281-ed5d-0e176971478f@lca.pw>
Date:   Fri, 18 Jan 2019 12:38:33 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <8edcc205-0e55-7988-5729-7b75e47e9b32@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/19 12:05 PM, Marc Gonzalez wrote:
> On 18/01/2019 17:14, Qian Cai wrote:
> 
>> This looks like something different from the original "invalid PFNs from
>> pfn_to_online_page()" issue. What's your .config ?
> 
> Here's my defconfig:
> 
> # CONFIG_SWAP is not set
> CONFIG_NO_HZ_IDLE=y
> CONFIG_HIGH_RES_TIMERS=y
> CONFIG_PREEMPT=y
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> CONFIG_LOG_BUF_SHIFT=20
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_ARCH_QCOM=y
> # CONFIG_EFI is not set
> # CONFIG_SUSPEND is not set
> CONFIG_PM=y
> # CONFIG_MQ_IOSCHED_DEADLINE is not set
> # CONFIG_MQ_IOSCHED_KYBER is not set
> CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
> CONFIG_DEVTMPFS=y
> CONFIG_DEVTMPFS_MOUNT=y
> # CONFIG_BLK_DEV is not set
> # CONFIG_INPUT_KEYBOARD is not set
> # CONFIG_INPUT_MOUSE is not set
> # CONFIG_SERIO_SERPORT is not set
> CONFIG_VT_HW_CONSOLE_BINDING=y
> CONFIG_LEGACY_PTY_COUNT=16
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_MSM=y
> CONFIG_SERIAL_MSM_CONSOLE=y
> CONFIG_SERIAL_DEV_BUS=y
> # CONFIG_HW_RANDOM is not set
> # CONFIG_HWMON is not set
> CONFIG_REGULATOR=y
> CONFIG_REGULATOR_FIXED_VOLTAGE=y
> CONFIG_REGULATOR_QCOM_SMD_RPM=y
> # CONFIG_HID is not set
> # CONFIG_USB_SUPPORT is not set
> # CONFIG_COMMON_CLK_XGENE is not set
> CONFIG_COMMON_CLK_QCOM=y
> # CONFIG_QCOM_A53PLL is not set
> # CONFIG_QCOM_CLK_APCS_MSM8916 is not set
> CONFIG_QCOM_CLK_SMD_RPM=y
> CONFIG_MSM_GCC_8998=y
> CONFIG_HWSPINLOCK=y
> CONFIG_HWSPINLOCK_QCOM=y
> CONFIG_MAILBOX=y
> CONFIG_QCOM_APCS_IPC=y
> CONFIG_RPMSG_QCOM_GLINK_RPM=y
> CONFIG_RPMSG_QCOM_GLINK_SMEM=y
> CONFIG_RPMSG_QCOM_SMD=y
> CONFIG_RPMSG_VIRTIO=y
> CONFIG_QCOM_COMMAND_DB=y
> CONFIG_QCOM_SMEM=y
> CONFIG_QCOM_SMD_RPM=y
> CONFIG_TMPFS=y
> CONFIG_DEBUG_INFO=y
> CONFIG_DEBUG_KERNEL=y
> CONFIG_DEBUG_KMEMLEAK=y
> CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE=4000
> CONFIG_FUNCTION_TRACER=y
> 

This is truncated. I'll need your whole .config file, so I can try to reproduce
it here on an arm64 ThunderX2 server.
