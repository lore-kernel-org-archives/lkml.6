Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A69C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAEC121479
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C7bhUIiJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAEC121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbeHPVsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:48:03 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38100 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbeHPVr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:47:59 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so5222105wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 11:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eoOhojkqM1h5g63vmx7Vze3CKxiR1nADmqiCkp0+M4U=;
        b=C7bhUIiJXrXQT6l2eRHavOZx6HV0B7LaVMrBualvczXyxWumWUT3n53pa/LkGD0214
         E2x1M2W1p38UBm8R80686mSpE01dZkyf+7jrPbX16JWTES1D2Qt1UrksHVjiWL66TM4z
         4xGaK7x2EcRCN5yvryYUqjbagPuZtKR8rjF9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eoOhojkqM1h5g63vmx7Vze3CKxiR1nADmqiCkp0+M4U=;
        b=YNS/DzHsakPciccBtOTbfiM6CQsU0N/xWg5efKqk+z7t6E+yDv1hXbFhWzuoM1bTRr
         lplUDRxjo6Gcq6TgRKR4mj/vWcfqX4PU+yR6REF7WeSJ+5vZ3+Yfo4j4zuq+1FTN3Nek
         gI4fxpaJWWiypz90euW0pqDHqGgYPdy98ToHbhdwvuZjuPITXjPl8o/7CKTYPPEvYhDQ
         MzKsCb4uEKdBT98CJzQsu4A7a7rTsR9WOKmNcCI3x7XolPbAV7t62ieJuelB6WF+898I
         pIpqRmglfyOIAUkiLMLG43wF7troZDL401KM49SQg1gV8cu0H4WxtLw0CCxCta7EZXp6
         2OFQ==
X-Gm-Message-State: AOUpUlE5ZlKPIwvaJTMi0A966ZmfedP5bcp7iL2ZLnoPtwVYtq10feS2
        JRMaMxZT9OmGxHGEhs/G9Ltc4HWAPIvisGH55Hg3U0uymwg=
X-Google-Smtp-Source: AA+uWPyQpk4S+IXu5q1U49XZIYQGGODBD5BL+twTiGxLD00WqziWMmTSVfV7alewR7+Ye0Y96W60fXbf7vWH1CG1Q4Q=
X-Received: by 2002:a1c:3a8f:: with SMTP id h137-v6mr18014479wma.41.1534445268486;
 Thu, 16 Aug 2018 11:47:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c243:0:0:0:0:0 with HTTP; Thu, 16 Aug 2018 11:47:47
 -0700 (PDT)
In-Reply-To: <95c5c8b6-35f9-b1b4-0153-591b000c0a79@iki.fi>
References: <462f8ae6-9948-a8e5-7504-623d40344336@iki.fi> <20180816102219.GF31093@arm.com>
 <CALAqxLWJzpV2Mqkz_ed_5zYX3SFyMZTBgTzyRAden7ab3VNm-Q@mail.gmail.com> <95c5c8b6-35f9-b1b4-0153-591b000c0a79@iki.fi>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 16 Aug 2018 11:47:47 -0700
Message-ID: <CALAqxLUZiSyi0f365B-QRTT1gkWq9RP-4n2950NcF0w9oSXYEg@mail.gmail.com>
Subject: Re: AArch64 boot failure on Hikey960 on latest master after "arm64:
 insn: Don't fallback on nosync path for general insn patching"
To:     Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 11:37 AM, Tuomas Tynkkynen
<tuomas.tynkkynen@iki.fi> wrote:
> Hi,
>
> On 08/16/2018 08:57 PM, John Stultz wrote:
>>
>> On Thu, Aug 16, 2018 at 3:22 AM, Will Deacon <will.deacon@arm.com> wrote:
>>>
>>> Hi Tuomas, [+John]
>
> ...
>>>
>>>
>>> Out of interest -- do you know if Hikey960 is used by any boot-testing
>>> farms? The patch above has been in linux-next for ages, but we didn't see
>>> any complaints until it hit mainline :(
>>
>>
>> Unfortunately not yet. HiKey960 upstreaming is ongoing, and the UFS
>> support patches should land in the 4.19 merge window.
>> After which, it will enable more mainline testing as folks won't have
>> to carry patches just to get the system to boot.
>>
>
> A microSD rootfs gets me a working system on e.g. v4.17... except that
> even there the system hangs if I don't have 'clk_ignore_unused' on
> the kernel command line. I wonder if this is a known problem?

Oh, good point. I'm usually focusing on AOSP, so I've not tried
booting from the uSD slot.

As for the  clk_ignore_unused, I've not seen it, but I'm usually
testing with a much larger patch stack targeting AOSP (only
occasionally trying with a smaller set to validate patches being
prepped for upstream).  So if you want to file a bug, please do so
here: https://bugs.96boards.org/

Appreciate your testing! Please do feel free to reach out/cc me if you
run into other issues.

thanks
-john
