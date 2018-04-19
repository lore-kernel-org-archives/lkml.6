Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752881AbeDSAyT convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 20:54:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:40499 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752326AbeDSAyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 20:54:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,467,1517904000";
   d="scan'208";a="47314905"
From: "Dey, Megha" <megha.dey@intel.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [PATCH V8 1/5] crypto: Multi-buffer encryption infrastructure
 support
Thread-Topic: [PATCH V8 1/5] crypto: Multi-buffer encryption infrastructure
 support
Thread-Index: AQHTiaT71VA7Q5Or9ESQdIw+yX/ir6N6FLYAgFlFdnuAMogJgIABiP2AgABwaXA=
Date: Thu, 19 Apr 2018 00:54:16 +0000
Message-ID: <C440BA31B54DCD4AAC682D2365C8FEE738C13DDE@ORSMSX111.amr.corp.intel.com>
References: <1515542948-24041-1-git-send-email-megha.dey@linux.intel.com>
 <1515542948-24041-2-git-send-email-megha.dey@linux.intel.com>
 <20180118113905.GA19904@gondor.apana.org.au>
 <1516322661.2526.3.camel@megha-Z97X-UD7-TH>
 <20180316145351.GA6231@gondor.apana.org.au>
 <C440BA31B54DCD4AAC682D2365C8FEE738C13267@ORSMSX111.amr.corp.intel.com>
 <20180418110115.v2w3o5yfv4u3gc4r@gondor.apana.org.au>
In-Reply-To: <20180418110115.v2w3o5yfv4u3gc4r@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDg2YTNhMDEtYjJjZi00ODczLTk3MjEtNDUyZTE1YTVkYjE3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6ImRBQWJxU1luaDBmaldZVEZ1MnJsMmJCRlhVaUVGcVZ6UXlBRnZqU0hiTXc9In0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Herbert Xu [mailto:herbert@gondor.apana.org.au]
>Sent: Wednesday, April 18, 2018 4:01 AM
>To: Dey, Megha <megha.dey@intel.com>
>Cc: linux-kernel@vger.kernel.org; linux-crypto@vger.kernel.org;
>davem@davemloft.net
>Subject: Re: [PATCH V8 1/5] crypto: Multi-buffer encryption infrastructure
>support
>
>On Tue, Apr 17, 2018 at 06:40:17PM +0000, Dey, Megha wrote:
>>
>>
>> >-----Original Message-----
>> >From: Herbert Xu [mailto:herbert@gondor.apana.org.au]
>> >Sent: Friday, March 16, 2018 7:54 AM
>> >To: Dey, Megha <megha.dey@intel.com>
>> >Cc: linux-kernel@vger.kernel.org; linux-crypto@vger.kernel.org;
>> >davem@davemloft.net
>> >Subject: Re: [PATCH V8 1/5] crypto: Multi-buffer encryption
>> >infrastructure support
>> >
>> >I have taken a deeper look and I'm even more convinced now that
>> >mcryptd is simply not needed in your current model.
>> >
>> >The only reason you would need mcryptd is if you need to limit the
>> >rate of requests going into the underlying mb algorithm.
>> >
>> >However, it doesn't do that all.  Even though it seems to have a
>> >batch size of 10, but because it immediately reschedules itself after
>> >the batch runs out, it's essentially just dumping all requests at the
>> >underlying algorithm as fast as they're coming in.  The underlying
>> >algorithm doesn't have need throttling anyway because it'll do the work
>when the queue is full synchronously.
>> >
>> >So why not just get rid of mcryptd completely and expose the
>> >underlying algorithm as a proper async skcipher/hash?
>>
>> Hi Herbert,
>>
>> Most part of the cryptd.c and mcryptd.c are similar, except the logic
>> used to flush out partially completed jobs in the case of multibuffer
>algorithms.
>>
>> I think I will try to merge the cryptd and mcryptd adding necessary quirks for
>multibuffer where needed.
>
>I think you didn't quite get my point.  From what I'm seeing you don't need
>either cryptd or mcryptd.  You just need to expose the underlying mb
>algorithm directly.

Hi Herbert,

Yeah I think I misunderstood. I think what you mean is to remove mcryptd.c completely and avoid the extra layer of indirection to call the underlying algorithm, instead call it directly, correct?

So currently we have 3 algorithms registered for every multibuffer algorithm:
name         : __sha1-mb
driver       : mcryptd(__intel_sha1-mb)

name         : sha1
driver       : sha1_mb

name         : __sha1-mb
driver       : __intel_sha1-mb

If we remove mcryptd, then we will have just the 2?

The outer algorithm:sha1-mb, will 
>
>So I'm not sure what we would gain from merging cryptd and mcryptd.
>
>Cheers,
>--
>Email: Herbert Xu <herbert@gondor.apana.org.au> Home Page:
>http://gondor.apana.org.au/~herbert/
>PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
