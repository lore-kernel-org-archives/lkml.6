Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751548AbeE3O3O (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:29:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56298 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750987AbeE3O3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:29:12 -0400
Subject: Re: [PATCH v5 10/13] s390: vfio-ap: sysfs interface to view matrix
 mdev matrix
To: pmorel@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
        berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-11-git-send-email-akrowiak@linux.vnet.ibm.com>
 <a6bba129-8a3c-a848-65aa-b67816bf2d25@linux.ibm.com>
 <53275110-45fb-d50f-c97e-93141378f094@linux.vnet.ibm.com>
 <89bda651-d465-af50-a737-1900a54b01c8@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Wed, 30 May 2018 10:28:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <89bda651-d465-af50-a737-1900a54b01c8@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18053014-8235-0000-0000-00000D9BB386
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009098; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01039855; UDB=6.00532245; IPR=6.00818987;
 MB=3.00021376; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-30 14:29:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053014-8236-0000-0000-0000413DCCBB
Message-Id: <6f67a282-773d-3fca-5b36-cc23ad49ba5b@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-30_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805300161
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/24/2018 05:10 AM, Pierre Morel wrote:
> On 23/05/2018 16:38, Tony Krowiak wrote:
>> On 05/16/2018 03:55 AM, Pierre Morel wrote:
>>> On 07/05/2018 17:11, Tony Krowiak wrote:
>>>> Provides a sysfs interface to view the AP matrix configured for the
>>>> mediated matrix device.
>>>>
>>>> The relevant sysfs structures are:
>>>>
>>>> /sys/devices/vfio_ap
>>>> ... [matrix]
>>>> ...... [mdev_supported_types]
>>>> ......... [vfio_ap-passthrough]
>>>> ............ [devices]
>>>> ...............[$uuid]
>>>> .................. matrix
>>>>
>>>> To view the matrix configured for the mediated matrix device,
>>>> print the matrix file:
>>>
>>> This is the configured matrix, not the one used by the guest.
>>> Nothing in the patches protect against binding a queue and assigning
>>> a new AP when the guest runs.
>>> The card and queue will be showed by this entry.
>>
>> Of course, as stated above, this is the matrix configured for the
>> mediated matrix device. Are you suggesting here that the driver
>> should prevent assigning a new adapter or domain while a guest is
>> running? Couldn't this be a step in the process for hot (un)plugging
>> AP queues?
>
> No, I mean what is the point to show this?
> It is not what the guest sees.
> Has it any use case?

The point is to display the matrix so one can view the AP queues that
have been assigned to the mediated matrix device. This is the only way
to view the matrix. Do you not find value in being able to see what
has been assigned to the mediated matrix device?

>
>
>>
>>>
>>>
>>>
>>>>
>>>>     cat matrix
>>>>
>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>>>> ---
>>>>   drivers/s390/crypto/vfio_ap_ops.c |   31 
>>>> +++++++++++++++++++++++++++++++
>>>>   1 files changed, 31 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c 
>>>> b/drivers/s390/crypto/vfio_ap_ops.c
>>>> index 755be1d..81e03b8 100644
>>>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>>>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>>>> @@ -716,6 +716,36 @@ static ssize_t control_domains_show(struct 
>>>> device *dev,
>>>>   }
>>>>   DEVICE_ATTR_RO(control_domains);
>>>>
>>>> +static ssize_t matrix_show(struct device *dev, struct 
>>>> device_attribute *attr,
>>>> +               char *buf)
>>>> +{
>>>> +    struct mdev_device *mdev = mdev_from_dev(dev);
>>>> +    struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
>>>> +    char *bufpos = buf;
>>>> +    unsigned long apid;
>>>> +    unsigned long apqi;
>>>> +    unsigned long napm = matrix_mdev->matrix.apm_max + 1;
>>>> +    unsigned long naqm = matrix_mdev->matrix.aqm_max + 1;
>>>> +    int nchars = 0;
>>>> +    int n;
>>>> +
>>>> +    for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, napm) {
>>>> +        n = sprintf(bufpos, "%02lx\n", apid);
>>>> +        bufpos += n;
>>>> +        nchars += n;
>>>> +
>>>> +        for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, naqm) {
>>>> +            n = sprintf(bufpos, "%02lx.%04lx\n", apid, apqi);
>>>> +            bufpos += n;
>>>> +            nchars += n;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    return nchars;
>>>> +}
>>>> +DEVICE_ATTR_RO(matrix);
>>>> +
>>>> +
>>>>   static struct attribute *vfio_ap_mdev_attrs[] = {
>>>>       &dev_attr_assign_adapter.attr,
>>>>       &dev_attr_unassign_adapter.attr,
>>>> @@ -724,6 +754,7 @@ static ssize_t control_domains_show(struct 
>>>> device *dev,
>>>>       &dev_attr_assign_control_domain.attr,
>>>>       &dev_attr_unassign_control_domain.attr,
>>>>       &dev_attr_control_domains.attr,
>>>> +    &dev_attr_matrix.attr,
>>>>       NULL,
>>>>   };
>>>>
>>>
>>
>
