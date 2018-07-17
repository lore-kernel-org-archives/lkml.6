Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C937EECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B28F20C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B28F20C10
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbeGQKmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:42:52 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42081 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729655AbeGQKmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:42:52 -0400
Received: from 79.184.255.17.ipv4.supernova.orange.pl (79.184.255.17) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 3eadf67fd58805f5; Tue, 17 Jul 2018 12:10:59 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Andreas Herrmann <aherrmann@suse.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Commit 554c8aa8ecad causing severe performance degression with pcc-cpufreq
Date:   Tue, 17 Jul 2018 12:09:21 +0200
Message-ID: <3724084.DyflrVPzDS@aspire.rjw.lan>
In-Reply-To: <20180717093620.ym6phfmr3rfvsxyo@suselix>
References: <20180717065048.74mmgk4t5utjaa6a@suselix> <20180717092721.onkaf3qsu7te6syi@suselix> <20180717093620.ym6phfmr3rfvsxyo@suselix>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, July 17, 2018 11:36:20 AM CEST Andreas Herrmann wrote:
> On Tue, Jul 17, 2018 at 11:27:21AM +0200, Andreas Herrmann wrote:
> > On Tue, Jul 17, 2018 at 11:23:25AM +0200, Rafael J. Wysocki wrote:
> > > On Tue, Jul 17, 2018 at 11:11 AM, Andreas Herrmann <aherrmann@suse.com> wrote:
> > > > On Tue, Jul 17, 2018 at 11:06:29AM +0200, Rafael J. Wysocki wrote:
> > > >> On Tue, Jul 17, 2018 at 10:50 AM, Andreas Herrmann <aherrmann@suse.com> wrote:
> > > >>
> > > >> [cut]
> > > >>
> > > >> >
> > > >> > On balance before this commit users could use pcc-cpufreq but had
> > > >> > already suboptimal performance (compared to say intel_pstate driver
> > > >> > which can be used changing BIOS options).
> > > >>
> > > >> BTW, I wonder why you need to change the BIOS options for intel_pstate to load.
> > > >
> > > > I think this is because of (in intel_pstate_init()):
> > > >
> > > >         /*
> > > >          * The Intel pstate driver will be ignored if the platform
> > > >          * firmware has its own power management modes.
> > > >          */
> > > >         if (intel_pstate_platform_pwr_mgmt_exists())
> > > >                 return -ENODEV;
> > > >
> > > 
> > > OK, because of the "Proliant" entry, right?
> > > 
> > > So it looks like we have an issue there.  We find the entry and we
> > > look for _PSS.  It is not there, so we assume that the firmware is
> > > expected to control performance, which is not the case.
> 
> FYI, there is another BIOS setting on those systems. It's called
> "Collaborative Power Control" (AFAIK enabled by default).
> 
> Only if this is disabled, firmware is (alone) in control of
> performance. (And of course in this case neither pcc-cpufreq nor
> intel_pstate will be loaded).

OK, the patch is below.

First, I hope that if "Collaborative Power Control" is disabled, it will
simply hide the PCCH object and so intel_pstate will still not load then.

The main question basically is what the OS is expected to do if "Dynamic
Power Savings Mode" is set.  If we are *expected* to use the PCC interface
then, intel_pstate may not work in that case, but I suspect that the PCC
interface allows extra energy to be saved over what is possible without it.

---
 drivers/cpufreq/intel_pstate.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -2391,6 +2391,18 @@ static bool __init intel_pstate_no_acpi_
 	return true;
 }
 
+static bool __init intel_pstate_no_acpi_pcch(void)
+{
+	acpi_status status;
+	acpi_handle handle;
+
+	status = acpi_get_handle(NULL, "\\_SB", &handle);
+	if (ACPI_FAILURE(status))
+		return true;
+
+	return !acpi_has_method(handle, "PCCH");
+}
+
 static bool __init intel_pstate_has_acpi_ppc(void)
 {
 	int i;
@@ -2450,7 +2462,10 @@ static bool __init intel_pstate_platform
 
 	switch (plat_info[idx].data) {
 	case PSS:
-		return intel_pstate_no_acpi_pss();
+		if (!intel_pstate_no_acpi_pss())
+			return false;
+
+		return intel_pstate_no_acpi_pcch();
 	case PPC:
 		return intel_pstate_has_acpi_ppc() && !force_load;
 	}

