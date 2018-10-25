Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08058C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED3620834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpwmpnTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED3620834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeJYXyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:54:18 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42354 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbeJYXyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:54:18 -0400
Received: by mail-yb1-f195.google.com with SMTP id o204-v6so3830798yba.9;
        Thu, 25 Oct 2018 08:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JFY42edVAs1eg28BpgnTF/8Lqgn+1MR/kXxJW72nqSk=;
        b=VpwmpnTr7U644k+1LEJ7uyEFizBiE4I0TAeU8tbBv5fWWwGTCX9WhWboSpDR0/ftQL
         WGC9I223fFBGSR/MheIfq2kabN2BpDH/w9YpZgNdrvZxCdmO2ZPtEZIK3bvKq0kEaGOi
         FIP9avz0yaxzpkAD1+5rCzVJsi16ICBpRVihpGUAOMzFyV/zpplFHB1DMURQvYwBqaOg
         Js7OcRVUhE1XIWOZJn9vFvt4fOU/hJ0z69MsgPv7/uqFy/W39M29xi5IfQAI723NLCLR
         Duc1YNeX1coW2fKwKphgnIAJizDMuPokGBj/1/14WPrb/1jQj69DcvFz9/kv71Ik9mWB
         XGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JFY42edVAs1eg28BpgnTF/8Lqgn+1MR/kXxJW72nqSk=;
        b=pjwUpvMZMFp9dbUfX8KbMCFLEWbm/mSbwQOkK+KS7qXxeW12bFAFNmfBma8l10qknA
         0LAQ9V3lfVXtna7+TFUBhs4BJAs3zHIc2CwyP1VaxrKqSSAVAG8p9hRx0A1QZYF5+pgn
         2ROCPINrBTpINIKQa9fJWCFzsZaj2ENTkDd5cJwa3sYtxKKN3gRN0l0B3xmS+sGH9PLn
         3uWmkqtx3yjWgQDIbDhpN++Og2/8ot5Akp7xUkhADwrJs15Q6SpYn0+jo34EDpDNEuJz
         bSYZO23Cu/MSMN41W4KiPMkvHnLk0GyasWgfZWJvpPfKFy8VsvPgu991ycsvfo+v/4Om
         VrJw==
X-Gm-Message-State: AGRZ1gLKhuT7uP0tAH+x5d2GB+rO4YlOOqQJBL+Fy/z13zRtUGOb1uys
        uGPA+VKVo/GyWTowNFW+Hcw=
X-Google-Smtp-Source: AJdET5dFPWZ6mtqx6rWzZE6yD6tAj3tyXN7+mdLtpp81cA4K2uMWurw+b/X9LoReamtuGdbHFt79+A==
X-Received: by 2002:a25:c70b:: with SMTP id w11-v6mr1969977ybe.6.1540480863004;
        Thu, 25 Oct 2018 08:21:03 -0700 (PDT)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id s200-v6sm3864776ywg.61.2018.10.25.08.21.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 08:21:02 -0700 (PDT)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@googlemail.com
To:     svendev@arcx.com, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, afaerber@suse.de, treding@nvidia.com,
        david@lechnology.com, noralf@tronnes.org, johan@kernel.org,
        monstr@monstr.eu, michal.vokac@ysoft.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        yuanzhichang@hisilicon.com, stuyoder@gmail.com,
        linus.walleij@linaro.org, maxime.ripard@bootlin.com,
        bogdan.purcareata@nxp.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH anybus v1 3/4] bus: support HMS Anybus-S bus.
Date:   Thu, 25 Oct 2018 11:20:58 -0400
Message-Id: <20181025152058.9176-1-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, thanks a million for the detailed patch review, you've given this
patch a lot more attention than I was expecting. Great !!

> What you need to add is a bit of how the driver is architected.

I agree. Written once, read/maintained 100s of times, right?

> This is really needed because the driver is starting threads and
> running completions and tasks and whatnot to the left and
> right, and when random people come in to maintain this code they
> will be puzzled. 

