Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225F1C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE10D2172A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 18:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hTRiRWMa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE10D2172A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbeHNVmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 17:42:54 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43251 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbeHNVmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 17:42:54 -0400
Received: by mail-yw1-f67.google.com with SMTP id l189-v6so16984540ywb.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 11:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BnqGdlg96kKKv3HwIazjvlSjLQmPmOEsMcp+8M4NhFw=;
        b=hTRiRWMaP6jmCpC23poVmNAIh7bgZy/7QWtpX3ZhPd9gEmbACDAqFPFm2apU/U8Z7d
         nLbc/HLEYN40vQseZH+8ELGbWWB1ejfPsL/7Xjkd4b+RikJbMAALPG9Uhc1z/jfQx/VT
         AWExgBxmP1zfnKRFLh7Je1nuFagUD8i3exPuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BnqGdlg96kKKv3HwIazjvlSjLQmPmOEsMcp+8M4NhFw=;
        b=Tq4gUooTrxBOniOyjBjrZe08zVLgPsbqktnsU+RahAfkQKbkNSio8ySYemYubTQLYG
         R7Gn/rQoe+MTrTr3AveZZr9L7uMwcpH5lmVCf3lLYg51YPTM+LW0jPvr3hAL0VdEUNjB
         A/E+iag+m1xi6YptXNuLSBQD4Y6ki9TtQcl0mrlSq91Zc2zTeariuiL2o6HjHebEZ9CS
         T5XQlUPVN2jBQOkgQAZXOrG53kQ7ljWZGTqVBMl5NgEW6cdFXnKjXJfwC61RtD1j3hhZ
         jRSFf6ctPD42xWY4F/c5FSM5FLiHmbdWOK0dwL5mCCYbrj6Vp50tQJvtWkBQYswKrEiO
         8ifA==
X-Gm-Message-State: AOUpUlG9em5m9FOM5l5tj9ctM6sZTPX6MQY7GxuCtvl4X77bJpYD13EQ
        EX5opPtxcS+JjVbRg0W3M0g0ZhQfEic=
X-Google-Smtp-Source: AA+uWPzortmxAj/+ATPrsT4uLZO+Ir0hM9jyixdIL8CxtqXBPxnI+7c1cPVDClYb+GvOsi0lyf/vrg==
X-Received: by 2002:a25:df8c:: with SMTP id w134-v6mr396136ybg.27.1534272860896;
        Tue, 14 Aug 2018 11:54:20 -0700 (PDT)
Received: from mail-yw1-f53.google.com (mail-yw1-f53.google.com. [209.85.161.53])
        by smtp.gmail.com with ESMTPSA id h145-v6sm17596689ywc.3.2018.08.14.11.54.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 11:54:19 -0700 (PDT)
Received: by mail-yw1-f53.google.com with SMTP id y203-v6so16979462ywd.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 11:54:19 -0700 (PDT)
X-Received: by 2002:a25:afce:: with SMTP id d14-v6mr11785141ybj.343.1534272858508;
 Tue, 14 Aug 2018 11:54:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2316:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 11:54:17
 -0700 (PDT)
In-Reply-To: <494CFD22286B8448AF161132C5FE9A985B624E05@dggema521-mbx.china.huawei.com>
References: <1534249051-56879-1-git-send-email-yuanxiaofeng1@huawei.com>
 <20180814123454.GA25328@bombadil.infradead.org> <494CFD22286B8448AF161132C5FE9A985B624E05@dggema521-mbx.china.huawei.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 14 Aug 2018 11:54:17 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLw1=KB1J3gQRyg66MxfgOoRmZDfeM5KO57djKU_as+Xw@mail.gmail.com>
Message-ID: <CAGXu5jLw1=KB1J3gQRyg66MxfgOoRmZDfeM5KO57djKU_as+Xw@mail.gmail.com>
Subject: Re: [PATCH RFC] usercopy: optimize stack check flow when the
 page-spanning test is disabled
To:     "Yuanxiaofeng (XiAn)" <yuanxiaofeng1@huawei.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Please use contextual quoting in replies... mixing contextual with
top-posting becomes very hard to read...)

On Tue, Aug 14, 2018 at 6:02 AM, Yuanxiaofeng (XiAn)
<yuanxiaofeng1@huawei.com> wrote:
> On Tue, Aug 14, 2018 at 8:35PM Matthew Wilcox wrote:
>> On Tue, Aug 14, 2018 at 08:17:31PM +0800, Xiaofeng Yuan wrote:
>>> The check_heap_object() checks the spanning multiple pages and slab.
>>> When the page-spanning test is disabled, the check_heap_object() is
>>> redundant for spanning multiple pages. However, the kernel stacks are
>>> multiple pages under certain conditions: CONFIG_ARCH_THREAD_STACK_ALLOCATOR
>>> is not defined and (THREAD_SIZE >= PAGE_SIZE). At this point, We can skip
>>> the check_heap_object() for kernel stacks to improve performance.
>>> Similarly, the virtually-mapped stack can skip check_heap_object() also,
>>> beacause virt_addr_valid() will return.
>>
>> Why not just check_stack_object() first, then check_heap_object() second?

Most of the dynamically-sized copies (i.e. those that will trigger
__check_object_size being used at all) come out of heap. Stack copies
tend to be a fixed size. That said, the stack check is pretty cheap:
if it's not bounded by task_stack_page(current) ... +THREAD_SIZE, it
kicks out immediately. The frame-walking will only happen if it IS
actually stack (and once finished will short-circuit all remaining
tests).

> 1, When the THREAD_SIZE is less than PAGE_SIZE, the stack will allocate memory by kmem_cache_alloc_node(), it's slab memory and will execute __check_heap_object().

Correct, though if an architecture supports stack frame analysis, this
is a more narrow check than the bulk heap object check. (i.e. it may
have sub-object granularity to determine if a copy spans a stack
frame.) This supports the idea of just doing the stack check first,
though.

> 2, When CONFIG_HARDENED_USERCOPY_PAGESPAN is enabled, the multiple-pages stacks will do some check in check_page_span().

PAGESPAN checking is buggy for a lot of reasons, unfortunately. It
should generally stay disabled unless someone is working on getting
rid of allocations that _should_ have marked themselves as spanning
pages. It's unclear if this is even a solvable problem in the kernel
right now due to how networking code manages skbs.

> So, I set some restrictions to make sure the useful check will not be skipped.

It'd be nice to find some workloads that visibly change by making the
heap/stack order change. I think the known worst-case (small-packet
UDP flooding) wouldn't get worse since both checks will be performed
in either case.

(Maybe we should also short-circuit early in heap checks if it IS a
valid heap object: no reason to go do the kernel text check after
that...)

-Kees

-- 
Kees Cook
Pixel Security
