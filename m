Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10379ECDE4C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDD120840
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDDD120840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbeKIEeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 23:34:24 -0500
Received: from mga05.intel.com ([192.55.52.43]:50651 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbeKIEeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 23:34:24 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2018 10:57:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,480,1534834800"; 
   d="scan'208";a="279494759"
Received: from smartikx-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.254.135])
  by fmsmga006.fm.intel.com with ESMTP; 08 Nov 2018 10:57:30 -0800
Date:   Thu, 8 Nov 2018 20:57:29 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Nayna Jain <nayna@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com,
        Ken Goldman <kgold@linux.vnet.ibm.com>,
        Kenneth Goldman <kgoldman@us.ibm.com>
Subject: Re: [PATCH v4 1/6] tpm: dynamically allocate active_banks array
Message-ID: <20181108185729.GB20608@linux.intel.com>
References: <20181106150159.1136-1-roberto.sassu@huawei.com>
 <20181106150159.1136-2-roberto.sassu@huawei.com>
 <98482eee-6e91-1666-1ce2-cfa94a33efc2@linux.ibm.com>
 <da2ef557-3041-a1ca-47cb-fd7ab92876aa@huawei.com>
 <086944ab-dd56-5522-af26-e9bb545556fd@linux.ibm.com>
 <20181108152124.GE14072@linux.intel.com>
 <1541690993.4502.26.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1541690993.4502.26.camel@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 10:29:53AM -0500, Mimi Zohar wrote:
> On Thu, 2018-11-08 at 17:21 +0200, Jarkko Sakkinen wrote:
> > On Thu, Nov 08, 2018 at 07:20:51PM +0530, Nayna Jain wrote:
> > > Based on a discussion with Ken, the count in the TPML_PCR_SELECTION returns
> > > the number of possible algorithms supported. In the example below, two
> > > possible algorithms - SHA1 and SHA256 - are returned.
> > > 
> > > # /usr/local/bin/tssgetcapability -cap 5
> > > 2 PCR selections
> > >     hash TPM_ALG_SHA1
> > >     TPMS_PCR_SELECTION length 3
> > >     ff ff ff
> > >     hash TPM_ALG_SHA256
> > >     TPMS_PCR_SELECTION length 3
> > >     00 00 00
> > > 
> > > The pcr_select fields - "ff ff ff" and "00 00 00" - are bit masks for the
> > > enabled PCRs. The SHA1 bank is enabled for all PCRs (0-23), while the SHA256
> > > bank is not enabled.
> > > 
> > > The current code works, but it unnecessarily extends some banks. Instead of
> > > basing the number of active banks on the number of algorithms returned, it
> > > should be based on the pcr_select field.
> > > 
> > >    - Mimi & Nayna
> > 
> > I would just allocate array of the size of possible banks and grow
> > nr_active_banks for active algorithms to keep the code simple because
> > we are talking about insignificant amount of wasted space (might be
> > even zero bytes given how kernel allocators works)>
> 
> That's fine.  Remember the memory is just one concern, but the other
> concerns are the performance of calculating the unneeded hash and the
> TPM performance of including it in the PCR extend.

The driver would initialize only as many entries as are active array and
set nr_active_banks accordingly.

/Jarkko
