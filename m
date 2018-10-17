Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C51ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D502150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D502150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeJQTtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:49:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44502 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727013AbeJQTtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:49:17 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9HBoktC086877
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 07:53:55 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n62npnawv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 07:53:55 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Wed, 17 Oct 2018 05:53:54 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 17 Oct 2018 05:53:47 -0600
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9HBrkhH59900108
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Oct 2018 04:53:46 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5FBC6E053;
        Wed, 17 Oct 2018 11:53:46 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A5546E050;
        Wed, 17 Oct 2018 11:53:40 +0000 (GMT)
Received: from [9.102.2.58] (unknown [9.102.2.58])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 17 Oct 2018 11:53:40 +0000 (GMT)
Subject: Re: Crash on FSL Book3E due to pte_pgprot()? (was Re: [PATCH v3
 12/24] powerpc/mm: use pte helpers in generic code)
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Geoff Levand <geoff@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Kumar Gala <galak@kernel.crashing.org>,
        Li Yang <leoyang.li@nxp.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
References: <cover.1539092111.git.christophe.leroy@c-s.fr>
 <343c844bbc5081d13ee4c9aa27ff3118f607e1cc.1539092112.git.christophe.leroy@c-s.fr>
 <87va61jsma.fsf@concordia.ellerman.id.au>
 <236d72cd-e6d7-61e5-2c80-e4311e41b4f6@c-s.fr>
 <87efcoeudx.fsf@concordia.ellerman.id.au>
 <6ec9cf4b-abd2-8244-4780-4564a7ffb1ad@c-s.fr>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date:   Wed, 17 Oct 2018 17:23:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <6ec9cf4b-abd2-8244-4780-4564a7ffb1ad@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18101711-0036-0000-0000-00000A4BEEEF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009891; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01103952; UDB=6.00571463; IPR=6.00884004;
 MB=3.00023791; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-17 11:53:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101711-0037-0000-0000-00004950FC29
Message-Id: <e3b03750-f76a-0a70-69ff-3767382859c6@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-16_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810170105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/18 4:42 PM, Christophe Leroy wrote:
> 
> 
> On 10/17/2018 10:32 AM, Michael Ellerman wrote:
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>> On 10/17/2018 12:59 AM, Michael Ellerman wrote:
>> ...
>>>> The question is what's the right way to fix it? Should pte_pgprot() not
>>>> be filtering those bits out on book3e?
>>>
>>> I think we should not use pte_pggrot() for that then. What about the
>>> below fix ?
>>
>> Thanks, that almost works.
>>
>> pte_mkprivileged() also needs to not strip _PAGE_BAP_SR.
> 
> Oops, I missed it allthough I knew it. Patch below.
> 
> From: Christophe Leroy <christophe.leroy@c-s.fr>
> Date: Wed, 17 Oct 2018 10:46:24 +0000
> Subject: [PATCH] powerpc/book3e: redefine pte_mkprivileged() and 
> pte_mkuser()
> To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras 
> <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
> Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
> 
> Book3e defines both _PAGE_USER and _PAGE_PRIVILEGED, so the nohash
> default pte_mkprivileged() and pte_mkuser() are not usable.
> 
> This patch redefines them for book3e.
> 
> Fixes: a0da4bc166f2 ("powerpc/mm: Allow platforms to redefine some 
> helpers")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   arch/powerpc/include/asm/nohash/pte-book3e.h | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/nohash/pte-book3e.h 
> b/arch/powerpc/include/asm/nohash/pte-book3e.h
> index 58eef8cb569d..fb4297dff3e2 100644
> --- a/arch/powerpc/include/asm/nohash/pte-book3e.h
> +++ b/arch/powerpc/include/asm/nohash/pte-book3e.h
> @@ -109,5 +109,19 @@
>   #define PAGE_READONLY    __pgprot(_PAGE_BASE | _PAGE_USER)
>   #define PAGE_READONLY_X    __pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
> 
> +static inline pte_t pte_mkprivileged(pte_t pte)
> +{
> +    return __pte((pte_val(pte) & ~_PAGE_USER) | _PAGE_PRIVILEGED);
> +}
> +
> +#define pte_mkprivileged pte_mkprivileged
> +
> +static inline pte_t pte_mkuser(pte_t pte)
> +{
> +    return __pte((pte_val(pte) & ~_PAGE_PRIVILEGED) | _PAGE_USER);
> +}
> +
> +#define pte_mkuser pte_mkuser
> +

I was build testing a similar patch. We would need to put #ifndef 
__ASSEMBLY__ around it.



-aneesh

