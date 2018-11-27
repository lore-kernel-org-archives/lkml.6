Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80304C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53131208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 06:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53131208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbeK0RWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 12:22:47 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46254 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbeK0RWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 12:22:46 -0500
Received: by mail-ot1-f66.google.com with SMTP id w25so19091908otm.13;
        Mon, 26 Nov 2018 22:25:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xBGZS2iSGQKOpLGh4MPzN1VqDyg0NeZrjdJ7gFacL9k=;
        b=IPR1LoWJkzbJ357wjycXfmBIdl6isd6pnPcELgtos346jIsmzNAV+pmd3J9Ofk7Yi2
         atnyzy2+LL2Uqn/8ulZv5ozQ+ej2RL4TUgxI2ONBHNBT4Ezk8+UxlTxGwHoSxjmQVXCU
         /gTBAlLXpwHNsh9lzhbcF28wuojDUVWDGF5VYHi/zi4lMFyBTyfy9pRBdjkqTfT8Yk4u
         e5Alc0KraxCtG2tQP0r/Ej+hg9/t1phQ9RWpIuQbW4newwpKzQx/w9TDNTLU86d926W2
         Y+F8lAhiBCVi7t6rDxtaRPhrD35kihuwPmNROfFDbSTm+JZXvbMXJu4Fp05o/Fiomy1M
         FrMw==
X-Gm-Message-State: AA+aEWah70w+VQ5ZtYuFu1Yn7fwgEE8swUaVyhpxBSjBL5iwwVmmASHY
        xMyBvMg/qBZN0bQi6UkFS1xilNcxBGPLliySJiQ=
X-Google-Smtp-Source: AFSGD/UkLUD/iWLggdoIjvJhCF7wUraK36IVutZ9FhA4Htw5oVtfGpa0ZSxg3/7XhsGVQ8qJvIJE4uQ35clxgzyB2q0=
X-Received: by 2002:a9d:1421:: with SMTP id h30mr1812025oth.321.1543299957895;
 Mon, 26 Nov 2018 22:25:57 -0800 (PST)
MIME-Version: 1.0
References: <1543216072-9623-1-git-send-email-harini.katakam@xilinx.com>
 <1543216072-9623-5-git-send-email-harini.katakam@xilinx.com> <c844298e-d997-940f-be85-fd3442d01be5@microchip.com>
In-Reply-To: <c844298e-d997-940f-be85-fd3442d01be5@microchip.com>
From:   Harini Katakam <harinik@xilinx.com>
Date:   Tue, 27 Nov 2018 11:55:47 +0530
Message-ID: <CAFcVEC+yyvQckJaj9HrkUtsJSsAKs0F5akRkgBceMqbOAcdx3g@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] net: macb: Add support for suspend/resume with
 full power down
To:     Claudiu Beznea <Claudiu.Beznea@microchip.com>
Cc:     Harini Katakam <harini.katakam@xilinx.com>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>, appanad@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

On Mon, Nov 26, 2018 at 8:16 PM <Claudiu.Beznea@microchip.com> wrote:
>
>
>
> On 26.11.2018 09:07, Harini Katakam wrote:
<snip>
>
> In the previous version you said you encountered some crashes while
> stressing this part if macb_open()/macb_close() was used in here. Could you
> share the tests so that I can debug it on my side?

Sure, my tests include doing a series of suspend/resume -- it is done
as part of a
random regression script. On ZynqMP, it includes the following to do an
FPD off suspend and then use either UART or WOL as a wake source and
repeat the same, sometimes pinging in between:

echo pm_request_wakeup 8 1 0 1 > /sys/kernel/debug/zynqmp-firmware/pm
echo pm_force_powerdown 6 > /sys/kernel/debug/zynqmp-firmware/pm
echo enabled > /sys/devices/platform/amba/ff000000.serial/tty/ttyPS0/power/wakeup
echo enabled > /sys/devices/platform/amba/ff0e0000.ethernet/net/eth0/power/wakeup
echo mem > /sys/power/state

ping does not work sometimes and after a few iterations (sometimes
20), a crash can be
observed tracing from "kfree_skb_list" to "macb_free_consistent". From
the flow, the
only explanation I could come up with was that there was an attempt to
free buffers that
may not have been allocated. Also, this was time consuming in the
suspend/resume path.

<snip>
> > +     } else {
> > +             macb_writel(bp, NCR, MACB_BIT(MPE));
>
> Just asking... shouldn't other registers be restored here after SoC power
> is cut off?
Ideally yes. But in this series, I'm just attempting to re-initialize
to a working
state. I can try context save/restore later.

Regards,
Harini
