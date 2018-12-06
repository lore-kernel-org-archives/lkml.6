Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6977C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D54320850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D54320850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chris-wilson.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbeLFJ2m convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:28:42 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:52081 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727763AbeLFJ2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:28:41 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 14796737-1500050 
        for multiple; Thu, 06 Dec 2018 09:28:37 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     "Zhang, Jerry\(Junwei\)" <Jerry.Zhang@amd.com>,
        =?utf-8?q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Christian Koenig <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>, Huang Rui <ray.huang@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <d81f2067-db9f-eeca-7d65-956d5f772093@daenzer.net>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20181205165621.5805-1-michel@daenzer.net>
 <10fca21a-5d7c-fe9e-07f0-6200e9de538e@amd.com>
 <154408757908.3572.9138595858555797029@skylake-alporthouse-com>
 <d81f2067-db9f-eeca-7d65-956d5f772093@daenzer.net>
Message-ID: <154408851245.18057.9814330902486356341@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH 1/2] drm: Only #define DEBUG if CONFIG_DYNAMIC_DEBUG is disabled
Date:   Thu, 06 Dec 2018 09:28:32 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Michel Dänzer (2018-12-06 09:21:40)
> On 2018-12-06 10:12 a.m., Chris Wilson wrote:
> > Quoting Zhang, Jerry(Junwei) (2018-12-06 02:40:42)
> >> On 12/6/18 12:56 AM, Michel Dänzer wrote:
> >>> From: Michel Dänzer <michel.daenzer@amd.com>
> >>>
> >>> The following cases are possible for pr_debug():
> >>>
> >>> 1. CONFIG_DYNAMIC_DEBUG disabled
> >>>     a) DEBUG not defined: pr_debug() translates to no_printk(...), i.e.
> >>>        it never generates any output.
> >>>     b) DEBUG defined: pr_debug() translates to printk(KERN_DEBUG ...),
> >>>        i.e. it generates output which doesn't appear in dmesg by default,
> >>>        can be enabled dynamically.
> >>>
> >>> 2. CONFIG_DYNAMIC_DEBUG enabled: pr_debug() translates to
> >>>     dynamic_pr_debug()
> >>>     a) DEBUG not defined: dynamic_pr_debug() generates no output by
> >>>        default, can be enabled dynamically.
> >>>     b) DEBUG defined: dynamic_pr_debug() generates output by default,
> >>>        can be disabled dynamically.
> >>>
> >>> The intention for drm_debug_printer() is to generate output which
> >>> doesn't appear in dmesg by default, but can be enabled dynamically, i.e.
> >>> cases 1b) and 2a). However, defining DEBUG unconditionally gave us 2b)
> >>> instead of 2a) with CONFIG_DYNAMIC_DEBUG enabled.
> >>>
> >>> Fixes: 79a5ad2fdb3c ("drm: Enable pr_debug() for drm_printer")
> >>> Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
> >> Reviewed-by: Junwei Zhang <Jerry.Zhang@amd.com>
> > 
> > At the cost of 1a? Nah.
> 
> We still #define DEBUG if CONFIG_DYNAMIC_DEBUG isn't defined, so it's
> still 1b), not 1a).

I completely fluffed my reading of ifndef.

#if !IS_ENABLED(CONFIG_DYNAMIC_DEBUG)
-Chris
