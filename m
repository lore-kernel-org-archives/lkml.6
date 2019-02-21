Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81473C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575492086A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfBUMuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:50:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53114 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725891AbfBUMug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:50:36 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1LCn2Eg090831
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 07:50:35 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qstwnkuk7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 07:50:34 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 21 Feb 2019 12:50:32 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 21 Feb 2019 12:50:29 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1LCoR4961735038
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 12:50:27 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BC2D4C059;
        Thu, 21 Feb 2019 12:50:27 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2E4D4C050;
        Thu, 21 Feb 2019 12:50:26 +0000 (GMT)
Received: from [9.152.224.140] (unknown [9.152.224.140])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 21 Feb 2019 12:50:26 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v3 7/9] s390: ap: implement PAPQ AQIC interception in
 kernel
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        cohuck@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-8-git-send-email-pmorel@linux.ibm.com>
 <20190220125420.04984405@oc2783563651>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Thu, 21 Feb 2019 13:50:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190220125420.04984405@oc2783563651>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022112-0016-0000-0000-000002592D14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022112-0017-0000-0000-000032B37CFD
Message-Id: <7f50ca6d-c0a5-e252-554b-b62b11629f1f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-21_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=658 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902210095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/2019 12:54, Halil Pasic wrote:
> On Thu, 14 Feb 2019 14:51:07 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> We register the AP PQAP instruction hook during the open
>> of the mediated device. And unregister it on release.
>>
>> In the AP PQAP instruction hook, if we receive a demand to
>> enable IRQs,
>> - we retrieve the vfio_ap_queue based on the APQN we receive
>>    in REG1,
>> - we retrieve the page of the guest address, (NIB), from
>>    register REG2
>> - we the mediated device to use the VFIO pinning infratrsucture
>>    to pin the page of the guest address,
>> - we retrieve the pointer to KVM to register the guest ISC
>>    and retrieve the host ISC
>> - finaly we activate GISA
>>
>> If we receive a demand to disable IRQs,
>> - we deactivate GISA
>> - unregister from the GIB
>> - unping the NIB
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
> 
> [..]
> 
>> +static int handle_pqap(struct kvm_vcpu *vcpu)
>> +{
>> +	uint64_t status;
>> +	uint16_t apqn;
>> +	struct vfio_ap_queue *q;
>> +	struct ap_queue_status qstatus = {};
>> +	struct ap_matrix_mdev *matrix_mdev;
>> +
>> +	/* If we do not use the AIV facility just go to userland */
>> +	if (!(vcpu->arch.sie_block->eca & ECA_AIV))
>> +		return -EOPNOTSUPP;
>> +
>> +	apqn = vcpu->run->s.regs.gprs[0] & 0xffff;
>> +	q = vfio_ap_get_queue(apqn);
>> +	if (!q) {
>> +		qstatus.response_code = AP_RESPONSE_Q_NOT_AVAIL;
>> +		goto out;
>> +	}
>> +
>> +	/* Check if the queue is associated with a guest matrix */
>> +	matrix_mdev = q->matrix;
>> +	if (!matrix_mdev || !matrix_mdev->kvm) {
>> +		qstatus.response_code = AP_RESPONSE_DECONFIGURED;
>> +		goto out;
>> +	}
>> +
>> +	status = vcpu->run->s.regs.gprs[1];
>> +
>> +	/* If IR bit(16) is set we enable the interrupt */
>> +	if ((status >> (63 - 16)) & 0x01) {
>> +		q->isc = status & 0x07;
>> +		q->nib = vcpu->run->s.regs.gprs[2];
> 
> Careful! You may already have q->nib set (may or may not be a 0x07
> scenario). You should unpin the old nib if set interruption controls
> works out, if we get 0x07 response then you unpin the new one.

You are right. We already had this discussion and the corrected patch.
It seems I misunderstood what we wanted to do by sending this patch 
series out.

I will make this right.

regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

