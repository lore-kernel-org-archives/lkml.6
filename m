Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611BFC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B10C2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbfBDMHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 07:07:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:52837 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728216AbfBDMHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 07:07:52 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 04:07:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="131378260"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.172])
  by orsmga002.jf.intel.com with ESMTP; 04 Feb 2019 04:07:46 -0800
Date:   Mon, 4 Feb 2019 14:07:46 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, david.safford@ge.com,
        monty.wiseman@ge.com, matthewgarrett@google.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v9 6/6] tpm: pass an array of tpm_extend_digest
 structures to tpm_pcr_extend()
Message-ID: <20190204120746.GG26799@linux.intel.com>
References: <20190201100641.26936-1-roberto.sassu@huawei.com>
 <20190201100641.26936-7-roberto.sassu@huawei.com>
 <1549048506.6993.73.camel@linux.ibm.com>
 <9f8a64d6-d566-1497-1d2b-465440cdfa80@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f8a64d6-d566-1497-1d2b-465440cdfa80@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 10:14:38AM +0100, Roberto Sassu wrote:
> On 2/1/2019 8:15 PM, Mimi Zohar wrote:
> > Hi Roberto,
> > 
> > Sorry for the delayed review.  A few comments inline below, minor
> > suggestions.
> > 
> > > diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> > > index cc12f3449a72..e6b2dcb0846a 100644
> > > --- a/security/integrity/ima/ima.h
> > > +++ b/security/integrity/ima/ima.h
> > > @@ -56,6 +56,7 @@ extern int ima_policy_flag;
> > >   extern int ima_hash_algo;
> > >   extern int ima_appraise;
> > >   extern struct tpm_chip *ima_tpm_chip;
> > > +extern struct tpm_digest *digests;
> > >   /* IMA event related data */
> > >   struct ima_event_data {
> > > diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> > > index 6bb42a9c5e47..296a965b11ef 100644
> > > --- a/security/integrity/ima/ima_init.c
> > > +++ b/security/integrity/ima/ima_init.c
> > > @@ -27,6 +27,7 @@
> > >   /* name for boot aggregate entry */
> > >   static const char boot_aggregate_name[] = "boot_aggregate";
> > >   struct tpm_chip *ima_tpm_chip;
> > > +struct tpm_digest *digests;
> > 
> > "digests" is used in the new ima_init_digests() and in
> > ima_pcr_extend().  It's nice that the initialization routines are
> > grouped together here in ima_init.c, but wouldn't it better to define
> > "digests" in ima_queued.c, where it is currently being used?
> >   "digests" could then be defined as static.
> 
> 'digests' and ima_init_digests() can be moved to ima_queue.c, but I have
> to add the definition of ima_init_digests() to ima.h. Should I do it?
> 
> 
> > >   /* Add the boot aggregate to the IMA measurement list and extend
> > >    * the PCR register.
> > > @@ -104,6 +105,24 @@ void __init ima_load_x509(void)
> > >   }
> > >   #endif
> > > +int __init ima_init_digests(void)
> > > +{
> > > +	int i;
> > > +
> > > +	if (!ima_tpm_chip)
> > > +		return 0;
> > > +
> > > +	digests = kcalloc(ima_tpm_chip->nr_allocated_banks, sizeof(*digests),
> > > +			  GFP_NOFS);
> > > +	if (!digests)
> > > +		return -ENOMEM;
> > > +
> > > +	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++)
> > > +		digests[i].alg_id = ima_tpm_chip->allocated_banks[i].alg_id;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >   int __init ima_init(void)
> > >   {
> > >   	int rc;
> > > @@ -125,6 +144,9 @@ int __init ima_init(void)
> > >   	ima_load_kexec_buffer();
> > > +	rc = ima_init_digests();
> > 
> > Ok. Getting the tpm chip is at the beginning of this function.
> >   Deferring allocating "digests" to here, avoids having to free memory
> > on failure.
> > 
> > ima_load_kexec_buffer() restores prior measurements, but doesn't
> > extend the TPM.  For anyone reading the code, a short comment above
> > ima_load_kexec_buffer() would make sense.
> 
> Ok. Should I resend the last patch again with the fixes you suggested?

Send the full patch set. For me it is easier then to apply the series
rather than cherry-picking patches from random versions of the patch
set.

/Jarkko
