Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D940C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA9620B6F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CA9620B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732613AbeHNPdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:33:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47520 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731871AbeHNPdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:33:52 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7ECjSpc089376
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 08:46:50 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kuwybkm2r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 08:46:49 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Tue, 14 Aug 2018 08:46:48 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Aug 2018 08:46:43 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7ECkfnX14483880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Aug 2018 12:46:41 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02C19AE05C;
        Tue, 14 Aug 2018 08:46:31 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2BB2AE062;
        Tue, 14 Aug 2018 08:46:29 -0400 (EDT)
Received: from oc8043147753.ibm.com (unknown [9.85.204.74])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 14 Aug 2018 08:46:29 -0400 (EDT)
Subject: Re: [PATCH v9 05/22] KVM: s390: vsie: simulate VCPU SIE entry/exit
To:     Cornelia Huck <cohuck@redhat.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com,
        pbonzini@redhat.com, alex.williamson@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com, David Hildenbrand <david@redhat.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-6-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180814105003.290cf5f1.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Tue, 14 Aug 2018 08:46:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180814105003.290cf5f1.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18081412-0040-0000-0000-0000045EA476
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009543; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01073384; UDB=6.00553062; IPR=6.00853341;
 MB=3.00022712; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-14 12:46:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081412-0041-0000-0000-00000865ACEC
Message-Id: <1e8e107e-7880-ff38-4724-6bf185a68584@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808140131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2018 04:50 AM, Cornelia Huck wrote:
> On Mon, 13 Aug 2018 17:48:02 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> From: David Hildenbrand <david@redhat.com>
>>
>> VCPU requests and VCPU blocking right now don't take care of the vSIE
>> (as it was not necessary until now). But we want to have VCPU requests
>> that will also be handled before running the vSIE again.
>>
>> So let's simulate a SIE entry when entering the vSIE loop and check
>> for PROG_ flags. The existing infrastructure (e.g. exit_sie()) will then
>> detect that the SIE (in form of the vSIE execution loop) is running and
>> properly kick the vSIE CPU, resulting in it leaving the vSIE loop and
>> therefore the vSIE interception handler, allowing it to handle VCPU
>> requests.
>>
>> E.g. if we want to modify the crycb of the VCPU and make sure that any
>> masks also get applied to the VSIE crycb shadow (which uses masks from the
>> VCPU crycb), we will need a way to hinder the vSIE from running and make
>> sure to process the updated crycb before reentering the vSIE again.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   arch/s390/kvm/kvm-s390.c |    9 ++++++++-
>>   arch/s390/kvm/kvm-s390.h |    1 +
>>   arch/s390/kvm/vsie.c     |   20 ++++++++++++++++++--
>>   3 files changed, 27 insertions(+), 3 deletions(-)
> I think that is the RFC version of David's patch, not the v1? Again,
> not really relevant for reviewing, but I hope that you test the final
> version.

Will do.

>

