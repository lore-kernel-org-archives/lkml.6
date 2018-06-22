Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41102C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0480F23C57
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 02:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0480F23C57
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934253AbeFVCZ6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 22:25:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47825 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933864AbeFVCZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 22:25:56 -0400
Received: from wld62.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w5M2PkbK4103957
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 21 Jun 2018 19:25:47 -0700
Date:   Thu, 21 Jun 2018 19:25:39 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20180622015851.GA10254@gmail.com>
References: <20180621211754.12757-1-h.peter.anvin@intel.com> <20180622015851.GA10254@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v3 0/7] x86/ptrace: regset access to the GDT and LDT
To:     Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin, Intel" <h.peter.anvin@intel.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        "Markus T . Metzger" <markus.t.metzger@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Josh Poimboeuf <jpoimboe@redhat.com>
From:   hpa@zytor.com
Message-ID: <D4F62A3D-1DE1-4FB3-A46A-A9928BB290F7@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 21, 2018 6:58:51 PM PDT, Ingo Molnar <mingo@kernel.org> wrote:
>
>* H. Peter Anvin, Intel <h.peter.anvin@intel.com> wrote:
>
>> From: "H. Peter Anvin" <hpa@linux.intel.com>
>> 
>> Give a debugger access to the visible part of the GDT and LDT.  This
>> allows a debugger to find out what a particular segment descriptor
>> corresponds to; e.g. if %cs is 16, 32, or 64 bits.
>> 
>> v3:
>> 	Requalify LDT segments for selectors that have actually changed.
>> 
>> v2:
>> 	Add missing change to elf.h for the very last patch.
>> 
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Chang S. Bae <chang.seok.bae@intel.com>
>> Cc: Markus T. Metzger <markus.t.metzger@intel.com>
>> Cc: H. Peter Anvin <hpa@zytor.com>
>> 
>>  arch/x86/Kconfig               |   4 +
>>  arch/x86/include/asm/desc.h    |  24 +++-
>>  arch/x86/include/asm/ldt.h     |  16 +++
>>  arch/x86/include/asm/segment.h |  10 ++
>>  arch/x86/kernel/Makefile       |   3 +-
>>  arch/x86/kernel/ldt.c          | 283
>++++++++++++++++++++++++++++++++---------
>>  arch/x86/kernel/ptrace.c       | 103 ++++++++++++++-
>>  arch/x86/kernel/tls.c          | 102 +++++----------
>>  arch/x86/kernel/tls.h          |   8 +-
>>  include/uapi/linux/elf.h       |   2 +
>>  10 files changed, 413 insertions(+), 142 deletions(-)
>
>Ok, this looks mostly good to me at a quick glance, but could you
>please do one 
>more iteration and more explicitly describe where you change/extend
>existing ABIs?
>
>I.e. instead of a terse and somewhat vague summary:
>
>> x86/tls,ptrace: provide regset access to the GDT
>>
>> Give a debugger access to the visible part of the GDT and LDT.  This
>> allows a debugger to find out what a particular segment descriptor
>> corresponds to; e.g. if %cs is 16, 32, or 64 bits.
>
>Please make it really explicit how the ABI is affected, both in the
>title and in 
>the description, and also _explain_ how this helps us over what we had
>before, 
>plus also list limitations of the new ABI.
>
>I.e. something like:
>
>  x86/tls, ptrace: Extend the ptrace ABI with the new REGSET_GDT method
>
>   Add the new REGSET_GDT ptrace variant to PTRACE_{GET|SET}REGSET,
>   to give read and write access to the GDT:
>
>- Previously only certain parts of the GDT were visible, and only via
>random
>ABIs and instructions - there was no architectured access to all of it.
>
>- The SETREGSET variant is only allowed to change the TLS area of the
>GDT.
>
>(or so.)
>
>This is important not just for documentation and library support
>purposes, but 
>also to be able to review it properly, to match 'intent' to
>'implementation'.
>
>(It might also help later on in finding bugs/quirks, if any.)
>
>Please do this for all patches in the series that change the ABI.
>
>Thanks,
>
>	Ingo

ACK.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
