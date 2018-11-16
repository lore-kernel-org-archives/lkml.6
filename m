Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C788C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593A72087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UsTjnaSM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593A72087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbeKQIBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 03:01:23 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41958 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbeKQIBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 03:01:23 -0500
Received: by mail-lj1-f193.google.com with SMTP id z80-v6so21583331ljb.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 13:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ddGZStsGxQ8KYqQYwqM29cWKwMOOt0E0fkCsxWg9tvk=;
        b=UsTjnaSMsCgCzc73G3wifawoYwWkELLsb/UsZhfsedQ+u0dcbUn3xSfkE6Dkul7kGw
         cmrW/ED2Gei+bzsQWKt9h4RY+rloyQ0uWquvT6chJT3j75u2LRDNprRG/QMmZR8JksDZ
         3btV9q2wYt+M+v+g0fMhI6K/rIYY550laVXOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ddGZStsGxQ8KYqQYwqM29cWKwMOOt0E0fkCsxWg9tvk=;
        b=n2yhperCyDYSWzaQiKOdZg7S8TOFyhk2sVZ8AHB3yvu2yU30c6C+o7SvtHYhYswCt7
         asYRhuDB5xVU4/2KaL/wgUIqXt4J99vvFsZPZMpkUgGBVsef4XjCn5hbBNvY17krUkvc
         bamaFE4KDPkFzkiSqQxeSZ6s9RRW/W5ioAhIiM9q2TPdE0zOpqFRE0INFMUtkMhxeudS
         7oixY4nkTv0LAONsDG55MyPmHQNhVdC6legYTu3ZBASM1q7b/CZt3XfpoJZ2oKYrildP
         iBEwf/QM7W/4755JuG4QD98rbMShFWM8tGPOJ3NinYVptyMvJw7LcYLehmvpsLoLXmeq
         gkfw==
X-Gm-Message-State: AGRZ1gLqrZD2uuuPUlxfwNRSwGdWkBzvBlIz4P9ep1IebqFs6R+VPYQP
        SszZxVpiu8S1SJzTziAlK9eaENiNi81AIZVidcdd/w==
X-Google-Smtp-Source: AJdET5e6t8uM7YD78bjM9I9YHs+fmh2WMixsHOSS98de4busWQd0mj5LjwFgc+P7kgAlFWAHMwREAy3SEsrvLwW8V5c=
X-Received: by 2002:a2e:29d7:: with SMTP id p84-v6mr6891542ljp.12.1542404835305;
 Fri, 16 Nov 2018 13:47:15 -0800 (PST)
MIME-Version: 1.0
References: <20181112141028.10213-1-johan@kernel.org>
In-Reply-To: <20181112141028.10213-1-johan@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Nov 2018 22:47:02 +0100
Message-ID: <CACRpkdYHjZ9z+a=3A=F5dk56uQk15vGsXRbn2Euz3Adv3fR99A@mail.gmail.com>
Subject: Re: [PATCH] gpio: drop broken to_gpio_irq_chip() helper
To:     Johan Hovold <johan@kernel.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 3:11 PM Johan Hovold <johan@kernel.org> wrote:

> Drop the broken to_gpio_irq_chip() container_of() helper, which would
> break the build for anyone who tries to use it.
>
> Specifically, struct gpio_irq_chip only holds a pointer to a struct
> irq_chip so using container_of() on an irq-chip pointer makes no sense.
>
> Fixes: da80ff81a8f5 ("gpio: Move irqchip into struct gpio_irq_chip")
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Patch applied, thanks!

Yours,
Linus Walleij
