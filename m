Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752493AbeDIJM2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 05:12:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39130 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751970AbeDIJMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 05:12:25 -0400
Subject: Re: [PATCH 2/2] crypto: ccree: enable support for hardware keys
To: Herbert Xu <herbert@gondor.apana.org.au>,
        Gilad Ben-Yossef <gilad@benyossef.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <1522049540-10042-1-git-send-email-gilad@benyossef.com>
 <1522049540-10042-3-git-send-email-gilad@benyossef.com>
 <20180330172616.GB28120@gondor.apana.org.au>
 <CAOtvUMd6MMyQBHU4E=5DKXndhZw90=K1V1apD0uRRaMLyp-0Ag@mail.gmail.com>
 <20180403101905.GA4245@gondor.apana.org.au>
From: Harald Freudenberger <freude@linux.vnet.ibm.com>
Date: Mon, 9 Apr 2018 11:12:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180403101905.GA4245@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18040909-0040-0000-0000-0000042C09D6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040909-0041-0000-0000-000026301364
Message-Id: <45fa8c6c-a518-92de-0ad2-f1fbe470282e@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-09_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804090101
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2018 12:19 PM, Herbert Xu wrote:
> On Sat, Mar 31, 2018 at 08:30:46PM +0300, Gilad Ben-Yossef wrote:
>> However, as it uses the exact same mechanism of the regular xts-aes-ccree
>> but takes the key from another source, I've marked it with a test of
>> alg_test_null() on the premise that if the xts-aes-ccree works, so must this.
> Well it appears to be stubbed out as cc_is_hw_key always returns
> false.
>
>>> Are there other crypto drivers doing this?
>> I thought the exact same thing until I ran into a presentation about the s390
>> secure keys implementation. I basically imitated their use (or abuse?)
>> of the Crypto API
>> assuming it is the way to go.
>>
>> Take a look at arch/s390/crypto/paes_s390.c
> It's always nice to discover code that was never reviewed.
>
> The general approach seems sane though.
>
>> Anyway, if this is not the way to go I'd be more than happy to do whatever
>> work is needed to create the right interface.
>>
>> PS. I'd be out of the office and away from email access to the coming week, so
>> kindly excuse any delay in response.
> I think it's fine.  However, I don't really like the idea of everyone
> coming up with their own "paes", i.e., your patch's use of "haes".
> It should be OK to just use paes for everyone, no?
>
> As to your patch specifically, there is one issue where you're
> directly dereferencing the key as a struct.  This is a no-no because
> the key may have come from user-space.  You must treat it as a
> binary blob.  The s390 code seems to do this correctly.
>
> Cheers,
I would be happy to have a generic kernel interface for some kind
of key token as a binary blob. I am also open to use the kernel key
ring for future extensions. But please understand we needed a way
to support our hardware keys and I think the chosen design isn't
so bad.

regards Harald Freudenberger
using the kernel key ring in future extensions.
