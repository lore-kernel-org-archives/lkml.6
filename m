Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965630AbeEIRBp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:01:45 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:37683 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934820AbeEIRBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:01:43 -0400
X-Google-Smtp-Source: AB8JxZrcKKGEDYQsTF4T9QHTdV0iBrRo6+9jf5XnWTYl6MKkfmcYhLaKGs3YxEW/W81cc7qQL+6vd9FnAolpZPXdrfc=
MIME-Version: 1.0
In-Reply-To: <4baffc55-510e-96d3-3487-5ea09f993a0c@redhat.com>
References: <20180509004229.36341-1-keescook@chromium.org> <4baffc55-510e-96d3-3487-5ea09f993a0c@redhat.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 9 May 2018 10:01:41 -0700
X-Google-Sender-Auth: eHxeIp7CI8-ltxdgKBOlK_0xX4s
Message-ID: <CAGXu5jKXq7--CYgp8Q+k00RjjGJY+o71RMr51NPuWS1eM0KX1w@mail.gmail.com>
Subject: Re: [RFC][PATCH 00/13] Provide saturating helpers for allocation
To: Laura Abbott <labbott@redhat.com>
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 9, 2018 at 9:08 AM, Laura Abbott <labbott@redhat.com> wrote:
> On 05/08/2018 05:42 PM, Kees Cook wrote:
>>
>> This is a stab at providing three new helpers for allocation size
>> calculation:
>>
>> struct_size(), array_size(), and array3_size().
>>
>> These are implemented on top of Rasmus's overflow checking functions,
>> and the last 8 patches are all treewide conversions of open-coded
>> multiplications into the various combinations of the helper functions.
>>
>> -Kees
>>
>>
> Obvious question (that might indicate this deserves documentation?)
>
> What's the difference between
>
> kmalloc_array(cnt, sizeof(struct blah), GFP_KERNEL);
>
> and
>
> kmalloc(array_size(cnt, struct blah), GFP_KERNEL);
>
>
> and when would you use one over the other?

If I'm understanding the intentions here, the next set of treewide
changes would be to remove *calloc() and *_array() in favor of using
the array_size() helper. (i.e. reducing proliferation of allocator
helpers in favor of using the *_size() helpers.

There are, however, some cases that don't map well to
{struct,array,array3}_size(), specifically cases of additions in
finding a count. For example, stuff like:

kmalloc(sizeof(header) + sizeof(trailing_array) * (count + SOMETHING), gfp...)

This gets currently mapped to:

kmalloc(struct_size(header, trailing_array, (count + SOMETHING), gfp...)

But we run the risk in some cases of having even the addition
overflow. I think we need to have a "saturating add" too. Something
like:

kmalloc(struct_size(header, trailing_array, sat_add(count, SOMETHING), gfp...)

It's a bit ugly, but it would cover nearly all the remaining cases...

-Kees

-- 
Kees Cook
Pixel Security
