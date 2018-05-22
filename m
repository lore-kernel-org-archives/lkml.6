Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753095AbeEVVla (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 17:41:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36942 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752960AbeEVVl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 17:41:28 -0400
Cc: akrowiak@linux.vnet.ibm.com, Halil Pasic <pasic@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
        berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
Subject: Re: [PATCH v5 05/13] s390: vfio-ap: register matrix device with VFIO
 mdev framework
To: Cornelia Huck <cohuck@redhat.com>
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-6-git-send-email-akrowiak@linux.vnet.ibm.com>
 <5471b194-d7ca-c9c6-132e-fa9539fe44f0@linux.ibm.com>
 <4688078d-3e13-5201-582f-52576b25defa@linux.vnet.ibm.com>
 <20180517094454.6afae7ba.cohuck@redhat.com>
 <b45ba36a-0451-56b8-c038-410441bb8bd4@linux.vnet.ibm.com>
 <20180522101940.166445f8.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Tue, 22 May 2018 17:41:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180522101940.166445f8.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18052221-0024-0000-0000-0000036004F4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009068; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036186; UDB=6.00530060; IPR=6.00815315;
 MB=3.00021246; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-22 21:41:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052221-0025-0000-0000-0000482109A0
Message-Id: <0ccac0ff-82d0-4adc-26a5-c64caf0f7a80@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805220219
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/22/2018 04:19 AM, Cornelia Huck wrote:
> On Mon, 21 May 2018 11:13:58 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> On 05/17/2018 03:44 AM, Cornelia Huck wrote:
>>> On Mon, 14 May 2018 15:42:18 -0400
>>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>>   
>>>> On 05/11/2018 01:18 PM, Halil Pasic wrote:
>>>>> On 05/07/2018 05:11 PM, Tony Krowiak wrote:
>>>>>> Registers the matrix device created by the VFIO AP device
>>>>>> driver with the VFIO mediated device framework.
>>>>>> Registering the matrix device will create the sysfs
>>>>>> structures needed to create mediated matrix devices
>>>>>> each of which will be used to configure the AP matrix
>>>>>> for a guest and connect it to the VFIO AP device driver.
>>>>>> +static int vfio_ap_mdev_create(struct kobject *kobj, struct
>>>>>> mdev_device *mdev)
>>>>>> +{
>>>>>> +    struct ap_matrix *ap_matrix = to_ap_matrix(mdev_parent_dev(mdev));
>>>>>> +
>>>>>> +    ap_matrix->available_instances--;
>>>>>> +
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int vfio_ap_mdev_remove(struct mdev_device *mdev)
>>>>>> +{
>>>>>> +    struct ap_matrix *ap_matrix = to_ap_matrix(mdev_parent_dev(mdev));
>>>>>> +
>>>>>> +    ap_matrix->available_instances++;
>>>>>> +
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>> The above functions seem to be called with the lock of this
>>>>> auto-generated
>>>>> mdev parent device held. That's why we don't have to care about
>>>>> synchronization
>>>>> ourselves, right?
>>>> I would assume as much. The comments for the 'struct mdev_parent_ops' in
>>>> include/linux/mdev.h do not mention anything about synchronization, nor
>>>> did I
>>>> see any locking or synchronization in the vfio_ccw implementation after
>>>> which
>>>> I modeled my code, so frankly it is something I did not consider.
>>>>   
>>>>> A small comment in the code could be helpful for mdev non-experts.
>>>>> Hell, I would
>>>>> even consider documenting it for all mdev -- took me some time to
>>>>> figure out.
>>>> You may want to bring this up with the VFIO mdev maintainers, but I'd be
>>>> happy to
>>>> include a comment in the functions in question if you think it important.
>>> Important note: There's currently a patch on list that removes the mdev
>>> parent mutex, and it seems there was never intended to be any
>>> serialization in that place by the mdev core. (Look for "vfio/mdev:
>>> Check globally for duplicate devices".)
>> The patch on the list holds the mdev_list_lock during create and remove
>> of an mdev device, so it looks like no synchronization is necessary on the
>> part of the vendor code in the create/remove callbacks; does that sound
>> about right?
> v1/v2 did that; v3/v4 hold the list lock only while the device is added
> to the mdev list. v4 also adds a note regarding locking to the
> documentation.

I'll add some synchronization to the read/update of available instances.

>
