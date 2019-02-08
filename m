Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B701C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D768320844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfBHNeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:34:00 -0500
Received: from mga07.intel.com ([134.134.136.100]:33153 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbfBHNeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:34:00 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 05:33:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,347,1544515200"; 
   d="scan'208";a="145235552"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.115])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2019 05:33:55 -0800
Date:   Fri, 8 Feb 2019 15:33:55 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v11 00/16] Remove nested TPM operations
Message-ID: <20190208133355.GA18774@linux.intel.com>
References: <3d6fdcc1-8221-2137-fc82-596377cc2fdc@infineon.com>
 <20190207212912.GD23906@linux.intel.com>
 <0af40351-91d5-d0a7-2965-0a9c6505af79@linux.ibm.com>
 <20190208003314.GB7202@linux.intel.com>
 <1fbd29ad-1005-8450-4c39-00974468183b@linux.ibm.com>
 <20190208111442.GA11755@linux.intel.com>
 <06473b24-7c59-9405-bbe0-8d30b3450391@linux.ibm.com>
 <20190208130227.GA16679@linux.intel.com>
 <da69e24d-ad5c-1e7b-9f02-a435872ad635@linux.ibm.com>
 <20190208131754.GA18133@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208131754.GA18133@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 03:17:54PM +0200, Jarkko Sakkinen wrote:
> On Fri, Feb 08, 2019 at 08:10:32AM -0500, Stefan Berger wrote:
> > On 2/8/19 8:02 AM, Jarkko Sakkinen wrote:
> > > On Fri, Feb 08, 2019 at 07:05:26AM -0500, Stefan Berger wrote:
> > > > See my comment on [PATCH v11 08/16]. It needs to be added in that patch
> > > > since otherwise rc holds a non-zero value on function exit, which is wrong
> > > > at that point.
> > > The snippet in question:
> > > 
> > > rc = chip->ops->send(chip, buf, count);
> > > if (rc < 0) {
> > > 	if (rc != -EPIPE)
> > > 		dev_err(&chip->dev,
> > > 			"%s: tpm_send: error %d\n", __func__, rc);
> > > 	return rc;
> > > }
> > > 
> > > if (chip->flags & TPM_CHIP_FLAG_IRQ)
> > > 	goto out_recv;
> > > 
> > > 'send()' ought to return zero on success case.
> > > 
> > > This is how the snippet was before applying any patches scheduled for
> > > v5.1:
> > > 
> > > rc = chip->ops->send(chip, buf, count);
> > > if (rc < 0) {
> > > 	if (rc != -EPIPE)
> > > 		dev_err(&chip->dev,
> > > 			"%s: tpm_send: error %d\n", __func__, rc);
> > > 	return rc;
> > > }
> > > 
> > > if (chip->flags & TPM_CHIP_FLAG_IRQ)
> > > 	goto out_recv;
> > > 
> > > Does not compute.
> > 
> > tpm_tis_send_main returns 'len' and that's what we have here.
> 
> Before doing any kind of code change, we should at least know what
> has caused this that it has worked before.
> 
> And also which commit caused the regression to happen, because it
> looks like a bug in tpm_tis_core, not in the main TPM driver. It
> would need the fixes tag and cc to stable.

Found the root cause.

len = chip->ops->recv(chip, buf, bufsiz);
if (len < 0) {
	rc = len;
	dev_err(&chip->dev,
		"tpm_transmit: tpm_recv: error %d\n", rc);
	goto out;
} else if (len < TPM_HEADER_SIZE) {
	rc = -EFAULT;
	goto out;
}

if (len != be32_to_cpu(header->length)) {
	rc = -EFAULT;
	goto out;
}

rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
if (rc)
	dev_err(&chip->dev, "tpm2_commit_space: error %d\n", rc);

That unconditional call to commit space masked the bugs in the device
drivers. I'll provide fixes shortly.

/Jarkko
