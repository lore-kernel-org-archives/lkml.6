Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753430AbeBER61 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 12:58:27 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:45332 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753398AbeBER6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 12:58:12 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?=
        <ville.syrjala@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] Revert "cpuidle: Make drivers initialize polling state"
Date: Mon, 05 Feb 2018 18:56:31 +0100
Message-ID: <36158666.hf5grRdGNf@aspire.rjw.lan>
In-Reply-To: <20180205140445.GH5453@intel.com>
References: <20180122162747.19103-1-ville.syrjala@linux.intel.com> <CAJZ5v0jKQh-YyjNjCuVqnj_oiPZ+HLLSftd4ECRJ1ZgPiroxSA@mail.gmail.com> <20180205140445.GH5453@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, February 5, 2018 3:04:45 PM CET Ville Syrjälä wrote:
> On Sun, Feb 04, 2018 at 10:18:07AM +0100, Rafael J. Wysocki wrote:
> > On Sun, Feb 4, 2018 at 10:12 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > On Mon, Jan 22, 2018 at 5:27 PM, Ville Syrjala
> > > <ville.syrjala@linux.intel.com> wrote:
> > >> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > >>
> > >> This reverts commit 1b39e3f813b4685c7a30ae964d5529a1b0e3a286.
> > >>
> > >> Makes my P3 machine oops somewhere in cpuidle. I suspect
> > >> CONFIG_ACPI=n may have something to do with this.
> > >
> > > And if you don't do CONFIG_ACPI=n, does it still oops?
> 
> Don't think I actually tried that. I can give it a whirl tonight.
> 
> I think this machine should actually have ACPI, but it inherited
> the .config from a P2 machine that did not. Apparently I was too
> lazy to change .config when I swapped in the "new" machine.

I guess it would work, but never mind.

> > >
> > > Anyway, there are later changes depending on this one, so reverting it
> > > won't work in general.
> > >
> > > Let me look deeper at this.
> > 
> > What's there in /sys/devices/system/cpu/cpuidle/current_driver on your
> > system with the problematic commit reverted?
> 
> # cat /sys/devices/system/cpu/cpuidle/current_driver
> apm_idle

That is the key bit: I overlooked this little fellow.

Does the below (untested here) help?

---
 arch/x86/kernel/apm_32.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-pm/arch/x86/kernel/apm_32.c
===================================================================
--- linux-pm.orig/arch/x86/kernel/apm_32.c
+++ linux-pm/arch/x86/kernel/apm_32.c
@@ -2389,6 +2389,7 @@ static int __init apm_init(void)
 	if (HZ != 100)
 		idle_period = (idle_period * HZ) / 100;
 	if (idle_threshold < 100) {
+		cpuidle_poll_state_init(&apm_idle_driver);
 		if (!cpuidle_register_driver(&apm_idle_driver))
 			if (cpuidle_register_device(&apm_cpuidle_device))
 				cpuidle_unregister_driver(&apm_idle_driver);
