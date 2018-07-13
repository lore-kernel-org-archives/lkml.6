Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F347ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43A2208B4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43A2208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbeGMQEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:04:12 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34589 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729763AbeGMQEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:04:12 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1fe0JV-0005uJ-2y; Fri, 13 Jul 2018 17:48:57 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1fe0JS-0002ZM-Cf; Fri, 13 Jul 2018 17:48:54 +0200
Date:   Fri, 13 Jul 2018 17:48:54 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, m.purski@samsung.com, p.paillet@st.com,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] regulator: core: fix _regulator_do_disable return value
Message-ID: <20180713154854.qmnraejcdq6gqn3x@pengutronix.de>
References: <20180713125624.13783-1-m.felsch@pengutronix.de>
 <20180713130715.GC16228@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713130715.GC16228@sirena.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 17:36:14 up 204 days,  4:14, 54 users,  load average: 0.01, 0.03,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

tanks for the feedback.

On 18-07-13 14:07, Mark Brown wrote:
> On Fri, Jul 13, 2018 at 02:56:24PM +0200, Marco Felsch wrote:
> 
> > Currently _regulator_do_disable returns 0 if either the ena_pin nor the
> > ops.disbale() isn't present. This assumes that the call was successful
> > but it wasn't because disbaling isn't supported at all.
> 
> > The last case of the if-chain should return -EINVAL, because disabling
> > isn't supported by the driver as it is done already by
> > _regulator_do_enable.
> 
> This is fine - consumers shouldn't expect that a disable will cause
> anything to actually get powered off, constraints or other consumers
> might mean that the disable doesn't actually happen.  It's just the same
> as a consumer with an always on flag.

Okay, I understand that the behaviour should be like the always-on
contrain. But now the behaviour of the core is like my v1 of
"Re-Enable support to disable switch regulators". It's like a 'simulated
off', which wasn't a good solution for you. The difference is, that the
'simulated off' is now made in the core.

Regards,
Marco
