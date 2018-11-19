Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA27C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE5B20823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AX7Qab9t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE5B20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbeKTEk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:40:57 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:46457 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730083AbeKTEk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:40:57 -0500
Received: by mail-wr1-f52.google.com with SMTP id l9so20216559wrt.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 10:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Jo/DPwH7sG0FfcZjqR7we98z5xl8VZZczpwyRKKxYq0=;
        b=AX7Qab9tPJWFGC1/Aeg6oL1iLmHAlCDBh12aQxFuGMnGmnlNJixZHpmu7wrTOGeX+a
         yMnXunCKG3lZWg5AZNHg+X+MUnHXTC0dOe3DdNQRDHjjM6sn3BFQfjvXloVzSh9r3f2J
         +SaOEUL8+zcIirFHCIsJJyOF9Zo4UIbhFyphQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Jo/DPwH7sG0FfcZjqR7we98z5xl8VZZczpwyRKKxYq0=;
        b=LW4iz+7P31t4AbgBB4xmAkNTtIN/Ir+TMip1vX3Y8kSulEdA2AjTie/vj59WrTqU3g
         7btVVvw/MTE8LVpUfHxcTaCx050FH+qIBfdvWwFA4Os1Vlc+O1Wv03dhq0reFyAPxzhV
         yugdXqH/YI+32QEi26EzjSI1EZtCUfLEwYbuqGyHEImd9jzTOfB/5PzN+PIjDYyz5psx
         +KrFXhRf7jqdCI5fhsyxgSK1FEFpSVndZvmfRLzClG+UMaJZp4rg1OT3D9usKhH1vnIz
         289qkYaevC0PXgdfuKAMscSS7OInh/LZwRy+HeSzI8AG2mL4pOCeTxmhGNq7HNTf+9Xp
         YX2A==
X-Gm-Message-State: AGRZ1gLEf3YDppZphWAo85dUukRHwb/f6abTU/I/5477SYWeFhUzrBRW
        e6ZPGfJ8Sovq7PEBGTd5cx5hb4NnRERNpEOlf7XfUA==
X-Google-Smtp-Source: AJdET5eRPLZtTsZBgmKbP9WAcRB7I3cGPCyc0Kos8y9AOmRKuGz1tsIBbIC35XhqFDgaAhORj3dYHOp0lKsVbPzsmGA=
X-Received: by 2002:adf:c189:: with SMTP id x9-v6mr19783689wre.233.1542651376169;
 Mon, 19 Nov 2018 10:16:16 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a1c:23d8:0:0:0:0:0 with HTTP; Mon, 19 Nov 2018 10:16:15
 -0800 (PST)
In-Reply-To: <20181119141003.6470-1-smuchun@gmail.com>
References: <20181119141003.6470-1-smuchun@gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 19 Nov 2018 10:16:15 -0800
Message-ID: <CALAqxLUUpGfDzOoDyPA4LFyzFyVmiT4wKLUWa5Tin8eypJBCDQ@mail.gmail.com>
Subject: Re: [PATCH] timers: Make the lower-level timer function first call
 than higher-level
To:     Muchun Song <smuchun@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 6:10 AM, Muchun Song <smuchun@gmail.com> wrote:
> The elements of the heads array are a linked list of timer events that
> expire at the current time. And it can contain up to LVL_DEPTH levels
> and the lower the level represents the smaller the time granularity.
>
> Now the result is that the function, which will be called when the timer
> expires, in the higher-level is called first than the lower-level function.
> I think it might be better to call the lower-level timer function first
> than the higher-level function. Because the lower-level has the smaller
> granularity and delay has less impact on higher-level. So fix it.

Interesting.

Do you have any specific examples of where this was helpful?  Maybe
data on how much this helped the case your concerned about?

thanks
-john
