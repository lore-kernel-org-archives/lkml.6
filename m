Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAD5C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7076A205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7076A205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbeH2Ru5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:50:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38100 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbeH2Ru5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:50:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id w11-v6so4913560wrc.5;
        Wed, 29 Aug 2018 06:53:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language;
        bh=i/RFwlcz2MLMSyfpGXsjDG/j8JbqoSula9kXCnfAqXE=;
        b=YtqF/lfoU565Z0VBhZUWqKuA+eYSb0zxNW4AApQVyN8LIme6/Vcm9MPSD9Ci2k6uv7
         W4kNqhHLoSM0UAKJsA3Cx5Sx9ydXK78DlYGDMW/dVnAtWCPjK9DGU1TmlhqK67r6JP2A
         5ja+9JHOG3usNIQHj0+rb3n/CBSrR2OmxXS5DNI16LF0kAypj1ftGG0fc06fSo7/oWDc
         Iyzd0UIv8su7eUxkd6jZH6wSmz0rpv949erb739FXVr7LD0bRoda6VG3ISE4z/74IGtW
         7kwinj6Ds/Ao6vcGtz2DYMstH4e3BpEn5Eal4mzAjq7mGDn8OkCb1CE4S7dSqQ96hRyh
         X2Lw==
X-Gm-Message-State: APzg51C3sNjBn99H9QwQsbxKJnrelRCaRz68agOtmqXjrIXfefT2qt6U
        NoeaJVeRkt7czxnt46y67d5kZYqi
X-Google-Smtp-Source: ANB0VdbkniHuY/Meif5+X/iiWA3k5NL+gtvW68srKNXL19ZxLVBjuh/xKp+HMZicEeTw3cSg0WAA/g==
X-Received: by 2002:adf:ad34:: with SMTP id p49-v6mr4598169wrc.10.1535550831334;
        Wed, 29 Aug 2018 06:53:51 -0700 (PDT)
Received: from ?IPv6:2a01:4240:2e27:ad85:aaaa::70f? ([2a01:4240:2e27:ad85:aaaa::70f])
        by smtp.gmail.com with ESMTPSA id g7-v6sm3399697wrw.30.2018.08.29.06.53.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 06:53:50 -0700 (PDT)
Subject: Re: [PATCH v2] n_tty: Protect tty->disc_data using refcount.
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     syzbot <syzbot+3aa9784721dfb90e984d@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <001a113ed31a122ced0568cc6be1@google.com>
 <db45a090-593d-23d2-e6b2-ede5b308f02f@I-love.SAKURA.ne.jp>
 <35d649ce-0c22-f839-aa4d-19733bf31a9c@I-love.SAKURA.ne.jp>
 <83fdde07-2f8e-8d20-30a2-a8f0804a5044@I-love.SAKURA.ne.jp>
 <8e83cd9a-e28c-a9f4-5f47-98f2046a5dfb@I-love.SAKURA.ne.jp>
