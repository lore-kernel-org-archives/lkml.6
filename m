Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752991AbeEPM6a (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 08:58:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38420 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752601AbeEPM61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 08:58:27 -0400
Subject: Re: [PATCH v5 05/13] s390: vfio-ap: register matrix device with VFIO
 mdev framework
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
        berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-6-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180516124240.42dcd426.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Wed, 16 May 2018 08:58:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180516124240.42dcd426.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18051612-0024-0000-0000-0000186BCDE0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009034; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01033132; UDB=6.00528232; IPR=6.00812263;
 MB=3.00021145; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-16 12:58:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051612-0025-0000-0000-000050023237
Message-Id: <33882a07-fe32-14c6-dfa0-c73d9bb8f796@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805160132
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/16/2018 06:42 AM, Cornelia Huck wrote:
> On Mon,  7 May 2018 11:11:44 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
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
>> 	uuidgen > create
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
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
>>   MAINTAINERS                           |    1 +
>>   drivers/s390/crypto/Makefile          |    2 +-
>>   drivers/s390/crypto/vfio_ap_drv.c     |    9 +++
>>   drivers/s390/crypto/vfio_ap_ops.c     |  106 +++++++++++++++++++++++++++++++++
>>   drivers/s390/crypto/vfio_ap_private.h |   17 +++++
>>   5 files changed, 134 insertions(+), 1 deletions(-)
>>   create mode 100644 drivers/s390/crypto/vfio_ap_ops.c
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> new file mode 100644
>> index 0000000..d7d36fb
>> --- /dev/null
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -0,0 +1,106 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Adjunct processor matrix VFIO device driver callbacks.
>> + *
>> + * Copyright IBM Corp. 2017
> Should be '2018' (also in some other files in this series; please
> double check.)
>
>> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
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
>> +static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
>> +{
>> +	struct ap_matrix *ap_matrix = to_ap_matrix(mdev_parent_dev(mdev));
>> +
>> +	ap_matrix->available_instances--;
> Shouldn't the code check whether available_instances is actually > 0?

Disregard my last response to this, I'm an idiot; it is the return of a
negative number from this function that causes the create to fail.

>
>> +
>> +	return 0;
>> +}
>> +
>> +static int vfio_ap_mdev_remove(struct mdev_device *mdev)
>> +{
>> +	struct ap_matrix *ap_matrix = to_ap_matrix(mdev_parent_dev(mdev));
>> +
>> +	ap_matrix->available_instances++;
>> +
>> +	return 0;
>> +}
>> +
>> +static ssize_t name_show(struct kobject *kobj, struct device *dev, char *buf)
>> +{
>> +	return sprintf(buf, "%s\n", VFIO_AP_MDEV_NAME_HWVIRT);
>> +}
>> +
>> +MDEV_TYPE_ATTR_RO(name);
>> +
>> +static ssize_t available_instances_show(struct kobject *kobj,
>> +					struct device *dev, char *buf)
>> +{
>> +	struct ap_matrix *ap_matrix;
>> +
>> +	ap_matrix = to_ap_matrix(dev);
> Move this with the declaration?

Okay, will do.

>
>> +
>> +	return sprintf(buf, "%d\n", ap_matrix->available_instances);
>> +}
>> +
>> +MDEV_TYPE_ATTR_RO(available_instances);
>> +
>> +static ssize_t device_api_show(struct kobject *kobj, struct device *dev,
>> +			       char *buf)
>> +{
>> +	return sprintf(buf, "%s\n", VFIO_DEVICE_API_AP_STRING);
>> +}
>> +
>> +MDEV_TYPE_ATTR_RO(device_api);
>> +
>> +static struct attribute *vfio_ap_mdev_type_attrs[] = {
>> +	&mdev_type_attr_name.attr,
>> +	&mdev_type_attr_device_api.attr,
>> +	&mdev_type_attr_available_instances.attr,
>> +	NULL,
>> +};
>> +
>> +static struct attribute_group vfio_ap_mdev_hwvirt_type_group = {
>> +	.name = VFOP_AP_MDEV_TYPE_HWVIRT,
>> +	.attrs = vfio_ap_mdev_type_attrs,
>> +};
>> +
>> +static struct attribute_group *vfio_ap_mdev_type_groups[] = {
>> +	&vfio_ap_mdev_hwvirt_type_group,
>> +	NULL,
>> +};
>> +
>> +static const struct mdev_parent_ops vfio_ap_matrix_ops = {
>> +	.owner			= THIS_MODULE,
>> +	.supported_type_groups	= vfio_ap_mdev_type_groups,
>> +	.create			= vfio_ap_mdev_create,
>> +	.remove			= vfio_ap_mdev_remove,
>> +};
>> +
>> +int vfio_ap_mdev_register(struct ap_matrix *ap_matrix)
>> +{
>> +	int ret;
>> +
>> +	ret = mdev_register_device(&ap_matrix->device, &vfio_ap_matrix_ops);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ap_matrix->available_instances = AP_MATRIX_MAX_AVAILABLE_INSTANCES;
>> +
>> +	return 0;
>> +}
>> +
>> +void vfio_ap_mdev_unregister(struct ap_matrix *ap_matrix)
>> +{
>> +	ap_matrix->available_instances--;
>> +	mdev_unregister_device(&ap_matrix->device);
>> +}
>> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
>> index cf23675..afd8dbc 100644
>> --- a/drivers/s390/crypto/vfio_ap_private.h
>> +++ b/drivers/s390/crypto/vfio_ap_private.h
>> @@ -10,14 +10,31 @@
>>   #define _VFIO_AP_PRIVATE_H_
>>   
>>   #include <linux/types.h>
>> +#include <linux/device.h>
>> +#include <linux/mdev.h>
>>   
>>   #include "ap_bus.h"
>>   
>>   #define VFIO_AP_MODULE_NAME "vfio_ap"
>>   #define VFIO_AP_DRV_NAME "vfio_ap"
>> +/**
>> + * There must be one mediated matrix device per guest. If every APQN is assigned
> One, or at most one? Or one for every guest using ap devices?

'One mediated matrix device for every guest using AP devices' is most 
accurate. I'll make the change.

>
>> + * to a guest, then the maximum number of guests with a unique APQN assigned
>> + * would be 255 adapters x 255 domains = 72351 guests.
>> + */
>> +#define AP_MATRIX_MAX_AVAILABLE_INSTANCES 72351
>>   
>>   struct ap_matrix {
>>   	struct device device;
>> +	int available_instances;
>>   };
>>   
>> +static inline struct ap_matrix *to_ap_matrix(struct device *dev)
>> +{
>> +	return container_of(dev, struct ap_matrix, device);
>> +}
>> +
>> +extern int vfio_ap_mdev_register(struct ap_matrix *ap_matrix);
>> +extern void vfio_ap_mdev_unregister(struct ap_matrix *ap_matrix);
>> +
>>   #endif /* _VFIO_AP_PRIVATE_H_ */
