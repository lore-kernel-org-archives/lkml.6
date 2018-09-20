Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A896ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5109A2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5109A2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbeITV4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:56:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40190 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726540AbeITV4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:56:33 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8KFqWT9023926
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 11:56:55 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mmcr76g38-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 11:56:55 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Thu, 20 Sep 2018 11:53:27 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Sep 2018 11:53:23 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8KFrLgg29884594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Sep 2018 15:53:21 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8A5E124053;
        Thu, 20 Sep 2018 12:53:32 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48717124052;
        Thu, 20 Sep 2018 12:53:31 -0400 (EDT)
Received: from oc8043147753.ibm.com (unknown [9.85.177.229])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 20 Sep 2018 12:53:31 -0400 (EDT)
Subject: Re: [PATCH v10 04/26] s390: vfio-ap: base implementation of VFIO AP
 device driver
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
        frankja@linux.ibm.com
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-5-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180920173156.70299b6c.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Thu, 20 Sep 2018 11:53:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180920173156.70299b6c.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18092015-2213-0000-0000-000002F22DA8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009740; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01091112; UDB=6.00563740; IPR=6.00871135;
 MB=3.00023411; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-20 15:53:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092015-2214-0000-0000-00005B9ECCA0
Message-Id: <528f4faa-6c0f-ec48-5f8d-aaacc060871f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809200156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/20/2018 11:31 AM, Cornelia Huck wrote:
> On Wed, 12 Sep 2018 15:42:54 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> Introduces a new AP device driver. This device driver
>> is built on the VFIO mediated device framework. The framework
>> provides sysfs interfaces that facilitate passthrough
>> access by guests to devices installed on the linux host.
>>
>> The VFIO AP device driver will serve two purposes:
>>
>> 1. Provide the interfaces to reserve AP devices for exclusive
>>     use by KVM guests. This is accomplished by unbinding the
>>     devices to be reserved for guest usage from the zcrypt
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
>>    1. A desire to keep the code as simple as possible;
>>
>>    2. Some older models are no longer supported by the kernel
>>       and others are getting close to end of service.
>>
>>    The probe and remove callbacks will be provided to support
>>    the binding/unbinding of AP queue devices to/from the VFIO
>>    AP device driver.
>>
>> * Creates a matrix device, /sys/devices/vfio_ap/matrix,
>>    to serve as the parent of the mediated devices created, one
>>    for each guest, and to hold the APQNs of the AP devices bound to
>>    the VFIO AP device driver.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Christian's S-o-b looks a bit odd here; OTOH, it's probably him anyway
> who will queue the patches in the end :)

It went in there when Christian submitted the patch series in my absence 
back in
July while I was on vacation. I wasn't aware it was in the actual commit 
message,
so it never got removed. I'll remove it if a v11 needs to be submitted.

>
>> ---
>>   MAINTAINERS                           |   10 +++
>>   arch/s390/Kconfig                     |   11 +++
>>   drivers/iommu/Kconfig                 |    8 ++
>>   drivers/s390/crypto/Makefile          |    4 +
>>   drivers/s390/crypto/vfio_ap_drv.c     |  134 +++++++++++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_private.h |   34 ++++++++
>>   6 files changed, 201 insertions(+), 0 deletions(-)
>>   create mode 100644 drivers/s390/crypto/vfio_ap_drv.c
>>   create mode 100644 drivers/s390/crypto/vfio_ap_private.h
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>

