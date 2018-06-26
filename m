Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037AAC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB93223D5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0OGvdr4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB93223D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753150AbeFZVjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 17:39:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752175AbeFZVjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 17:39:16 -0400
Received: from mail-it0-f47.google.com (mail-it0-f47.google.com [209.85.214.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6A6C23EBF;
        Tue, 26 Jun 2018 21:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530049156;
        bh=6D7WDbeFEDS6ujrxcRrtT4Oh+52tXITCPW1f0T0P5AI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r0OGvdr4TGwqpcQ46zKs2ohVoXNC4FAngKHaLHd5VeSWoM0J9/FfkgKt+HkrsjrtV
         TyjXKHO9SS4+QvByynghMxhu3zsRcvR/VVzlQVpdt5yPLZt0YnTSWIqZdqf2KPFXeQ
         n10EgRqzohNXLsOnLbGb6YWPC4lJXQJGWllwjMlU=
Received: by mail-it0-f47.google.com with SMTP id a195-v6so4518373itd.3;
        Tue, 26 Jun 2018 14:39:16 -0700 (PDT)
X-Gm-Message-State: APt69E08V5ZQ+loC6zYCZq5LVl884N5GCCA/MhSTyDf1PxianvJGDpP2
        oZ79ucHuPovn17J11iJrxGGh6tPEsByiOVkyxw==
X-Google-Smtp-Source: AAOMgpdyUE/rD6vzXEgiWtrgzg3bn/7TltbC+b00u+cd7MfV944CkiBV6LLYNHNeWOPmnwDQy7a358fAER8Io+8VWgs=
X-Received: by 2002:a24:798f:: with SMTP id z137-v6mr2750002itc.19.1530049155573;
 Tue, 26 Jun 2018 14:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180619212744.794-1-daniel@zonque.org>
In-Reply-To: <20180619212744.794-1-daniel@zonque.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 26 Jun 2018 15:39:04 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLfzfJC=_NhJy=jFAqEgfi=cvjMcnkjdHdzfM2uhKGBAQ@mail.gmail.com>
Message-ID: <CAL_JsqLfzfJC=_NhJy=jFAqEgfi=cvjMcnkjdHdzfM2uhKGBAQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/4] Adding DT functionality to w1 busses
To:     Daniel Mack <daniel@zonque.org>
Cc:     zbr@ioremap.net, Mark Rutland <mark.rutland@arm.com>,
        szabolcs.gyurko@tlt.hu, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 3:27 PM, Daniel Mack <daniel@zonque.org> wrote:
> In order to fully move battery-supplied devices over to devicetree, the
> onewire subsystem must get some updates.
>
> Currently, the w1 bus system works like this. Device families, such as
> battery controllers etc, are registered to the w1 core. Once a master
> device is probed, it starts scanning the bus. Slave devices that are
> revealed through this scan and that match previously registered
> families are then registered, and their .add_slave() callback is
> invoked.
>
> Some devices, such as the ds2760, use that callback to call
> platform_device_alloc() at runtime with a fixed device name to
> instanciate their only user. That user does the actual work, while the
> slave device merely functions as an I/O proxy. In the user
> implementation, the w1 slave device is accessible through
> dev->parent.

Looks to me like you are letting the driver structure define the DT
structure. This detail is all irrelevant to DT.

>
> Now, for devicetree environments, this has to change a bit. First, slave
> devices need to have a matching table so they can be listed as sub-nodes
> of their master bus controller. Second, the core needs to match the
> entries in these tables against the sub-nodes of the master node.
> These two are trivial to do.
>
> The next question is how the w1 slave device and its user(s) are linked
> together. I'm proposing a DT layout with the following example:
>
>         onewire {
>                 compatible = "w1-gpio";
>
>                 w1_slave: slave@0 {
>                         compatible = "maxim,w1-ds2760";
>                 };
>         };
>
>         battery-supply {
>                 compatible = "maxim,ds2760-supply";
>                 w1-slave = <&w1_slave>;
>         };

This should just be one node and a child of the 1-wire master.

Rob
