Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89767C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C0920851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PTtrwXyo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C0920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbeLKST3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:19:29 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44309 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbeLKST3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:19:29 -0500
Received: by mail-lf1-f68.google.com with SMTP id z13so11484786lfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 10:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lj0p4F+Wqt8o2/eaaV6cPeKTzG8Y+EbESwMhilDDlF8=;
        b=PTtrwXyoVgYMfspHGAPHJ+Xc2iHt3h/8IvorKcg5cgjE1FuN7UPyjFzo5uIjfsNm1a
         XYLRq42Lgk7H72zQ9XXWO/naWP7ycT7UCtueu1YIBrL+2MTgfaSFDAjaNpfC5DCEKGLY
         OfZscA5X6TmpOyyo5FI2POLZf0HLgezErMEC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lj0p4F+Wqt8o2/eaaV6cPeKTzG8Y+EbESwMhilDDlF8=;
        b=NAwLbNwlnoF+xAHrbQO2aXzEm6L1JUQr3iHo023qDmhQ4IZsWxzAhehiYMoWWz+Tap
         0N5HgKKCmeLz0maNvGaAkw7DDH1Hzg0uDBReXb++wWUh8YhS0OP3XrcZbDUG11HM3rrN
         6evxXnH9uCzLVByXwSHT16yfmhDR/B5+zbwJDDFn+SgKyH/5xv4zKzFfsCOyv3XIhXsf
         aJ0kNa5Oi6VAjccMNQdGET0lCBxdHv+drsBAnqvKSsxIkEyGt4KFA3cywUc9q4ycGkgY
         5PGqWKm/x8ezBbxyA8LqTYWaPXFiPWkn7v2ye0j5fKN286hnfx6NJHd6wRUcReRO8gLr
         otcg==
X-Gm-Message-State: AA+aEWZbgV/wxhx2TFDBxy6hYU8jPOMBqKbRiWbU8fE5fry6BN4I0N4z
        qiS6VexDrnAvGTgY/HqXs4/YFVSUupc=
X-Google-Smtp-Source: AFSGD/UCAMbSnRFNYyCwSb2w2CGSOoIvty0NLVXHmxLLoQNlJ17OPY2hTp1w+AvurVhn9LjgeNdYCg==
X-Received: by 2002:ac2:4215:: with SMTP id y21mr9908283lfh.6.1544552366358;
        Tue, 11 Dec 2018 10:19:26 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id o5-v6sm2814185ljh.75.2018.12.11.10.19.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 10:19:25 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id c16so11481167lfj.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 10:19:24 -0800 (PST)
X-Received: by 2002:a19:982:: with SMTP id 124mr9668394lfj.138.1544552364547;
 Tue, 11 Dec 2018 10:19:24 -0800 (PST)
MIME-Version: 1.0
References: <20181211152113.8523-1-thomas.preston@codethink.co.uk>
 <20181211152113.8523-3-thomas.preston@codethink.co.uk> <CAHk-=wi2kvoDh3z_X3ZCBcyAX1MU4OedPkQjA-4=bR=6q7AT3w@mail.gmail.com>
 <20181211180458.GE10650@smile.fi.intel.com>
In-Reply-To: <20181211180458.GE10650@smile.fi.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Dec 2018 10:19:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiDkpCdOdEHeSHKVwr6d5RJdVn7mLZaJO-mZkR=7hYkCA@mail.gmail.com>
Message-ID: <CAHk-=wiDkpCdOdEHeSHKVwr6d5RJdVn7mLZaJO-mZkR=7hYkCA@mail.gmail.com>
Subject: Re: [PATCH 2/2] vsprintf: Stop using obsolete simple_strtoul()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     thomas.preston@codethink.co.uk,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>, geert+renesas@glider.be,
        Jonathan Corbet <corbet@lwn.net>, tcharding <me@tobin.cc>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        ben.dooks@codethink.co.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 10:05 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> I think it's slightly more complicated, I run the following test case on glibc:
>
>         uint32_t hi, lo, t;
>
>         sscanf("00fafafafa0d0b0b0b0c000000", "%8x%8x%x", &hi, &lo, &t);
>
> 64-bit:
>         HI: 00fafafa LO: fa0d0b0b (c000000)
> 32-bit:
>         HI: 00fafafa LO: fa0d0b0b (ffffffff)

But that's exactly the values my pseudo-code gets (well, my
"pseudo-code obviously just said

    // Now do "sign" and range checking on val

The three sub-parts are: "00fafafa" "fa0d0b0b" and "0b0c000000"

and the third one encounters an overflow in "long" on 32-bit, so it
turns into ~0.

And yes, the 64-bit "long" in that third value gets truncated to
"uint32" when written to "t" (which is wht that "0b" part just gets
lost.

And that's just because of historical C scanf behavior. There's no
overflow checking in "int". Only in "long" and "long long".

                Linus
