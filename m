Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A77C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 07:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0214820684
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 07:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0214820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbeKRR5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 12:57:24 -0500
Received: from mga14.intel.com ([192.55.52.115]:1913 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbeKRR5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 12:57:24 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2018 23:37:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,247,1539673200"; 
   d="scan'208";a="280924804"
Received: from kaczmarx-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.89])
  by fmsmga005.fm.intel.com with ESMTP; 17 Nov 2018 23:37:47 -0800
Date:   Sun, 18 Nov 2018 09:37:44 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 16/17] tpm: take TPM chip power gating out of
 tpm_transmit()
Message-ID: <20181118073744.GE5897@linux.intel.com>
References: <20181116123845.15705-1-jarkko.sakkinen@linux.intel.com>
 <20181116123845.15705-17-jarkko.sakkinen@linux.intel.com>
 <fdfb4ac9-14ed-9a42-c5fb-69d59208875a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdfb4ac9-14ed-9a42-c5fb-69d59208875a@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 12:02:17PM -0500, Stefan Berger wrote:
> On 11/16/18 7:38 AM, Jarkko Sakkinen wrote:
> > Call tpm_chip_start() and tpm_chip_stop() in
> > 
> > * tpm_try_get_ops() and tpm_put_ops()
> > * tpm_chip_register()
> > * tpm2_del_space()
> > 
> > And remove these calls from tpm_transmit(). The core reason for this
> > change is that in tpm_vtpm_proxy a locality change requires a virtual
> > TPM command (a command made up just for that driver).
> > 
> > The consequence of this is that this commit removes the remaining nested
> > calls.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> >   drivers/char/tpm/tpm-chip.c       | 21 ++++++++-------------
> >   drivers/char/tpm/tpm-interface.c  |  4 ----
> >   drivers/char/tpm/tpm.h            |  9 ---------
> >   drivers/char/tpm/tpm2-space.c     |  5 ++++-
> >   drivers/char/tpm/tpm_vtpm_proxy.c |  3 +--
> >   5 files changed, 13 insertions(+), 29 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > index 65f1561eba81..837d44fa0797 100644
> > --- a/drivers/char/tpm/tpm-chip.c
> > +++ b/drivers/char/tpm/tpm-chip.c
> > @@ -41,9 +41,6 @@ static int tpm_request_locality(struct tpm_chip *chip, unsigned int flags)
> >   {
> >   	int rc;
> > 
> > -	if (flags & TPM_TRANSMIT_NESTED)
> > -		return 0;
> > -
> >   	if (!chip->ops->request_locality)
> >   		return 0;
> > 
> > @@ -59,9 +56,6 @@ static void tpm_relinquish_locality(struct tpm_chip *chip, unsigned int flags)
> >   {
> >   	int rc;
> > 
> > -	if (flags & TPM_TRANSMIT_NESTED)
> > -		return;
> > -
> >   	if (!chip->ops->relinquish_locality)
> >   		return;
> > 
> > @@ -74,9 +68,6 @@ static void tpm_relinquish_locality(struct tpm_chip *chip, unsigned int flags)
> > 
> >   static int tpm_cmd_ready(struct tpm_chip *chip, unsigned int flags)
> >   {
> > -	if (flags & TPM_TRANSMIT_NESTED)
> > -		return 0;
> > -
> >   	if (!chip->ops->cmd_ready)
> >   		return 0;
> > 
> > @@ -85,9 +76,6 @@ static int tpm_cmd_ready(struct tpm_chip *chip, unsigned int flags)
> > 
> >   static int tpm_go_idle(struct tpm_chip *chip, unsigned int flags)
> >   {
> > -	if (flags & TPM_TRANSMIT_NESTED)
> > -		return 0;
> > -
> >   	if (!chip->ops->go_idle)
> >   		return 0;
> > 
> > @@ -169,7 +157,9 @@ int tpm_try_get_ops(struct tpm_chip *chip)
> >   		goto out_lock;
> > 
> >   	mutex_lock(&chip->tpm_mutex);
> > -	return 0;
> > +	rc = tpm_chip_start(chip, 0);
> > +	if (rc)
> > +		mutex_unlock(&chip->tpm_mutex);
> 
> This cannot be right to fall through to up_read() etc.

Ouch! It is not and I had a fixup for it that was not applied to the
resulting patch set :-/

/Jarkko
