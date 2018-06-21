Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9568AC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355FF21A34
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 355FF21A34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932866AbeFUSk7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 14:40:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:46011 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752650AbeFUSk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 14:40:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 11:40:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,253,1526367600"; 
   d="scan'208";a="66587388"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga001.jf.intel.com with ESMTP; 21 Jun 2018 11:40:55 -0700
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 21 Jun 2018 11:40:55 -0700
Received: from hasmsx106.ger.corp.intel.com (10.184.198.20) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 21 Jun 2018 11:40:54 -0700
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.94]) by
 HASMSX106.ger.corp.intel.com ([169.254.10.121]) with mapi id 14.03.0319.002;
 Thu, 21 Jun 2018 21:40:52 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v6] tpm: separate cmd_ready/go_idle from runtime_pm
Thread-Topic: [PATCH v6] tpm: separate cmd_ready/go_idle from runtime_pm
Thread-Index: AQHT/qWAvuZRuvUvB0qACxkSGWcwoaRmLekAgABIo+CABFFDAIAAV/Sg
Date:   Thu, 21 Jun 2018 18:40:50 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D9516CE@hasmsx108.ger.corp.intel.com>
References: <20180607212040.30989-1-tomas.winkler@intel.com>
 <20180618180406.GA20697@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D94EA09@hasmsx108.ger.corp.intel.com>
 <20180621161958.GA11859@linux.intel.com>