I had originally architected this driver to be much simpler, with everything
running in the context of the userspace threads (except obviously the
interrupt). But it stood zero chance, the presence of the soft interrupt + the
h/w requirement to lock/unlock the region when acking the soft interrupt meant
that there were circular locking dependencies that always resulted in
deadlock :(

This single-thread message-queue architecture is harder to understand,
but much easier and safer in terms of synchronization.

I find it hard myself to keep track of functions that run in userland thread
context, and those that run in the kernel thread. Should I prefix kernel thread
functions with kt_* just to keep them apart?

> also "buss" is a germanism isn't it?  It should be just "anybus"?

There are several different types of anybus:
Anybus-M
Anybus-S
Anybus-CompactCOM

This driver implements Anybus-S only. I had originally prefixed files and
functions with anybus-s and anybus_s respectively, but it looked horrible
visually:

struct anybus_s_host *cd = data;
drivers/bus/anybus-s-host.c
include/linux/anybus-s-client.h

I'm completely open to suggestions on this one.
anybuss?
anybus-s?
just anybus?

>> +static irqreturn_t irq_handler(int irq, void *data)
>> +{
>> +       struct anybuss_host *cd = data;
>> +       int ind_ab;
>> +
>> +       /* reading the anybus indicator register acks the interrupt */
>> +       ind_ab = read_ind_ab(cd->regmap);
>> +       if (ind_ab < 0)
>> +               return IRQ_NONE;
>> +       atomic_set(&cd->ind_ab, ind_ab);
>> +       complete(&cd->card_boot);
>> +       wake_up(&cd->wq);
>> +       return IRQ_HANDLED;
>> +}

> It looks a bit like you reinvent threaded interrupts but enlighten me
> on the architecture and I might be able to get it.

HMS Industrial Networks designed the anybus interrupt line to be dual purpose.
In addition to being a 'real' interrupt during normal operation, it also signals
that the card has initialized when coming out of reset. As this is a one-time
thing, it needs a 'struct completion', not a wait_queue.

It is of course possible to emulate a struct completion using a waitqueue and
an atomic variable, but wasn't struct completion invented to eliminate the
subtle dangers of this?

So this is why the irq_handler has to call both complete() and wake_up(), so
it can't be modelled by a threaded interrupt.

Maybe if we use two separate irq_handlers: put the first one in place during
initialization, then when the card is initialized, remove it and put a threaded
one in place? Would this be a bit too complicated?

> This looks complex. Why can't you just sleep() and then
> retry this instead of shuffleing around different "tasks"?
> Are you actually modeling a state machine? In that case
> I can kind of understand it, then you just need one
> thread/work and assign it an enum of states or
> something, maybe name that "state" rather than task
> so we see what is going on.

Yes, I am modeling a state machine.
When userspace asks the anybus to do something, it throws a task into a queue,
and waits on the completion of that task.
The anybus processes the tasks sequentially, each task will go through
multiple states before completing:

userspace processes 	A	B	C
			|	|	|
			v	v	v
			-----------------
			| task waiting	|
			| task waiting	|
			| task waiting	|
			|---------------|
			| task running	|
			-----------------
				^
				|
			-----------------
			| anybus process |
			| single-thread	 |
			| h/w access	 |
			------------------

There is only one single kernel thread that accesses the hardware and the queue.
This prevents various subtle synchronization/deadlock issues related to the
soft interrupts.

The tasks change state by re-assigning their own task_fn callback:

function do_state_1(self) {
	...
	if (need state 2)
		self->task_fn = do_state_2;
}

function do_state_2(self) {
	...
	if (need_state_1)
		self->task_fn = do_state_1;
}

I could have opted for a classic state machine in a single callback:

function do_state(self) {
	switch (self->state) {
	case state_1:
		...
		if (need_state_2)
			self->state = state_2;
		break;
	case state_2:
		...
		if (need_state_1)
			self->state = state_1;
		break;
	}
}

But the former seemed easier to understand.
Obviously it's more important that it's easy to understand not to me, but to
most developers who read the code. So tell me if the callback approach is
too exotic.

>> +static void softint_ack(struct anybuss_host *cd)
>> +static void process_softint(struct anybuss_host *cd)
>
> This looks like MSI (message signalled interrupt) and makes me think
> that you should probably involve the irqchip maintainers. Interrupts
> shall be represented in the irqchip abstraction.

This is not a *real* software interrupt - it's just a bit in an internal
register that gets set by the anybus on a certain condition, and needs
to be ACKed. When the bit is set, the bus driver then tells userspace
about it - anyone who is running poll/select on the sysfs node or devnode.

The anybus documentation calls this a 'software interrupt'.

>> +       cd->reset = pdata->reset;
>
> This callback thing to handle reset doesn't seem right.

I agree, and I've gone through the exact same thought process before.

Right now I'm using platform_data for the bus driver's dependencies:
(the irq is passed out-of-band, via platform_get_resource())

+/**
+ * Platform data of the Anybus-S host controller.
+ *
+ * @regmap: provides access to the card dpram.
+ *		MUST NOT use caching
+ *		MUST NOT sleep
+ * @reset:  controls the card reset line.
+ */
+struct anybuss_host_pdata {
+	struct regmap *regmap;
+	anybuss_reset_t reset;
+};

Now imagine that the underlying anybus bridge is defined as a reset controller.
I could not find a way to pass a reset controller handle through platform_data.
It seemed possible via the devicetree only. I was developing on 4.9 at the time.

So what if we pass the dependencies not via platform_data, but via the
devicetree? In that case, I cannot find a way to pass the struct regmap
via the devicetree...

Wait... are you talking about
reset_controller_add_lookup() / devm_reset_control_get_exclusive() ?
That's new to me, and only used in a single driver right now. Would that work?
