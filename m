Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD10C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F29214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfBUJiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:38:15 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:3057 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbfBUJiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:38:14 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id A1FF013F8D6;
        Thu, 21 Feb 2019 10:37:55 +0100 (CET)
Subject: Re: [PATCH v1] regulator: core: Log forbidden DRMS operation
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
References: <6e471922-2850-97b8-c555-34e1708cbc38@free.fr>
 <20190219163929.GA20883@sirena.org.uk>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <aac7535e-b27f-60be-ed9d-408ed6f869b5@free.fr>
Date:   Thu, 21 Feb 2019 10:37:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190219163929.GA20883@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2019 17:39, Mark Brown wrote:

> On Tue, Feb 19, 2019 at 05:02:46PM +0100, Marc Gonzalez wrote:
> 
>> When REGULATOR_CHANGE_DRMS is not set, drms_uA_update is a no-op.
>> It used to print a debug message, which was dropped in commit
>> 8a34e979f684 ("regulator: refactor valid_ops_mask checking code")
>> 
>> Let's bring the debug message back as KERN_INFO, because it is very
>> useful to diagnose missing regulator-allow-set-load properties.
> 
> No, it's perfectly normal for machine constraints to stop drivers from
> doing things so we shouldn't warn on this - it would get incredibly
> noisy if we started printing every time constraints didn't let us do
> something at info level.  Debug level might be viable, or definitely
> vdbg or trace points.

I had a look at the various REGULATOR_CHANGE_* flags.

#define REGULATOR_CHANGE_VOLTAGE	0x1
#define REGULATOR_CHANGE_CURRENT	0x2
#define REGULATOR_CHANGE_MODE		0x4
#define REGULATOR_CHANGE_STATUS		0x8
#define REGULATOR_CHANGE_DRMS		0x10
#define REGULATOR_CHANGE_BYPASS		0x20

Several functions return an error (and log a KERN_ERR message) if their
corresponding flag is not set:

regulator_check_voltage()	REGULATOR_CHANGE_VOLTAGE
regulator_check_current_limit()	REGULATOR_CHANGE_CURRENT
regulator_mode_constrain()	REGULATOR_CHANGE_MODE

Others succeed silently even if their corresponding flag is not set:

drms_uA_update()		REGULATOR_CHANGE_DRMS
regulator_allow_bypass()	REGULATOR_CHANGE_BYPASS


Why is setting the voltage handled differently than setting the load?

Regards.
