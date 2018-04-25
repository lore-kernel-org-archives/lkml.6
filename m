Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752809AbeDYVFH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 17:05:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41982 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751558AbeDYVE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 17:04:58 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 96646601CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=collinsd@codeaurora.org
Subject: Re: [PATCH v2 2/2] regulator: add QCOM RPMh regulator driver
To: Mark Brown <broonie@kernel.org>
Cc: Doug Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>, Matthias Kaehlcke <mka@chromium.org>
References: <cover.1523673467.git.collinsd@codeaurora.org>
 <4b45f41996ea3344340e44fab2dc9e487572e209.1523673467.git.collinsd@codeaurora.org>
 <CAD=FV=XKYCDtF93RtYi+dokR2BcT-z6Ex3UjgJ0ia_kF=847eA@mail.gmail.com>
 <4e3353fe-ebb5-46bb-aa58-49ad04c4d9db@codeaurora.org>
 <CAD=FV=W28_exRv+H0MJvPnHWGEeUG=SMKr=UqEKpBzkH44Fzmg@mail.gmail.com>
 <132ab845-52d6-6192-4d8c-5a9c95410688@codeaurora.org>
 <20180424174507.GI22073@sirena.org.uk>
 <20a8f736-2687-f14f-eaa1-2b2c06eed629@codeaurora.org>
 <20180425103136.GB24769@sirena.org.uk>
From: David Collins <collinsd@codeaurora.org>
Message-ID: <f98416ac-230c-0362-ed50-a7f92ff283d7@codeaurora.org>
Date: Wed, 25 Apr 2018 14:04:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20180425103136.GB24769@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> I think that's probably only OK if we have a specific error code for the
>>> regulator being limited in this way otherwise our error handling for I/O
>>> problems involves us trying to reconfigure supplies which seems like it
>>> would be risky.  

>> Would you be ok with -EAGAIN being used for this purpose?

> Using -EAGAIN for "I can't ever read the configuration from this
> regulator" doesn't seem right - it's not like any number of retries
> will ever manage to read the value back.

In this case, the _regulator_get_voltage() call can succeed, but only
after a voltage is explicitly requested from the framework side.  The
intention here would then be to call _regulator_do_set_voltage() with the
constraint min_uV to max_uV range.  After that, subsequent
_regulator_get_voltage() calls will be successful.

Here is the general idea:

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 65f9b7c..e61983d 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -910,6 +910,19 @@ static int machine_constraints_voltage(struct
regulator_dev *rdev,
 	    rdev->constraints->min_uV && rdev->constraints->max_uV) {
 		int target_min, target_max;
 		int current_uV = _regulator_get_voltage(rdev);
+		if (current_uV == -EAGAIN) {
+			/*
+			 * Regulator voltage cannot be read until after
+			 * configuration; try setting constraint range.
+			 */
+			rdev_info(rdev, "Setting %d-%duV\n",
+				  rdev->constraints->min_uV,
+				  rdev->constraints->max_uV);
+			_regulator_do_set_voltage(rdev,
+						  rdev->constraints->min_uV,
+						  rdev->constraints->max_uV);
+			current_uV = _regulator_get_voltage(rdev);
+		}
 		if (current_uV < 0) {
 			rdev_err(rdev,
 				 "failed to get the current voltage(%d)\n",

Do you still have reservations about using -EAGAIN for this purpose?  If
so, which error code would you suggest using?

Thanks,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
