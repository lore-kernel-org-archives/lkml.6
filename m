Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC10EC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564AF208DC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 21:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 564AF208DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeHWAcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 20:32:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60926 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726581AbeHWAcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 20:32:10 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7ML4dp4058529
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 17:05:40 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m1dx8kb29-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 17:05:40 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Wed, 22 Aug 2018 17:05:39 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 Aug 2018 17:05:35 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7ML5Xvh18481202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Aug 2018 21:05:33 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45C3C2805C;
        Wed, 22 Aug 2018 17:04:03 -0400 (EDT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AC9C28059;
        Wed, 22 Aug 2018 17:04:02 -0400 (EDT)
Received: from oc8043147753.ibm.com (unknown [9.60.75.213])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 22 Aug 2018 17:04:01 -0400 (EDT)
Subject: Re: [PATCH v9 21/22] KVM: s390: CPU model support for AP
 virtualization
To:     David Hildenbrand <david@redhat.com>, pmorel@linux.ibm.com,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-22-git-send-email-akrowiak@linux.vnet.ibm.com>
 <2c2c4859-ed3e-a492-dd59-78529c7768b2@redhat.com>
 <e7e1efe7-a7f5-f9a8-bd85-88759fa8ba2b@linux.ibm.com>
 <b04e7d88-b7d3-b55d-cba8-bec0623e4adc@redhat.com>
 <9f512d55-ef10-e2ae-f34e-e003c929bc3f@linux.ibm.com>
 <befdd6b9-6ca8-96c2-68c7-f52f8367443c@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Wed, 22 Aug 2018 17:05:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <befdd6b9-6ca8-96c2-68c7-f52f8367443c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18082221-0040-0000-0000-000004637921
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009593; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01077367; UDB=6.00555464; IPR=6.00857343;
 MB=3.00022874; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-22 21:05:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082221-0041-0000-0000-0000086A8C05
Message-Id: <abd85777-b7db-ee42-1c7b-7131d3475fe0@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-22_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808220208
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/22/2018 12:57 PM, David Hildenbrand wrote:
>>>> In this case we will have no problem with older guests not having idea
>>>> about APXA.
>>>>
>>>> Would it be a solution?
>>> Any feature the guest sees, should be part of the CPU model. The whole
>>> environment for cpu subfunctions is already in place both in KVM and
>>> QEMU. Only disabling subfunctions in KVM is not implemented yet.
>>>
>>> You can exclude any subfunctions/facilities that are only valid on LPAR
>>> level and cannot be used in some guest either way. (that makes life
>>> sometimes easier)
>>>
>>>
>>> I know that this might sound a little bit complicated, but it really
>>> isn't. Boils down to modifying kvm_s390_cpu_feat_init() and specifying
>>> some features+feature groups in QEMU.
>> OK, we definitively need another patch/patch-set, to handle this.
>> Do you think it can be done in another series since if we always support
>> APXA when we have AP instructions, we already have an indication that
>> APXA exist: the AP facility.
>>
> Please implement the subfunction stuff right away. This will allow to
> handle all future facilities transparently from a kernel POV.

I find your use of the term 'subfunction' confusing here. In the
kvm_s390_cpu_feat_init(void) function, it looks like the
kvm_s390_available_subfunc structure is filled in with bits
returned from CPACF queries of various MSA facilities to indicate
which CPACF functions are supported. APXA is not a subfunction but
a facility that is indicated by a bit returned from the PQAP(QCI)
instruction. If we are to implement this, wouldn't it be done as
a CPU model feature as opposed to a subfunction? Am I
misunderstanding what you are asking for?

>
> Implementing that should be easy - and I don't like gluing features
> together in such a way.
>
> You can always assure that consistent data (e.g. AP + APXA availability)
> is reported from KVM to QEMU.
>
>> Regards,
>> Pierre
>>
>>
>>
>>
>

