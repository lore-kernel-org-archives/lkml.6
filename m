Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968881AbeEXUZc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 16:25:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967470AbeEXUZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 16:25:28 -0400
X-Google-Smtp-Source: ADUXVKIfARRst21gBPMwvIC9YlmJTapwInLcBRoGZ3x0wONCD3klx5jBJ1SI+CZ3DlURvb1PoBlFT4xJ6VznIALxNNk=
MIME-Version: 1.0
In-Reply-To: <20180524181834.GF4828@sirena.org.uk>
References: <20180524175024.19874-1-robh@kernel.org> <20180524175024.19874-2-robh@kernel.org>
 <20180524181834.GF4828@sirena.org.uk>
From: Rob Herring <robh@kernel.org>
Date: Thu, 24 May 2018 15:25:06 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+xHbW8S4ZMsZp8BJ=wq=t6z2gGTacBnYGgkgBG0dVdYg@mail.gmail.com>
Message-ID: <CAL_Jsq+xHbW8S4ZMsZp8BJ=wq=t6z2gGTacBnYGgkgBG0dVdYg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] driver core: make deferring probe after init optional
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Architecture Mailman List <boot-architecture@lists.linaro.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 1:18 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, May 24, 2018 at 12:50:17PM -0500, Rob Herring wrote:
>
>> Subsystems or drivers may opt-in to this behavior by calling
>> driver_deferred_probe_check_init_done() instead of just returning
>> -EPROBE_DEFER. They may use additional information from DT or kernel's
>> config to decide whether to continue to defer probe or not.
>
> Should userspace have some involvement in this decision?  It knows if
> it's got any intention of loading modules for example.  Kernel config
> checks might be good enough, though it's going to be a pain to work out
> if the relevant driver is built as a module for example.

I looked into whether we could hook into uevents in some way. If we
knew when all the coldplug events had been handled, that would be
sufficient. But it doesn't look to me like we can tell when that
happens with the uevent netlink socket. I think about the only thing
we can tell is if userspace has opened a socket. I'm not all that
familiar with how the whole sequence works, so other opinions on this
would be helpful.

Also, for this to work with serial consoles, we have to make the
decision before we get to userspace. I couldn't get systemd to create
serial gettys either if we deferred later. There's some dependence on
/dev/console, but I didn't get to the bottom of it.

Rob
