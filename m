Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D771C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D552450A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D552450A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753519AbeGBWIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 18:08:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:61499 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752715AbeGBWIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 18:08:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 15:08:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,300,1526367600"; 
   d="scan'208";a="53949883"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga008.jf.intel.com with ESMTP; 02 Jul 2018 15:08:43 -0700
Message-ID: <ca753f719e123d8e3c2306b8d55f3d4a656cbd2f.camel@linux.intel.com>
Subject: Re: [RFC PATCH] ata: ahci: Enable DEVSLP by default on x86 modern
 standby platform
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>
Cc:     rjw@rjwysocki.net, alan.cox@intel.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Mario.Limonciello@dell.com
Date:   Mon, 02 Jul 2018 15:08:43 -0700
In-Reply-To: <5493bfdb-14a9-a55d-f96e-b9c8a29f1d63@redhat.com>
References: <20180702190845.7456-1-srinivas.pandruvada@linux.intel.com>
         <20180702202151.GK533219@devbig577.frc2.facebook.com>
         <5493bfdb-14a9-a55d-f96e-b9c8a29f1d63@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Mon, 2018-07-02 at 23:27 +0200, Hans de Goede wrote:
> Hi,
> 
> On 02-07-18 22:21, Tejun Heo wrote:
> > On Mon, Jul 02, 2018 at 12:08:45PM -0700, Srinivas Pandruvada
> > wrote:
> > > From: Srinivas <srinivas.pandruvada@linux.intel.com>
> > > 
> > > One of the requirement for modern x86 system to enter lowest
> > > power mode
> > > (SLP_S0) is SATA IP block to be off. This is true even during
> > > when
> > > platform is suspended to idle and not only in opportunistic
> > > (runtime)
> > > suspend.
> > > 
> > > Several of these system don't have traditional ACPI S3, so it is
> > > important that they enter SLP_S0 state, to avoid draining battery
> > > even
> > > during suspend even with out of the box Linux installation.
> 
> Question can systems which do have S3 not also enter SLP_S0 state
> during
> normal operation to save power?
S3 systems don't enter SLP_S0. When in suspend via S3 all devices are
simply turn off all except some for wakeup.

> 
> I guess the change of that happening without being in a suspend like
> state
> (screen turned off, etc), is very small because there will always be
> something blocking entering of SLP_S0, so that it is not worth
> bothering looking into SLP_S0 on systems which use S3 for suspend ?
> 
SLP_S0 is suspend like state without big exit latency. To achieve this
state the IP blocks, clocks and voltage rails needs to be in certain
predefined state. If anyone of those constraints not met, the system
will not reach this state. Unlike S3, we need to make sure that devices
reach right suspend state. In S3 we wouldn't have cared much, as
BIOS/ACPI will take action and turn off anyway.
If you achieve SLP_S0, the power will be lower or equal to S3 but will
be immediately able to resume.


> > > SATA IP block doesn't get turned off till SATA is in DEVSLP mode.
> > > Here
> > > user has to either use scsi-host sysfs or tools like powertop to
> > > set
> > > the sata-host link_power_management_policy to min_power.
> > > 
> > > This change sets by default link power management policy to
> > > min_power
> > > for some platforms.  To avoid regressions, the following
> > > conditions
> > > are used:
> > > - The kernel config is already set to use med_power_with_dipm or
> > > deeper
> > > - System is a modern standby system using ACPI low power idle
> > > flag
> > > - The platform is not blacklisted for Suspend to Idle and suspend
> > > to idle is used instead of S3
> > > This combination will make sure that systems are fairly recent
> > > and
> > > since getting shipped with modern standby standby, the DEVSLP
> > > function
> > > is already validated.
> > > 
> > > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.int
> > > el.com>
> > 
> > Seems sane to me.  Hans, what do you think?
> 
> I think this is going in the right direction, but min_power enables
> both DEVSLP and HIPM, AFAIK Windows at least in the past did not
> enable HIPM be default.

Windows and Linux will need to meet the same criteria to reach SLP_S0
state. OS is not deciding whether we meet criteria or not, it is
firmware deciding, and it will look for SATA IP to be in certain
predefined state, before generating this SLP_S0 signal.


> Srinivas can you figure out what Windows does wrt HIPM?

We can see that under Windows the SATA rail voltage is dropped. I don't
know if there is any other method other than DEVSLP configuration. But
I will surely check around.


> We may need a new med_power_with_dipm_and_devslp level if windows
> does
> not enable HIPM by default on these systems. In hind sight we really
> should have separate bools for each, rather then coding this in
> a single level, ah well.
Agree. We can certainly do this for even safer implementation.

Thanks,
Srinivas

> 
> Regards,
> 
> Hans
