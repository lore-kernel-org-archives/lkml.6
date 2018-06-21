Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D98C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0791321711
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0791321711
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933580AbeFUQux (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 12:50:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:15233 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933429AbeFUQuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 12:50:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 09:50:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,252,1526367600"; 
   d="scan'208";a="66558617"
Received: from lmrad-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.46])
  by orsmga001.jf.intel.com with ESMTP; 21 Jun 2018 09:50:46 -0700
Date:   Thu, 21 Jun 2018 19:50:47 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        zohar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] tpm: Introduce a kref for the tpm_chip
Message-ID: <20180621165047.GG11859@linux.intel.com>
References: <20180620161948.1464255-1-stefanb@linux.vnet.ibm.com>
 <20180620161948.1464255-2-stefanb@linux.vnet.ibm.com>
 <20180620183854.GC27445@ziepe.ca>
 <0d37dbe0-d0f4-da13-ffa4-4f00d3542390@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d37dbe0-d0f4-da13-ffa4-4f00d3542390@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 03:34:36PM -0400, Stefan Berger wrote:
> On 06/20/2018 02:38 PM, Jason Gunthorpe wrote:
> > On Wed, Jun 20, 2018 at 12:19:43PM -0400, Stefan Berger wrote:
> > > Introduce a kref for the tpm_chip that we initialize when the tpm_chip has
> > > been allocated and release before the tpm_chip is to be freed.
> > > 
> > > Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> > >   drivers/char/tpm/tpm-chip.c | 24 +++++++++++++++++++-----
> > >   drivers/char/tpm/tpm.h      |  1 +
> > >   2 files changed, 20 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > > index 0a62c19937b6..a933676194a4 100644
> > > +++ b/drivers/char/tpm/tpm-chip.c
> > > @@ -119,8 +119,24 @@ struct tpm_chip *tpm_chip_find_get(struct tpm_chip *chip)
> > >   	return res;
> > >   }
> > > +static void tpm_chip_free(struct kref *kref)
> > > +{
> > > +	struct tpm_chip *chip = container_of(kref, struct tpm_chip, kref);
> > > +
> > > +	kfree(chip->log.bios_event_log);
> > > +	kfree(chip->work_space.context_buf);
> > > +	kfree(chip->work_space.session_buf);
> > > +	kfree(chip);
> > > +}
> > > +
> > > +static void tpm_chip_put(struct tpm_chip *chip)
> > > +{
> > > +	if (chip)
> > > +		kref_put(&chip->kref, tpm_chip_free);
> > > +}
> > > +
> > >   /**
> > > - * tpm_dev_release() - free chip memory and the device number
> > > + * tpm_dev_release() - free the device number and release reference to chip
> > >    * @dev: the character device for the TPM chip
> > >    *
> > >    * This is used as the release function for the character device.
> > > @@ -133,10 +149,7 @@ static void tpm_dev_release(struct device *dev)
> > >   	idr_remove(&dev_nums_idr, chip->dev_num);
> > >   	mutex_unlock(&idr_lock);
> > > -	kfree(chip->log.bios_event_log);
> > > -	kfree(chip->work_space.context_buf);
> > > -	kfree(chip->work_space.session_buf);
> > > -	kfree(chip);
> > > +	tpm_chip_put(chip);
> > >   }
> > >   static void tpm_devs_release(struct device *dev)
> > > @@ -195,6 +208,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
> > >   	mutex_init(&chip->tpm_mutex);
> > >   	init_rwsem(&chip->ops_sem);
> > > +	kref_init(&chip->kref);
> > >   	chip->ops = ops;
> > > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > > index 7f2d0f489e9c..098d7dcc04a4 100644
> > > +++ b/drivers/char/tpm/tpm.h
> > > @@ -211,6 +211,7 @@ struct tpm_chip {
> > >   	struct cdev cdev;
> > >   	struct cdev cdevs;
> > > +	struct kref kref;
> > NAK, there is already a kref in struct device, that one must be used.
> 
> Right. Should make it simpler...

I'll review the next version.

/Jarkko
