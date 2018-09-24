Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E300C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340202098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 340202098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbeIXVgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:36:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36716 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727770AbeIXVgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:36:39 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8OFV5N5115548
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 11:33:54 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mq2mpg3yr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 11:33:54 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Mon, 24 Sep 2018 09:33:53 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 24 Sep 2018 09:33:50 -0600
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8OFXljm21037272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Sep 2018 08:33:47 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BD28BE056;
        Mon, 24 Sep 2018 09:33:47 -0600 (MDT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B711BE04F;
        Mon, 24 Sep 2018 09:33:44 -0600 (MDT)
Received: from oc8043147753.ibm.com (unknown [9.85.130.123])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 24 Sep 2018 09:33:44 -0600 (MDT)
Subject: Re: [PATCH v10 10/26] KVM: s390: interfaces to clear CRYCB masks
To:     Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc:     Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com,
        pbonzini@redhat.com, alex.williamson@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-11-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180924130153.766eaec7.cohuck@redhat.com>
 <42b23a01-bee1-0c87-3f81-320c40bcb7c9@linux.ibm.com>
 <20180924140120.398a3293.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Mon, 24 Sep 2018 11:33:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180924140120.398a3293.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18092415-0004-0000-0000-00001490D449
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009763; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01093007; UDB=6.00564886; IPR=6.00873045;
 MB=3.00023483; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-24 15:33:53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092415-0005-0000-0000-000088EC5D6C
Message-Id: <9cf3d134-afbb-2f2f-8386-63b1ab5e3d2f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-24_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=727 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809240153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/24/2018 08:01 AM, Cornelia Huck wrote:
> On Mon, 24 Sep 2018 13:50:36 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> On 09/24/2018 01:01 PM, Cornelia Huck wrote:
>>> On Wed, 12 Sep 2018 15:43:00 -0400
>>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>>    
>>>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>>>
>>>> Introduces two new KVM interface to clear the APM, AQM and ADM masks in
>>>> the guest's CRYCB.  The VCPUs are taken out of SIE to ensure the VCPUs do
>>>> not get out of sync.
>>>
>>> Hm, that patch description does not quite match what the patch actually
>>> does...
>>>    
>>
>> You mean it is not obvious where the masks get cleared? Well the APCB is
>> defined to contain exactly the three masks. As far as I can tell the patch
>> description is correct.
> 
> No, I was referring to "two new KVM interface[s]". The patch just
> introduces a new function that clears the masks (well, maybe you can
> call this an "interface"). So
> 
> s/two new KVM interface/a function in KVM/
> 
> and I'd be happy :) (sorry for being too vague)

I'm not quite sure why this is not an interface, but this is not a hill
I'm willing to die on. And, I agree, there are not two of them. I'll
make the change.

> 

