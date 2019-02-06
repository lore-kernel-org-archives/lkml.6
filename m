Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3C8C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A502081B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfBFIyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 03:54:17 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42299 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbfBFIyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 03:54:17 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1grIy7-00046q-CR; Wed, 06 Feb 2019 09:54:07 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1grIy5-0003KU-RK; Wed, 06 Feb 2019 09:54:05 +0100
Date:   Wed, 6 Feb 2019 09:54:05 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>, jic23@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com,
        mcoquelin.stm32@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        vilhelm.gray@gmail.com, linux-stm32@st-md-mailman.stormreply.com,
        Tomasz Duszynski <tduszyns@gmail.com>
Subject: Re: [PATCH 2/4] pwm: stm32-lp: Add power management support
Message-ID: <20190206085405.pdiwd3c6wjog5hl7@pengutronix.de>
References: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
 <1549370429-19116-3-git-send-email-fabrice.gasnier@st.com>
 <20190205204732.zrbhgyxnvjbwfyw4@pengutronix.de>
 <20190205222522.GB1372@mithrandir>
 <6584a59b-657d-adc9-fab2-eb1a9baba05d@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6584a59b-657d-adc9-fab2-eb1a9baba05d@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 09:42:48AM +0100, Fabrice Gasnier wrote:
> If you agree with the current approach, I can send a V2 with Tomasz's
> suggestion to remove the ifdefs and use __maybe_unused instead.

I think the suspend callback should have something like:

	if (is_still_enabled) {
		/*
		 * The consumer didn't stop us, so refuse to suspend.
		 */
		dev_err(dev, "The consumer didn't stop us, so refuse to suspend.\n");
		return -EBUSY;
	}

This way there are no bad surprises if the pwm is suspended before its
consumer and it's obvious what is missing.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
