Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967044AbeBNKEF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:04:05 -0500
Received: from mga05.intel.com ([192.55.52.43]:31094 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966929AbeBNKEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:04:02 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,511,1511856000";
   d="scan'208";a="204018302"
Date: Wed, 14 Feb 2018 12:03:58 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mario.Limonciello@dell.com
Cc: linux-kernel@vger.kernel.org, andreas.noever@gmail.com,
        michael.jamet@intel.com, yehezkel.bernat@intel.com,
        bhelgaas@google.com, radion.mirchevsky@intel.com
Subject: Re: [PATCH 06/18] thunderbolt: Wait a bit longer for ICM to
 authenticate the active NVM
Message-ID: <20180214100358.GL27191@lahna.fi.intel.com>
References: <20180213170018.9780-1-mika.westerberg@linux.intel.com>
 <20180213170018.9780-7-mika.westerberg@linux.intel.com>
 <a4e11e8dcec643d7bce1d8b1f9fc2c89@ausx13mpc120.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4e11e8dcec643d7bce1d8b1f9fc2c89@ausx13mpc120.AMER.DELL.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 05:21:33PM +0000, Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Mika Westerberg [mailto:mika.westerberg@linux.intel.com]
> > Sent: Tuesday, February 13, 2018 11:00 AM
> > To: linux-kernel@vger.kernel.org
> > Cc: Andreas Noever <andreas.noever@gmail.com>; Michael Jamet
> > <michael.jamet@intel.com>; Yehezkel Bernat <yehezkel.bernat@intel.com>; Bjorn
> > Helgaas <bhelgaas@google.com>; Limonciello, Mario
> > <Mario_Limonciello@Dell.com>; Radion Mirchevsky
> > <radion.mirchevsky@intel.com>; Mika Westerberg
> > <mika.westerberg@linux.intel.com>
> > Subject: [PATCH 06/18] thunderbolt: Wait a bit longer for ICM to authenticate the
> > active NVM
> > 
> > Sometimes during cold boot ICM has not yet authenticated the active NVM
> > image leading to timeout and failing the driver probe. Allow ICM to take
> > some more time and increase the timeout to 3 seconds before we give up.
> > 
> > While there fix icm_firmware_init() to return the real error code
> > without overwriting it with -ENODEV.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/thunderbolt/icm.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
> > index 1183321586c5..611d28e8e5f2 100644
> > --- a/drivers/thunderbolt/icm.c
> > +++ b/drivers/thunderbolt/icm.c
> > @@ -736,14 +736,14 @@ static bool icm_ar_is_supported(struct tb *tb)
> >  static int icm_ar_get_mode(struct tb *tb)
> >  {
> >  	struct tb_nhi *nhi = tb->nhi;
> > -	int retries = 5;
> > +	int retries = 60;
> >  	u32 val;
> > 
> >  	do {
> >  		val = ioread32(nhi->iobase + REG_FW_STS);
> >  		if (val & REG_FW_STS_NVM_AUTH_DONE)
> >  			break;
> > -		msleep(30);
> > +		msleep(50);
> >  	} while (--retries);
> > 
> >  	if (!retries) {
> > @@ -1063,6 +1063,9 @@ static int icm_firmware_init(struct tb *tb)
> >  			break;
> > 
> >  		default:
> > +			if (ret < 0)
> > +				return ret;
> > +
> >  			tb_err(tb, "ICM firmware is in wrong mode: %u\n", ret);
> >  			return -ENODEV;
> >  		}
> > --
> > 2.15.1
> 
> Mika,
> 
> Some of your patches in this series already have the stable tag, but I think 
> especially this one is probably a good candidate to add to @stable.

You are right. I'll add stable tag for v2.
