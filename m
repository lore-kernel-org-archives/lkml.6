Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B794C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6042133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 16:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388180AbfAKQfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 11:35:08 -0500
Received: from mga14.intel.com ([192.55.52.115]:63254 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731688AbfAKQfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 11:35:07 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jan 2019 08:35:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,466,1539673200"; 
   d="scan'208";a="116045836"
Received: from gandrejc-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.144])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jan 2019 08:35:02 -0800
Date:   Fri, 11 Jan 2019 18:35:00 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, david.safford@ge.com, monty.wiseman@ge.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v7 1/5] tpm: dynamically allocate the allocated_banks
 array
Message-ID: <20190111163500.GD12093@linux.intel.com>
References: <20181213102945.30946-1-roberto.sassu@huawei.com>
 <20181213102945.30946-2-roberto.sassu@huawei.com>
 <20181220145500.GA10652@linux.intel.com>
 <0900a894-e17b-edc8-fa30-db7d16665082@huawei.com>
 <20181222000321.GB8954@linux.intel.com>
 <7cc91a22-b09b-8bdc-c225-adff68e1f69e@huawei.com>
 <20190110173845.GG6589@linux.intel.com>
 <32ec194b-811e-fe83-3937-bb82ffad55a7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32ec194b-811e-fe83-3937-bb82ffad55a7@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 08:53:00AM +0100, Roberto Sassu wrote:
> On 1/10/2019 6:38 PM, Jarkko Sakkinen wrote:
> > On Mon, Jan 07, 2019 at 11:06:33AM +0100, Roberto Sassu wrote:
> > > On 12/22/2018 1:03 AM, Jarkko Sakkinen wrote:
> > > > On Fri, Dec 21, 2018 at 10:40:09AM +0100, Roberto Sassu wrote:
> > > > > On 12/20/2018 3:55 PM, Jarkko Sakkinen wrote:
> > > > > > On Thu, Dec 13, 2018 at 11:29:41AM +0100, Roberto Sassu wrote:
> > > > > > > This patch renames active_banks (member of tpm_chip) to allocated_banks,
> > > > > > > stores the number of allocated PCR banks in nr_allocated_banks (new member
> > > > > > > of tpm_chip), and replaces the static array with a pointer to a dynamically
> > > > > > > allocated array.
> > > > > > > 
> > > > > > > tpm2_get_pcr_allocation() determines if a PCR bank is allocated by checking
> > > > > > > the mask in the TPML_PCR_SELECTION structure returned by the TPM for
> > > > > > > TPM2_Get_Capability(). If a bank is not allocated, the TPM returns that
> > > > > > > bank in TPML_PCR_SELECTION, with all bits in the mask set to zero. In this
> > > > > > > case, the bank is not included in chip->allocated_banks, to avoid that TPM
> > > > > > > driver users unnecessarily calculate a digest for that bank.
> > > > > > > 
> > > > > > > One PCR bank with algorithm set to SHA1 is always allocated for TPM 1.x.
> > > > > > > 
> > > > > > > As a consequence of the introduction of nr_allocated_banks,
> > > > > > > tpm_pcr_extend() does not check anymore if the algorithm stored in tpm_chip
> > > > > > > is equal to zero.
> > > > > > > 
> > > > > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > > Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > > > > > ---
> > > > > > >     drivers/char/tpm/tpm-chip.c      |  1 +
> > > > > > >     drivers/char/tpm/tpm-interface.c | 18 +++++++++--------
> > > > > > >     drivers/char/tpm/tpm.h           |  3 ++-
> > > > > > >     drivers/char/tpm/tpm1-cmd.c      | 10 ++++++++++
> > > > > > >     drivers/char/tpm/tpm2-cmd.c      | 34 ++++++++++++++++++++++----------
> > > > > > >     5 files changed, 47 insertions(+), 19 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > > > > > > index 32db84683c40..ce851c62bb68 100644
> > > > > > > --- a/drivers/char/tpm/tpm-chip.c
> > > > > > > +++ b/drivers/char/tpm/tpm-chip.c
> > > > > > > @@ -160,6 +160,7 @@ static void tpm_dev_release(struct device *dev)
> > > > > > >     	kfree(chip->log.bios_event_log);
> > > > > > >     	kfree(chip->work_space.context_buf);
> > > > > > >     	kfree(chip->work_space.session_buf);
> > > > > > > +	kfree(chip->allocated_banks);
> > > > > > >     	kfree(chip);
> > > > > > >     }
> > > > > > > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> > > > > > > index d9439f9abe78..7b80919228be 100644
> > > > > > > --- a/drivers/char/tpm/tpm-interface.c
> > > > > > > +++ b/drivers/char/tpm/tpm-interface.c
> > > > > > > @@ -488,8 +488,7 @@ EXPORT_SYMBOL_GPL(tpm_pcr_read);
> > > > > > >     int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash)
> > > > > > >     {
> > > > > > >     	int rc;
> > > > > > > -	struct tpm2_digest digest_list[ARRAY_SIZE(chip->active_banks)];
> > > > > > > -	u32 count = 0;
> > > > > > > +	struct tpm2_digest *digest_list;
> > > > > > >     	int i;
> > > > > > >     	chip = tpm_find_get_ops(chip);
> > > > > > > @@ -497,16 +496,19 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash)
> > > > > > >     		return -ENODEV;
> > > > > > >     	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> > > > > > > -		memset(digest_list, 0, sizeof(digest_list));
> > > > > > > +		digest_list = kcalloc(chip->nr_allocated_banks,
> > > > > > > +				      sizeof(*digest_list), GFP_KERNEL);
> > > > > > > +		if (!digest_list)
> > > > > > > +			return -ENOMEM;
> > > > > > 
> > > > > > You could preallocate digest list and place it to struct tpm_chip
> > > > > > instead of doing it everytime tpm_pcr_extend() called.
> > > > > 
> > > > > This part will be removed with patch 5/5.
> > > > 
> > > > Even if it did, it does not make this patch unbroken.
> > > 
> > > Can two calls to tpm_pcr_extend() be executed at the same time?
> > > 
> > > If yes, the digest list should be protected by a mutex.
> > 
> > Good question: the answer is no. Mutex locking is done inside the
> > transmit flow ATM.
> 
> But data are copied before the mutex is locked. Can't a second call
> overwrite chip->preallocated_digest_list while the first call is still
> writing it?

Now I see what you mean. I have patch set on review that would make this
more natural to do. Locking can be done now too so that it would work
but that would counter-productive, so lets keep the approach that you
have.

/Jarkko
