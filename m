Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB290C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C71222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="V94OLrF3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392848AbfBNB43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 20:56:29 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40561 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732533AbfBNB42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 20:56:28 -0500
Received: by mail-qk1-f196.google.com with SMTP id y16so2693436qki.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 17:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3CGkQT7h8Gsjs+mnP8a/TLO+n94REOr+hRiFIimk1wY=;
        b=V94OLrF3GzIKHTK8ENOjh+EcyFT4Cs0IHIonz0lHss1imeLhbyKo1NtNqOViFIBhwC
         MOpANeLX5y8Ef9b8t+RYbyDfM/URfIsoQnduvVSBSx6QZ3lD2zrnnKPWDeFnEEkgNuwE
         cZPuCFXyIOsbe1ZfXw0wN86i2n6gc8mVCsptN9BQxACkns9DJJ06RqXGqQzGMWEK7jTb
         7f5chmTyDSEMgu7sK7pVtXuNR5WEZiZhIYw3GKZmiVkBgHlrVIMNQ3x1NU0ny8leJDoU
         x9BVrPNnwc/siVUYjock6uEXkpe3ZZTHNbybs6FWS/ZHvnDsjLKt1uTXaj+lpZj8HRIg
         R8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3CGkQT7h8Gsjs+mnP8a/TLO+n94REOr+hRiFIimk1wY=;
        b=jmnb8NxABPv/Ts8v8D6ySNtldPb8LLdCr0VK8cowWWtsrFouO6VND0Bw/zYRREQOXy
         dwinhKpzQbB4isEuaGiG1uflGZ0SLNpYSsJ1T4pTLIYQRYtISVc3bde1dUC4q+CN4h09
         o5iGmvib53s3IXdSh57+QHe8htTG6r+iV7wmLp7D5aF/upSAjbR4zbHLbEiK57C3YL6h
         mGl9pGtLOtnasV3qDeTboG3NVnR27pRfxSh52UqL0iIK3eDkQkneS+b4urYR8GhhyxuM
         Y332/Y/O2OJlFZFwyNmz6pdI+Gv12YesJqyo5GYKQ201sn67wjFJVQxG0PA4oe3hlKHb
         lZSA==
X-Gm-Message-State: AHQUAuZRghoAIv92Kv/RD+9BKbkP4NFsXzkqp4Kd1VlAcWwtGLAXE43V
        UkvGwuzIutiFb3zD7b8mXFGywg==
X-Google-Smtp-Source: AHgI3IYCzJNRF4MvwhSX1BX9K5QGZEqqnvfISRM/7ZAiUwGzaHzTtHfFbzqRMWIt/8Zrl/w46VbOXA==
X-Received: by 2002:a37:b46:: with SMTP id 67mr909438qkl.161.1550109387183;
        Wed, 13 Feb 2019 17:56:27 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id a19sm56287qth.50.2019.02.13.17.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 17:56:26 -0800 (PST)
Subject: Re: [PATCH] kasan, slub: fix more conflicts with
 CONFIG_SLAB_FREELIST_HARDENED
To:     Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>
References: <bf858f26ef32eb7bd24c665755b3aee4bc58d0e4.1550103861.git.andreyknvl@google.com>
 <CAAeHK+z=ft93RNx7rvq1QFr3kiOFVzBVACEFN4fL8nbEVOEXKA@mail.gmail.com>
From:   Qian Cai <cai@lca.pw>
Message-ID: <d3cc9a82-d51c-e493-da2e-94903d5330a6@lca.pw>
Date:   Wed, 13 Feb 2019 20:56:25 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAAeHK+z=ft93RNx7rvq1QFr3kiOFVzBVACEFN4fL8nbEVOEXKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/13/19 7:27 PM, Andrey Konovalov wrote:
> On Thu, Feb 14, 2019 at 1:25 AM Andrey Konovalov <andreyknvl@google.com> wrote:
>>
>> When CONFIG_KASAN_SW_TAGS is enabled, ptr_addr might be tagged.
>> Normally, this doesn't cause any issues, as both set_freepointer()
>> and get_freepointer() are called with a pointer with the same tag.
>> However, there are some issues with CONFIG_SLUB_DEBUG code. For
>> example, when __free_slub() iterates over objects in a cache, it
>> passes untagged pointers to check_object(). check_object() in turns
>> calls get_freepointer() with an untagged pointer, which causes the
>> freepointer to be restored incorrectly.
>>
>> Add kasan_reset_tag to freelist_ptr(). Also add a detailed comment.
>>
>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> 
> Reported-by: Qian Cai <cai@lca.pw>

Tested-by: Qian Cai <cai@lca.pw>