From:   Jiri Slaby <jslaby@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 xsFNBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABzSBKaXJpIFNsYWJ5
 IDxqaXJpc2xhYnlAZ21haWwuY29tPsLBewQTAQIAJQIbAwYLCQgHAwIGFQgCCQoLBBYCAwEC
 HgECF4AFAk6S6P4CGQEACgkQvSWxBAa0cEl1Sg//UMXp//d4lP57onXMC2y8gafT1ap/xuss
 IvXR+3jSdJCHRaUFTPY2hN0ahCAyBQq8puUa6zaXco5jIzsVjLGVfO/s9qmvBTKw9aP6eTU7
 77RLssLlQYhRzh7vapRRp4xDBLvBGBv9uvWORx6dtRjh+e0J0nKKce8VEY+jiXv1NipWf+RV
 vg1gVbAjBnT+5RbJYtIDhogyuBFg14ECKgvy1Do6tg9Hr/kU4ta6ZBEUTh18Io7f0vr1Mlh4
 yl2ytuUNymUlkA/ExBNtOhOJq/B087SmGwSLmCRoo5VcRIYK29dLeX6BzDnmBG+mRE63IrKD
 kf/ZCIwZ7cSbZaGo+gqoEpIqu5spIe3n3JLZQGnF45MR+TfdAUxNQ4F1TrjWyg5Fo30blYYU
 z6+5tQbaDoBbcSEV9bDt6UOhCx033TrdToMLpee6bUAKehsUctBlfYXZP2huZ5gJxjINRnlI
 gKTATBAXF+7vMhgyZ9h7eARG6LOdVRwhIFUMGbRCCMXrLLnQf6oAHyVnsZU1+JWANGFBjsyy
 fRP2+d8TrlhzN9FoIGYiKjATR9CpJZoELFuKLfKOBsc7DfEBpsdusLT0vlzR6JaGae78Od5+
 ljzt88OGNyjCRIb6Vso0IqEavtGOcYG8R5gPhMV9n9/bCIVqM5KWJf/4mRaySZp7kcHyJSb0
 O6nOwU0ETpLnhgEQAM+cDWLL+Wvc9cLhA2OXZ/gMmu7NbYKjfth1UyOuBd5emIO+d4RfFM02
 XFTIt4MxwhAryhsKQQcA4iQNldkbyeviYrPKWjLTjRXT5cD2lpWzr+Jx7mX7InV5JOz1Qq+P
 +nJWYIBjUKhI03ux89p58CYil24Zpyn2F5cX7U+inY8lJIBwLPBnc9Z0An/DVnUOD+0wIcYV
 nZAKDiIXODkGqTg3fhZwbbi+KAhtHPFM2fGw2VTUf62IHzV+eBSnamzPOBc1XsJYKRo3FHNe
 LuS8f4wUe7bWb9O66PPFK/RkeqNX6akkFBf9VfrZ1rTEKAyJ2uqf1EI1olYnENk4+00IBa+B
 avGQ8UW9dGW3nbPrfuOV5UUvbnsSQwj67pSdrBQqilr5N/5H9z7VCDQ0dhuJNtvDSlTf2iUF
 Bqgk3smln31PUYiVPrMP0V4ja0i9qtO/TB01rTfTyXTRtqz53qO5dGsYiliJO5aUmh8swVpo
 tgK4/57h3zGsaXO9PGgnnAdqeKVITaFTLY1ISg+Ptb4KoliiOjrBMmQUSJVtkUXMrCMCeuPD
 GHo739Xc75lcHlGuM3yEB//htKjyprbLeLf1y4xPyTeeF5zg/0ztRZNKZicgEmxyUNBHHnBK
 HQxz1j+mzH0HjZZtXjGu2KLJ18G07q0fpz2ZPk2D53Ww39VNI/J9ABEBAAHCwV8EGAECAAkF
 Ak6S54YCGwwACgkQvSWxBAa0cEk3tRAAgO+DFpbyIa4RlnfpcW17AfnpZi9VR5+zr496n2jH
 /1ldwRO/S+QNSA8qdABqMb9WI4BNaoANgcg0AS429Mq0taaWKkAjkkGAT7mD1Q5PiLr06Y/+
 Kzdr90eUVneqM2TUQQbK+Kh7JwmGVrRGNqQrDk+gRNvKnGwFNeTkTKtJ0P8jYd7P1gZb9Fwj
 9YLxjhn/sVIhNmEBLBoI7PL+9fbILqJPHgAwW35rpnq4f/EYTykbk1sa13Tav6btJ+4QOgbc
 ezWIwZ5w/JVfEJW9JXp3BFAVzRQ5nVrrLDAJZ8Y5ioWcm99JtSIIxXxt9FJaGc1Bgsi5K/+d
 yTKLwLMJgiBzbVx8G+fCJJ9YtlNOPWhbKPlrQ8+AY52Aagi9WNhe6XfJdh5g6ptiOILm330m
 kR4gW6nEgZVyIyTq3ekOuruftWL99qpP5zi+eNrMmLRQx9iecDNgFr342R9bTDlb1TLuRb+/
 tJ98f/bIWIr0cqQmqQ33FgRhrG1+Xml6UXyJ2jExmlO8JljuOGeXYh6ZkIEyzqzffzBLXZCu
 jlYQDFXpyMNVJ2ZwPmX2mWEoYuaBU0JN7wM+/zWgOf2zRwhEuD3A2cO2PxoiIfyUEfB9SSmf
 faK/S4xXoB6wvGENZ85Hg37C7WDNdaAt6Xh2uQIly5grkgvWppkNy4ZHxE+jeNsU7tg=
