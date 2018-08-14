Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9CDC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833AA21733
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833AA21733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732104AbeHNM5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:57:51 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44936 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbeHNM5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:57:50 -0400
Received: from 79.184.254.66.ipv4.supernova.orange.pl (79.184.254.66) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 4113d7ce812c33ff; Tue, 14 Aug 2018 12:11:19 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Schmauss, Erik" <erik.schmauss@intel.com>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPICA: Clear status of all events when entering sleep states
Date:   Tue, 14 Aug 2018 12:09:10 +0200
Message-ID: <8122869.gpExdStrds@aspire.rjw.lan>
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53BB67514@ORSMSX110.amr.corp.intel.com>
References: <1764673.ub23GCSM6t@aspire.rjw.lan> <CF6A88132359CE47947DB4C6E1709ED53BB67514@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 13, 2018 7:15:19 PM CEST Schmauss, Erik wrote:
> 
> > -----Original Message-----
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
> > Sent: Sunday, August 12, 2018 3:50 AM
> > To: Linux ACPI <linux-acpi@vger.kernel.org>
> > Cc: Paul Menzel <pmenzel@molgen.mpg.de>; Linux PM <linux-
> > pm@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>; Schmauss, Erik
> > <erik.schmauss@intel.com>
> > Subject: [PATCH] ACPICA: Clear status of all events when entering sleep states
> > 
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Commit fa85015c0d95 (ACPICA: Clear status of all events when entering
> > S5) made the sleep state entry code in ACPICA clear the status of all ACPI events
> > when entering S5 to fix a functional regression reported against commit
> > 18996f2db918 (ACPICA: Events: Stop unconditionally clearing ACPI IRQs during
> > suspend/resume).  However, it is reported now that the regression also affects
> > system states other than S5 on some systems and causes them to wake up from
> > sleep prematurely.
> > 
> > For this reason, make the code in question clear the status of all ACPI events
> > when entering all sleep states (in addition to S5) to avoid the premature
> > wakeups (this may cause some wakeup events to be missed in theory, but the
> > likelihood of that is small and the change here simply restores the previous
> > behavior of the code).
> > 
> > Fixes: 18996f2db918 (ACPICA: Events: Stop unconditionally clearing ACPI IRQs
> > during suspend/resume)
> > Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > Cc: 4.17+ <stable@vger.kernel.org> # 4.17+: fa85015c0d95 ACPICA: Clear
> > status ...
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/acpi/acpica/hwsleep.c |   11 +++--------
> >  1 file changed, 3 insertions(+), 8 deletions(-)
> > 
> > Index: linux-pm/drivers/acpi/acpica/hwsleep.c
> > =================================================================
> > ==
> > --- linux-pm.orig/drivers/acpi/acpica/hwsleep.c
> > +++ linux-pm/drivers/acpi/acpica/hwsleep.c
> > @@ -56,14 +56,9 @@ acpi_status acpi_hw_legacy_sleep(u8 slee
> >  	if (ACPI_FAILURE(status)) {
> >  		return_ACPI_STATUS(status);
> >  	}
> > -	/*
> > -	 * If the target sleep state is S5, clear all GPEs and fixed events too
> > -	 */
> > -	if (sleep_state == ACPI_STATE_S5) {
> > -		status = acpi_hw_clear_acpi_status();
> > -		if (ACPI_FAILURE(status)) {
> > -			return_ACPI_STATUS(status);
> > -		}
> > +	status = acpi_hw_clear_acpi_status();
> > +	if (ACPI_FAILURE(status)) {
> > +		return_ACPI_STATUS(status);
> >  	}
> >  	acpi_gbl_system_awake_and_running = FALSE;
> > 
> 
> I'll backport this for the next ACPICA release

Thanks!

