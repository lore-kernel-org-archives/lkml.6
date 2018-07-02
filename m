Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58950C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 180B924A79
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 180B924A79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752378AbeGBPje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:39:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41494 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752137AbeGBPjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:39:32 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w62FdIx9075172
        for <linux-kernel@vger.kernel.org>; Mon, 2 Jul 2018 11:39:32 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jykxbfys4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 11:39:32 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Mon, 2 Jul 2018 11:39:30 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Jul 2018 11:39:26 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w62FdOw8328098
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Jul 2018 15:39:24 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1434AE060;
        Mon,  2 Jul 2018 11:39:08 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CED5AE05C;
        Mon,  2 Jul 2018 11:39:08 -0400 (EDT)
Received: from oc8043147753.ibm.com (unknown [9.60.75.218])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  2 Jul 2018 11:39:08 -0400 (EDT)
Subject: Re: [PATCH v6 07/21] s390: vfio-ap: base implementation of VFIO AP
 device driver
To:     Halil Pasic <pasic@linux.ibm.com>,
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
 <1530306683-7270-8-git-send-email-akrowiak@linux.vnet.ibm.com>
 <f4fdea7d-1c4d-bb6e-1dd2-27e441dc9837@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Mon, 2 Jul 2018 11:39:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <f4fdea7d-1c4d-bb6e-1dd2-27e441dc9837@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18070215-0060-0000-0000-00000285AABE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009295; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01055519; UDB=6.00541379; IPR=6.00833441;
 MB=3.00021964; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-02 15:39:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070215-0061-0000-0000-000045A6A79E
Message-Id: <51fada6f-db0b-b884-7bd7-07cddecf3824@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-02_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=900 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807020179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2018 09:53 AM, Halil Pasic wrote:
>
>
> On 06/29/2018 11:11 PM, Tony Krowiak wrote:
>> Introduces a new AP device driver. This device driver
>> is built on the VFIO mediated device framework. The framework
>> provides sysfs interfaces that facilitate passthrough
>> access by guests to devices installed on the linux host.
>>
>> The VFIO AP device driver will serve two purposes:
>>
>> 1. Provide the interfaces to reserve AP devices for exclusive
>>     use by KVM guests. This is accomplished by unbinding the
>>     devices to be reserved for guest usage from the default AP
>>     device driver and binding them to the VFIO AP device driver.
>>
>> 2. Implements the functions, callbacks and sysfs attribute
>>     interfaces required to create one or more VFIO mediated
>>     devices each of which will be used to configure the AP
>>     matrix for a guest and serve as a file descriptor
>>     for facilitating communication between QEMU and the
>>     VFIO AP device driver.
>>
>> When the VFIO AP device driver is initialized:
>>
>> * It registers with the AP bus for control of type 10 (CEX4
>>    and newer) AP queue devices. This limitation was imposed
>>    due to:
>>
>>    1. A lack of access to older systems needed to test the
>>       older AP device models;
>>
>>    2. A desire to keep the code as simple as possible;
>>
>>    3. Some older models are no longer supported by the kernel
>>       and others are getting close to end of service.
>>
>>    The probe and remove callbacks will be provided to support
>>    the binding/unbinding of AP queue devices to/from the VFIO
>>    AP device driver.
>>
>> * Creates a /sys/devices/vfio-ap/matrix device to hold
>>    the APQNs of the AP devices bound to the VFIO
>>    AP device driver and serves as the parent of the
>>    mediated devices created for each guest.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   MAINTAINERS                           |   10 +++
>>   arch/s390/Kconfig                     |   11 +++
>>   drivers/s390/crypto/Makefile          |    4 +
>>   drivers/s390/crypto/vfio_ap_drv.c     |  140 
>> +++++++++++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_private.h |   29 +++++++
>>   include/uapi/linux/vfio.h             |    2 +
>>   samples/bpf/bpf_load.c                |   62 +++++++++++++++
>
> You have probably touched the last one by accident.

I'll have to figure out what happened here.

>
>
> Regards,
> Halil


