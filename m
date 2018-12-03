Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FCFC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B3E20666
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C0AKAMWx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B3E20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbeLCXsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:48:33 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44981 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbeLCXsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:48:32 -0500
Received: by mail-pl1-f195.google.com with SMTP id k8so7268976pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 15:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=8TlFaMonp9oxMSo4me7gJfHFdO0cVi4wJZxa2g4hFaA=;
        b=C0AKAMWxF1LoUkYkcb1QksQsdikZ2wKn4aylxyT97HJSfdO4F6SJox6tLsh48AAeak
         dLPcO/mz/iSAvk6jl6gcfGua1nBUcaDtG9LWmx0PqgiGBYP/wCnI0MOFdH0yxH+/FGjL
         n0WHdPPJL3108wG+W4P9JD3ZXGMO2TaE2QeGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=8TlFaMonp9oxMSo4me7gJfHFdO0cVi4wJZxa2g4hFaA=;
        b=Z8u9yPSM7CU/Zeqs9KXkNtGS6U6sREj7aTuT+8gKme6rJ4Mko4MDLo38iQbSAVPXvQ
         6OIJCy/gBRbeNJ9adTnSMC50htRPhTR4mzJesjl/xcapg2roOEtRN3nYLJJlNN/Pgl1m
         HWAHFmi1MLdS4p9O46baVt1GxxQavkE8G1uVj8qpq59Nfmzs/6NbGH3QJqo7KGmQaiga
         JE2rgdX22DVCbX3pIA9d5qXxQoWc0W6VXJZ2+yHc5xKAXGH1JS6OyJCmTpqt1/qpD9G4
         QFl70V3WApEtl1JwT5Ec33Dpz1vAqvpIbLPddkYv3LrUgi+u2HU39CwpeBEGg9E0yIvI
         mcGw==
X-Gm-Message-State: AA+aEWYcjpE4vBUXetdQvwATasqTZPsQXZgtwPISAvY5PqKiIRP39vDz
        P0/Q4gXBYW4DtWqWv3qB57TlmIWB2tM=
X-Google-Smtp-Source: AFSGD/XVYPaqejMqGqj+m3rDXTzGhp6Dvp3yvTZ19oeUqGT5b3qWPYCgZI/bxfN9SyrWC6ksHjz1lA==
X-Received: by 2002:a17:902:b707:: with SMTP id d7mr9098319pls.29.1543880911479;
        Mon, 03 Dec 2018 15:48:31 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id z191sm17071850pgd.74.2018.12.03.15.48.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 15:48:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181130183317.GL18262@codeaurora.org>
Cc:     evgreen@chromium.org, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        thierry.reding@gmail.com
References: <20181121000648.29262-1-ilina@codeaurora.org>
 <154283618199.88331.10217252750356423959@swboyd.mtv.corp.google.com>
 <20181126161455.GA28236@codeaurora.org>
 <154330994255.88331.11409511159882116164@swboyd.mtv.corp.google.com>
 <20181127182123.GC28236@codeaurora.org>
 <154335513853.88331.9713562640538396853@swboyd.mtv.corp.google.com>
 <20181128173959.GC18262@codeaurora.org> <20181129002457.GJ24969@minitux>
 <20181129214539.GG18262@codeaurora.org>
 <20181130183317.GL18262@codeaurora.org>
Message-ID: <154388090959.88331.13819513007141877197@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [RFC v3 2/3] dt-bindings: sdm845-pinctrl: add wakeup interrupt parent
 for GPIO
Date:   Mon, 03 Dec 2018 15:48:29 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2018-11-30 10:33:17)
> On Thu, Nov 29 2018 at 14:45 -0700, Lina Iyer wrote:
> >On Wed, Nov 28 2018 at 17:25 -0700, Bjorn Andersson wrote:
> >>On Wed 28 Nov 09:39 PST 2018, Lina Iyer wrote:
> >>
> >>>On Tue, Nov 27 2018 at 14:45 -0700, Stephen Boyd wrote:
> >>>> Quoting Lina Iyer (2018-11-27 10:21:23)
> >>>> > On Tue, Nov 27 2018 at 02:12 -0700, Stephen Boyd wrote:
> =

> [...]
> >BTW, I am discussing with the internal folks here on if we need to mask
> >TLMM when the wakeup-parent is MPM. If we don't have to, we should be
> >able to follow the same model as we done in this patch and don't even
> >have to check the compatible or use the approach suggested by Stephen.
> >
> The TLMM and the MPM are not active at the same time. However, there is
> a small chance they might be (a few clock cycles) when the system is
> going down, but even then, since we replay the interrupt from the MPM
> driver before the interrupts are serviced by Linux, we would not see
> multiple GPIO interrupts.
> =

> The way we have MPM working downstream, for a wakeup GPIO IRQ -
> =

> a. Application cores gets a wakeup interrupt either from RPM or GIC (if
> TLMM was not powered down) while still in the interrupt locked context.
> =

> b. In the hardware, apps core handshakes with the RPM and then starts
> resuming from the platform's system idle driver.
> =

> c. The first CPU to wake up calls MPM driver from the idle driver, which
> reads the shared memory to find the MPM pins that are set. Converts the
> MPM pins to their corresponding linux interrupt and replays the
> interrupt.
> =

> d. Idle driver exits and wakeup GPIO interrupt is handled.
> =

> The MPM pins are not updated after the RPM lets the application core to
> run. Since TLMM is functional after the RPM handshake, it takes over.
> =


Thanks for the background info. I don't think it really changes anything
that we've discussed though. We still need to mask the IRQ in TLMM all
the time when we're using the PDC and we need to leave it unmasked and
replay edges that the MPM sees when we use the MPM. Should I clean up my
RFC patch and post it to the list? I'd like to see hierarchical gpio
irqs work in general for this problem and also the SSBI/SPMI gpio irq
problem that Linus pointed out last week.

