Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94308C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330112086E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 09:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlTTF47U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330112086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbeGLJLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 05:11:49 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:42067 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeGLJLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 05:11:49 -0400
Received: by mail-vk0-f68.google.com with SMTP id t4-v6so15844497vke.9;
        Thu, 12 Jul 2018 02:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YaHS3fa20mvkoVRI7l0uzliqKqjYEdHgj5srKj8agw4=;
        b=TlTTF47UYs0/MRSUYfE0raHybmRWpI7aP1tj/NjpaYlyAPb27CJwuzYJUIgUhOC/Ps
         dE6TPPKBVd7Gqs4v+B3ngj3GUqzwfyCL8tASNvApND1bLJp2SCe+EXFT7IxIEit39aGn
         qHiIcqv4t4APqOAeXbA6x1bbjnrjiYH0XfKa3eKJn708mq/MomvshLurocSpU6xDHTqX
         cU6EYbemr0ofni6reejuxN/o2youSG5izJFB5YBbHQtkv+2NLAOa6u+rWwYGsTNYXD2o
         3BJ0ns1Q+YAUjaU2Zzn/DNAwrRnL2Pi1d3ns3+0NmxS34E4ICkgq+ChAxZvAtWSU/V02
         SLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YaHS3fa20mvkoVRI7l0uzliqKqjYEdHgj5srKj8agw4=;
        b=Qupkc59gqMNEvXknWj9BoBzjb8ZVMyCtodak/xS4WtDaWC+xJtOZ5b5FLPKgdn0dZ+
         dStWhmgxC/JnuXA4NyyKh9/Qq6oXwS92Hh3EoXl9xPUKyG91lfJUoU66EKXN8gHSjGHA
         q7tw395WL3mZB+B79hB+i4/x72qzw8XaQArt7owuE0LQl2pwWxB68i47ZCM30UPpKQ7e
         b3Xb04tprdHHqby2qqlWnGDaEQ6W4UCagTNWplNA3kXLx4Zr+GOKvOidWM4uGdzW/dLL
         8n4eH20hf0WrcAg34YevQ4RdXcN/V5Zt0tgLwJ+rfp6jXRtqjzhx2/TVL9d53O5EpyvA
         Sirw==
X-Gm-Message-State: AOUpUlHQCg0A3nRqm+SuBF68m4x4y20sqCY/J0QK7MaQ0l/AcDrXqvlQ
        z2TZsfBdctGZUFfIAmJk+FMERRWGgi8jnXJWeFQXZg==
X-Google-Smtp-Source: AAOMgpeJlN7cMhamX4sWdx8jTK5JxC0QqONmlhufmIJhgeUEzjNrW0afhim0huKLddvpIsEE8smWVheL7DSqCMQoh7Y=
X-Received: by 2002:a1f:20d4:: with SMTP id g203-v6mr697022vkg.176.1531386189349;
 Thu, 12 Jul 2018 02:03:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 02:03:08
 -0700 (PDT)
In-Reply-To: <20180711160744.32074-1-tycho@tycho.ws>
References: <20180706212220.GC3583@cisco.lan> <20180711160744.32074-1-tycho@tycho.ws>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 12 Jul 2018 12:03:08 +0300
Message-ID: <CAHp75VfQe4p_z1uAoq87F6zqaCbqKG1ZgHeK55fjwkFGNtMK0A@mail.gmail.com>
Subject: Re: [PATCH v4] uart: fix race between uart_put_char() and uart_shutdown()
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 7:07 PM, Tycho Andersen <tycho@tycho.ws> wrote:

> Anyway, since the lock is not acquired, if uart_shutdown() is called, the
> last chunk of that function may release state->xmit.buf before its assigned
> to null, and cause the race above.
>
> To fix it, let's lock uport->lock when allocating/deallocating
> state->xmit.buf in addition to the per-port mutex.

>     * use the result of uart_port_lock() in uart_shutdown() to avoid
>       uninitialized warning
>     * don't use the uart_port_lock/unlock macros in uart_port_startup,
>       instead test against uport directly; the compiler can't seem to "see"
>       through the macros/ref/unref calls to not warn about uninitialized
>       flags. We don't need to do a ref here since we hold the per-port
>       mutex anyway.

> +       if (uport)
> +               spin_lock_irqsave(&uport->lock, flags);

> +       if (uport)
> +               spin_unlock_irqrestore(&uport->lock, flags);

At some point it It was uart_port_lock()/uart_port_unlock(), and you
changed to simple spin lock. The macro also take reference to the
port. Do we aware about that here?

-- 
With Best Regards,
Andy Shevchenko
