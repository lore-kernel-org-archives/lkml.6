Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B606C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0510E2156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="YooBauo4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0510E2156D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeI0OJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 10:09:50 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43388 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbeI0OJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 10:09:50 -0400
Received: by mail-lf1-f67.google.com with SMTP id x24-v6so1330459lfe.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 00:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l7BpBimOf09KHyyk0Zg5kXWpd+CCDeeZsQm9eTxvK1I=;
        b=YooBauo4RWdkRf1Qo9YKjHJzhuQMEynSeEmsU5FKIs+37TxHvWvuGim9Um3BDJt6kz
         vpubinQZCMlE4XLb5sbK0ceWzAxY8M2QfObk3K2i+bnEVttHfP/wNxOq78eg+2vXqeur
         elT6e4SrMpV24LuaRX+lTdyDfoCIZtsaIzqCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l7BpBimOf09KHyyk0Zg5kXWpd+CCDeeZsQm9eTxvK1I=;
        b=PUyuloCGAQ5o0objmHP/E6xEgoeMY2AVpN7ddeF14nLZ78QrutYNvJi5jmyW2KTL0e
         DHRSbZt6fIi7YxWzo947LXMPbr7TnbuQBG9JM5e5JmOjL2POmj8um2e9pXNy83Z6gdnG
         qucb9CxxkMQOaBGX7MEbSRJg5obafJEhqdcdcPVxW6bEhsuz/3cL6sW3EIn3ixdl15XK
         bQFWEgFb7TjqsnlxM7otRXK0rNYczky7FDqDbZtERayv8K7eDUm/XUB0k3Adl3vwE+36
         0lxoL+o2MlKFwXxylelptcW7Tw4WymGJaza4uC6UnLgRDp6zToX6PMxRuvaKL9z8UohX
         36cQ==
X-Gm-Message-State: ABuFfohDT3B5GZ+VNMXvxP6FcWmXbED8bmICWgETd5xXSBa0F23OWsSu
        7rhs2adEXyJjVIOCmssf1cGHDw==
X-Google-Smtp-Source: ACcGV60bWg8Z2uFEGDXFYGTcrNRXNqGPoNzJweEHiC5O8GyAeZn2QQHwBXtul6A2qhl7b/Kq5bOMWQ==
X-Received: by 2002:a19:6544:: with SMTP id c4-v6mr6810679lfj.31.1538034772692;
        Thu, 27 Sep 2018 00:52:52 -0700 (PDT)
Received: from [172.16.11.40] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 33-v6sm281507lfu.64.2018.09.27.00.52.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 00:52:51 -0700 (PDT)
Subject: Re: [PATCH v8 02/10] Makefile: Prepare for using macros for inline
 asm
To:     Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
References: <20180918212847.199085-1-namit@vmware.com>
 <20180918212847.199085-3-namit@vmware.com>
 <1aa5a1f3-ef3d-5cd3-831c-2202d73d3c9e@rasmusvillemoes.dk>
 <307823F9-DCCF-4384-9FBE-28642FAD6B4E@vmware.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <4d3684d6-f415-09b3-0a4f-6eca173bfd37@rasmusvillemoes.dk>
Date:   Thu, 27 Sep 2018 09:52:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <307823F9-DCCF-4384-9FBE-28642FAD6B4E@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-26 19:56, Nadav Amit wrote:
> at 1:58 AM, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> 
>>> +ASM_MACRO_FLAGS = -Wa,arch/x86/kernel/macros.s
>>> +export ASM_MACRO_FLAGS
>>> +KBUILD_CFLAGS += $(ASM_MACRO_FLAGS)
>> How does this affect what gets rebuilt when one of the asm/foo.h files
>> going into macros.s changes? Does that cause a global rebuild because
>> everything depends on macros.s, or do we still only rebuild the files
>> that actually include asm/foo.h?
> 
> There will not be a global rebuild. Any source file that uses the header
> files that are included in macros.S will be rebuilt.
> 
> But your question actually raises two issues:
> 
> 1. If macros.S changes, there *should* be a global rebuild, and currently
> there wouldn’t be one. Do you happen to know what would be the appropriate
> way to trigger one?

Hm, that's a question for Kbuild folks, I think. Maybe one could just
ensure macros.s gets written into the dependency file for each
translation unit (maybe fixdep already has support for that). But if we
do that, we probably want macros.s to be generated with some if_changed
makefile magic, so that changes in one of the asm/ headers that do not
actually change macros.s does not cause a global rebuild (it would still
rebuild the files that actually inclue that asm/ header, of course).

> 2. Someone might mistakenly use the macros through inline assembly without
> including the header file.

That's rather unlikely, I think. An open-coded asm("SOME_MACRO ...")
would hopefully be caught in review. But yeah...

> It would be better to detect such cases and fail
> the build. I may be able to create another asm macro in the C part of the
> header that would cause the build to fail. But let me know if you any
> better idea.

The best I can think of (and I'm not suggesting to do this, or that it
would actually work): In asm/foo.h, inside its cpp include guard, and
inside a guard that excludes this piece when building macros.s itself,
have a 'asm("___asm_foo_included__ = 1\n")'. Then inside each asm macro
defined in asm/foo.h, have a ".ifndef ___asm_foo_included___\n.error
...\n.endif". That latter part might be macrofied itself so that it's
just one line, "CHECK_INCLUDE ___asm_foo_included___\n", with
CHECK_INCLUDE being defined in macros.S.

Rasmus
