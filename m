Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615E2C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C3A20825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C3A20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbeKEVVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:21:15 -0500
Received: from mga05.intel.com ([192.55.52.43]:65046 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727814AbeKEVVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:21:15 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 04:01:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,467,1534834800"; 
   d="scan'208";a="97719248"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.180])
  by orsmga003.jf.intel.com with ESMTP; 05 Nov 2018 04:01:48 -0800
Date:   Mon, 5 Nov 2018 14:01:47 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH v3 4/5] tpm: retrieve digest size of unknown algorithms
 with PCR read
Message-ID: <20181105120147.GA7621@linux.intel.com>
References: <20181030154711.2782-1-roberto.sassu@huawei.com>
 <20181030154711.2782-5-roberto.sassu@huawei.com>
 <1541088173.4035.26.camel@linux.ibm.com>
 <3034c896-788b-50f9-23cb-f4b2cd6363e6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3034c896-788b-50f9-23cb-f4b2cd6363e6@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 10:47:19AM +0100, Roberto Sassu wrote:
> > Commit 1db15344f874 ("tpm: implement TPM 2.0 capability to get active
> > PCR banks") defined active_banks[7].  Subsequently, commit
> > 4d23cc323cdb ("tpm: add securityfs support for TPM 2.0 firmware event
> > log") defined TPM2_PCR_ACTIVE_BANKS as 3.  I'm not sure which is the
> > correct value, but the number of active_banks should not be hard coded
> > here.
> 
> Jarkko, should I change the value of TPM2_PCR_ACTIVE_BANKS, or set the
> size of the active_banks array to TPM2_PCR_ACTIVE_BANKS?

Hi, sorry I missed your patch set. Please add me either to 'To' or 'Cc'
field of the email if you want a quick response.

I think the implementation is flakky in both places and should be fixed
before doing any other changes. Thanks James for pointing out these
commits.

What you need to do is to create a prequel commit that reads the number
of banks to a variable e.g.

  unsigned int nr_active_banks;

and allocate 'active_banks' dynamically and change the places that
James pointed out. I guess it is OK to have a commit with two 'Fixes'
tags.

/Jarkko
