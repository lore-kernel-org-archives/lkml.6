Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E24C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 01:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85CA214F1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 01:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cIwchEGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85CA214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389168AbeKPLVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 06:21:15 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:46892 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbeKPLVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 06:21:15 -0500
Received: by mail-yb1-f193.google.com with SMTP id i17-v6so9140064ybp.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 17:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uUdYXNvl55K6wbXFRulAc5o6dhQhJefkXW0PQayrit4=;
        b=cIwchEGEnUsMqjXIxz0LS+acI+fQ0jV+ZASQI3BU/8MlV31pEG4dGbD25qwSOBYltP
         eT7GWey09+0CIOe+/xxrSMUZX6L2wG1sVYngWfSIMRZgytmsjFm7JBHE3f1TChXu+aNi
         Eel0OKO18FSVj86k12JUjjp0eYVDxWnkJUV+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uUdYXNvl55K6wbXFRulAc5o6dhQhJefkXW0PQayrit4=;
        b=pSeXUWZU94nrvjWwV4Z4ed6GK7o78R30UiyQsRkdWu/97c6Una7vvt9FbIkVD8/rRA
         D4B9L3whaInlYkVwlFG4sXkXoXaydXzOqOSzcL49bdLtDjX5PZ/qyR39Lqtd1PRFRTq8
         nykc29Kx+canRQWdzpVnd32/6F7LtuQYhqy/qMC2t4H1OEmTmXBP/xCpB9B/D9DYlzzd
         zphmUbVcXDb6sHmh9/soZgEgptrlow5JhGzbE8RvOIYlaPmNgwPqwFt5ac87t4Drs8KR
         e7/51n7fJ7NNtcG4zbrPOugFSNIVI3goJjFhU30LboKnTnZCIHOjXr0yKeZAo/BKaAgb
         S45Q==
X-Gm-Message-State: AGRZ1gKgqrzHufLdHfKMKlRg0R9LohtnkTpxYhtRYh/+kHl7VmMDPy1V
        /HwAS+/rg02z8El1cnVuFYmgaRWFIas=
X-Google-Smtp-Source: AJdET5fWWBpThuMQqsmxSyPEmYq6UAOsmnYkbuFf2TZyRgCqYJjcU8J37UVnFcLW4ed1IMl41Jf4hQ==
X-Received: by 2002:a25:5443:: with SMTP id i64-v6mr8884401ybb.287.1542330658719;
        Thu, 15 Nov 2018 17:10:58 -0800 (PST)
Received: from mail-yw1-f53.google.com (mail-yw1-f53.google.com. [209.85.161.53])
        by smtp.gmail.com with ESMTPSA id u130-v6sm7207100ywa.71.2018.11.15.17.10.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 17:10:57 -0800 (PST)
Received: by mail-yw1-f53.google.com with SMTP id p18-v6so9436540ywg.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 17:10:55 -0800 (PST)
X-Received: by 2002:a0d:d302:: with SMTP id v2-v6mr8634737ywd.124.1542330655097;
 Thu, 15 Nov 2018 17:10:55 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Thu, 15 Nov 2018 17:10:53
 -0800 (PST)
In-Reply-To: <CANq1E4T6rKjVPwGd-4CDWZzFYz1ohzPSpKGd2kK+O4BNSe--Hg@mail.gmail.com>
References: <20181114131642.21425-1-dh.herrmann@gmail.com> <ea944fb3-0cd9-e6e6-5449-faab7c9603c1@redhat.com>
 <CAGXu5jJJGg5_crJ3v+AG5JZWVGLpDvZGr0UVyurzFxcv9Fwa5A@mail.gmail.com> <CANq1E4T6rKjVPwGd-4CDWZzFYz1ohzPSpKGd2kK+O4BNSe--Hg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 15 Nov 2018 19:10:53 -0600
X-Gmail-Original-Message-ID: <CAGXu5jK35O-fGVwG4HbU-WP_YETgbTAQJpiYK8AD4mweo1WrcA@mail.gmail.com>
Message-ID: <CAGXu5jK35O-fGVwG4HbU-WP_YETgbTAQJpiYK8AD4mweo1WrcA@mail.gmail.com>
Subject: Re: [PATCH] Revert "HID: uhid: use strlcpy() instead of strncpy()"
To:     David Herrmann <dh.herrmann@gmail.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 5:55 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
> Hi
>
> On Thu, Nov 15, 2018 at 12:09 AM Kees Cook <keescook@chromium.org> wrote:
>> On Wed, Nov 14, 2018 at 9:40 AM, Laura Abbott <labbott@redhat.com> wrote:
> [...]
>> > Can we switch to strscpy instead? This will quiet gcc and avoid the
>> > issues with strlcpy.
>>
>> Yes please: it looks like these strings are expected to be NUL
>> terminated, so strscpy() without the "- 1" and min() logic would be
>> the correct solution here.
>
> "the correct solution"? To my knowledge the original code was correct
> as well. Am I missing something?

So, yes, no one should use strlcpy():
https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy

And while I think nothing was technically wrong with the strncpy()
usage in the original version, I think strncpy() should only be used
for __nonstring cases:
https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings

>
>>                            If @hid is already zero, then this would
>> just be:
>>
>>        strscpy(hid->name, ev->u.create2.name, sizeof(hid->name));
>>        strscpy(hid->phys, ev->u.create2.phys, sizeof(hid->phys));
>>        strscpy(hid->uniq, ev->u.create2.uniq, sizeof(hid->uniq));
>>
>> If they are NOT NUL terminated, then keep using strncpy() but mark the
>> fields in the struct with the __nonstring attribute.
>
> They are supposed to be NUL terminated, but for compatibility reasons
> we allow them to be not. So I don't think your proposal is safe.

I was originally thinking only about the the hid->* strings, so I was
confused by this answer (they appear to always be NUL-terminated).
Then I thought you meant that ev->u.create2.* strings may not be
terminated, but I stayed confused. :)

The original code was:

        len = min(sizeof(hid->name), sizeof(ev->u.create2.name)) - 1;
        strncpy(hid->name, ev->u.create2.name, len);

If sizeof(hid->name) is smaller than sizeof(ev->u.create2.name), it
made sure than hid->name kept a trailing NUL.

If sizeof(ev->u.create2.name) is smaller than sizeof(hid->name), it
made sure than the last byte of ev->u.create2.name was ignored, and by
definition, hid->name would be NUL-terminated.

So you're converting from a potentially unterminated string into a
terminated string... (ev->u.create2.name maybe needs to be marked
__nonstring?)

The most you can write is sizeof(dest) - 1 but you must not read more
than sizeof(source). So I see that if the destination is smaller than
the source, you cannot represent these conditions correctly to
strscpy(). (And, I would argue, you can't with strncpy() either.)

However, they're all exactly the same size, so none of this matters,
and I think strscpy() would be the most sensible. And maybe you could
enforce the size checking:

        BUILD_BUG_ON(sizeof(hid->name) != sizeof(ev->u.create2.name));
        strscpy(hid->name, ev->u.create2.name, sizeof(hid->name));

etc...

-- 
Kees Cook
