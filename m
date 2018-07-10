Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A100C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 339C320877
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 339C320877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751263AbeGJHDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 03:03:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750992AbeGJHDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 03:03:35 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6A73WaC003371
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 03:03:35 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k4mwcdrak-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 03:03:34 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <freude@linux.ibm.com>;
        Tue, 10 Jul 2018 08:03:30 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 10 Jul 2018 08:03:26 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6A73OBS35520704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Jul 2018 07:03:24 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AC214C06A;
        Tue, 10 Jul 2018 10:03:47 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F6E34C040;
        Tue, 10 Jul 2018 10:03:44 +0100 (BST)
Received: from [10.0.2.15] (unknown [9.152.224.35])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 10 Jul 2018 10:03:44 +0100 (BST)
Subject: Re: [PATCH v6 08/21] s390: vfio-ap: register matrix device with VFIO
 mdev framework
To:     pmorel@linux.ibm.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
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
        Tony Krowiak <akrowiak@linux.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1530306683-7270-9-git-send-email-akrowiak@linux.vnet.ibm.com>
 <198dfc60-96a8-5c46-f437-38bce5efcf20@linux.ibm.com>
From:   Harald Freudenberger <freude@linux.ibm.com>
Date:   Tue, 10 Jul 2018 09:03:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <198dfc60-96a8-5c46-f437-38bce5efcf20@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18071007-0020-0000-0000-000002A4D5DE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071007-0021-0000-0000-000020F1135D
Message-Id: <63062d1b-164f-8d7e-76bf-8e9b3ac23366@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-10_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807100081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.07.2018 16:17, Pierre Morel wrote:
> On 29/06/2018 23:11, Tony Krowiak wrote:
>> Registers the matrix device created by the VFIO AP device
>> driver with the VFIO mediated device framework.
>> Registering the matrix device will create the sysfs
>> structures needed to create mediated matrix devices
>> each of which will be used to configure the AP matrix
>> for a guest and connect it to the VFIO AP device driver.
>>
>> Registering the matrix device with the VFIO mediated device
>> framework will create the following sysfs structures:
>>
>> /sys/devices/vfio_ap
>> ... [matrix]
>> ...... [mdev_supported_types]
>> ......... [vfio_ap-passthrough]
>> ............ create
>>
>> To create a mediated device for the AP matrix device, write a UUID
>> to the create file:
>>
>>     uuidgen > create
>>
>> A symbolic link to the mediated device's directory will be created in the
>> devices subdirectory named after the generated $uuid:
>>
>> /sys/devices/vfio_ap
>> ... [matrix]
>> ...... [mdev_supported_types]
>> ......... [vfio_ap-passthrough]
>> ............ [devices]
>> ............... [$uuid]
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   MAINTAINERS                           |    1 +
>>   drivers/s390/crypto/Makefile          |    2 +-
>>   drivers/s390/crypto/vfio_ap_drv.c     |    9 ++
>>   drivers/s390/crypto/vfio_ap_ops.c     |  131 +++++++++++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_private.h |   22 +++++-
>>   5 files changed, 161 insertions(+), 4 deletions(-)
>>   create mode 100644 drivers/s390/crypto/vfio_ap_ops.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 0515dae..3217803 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -12410,6 +12410,7 @@ W:    http://www.ibm.com/developerworks/linux/linux390/
>>   S:    Supported
>>   F:    drivers/s390/crypto/vfio_ap_drv.c
>>   F:    drivers/s390/crypto/vfio_ap_private.h
>> +F:    drivers/s390/crypto/vfio_ap_ops.c
>>
>>   S390 ZFCP DRIVER
>>   M:    Steffen Maier <maier@linux.ibm.com>
>> diff --git a/drivers/s390/crypto/Makefile b/drivers/s390/crypto/Makefile
>> index 48e466e..8d36b05 100644
>> --- a/drivers/s390/crypto/Makefile
>> +++ b/drivers/s390/crypto/Makefile
>> @@ -17,5 +17,5 @@ pkey-objs := pkey_api.o
>>   obj-$(CONFIG_PKEY) += pkey.o
>>
>>   # adjunct processor matrix
>> -vfio_ap-objs := vfio_ap_drv.o
>> +vfio_ap-objs := vfio_ap_drv.o vfio_ap_ops.o
>>   obj-$(CONFIG_VFIO_AP) += vfio_ap.o
>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
>> index 93db312..b6ff7a4 100644
>> --- a/drivers/s390/crypto/vfio_ap_drv.c
>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>> @@ -127,11 +127,20 @@ int __init vfio_ap_init(void)
>>           return ret;
>>       }
>>
>> +    ret = vfio_ap_mdev_register(matrix_dev);
>> +    if (ret) {
>> +        ap_driver_unregister(&vfio_ap_drv);
>> +        vfio_ap_matrix_dev_destroy(matrix_dev);
>> +
>> +        return ret;
>> +    }
>> +
>>       return 0;
>>   }
>>
>>   void __exit vfio_ap_exit(void)
>>   {
>> +    vfio_ap_mdev_unregister(matrix_dev);
>>       ap_driver_unregister(&vfio_ap_drv);
>>       vfio_ap_matrix_dev_destroy(matrix_dev);
>>   }
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> new file mode 100644
>> index 0000000..4e61e33
>> --- /dev/null
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -0,0 +1,131 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Adjunct processor matrix VFIO device driver callbacks.
>> + *
>> + * Copyright IBM Corp. 2018
>> + * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
>> + *
>> + */
>> +#include <linux/string.h>
>> +#include <linux/vfio.h>
>> +#include <linux/device.h>
>> +#include <linux/list.h>
>> +#include <linux/ctype.h>
>> +
>> +#include "vfio_ap_private.h"
>> +
>> +#define VFOP_AP_MDEV_TYPE_HWVIRT "passthrough"
>> +#define VFIO_AP_MDEV_NAME_HWVIRT "VFIO AP Passthrough Device"
>> +
>> +DEFINE_SPINLOCK(mdev_list_lock);
>> +LIST_HEAD(mdev_list);
>> +
>> +static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
>> +{
>> +    struct ap_matrix_dev *matrix_dev =
>> +        to_ap_matrix_dev(mdev_parent_dev(mdev));
>> +    struct ap_matrix_mdev *matrix_mdev;
>> +
>> +    matrix_mdev = kzalloc(sizeof(*matrix_mdev), GFP_KERNEL);
>> +    if (!matrix_mdev)
>> +        return -ENOMEM;
>> +
>> +    matrix_mdev->name = dev_name(mdev_dev(mdev));
>> +    mdev_set_drvdata(mdev, matrix_mdev);
>> +
>> +    if (atomic_dec_if_positive(&matrix_dev->available_instances) < 0) {
>> +        kfree(matrix_mdev);
>> +        return -EPERM;
>> +    }
>> +
>> +    spin_lock_bh(&mdev_list_lock);
>> +    list_add(&matrix_mdev->list, &mdev_list);
>> +    spin_unlock_bh(&mdev_list_lock);
>> +
>> +    return 0;
>> +}
>> +
>> +static int vfio_ap_mdev_remove(struct mdev_device *mdev)
>> +{
>> +    struct ap_matrix_dev *matrix_dev =
>> +        to_ap_matrix_dev(mdev_parent_dev(mdev));
>> +    struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>> +
>> +    spin_lock_bh(&mdev_list_lock);
>> +    list_del(&matrix_mdev->list);
>> +    spin_unlock_bh(&mdev_list_lock);
>> +    kfree(matrix_mdev);
>> +    mdev_set_drvdata(mdev, NULL);
>> +    atomic_inc(&matrix_dev->available_instances);
>> +
>> +    return 0;
>> +}
>> +
>> +static ssize_t name_show(struct kobject *kobj, struct device *dev, char *buf)
>> +{
>> +    return sprintf(buf, "%s\n", VFIO_AP_MDEV_NAME_HWVIRT);
>> +}
>> +
>> +MDEV_TYPE_ATTR_RO(name);
>> +
>> +static ssize_t available_instances_show(struct kobject *kobj,
>> +                    struct device *dev, char *buf)
>> +{
>> +    struct ap_matrix_dev *matrix_dev = to_ap_matrix_dev(dev);
>> +
>> +    return sprintf(buf, "%d\n",
>> +               atomic_read(&matrix_dev->available_instances));
>> +}
>> +
>> +MDEV_TYPE_ATTR_RO(available_instances);
>> +
>> +static ssize_t device_api_show(struct kobject *kobj, struct device *dev,
>> +                   char *buf)
>> +{
>> +    return sprintf(buf, "%s\n", VFIO_DEVICE_API_AP_STRING);
>> +}
>> +
>> +MDEV_TYPE_ATTR_RO(device_api);
>> +
>> +static struct attribute *vfio_ap_mdev_type_attrs[] = {
>> +    &mdev_type_attr_name.attr,
>> +    &mdev_type_attr_device_api.attr,
>> +    &mdev_type_attr_available_instances.attr,
>> +    NULL,
>> +};
>> +
>> +static struct attribute_group vfio_ap_mdev_hwvirt_type_group = {
>> +    .name = VFOP_AP_MDEV_TYPE_HWVIRT,
>> +    .attrs = vfio_ap_mdev_type_attrs,
>> +};
>> +
>> +static struct attribute_group *vfio_ap_mdev_type_groups[] = {
>> +    &vfio_ap_mdev_hwvirt_type_group,
>> +    NULL,
>> +};
>> +
>> +static const struct mdev_parent_ops vfio_ap_matrix_ops = {
>> +    .owner            = THIS_MODULE,
>> +    .supported_type_groups    = vfio_ap_mdev_type_groups,
>> +    .create            = vfio_ap_mdev_create,
>> +    .remove            = vfio_ap_mdev_remove,
>> +};
>> +
>> +int vfio_ap_mdev_register(struct ap_matrix_dev *matrix_dev)
>> +{
>> +    int ret;
>> +
>> +    ret = mdev_register_device(&matrix_dev->device, &vfio_ap_matrix_ops);
>> +    if (ret)
>> +        return ret;
>> +
>> +    atomic_set(&matrix_dev->available_instances,
>> +           AP_MATRIX_MAX_AVAILABLE_INSTANCES);
>> +
>> +    return 0;
>> +}
>> +
>> +void vfio_ap_mdev_unregister(struct ap_matrix_dev *matrix_dev)
>> +{
>> +    mdev_unregister_device(&matrix_dev->device);
>> +}
>> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
>> index 19c0b60..3de1275 100644
>> --- a/drivers/s390/crypto/vfio_ap_private.h
>> +++ b/drivers/s390/crypto/vfio_ap_private.h
>> @@ -10,20 +10,36 @@
>>   #define _VFIO_AP_PRIVATE_H_
>>
>>   #include <linux/types.h>
>> +#include <linux/device.h>
>> +#include <linux/mdev.h>
>>
>>   #include "ap_bus.h"
>>
>>   #define VFIO_AP_MODULE_NAME "vfio_ap"
>>   #define VFIO_AP_DRV_NAME "vfio_ap"
>> +/**
>> + * There must be one mediated matrix device for every guest using AP devices.
>> + * If every APQN is assigned to a guest, then the maximum number of guests with
>> + * a unique APQN assigned would be 255 adapters x 255 domains = 72351 guests.
>> + */
>> +#define AP_MATRIX_MAX_AVAILABLE_INSTANCES 72351
>
> Why isn't it 256 x 256 ?
In zcrypt.h there are defines for these:

#define MAX_ZDEV_CARDIDS_EXT 256
#define MAX_ZDEV_DOMAINS_EXT 256

/* Maximum number of zcrypt devices */
#define MAX_ZDEV_ENTRIES_EXT (MAX_ZDEV_CARDIDS_EXT * MAX_ZDEV_DOMAINS_EXT)
>>   struct ap_matrix_dev {
>>       struct device device;
>> +    atomic_t available_instances;
>> +};
>> +
>> +struct ap_matrix_mdev {
>> +    const char *name;
>> +    struct list_head list;
>>   };
>>
>> -static inline struct ap_matrix_dev
>> -*to_ap_matrix_parent_dev(struct device *dev)
>> +static struct ap_matrix_dev *to_ap_matrix_dev(struct device *dev)
>>   {
>> -    return container_of(dev, struct ap_matrix_dev, device.parent);
>> +    return container_of(dev, struct ap_matrix_dev, device);
>>   }
>>
>> +extern int vfio_ap_mdev_register(struct ap_matrix_dev *matrix_dev);
>> +extern void vfio_ap_mdev_unregister(struct ap_matrix_dev *matrix_dev);
>> +
>>   #endif /* _VFIO_AP_PRIVATE_H_ */
>
>

