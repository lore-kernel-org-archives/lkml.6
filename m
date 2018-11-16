Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B51EC04EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 01:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B60214F1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 01:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B60214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389129AbeKPLoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 06:44:05 -0500
Received: from mga05.intel.com ([192.55.52.43]:64269 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726978AbeKPLoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 06:44:05 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2018 17:33:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,238,1539673200"; 
   d="scan'208";a="106692100"
Received: from sfhansen-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.254.82])
  by fmsmga004.fm.intel.com with ESMTP; 15 Nov 2018 17:33:42 -0800
Date:   Fri, 16 Nov 2018 03:33:41 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tpm: add support for partial reads
Message-ID: <20181116013341.GA26336@linux.intel.com>
References: <154231454280.17567.455994477207265338.stgit@tstruk-mobl1.jf.intel.com>
 <20181115233158.GA30018@linux.intel.com>
 <825f4c01-efb1-5034-ea90-9ea5ea8f5b45@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <825f4c01-efb1-5034-ea90-9ea5ea8f5b45@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 04:26:33PM -0800, Tadeusz Struk wrote:
> On 11/15/18 3:31 PM, Jarkko Sakkinen wrote:
> > You could drop these memset() calls and also one from
> > tpm_timeout_work(). The call could be done once in the beginning of
> > tpm_common_write() instead of having three different call sites.
> > 
> 
> Don't we want to clean the buffer as the response is read?
> When we will only memset it in write and if one would send
> just one command there will only be one response.
> The data will sit in the buffer until the next command.
> There will be a quite bit time window when the data can leak.

Point taken.

> > Naming becomes a mess and the comment for data_pending variable is
> > incorrect as it is also used for synchronous operation.
> > 
> > Maybe add a prepending commit to rename it as
> > 
> > 	/* Holds the resul of the tpm_transmit() last call. */
> > 	ssize_t transmit_result;
> 
> Agree, will do that.
> 
> > 
> > That is at least clear and obvious on what it contains.
> > 
> > The comment for partial_data is incorrect as the variable does not
> > contain any data.
> 
> Yes, I will change it.
> 
> > 
> > We could use declare:
> > 
> > 	/* Holds the count how much of the response is still unread. */
> > 	size_t response_pending;
> > 
> > Observe another remark from your commit: there is no reaso to ssize_t as
> > the type as the value should never be a negative number.
> 
> Yes, in fact now the priv->data_pending can also be only positive.
> I'll change it and send a new version soon.

Right you're correct. Then it should be simply called as response_size
(and be size_t) as it is then the most precise name for what it
contains.

> Thanks,
> -- 
> Tadeusz

/Jarkko
