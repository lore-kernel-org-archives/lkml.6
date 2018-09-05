Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54548C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DDF72077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WS3KY9Wl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DDF72077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeIEUfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 16:35:10 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:33359 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbeIEUfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 16:35:10 -0400
Received: by mail-yb1-f196.google.com with SMTP id m123-v6so2895647ybm.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 09:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=VNRbT61f9XqZrz7We7IC/lTsql9rSwq2esxyN+EbK1g=;
        b=WS3KY9WlCwCFxeXgLouywxLowJBu0ucVmeuMplMcALsRjhUsRtNmP9+VVc09pERZB1
         c6j5EwLe7inH7Indhrm2L4WLLZTE9G0692WCGNHGp2RGQTqykatPEqc8GNwHSS3UnZ97
         dj7MRCbNY/h/wXO82xo6AcaR4ZMihoyf10xlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=VNRbT61f9XqZrz7We7IC/lTsql9rSwq2esxyN+EbK1g=;
        b=OwHHL0PI0c2Q7EHvKMwcJitAEiob1t9MX4G6AiCwqeyuS//I9PteesxKHfRfYO+DTU
         PB5g3tjKbr5wjVScVtryDtiywJG487wGjMS5VxpBau6sB1CPfPFJfReiMoOrVZKoMr1w
         dgv4ZH9jxbib51OjQUcM0YRMPfVO78kqupUOJntAZj3f4RW1o02tgeHaubU6GgIX0lWn
         r2VDxeQXX87JqalqvUnc8NOvEtzo5BRgBhXk6udmr4mqDG6+LOAVl/d247xJp+JqhBa7
         UgNudAARQER+lXhJI/w9zUei7JrTiK3bJOHCzFErbVeHfPYtNp8ZDJ4d6j8hUcCifD1P
         bgXA==
X-Gm-Message-State: APzg51DNpDkL5bxaavcim2+ayaEMMC1ZmHEpglfvXbUB5AUfS+9qfQmr
        CX278DoixaX3X08dvVan8gBe/MsMtk0=
X-Google-Smtp-Source: ANB0VdYgxukZcRJhG0bxFJKAt3bKB0k+4YMccD3AWyrry1rQomtrK5McDulJqpngEOo5UO8Tfgm4sw==
X-Received: by 2002:a25:6b41:: with SMTP id o1-v6mr11644037ybm.319.1536163458368;
        Wed, 05 Sep 2018 09:04:18 -0700 (PDT)
Received: from mail-yw1-f45.google.com (mail-yw1-f45.google.com. [209.85.161.45])
        by smtp.gmail.com with ESMTPSA id m82-v6sm1078103ywm.19.2018.09.05.09.04.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 09:04:16 -0700 (PDT)
Received: by mail-yw1-f45.google.com with SMTP id l9-v6so2835915ywc.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 09:04:16 -0700 (PDT)
X-Received: by 2002:a81:98d7:: with SMTP id p206-v6mr21312320ywg.353.1536163455561;
 Wed, 05 Sep 2018 09:04:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 09:04:14 -0700 (PDT)
In-Reply-To: <20180905083320.GA28462@soda.linbit>
References: <20180806233216.GA6037@beast> <CAGXu5jKA6_aZpDXB2UurmW5cEGEC7aMcq=qvJGPVAifjnk17ug@mail.gmail.com>
 <CAGXu5jLyynGbnuhwabbViwzvRFzn-Vj5ktYOrypRGj_qk8UvQw@mail.gmail.com> <20180905083320.GA28462@soda.linbit>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 5 Sep 2018 09:04:14 -0700
X-Gmail-Original-Message-ID: <CAGXu5jL3Pw3s0r1kebQy_9xVDrtNnCqbRTAEqsa_GwK-eAWMkg@mail.gmail.com>
Message-ID: <CAGXu5jL3Pw3s0r1kebQy_9xVDrtNnCqbRTAEqsa_GwK-eAWMkg@mail.gmail.com>
Subject: Re: [PATCH v7] drbd: Convert from ahash to shash
To:     Kees Cook <keescook@chromium.org>, Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block <linux-block@vger.kernel.org>,
        drbd-dev@lists.linbit.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 1:33 AM, Lars Ellenberg
<lars.ellenberg@linbit.com> wrote:
> On Tue, Sep 04, 2018 at 08:04:18PM -0700, Kees Cook wrote:
>> On Mon, Sep 3, 2018 at 11:04 PM, Kees Cook <keescook@chromium.org> wrote:
>> > On Mon, Aug 6, 2018 at 4:32 PM, Kees Cook <keescook@chromium.org> wrote:
>> >> In preparing to remove all stack VLA usage from the kernel[1], this
>> >> removes the discouraged use of AHASH_REQUEST_ON_STACK in favor of
>> >> the smaller SHASH_DESC_ON_STACK by converting from ahash-wrapped-shash
>> >> to direct shash. By removing a layer of indirection this both improves
>> >> performance and reduces stack usage. The stack allocation will be made
>> >> a fixed size in a later patch to the crypto subsystem.
>> >>
>> >> The bulk of the lines in this change are simple s/ahash/shash/, but the
>> >> main logic differences are in drbd_csum_ee() and drbd_csum_bio(), which
>> >> externalizes the page walking with k(un)map_atomic() instead of using
>> >> scattergather.
>> >
>> > Hi Lars! How does this look to you? If you can Ack I assume Jens would
>> > be able to take this.
>
> Sure, I should have ACKed it a month ago already.  As I said, I believe
> you the crypto. And you added the kmap_atomic as I pointed out.
> All good.

Great, thanks! Jens, can you take this?

>> FWIW I've tested a simple drbd configuration before/after this change
>> and things seem to be working correctly.
>
> You'd need "data-integrity-alg" set (or "verify-alg", and then have it
> do an online-verify) to excercise the crypto stuff,
> and you'd need a highmem system (are these still out there?)
> to have the kmap not be a no-op.  But I don't see any potential problem.

While I don't have a highmem system, I've confirmed that
data-integrity-alg and verify-alg are both working for me.

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
