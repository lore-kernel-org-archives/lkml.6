Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933417AbeEWOiy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 10:38:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35648 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933399AbeEWOim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 10:38:42 -0400
Cc: akrowiak@linux.vnet.ibm.com, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
        berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
Subject: Re: [PATCH v5 10/13] s390: vfio-ap: sysfs interface to view matrix
 mdev matrix
To: pmorel@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-11-git-send-email-akrowiak@linux.vnet.ibm.com>
 <a6bba129-8a3c-a848-65aa-b67816bf2d25@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Wed, 23 May 2018 10:38:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <a6bba129-8a3c-a848-65aa-b67816bf2d25@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18052314-0020-0000-0000-00000DFEB088
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009072; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036525; UDB=6.00530262; IPR=6.00815653;
 MB=3.00021258; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-23 14:38:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052314-0021-0000-0000-000061868597
Message-Id: <53275110-45fb-d50f-c97e-93141378f094@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-23_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805230148
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/16/2018 03:55 AM, Pierre Morel wrote:
> On 07/05/2018 17:11, Tony Krowiak wrote:
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
>
> This is the configured matrix, not the one used by the guest.
> Nothing in the patches protect against binding a queue and assigning
> a new AP when the guest runs.
> The card and queue will be showed by this entry.

Of course, as stated above, this is the matrix configured for the
mediated matrix device. Are you suggesting here that the driver
should prevent assigning a new adapter or domain while a guest is
running? Couldn't this be a step in the process for hot (un)plugging
AP queues?

>
>
>
>>
>>     cat matrix
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_ops.c |   31 
>> +++++++++++++++++++++++++++++++
>>   1 files changed, 31 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>> b/drivers/s390/crypto/vfio_ap_ops.c
>> index 755be1d..81e03b8 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>> @@ -716,6 +716,36 @@ static ssize_t control_domains_show(struct 
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
>> +    unsigned long napm = matrix_mdev->matrix.apm_max + 1;
>> +    unsigned long naqm = matrix_mdev->matrix.aqm_max + 1;
>> +    int nchars = 0;
>> +    int n;
>> +
>> +    for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, napm) {
>> +        n = sprintf(bufpos, "%02lx\n", apid);
>> +        bufpos += n;
>> +        nchars += n;
>> +
>> +        for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, naqm) {
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
>> @@ -724,6 +754,7 @@ static ssize_t control_domains_show(struct device 
>> *dev,
>>       &dev_attr_assign_control_domain.attr,
>>       &dev_attr_unassign_control_domain.attr,
>>       &dev_attr_control_domains.attr,
>> +    &dev_attr_matrix.attr,
>>       NULL,
>>   };
>>
>
