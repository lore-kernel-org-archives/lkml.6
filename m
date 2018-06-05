Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751912AbeFENDC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:03:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51456 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751667AbeFENDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:03:01 -0400
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v2 10/10] vfio: ccw: Let user wait when busy on IO
To: Heiko Carstens <heiko.carstens@de.ibm.com>,
        Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, cohuck@redhat.com
References: <1527243678-3140-1-git-send-email-pmorel@linux.vnet.ibm.com>
 <1527243678-3140-11-git-send-email-pmorel@linux.vnet.ibm.com>
 <20180525140418.GA17131@osiris>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Tue, 5 Jun 2018 15:02:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180525140418.GA17131@osiris>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18060513-0016-0000-0000-000001D85A98
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060513-0017-0000-0000-0000322B6097
Message-Id: <05ae3528-d4e9-3f0f-4585-8e209f9d9e22@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-05_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806050151
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2018 16:04, Heiko Carstens wrote:
> On Fri, May 25, 2018 at 12:21:18PM +0200, Pierre Morel wrote:
>> In the current implementation, we do not want to start a new SSCH
>> command before the last one ends.
>>
>> Currently the user needs to poll on the -EBUSY error to
>> wait before sending a new request.
>>
>> Let's be friendly with global warming and let the user sleep
>> until he may send a new request.
>>
>> Let's make the caller wait until the last SSCH ends.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> ---
>>   drivers/s390/cio/vfio_ccw_fsm.c     | 4 ++++
>>   drivers/s390/cio/vfio_ccw_ops.c     | 6 ++++++
>>   drivers/s390/cio/vfio_ccw_private.h | 1 +
>>   3 files changed, 11 insertions(+)
>>
>> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
>> index c37052d..97b74a1 100644
>> --- a/drivers/s390/cio/vfio_ccw_fsm.c
>> +++ b/drivers/s390/cio/vfio_ccw_fsm.c
>> @@ -200,6 +200,10 @@ static int fsm_irq(struct vfio_ccw_private *private)
>>   
>>   	if (private->io_trigger)
>>   		eventfd_signal(private->io_trigger, 1);
>> +
>> +	if (private->io_completion)
>> +		complete(private->io_completion);
>> +
>>   	return VFIO_CCW_STATE_IDLE;
>>   }
>>   
>> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
>> index b202e73..39beb6e 100644
>> --- a/drivers/s390/cio/vfio_ccw_ops.c
>> +++ b/drivers/s390/cio/vfio_ccw_ops.c
>> @@ -183,6 +183,7 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
>>   	struct vfio_ccw_private *private;
>>   	struct ccw_io_region *region;
>>   	union scsw *scsw;
>> +	DECLARE_COMPLETION_ONSTACK(completion);
>>   
>>   	if (*ppos + count > sizeof(*region))
>>   		return -EINVAL;
>> @@ -196,6 +197,11 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
>>   	scsw = (union scsw *) &region->scsw_area;
>>   	switch (scsw->cmd.fctl) {
>>   	case SCSW_FCTL_START_FUNC:
>> +		if (private->state == VFIO_CCW_STATE_BUSY) {
>> +			private->io_completion = &completion;
>> +			if (wait_for_completion_interruptible(&completion))
>> +				return -EINTR;
>> +		}
> What prevents a state change between checking the state and before
> private->io_completion is set? If that happens you would end with an
> endless wait.
>
> Similarly, you would have memory corruption if the task would be
> interrupted and if the function would be left, ending up with a stale
> private->io_completion completion pointer.
> The complete(private->io_completion) call will then write to a memory
> location that might already be reused.
>
> Just my 0.02 after having a very very short look ;)

Right, completely false, I should pay a little more (at least) attention.

Thanks to have had a very very short (but sharp)look.

Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany
