Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D67C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC3922360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC3922360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731406AbeKNDDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:03:52 -0500
Received: from mga17.intel.com ([192.55.52.151]:54487 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730730AbeKNDDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:03:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 09:04:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,228,1539673200"; 
   d="scan'208";a="90809182"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.77])
  by orsmga006.jf.intel.com with ESMTP; 13 Nov 2018 09:04:44 -0800
Date:   Tue, 13 Nov 2018 19:04:43 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v4 1/6] tpm: dynamically allocate active_banks array
Message-ID: <20181113170443.GD4752@linux.intel.com>
References: <20181106150159.1136-1-roberto.sassu@huawei.com>
 <20181106150159.1136-2-roberto.sassu@huawei.com>
 <20181108134651.GA8922@linux.intel.com>
 <38bdee38-503b-0bac-efba-99f285018934@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38bdee38-503b-0bac-efba-99f285018934@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 02:34:39PM +0100, Roberto Sassu wrote:
> On 11/8/2018 2:46 PM, Jarkko Sakkinen wrote:
> > Orrayn Tue, Nov 06, 2018 at 04:01:54PM +0100, Roberto Sassu wrote:
> > > This patch removes the hard-coded limit of the active_banks array size.
> > > It stores in the tpm_chip structure the number of active PCR banks,
> > > determined in tpm2_get_pcr_allocation(), and replaces the static array
> > > with a pointer to a dynamically allocated array.
> > > 
> > > As a consequence of the introduction of nr_active_banks, tpm_pcr_extend()
> > > does not check anymore if the algorithm stored in tpm_chip is equal to
> > > zero. The active_banks array always contains valid algorithms.
> > > 
> > > Fixes: 1db15344f874 ("tpm: implement TPM 2.0 capability to get active
> > > PCR banks")
> > > 
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > ---
> > >   drivers/char/tpm/tpm-chip.c      |  1 +
> > >   drivers/char/tpm/tpm-interface.c | 19 ++++++++++++-------
> > >   drivers/char/tpm/tpm.h           |  3 ++-
> > >   drivers/char/tpm/tpm2-cmd.c      | 17 ++++++++---------
> > >   4 files changed, 23 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > > index 46caadca916a..2a9e8b744436 100644
> > > --- a/drivers/char/tpm/tpm-chip.c
> > > +++ b/drivers/char/tpm/tpm-chip.c
> > > @@ -160,6 +160,7 @@ static void tpm_dev_release(struct device *dev)
> > >   	kfree(chip->log.bios_event_log);
> > >   	kfree(chip->work_space.context_buf);
> > >   	kfree(chip->work_space.session_buf);
> > > +	kfree(chip->active_banks);
> > >   	kfree(chip);
> > >   }
> > > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> > > index 1a803b0cf980..ba7ca6b3e664 100644
> > > --- a/drivers/char/tpm/tpm-interface.c
> > > +++ b/drivers/char/tpm/tpm-interface.c
> > > @@ -1039,8 +1039,7 @@ static int tpm1_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash,
> > >   int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash)
> > >   {
> > >   	int rc;
> > > -	struct tpm2_digest digest_list[ARRAY_SIZE(chip->active_banks)];
> > > -	u32 count = 0;
> > > +	struct tpm2_digest *digest_list;
> > >   	int i;
> > >   	chip = tpm_find_get_ops(chip);
> > > @@ -1048,16 +1047,22 @@ int tpm_pcr_extend(struct tpm_chip *chip, int pcr_idx, const u8 *hash)
> > >   		return -ENODEV;
> > 
> > Should take digest_list as input. Probably callers could re-use the
> > same digest_list array multiple times?
> > 
> > Move struct tpm_chip to include/linux/tpm.h so that the caller can query
> > nr_active_banks and active_banks and can create the digest array by
> > itself. Lets do this right at once now that this is being restructured.
> 
> I have to move also other structures and #define. Wouldn't be better to
> introduce a new function to pass to the caller active_banks and
> nr_active_banks?

Revisited. I think it is fine how it is for now and we reconsider
later. Only thing I want to remark is that use should use kcalloc()
instead of kalloc_array() + memset().

/Jarkko
