Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB69AC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755BC23EC0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 10:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755BC23EC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753684AbeGFKfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 06:35:47 -0400
Received: from muru.com ([72.249.23.125]:50488 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753519AbeGFKfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 06:35:45 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D1AB480B6;
        Fri,  6 Jul 2018 10:38:43 +0000 (UTC)
Date:   Fri, 6 Jul 2018 03:35:41 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        bcousson@baylibre.com, paul@pwsan.com, t-kristo@ti.com,
        mark.rutland@arm.com
Subject: Re: [PATCH v4 4/6] bus: ti-sysc: Add support for software reset
Message-ID: <20180706103541.GC112168@atomide.com>
References: <20180705142319.19583-1-faiz_abbas@ti.com>
 <20180705142319.19583-5-faiz_abbas@ti.com>
 <20180705154758.GA112168@atomide.com>
 <cf8652a1-019c-d423-9b44-0d62006734f8@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf8652a1-019c-d423-9b44-0d62006734f8@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Faiz Abbas <faiz_abbas@ti.com> [180706 10:05]:
> Hi,
> 
> On Thursday 05 July 2018 09:17 PM, Tony Lindgren wrote:
> > * Faiz Abbas <faiz_abbas@ti.com> [180705 14:24]:
> >> +static int sysc_reset(struct sysc *ddata)
> >> +{
> >> +	int offset = ddata->offsets[SYSC_SYSCONFIG];
> >> +	int val = sysc_read(ddata, offset);
> > 
> > Can you please just warn and return early for now if no
> > syss_mask is specified? Otherwise we'll have mysterious
> > errors if somebody leaves out "ti,hwmods" for module types
> > we do not yet support reset for.
> 
> RESET write to sysconfig can still happen even if there's no syss_mask
> right? Not all modules need to poll on reset status.

It can but we currently don't have anything similar to
srst_udelay like we have in _ocp_softreset(). And we don't
currently have suport for sysc reset done bit.

So we want to warn and return error except in the known
working case for now.

Regards,

Tony