In-Reply-To: <20180621161958.GA11859@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDIyMDcyY2EtMWMyOC00ZTRlLWJhZmMtNzg2M2M2NjhiNTY0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiU0ltYmpxMFwvTUJ2eVdBYzZuTVR2ajVkOEgza3lKTVZZR0tDZURnR0JPNHNYbHo3NGNIeTkrK3ArMnlOQmNiVlUifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.252.9.218]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> On Mon, Jun 18, 2018 at 07:24:39PM +0000, Winkler, Tomas wrote:
> > >
> > > On Fri, Jun 08, 2018 at 12:20:40AM +0300, Tomas Winkler wrote:
> > > > We cannot use go_idle cmd_ready commands via runtime_pm handles
> as
> > > > with the introduction of localities this is no longer an optional
> > > > feature, while runtime pm can be not enabled.
> > > > Though cmd_ready/go_idle provides a power saving, it's also a part
> > > > of
> > > > TPM2 protocol and should be called explicitly.
> > > > This patch exposes cmd_read/go_idle via tpm class ops and removes
> > > > runtime pm support as it is not used by any driver.
> > > >
> > > > A new tpm transmit flag is added TPM_TRANSMIT_NESTED, which
> > > > implies TPM_TRANSMIT_UNLOCKED and TPM_TRANSMIT_RAW. Both
> are
> > > > needed
> > > to resolve
> > > > tpm spaces and locality request recursive calls to tpm_transmit().
> > > >
> > > > New wrappers are added tpm_cmd_ready() and tpm_go_idle() to
> > > streamline
> > > > tpm_try_transmit code.
> > > >
> > > > tpm_crb no longer needs own power saving functions and can drop
> > > > using tpm_pm_suspend/resume.
> > > >
> > > > This patch cannot be really separated from the locality fix.
> > > > Fixes: 888d867df441 (tpm: cmd_ready command can be issued only
> > > > after granting locality)
> > > >
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: 888d867df441 (tpm: cmd_ready command can be issued only
> > > > after granting locality)
> > > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > > ---
> > > > V2-3:resent
> > > > V4: 1. Use tpm_pm_suspend/resume in tpm_crb
> > > >     2. Drop cmd_ready/go_idle around tpm_chip_register, as there is no
> > > >        usage counter like in runtime_pm.
> > > > V5: 1. add tpm_cmd_ready and tpm_go_idle wrappers.
> > > >     2. Abuse TPM_TRANSMIT_UNLOCKED flag to resolve tpm space
> > > >        recursion.
> > > > V6: 1. Add new flags TPM_TRANSMIT_NESTED which implies
> > > >        TPM_TRANSMIT_UNLOCKED and TPM_TRANSMIT_RAW, as not all
> > > >        unlocked flows are recursive i.e. tpm2_unseal_trusted.
> > > >
> > > >  drivers/char/tpm/tpm-interface.c  |  51 +++++++++++++++----
> > > >  drivers/char/tpm/tpm.h            |  13 ++++-
> > > >  drivers/char/tpm/tpm2-space.c     |  12 ++---
> > > >  drivers/char/tpm/tpm_crb.c        | 101 ++++++++++----------------------------
> > > >  drivers/char/tpm/tpm_vtpm_proxy.c |   2 +-
> > > >  include/linux/tpm.h               |   2 +
> > > >  6 files changed, 88 insertions(+), 93 deletions(-)
> > > >
> > > > diff --git a/drivers/char/tpm/tpm-interface.c
> > > > b/drivers/char/tpm/tpm-interface.c
> > > > index e32f6e85dc6d..1abd8261651b 100644
> > > > --- a/drivers/char/tpm/tpm-interface.c
> > > > +++ b/drivers/char/tpm/tpm-interface.c
> > > > @@ -29,7 +29,6 @@
> > > >  #include <linux/mutex.h>
> > > >  #include <linux/spinlock.h>
> > > >  #include <linux/freezer.h>
> > > > -#include <linux/pm_runtime.h>
> > > >  #include <linux/tpm_eventlog.h>
> > > >
> > > >  #include "tpm.h"
> > > > @@ -369,10 +368,13 @@ static int tpm_validate_command(struct
> > > tpm_chip *chip,
> > > >  	return -EINVAL;
> > > >  }
> > > >
> > > > -static int tpm_request_locality(struct tpm_chip *chip)
> > > > +static int tpm_request_locality(struct tpm_chip *chip, unsigned
> > > > +int
> > > > +flags)
> > > >  {
> > > >  	int rc;
> > > >
> > > > +	if (flags & __TPM_TRANSMIT_RAW)
> > > > +		return 0;
> > > > +
> > > >  	if (!chip->ops->request_locality)
> > > >  		return 0;
> > > >
> > > > @@ -385,10 +387,13 @@ static int tpm_request_locality(struct
> > > > tpm_chip
> > > *chip)
> > > >  	return 0;
> > > >  }
> > > >
> > > > -static void tpm_relinquish_locality(struct tpm_chip *chip)
> > > > +static void tpm_relinquish_locality(struct tpm_chip *chip,
> > > > +unsigned int flags)
> > > >  {
> > > >  	int rc;
> > > >
> > > > +	if (flags & __TPM_TRANSMIT_RAW)
> > > > +		return;
> > > > +
> > > >  	if (!chip->ops->relinquish_locality)
> > > >  		return;
> > > >
> > > > @@ -399,6 +404,28 @@ static void tpm_relinquish_locality(struct
> > > tpm_chip *chip)
> > > >  	chip->locality = -1;
> > > >  }
> > > >
> > > > +static int tpm_cmd_ready(struct tpm_chip *chip, unsigned int flags) {
> > > > +	if (flags & __TPM_TRANSMIT_RAW)
> > > > +		return 0;
> > > > +
> > > > +	if (!chip->ops->cmd_ready)
> > > > +		return 0;
> > > > +
> > > > +	return chip->ops->cmd_ready(chip); }
> > > > +
> > > > +static int tpm_go_idle(struct tpm_chip *chip, unsigned int flags) {
> > > > +	if (flags & __TPM_TRANSMIT_RAW)
> > > > +		return 0;
> > > > +
> > > > +	if (!chip->ops->go_idle)
> > > > +		return 0;
> > > > +
> > > > +	return chip->ops->go_idle(chip); }
> > > > +
> > > >  static ssize_t tpm_try_transmit(struct tpm_chip *chip,
> > > >  				struct tpm_space *space,
> > > >  				u8 *buf, size_t bufsiz,
> > > > @@ -449,14 +476,15 @@ static ssize_t tpm_try_transmit(struct
> > > > tpm_chip
> > > *chip,
> > > >  	/* Store the decision as chip->locality will be changed. */
> > > >  	need_locality = chip->locality == -1;
> > > >
> > > > -	if (!(flags & TPM_TRANSMIT_RAW) && need_locality) {
> > > > -		rc = tpm_request_locality(chip);
> > > > +	if (need_locality) {
> > > > +		rc = tpm_request_locality(chip, flags);
> > > >  		if (rc < 0)
> > > >  			goto out_no_locality;
> > > >  	}
> > > >
> > > > -	if (chip->dev.parent)
> > > > -		pm_runtime_get_sync(chip->dev.parent);
> > > > +	rc = tpm_cmd_ready(chip, flags);
> > > > +	if (rc)
> > > > +		goto out;
> > > >
> > > >  	rc = tpm2_prepare_space(chip, space, ordinal, buf);
> > > >  	if (rc)
> > > > @@ -516,13 +544,16 @@ static ssize_t tpm_try_transmit(struct
> > > > tpm_chip
> > > *chip,
> > > >  	}
> > > >
> > > >  	rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
> > > > +	if (rc)
> > > > +		dev_err(&chip->dev, "tpm2_commit_space: error %d\n", rc);
> > > >
> > > >  out:
> > > > -	if (chip->dev.parent)
> > > > -		pm_runtime_put_sync(chip->dev.parent);
> > > > +	rc = tpm_go_idle(chip, flags);
> > > > +	if (rc)
> > > > +		goto out;
> > > >
> > > >  	if (need_locality)
> > > > -		tpm_relinquish_locality(chip);
> > > > +		tpm_relinquish_locality(chip, flags);
> > > >
> > > >  out_no_locality:
> > > >  	if (chip->ops->clk_enable != NULL) diff --git
> > > > a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h index
> > > > 4426649e431c..beb0a763016c 100644
> > > > --- a/drivers/char/tpm/tpm.h
> > > > +++ b/drivers/char/tpm/tpm.h
> > > > @@ -511,9 +511,18 @@ extern const struct file_operations tpm_fops;
> > > > extern const struct file_operations tpmrm_fops;  extern struct idr
> > > > dev_nums_idr;
> > > >
> > > > +/**
> > > > + * enum tpm_transmit_flags
> > > > + *
> > > > + * @TPM_TRANSMIT_UNLOCKED: used to lock sequence of
> tpm_transmit
> > > calls.
> > > > + * @__TPM_TRANSMIT_RAW: prevent recursive calls into setup steps
> > > > + *                    (go idle, locality,..). Don't use directly.
> > > > + * @TPM_TRANSMIT_NESTED: Use from nested tpm_transmit calls  */
> > > >  enum tpm_transmit_flags {
> > > > -	TPM_TRANSMIT_UNLOCKED	= BIT(0),
> > > > -	TPM_TRANSMIT_RAW	= BIT(1),
> > > > +	TPM_TRANSMIT_UNLOCKED   = BIT(0),
> > > > +	__TPM_TRANSMIT_RAW      = BIT(1),
> > >
> > > NAK for the naming convention.
> >
> > What do you suggest
> > Tomas
> 
> Just keeping the same name.
I just wanted to make sure that 'RAW' not used in the api directly, it will break the flow, do have any suggestion to make it obvious.

Thanks
Tomas


