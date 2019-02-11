Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2676C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74FAC218A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mFmQgTb8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfBKWXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:23:20 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43311 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfBKWXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:23:19 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so211914pgk.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 14:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=MrPICWp6pz3MZZf/m3HgNLOFtoUsRY4n1DmcuA0FpPY=;
        b=mFmQgTb8/+n35SO/Ed/3B4oKrYHYM7sQMf7ottpU4Zs9XqfVyXQf9Ar75K3fnIeX3r
         pPNAxcqBAVSIdVYAwIkJzE5t8VPkxk/AQ5ThWwj/h/4n/0yUq7iMghzpCAJVW6NUgx62
         b9MQMStQzj2JSzF/OzQG46+J6/glq3dLgsQ8FD2x15wF1wTAXXkkSpF5/GNmz2paG3Sm
         GxrZyXPVlzvcD7QypO5hlyLfvnZsqcpoqdh7ux27B49nAIAf7KCO5JwauJY8qNcRl5Xi
         lFeqdyJynv6j8993VztefbH1oVYCWyIuo/AKfAdbGBfJMGSkzep3GYRvDz0KZLeS9KxN
         TcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=MrPICWp6pz3MZZf/m3HgNLOFtoUsRY4n1DmcuA0FpPY=;
        b=uPPoDCsyK41R1KFGDYk0prsAcWZC7KZhensvBystMq/OvxYCZeOlt5kQYW8IJnbjIl
         iQ/AP9Um3nC8S4Jpvi46IUXOklzmMpb18oDho6MI/cp6StOSWICa3dlPafNKM5isiwwj
         gs0ErYi+eKChE8TfOKSL4SG+5hQQ2TOiGs1kzAozKTBty7KA4XKYmYBwJA+qdqgfNmJG
         qsfyfxX41sP5J4K+0OVF/9z4gZP/d0DNyDFYtiQmS6LCoSBHeDiYNk7nh6klFhwOVYuR
         47tndVYePgnCWCKcwcl9W2PAM87SFay9TdpgjmbM+62I4fjqsLE7JKfsSlvqxbKxZXVz
         qZ7A==
X-Gm-Message-State: AHQUAuazgKQ/eCNjCXDZmlfA4ErAxHg5CkamTyC/JkRfBtrv2QEYjfcA
        o5IR5xAR1ia9nQYyP5/Izh6h7w==
X-Google-Smtp-Source: AHgI3IYZP91WKA9faP5sK3q6a60MyNbanyy5FvH4gGveLqeZo9s8vLPuCMlq81WHFL87hoTz8maJZA==
X-Received: by 2002:aa7:849a:: with SMTP id u26mr516187pfn.157.1549923798419;
        Mon, 11 Feb 2019 14:23:18 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id l11sm14324508pff.65.2019.02.11.14.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 14:23:17 -0800 (PST)
Date:   Mon, 11 Feb 2019 14:23:17 -0800 (PST)
X-Google-Original-Date: Mon, 11 Feb 2019 14:22:30 PST (-0800)
Subject:     Re: [v3 PATCH 8/8] RISC-V: Assign hwcap only according to boot cpu.
In-Reply-To: <20190211221325.7244b575@why.wild-wind.fr.eu.org>
CC:     atish.patra@wdc.com, david.abdurachmanov@gmail.com,
        Christoph Hellwig <hch@infradead.org>, Damien.LeMoal@wdc.com,
        aou@eecs.berkeley.edu, jason@lakedaemon.net, alankao@andestech.com,
        dmitriy@oss-tech.org, anup@brainfault.org,
        daniel.lezcano@linaro.org, me@packi.ch,
        linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, schwab@suse.de,
        linux-riscv@lists.infradead.org, tglx@linutronix.de,
        zongbox@gmail.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     marc.zyngier@arm.com
