Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AF2C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C33420827
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="gWO7mRnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C33420827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbeKJGf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 01:35:29 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42023 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbeKJGf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 01:35:28 -0500
Received: by mail-lj1-f196.google.com with SMTP id f3-v6so2720752ljk.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 12:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wjzqdqykk6z553Fe0xP1a7AI2E2DCKEgihIyL5uH7N0=;
        b=gWO7mRnPobtGLnWwItRFo8/OEmoDbpc51qy9OZIWzZzKSREAUaz+NOZMrHOlqrUSoX
         OIfktOClCJylxfdXkPg2ETzK4e9pTrv0IZHUWUVlN2tXcmfZlp3bnw1Cnb5pMmbXQ9O5
         mT68raQIg5jYRK5EvqIi55zasQ6vQko9zzOvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wjzqdqykk6z553Fe0xP1a7AI2E2DCKEgihIyL5uH7N0=;
        b=dtb4JksG6XZqIHD0N2h8sLbvldlUyS6DLMWRVbM9LAHMO+wBjrj9rJZQtGlbO7N84C
         bjbyCe1e1ZamIKzRL/ReBziPvr+qkE8tKg5DciW1E19hZhrYrYm3q8BvnIko6wMmmEDv
         2fwGc4SID2pUfBWVhiXTeHmnyMFQZY8an9z9nTHXVcWGrV+9hxvv0ZKB9TBrvWCNUKSJ
         aYebgfngWSVya05NSI4yhNKpbaQ4Ojv0h8/86dG+8HzOWluhyelmq1AsWNAWgN1kxGLE
         7AOugaJtpGNK3fV0EZKUyOV2EqLB795Wh0l/4TV8FHEM7wRfEbph4sUyXZqEK28cdB6s
         uP0A==
X-Gm-Message-State: AGRZ1gLcDvEtmWP4sUqOHnprtudbuBc//7elW5gWm3u2nlY8enuapr9/
        MXZdo9NbjuimXwGOt/N2pX9JtQ==
X-Google-Smtp-Source: AJdET5dgwCicn8v6KpvIrk8HTVSBNrn/aacYS9FcnIvfwGTEA38m8a8Jahh3xWZgCwoaelw1ApzH/w==
X-Received: by 2002:a2e:4745:: with SMTP id u66-v6mr6311995lja.37.1541796790185;
        Fri, 09 Nov 2018 12:53:10 -0800 (PST)
Received: from [192.168.0.189] (dhcp-5-186-114-252.cgn.ip.fibianet.dk. [5.186.114.252])
        by smtp.gmail.com with ESMTPSA id o72sm1699327lfg.33.2018.11.09.12.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 12:53:09 -0800 (PST)
Subject: Re: [PATCH RFC 0/3] Static calls
To:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>
References: <cover.1541711457.git.jpoimboe@redhat.com>
 <20181109072811.GB86700@gmail.com>
 <CALCETrU3tPPOiuTaLqUy-L4sPvZRU8BLYML-BgQH_LZhA4bzSQ@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <54b6c3b1-acf3-d591-cd2a-79eae4ff0ebb@rasmusvillemoes.dk>
Date:   Fri, 9 Nov 2018 21:53:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CALCETrU3tPPOiuTaLqUy-L4sPvZRU8BLYML-BgQH_LZhA4bzSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 16.16, Andy Lutomirski wrote:
> On Thu, Nov 8, 2018 at 11:28 PM Ingo Molnar <mingo@kernel.org> wrote:
>>
>>
>> All other usecases are bonus, but it would certainly be interesting to
>> investigate the impact of using these APIs for tracing: that too is a
>> feature enabled everywhere but utilized only by a small fraction of Linux
>> users - so literally every single cycle or instruction saved or hot-path
>> shortened is a major win.
> 
> For tracing, we'd want static_call_set_to_nop() or something like that, right?
> 

Hm. IIUC, when gcc sees static_call(key)(...), it has to generate code
to put the right values in %rdi, %rsi etc.. Even if the function is void
(*)(void), gcc would still need to shuffle things around (either spill
and reload, or move %rdi to some callee saved register). So if the
static_call is noop'ed out most of the time, that seems like a net loss?
With an unlikely static_key, gcc can do all the parameter setup and
reloading in an out-of-line chunk of code.

static calls seems like a quite useful concept, but only/mostly if
_some_ function needs to be called at that spot.

Aside: there should be some compile-time check that
static_call_set_to_nop can only be used if the return type is void.

Rasmus


