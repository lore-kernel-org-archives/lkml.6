Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8D7C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 17:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C832085B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 17:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cD81g3Un"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C832085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbeJ1CIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 22:08:41 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:32838 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbeJ1CIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 22:08:41 -0400
Received: by mail-lj1-f177.google.com with SMTP id z21-v6so4031766ljz.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 10:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K4roiOGdDLY/A/AjgFlHUPUKHMnmJEJbRKu9haAw68c=;
        b=cD81g3Unf6oXRlTm24sGvP6zFnyueikUbE0rToWkb10yTGZsZ9a85oMT1AZIh7DNRY
         5RfRYnS3psJ/ZJZyjn+BSA9PJKSA3jJ4SL2a3Iryn4GV//VlGm4nAog1ukMb+iCcPfr+
         4Gia/6HJvcbFbEdlyveN8ipTOeND9sVooyYYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K4roiOGdDLY/A/AjgFlHUPUKHMnmJEJbRKu9haAw68c=;
        b=kPJSmzKairaqsdlbvSQfHKLBHlyjrptIfcnZ3thDXmiIFDrltYTiapvPrjns/rxTUb
         uonbwCZJwEkTJ1UutTR8Ht5niqIxbXZx3FRtFIb1vmkgiB7iU0+dCVR0H6HpSIORWmJj
         p6AIwjM22L3xxqvvrswvmFD7GKOmgYbyprm48fpLkfOCAk5JL06FYJr8cJNpGt6i3gup
         RBaczm6C5bDLizYJuUeeleuf5czmRITrEYF8D5KSI/J3OILJQbyMz4AnXnRR8yKgU9XH
         GM9jEj9oYCs/wUFA0ArIZyomhweRb0orWnNx9sfibuCKvtWNIJaIq0D3vhP1RmV3xGAV
         rO6w==
X-Gm-Message-State: AGRZ1gLttHmue1sBC74bkYzKHHqwlx6KXmxPi95hs6rl+IgfszJk5j1F
        r9+9br2vFxJI2oKATcNcf7xpVCc+wEaa8w==
X-Google-Smtp-Source: AJdET5eA46TJt1k63ROsC8uUWxni+8FIfXGVkj3TsOakM2yHjrTbIViDcDTasGvYKjoryz3yg4FEMw==
X-Received: by 2002:a2e:8146:: with SMTP id t6-v6mr5329329ljg.32.1540661219299;
        Sat, 27 Oct 2018 10:26:59 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id u27-v6sm1058330lfc.36.2018.10.27.10.26.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 10:26:58 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id m18-v6so3148366lfl.11
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 10:26:57 -0700 (PDT)
X-Received: by 2002:ac2:41d8:: with SMTP id d24-v6mr4595017lfi.138.1540661217220;
 Sat, 27 Oct 2018 10:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181027112724.GA26504@www.linux-watchdog.org>
In-Reply-To: <20181027112724.GA26504@www.linux-watchdog.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 27 Oct 2018 10:26:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wicMwPp77jc-nDt3+FZOUKnRqeresdYhUPbJUMbiJsg9g@mail.gmail.com>
Message-ID: <CAHk-=wicMwPp77jc-nDt3+FZOUKnRqeresdYhUPbJUMbiJsg9g@mail.gmail.com>
Subject: Re: [GIT PULL REQUEST] watchdog - v4.20 Merge window
To:     wim@linux-watchdog.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        khoroshilov@ispras.ru, chris.brandt@renesas.com,
        christophe.leroy@c-s.fr, hauke@hauke-m.de, jdelvare@suse.de,
        jerry.hoemann@hpe.com, kuninori.morimoto.gx@renesas.com,
        marek.behun@nic.cz, rpjday@crashcourse.ca,
        romain.izard.pro@gmail.com, wsa+renesas@sang-engineering.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2018 at 4:50 AM Wim Van Sebroeck <wim@linux-watchdog.org> wrote:
>
> Please pull the watchdog changes for the v4.20 (or 5.00) release cycle.

Pulled,

                     Linus
