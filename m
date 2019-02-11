Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA636C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2EB222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="Tx8E4U1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391221AbfBKPR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:17:28 -0500
Received: from smtp2.infineon.com ([217.10.52.18]:46699 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391098AbfBKPF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:05:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1549897555; x=1581433555;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=yV8Bbok3J6t0HsHnKNBRCm3adtM8CO1UJUDJN+aJGU0=;
  b=Tx8E4U1IMV1qIyjCZ07v0Ij4F83G9XmSqwxiEHn8zK7urm75mqLGglQI
   YRPNLhuHeV+y9wFsCvZFfb/ciyQ91EdCtueildFmmrP4ypaVORuskCfpd
   P7RBcv25t+g0WIV2+m6LsfQjuylT846A4jw1IgKgN6yBASMMRk1cdh7i7
   w=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="5900,7806,9163"; a="100302449"
X-IronPort-AV: E=Sophos;i="5.58,358,1544482800"; 
   d="scan'208";a="100302449"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp2.infineon.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Feb 2019 16:05:53 +0100
Received: from MUCSE708.infineon.com (MUCSE708.infineon.com [172.23.7.82])
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS;
        Mon, 11 Feb 2019 16:05:53 +0100 (CET)
Received: from [10.154.32.30] (172.23.8.247) by MUCSE708.infineon.com
 (172.23.7.82) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1531.3; Mon, 11
 Feb 2019 16:05:52 +0100
Subject: Re: [PATCH v4 1/2] tpm: Unify the send callback behaviour
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.ibm.com>
CC:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        <stable@vger.kernel.org>
References: <20190208180857.12330-1-jarkko.sakkinen@linux.intel.com>
 <20190208180857.12330-2-jarkko.sakkinen@linux.intel.com>
 <4072b2b6-0f95-be50-0772-7e2869c2c24e@linux.ibm.com>
 <20190208190057.GA3439@linux.intel.com>
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
Message-ID: <2849751f-ff26-193e-f15e-4d7d5f8525a7@infineon.com>
Date:   Mon, 11 Feb 2019 16:05:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190208190057.GA3439@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE705.infineon.com (172.23.7.79) To
 MUCSE708.infineon.com (172.23.7.82)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.02.2019 20:00, Jarkko Sakkinen wrote:
> On Fri, Feb 08, 2019 at 01:12:34PM -0500, Stefan Berger wrote:
>> On 2/8/19 1:08 PM, Jarkko Sakkinen wrote:
>>> The send() callback should never return length as it does not in every
>>> driver except tpm_crb in the success case. The reason is that the main
>>> transmit functionality only cares about whether the transmit was
>>> successful or not and ignores the count completely.
>>>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Let me know when you put it into your tree, I'll give it a spin while I am
>> at it. :-)
> 
> Thank you Stefan! I also add your suggested-by to the first commit
> because you pointed out the problem.
> 
> It all looks now legit, but just in case I'll add a check for the return
> value to tpm_try_transmit() and a warning if it is not zero in the
> success case (and after that zeroing of rc).
> 
> That check can be removed when I do v5.3 pull request. That should
> enough window to catch any potential issues and check will ensure that
> kernel won't fail even there was something forgotten.
> 
> Alexander, I'll push this version now to the master and next with the
> additional check described in this commit, but will add your tags
> after you have time to test.

I ran all tests again and everything works now as expected :)

Tested-by: Alexander Steffen <Alexander.Steffen@infineon.com>

Alexander
