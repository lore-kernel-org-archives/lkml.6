Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655CEC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB42218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbfAXTOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:14:35 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:38284 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfAXTOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:14:34 -0500
Received: by mail-ua1-f65.google.com with SMTP id p9so2394789uaa.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 11:14:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ecRdz3u2fB7hyoMkLTlDiH5Xzlx1hzaFWgNumlTvb0=;
        b=C8HbUXUWV8gIb6UPB/EnDXFLQUf32PP3sjrbqWpcev10ucW0Kwel64zb5HeMZQ4zIi
         HfZDFyWae9cPTKFRQdWxG+lmAp5+GlciuK8wT/BJ21bbaMRwkUQsnAs1L3DILlTZEqgb
         mV7TwzXAVoMVOcndaYb+c0dGk+693AyJibmJcnhEs5i9GwWj0+kQCIF08K0Qj7SJVA2I
         QZeT/hjlnMMnwDbH8PLniTqeRVCxwUyVRGmyFS8I+SzEMtJc4goiiGjYnJwlGGwOsjZ6
         ib68ofnRvX57WebXZ+xt7R7omLTg2a9t1E0oSdDFyyAoJer53E7gk2yTXV5eEQxUS9xd
         h8vQ==
X-Gm-Message-State: AJcUukdjpxrW7fTowCfyWJWFMcQB1ol0zTW+HRtMFBsuaxKXMfvYBqoO
        MxNupyjqgIYJMXNvi9HovGV1b4heUyGMZJHa1Toqnw==
X-Google-Smtp-Source: ALg8bN5SHxXNVTJ36AhkvUmq/t3tqAD6l+6DXJ4URySsuAKkra7ByG99/I8e3qf7deNLiDpwUx1vcH3NDo/5lJCt8Wc=
X-Received: by 2002:ab0:64d4:: with SMTP id j20mr3284930uaq.86.1548357273759;
 Thu, 24 Jan 2019 11:14:33 -0800 (PST)
MIME-Version: 1.0
References: <20190124185415.29830-1-will.deacon@arm.com> <20190124190405.GB32078@kroah.com>
In-Reply-To: <20190124190405.GB32078@kroah.com>
From:   David Airlie <airlied@redhat.com>
Date:   Fri, 25 Jan 2019 05:14:22 +1000
Message-ID: <CAMwc25rkgQDR6huvJ+9FCaVtL2NNMowoWZhEo3Vei2EG68mO1Q@mail.gmail.com>
Subject: Re: [PATCH stable-4.9.y] locking/qspinlock: Pull in asm/byteorder.h
 to ensure correct endianness
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 5:04 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jan 24, 2019 at 06:54:15PM +0000, Will Deacon wrote:
> > From: Dave Airlie <airlied@redhat.com>
> >
> > This commit is not required upstream, but is required for the 4.9.y
> > stable series.
> >
> > Upstream commit 101110f6271c ("Kbuild: always define endianess in
> > kconfig.h") ensures that either __LITTLE_ENDIAN or __BIG_ENDIAN is
> > defined to reflect the endianness of the target CPU architecture
> > regardless of whether or not <asm/byteorder.h> has been #included. The
> > upstream definition of 'struct qspinlock' relies on this property.
> >
> > Unfortunately, the 4.9.y stable series does not provide this guarantee,
> > so the 'spin_unlock()' routine can erroneously treat the underlying
> > lockword as big-endian on little-endian architectures using native
> > qspinlock (i.e. x86_64 without PV) if the caller has not included
> > <asm/byteorder.h>. This can lead to hangs such as the one in
> > 'i915_gem_request()' reported via bugzilla:
> >
> >   https://bugzilla.kernel.org/show_bug.cgi?id=202063
> >
> > Fix the issue by ensuring that <asm/byteorder.h> is #included in
> > <asm/qspinlock_types.h>, where 'struct qspinlock' is defined.
>
> That is crazy...

You've no idea, we've spent a couple of days at LCA figuring it all out :-)

Dave.
