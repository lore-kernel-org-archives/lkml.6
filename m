Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7A2C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 01:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024302073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 01:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="j8bqOPsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024302073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeI2IL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 04:11:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34529 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeI2IL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 04:11:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so5441180pfi.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 18:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=BCbCfmNw3TWJkcE6Svde7cv50NunpK6ZWR+5u993ZLE=;
        b=j8bqOPsFZQJxQDphK+7RVzPhvvhNsdCz2BY3fdui/U84nwPEi3saoF00PHGytAbQe9
         illdEqquMQNFQJFXlLxZG3XETubvW3sWLBX/qvIOM3w6u8Daohdify44TrJis1ThHheh
         qIFplHk0EEFVcaH/DfdDN0oE1TTfiQZPvpLA5DFvPsxYz5R+7ayYs4wFr3cEGCiK0D4q
         svNDPnfjdhb1kQ0Q1ybewtq6i1mcVbSWV6BCIU0rdUui6Nt1Irkbxng3QCc2p6mqMjJG
         JeO5Qr8WhGbbGFQgqq0q8cy50TZC5ZsP833wl/ExeQb/4V8PLe9/CX9t5/fBe1wTyhrj
         c1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=BCbCfmNw3TWJkcE6Svde7cv50NunpK6ZWR+5u993ZLE=;
        b=B2tL6DfRt/VGMMzlNmUM5fPq5l8fjDp5sEgb97K0h9/lO9jco1/SZrmlbsb99649cn
         80zEi8qo6rFVOFBv0MvYl5aE6P3wWXMH1uMn2ywvmffJDflf4Ke1UwXBBrSa/iePfgH0
         +31EJfFM5e5L6iyDakoHS+UsAOCfJjCBiQ5PVbIF8EwibF4uOD2Uc8DDRy/CTQMlzaIK
         uhC1kYFMdaKKIjVi9WcNrhTPbh0U6F2eWitpnOY0YGQjWhiL34Iw5VTHfmhoJqJuavjt
         pn3m3riMpmcWKnsAviyHbxpbJKZdkR3tP/tuB6R6CC5muo4gN1lqW9jHIrXSe9COiMkd
         zrgA==
X-Gm-Message-State: ABuFfoj/1cvbs/g4LTrjoeeS7wez7SS9v4LbSAvtmP9ono3zHEE8D3SP
        5jvu0vbavMI/R0vA2l+JiySejA==
X-Google-Smtp-Source: ACcGV61T0KjR++luqDgzcAuFxi4J9zeMjLM4g8tyttvyKnmoc8f+hbTcG0Tvw92DtAWkzzGbXmJ90Q==
X-Received: by 2002:a17:902:ab94:: with SMTP id f20-v6mr1120186plr.231.1538185500835;
        Fri, 28 Sep 2018 18:45:00 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id y4-v6sm8742362pfm.137.2018.09.28.18.44.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 18:44:59 -0700 (PDT)
Date:   Fri, 28 Sep 2018 18:44:59 -0700 (PDT)
X-Google-Original-Date: Fri, 28 Sep 2018 17:33:35 PDT (-0700)
Subject:     Re: [PATCH 1/2] of/fdt: Allow architectures to override CONFIG_CMDLINE logic
In-Reply-To: <CAL_Jsq+n4e5_ptuh89CJibViGS_bgHz0A+Ki-uwtcGU38+mHXQ@mail.gmail.com>
CC:     paul.burton@mips.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        frowand.list@gmail.com, jaedon.shin@gmail.com, malat@debian.org,
        stable@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     robh+dt@kernel.org
Message-ID: <mhng-01382a17-8203-4155-9caf-20600f88bb37@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Sep 2018 13:29:03 PDT (-0700), robh+dt@kernel.org wrote:
> On Fri, Sep 7, 2018 at 1:55 PM Paul Burton <paul.burton@mips.com> wrote:
>>
>> The CONFIG_CMDLINE-related logic in early_init_dt_scan_chosen() falls
>> back to copying CONFIG_CMDLINE into boot_command_line/data if the DT has
>> a /chosen node but that node has no bootargs property or a bootargs
>> property of length zero.
>
> The Risc-V guys found a similar issue if chosen is missing[1]. I
> started a patch[2] to address that, but then looking at the different
> arches wasn't sure if I'd break something. I don't recall for sure,
> but it may have been MIPS that worried me.

IIRC we actually determined it didn't even work correctly on RISC-V, but I 
never actually got the time to figure out why and then forgot about it.  Sorry!

>
>> This is problematic for the MIPS architecture because we support
>> concatenating arguments from either the DT or the bootloader with those
>> from CONFIG_CMDLINE, but the behaviour of early_init_dt_scan_chosen()
>> gives us no way of knowing whether boot_command_line contains arguments
>> from DT or already contains CONFIG_CMDLINE. This can lead to us
>> concatenating CONFIG_CMDLINE with itself, duplicating command line
>> arguments which can be problematic (eg. for earlycon which will attempt
>> to register the same console twice & warn about it).
>
> If CONFIG_CMDLINE_EXTEND is set, you know it contains CONFIG_CMDLINE.
> But I guess part of the problem is MIPS using its own kconfig options.
>
>> Move the CONFIG_CMDLINE-related logic to a weak function that
>> architectures can provide their own version of, such that we continue to
>> use the existing logic for architectures where it's suitable but also
>> allow MIPS to override this behaviour such that the architecture code
>> knows when CONFIG_CMDLINE is used.
>
> More arch specific functions is not what I want. Really, all the
> cmdline manipulating logic doesn't belong in DT code, but it shouldn't
> be in the arch specific code either IMO. Really it should be some
> common kernel function which calls into the DT code to retrieve the DT
> bootargs and that's it. Then you can skip calling that kernel function
> if you really need non-standard handling.
>
> Perhaps you should consider filling DT bootargs with the cmdline from
> bootloader. IOW, make the legacy case look like the non-legacy case
> early, and then the kernel doesn't have to deal with both cases later
> on.
>
> Rob
>
> [1] https://lkml.org/lkml/2018/3/14/701
> [2] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git dt/cmdline
