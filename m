Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0593C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCFA2081B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387787AbeL1T36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 14:29:58 -0500
Received: from mga18.intel.com ([134.134.136.126]:35907 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729398AbeL1T36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 14:29:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Dec 2018 11:29:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,410,1539673200"; 
   d="scan'208";a="305834893"
Received: from ellie.jf.intel.com (HELO ellie) ([10.54.70.81])
  by fmsmga006.fm.intel.com with ESMTP; 28 Dec 2018 11:29:56 -0800
From:   Vinicius Costa Gomes <vinicius.gomes@intel.com>
To:     PO LIU <po.liu@nxp.com>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "davem\@davemloft.net" <davem@davemloft.net>,
        "haustad\@cisco.com" <haustad@cisco.com>,
        "nicolas.ferre\@microchip.com" <nicolas.ferre@microchip.com>,
        "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        PO LIU <po.liu@nxp.com>, PO LIU <po.liu@nxp.com>
Subject: Re: [PATCH] net: tsn: add an netlink interface between kernel and application layer
In-Reply-To: <1545968945-7290-1-git-send-email-Po.Liu@nxp.com>
References: <1545968772-7237-1-git-send-email-Po.Liu@nxp.com> <1545968945-7290-1-git-send-email-Po.Liu@nxp.com>
Date:   Fri, 28 Dec 2018 11:29:56 -0800
Message-ID: <87r2e14fgr.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

PO LIU <po.liu@nxp.com> writes:

> This patch provids netlink method to configure the TSN protocols hardwares.
> TSN guaranteed packet transport with bounded low latency, low packet delay
> variation, and low packet loss by hardware and software methods.

I don't think having another way to configure TSN features is a good
idea. We already have the CBS/ETF/taprio family of qdiscs, that provide
(or will in the near future, more on this later) a way to configure the
hardware.

A little background on the choice of qdiscs as an interface (and why we
came to believe they are a good abstraction), they already provide a way
to map packets into traffic classes (it isn't clear in our proposal how
you do that, but I think you are using something like mqprio), they
provide a neat way to "compose" (by installing one under another), they
already have a user facing API with various counters, and very
importantly for TSN they have mecanisms to offload some of their work to
the hardware.

I suggest is for you to take a look at how CBS offloading was
implemented for the Intel i210:

https://patchwork.ozlabs.org/cover/824626/

Patches 4 and 5 should be the interesting ones. I think you can use them
as inspiration for enabling CBS offload in your driver.

If you did take a look at those patches (and the current work that has
been upstreamed), my question then becomes, what are the reasons that it
might not work for your use cases?

>
> The three basic components of TSN are:
>
> 1. Time synchronization: This was implement by 8021AS which base on the
>    IEEE1588 precision Time Protocol. This is configured by the other way
>    in kernel.
>    8021AS not included in this patch.
>
> 2. Scheduling and traffic shaping and per-stream filter policing:
>    This patch support Qbv/Qci.

I am working on a proposal for the API for Qbv (and Qbu) offloading
using taprio. I should send it soon-ish. Your feedback would be very
welcome.

Also, how to expose in the qdiscs the per-stream filtering and policing
parts (Qci) is something that I don't know how to do right now, any
suggestions would be nice.

In short, take a look at what's there and see what's missing for the
stuff that you care about, then we can work on that.

>
> 3. Selection of communication paths:
>    This patch not support the pure software only TSN protocols(like Qcc)
>    but hardware related configuration.
>
> TSN Protocols supports by this patch: Qbv/Qci/Qbu/Credit-base Shaper(Qav).
> This patch verified on NXP ls1028ardb board.
>
> Will add more protocols in the future.
>
> Signed-off-by: Po Liu <Po.Liu@nxp.com>


Cheers,
--
Vinicius
