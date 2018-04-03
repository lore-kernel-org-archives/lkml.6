Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752156AbeDCPmv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 11:42:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39752 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751645AbeDCPmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 11:42:49 -0400
Subject: Re: [PATCH v3 09/14] s390: vfio-ap: sysfs interfaces to configure
 domains
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com,
        berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        akrowiak@linux.vnet.ibm.com
References: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1521051954-25715-10-git-send-email-akrowiak@linux.vnet.ibm.com>
 <20180403131759.24516cf4.cohuck@redhat.com>
 <1860430c-df59-6d58-77f9-b36c51595b4b@linux.vnet.ibm.com>
 <20180403171910.2edaf63c.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Tue, 3 Apr 2018 11:42:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180403171910.2edaf63c.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18040315-0028-0000-0000-000009641A9C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008795; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01012562; UDB=6.00516063; IPR=6.00791828;
 MB=3.00020393; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-03 15:42:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040315-0029-0000-0000-00003A3978CA
Message-Id: <66115f68-809b-d765-5916-e3d8d391db5a@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-03_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804030162
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2018 11:19 AM, Cornelia Huck wrote:
> On Tue, 3 Apr 2018 11:12:45 -0400
> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>
>> On 04/03/2018 07:17 AM, Cornelia Huck wrote:
>>> On Wed, 14 Mar 2018 14:25:49 -0400
>>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>>   
>>>> Provides the sysfs interfaces for assigning AP domains to
>>>> and unassigning AP domains from a mediated matrix device.
>>>>
>>>> An AP domain ID corresponds to an AP queue index (APQI). For
>>>> each domain assigned to the mediated matrix device, its
>>>> corresponging APQI is stored in an AP queue mask (AQM).
>>>> The bits in the AQM, from most significant to least
>>>> significant bit, correspond to AP domain numbers 0 to 255.
>>>> When a domain is assigned, the bit corresponding to its
>>>> APQI will be set in the AQM. Likewise, when a domain is
>>>> unassigned, the bit corresponding to its APQI will be
>>>> cleared from the AQM.
>>>>
>>>> The relevant sysfs structures are:
>>>>
>>>> /sys/devices/vfio_ap
>>>> ... [matrix]
>>>> ...... [mdev_supported_types]
>>>> ......... [vfio_ap-passthrough]
>>>> ............ [devices]
>>>> ...............[$uuid]
>>>> .................. assign_domain
>>>> .................. unassign_domain
>>>>
>>>> To assign a domain to the $uuid mediated matrix device,
>>>> write the domain's ID to the assign_domain file. To
>>>> unassign a domain, write the domain's ID to the
>>>> unassign_domain file. The ID is specified using
>>>> conventional semantics: If it begins with 0x, the number
>>>> will be parsed as a hexadecimal (case insensitive) number;
>>>> otherwise, it will be parsed as a decimal number.
>>>>
>>>> For example, to assign domain 173 (0xad) to the mediated matrix
>>>> device $uuid:
>>>>
>>>> 	echo 173 > assign_domain
>>>>
>>>> 	or
>>>>
>>>> 	echo 0xad > assign_domain
>>>>
>>>> To unassign domain 173 (0xad):
>>>>
>>>> 	echo 173 > unassign_domain
>>>>
>>>> 	or
>>>>
>>>> 	echo 0xad > unassign_domain
>>>>
>>>> The assignment will be rejected:
>>>>
>>>> * If the domain ID exceeds the maximum value for an AP domain:
>>>>
>>>>     * If the AP Extended Addressing (APXA) facility is installed,
>>>>       the max value is 255
>>>>
>>>>     * Else the max value is 15
>>>>
>>>> * If no AP adapters have yet been assigned and there are
>>>>     no AP queues reserved by the VFIO AP driver that have an APQN
>>>>     with an APQI matching that of the AP domain number being
>>>>     assigned.
>>>>
>>>> * If any of the APQNs that can be derived from the intersection
>>>>     of the APQI being assigned and the AP adapter ID (APID) of
>>>>     each of the AP adapters previously assigned can not be matched
>>>>     with an APQN of an AP queue device reserved by the VFIO AP
>>>>     driver.
>>>>
>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>>>> ---
>>>>    arch/s390/include/asm/kvm-ap.h    |    1 +
>>>>    drivers/s390/crypto/vfio_ap_ops.c |  215 ++++++++++++++++++++++++++++++++++++-
>>>>    2 files changed, 215 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>>>> index 90512a6..c448835 100644
>>>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>>>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
>>>> @@ -377,10 +377,223 @@ static ssize_t unassign_adapter_store(struct device *dev,
>>>>    }
>>>>    DEVICE_ATTR_WO(unassign_adapter);
>>>>    
>>>> +/**
>>>> + * vfio_ap_validate_queues_for_apqi
>>>> + *
>>>> + * @ap_matrix: the matrix device
>>>> + * @matrix_mdev: the mediated matrix device
>>>> + * @apqi: an AP queue index (APQI) - corresponds to a domain ID
>>>> + *
>>>> + * Verifies that each APQN that is derived from the intersection of @apqi and
>>>> + * each AP adapter ID (APID) corresponding to an AP domain assigned to the
>>>> + * @matrix_mdev matches the APQN of an AP queue reserved by the VFIO AP device
>>>> + * driver.
>>>> + *
>>>> + * Returns 0 if validation succeeds; otherwise, returns an error.
>>>> + */
>>>> +static int vfio_ap_validate_queues_for_apqi(struct ap_matrix *ap_matrix,
>>>> +					    struct ap_matrix_mdev *matrix_mdev,
>>>> +					    unsigned long apqi)
>>>> +{
>>>> +	int ret;
>>>> +	struct vfio_ap_qid_match qid_match;
>>>> +	unsigned long apid;
>>>> +	struct device_driver *drv = ap_matrix->device.driver;
>>>> +
>>>> +	/**
>>>> +	 * Examine each APQN with the specified APQI
>>>> +	 */
>>>> +	for_each_set_bit_inv(apid, matrix_mdev->matrix->apm,
>>>> +			     matrix_mdev->matrix->apm_max) {
>>>> +		qid_match.qid = AP_MKQID(apid, apqi);
>>>> +		qid_match.dev = NULL;
>>>> +
>>>> +		ret = driver_for_each_device(drv, NULL, &qid_match,
>>>> +					     vfio_ap_queue_match);
>>>> +		if (ret)
>>>> +			return ret;
>>> Hm, I'm wondering whether jumping out of the outer loop is the correct
>>> thing to do here - and if yes, whether we should log an error?
>> If you look at the vfio_ap_queue_match() function which is passed to the
>> driver_for_each_device() function, it never returns an error. The
>> driver_for_each_device() function only returns an error if the function
>> passed in returns an error, so in reality, the value of *ret *will never
>> be anything but 0. Having said that, there are no guarantees that the
>> vfio_ap_queue_match() function will never change, so it would probably
>> be a good idea to log an error if *ret *is not 0.**I think returning at
>> this point is valid because a non-zero is returned from
>> driver_for_each_device() function as soon as the input function returns
>> a non-zero value for a specific device. This means that subsequent
>> devices will not be processed, so we may not know whether an AP queue
>> has been reserved or not - see check below.
> OK, then logging an error makes the most sense.
>
> Is there a source tree with the patches somewhere, btw? Checking out a
> branch is less time-consuming than applying a series (and helps
> review). Same applies to the qemu patches; maybe one of the IBM
> maintainers can push to a branch?
I'll check with Christian for the forthcoming v4 patches.
>
>>>   
>>>> +
>>>> +		/*
>>>> +		 * If the APQN identifies an AP queue that is reserved by the
>>>> +		 * VFIO AP device driver, continue processing.
>>>> +		 */
>>>> +		if (qid_match.dev)
>>>> +			continue;
>>>> +
>>>> +		pr_err("%s: AP queue %02lx.%04lx not reserved by %s driver",
>>>> +		       VFIO_AP_MATRIX_MODULE_NAME, apqi, apqi,
>>>> +		       VFIO_AP_DRV_NAME);
>>>> +
>>>> +		return -ENXIO;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>
