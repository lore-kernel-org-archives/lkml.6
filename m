Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07275C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF4F2170E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 23:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF4F2170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732491AbeHOCUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 22:20:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729286AbeHOCUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 22:20:45 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7ENSkek057005
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 19:31:14 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kv5y8xq5u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 19:31:14 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Tue, 14 Aug 2018 19:31:14 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Aug 2018 19:31:10 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7ENV8nW60751986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Aug 2018 23:31:08 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E32B3AE05F;
        Tue, 14 Aug 2018 19:30:56 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 154E7AE05C;
        Tue, 14 Aug 2018 19:30:55 -0400 (EDT)
Received: from oc8043147753.ibm.com (unknown [9.85.204.74])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 14 Aug 2018 19:30:54 -0400 (EDT)
Subject: Re: [PATCH v9 08/22] s390: vfio-ap: base implementation of VFIO AP
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
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1534196899-16987-9-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180814124220.355f2ffa.cohuck@redhat.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Tue, 14 Aug 2018 19:30:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180814124220.355f2ffa.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18081423-0040-0000-0000-0000045EF84A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009545; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01073598; UDB=6.00553191; IPR=6.00853556;
 MB=3.00022720; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-14 23:31:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081423-0041-0000-0000-000008660197
Message-Id: <9537c702-d51c-aa26-3cb1-6aa0526e6fd2@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-14_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808140234
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2018 06:42 AM, Cornelia Huck wrote:
> On Mon, 13 Aug 2018 17:48:05 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>
>> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
>> new file mode 100644
>> index 0000000..5069580
>> --- /dev/null
>> +++ b/drivers/s390/crypto/vfio_ap_drv.c
>> @@ -0,0 +1,118 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * VFIO based AP device driver
>> + *
>> + * Copyright IBM Corp. 2018
>> + *
>> + * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/slab.h>
>> +#include <linux/string.h>
>> +#include "vfio_ap_private.h"
>> +
>> +#define VFIO_AP_ROOT_NAME "vfio_ap"
>> +#define VFIO_AP_DEV_TYPE_NAME "ap_matrix"
>> +#define VFIO_AP_DEV_NAME "matrix"
>> +
>> +MODULE_AUTHOR("IBM Corporation");
>> +MODULE_DESCRIPTION("VFIO AP device driver, Copyright IBM Corp. 2018");
>> +MODULE_LICENSE("GPL v2");
>> +
>> +static struct ap_driver vfio_ap_drv;
>> +
>> +static struct device_type vfio_ap_dev_type = {
>> +	.name = VFIO_AP_DEV_TYPE_NAME,
>> +};
>> +
>> +struct ap_matrix_dev matrix_dev;
> Please don't add new statically allocated devices, but allocate it
> dynamically (see the comment in device_add()).

Okay, I'll dynamically allocate it.

>
>> +
>> +/* Only type 10 adapters (CEX4 and later) are supported
>> + * by the AP matrix device driver
>> + */
>> +static struct ap_device_id ap_queue_ids[] = {
>> +	{ .dev_type = AP_DEVICE_TYPE_CEX4,
>> +	  .match_flags = AP_DEVICE_ID_MATCH_QUEUE_TYPE },
>> +	{ .dev_type = AP_DEVICE_TYPE_CEX5,
>> +	  .match_flags = AP_DEVICE_ID_MATCH_QUEUE_TYPE },
>> +	{ .dev_type = AP_DEVICE_TYPE_CEX6,
>> +	  .match_flags = AP_DEVICE_ID_MATCH_QUEUE_TYPE },
>> +	{ /* end of sibling */ },
>> +};
>> +
>> +MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
>> +
>> +static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
>> +{
>> +	return 0;
>> +}
>> +
>> +static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
>> +{
>> +	/* Nothing to do yet */
>> +}
> You need a release callback as well.

Will do.

>
>> +
>> +static int vfio_ap_matrix_dev_init(void)
>> +{
>> +	int ret;
>> +	struct device *root_device;
>> +
>> +	root_device = root_device_register(VFIO_AP_ROOT_NAME);
>> +	if (IS_ERR(root_device)) {
>> +		ret = PTR_ERR(root_device);
>> +		return ret;
>> +	}
>> +
>> +	matrix_dev.device.type = &vfio_ap_dev_type;
>> +	dev_set_name(&matrix_dev.device, "%s", VFIO_AP_DEV_NAME);
>> +	matrix_dev.device.type = &vfio_ap_dev_type;
>> +	matrix_dev.device.parent = root_device;
>> +	matrix_dev.device.driver = &vfio_ap_drv.driver;
>> +
>> +	ret = device_register(&matrix_dev.device);
>> +	if (ret) {
>> +		root_device_unregister(root_device);
> And this needs a put_device() for the matrix device. (It is getting
> ugly with a statically allocated device.)

Will do.

>
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void vfio_ap_matrix_dev_destroy(void)
>> +{
>> +	device_unregister(&matrix_dev.device);
> This one already does a put_device(). Didn't the driver core complain?

The driver core did not complain.

>
>> +	root_device_unregister(matrix_dev.device.parent);
>> +}


