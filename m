Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752632AbeCOOw3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:52:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41476 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752244AbeCOOw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:52:27 -0400
Subject: Re: [PATCH v3 11/14] s390: vfio-ap: sysfs interface to view matrix
 mdev matrix
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1521051954-25715-12-git-send-email-akrowiak@linux.vnet.ibm.com>
 <fee58106-a481-aaf8-7fb6-8d51c4b7e906@linux.vnet.ibm.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Thu, 15 Mar 2018 10:52:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <fee58106-a481-aaf8-7fb6-8d51c4b7e906@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18031514-0028-0000-0000-0000094E5A1A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008679; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01003434; UDB=6.00510668; IPR=6.00782760;
 MB=3.00020051; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-15 14:52:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031514-0029-0000-0000-000039FA7CF6
Message-Id: <f86c2e7d-198b-0900-e0ed-f22fedf39b04@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-15_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803150165
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15/2018 05:42 AM, Pierre Morel wrote:
> On 14/03/2018 19:25, Tony Krowiak wrote:
>> Provides a sysfs interface to view the AP matrix configured for the
>> mediated matrix device.
>>
>> The relevant sysfs structures are:
>>
>> /sys/devices/vfio_ap
>> ... [matrix]
>> ...... [mdev_supported_types]
>> ......... [vfio_ap-passthrough]
>> ............ [devices]
>> ...............[$uuid]
>> .................. matrix
>>
>> To view the matrix configured for the mediated matrix device,
>> print the matrix file:
>>
>>     cat matrix
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c |   39 
>> +++++++++++++++++++++++++++++++++++++
>>   1 files changed, 39 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>> b/drivers/s390/crypto/vfio_ap_ops.c
>> index 461d450..04f7a92 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -692,6 +692,44 @@ static ssize_t control_domains_show(struct 
>> device *dev,
>>   }
>>   DEVICE_ATTR_RO(control_domains);
>>
>> +static ssize_t matrix_show(struct device *dev, struct 
>> device_attribute *attr,
>> +               char *buf)
>> +{
>> +    struct mdev_device *mdev = mdev_from_dev(dev);
>> +    struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>> +    char *bufpos = buf;
>> +    unsigned long apid;
>> +    unsigned long apqi;
>> +    int nchars = 0;
>> +    int n;
>> +
>> +    n = sprintf(bufpos, "ADAPTER.DOMAIN\n");
>
> For easy parsing it is better to only report the interesting data
> and let a user space utility make fancy presentation.
Is that your way of saying take the above line out?
>
>
>> +    bufpos += n;
>> +    nchars += n;
>> +
>> +    n = sprintf(bufpos, "--------------\n");
>> +    bufpos += n;
>> +    nchars += n;
>> +
>> +    for_each_set_bit_inv(apid, matrix_mdev->matrix->apm,
>> +                 matrix_mdev->matrix->apm_max) {
>> +        n = sprintf(bufpos, "%02lx\n", apid);
>> +        bufpos += n;
>> +        nchars += n;
>> +
>> +        for_each_set_bit_inv(apqi, matrix_mdev->matrix->aqm,
>> +                     matrix_mdev->matrix->aqm_max) {
>> +            n = sprintf(bufpos, "%02lx.%04lx\n", apid, apqi);
>> +            bufpos += n;
>> +            nchars += n;
>> +        }
>> +    }
>> +
>> +    return nchars;
>> +}
>> +DEVICE_ATTR_RO(matrix);
>> +
>> +
>>   static struct attribute *vfio_ap_mdev_attrs[] = {
>>       &dev_attr_assign_adapter.attr,
>>       &dev_attr_unassign_adapter.attr,
>> @@ -700,6 +738,7 @@ static ssize_t control_domains_show(struct device 
>> *dev,
>>       &dev_attr_assign_control_domain.attr,
>>       &dev_attr_unassign_control_domain.attr,
>>       &dev_attr_control_domains.attr,
>> +    &dev_attr_matrix.attr,
>>       NULL,
>>   };
>>
>
