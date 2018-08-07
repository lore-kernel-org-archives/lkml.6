Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D80CC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CB0217BF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 12:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06CB0217BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389030AbeHGO3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 10:29:51 -0400
Received: from ozlabs.org ([203.11.71.1]:35469 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbeHGO3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 10:29:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41lD4c50lTz9rxx;
        Tue,  7 Aug 2018 22:15:44 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     npiggin@gmail.com, benh@kernel.crashing.org,
        ego@linux.vnet.ibm.com, huntbag@linux.vnet.ibm.com,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 0/3] New device-tree format  and Opal based idle save-restore
In-Reply-To: <20180802045132.12432-1-akshay.adiga@linux.vnet.ibm.com>
References: <20180802045132.12432-1-akshay.adiga@linux.vnet.ibm.com>
Date:   Tue, 07 Aug 2018 22:15:37 +1000
Message-ID: <87zhxybceu.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> writes:

> Previously if a older kernel runs on a newer firmware, it may enable
> all available states irrespective of its capability of handling it.
> New device tree format adds a compatible flag, so that only kernel
> which has the capability to handle the version of stop state will enable
> it.
>
> Older kernel will still see stop0 and stop0_lite in older format and we
> will depricate it after some time.
>
> 1) Idea is to bump up the version string in firmware if we find a bug or
> regression in stop states. A fix will be provided in linux which would
> now know about the bumped up version of stop states, where as kernel
> without fixes would ignore the states.
>
> 2) Slowly deprecate cpuidle/cpuhotplug threshold which is hard-coded
> into cpuidle-powernv driver. Instead use compatible strings to indicate
> if idle state is suitable for cpuidle and hotplug.
>
> New idle state device tree format :
>        power-mgt {
>             ...
>          ibm,enabled-stop-levels = <0xec000000>;
>          ibm,cpu-idle-state-psscr-mask = <0x0 0x3003ff 0x0 0x3003ff>;
>          ibm,cpu-idle-state-latencies-ns = <0x3e8 0x7d0>;
>          ibm,cpu-idle-state-psscr = <0x0 0x330 0x0 0x300330>;
>          ibm,cpu-idle-state-flags = <0x100000 0x101000>;
>          ibm,cpu-idle-state-residency-ns = <0x2710 0x4e20>;
>          ibm,idle-states {
>                      stop4 {
>                          flags = <0x207000>;
>                          compatible = "ibm,state-v1",
> 				      "cpuidle",
> 				      "opal-supported";
>                          psscr-mask = <0x0 0x3003ff>;
>                          handle = <0x102>;
>                          latency-ns = <0x186a0>;
>                          residency-ns = <0x989680>;
>                          psscr = <0x0 0x300374>;
>                   };
>                     ...
>                     stop11 {
>                      ...
>                          compatible = "ibm,state-v1",
> 				      "cpuoffline",
> 				      "opal-supported";
>                          ...
>                   };
>              };
>
> Skiboot patch-set for device-tree is posted here :
> https://patchwork.ozlabs.org/project/skiboot/list/?series=58934

I don't see a device tree binding documented anywhere?

There is an existing binding defined for ARM chips, presumably it
doesn't do everything we need. But are there good reasons why we are not
using it as a base?

See: Documentation/devicetree/bindings/arm/idle-states.txt


The way you're using compatible is not really consistent with its
traditional meaning.

eg, you have multiple states with:

                compatible = "ibm,state-v1",
                            "cpuoffline",
                            "opal-supported";


This would typically mean that all those state are all "compatible" with
some semantics defined by the name "ibm,state-v1". What you're trying to
say (I think) is that each state is "version 1" of *that state*. And
only kernels that understand version 1 should use the state.

And "cpuoffline" and "opal-supported" definitely don't belong in
compatible AFAICS, they should simply be boolean properties of the node.

cheers
