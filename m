Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934675AbeB1Uen (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 15:34:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39306 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934616AbeB1Uej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 15:34:39 -0500
Subject: Re: [PATCH v2 05/15] s390: vfio-ap: base implementation of VFIO AP
 device driver
To: Cornelia Huck <cohuck@redhat.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, fiuczy@linux.vnet.ibm.com,
        buendgen@de.ibm.com
References: <1519741693-17440-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1519741693-17440-6-git-send-email-akrowiak@linux.vnet.ibm.com>
 <bdc22d47-afe6-a71a-615d-3beffd4ada3e@linux.vnet.ibm.com>
 <c7ae5d8e-aa40-9da5-afdf-af53487de3c3@linux.vnet.ibm.com>
 <20180228191019.20507888.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Wed, 28 Feb 2018 15:34:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180228191019.20507888.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18022820-0008-0000-0000-000002DD24CA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008603; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00996462; UDB=6.00506588; IPR=6.00775784;
 MB=3.00019783; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-28 20:34:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022820-0009-0000-0000-0000386ACA98
Message-Id: <6ec02d29-a0fb-a60e-0147-8c7c7530c3ae@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802280250
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/2018 01:10 PM, Cornelia Huck wrote:
> On Wed, 28 Feb 2018 11:43:37 -0500
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> On 02/28/2018 10:33 AM, Pierre Morel wrote:
>>> On 27/02/2018 15:28, Tony Krowiak wrote:
> (...)
>
>>>> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
>>>> index cbe1d97..9f23caf 100644
>>>> --- a/arch/s390/Kconfig
>>>> +++ b/arch/s390/Kconfig
>>>> @@ -771,6 +771,14 @@ config VFIO_CCW
>>>>          To compile this driver as a module, choose M here: the
>>>>          module will be called vfio_ccw.
>>>>
>>>> +config VFIO_AP
>>>> +    def_tristate m
> Any reason you default to m instead of n here?
None in particular, is there a good reason to change this to n?
>
>>>> +    prompt "Support for virtual Adjunct Processor device interface"
>>> The VFIO AP devices are not virtual.
>>> What about
>>>      "VFIO support for AP devices"
>> Sounds good.
> +1
>
>>>   
>>>> +    depends on ZCRYPT && VFIO_MDEV_DEVICE
>>>> +    help
>>>> +        driver grants access to Adjunct Processor (AP) devices
> s/driver/This driver/
Okay, I'll make the change
>
>>>> +        via the VFIO mediated device interface.
> You also might want to add
>
> "To compile this driver as a module, choose M here: the
> module will be called..."
Will do
>
>>>> +
>>>>    endmenu
> It's a tad confusing to find this in the I/O submenu, but I don't
> really have a better idea.
I wasn't sure either, but couldn't think of a better location. Anybody
else have any ideas?
>
>>>>    menu "Dump support"
>>>> diff --git a/arch/s390/configs/default_defconfig
>>>> b/arch/s390/configs/default_defconfig
>>>> index 5af8458..40fa3f6 100644
>>>> --- a/arch/s390/configs/default_defconfig
>>>> +++ b/arch/s390/configs/default_defconfig
>>> Not sure that this file belongs to this patch
>> Neither am I, but at the time I inserted this here - well before August
>> of last year - I was using vfio-ccw as a model.
>> If someone can verify this does not belong here, I'd be more than happy
>> to remove it.
> I don't see any entry for VFIO_CCW in there?
There isn't now, but there was at the time I first started working on this.
My first pass was a lot of cut-and-paste followed by modification of the
vfio_ccw implementation, but that was long ago. This is a remnant of that
time. Like I said, I'd be happy to remove this.
>
>>>   
>>>> @@ -719,3 +719,6 @@ CONFIG_APPLDATA_BASE=y
>>>>    CONFIG_KVM=m
>>>>    CONFIG_KVM_S390_UCONTROL=y
>>>>    CONFIG_VHOST_NET=m
>>>> +VFIO_MDEV=m
>>>> +VFIO_MDEV_DEVICE=m
>>>> +CONFIG_VFIO_AP=m
>>> What is your goal when modifying this three files?
>>> Could you add a comment in the commit message?
>> As stated above, this was originally based on the vfio-ccw model and has
>> been in the
>> patch series since its inception. I'd be happy to remove it if it is not
>> necessary.
> I'd vote for removing it.
Consider them gone.
>
> (...)
>
>>>> +static int vfio_ap_matrix_dev_create(void)
>>>> +{
>>>> +    int ret;
>>>> +
>>>> +    vfio_ap_root_device = root_device_register(VFIO_AP_ROOT_NAME);
>>>> +
>>>> +    ret = PTR_ERR_OR_ZERO(vfio_ap_root_device);
>>> IS_ERR() is enough, root_device_register() never return NULL.
>> I searched the kernel code to look at other places the
>> root_device_register()
>> function is called to see how the return value is handled. I've seen all
>> of the
>> following used:
>> if (IS_ERR())
>>       ret = PTR_ERR()
>> PTR_ERR()
>> PTR_ERR_OR_ZERO()
>>
>> I'm not sure why this is a concern, but I'll use the first option above
>> since PTR_ERR_OR_ZERO() also embeds the first option.
> PTR_ERR_OR_ZERO() seems like the best choice for the way the return
> code is processed here. (It's just unfortunate that its name conjures
> up connotations of NULL-pointer handling.)
I changed it to:

     ret = IS_ERR(vfio_ap_root_device);
     if (ret) {
         ret = PTR_ERR(vfio_ap_root_device);
         goto done;
     }

Hopefully everybody is happy with this.
>
>>>> +    if (ret)
>>>> +        goto done;
