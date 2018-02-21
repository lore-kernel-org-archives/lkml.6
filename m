Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932457AbeBUQHS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:07:18 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35127 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752553AbeBUQHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:07:16 -0500
X-Google-Smtp-Source: AG47ELuF0FxIVB6jZkY4bCucHMjc2t334carzTzSuBRR4bmiRn+eXRfwFB9PZf3ZN2jxhCyurSlMtqDkn0sB7JTE3i8=
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXm97QFTC8VYDoByHsXaG5BQqFdhwqMTuGVRKDe-oh8EQ@mail.gmail.com>
References: <1518539815-13774-1-git-send-email-geert+renesas@glider.be>
 <1518539815-13774-2-git-send-email-geert+renesas@glider.be>
 <2fe86be6-a3e2-9bd6-1d72-63cf0fe3a731@redhat.com> <CAMuHMdXm97QFTC8VYDoByHsXaG5BQqFdhwqMTuGVRKDe-oh8EQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Feb 2018 17:07:14 +0100
X-Google-Sender-Auth: Z6qn8Ej1cIWBej1Qt7vy1XyMUTY
Message-ID: <CAMuHMdVkTy=TELjG0Jh7HMDe5075EHSebpNUWqBDt+6ik_Aixw@mail.gmail.com>
Subject: Re: [PATCH 1/2] vfio: platform: Fix reset module leak in error path
To: Auger Eric <eric.auger@redhat.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Baptiste Reynal <b.reynal@virtualopensystems.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        KVM list <kvm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Wed, Feb 14, 2018 at 10:32 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Wed, Feb 14, 2018 at 9:36 AM, Auger Eric <eric.auger@redhat.com> wrote:
>> If I am not wrong we also leak the reset_module if
>> vfio_platform_get_reset() fails to find the reset function (of_reset ==
>> NULL), in which case we should do the module_put() in
>> vfio_platform_get_reset().
>
> Correct. Will look into fixing it...

Upon second look, I don't think there's a leak in vfio_platform_get_reset().

If try_module_get() succeeded, there will always be a valid reset function
(unless someone registered a vfio_reset_handler with a NULL reset function).

Or do you mean the call to request_module()?
That one doesn't do a module_get(), it merely tries to load a module.
Hence there's no need to do a module_put() afterwards.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
