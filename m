Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37ABFECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BF02087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xz+r7r01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9BF02087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbeJTAMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:12:47 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:33055 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbeJTAMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:12:47 -0400
Received: by mail-yb1-f194.google.com with SMTP id m184-v6so2366486ybm.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 09:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=k07tQgriygijEHZva+Rdyw1dO1Gz+TCdiZKe/B9bFSg=;
        b=Xz+r7r010MPZHUzdOYtxFp+uNSiSXeK4tXyercq+pytS37gl3CAA9jyKF9ItjO61Vr
         flhyvbwm0xAEmvNG6wzeF3pnhWU93nMeDkIlegtBibA1ALxu0PO7BVS0LlS6hhFFQy3t
         bVW/n52jvggDZpHcro2RoQ3Fw5AR/16F6yQ1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=k07tQgriygijEHZva+Rdyw1dO1Gz+TCdiZKe/B9bFSg=;
        b=ReRFT9B6+v3DGPyUq6IvVx8b0t/p4UgfSqFijzizU50fzN1rdX/ZlpicM7fdUcTGBZ
         DAvPPL2VrUNoiNami8E5aw7+ayPToRh0Ea9R7tiwp7U4kBz5vU+27yCo9yMGrABKPO0W
         9nhT7J4VgFugynNFgQ8D3j9A1SCcAo3RjtSJct4l+sbQfXEg4be0eY+6SqlrGT/+Flpb
         GLXcTKBHGhl9QSKL74GOZEyAfT50bQXcRCU1hOs7KjZqd4uaBM0ve2u2RsJ6DZmmi0bg
         13yVSgKNpp4aNU/Kh/RDlR4ynqpBKwk93ZJKsf0v7KKKNQ2lnOiNGc5q+o1NxtZXjbR3
         BZnQ==
X-Gm-Message-State: AGRZ1gJ98hSTLWyEqL0q9FhLfkW6YEZ/JUFE2inG5/AouRvjrHzT8qWI
        7vpZz0+dIOIxhENXwkcgHVjm3HjdVFo=
X-Google-Smtp-Source: AJdET5fwDQV0vulZUozwl0Ize0RKIx7GWMSYjnO1QU+j8xRH5LkFdPYChuwk7IcxK34d2QjC29a4xA==
X-Received: by 2002:a25:ad5d:: with SMTP id l29-v6mr1287657ybe.398.1539965162267;
        Fri, 19 Oct 2018 09:06:02 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id r8-v6sm9574309ywa.56.2018.10.19.09.05.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 09:06:00 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id x5-v6so13444760ybl.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 09:05:59 -0700 (PDT)
X-Received: by 2002:a25:7643:: with SMTP id r64-v6mr3630700ybc.403.1539965158327;
 Fri, 19 Oct 2018 09:05:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Fri, 19 Oct 2018 09:05:57
 -0700 (PDT)
In-Reply-To: <20181019154948.GD16771@arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-8-kristina.martsenko@arm.com> <20181019111542.6wrvjguirglzg7vg@mbp>
 <20181019112404.GD14246@arm.com> <CAGXu5j+2axuzPJji_eCvMZDiPvrPsP3kAnG0CY_rsL5c=uFQFA@mail.gmail.com>
 <20181019154948.GD16771@arm.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 19 Oct 2018 09:05:57 -0700
X-Gmail-Original-Message-ID: <CAGXu5jK8OK+430FQtztwVD8B95_SCjTWoysZXBdkZaDeSiV+ow@mail.gmail.com>
Message-ID: <CAGXu5jK8OK+430FQtztwVD8B95_SCjTWoysZXBdkZaDeSiV+ow@mail.gmail.com>
Subject: Re: [PATCH v5 07/17] arm64: add basic pointer authentication support
To:     Will Deacon <will.deacon@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Jacob Bramley <jacob.bramley@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Adam Wallis <awallis@codeaurora.org>,
        "Suzuki K . Poulose" <suzuki.poulose@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Amit Kachhap <Amit.Kachhap@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cyrill Gorcunov <gorcunov@openvz.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 8:49 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Oct 19, 2018 at 08:36:45AM -0700, Kees Cook wrote:
>> On Fri, Oct 19, 2018 at 4:24 AM, Will Deacon <will.deacon@arm.com> wrote:
>> > FWIW: I think we should be entertaining a prctl() interface to use a new
>> > key on a per-thread basis. Obviously, this would need to be used with care
>> > (e.g. you'd fork(); use the prctl() and then you'd better not return from
>> > the calling function!).
>> >
>> > Assuming we want this (Kees -- I was under the impression that everything in
>> > Android would end up with the same key otherwise?), then the question is
>> > do we want:
>> >
>> >   - prctl() get/set operations for the key, or
>> >   - prctl() set_random_key operation, or
>> >   - both of the above?
>> >
>> > Part of the answer to that may lie in the requirements of CRIU, where I
>> > strongly suspect they need explicit get/set operations, although these
>> > could be gated on CONFIG_CHECKPOINT_RESTORE=y.
>>
>> Oh CRIU. Yikes. I'd like the get/set to be gated by the CONFIG, yes.
>> No reason to allow explicit access to the key (and selected algo) if
>> we don't have to.
>
> Makes sense.
>
>> As for per-thread or not, having a "pick a new key now" prctl() sounds
>> good, but I'd like to have an eye toward having it just be "automatic"
>> on clone().
>
> I thought about that too, but we're out of clone() flags afaict and there's
> no arch hook in there. We could add yet another clone syscall, but yuck (and
> I reckon viro would kill us).
>
> Or are you saying that we could infer the behaviour from the existing set
> of flags?

I mean if it's starting a new thread, it should get a new key
automatically, just like the ssp canary happens in dup_task_struct().

(Or did I miss some context for why that's not possible?)

-Kees

-- 
Kees Cook
Pixel Security
