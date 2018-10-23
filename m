Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C162C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DEF20671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01DEF20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbeJXE0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:26:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50927 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725266AbeJXE0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:26:38 -0400
Received: from hanvin-mobl2.amr.corp.intel.com ([134.134.139.76])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w9NK1QrL3158719
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 23 Oct 2018 13:01:27 -0700
Subject: Re: [PATCH RFC] x86: Don't include '-Wa,-' when building with Clang
To:     Nick Desaulniers <ndesaulniers@google.com>, namit@vmware.com
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
References: <20181023003725.21463-1-natechancellor@gmail.com>
 <F3BBC06A-A9CB-4ABF-ADF4-6B0971FAE364@vmware.com>
 <CAKwvOdmsKbW9v9or+u-W9V7T+LrF4ODY9cgUStkjkmsbMcqJ2g@mail.gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <96ffedd2-a19d-95de-45fd-3a83025dd48a@zytor.com>
Date:   Tue, 23 Oct 2018 13:01:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKwvOdmsKbW9v9or+u-W9V7T+LrF4ODY9cgUStkjkmsbMcqJ2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/18 11:40, Nick Desaulniers wrote:
> On Mon, Oct 22, 2018 at 10:11 PM Nadav Amit <namit@vmware.com> wrote:
>>
>> at 5:37 PM, Nathan Chancellor <natechancellor@gmail.com> wrote:
>>
>> Commit 77b0bf55bc67 ("kbuild/Makefile: Prepare for using macros in
>> inline assembly code to work around asm() related GCC inlining bugs")
>> added this flag to KBUILD_CFLAGS, where it works perfectly fine with
>> GCC. However, when building with Clang, all of the object files compile
>> fine but the build hangs indefinitely at init/main.o, right before the
>> linking stage. Don't include this flag when building with Clang.
>>
>> The kernel builds and boots to a shell in QEMU with both GCC and Clang
>> with this patch applied.
>>
>> Link: https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FClangBuiltLinux%2Flinux%2Fissues%2F213&amp;data=02%7C01%7Cnamit%40vmware.com%7C871daebc2ca44947d28d08d638811fb5%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C1%7C0%7C636758524579997650&amp;sdata=shuxW81QRrO3TSqbgf462wgZYdLeAKeQEdGRxmnUX30%3D&amp;reserved=0
>> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>> ---
>>
>> The reason this patch is labeled RFC is while I can verify that this
>> fixes the issue, I'm not entirely sure why the '-Wa,-' works for GCC
>> and not Clang. I looked into what the flag means and I couldn't really
>> find anything so I just assume it's taking input from stdin? The issue
>> could stem from how GCC forks gas versus how Clang does it. If this
>> isn't of concern and the maintainers are happy with this patch as is,
>> feel free to take it.
>>

Perhaps someone could actually, you know, time the build and see how
much -pipe actually matters, if at all?

	-hpa

