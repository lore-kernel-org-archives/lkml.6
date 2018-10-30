Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C5CC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84E42082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PFEUvrhs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84E42082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbeJ3Ss5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:48:57 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40216 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeJ3Ss5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:48:57 -0400
Received: by mail-lf1-f68.google.com with SMTP id n3-v6so8350296lfe.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 02:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eXk89ebXZWCfCuxQ5noLjVs3vz6yneAcyh7EMfi/L8g=;
        b=PFEUvrhsFK+tM2pA92lARQXf6WVSZ/SlJCOA6ybOZ3YaWti/cackMCweqPa3k5dwr4
         fxhOsL3Q/QfEe6c0eVTowZpeSpzT5/y5YHKhTZTxevZLqK7hq6KFZoaqB7Y2HYW6eIbx
         vyGzJ+ganE3Nxc6i8XFANqWFH/2uq3iiGj+PQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eXk89ebXZWCfCuxQ5noLjVs3vz6yneAcyh7EMfi/L8g=;
        b=s8fR6VzVZZPtXFJmv0D1Ns5qxrqL8fHq1UHBAL3iSzvdx1Hc2xuycJJp70huRqS3+T
         VmLKxYdA5enGy8dv5AvKPKFZ+hoNKjMP9nk8yTe6439jGnjXSCO90fbkcqEk84xTjh/f
         bzV0thMa7dABnZBjRdjYMTKzaItuos59yeIeo6B599gy97e9edrMRunhnqLBXZw/ClJM
         3XWYB25LSPxrxH+D0Xs7Mjkasj0tMfMuxGoPj62rURWHNZyCwejs6Yw9yC7r4wEU8RF5
         jM4wVJquFVKNXKmb+0uo0DL/pjIdVYOVxCE7TPVpQ8wGw1iPa+quFZsZSs7FBSMcI/T5
         t57Q==
X-Gm-Message-State: AGRZ1gJ2Kzn+ipXlJ/EIJMFgqTuBBFm2+hYF6Mma83koZVYdgefXFL8j
        D5+lp6jYbkuSynv5gvX6GQXWmAWUkKTYZjkZVzsjPg==
X-Google-Smtp-Source: AJdET5dhhDxxTGKa378Pg93uWTVrsJUilxWaLSBrWSlwsRM5Z3N/hm8cGL9SREKoi4EXuoZZx5EC0eWjEF/Aomwv4Pg=
X-Received: by 2002:a19:2752:: with SMTP id n79mr1518921lfn.11.1540893368257;
 Tue, 30 Oct 2018 02:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20181025152058.9176-1-TheSven73@googlemail.com>
In-Reply-To: <20181025152058.9176-1-TheSven73@googlemail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 30 Oct 2018 10:55:54 +0100
Message-ID: <CACRpkdYVN-s7shQmPkRjB9sxwi32TiKhmd_vKU+Jm--vGy2dSA@mail.gmail.com>
Subject: Re: [PATCH anybus v1 3/4] bus: support HMS Anybus-S bus.
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     svendev@arcx.com, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Johan Hovold <johan@kernel.org>,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>, john.garry@huawei.com,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Icenowy Zheng <icenowy@aosc.io>, yuanzhichang@hisilicon.com,
        Stuart Yoder <stuyoder@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        bogdan.purcareata@nxp.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

some tries to answer questions... (I am no expert in this but
I try my best)

On Thu, Oct 25, 2018 at 5:21 PM <thesven73@gmail.com> wrote:

> I had originally architected this driver to be much simpler, with everything
> running in the context of the userspace threads (except obviously the
> interrupt). But it stood zero chance, the presence of the soft interrupt + the
> h/w requirement to lock/unlock the region when acking the soft interrupt meant
> that there were circular locking dependencies that always resulted in
> deadlock :(

I think the kernel should run all hardware drivers so IMO you did the
right thing.

> > also "buss" is a germanism isn't it?  It should be just "anybus"?
>
> There are several different types of anybus:
> Anybus-M
> Anybus-S
> Anybus-CompactCOM
>
> This driver implements Anybus-S only. I had originally prefixed files and
> functions with anybus-s and anybus_s respectively, but it looked horrible
> visually:
>
> struct anybus_s_host *cd = data;
> drivers/bus/anybus-s-host.c
> include/linux/anybus-s-client.h

Hm I think this looks pretty neat actually. Anyways, in the overall
architecture explain the three Anybus:es and why things pertaining
to Anybus-s are named as they are.

> >> +static irqreturn_t irq_handler(int irq, void *data)
> >> +{
> >> +       struct anybuss_host *cd = data;
> >> +       int ind_ab;
> >> +
> >> +       /* reading the anybus indicator register acks the interrupt */
> >> +       ind_ab = read_ind_ab(cd->regmap);
> >> +       if (ind_ab < 0)
> >> +               return IRQ_NONE;
> >> +       atomic_set(&cd->ind_ab, ind_ab);
> >> +       complete(&cd->card_boot);
> >> +       wake_up(&cd->wq);
> >> +       return IRQ_HANDLED;
> >> +}
>
> > It looks a bit like you reinvent threaded interrupts but enlighten me
> > on the architecture and I might be able to get it.
>
> HMS Industrial Networks designed the anybus interrupt line to be dual purpose.
> In addition to being a 'real' interrupt during normal operation, it also signals
> that the card has initialized when coming out of reset. As this is a one-time
> thing, it needs a 'struct completion', not a wait_queue.

OK but you also have an atomic_set() going on and the struct completion
already contains a waitqueue and I start to worry about overuse of
primitives here. How does ps aux look on your system when running this?

> It is of course possible to emulate a struct completion using a waitqueue and
> an atomic variable, but wasn't struct completion invented to eliminate the
> subtle dangers of this?

The completion is a waitqueue entry and a spinlock, essentially.
But you're right, if you're waiting in process context for something
to happen, such as an ack interrupt for something you initiated,
a completion is the right abstraction to use.

> So this is why the irq_handler has to call both complete() and wake_up(), so
> it can't be modelled by a threaded interrupt.

It's just that when you do things like this:

   complete(&cd->card_boot);
   wake_up(&cd->wq);

I start asking: OK so why is that waitqueue not woken up from
wherever you are doing wait_for_completion()? I hope it is not
because you are waiting for the completion in the very same
waitqueue. That would be really messy.

So I guess what we like is clear program flow, as easy as possible
to follow what happens in the driver.

> Maybe if we use two separate irq_handlers: put the first one in place during
> initialization, then when the card is initialized, remove it and put a threaded
> one in place? Would this be a bit too complicated?

Nah one irq handler is fine, but you can have an optional
bottom half:

request_threaded_irq(irq, fastpath, slowpath...):

From fastpath you return IRQ_WAKE_THREAD only
if you want to continue running the slowpath callback
in process context, else just complete() and
return IRQ_HANDLED and the slowpath thread will not be
executed.

> Yes, I am modeling a state machine.
> When userspace asks the anybus to do something, it throws a task into a queue,
> and waits on the completion of that task.
> The anybus processes the tasks sequentially, each task will go through
> multiple states before completing:
>
> userspace processes     A       B       C
>                         |       |       |
>                         v       v       v
>                         -----------------
>                         | task waiting  |
>                         | task waiting  |
>                         | task waiting  |
>                         |---------------|
>                         | task running  |
>                         -----------------
>                                 ^
>                                 |
>                         -----------------
>                         | anybus process |
>                         | single-thread  |
>                         | h/w access     |
>                         ------------------
>
> There is only one single kernel thread that accesses the hardware and the queue.
> This prevents various subtle synchronization/deadlock issues related to the
> soft interrupts.

This should all go into the comment section on the top of the
C file so we understand what is going on :)
(Good explanation BTW.)

