Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C69C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8114213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 12:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfBYM4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 07:56:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47246 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbfBYM4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 07:56:04 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DD22F59466;
        Mon, 25 Feb 2019 12:56:03 +0000 (UTC)
Received: from krava (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id 329795D71A;
        Mon, 25 Feb 2019 12:56:02 +0000 (UTC)
Date:   Mon, 25 Feb 2019 13:56:00 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 02/11] perf tools script: Support insn output for normal
 samples
Message-ID: <20190225125600.GG19795@krava>
References: <20190224153722.27020-1-andi@firstfloor.org>
 <20190224153722.27020-3-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190224153722.27020-3-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 25 Feb 2019 12:56:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 07:37:13AM -0800, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> perf script -F +insn was only working for PT traces because
> the PT instruction decoder was filling in the insn/insn_len
> sample attributes. Support it for non PT samples too on x86
> using the existing x86 instruction decoder.
> 
> % perf record -a sleep 1
> % perf script -F ip,sym,insn --xed
>  ffffffff811704c9 remote_function               movl  %eax, 0x18(%rbx)
>  ffffffff8100bb50 intel_bts_enable_local                retq
>  ffffffff81048612 native_apic_mem_write                 movl  %esi, -0xa04000(%rdi)
>  ffffffff81048612 native_apic_mem_write                 movl  %esi, -0xa04000(%rdi)
>  ffffffff81048612 native_apic_mem_write                 movl  %esi, -0xa04000(%rdi)
>  ffffffff810f1f79 generic_exec_single           xor %eax, %eax
>  ffffffff811704c9 remote_function               movl  %eax, 0x18(%rbx)
>  ffffffff8100bb34 intel_bts_enable_local                movl  0x2000(%rax), %edx
>  ffffffff81048610 native_apic_mem_write                 mov %edi, %edi

also for samples with empty instruction, where I guess we fail
for some reason to retrieve it, we will show default (0?) mnemonic

[jolsa@krava perf]$ ./perf script -F insn
 insn:
 insn:
 insn:
 insn:
 insn:
 insn:
 insn:
 insn: 76 ea
 insn:
 insn: 0f a2
 insn: 29 c8
 insn: 8b 04 90
 insn: 0f a2

[jolsa@krava perf]$ ./perf script -F insn --xed
                addb  %al, (%rax)
                addb  %al, (%rax)
                addb  %al, (%rax)
                addb  %al, (%rax)
                addb  %al, (%rax)
                addb  %al, (%rax)
                addb  %al, (%rax)
                jbe 0xffffffffffffffec
                addb  %al, (%rax)
                cpuid
                sub %ecx, %eax
                movl  (%rax,%rdx,4), %eax
                cpuid

jirka
