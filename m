Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3073C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A5B208E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A5B208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbeHWRCM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 13:02:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41330 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727392AbeHWRCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 13:02:12 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7NDTf74130907
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 09:32:28 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m1vnwbfah-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 09:32:27 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <andrew.donnellan@au1.ibm.com>;
        Thu, 23 Aug 2018 14:32:26 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Aug 2018 14:32:21 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7NDWKof42205358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Aug 2018 13:32:20 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A83F3AE04D;
        Thu, 23 Aug 2018 16:31:57 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53F46AE045;
        Thu, 23 Aug 2018 16:31:57 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Aug 2018 16:31:57 +0100 (BST)
Received: from [9.81.213.45] (unknown [9.81.213.45])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 7659AA020A;
        Thu, 23 Aug 2018 23:32:16 +1000 (AEST)
Subject: Re: [PATCH v2 3/4] powerpc/mm: fix a warning when a cache is common
 to PGD and hugepages
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Russell Currey <ruscur@russell.cc>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Christophe LEROY <christophe.leroy@c-s.fr>,
        Segher Boessenkool <segher@kernel.crashing.org>
References: <2f96bf1a8df1091c642de099ed07c34b5ab9b90a.1534258290.git.christophe.leroy@c-s.fr>
 <4aaca2d27429e6bdadc340fd3b96e7c350c4b2f4.1534258290.git.christophe.leroy@c-s.fr>
 <6dea8d0c-c4ab-49aa-da26-a729c18fa818@linux.ibm.com>
 <006e5f33-b816-7508-faac-da26a860659c@c-s.fr>
 <3e6412ac-c645-908f-a3bb-c9a2a72f4b68@linux.ibm.com>
 <cb121f38-ac89-4971-fd84-5473e7e9ced5@c-s.fr>
 <20180823103625.GR24439@gate.crashing.org>
 <8ada20e9-3bc1-fdaf-d78f-2f5a317e8216@c-s.fr>
 <87a7pdl2jy.fsf@concordia.ellerman.id.au>
From:   Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date:   Thu, 23 Aug 2018 23:32:16 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
In-Reply-To: <87a7pdl2jy.fsf@concordia.ellerman.id.au>
Content-Language: en-AU
X-TM-AS-GCONF: 00
x-cbid: 18082313-0016-0000-0000-000001FABA86
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082313-0017-0000-0000-0000325115F4
Message-Id: <d561e11b-b85e-6f6c-0936-4a93cf309915@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=744 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808230144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/18 21:56, Michael Ellerman wrote:
> Christophe LEROY <christophe.leroy@c-s.fr> writes:
> 
>> Le 23/08/2018 à 12:36, Segher Boessenkool a écrit :
>>> On Thu, Aug 23, 2018 at 11:40:22AM +0200, Christophe LEROY wrote:
>>>> The only small problème I have is that some version of GCC seems to
>>>> complain about big memset() (132k and 256k ones). Is there a way to tell
>>>> GCC we really want to do it ?
>>>
>>> I'm not sure what you mean.  Complain, is that a warning, is that an error?
>>> What does it say?  Do you have some example code to reproduce it?  Etc.
>>
>> I saw the warnings in the checks at
>> https://patchwork.ozlabs.org/patch/957566/
>> Unfortunatly the link is now broken.
> 
> ruscur/ajd any idea what happened to the snowpatch links here?

I think they've disappeared because our log rotation is too fast - I've 
now upped it to 30 days. I guess over time we'll figure out what we need 
in this regard, ideally we'd keep logs indefinitely but they're several 
megs per build.

I've kicked off another build for this series and the links in Patchwork 
should update to point to the new job when it's done (probably in the 
next couple of hours).

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

