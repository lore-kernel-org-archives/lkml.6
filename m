Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98055C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DBE20020
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45DBE20020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754555AbeFUBGG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:06:06 -0400
Received: from mga12.intel.com ([192.55.52.136]:41826 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754423AbeFUBGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:06:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 18:06:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,249,1526367600"; 
   d="scan'208";a="50633560"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga007.jf.intel.com with ESMTP; 20 Jun 2018 18:05:45 -0700
Received: from orsmsx111.amr.corp.intel.com ([169.254.12.50]) by
 ORSMSX105.amr.corp.intel.com ([169.254.2.132]) with mapi id 14.03.0319.002;
 Wed, 20 Jun 2018 18:05:45 -0700
From:   "Dey, Megha" <megha.dey@intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [PATCH V8 1/5] crypto: Multi-buffer encryption infrastructure
 support
Thread-Topic: [PATCH V8 1/5] crypto: Multi-buffer encryption infrastructure
 support
Thread-Index: AQHTiaT71VA7Q5Or9ESQdIw+yX/ir6N6FLYAgFlFdnuAMogJgIABiP2AgABwaXCAAKKQgIAI0PhwgAKZVoCACDnDsIAJDTaAgAVJM2CAAK8wAIAA46lggD7YNoA=
Date:   Thu, 21 Jun 2018 01:05:44 +0000
Message-ID: <C440BA31B54DCD4AAC682D2365C8FEE738CBA3ED@ORSMSX111.amr.corp.intel.com>
References: <20180316145351.GA6231@gondor.apana.org.au>
 <C440BA31B54DCD4AAC682D2365C8FEE738C13267@ORSMSX111.amr.corp.intel.com>
 <20180418110115.v2w3o5yfv4u3gc4r@gondor.apana.org.au>
 <C440BA31B54DCD4AAC682D2365C8FEE738C13DDE@ORSMSX111.amr.corp.intel.com>
 <20180419032525.6csodbz6lrksyudd@gondor.apana.org.au>
 <C440BA31B54DCD4AAC682D2365C8FEE738C270FC@ORSMSX111.amr.corp.intel.com>
 <20180426094445.4jiwondmtbenepo2@gondor.apana.org.au>
 <C440BA31B54DCD4AAC682D2365C8FEE738C4291E@ORSMSX111.amr.corp.intel.com>
 <20180507093511.jscgnk436e3ba4un@gondor.apana.org.au>
 <C440BA31B54DCD4AAC682D2365C8FEE738C60300@ORSMSX111.amr.corp.intel.com>
 <20180511044530.n6ht3mpvg22hqny5@gondor.apana.org.au> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOWZjZTE5MjYtNTY3Mi00MWJlLWFlNDctOTU1Zjg0MmQzMWE1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidFlibzFPaXNPUDlEVGttVENvUEdES2t1S1VGeVBhdTBTZWpuWWtQMlI3Zkw0K3VERzZzeWY3aEI0Ylp3SG1PTCJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Dey, Megha
>Sent: Friday, May 11, 2018 6:22 PM
>To: Herbert Xu <herbert@gondor.apana.org.au>
>Cc: linux-kernel@vger.kernel.org; linux-crypto@vger.kernel.org;
>davem@davemloft.net
>Subject: RE: [PATCH V8 1/5] crypto: Multi-buffer encryption infrastructure
>support
>
>
>
>>-----Original Message-----
>>From: Herbert Xu [mailto:herbert@gondor.apana.org.au]
>>Sent: Thursday, May 10, 2018 9:46 PM
>>To: Dey, Megha <megha.dey@intel.com>
>>Cc: linux-kernel@vger.kernel.org; linux-crypto@vger.kernel.org;
>>davem@davemloft.net
>>Subject: Re: [PATCH V8 1/5] crypto: Multi-buffer encryption
>>infrastructure support
>>
>>On Fri, May 11, 2018 at 01:24:42AM +0000, Dey, Megha wrote:
>>>
>>> Are you suggesting that the SIMD wrapper, will do what is currently
>>> being
>>done by the ' mcryptd_queue_worker ' function (assuming FPU is not
>>disabled) i.e dispatching the job to the inner algorithm?
>>>
>>> I have got rid of the mcryptd layer( have an inner layer, outer SIMD
>>> layer,
>>handled the pointers and completions accordingly), but still facing
>>some issues after removing the per cpu mcryptd_cpu_queue.
>>
>>Why don't you post what you've got and we can work it out together?
>
>Hi Herbert,
>
>Sure, I will post an RFC patch. (crypto: Remove mcryptd).

Hi Herbert,

I had posted an RFC patch about a month back (2018/05/11). Could you please have a look?

[RFC] crypto: Remove mcryptd
>
>>
>>Thanks,
>>--
>>Email: Herbert Xu <herbert@gondor.apana.org.au> Home Page:
>>http://gondor.apana.org.au/~herbert/
>>PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
