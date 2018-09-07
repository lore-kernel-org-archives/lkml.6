Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E78FC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E8020855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E8020855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbeIHCAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:00:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43382 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbeIHCAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:00:05 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C55A2D6B;
        Fri,  7 Sep 2018 21:17:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4.18 092/145] i2c: designware: Re-init controllers with pm_disabled set on resume
Date:   Fri,  7 Sep 2018 23:09:18 +0200
Message-Id: <20180907210911.590639512@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 9d9a152ebaa86a9dede4624919566483c955d0a7 upstream.

On Bay Trail and Cherry Trail devices we set the pm_disabled flag for I2C
busses which the OS shares with the PUNIT as these need special handling.
Until now we called dev_pm_syscore_device(dev, true) for I2C controllers
with this flag set to keep these I2C controllers always on.

After commit 12864ff8545f ("ACPI / LPSS: Avoid PM quirks on suspend and
resume from hibernation"), this no longer works. This commit modifies
lpss_iosf_exit_d3_state() to only run if lpss_iosf_enter_d3_state() has ran
before it, so that it does not run on a resume from hibernate (or from S3).

On these systems the conditions for lpss_iosf_enter_d3_state() to run
never become true, so lpss_iosf_exit_d3_state() never gets called and
the 2 LPSS DMA controllers never get forced into D0 mode, instead they
are left in their default automatic power-on when needed mode.

The not forcing of D0 mode for the DMA controllers enables these systems
to properly enter S0ix modes, which is a good thing.

But after entering S0ix modes the I2C controller connected to the PMIC
no longer works, leading to e.g. broken battery monitoring.

The _PS3 method for this I2C controller looks like this:

            Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
            {
                If ((((PMID == 0x04) || (PMID == 0x05)) || (PMID == 0x06)))
                {
                    Return (Zero)
                }

                PSAT |= 0x03
                Local0 = PSAT /* \_SB_.I2C5.PSAT */
            }

Where PMID = 0x05, so we enter the Return (Zero) path on these systems.

So even if we were to not call dev_pm_syscore_device(dev, true) the
I2C controller will be left in D0 rather then be switched to D3.

Yet on other Bay and Cherry Trail devices S0ix is not entered unless *all*
I2C controllers are in D3 mode. This combined with the I2C controller no
longer working now that we reach S0ix states on these systems leads to me
believing that the PUNIT itself puts the I2C controller in D3 when all
other conditions for entering S0ix states are true.

Since now the I2C controller is put in D3 over a suspend/resume we must
re-initialize it afterwards and that does indeed fix it no longer working.

This commit implements this fix by:

1) Making the suspend_late callback a no-op if pm_disabled is set and
making the resume_early callback skip the clock re-enable (since it now was
not disabled) while still doing the necessary I2C controller re-init.

2) Removing the dev_pm_syscore_device(dev, true) call, so that the suspend
and resume callbacks are actually called. Normally this would cause the
ACPI pm code to call _PS3 putting the I2C controller in D3, wreaking havoc
since it is shared with the PUNIT, but in this special case the _PS3 method
is a no-op so we can safely allow a "fake" suspend / resume.

Fixes: 12864ff8545f ("ACPI / LPSS: Avoid PM quirks on suspend and resume ...")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=200861
Cc: 4.15+ <stable@vger.kernel.org> # 4.15+
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-designware-master.c  |    1 -
 drivers/i2c/busses/i2c-designware-platdrv.c |    7 ++++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -693,7 +693,6 @@ int i2c_dw_probe(struct dw_i2c_dev *dev)
 	i2c_set_adapdata(adap, dev);
 
 	if (dev->pm_disabled) {
-		dev_pm_syscore_device(dev->dev, true);
 		irq_flags = IRQF_NO_SUSPEND;
 	} else {
 		irq_flags = IRQF_SHARED | IRQF_COND_SUSPEND;
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -448,6 +448,9 @@ static int dw_i2c_plat_suspend(struct de
 {
 	struct dw_i2c_dev *i_dev = dev_get_drvdata(dev);
 
+	if (i_dev->pm_disabled)
+		return 0;
+
 	i_dev->disable(i_dev);
 	i2c_dw_prepare_clk(i_dev, false);
 
@@ -458,7 +461,9 @@ static int dw_i2c_plat_resume(struct dev
 {
 	struct dw_i2c_dev *i_dev = dev_get_drvdata(dev);
 
-	i2c_dw_prepare_clk(i_dev, true);
+	if (!i_dev->pm_disabled)
+		i2c_dw_prepare_clk(i_dev, true);
+
 	i_dev->init(i_dev);
 
 	return 0;


