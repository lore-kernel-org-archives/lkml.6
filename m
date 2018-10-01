Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE1FC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3922F2082A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 17:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3922F2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeJBARy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:17:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43141 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725740AbeJBARy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:17:54 -0400
Received: from hanvin-mobl2.amr.corp.intel.com (jfdmzpr03-ext.jf.intel.com [134.134.139.72])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w91HccaW1651456
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 1 Oct 2018 10:38:39 -0700
Subject: Re: [PATCH v2] x86/boot: define CC_HAVE_ASM_GOTO
To:     ndesaulniers@google.com, bp@alien8.de, mingo@redhat.com,
        tglx@linutronix.de
Cc:     x86@kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org
References: <20180927204800.32210-1-ndesaulniers@google.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <d98d47ea-b639-8afd-2851-1f7ceaf66fd0@zytor.com>
Date:   Mon, 1 Oct 2018 10:38:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927204800.32210-1-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/27/18 13:47, ndesaulniers@google.com wrote:
> Early prototypes of Clang with asm goto support produce 6 instances of
> the following warning:
> 
> In file included from arch/x86/boot/compressed/misc.h:20:
> In file included from ./include/linux/elf.h:5:
> In file included from ./arch/x86/include/asm/elf.h:8:
> In file included from ./include/linux/thread_info.h:38:
> In file included from ./arch/x86/include/asm/thread_info.h:53:
> ./arch/x86/include/asm/cpufeature.h:150:2: warning: "Compiler lacks
> ASM_GOTO support. Add -D __BPF_TRACING__ to your compiler arguments"
> [-W#warnings]
> your compiler arguments"
>  ^
> 
> Since 6 files under arch/x86/boot/compressed/ include
> arch/x86/boot/compressed/misc.h AND
> arch/x86/boot/compressed/Makefile happens to redefine KBUILD_CFLAGS,
> which set these variables in the top level MAKEFILE.
> 

The Right Thing[TM] would probably be to split the CFLAGS into those
that are independent of x86_64 vs i386. After all, there is no
fundamental reason we couldn't want to use asm goto in the setup or
real-mode code in the future.  In addition to BIOS entry code there is
the EFI32 code.

	-hpa
