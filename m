Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95051ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4722147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4722147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732492AbeGLWSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 18:18:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48705 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbeGLWSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 18:18:44 -0400
Received: from carbon-x1.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w6CM6x7v4066665
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 12 Jul 2018 15:06:59 -0700
Subject: Re: [PATCH] x86: vdso: Fix leaky vdso link with CC=clang
To:     Alistair Strachan <astrachan@google.com>
Cc:     linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        x86@kernel.org, kernel-team@android.com, joel@joelfernandes.com
References: <20180712201032.156997-1-astrachan@google.com>
 <47d4b24e-8c60-fb3b-3377-62d20c5f3dd1@zytor.com>
 <CANDihLEz3_fZ4r4g=VcxWps5DWSjMJdbJZKZWsLFKVp_c7FscA@mail.gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <1432bfde-41b4-e8aa-037b-fca41a149cb8@zytor.com>
Date:   Thu, 12 Jul 2018 15:06:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CANDihLEz3_fZ4r4g=VcxWps5DWSjMJdbJZKZWsLFKVp_c7FscA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/18 13:37, Alistair Strachan wrote:
> On Thu, Jul 12, 2018 at 1:25 PM H. Peter Anvin <hpa@zytor.com> wrote:
>> On 07/12/18 13:10, Alistair Strachan wrote:
>>> The vdso{32,64}.so can fail to link with CC=clang when clang tries to
>>> find a suitable GCC toolchain to link these libraries with.
>>>
>>> /usr/bin/ld: arch/x86/entry/vdso/vclock_gettime.o:
>>>   access beyond end of merged section (782)
>>>
>>> This happens because the host environment leaked into the cross
>>> compiler environment due to the way clang searches for suitable GCC
>>> toolchains.
>>>
>>
>> Is this another clang bug that you want a workaround for in the kernel?
> 
> Clang is a retargetable compiler (specified with --target=<something>)
> and so it has a mechanism for searching for suitable binutils (from
> another "GCC toolchain") to perform assembly and linkage. This
> mechanism relies on both --target and --gcc-toolchain when
> cross-compiling, otherwise it will fall back to searching /usr.
> 
> The --target and --gcc-toolchain flags are already specified correctly
> in the top level Makefile, but the vdso Makefile rolls its own linker
> flags and doesn't use KBUILD_CFLAGS. Therefore, these flags get
> incorrectly dropped from the vdso $CC link command line, and an
> inconsistency is created between the "GCC toolchain" used to generate
> the objects for the vdso, and the linker used to link them.
> 

It sounds like there needs to be a more fundamental symbol than
KBUILD_CFLAGS to contain these kinds of things.

	-hpa
