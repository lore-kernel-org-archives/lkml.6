Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6CCC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 04:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F8A20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 04:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F8A20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeKANjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 09:39:55 -0400
Received: from ozlabs.org ([203.11.71.1]:41539 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727203AbeKANjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 09:39:54 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42lssR1f4Rz9sRt;
        Thu,  1 Nov 2018 15:38:35 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nick Desaulniers <ndesaulniers@google.com>, joel@jms.id.au
Cc:     LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>, jji@us.ibm.com
Subject: Re: [PATCH] raid6/ppc: Fix build for clang
In-Reply-To: <CAKwvOdm8rFNEG39_6f5voZo3nU1g9eC6M8uxeQPVE8=JUoB3mg@mail.gmail.com>
References: <20181031032829.18131-1-joel@jms.id.au> <CAKwvOdm8rFNEG39_6f5voZo3nU1g9eC6M8uxeQPVE8=JUoB3mg@mail.gmail.com>
Date:   Thu, 01 Nov 2018 15:38:35 +1100
Message-ID: <87y3ad76pg.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Desaulniers <ndesaulniers@google.com> writes:
> On Tue, Oct 30, 2018 at 8:28 PM Joel Stanley <joel@jms.id.au> wrote:
>>
>> We cannot build these files with clang as it does not allow altivec
>> instructions in assembly when -msoft-float is passed.
>>
>> Jinsong Ji <jji@us.ibm.com> wrote:
>> > We currently disable Altivec/VSX support when enabling soft-float.  So
>> > any usage of vector builtins will break.
>> >
>> > Enable Altivec/VSX with soft-float may need quite some clean up work, so
>> > I guess this is currently a limitation.
>> >
>> > Removing -msoft-float will make it work (and we are lucky that no
>> > floating point instructions will be generated as well).
>>
>> This is a workaround until the issue is resolved in clang.
>>
>> Link: https://bugs.llvm.org/show_bug.cgi?id=31177
>> Link: https://github.com/ClangBuiltLinux/linux/issues/239
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>
> Hopefully we can have this fixed up soon.  I'll try to see who works
> on Clang+PPC here and see if they can help move that bug along. Thanks
> for the patch!
>
>> ---
>>  lib/raid6/Makefile | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
>> index 2f8b61dfd9b0..3a844e6fd01c 100644
>> --- a/lib/raid6/Makefile
>> +++ b/lib/raid6/Makefile
>> @@ -18,6 +18,21 @@ quiet_cmd_unroll = UNROLL  $@
>>
>>  ifeq ($(CONFIG_ALTIVEC),y)
>>  altivec_flags := -maltivec $(call cc-option,-mabi=altivec)
>> +
>> +ifdef CONFIG_CC_IS_CLANG
>
> Note that the top level makefile detects clang via:
>
> ifeq ($(cc-name),clang)
>
> Does that not work here? I'd prefer to keep compiler detection in
> Makefiles consistent, if it works?

cc-name is being removed in favor of CONFIG_CC_IS_CLANG:

https://lore.kernel.org/lkml/1540905994-6073-1-git-send-email-yamada.masahiro@socionext.com/

cheers