> The tasks change state by re-assigning their own task_fn callback:
>
> function do_state_1(self) {
>         ...
>         if (need state 2)
>                 self->task_fn = do_state_2;
> }
>
> function do_state_2(self) {
>         ...
>         if (need_state_1)
>                 self->task_fn = do_state_1;
> }
>
> I could have opted for a classic state machine in a single callback:
>
> function do_state(self) {
>         switch (self->state) {
>         case state_1:
>                 ...
>                 if (need_state_2)
>                         self->state = state_2;
>                 break;
>         case state_2:
>                 ...
>                 if (need_state_1)
>                         self->state = state_1;
>                 break;
>         }
> }
>
> But the former seemed easier to understand.

OK I honestly don't know what is the best way. But what about
calling that "task" a "state" instead so we know what is going
on (i.e. you are switching between different states in process
context).

> >> +static void softint_ack(struct anybuss_host *cd)
> >> +static void process_softint(struct anybuss_host *cd)
> >
> > This looks like MSI (message signalled interrupt) and makes me think
> > that you should probably involve the irqchip maintainers. Interrupts
> > shall be represented in the irqchip abstraction.
>
> This is not a *real* software interrupt - it's just a bit in an internal
> register that gets set by the anybus on a certain condition, and needs
> to be ACKed. When the bit is set, the bus driver then tells userspace
> about it - anyone who is running poll/select on the sysfs node or devnode.
>
> The anybus documentation calls this a 'software interrupt'.

OK I get it... I think.

Silly question but why does userspace need to know about
this software interrupt? Can't you just hide that?
Userspace ABIs should be minimal.

> Right now I'm using platform_data for the bus driver's dependencies:
> (the irq is passed out-of-band, via platform_get_resource())
(...)
> +/**
> + * Platform data of the Anybus-S host controller.
> + *
> + * @regmap: provides access to the card dpram.
> + *             MUST NOT use caching
> + *             MUST NOT sleep
> + * @reset:  controls the card reset line.
> + */
> +struct anybuss_host_pdata {
> +       struct regmap *regmap;
> +       anybuss_reset_t reset;
> +};
>
> Now imagine that the underlying anybus bridge is defined as a reset controller.
> I could not find a way to pass a reset controller handle through platform_data.
> It seemed possible via the devicetree only. I was developing on 4.9 at the time.

I don't get the question. The reset controller is a provider just
like a clock controller or regulator. You look up the resource
associated with your device.

The platform_data is surely associated with a struct device *
and the reset controller handle should be associated with the
same struct device* and obtained with
[devm_]reset_control_get().

If you mean that you can't figure out how to associate a reset
controller handle with a device in the first place, then we need
to fix the reset controller subsystem to provide a mechanism for
that if there is not one already, not work around its shortcomings.
But reset_controller_add_lookup() seems to do what you want.
See for example drivers/clk/davinci/psc-da850.c
for an example of how to use that.

> So what if we pass the dependencies not via platform_data, but via the
> devicetree? In that case, I cannot find a way to pass the struct regmap
> via the devicetree...

The abstraction you associate resources with is struct device *
not device tree (nodes).

When I pass struct regmap to subdrivers I usually define a struct
that I pass in driver_data one way or another.
Sometimes I look up the driver_data of a parent by just
walking the ->parent hierarchy in struct device.

> Wait... are you talking about
> reset_controller_add_lookup() / devm_reset_control_get_exclusive() ?
> That's new to me, and only used in a single driver right now. Would that work?

Yeah I think so.

Yours,
Linus Walleij
