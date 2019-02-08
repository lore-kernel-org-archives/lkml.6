Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A305AC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7044D2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfBHTRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:17:18 -0500
Received: from mga09.intel.com ([134.134.136.24]:60147 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbfBHTRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 14:17:17 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Feb 2019 11:17:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,348,1544515200"; 
   d="scan'208";a="121021449"
Received: from szilberm-mobl.ger.corp.intel.com (HELO localhost) ([10.249.254.172])
  by fmsmga007.fm.intel.com with ESMTP; 08 Feb 2019 11:17:11 -0800
Date:   Fri, 8 Feb 2019 21:17:10 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] tpm: =?iso-8859-1?Q?Uni?=
 =?iso-8859-1?Q?fy_the_send_callback_behaviour=E4?=
Message-ID: <20190208191710.GA30645@linux.intel.com>
References: <20190208180857.12330-1-jarkko.sakkinen@linux.intel.com>
 <20190208180857.12330-2-jarkko.sakkinen@linux.intel.com>
 <4072b2b6-0f95-be50-0772-7e2869c2c24e@linux.ibm.com>
 <20190208190057.GA3439@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208190057.GA3439@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 09:00:57PM +0200, Jarkko Sakkinen wrote:
> It all looks now legit, but just in case I'll add a check for the return
> value to tpm_try_transmit() and a warning if it is not zero in the
> success case (and after that zeroing of rc).

Now the commits are applied both master and next, and these are
the checks for send():

rc = chip->ops->send(chip, buf, count);
if (rc < 0) {
	if (rc != -EPIPE)
		dev_err(&chip->dev,
			"%s: send(): error %d\n", __func__, rc);
	return rc;
}

/* A sanity check. send() should just return zero on success e.g.
 * not the command length.
 */
if (rc > 0) {
	dev_warn(&chip->dev,
		 "%s: send(): invalid value %d\n", __func__, rc);
	rc = 0;
}

Should be fairly safe play now.

/Jarkko
