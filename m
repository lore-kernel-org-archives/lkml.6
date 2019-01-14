Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EECC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 02:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5516B20657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 02:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="gDvVe2qG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfANCdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 21:33:55 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39803 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfANCdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 21:33:55 -0500
Received: by mail-qt1-f193.google.com with SMTP id u47so25047145qtj.6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jan 2019 18:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xCX3o9XGFhNA1ABsQw6IE0ky8pUPPucksjE8/snYP48=;
        b=gDvVe2qGuvXmlpDL2ABIYTV9q1qMrDV3zkAUP5DtukATXkvcHrQXfSglVXVG38TxJL
         vCa0++yeOIu5g+NkfzKTgYsafGtH7hhGl945GpRV6IT34R613FqJjz+CodICzoGUuA9P
         9fM4QGyAyjQzg4MAHynWyO0ioLbCXSQXszwd77FD+htx99t4PWKC368jzam5SZXuQk0D
         HPsvN2+yrF5v3sNhL+wBc5gNEeemgUM42o5p8r1oJJCny21MEh7iqaBZkX9hrQ4FTLLc
         4IVn8EkYHgvibRM2AT4/jcUz+ylA481U/kZgDsAZViOOABnazYtlJOYf1EhP4is8tMxM
         Cl/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xCX3o9XGFhNA1ABsQw6IE0ky8pUPPucksjE8/snYP48=;
        b=ZRe1KzSmEO/3GTcQd7k3N4BhlDiiI8rz2TaRi+PqpwAc1RWlmj8ZCR3uQXk6uFd8zp
         J9SyT+fMtawaNIXxuY31NB0dYE9wRvw20AL2mQsNwHoiMgGmjQW5ampUYG0cK54vzryZ
         O3rxDTRIMFQSj2he/YcENSEKhWXsisxFrrsayxz+lGRy0pYf/tndkkUV9eZ2Mp5zbgYc
         dSj4dD/9YKSsN1YBUxnzY03Q3aB13E5Zb5L+xBV+s9hjaWgc6VaqkB3XZn+t9ni9WEnB
         uYs27Fs38gHRbANVdQu/LShuDnltSrFDHkkxMvf73NzyIV2aurV445/ei0jifWDavt5U
         qA0A==
X-Gm-Message-State: AJcUukdxxB7P+c0ae9NvIKVHe64APK7ini5dE6BXcfmGQXMCQo9dey0p
        LYXMsEuTBRZAvvYy2/iiFT1egicj2prAvA==
X-Google-Smtp-Source: ALg8bN7KirtCE6C6JMmVoHWC7cUbiazMrdlhrNTsO89qu9dsvNTO1Br7UCGn7tN6bfG2CKVf9MvIXQ==
X-Received: by 2002:a0c:bec3:: with SMTP id f3mr22680798qvj.127.1547433233874;
        Sun, 13 Jan 2019 18:33:53 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d45sm48658225qtd.56.2019.01.13.18.33.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 18:33:53 -0800 (PST)
Subject: Re: [PATCH v2] rbtree: fix the red root
To:     David Lechner <david@lechnology.com>,
        Michel Lespinasse <walken@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, esploit@protonmail.ch,
        jejb@linux.ibm.com, dgilbert@interlog.com,
        martin.petersen@oracle.com, joeypabalinas@gmail.com,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190111181600.GJ6310@bombadil.infradead.org>
 <20190111205843.25761-1-cai@lca.pw>
 <a783f23d-77ab-a7d3-39d1-4008d90094c3@lechnology.com>
 <CANN689G0zbk7sMbQ+p9NQGQ=NWq-Q0mQOOjeFkLp19YrTfgcLg@mail.gmail.com>
 <864d6b85-3336-4040-7c95-7d9615873777@lechnology.com>
From:   Qian Cai <cai@lca.pw>
Message-ID: <b1033d96-ebdd-e791-650a-c6564f030ce1@lca.pw>
Date:   Sun, 13 Jan 2019 21:33:51 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <864d6b85-3336-4040-7c95-7d9615873777@lechnology.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/13/19 9:20 PM, David Lechner wrote:
> On 1/11/19 8:58 PM, Michel Lespinasse wrote:
>> On Fri, Jan 11, 2019 at 3:47 PM David Lechner <david@lechnology.com> wrote:
>>>
>>> On 1/11/19 2:58 PM, Qian Cai wrote:
>>>> A GPF was reported,
>>>>
>>>> kasan: CONFIG_KASAN_INLINE enabled
>>>> kasan: GPF could be caused by NULL-ptr deref or user memory access
>>>> general protection fault: 0000 [#1] SMP KASAN
>>>>           kasan_die_handler.cold.22+0x11/0x31
>>>>           notifier_call_chain+0x17b/0x390
>>>>           atomic_notifier_call_chain+0xa7/0x1b0
>>>>           notify_die+0x1be/0x2e0
>>>>           do_general_protection+0x13e/0x330
>>>>           general_protection+0x1e/0x30
>>>>           rb_insert_color+0x189/0x1480
>>>>           create_object+0x785/0xca0
>>>>           kmemleak_alloc+0x2f/0x50
>>>>           kmem_cache_alloc+0x1b9/0x3c0
>>>>           getname_flags+0xdb/0x5d0
>>>>           getname+0x1e/0x20
>>>>           do_sys_open+0x3a1/0x7d0
>>>>           __x64_sys_open+0x7e/0xc0
>>>>           do_syscall_64+0x1b3/0x820
>>>>           entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>>>
>>>> It turned out,
>>>>
>>>> gparent = rb_red_parent(parent);
>>>> tmp = gparent->rb_right; <-- GPF was triggered here.
>>>>
>>>> Apparently, "gparent" is NULL which indicates "parent" is rbtree's root
>>>> which is red. Otherwise, it will be treated properly a few lines above.
>>>>
>>>> /*
>>>>    * If there is a black parent, we are done.
>>>>    * Otherwise, take some corrective action as,
>>>>    * per 4), we don't want a red root or two
>>>>    * consecutive red nodes.
>>>>    */
>>>> if(rb_is_black(parent))
>>>>        break;
>>>>
>>>> Hence, it violates the rule #1 (the root can't be red) and need a fix
>>>> up, and also add a regression test for it. This looks like was
>>>> introduced by 6d58452dc06 where it no longer always paint the root as
>>>> black.
>>>>
>>>> Fixes: 6d58452dc06 (rbtree: adjust root color in rb_insert_color() only
>>>> when necessary)
>>>> Reported-by: Esme <esploit@protonmail.ch>
>>>> Tested-by: Joey Pabalinas <joeypabalinas@gmail.com>
>>>> Signed-off-by: Qian Cai <cai@lca.pw>
>>>> ---
>>>
>>> Tested-by: David Lechner <david@lechnology.com>
>>> FWIW, this fixed the following crash for me:
>>>
>>> Unable to handle kernel NULL pointer dereference at virtual address 00000004
>>
>> Just to clarify, do you have a way to reproduce this crash without the fix ?
> 
> I am starting to suspect that my crash was caused by some new code
> in the drm-misc-next tree that might be causing a memory corruption.
> It threw me off that the stack trace didn't contain anything related
> to drm.
> 
> See: https://patchwork.freedesktop.org/patch/276719/
>

It may be useful for those who could reproduce this issue to turn on those
memory corruption debug options to narrow down a bit.

CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
CONFIG_SLUB_DEBUG_ON=y
