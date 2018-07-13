Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D03ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5BC20835
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5BC20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbeGMLDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:03:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34212 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727454AbeGMLDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:03:07 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6DAiL63052463
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 06:48:59 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k6s29v9uw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 06:48:59 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 13 Jul 2018 11:48:56 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 13 Jul 2018 11:48:52 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6DAmo2429425728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Jul 2018 10:48:50 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA97442041;
        Fri, 13 Jul 2018 13:49:11 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BFA542047;
        Fri, 13 Jul 2018 13:49:11 +0100 (BST)
Received: from oc0155643701.ibm.com (unknown [9.152.224.229])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 13 Jul 2018 13:49:11 +0100 (BST)
Subject: Re: [PATCH v6 14/21] s390: vfio-ap: implement mediated device open
 callback
To:     Tony Krowiak <akrowiak@linux.ibm.com>,
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
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-15-git-send-email-akrowiak@linux.vnet.ibm.com>
 <c8dbb517-88e6-6976-f754-64e3597d0e71@linux.ibm.com>
 <9c7ef696-79e5-ef51-be1a-3402a9bb6749@linux.ibm.com>
From:   Halil Pasic <pasic@linux.ibm.com>
Date:   Fri, 13 Jul 2018 12:48:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <9c7ef696-79e5-ef51-be1a-3402a9bb6749@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18071310-0012-0000-0000-00000289CCFB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071310-0013-0000-0000-000020BB798B
Message-Id: <3c9a3de0-4c03-606b-72f1-0afb462844a7@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-13_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807130085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/12/2018 06:03 PM, Tony Krowiak wrote:
>>> +static int vfio_ap_mdev_open(struct mdev_device *mdev)
>>> +{
>>> +    struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>>> +    struct ap_matrix_dev *matrix_dev =
>>> +        to_ap_matrix_dev(mdev_parent_dev(mdev));
>>> +    unsigned long events;
>>> +    int ret;
>>> +
>>> +    if (!try_module_get(THIS_MODULE))
>>> +        return -ENODEV;
>>> +
>>> +    ret = vfio_ap_verify_queues_reserved(matrix_dev, matrix_mdev->name,
>>> +                         &matrix_mdev->matrix);
>>> +    if (ret)
>>> +        goto out_err;
>>> +
>>> +    matrix_mdev->group_notifier.notifier_call = vfio_ap_mdev_group_notifier;
>>> +    events = VFIO_GROUP_NOTIFY_SET_KVM;
>>> +
>>> +    ret = vfio_register_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>>> +                     &events, &matrix_mdev->group_notifier);
>>> +    if (ret)
>>> +        goto out_err;
>>> +
>>> +    ret = kvm_ap_validate_crypto_setup(matrix_mdev->kvm);
>>
>> At this point you assume that your vfio_ap_mdev_group_notifier callback
>> was called with VFIO_GROUP_NOTIFY_SET_KVM and that you do have
>> matrix_mdev->kvm set up properly.
>>
>> Based on how callbacks usually work this seems rather strange. It's
>> probably cleaner to set up he cyrcb (including all the validation
>> that needs to be done immediately before) in the callback
>> (vfio_ap_mdev_group_notifier).
>>
>> If that is not viable I think we need a comment here explaining why is this
>> OK (at least).
> 
> This was originally in the callback and moved out, to the best of my recollection,
> because the validation at that time was done on the CRYCB and if that validation
> failed, there was no way to notify the client (QEMU) that configuration of the
> guest's CRYCB failed from the notification callback. This works - at least as far
> as I can tell from testing - because the registration of the notifier invokes the
> notification callback if KVM has already been set and that appears to be the case.
> You are correct, however; we probably shouldn't bank on that given that
> I don't think we can guarantee that to be the case 100% of the time. Consequently,
> I will move this back into the notification callback and since consistency checking
> is now being done on the mdev devices instead of the CRYCB, we don't need KVM at open
> time.

Sounds good to me. Making the open fail was not a good way to communicate this
error condition to userspace anyway.


Regards,
Halil

