Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BB1C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 10:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DACB0219DA
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 10:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DACB0219DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbeHLNRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 09:17:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:1991 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727549AbeHLNRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 09:17:39 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2018 03:40:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,228,1531810800"; 
   d="scan'208";a="82705850"
Received: from olbrica-mobl.ger.corp.intel.com (HELO localhost) ([10.252.51.177])
  by orsmga002.jf.intel.com with ESMTP; 12 Aug 2018 03:39:56 -0700
Date:   Sun, 12 Aug 2018 13:39:55 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     flihp@twobit.us, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] tpm: add support for nonblocking operation
Message-ID: <20180812103955.GA4813@linux.intel.com>
References: <153367365951.18015.11320230309813817454.stgit@tstruk-mobl1.jf.intel.com>
 <153367366969.18015.14742040525393494830.stgit@tstruk-mobl1.jf.intel.com>
 <20180810174320.GV4692@linux.intel.com>
 <ad02d89f-31d3-7d9f-4580-daf759c8d837@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad02d89f-31d3-7d9f-4580-daf759c8d837@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 11:21:14AM -0700, Tadeusz Struk wrote:
> On 08/10/2018 10:43 AM, Jarkko Sakkinen wrote:
> >> +static struct workqueue_struct *tpm_dev_wq;
> > A naming contradiction with tpm_common_read() and tpm_common_write(). To
> > sort that up I would suggest adding a commit to the patch set that
> > renames these functions as tpm_dev_common_read() and
> > tpm_dev_common_write() and use the name tpm_common_dev_wq here.
> > 
> 
> Currently we have: tpm_open(), tpm_write(), tpm_release() in tpm-dev.c
> tpmrm_open(), tpmrm_read(), tpmrm_write(), tpmrm_release() in tpmrm-dev.c
> tpm_common_open(), tpm_common_read(), tpm_common_write(), tpm_common_release() in tpm-dev-common.c
> 
> I think that's pretty consistent. Do you want me to rename all of them to tpm_dev_*()?
> I don't see any value in doing this. What about if I just rename: 
> tpm_dev_wq_lock to tpm_common_wq_lock, and tpm_dev_wq to tpm_common_wq?

That is good enough. At least it is consistent.

> >> +static DEFINE_MUTEX(tpm_dev_wq_lock);
> > This is an unacceptable way to do it, Rather add:
> > 
> > int __init  tpm_dev_common_init(void)
> > {
> > 	tpm_dev_common_wq = alloc_workqueue("tpm_dev_wq", WQ_MEM_RECLAIM, 0);
> > 	if (!tpm_dev_common_wq)
> > 		return -ENOMEM;
> > 
> > 	return 0;
> > }
> > 
> > and call this in the driver initialization.
> > 
> That was the way it was implemented in v1 https://patchwork.kernel.org/patch/10442125/
> 
> See: static int __init tpm_dev_common_init(void)
> 
> and the feedback I got from Jason was:
> 
> "I wonder if it is worth creating this when the first file is
> opened.. Lots of systems have TPMs but few use the userspace.."
> 
> so I changed this to allocate the WQ on first open. I think it makes sense,
> but I leave it to you to decide.

Without a question I would go with tpm_common_init() for stability (one
less point of failure in open) and simplicity (no need for a locking
scheme).

> Tadeusz,
> -- 
> Tadeusz

/Jarkko
