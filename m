Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1014DECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB06B2064D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="XCRv5UUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB06B2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731881AbeGQO52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:57:28 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43036 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731608AbeGQO52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:57:28 -0400
Received: by mail-lf0-f66.google.com with SMTP id m12-v6so978253lfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 07:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VzJWilzjD9QyH8EQZA9XW5s+BaknxtsbeUT09Yr+xi8=;
        b=XCRv5UUZ+z+R2GB/M3IJEJVeroxNE0AogE1lVESBchrJXOoJElC4qHqzeWS2zxnf1o
         0HD4BA4oNRB+yWDfMxJwbishUYqemW4ZUAvq0Y3a6NhCze6mC8O1lCbBOFV/oOw3mrjR
         SvL9CA5BUfm+XEOEo67V18MunwYvFCFnmy0to=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VzJWilzjD9QyH8EQZA9XW5s+BaknxtsbeUT09Yr+xi8=;
        b=RjWqqJVEK2wd7bOf1B67EvQQL+qafRv+0Zopdx2FzObXWaWjuyJOLrrra1pZWzXy3P
         PeNNsJGRxIC4+t/6fG1aXkYCxu5Wb86sCqsSFOvaMxU1IpuFxbTCqGEuShTY+Te6ykb/
         h0+BdvZJeRfMzFD5Tqhs6zj6rkhHWt9vG+apLeGwYLeMdXEqQZra055c4mqk10sPJo5c
         K0/gZ7bNevnvJgyVljq/geDFLh20aJuNCENXvUkbFbki4b/3umzSaBbushWkPiXybj9N
         AdjUcZR+6yYAMUgx87nAv4qRqimW3atqfw+agTMDhlA64Vox10V1RguJB5ysnJnsoRzi
         H+8g==
X-Gm-Message-State: AOUpUlF/GAr971Ci/sSyctxeJnN/bbyUIrSEXuuIIsTpf7xbTKDtiJxP
        UXmFzasbzJqeilu0kUmtAMdgjA==
X-Google-Smtp-Source: AAOMgpeFPmeAiDRU/bnZ79kXZlnnddpWqoSNfXFhFX5eNKmDg2VgZKyl+TD8ej8Zcn6w+cTE9sCo4A==
X-Received: by 2002:a19:9806:: with SMTP id a6-v6mr1502219lfe.128.1531837472362;
        Tue, 17 Jul 2018 07:24:32 -0700 (PDT)
Received: from [172.16.11.32] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id k10-v6sm200154ljh.5.2018.07.17.07.24.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 07:24:31 -0700 (PDT)
Subject: Re: [PATCH] x86: Avoid pr_cont() in show_opcodes()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Ingo Molnar <mingo@kernel.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SKAURA.ne.jp>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1530943625-3288-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20180707111209.GA27768@gmail.com>
 <da14a295-3bff-f4bb-7c3e-f4126cda8d08@i-love.sakura.ne.jp>
 <12409dc4-c10a-d77a-f88d-165aa92b489e@rasmusvillemoes.dk>
 <f486debf-e824-0d0c-c0c9-cf1e278ee9eb@i-love.sakura.ne.jp>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <218baff7-9473-ac1e-2449-13de98fa6dc9@rasmusvillemoes.dk>
Date:   Tue, 17 Jul 2018 16:24:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <f486debf-e824-0d0c-c0c9-cf1e278ee9eb@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-17 15:53, Tetsuo Handa wrote:
> On 2018/07/17 18:01, Rasmus Villemoes wrote:
>> Why not this instead? Less stack use, less code, no intermediary
>> snprintfs, no pr_cont...
> 
> Excellent! I didn't notice %ph extension.
> 
>> Not compile-tested, probably whitespace-damaged, but you get the idea.
> 
> Yes, it works well.
> 
> 
> 
> From 96d9d4d135994a081e54d33d23f5007c53d9b5dd Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Tue, 17 Jul 2018 22:47:11 +0900
> Subject: [PATCH v3] x86: Avoid pr_cont() in show_opcodes()
> 
> Since syzbot is confused by concurrent printk() messages [1],
> this patch changes show_opcodes() to use %*ph format string.
> 
> When we start adding prefix to each line of printk() output,
> we will be able to handle concurrent printk() messages.
> 
> [1] https://syzkaller.appspot.com/text?tag=CrashReport&x=139d342c400000
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SKAURA.ne.jp>
> Signed-off-by: Rasmus Villemoes <mail@rasmusvillemoes.dk>

I'm not sure that SoB-chain is correct. Anyway, however which way, and
if at all, you want to credit me, please use the email address
linux@rasmusvillemoes.dk . I probably botched From header in the
previous mail, not used to using Thunderbird...

Rasmus
