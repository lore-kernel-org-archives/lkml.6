Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E85FC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DFB23FE1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 09:42:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3DFB23FE1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753625AbeGFJmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 05:42:14 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:53021 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753314AbeGFJmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 05:42:12 -0400
Received: from 79.184.254.38.ipv4.supernova.orange.pl (79.184.254.38) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 401ed54d407565b1; Fri, 6 Jul 2018 11:42:09 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Takashi Iwai <tiwai@suse.de>, Thomas H4nig <haenig@cosifan.de>
Cc:     Erik Schmauss <erik.schmauss@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [REGRESSION 4.17] Spurious wakeup / reboot with power button
Date:   Fri, 06 Jul 2018 11:40:43 +0200
Message-ID: <10224352.M7fh6vac6O@aspire.rjw.lan>
In-Reply-To: <s5hr2kgetux.wl-tiwai@suse.de>
References: <s5hk1qaf9hv.wl-tiwai@suse.de> <5cce6fa6-c089-7a6b-aaef-bdd04a3761c6@cosifan.de> <s5hr2kgetux.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, July 6, 2018 8:55:18 AM CEST Takashi Iwai wrote:
> On Fri, 06 Jul 2018 07:18:36 +0200,
> Thomas H4nig wrote:
> > 
> > 
> > 
> > Am 05.07.2018 um 18:56 schrieb Takashi Iwai:
> > > On Thu, 05 Jul 2018 18:02:11 +0200,
> > > Rafael J. Wysocki wrote:
> > >>
> > >> [The Lv's address is not valid any more, so drop it from the CC]
> > >>
> > >> On Thursday, July 5, 2018 5:10:20 PM CEST Rafael J. Wysocki wrote:
> > >>> On Thu, Jul 5, 2018 at 5:09 PM, Takashi Iwai <tiwai@suse.de> wrote:
> > >>>> On Thu, 05 Jul 2018 16:00:14 +0200,
> > >>>> Thomas H4nig wrote:
> > >>>>>
> > >>>>> Am 05.07.2018 um 14:12 schrieb Takashi Iwai:
> > >>>>>> On Thu, 05 Jul 2018 12:41:03 +0200,
> > >>>>>> Rafael J. Wysocki wrote:
> > >>>>>>>
> > >>>>>>> On Thursday, July 5, 2018 11:50:11 AM CEST Takashi Iwai wrote:
> > >>>>>>>> On Thu, 05 Jul 2018 11:34:59 +0200,
> > >>>>>>>> Rafael J. Wysocki wrote:
> > >>>>>>>>>
> > >>>>>>>>> Hi,
> > >>>>>>>>>
> > >>>>>>>>> On Thu, Jul 5, 2018 at 9:05 AM, Takashi Iwai <tiwai@suse.de> wrote:
> > >>>>>>>>>> Hi,
> > >>>>>>>>>>
> > >>>>>>>>>> we've got a regression report since 4.17 about the behavior of
> > >>>>>>>>>> power-off with the power button.  When a machine is powered off with
> > >>>>>>>>>> the power button on desktop, it reboots after a few seconds instead of
> > >>>>>>>>>> power down.
> > >>>>>>>>>>
> > >>>>>>>>>> The manual power down via "systemctl poweroff" works fine, so it's
> > >>>>>>>>>> possibly some spurious wakeup by the power button action, and some
> > >>>>>>>>>> ACPI-related change is suspected.
> > >>>>>>>>>> The regression still remains in 4.18-rc3.
> > >>>>>>>>>
> > >>>>>>>>> There are only a few ACPI commits directly related to power management
> > >>>>>>>>> between 4.16 and 4.17 and none of them looks particularly suspicious.
> > >>>>>>>>
> > >>>>>>>> OK, interesting.
> > >>>>>>>>
> > >>>>>>>>> It looks like the power button state may not be cleared sufficiently
> > >>>>>>>>> after it's been pressed which is now visible for some reason.
> > >>>>>>>>
> > >>>>>>>> Hmm, where can such a state remain?  Since it happens after the
> > >>>>>>>> machine turned off, some (ACPI) wakeup bits?
> > >>>>>>>
> > >>>>>>> Basically, yes.
> > >>>>>>>
> > >>>>>>> It looks like a GPE may remain active which then triggers wakeup after
> > >>>>>>> shutdown.
> > >>>>>>>
> > >>>>>>> On a hunch, I'm wondering if reverting commit
> > >>>>>>>
> > >>>>>>> 18996f2db918 ACPICA: Events: Stop unconditionally clearing ACPI IRQs during suspend/resume
> > >>>>>>>
> > >>>>>>> (may not revert clearly, though) makes any difference.
> > >>>>>>
> > >>>>>> OK, I'm building a 4.17.x test kernel with that revert, in OBS
> > >>>>>> home:tiwai:bsc1099930 repo.
> > >>>>>>
> > >>>>>> Thomas, could you try later the kernel in
> > >>>>>>   http://download.opensuse.org/repositories/home:/tiwai:/bsc1099930/standard/
> > >>>>>> ?  It'll take an hour or so until the build finishes.
> > >>>>>
> > >>>>> With your new built kernel
> > >>>>> 4.17.4-1.g6f23755-default
> > >>>>>
> > >>>>> the power button works again, so the revert solved the problem
> > >>>>
> > >>>> Thanks, that clarifies the cause.
> > >>>> Adding Erik and Lv to Cc.
> > >>>>
> > >>>> I guess it's the side-effect by removing
> > >>>>         acpi_ev_walk_gpe_list(acpi_hw_clear_gpe_block, NULL);
> > >>>> in acpi_hw_disable_all_gpes().
> > >>>>
> > >>>> This function is called from acpi_power_off_prepare(), and the machine
> > >>>> goes to power off without clearing the GPEs, hence it's woken up later
> > >>>> unexpectedly.
> > >>>
> > >>> That's correct.
> > >>>
> > >>> We need to fix up that commit.  I'll try to prepare something.
> > >>>
> > >>
> > >> Below is a patch to test that theory and maybe fix things if it is correct.
> > >>
> > >> What it does is to clear all GPEs after disabling them in
> > >> acpi_power_off_prepare() which should address the issue if our theory
> > >> about the underlying reason is correct.
> > >>
> > >> Please test.
> > > 
> > > OK, building a new test kernel package in OBS home:tiwai:bsc1099930-2
> > > repo.  It'll appear at
> > >   http://download.opensuse.org/repositories/home:/tiwai:/bsc1099930-2/standard/
> > > 
> > > Thomas, please give it a try later.
> > > 
> > > 
> > > thanks,
> > > 
> > > Takashi
> > 
> > I am sorry, but with your test kernel 4.17.4-1.g76c6238-default the
> > notebook again gets not properly powered off but restarts
> 
> Interesting.  The package version shows that the tested kernel must be
> the right one.  (Though, it'd be good to double-check -- it's often
> confusing if you have multiple same kernel versions on the system.)
> 
> If Rafael's patch doesn't work, we'd need to identify which change in
> the commit 18996f2db918 has the effect.

I'd rather prefer the following modification of the previous patch to be
tested:

---
 drivers/acpi/acpica/achware.h |    2 ++
 drivers/acpi/acpica/evxfgpe.c |   33 ++++++++++++++++++++++++++++++++-
 drivers/acpi/acpica/hwgpe.c   |   24 +++++++++++++++++++++++-
 drivers/acpi/acpica/hwsleep.c |   13 +++++++++----
 drivers/acpi/sleep.c          |    1 +
 include/acpi/acpixf.h         |    1 +
 6 files changed, 68 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/acpi/acpica/achware.h
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/achware.h
+++ linux-pm/drivers/acpi/acpica/achware.h
@@ -97,6 +97,8 @@ acpi_hw_get_gpe_status(struct acpi_gpe_e
 
 acpi_status acpi_hw_disable_all_gpes(void);
 
+acpi_status acpi_hw_clear_all_gpes(void);
+
 acpi_status acpi_hw_enable_all_runtime_gpes(void);
 
 acpi_status acpi_hw_enable_all_wakeup_gpes(void);
Index: linux-pm/drivers/acpi/acpica/hwgpe.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/hwgpe.c
+++ linux-pm/drivers/acpi/acpica/hwgpe.c
@@ -452,7 +452,7 @@ acpi_hw_enable_wakeup_gpe_block(struct a
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Disable and clear all GPEs in all GPE blocks
+ * DESCRIPTION: Disable all GPEs in all GPE blocks
  *
  ******************************************************************************/
 
@@ -466,6 +466,28 @@ acpi_status acpi_hw_disable_all_gpes(voi
 	return_ACPI_STATUS(status);
 }
 
+/******************************************************************************
+ *
+ * FUNCTION:    acpi_hw_clear_all_gpes
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Clear all GPEs in all GPE blocks
+ *
+ ******************************************************************************/
+
+acpi_status acpi_hw_clear_all_gpes(void)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(hw_clear_all_gpes);
+
+	status = acpi_ev_walk_gpe_list(acpi_hw_clear_gpe_block, NULL);
+	return_ACPI_STATUS(status);
+}
+
 /******************************************************************************
  *
  * FUNCTION:    acpi_hw_enable_all_runtime_gpes
Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -1246,6 +1246,7 @@ static void acpi_power_off_prepare(void)
 	/* Prepare to power off the system */
 	acpi_sleep_prepare(ACPI_STATE_S5);
 	acpi_disable_all_gpes();
+	acpi_clear_all_gpes();
 	acpi_os_wait_events_complete();
 }
 
Index: linux-pm/drivers/acpi/acpica/evxfgpe.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/evxfgpe.c
+++ linux-pm/drivers/acpi/acpica/evxfgpe.c
@@ -710,7 +710,7 @@ ACPI_EXPORT_SYMBOL(acpi_finish_gpe)
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Disable and clear all GPEs in all GPE blocks
+ * DESCRIPTION: Disable all GPEs in all GPE blocks
  *
  ******************************************************************************/
 
@@ -735,6 +735,37 @@ ACPI_EXPORT_SYMBOL(acpi_disable_all_gpes
 
 /******************************************************************************
  *
+ * FUNCTION:    acpi_clear_all_gpes
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Clear all GPEs in all GPE blocks
+ *
+ ******************************************************************************/
+
+acpi_status acpi_clear_all_gpes(void)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(acpi_clear_all_gpes);
+
+	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	status = acpi_hw_clear_all_gpes();
+	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
+
+	return_ACPI_STATUS(status);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_clear_all_gpes)
+
+/******************************************************************************
+ *
  * FUNCTION:    acpi_enable_all_runtime_gpes
  *
  * PARAMETERS:  None
Index: linux-pm/include/acpi/acpixf.h
===================================================================
--- linux-pm.orig/include/acpi/acpixf.h
+++ linux-pm/include/acpi/acpixf.h
@@ -755,6 +755,7 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_sta
 						     *event_status))
 ACPI_HW_DEPENDENT_RETURN_VOID(void acpi_dispatch_gpe(acpi_handle gpe_device, u32 gpe_number))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_disable_all_gpes(void))
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_clear_all_gpes(void))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_runtime_gpes(void))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_wakeup_gpes(void))
 
Index: linux-pm/drivers/acpi/acpica/hwsleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/hwsleep.c
+++ linux-pm/drivers/acpi/acpica/hwsleep.c
@@ -51,16 +51,21 @@ acpi_status acpi_hw_legacy_sleep(u8 slee
 		return_ACPI_STATUS(status);
 	}
 
-	/*
-	 * 1) Disable all GPEs
-	 * 2) Enable all wakeup GPEs
-	 */
+	/* Disable all GPEs */
 	status = acpi_hw_disable_all_gpes();
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
+	/* If the target sleep state is S5, clear all GPEs too */
+	if (sleep_state == ACPI_STATE_S5) {
+		status = acpi_hw_clear_all_gpes();
+		if (ACPI_FAILURE(status)) {
+			return_ACPI_STATUS(status);
+		}
+	}
 	acpi_gbl_system_awake_and_running = FALSE;
 
+	 /* Enable all wakeup GPEs */
 	status = acpi_hw_enable_all_wakeup_gpes();
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);

