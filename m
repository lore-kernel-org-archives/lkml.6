Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749F2C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0DC20855
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 12:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfAVMKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 07:10:34 -0500
Received: from mga11.intel.com ([192.55.52.93]:20141 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728093AbfAVMKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 07:10:34 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2019 04:10:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,506,1539673200"; 
   d="scan'208";a="140281306"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.115])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jan 2019 04:10:32 -0800
Date:   Tue, 22 Jan 2019 14:10:31 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] tpm: ppi: Enable submission of optional command
 parameter for PPI 1.3
Message-ID: <20190122121031.GD7514@linux.intel.com>
References: <20190117174135.2117937-1-stefanb@linux.ibm.com>
 <20190117174135.2117937-6-stefanb@linux.ibm.com>
 <20190122120159.GC7514@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122120159.GC7514@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 02:01:59PM +0200, Jarkko Sakkinen wrote:
> On Thu, Jan 17, 2019 at 12:41:35PM -0500, Stefan Berger wrote:
> > This patch enables a user to specify the additional optional command
> > parameter by writing it into the request file:
> > 
> >    # echo "23 16" > request
> >    # cat request
> >    23 16
> > 
> > For backwards compatibility:
> > 
> > If only 1 parameter is given then we assume this is the operation request
> > number.
> > 
> >    # echo "5" > request
> >    # cat request
> >    5
> > 
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > Tested-by: David Safford <david.safford@ge.com>
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Oops, sorry, this was meant for 4/5, so please ignore that.

The goto statement in tpm_store_ppi_request() is a bit messy as you
jump between branches. Definitely works, but very unreadable.

To get around it, you could change the branching as

if (strcmp(chip->ppi_version, "1.3") == 0 &&
    sscanf(buf, "%llu %llu", &tmp[0].integer.value,
	   &tmp[1].integer.value) == 2) {
	/* ... */
} else if (strcmp(chip->ppi_version, "1.2") == 0) {
	/* ... */
} else {
	/* ... */
}

/Jarkko
