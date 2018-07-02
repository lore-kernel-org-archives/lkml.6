Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73267C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2439525169
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2439525169
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752620AbeGBPyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:54:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42966 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752042AbeGBPyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:54:35 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w62FrodZ063236
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 11:54:34 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jypq9rum6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 11:54:34 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Mon, 2 Jul 2018 11:54:34 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Jul 2018 11:54:31 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w62FsThX4915898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Jul 2018 15:54:29 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C2C2AE05F;
        Mon,  2 Jul 2018 11:54:13 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A291AE05C;
        Mon,  2 Jul 2018 11:54:13 -0400 (EDT)
Received: from oc8043147753.ibm.com (unknown [9.60.75.218])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  2 Jul 2018 11:54:13 -0400 (EDT)
Subject: Re: [PATCH v6 05/21] KVM: s390: CPU model support for AP
 virtualization
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-6-git-send-email-akrowiak@linux.vnet.ibm.com>
 <ceb1d797-9bb3-cb6e-c510-657fc61a7f82@de.ibm.com>
 <276b5ae7-7f27-faae-1e5a-0d4c084139e9@linux.ibm.com>
 <20180702174103.5d1ce603.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Mon, 2 Jul 2018 11:54:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180702174103.5d1ce603.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18070215-0040-0000-0000-0000044854BF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009295; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01055523; UDB=6.00541382; IPR=6.00833446;
 MB=3.00021964; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-02 15:54:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070215-0041-0000-0000-0000084E7098
Message-Id: <d1eb3115-cc3c-cc4f-b683-1a660aa0c6c9@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-02_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=837 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807020181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2018 11:41 AM, Cornelia Huck wrote:
> On Mon, 2 Jul 2018 11:37:11 -0400
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
>
>> On 07/02/2018 10:38 AM, Christian Borntraeger wrote:
>>> On 06/29/2018 11:11 PM, Tony Krowiak wrote:
>>>> Introduces a new CPU model feature and two CPU model
>>>> facilities to support AP virtualization for KVM guests.
>>>>
>>>> CPU model feature:
>>>>
>>>> The KVM_S390_VM_CPU_FEAT_AP feature indicates that
>>>> AP instructions are available on the guest. This
>>>> feature will be enabled by the kernel only if the AP
>>>> instructions are installed on the linux host. This feature
>>>> must be specifically turned on for the KVM guest from
>>>> userspace to use the VFIO AP device driver for guest
>>>> access to AP devices.
>>>>
>>>> CPU model facilities:
>>>>
>>>> 1. AP Query Configuration Information (QCI) facility is installed.
>>>>
>>>>      This is indicated by setting facilities bit 12 for
>>>>      the guest. The kernel will not enable this facility
>>>>      for the guest if it is not set on the host. This facility
>>>>      must not be set by userspace if the KVM_S390_VM_CPU_FEAT_AP
>>>>      feature is not installed.
>>>>
>>>>      If this facility is not set for the KVM guest, then only
>>>>      APQNs with an APQI less than 16 will be available to the
>>>>      guest regardless of the guest's matrix configuration. This
>>>>      is a limitation of the AP bus running on the guest.
>>>>
>>>> 2. AP Facilities Test facility (APFT) is installed.
>>>>
>>>>      This is indicated by setting facilities bit 15 for
>>>>      the guest. The kernel will not enable this facility for
>>>>      the guest if it is not set on the host. This facility
>>>>      must not be set by userspace if the KVM_S390_VM_CPU_FEAT_AP
>>>>      feature is not installed.
>>>>
>>>>      If this facility is not set for the KVM guest, then no
>>>>      AP devices will be available to the guest regardless of
>>>>      the guest's matrix configuration. This is a limitation
>>>>      of the AP bus running under the guest.
>>>>
>>>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>> I think it probably should be at the end of the series, other than that its good.
>> If I move this to the end of the series, the very next patch checks the
>>
>> KVM_S390_VM_CPU_FEAT_AP feature?
> Introduce it here, offer it only with the last patch?

I apologize, but I don't know what you mean by this. Are you suggesting 
this patch
should only include the #define for KVM_S390_VM_CPU_FEAT_AP?

>

