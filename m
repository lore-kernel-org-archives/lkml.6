Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E6FECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 03:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BFD208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 03:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75BFD208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbeGQENz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:13:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:51220 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbeGQENz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:13:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 20:43:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,364,1526367600"; 
   d="scan'208";a="246276268"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.8.16])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jul 2018 20:43:27 -0700
Message-ID: <701525498127eae51cd95f89fa88b53d411a9b71.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] ata: libahci: Correct setting of DEVSLP register
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     AceLan Kao <acelan@gmail.com>
Cc:     tj@kernel.org, hdegoede@redhat.com, rjw@rjwysocki.net,
        alan.cox@intel.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 16 Jul 2018 20:43:27 -0700
In-Reply-To: <CAAtuYK9zXJHhJ8_aRqfqOPJJ9L29patDA9RuUs9r+GJVZMCy=Q@mail.gmail.com>
References: <20180702190154.6864-1-srinivas.pandruvada@linux.intel.com>
         <20180702190154.6864-2-srinivas.pandruvada@linux.intel.com>
         <CAAtuYK9zXJHhJ8_aRqfqOPJJ9L29patDA9RuUs9r+GJVZMCy=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-17 at 11:26 +0800, AceLan Kao wrote:
> Tested-by: AceLan Kao <acelan.kao@canonical.com>

Thanks Kao for the test.

-Srinivas

> 
> The patches help the power consumption a little bit on my test
> system,
> and no obvious issue I can observe. 
> 
> 2018-07-03 3:01 GMT+08:00 Srinivas Pandruvada <srinivas.pandruvada@li
> nux.intel.com>:
> > We have seen that on some platforms, SATA device never show any
> > DEVSLP
> > residency. This prevent power gating of SATA IP, which prevent
> > system
> > to transition to low power mode in systems with SLP_S0 aka modern
> > standby systems. The PHY logic is off only in DEVSLP not in
> > slumber.
> > Reference:
> > https://www.intel.com/content/dam/www/public/us/en/documents/datash
> > eets
> > /332995-skylake-i-o-platform-datasheet-volume-1.pdf
> > Section 28.7.6.1
> > 
> > Here driver is trying to do read-modify-write the devslp register.
> > But
> > not resetting the bits for which this driver will modify values
> > (DITO,
> > MDAT and DETO). So simply reset those bits before updating to new
> > values.
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel
> > .com>
> > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/ata/libahci.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> > index 965842a08743..f6795d261869 100644
> > --- a/drivers/ata/libahci.c
> > +++ b/drivers/ata/libahci.c
> > @@ -2159,6 +2159,8 @@ static void ahci_set_aggressive_devslp(struct
> > ata_port *ap, bool sleep)
> >                 deto = 20;
> >         }
> > 
> > +       /* Make dito, mdat, deto bits to 0s */
> > +       devslp &= ~GENMASK_ULL(24, 2);
> >         devslp |= ((dito << PORT_DEVSLP_DITO_OFFSET) |
> >                    (mdat << PORT_DEVSLP_MDAT_OFFSET) |
> >                    (deto << PORT_DEVSLP_DETO_OFFSET) |
> > -- 
> > 2.17.1
> > 
> 
> 
