Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE01C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87AA2154D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f4/UCATN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87AA2154D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbeHOUiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 16:38:55 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:39359 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729363AbeHOUiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 16:38:54 -0400
Received: by mail-it0-f67.google.com with SMTP id g141-v6so3023593ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 10:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gvkXHUkutAbxHKXWFMOvjhVg9DMQjImVZPzp/JHSpqg=;
        b=f4/UCATN0PR9DDqGemIkmc1A3QPm0KMze/c7/Up7YyREU9lDPWmrZs4PcWldLw0it2
         ASwmPNaqvFxm0oBwG4rUI73QS6QkZX4EZMwGstyBM00sLv1wjcefKwh5+g8NaX5QP6wE
         uqTmuwLmVBf4llZG0oqeD/dkY9CwvXx1tzxi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gvkXHUkutAbxHKXWFMOvjhVg9DMQjImVZPzp/JHSpqg=;
        b=QOMqVeGWL0AeprZ4rVoSKLNQbghbljxqMWGJW1wd//ASESg3JXc026o62uVdBU7ito
         uywoPDk5a5M1Lm6VVuEdzQB3SfWPOB4186L0dik9zCDEKz5h8MZqOtfzGcOZhxKiXPRL
         ua3pLo7FTgDOte9ybgOUSM9DvSUdVLlAEYrVE0dt8inp0GBcgXFRn9ZxpzhpFFC3N3Ae
         Ljquq4XKmButO53OZ0sKkZ6BvwRsQ9FvFpuBWbhpAMqKTXx37zoSPgVmmFcwiNFhY2xg
         thxRu4f7WvvrawL3n3s8dlGJQinMPxQM1yaouvzVQS9mSF4KRBMysglf4PS7d7hlc2J8
         50Bw==
X-Gm-Message-State: AOUpUlE+i5Ag6vDebLhK3IiVQKQceqbfBhzLDxoG4J6s7/31B65EkJv7
        qi6rxo+M3YtZ/waubF4B4DHk+HYwq0J8H0m4W8+WxmGq
X-Google-Smtp-Source: AA+uWPzYeTCHIE7CzLoLdyuBPrJm030ia/wQ18T0OIqzlltInjAhFNrMIi2Ix8N+9WqjKCMCEM7QeIAp6gt125l4xvg=
X-Received: by 2002:a24:5002:: with SMTP id m2-v6mr18461050itb.16.1534355147838;
 Wed, 15 Aug 2018 10:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180815100053.13609-1-yannik@sembritzki.me> <CA+55aFx2goMXj7rQg-qx-puiiWYJmkDMU1xniWEu6ikDBNgfdQ@mail.gmail.com>
 <654fbafb-69da-cd9a-b176-7b03401e71c5@sembritzki.me>
In-Reply-To: <654fbafb-69da-cd9a-b176-7b03401e71c5@sembritzki.me>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Aug 2018 10:45:36 -0700
Message-ID: <CA+55aFz4J+B7jvxVAGkjdsDJQff46WU2oo00_HaktncFigmxmA@mail.gmail.com>
Subject: Re: [PATCH] Fix kexec forbidding kernels signed with custom platform
 keys to boot
To:     yannik@sembritzki.me
Cc:     David Howells <dhowells@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 10:27 AM Yannik Sembritzki <yannik@sembritzki.me> wrote:
>
> Would this be okay?

No, I meant that it would have to go into the proper header files, and
also be used by verify_pkcs7_signature() and pkcs7_preparse() etc, so
that you could actually grep for this, and understand what it does.

Right now you have to know about the magic. Or follow the call chain
down and look, like I did.

Side note, it should probably be

  #define TRUST_FULL_KEYRING ((struct key *)1ul)

instead, so that it is also type-safe (using "void *" means that it
would work almost anywhere, but it really should be a "struct key *".

And I'd like to see a comment from the kexec people too, I guess.

             Linus