Message-ID: <mhng-99c5091e-32b8-4609-a92d-d3ff2a239887@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019 14:13:25 PST (-0800), marc.zyngier@arm.com wrote:
> On Mon, 11 Feb 2019 12:03:30 -0800
> Atish Patra <atish.patra@wdc.com> wrote:
>
>> On 2/11/19 11:02 AM, Palmer Dabbelt wrote:
>> > On Fri, 08 Feb 2019 20:26:07 PST (-0800), david.abdurachmanov@gmail.com wrote:
>> >> On Sat, Feb 9, 2019 at 12:03 AM Atish Patra <atish.patra@wdc.com> wrote:
>> >>>
>> >>> On 2/8/19 1:11 AM, Christoph Hellwig wrote:
>> >>>>> +     * We don't support running Linux on hertergenous ISA systems.
>> >>>>> +     * But first "okay" processor might not be the boot cpu.
>> >>>>> +     * Check the ISA of boot cpu.
>> >>>>
>> >>>> Please use up your available 80 characters per line in comments.
>> >>>>
>> >>> I will fix it.
>> >>>
>> >>>>> +            /*
>> >>>>> +             * All "okay" hart should have same isa. We don't know how to
>> >>>>> +             * handle if they don't. Throw a warning for now.
>> >>>>> +             */
>> >>>>> +            if (elf_hwcap && temp_hwcap != elf_hwcap)
>> >>>>> +                    pr_warn("isa mismatch: 0x%lx != 0x%lx\n",
>> >>>>> +                            elf_hwcap, temp_hwcap);
>> >>>>> +
>> >>>>> +            if (hartid == boot_cpu_hartid)
>> >>>>> +                    boot_hwcap = temp_hwcap;
>> >>>>> +            elf_hwcap = temp_hwcap;
>> >>>>
>> >>>> So we always set elf_hwcap to the capabilities of the previous cpu.
>> >>>>
>> >>>>> +            temp_hwcap = 0;
>> >>>>
>> >>>> I think tmp_hwcap should be declared and initialized inside the outer loop
>> >>>> instead having to manually reset it like this.
>> >>>>
>> >>>>> +    }
>> >>>>>
>> >>>>> +    elf_hwcap = boot_hwcap;
>> >>>>
>> >>>> And then reset it here to the boot cpu.
>> >>>>
>> >>>> Shoudn't we only report the features supported by all cores?  Otherwise
>> >>>> we'll still have problems if the boot cpu supports a feature, but not
>> >>>> others.
>> >>>>
>> >>>
>> >>> Hmm. The other side of the argument is boot cpu does have a feature that
>> >>> is not supported by other hart that didn't even boot.
>> >>> The user space may execute something based on boot cpu capability but
>> >>> that won't be enabled.
>> >>>
>> >>> At least, in this way we know that we are compatible completely with
>> >>> boot cpu capabilities. Thoughts ?
>> >>
>> >> There is one example on the market, e.g., Samsung Exynos 9810.
>> >>
>> >> Mongoose 3 (big cores) only support ARMv8.0, while Cortex-A55
>> >> (little ones) support ARMv8.2 (and that brings atomics support).
>> >> I think, it's the only ARM SOC that supports different ISA extensions
>> >> between cores on the same package.
>> >>
>> >> Kernel scheduler doesn't know that big cores are missing atomics
>> >> support or that applications needs it and moves the thread
>> >> resulting in illegal instruction.
>> >>
>> >> E.g., see Golang issue: https://github.com/golang/go/issues/28431
>> >>
>> >> I also recall Jon Masters (Computer Architect at Red Hat) advocating
>> >> against having cores with mismatched capabilities on the server market.
>> >>
>> >> It just causes more problems down the line.
>> > > IMO the best bet is to only put extensions in HWCAP that are supported by all
>> > the harts that userspace will be scheduled on.
>> > Fair enough. Instead of setting HWCAP in setup_arch() once, we can set it only for boot cpu. It will be updated after every cpu comes up online.
>>
>> Thus, HWCAP will consists all extensions supported by all cpus that are online currently.
>
> You must thus prevent CPUs that have a different set of capabilities
> from coming up late (once userspace has started).

and we have no way to do that.  I'd prefer if we just looked through the entire 
device tree and only showed userspace the features that are on every possible 
CPU from the start.  Otherwise the HWCAP will shift around during a userspace 
run, which seems odd.
