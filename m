Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753508AbeBKPex (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 10:34:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57850 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751077AbeBKPew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 10:34:52 -0500
Subject: Re: [PATCH v4 2/5] powerpc/mm/slice: Enhance for supporting PPC32
To: Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <01e8f783db8f4d4d41df91e0400a8634272b326f.1518226173.git.christophe.leroy@c-s.fr>
 <0ac518636ae1e601ea0732dd69b48dcd0f347285.1518226173.git.christophe.leroy@c-s.fr>
 <20180211235944.14c2be39@roar.ozlabs.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Sun, 11 Feb 2018 21:04:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180211235944.14c2be39@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18021115-0004-0000-0000-000013A522FF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008516; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000251; SDB=6.00988212; UDB=6.00501673; IPR=6.00767566;
 BA=6.00005825; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019492; XFM=3.00000015;
 UTC=2018-02-11 15:34:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021115-0005-0000-0000-0000860A8E06
Message-Id: <ba493b6c-c61a-5097-e896-5ae3f0128b3a@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-11_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802110206
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/11/2018 07:29 PM, Nicholas Piggin wrote:
> On Sat, 10 Feb 2018 13:54:27 +0100 (CET)
> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> 
>> In preparation for the following patch which will fix an issue on
>> the 8xx by re-using the 'slices', this patch enhances the
>> 'slices' implementation to support 32 bits CPUs.
>>
>> On PPC32, the address space is limited to 4Gbytes, hence only the low
>> slices will be used.
>>
>> This patch moves "slices" functions prototypes from page64.h to slice.h
>>
>> The high slices use bitmaps. As bitmap functions are not prepared to
>> handling bitmaps of size 0, the bitmap_xxx() calls are wrapped into
>> slice_bitmap_xxx() functions which will void on PPC32
> 
> On this last point, I think it would be better to put these with the
> existing slice bitmap functions in slice.c and just have a few #ifdefs
> for SLICE_NUM_HIGH == 0.
> 

We went back and forth with that. IMHO, we should avoid as much #ifdef 
as possible across platforms. It helps to understand the platform 
restrictions better as we have less and less access to these platforms. 
The above change indicates that nohash 32 wants to use the slice code 
and they have different restrictions. With that we now know that 
book3s64 and nohash 32 are the two different configs using slice code.

-aneesh