Message-ID: <021343cd-dc28-9889-7656-e624861bc770@suse.cz>
Date:   Wed, 29 Aug 2018 15:53:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8e83cd9a-e28c-a9f4-5f47-98f2046a5dfb@I-love.SAKURA.ne.jp>
Content-Type: multipart/mixed;
 boundary="------------60B1CCB6B678BE686DBE8098"
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------60B1CCB6B678BE686DBE8098
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 07/24/2018, 05:22 PM, Tetsuo Handa wrote:
> From 118c64e86641a97d44dec39e313a95b12d9bc3b2 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Wed, 25 Jul 2018 00:15:18 +0900
> Subject: [PATCH v2] n_tty: Protect tty->disc_data using refcount.
> 
> syzbot is reporting NULL pointer dereference at n_tty_set_termios() [1].
> This is because ioctl(TIOCVHANGUP) versus ioctl(TCSETS) can race.
> 
> Since we don't want to introduce new locking dependency, this patch
> converts "struct n_tty_data *ldata = tty->disc_data;" in individual
> function into a function argument which follows "struct tty *", and
> holds tty->disc_data at each "struct tty_ldisc_ops" hook using refcount
> in order to ensure that memory which contains "struct n_tty_data" will
> not be released while processing individual function.

This does not look correct and is way too complicated. ioctls should not
be called while changing/killing/hanging/whatever a ldisc. But there is
one missing lock in tty_reopen.

So does the attached patch helps instead?

thanks,
-- 
js
suse labs

--------------60B1CCB6B678BE686DBE8098
Content-Type: text/x-patch;
 name="0001-tty-fix-NULL-ptr-dereference.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-tty-fix-NULL-ptr-dereference.patch"

From a41b427c77d920cd151473361788deb80e576f6c Mon Sep 17 00:00:00 2001
From: Jiri Slaby <jslaby@suse.cz>
Date: Wed, 29 Aug 2018 15:49:51 +0200
Subject: [PATCH] tty: fix NULL ptr dereference

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/tty_io.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index f89939922050..160f320e0d2c 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1255,6 +1255,7 @@ static void tty_driver_remove_tty(struct tty_driver *driver, struct tty_struct *
 static int tty_reopen(struct tty_struct *tty)
 {
 	struct tty_driver *driver = tty->driver;
+	int ret = 0;
 
 	if (driver->type == TTY_DRIVER_TYPE_PTY &&
 	    driver->subtype == PTY_TYPE_MASTER)
@@ -1268,10 +1269,12 @@ static int tty_reopen(struct tty_struct *tty)
 
 	tty->count++;
 
+	tty_ldisc_lock(tty, MAX_SCHEDULE_TIMEOUT);
 	if (!tty->ldisc)
-		return tty_ldisc_reinit(tty, tty->termios.c_line);
+		ret = tty_ldisc_reinit(tty, tty->termios.c_line);
+	tty_ldisc_unlock(tty);
 
-	return 0;
+	return ret;
 }
 
 /**
-- 
2.18.0


--------------60B1CCB6B678BE686DBE8098--
