Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965838AbeEXJJZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 05:09:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52566 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965517AbeEXJJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 05:09:22 -0400
Subject: Re: BUG: scsi/qla2xxx: BUG_ON(blk_queued_rq(req) is triggered in
 blk_finish_request
To: "Madhani, Himanshu" <Himanshu.Madhani@cavium.com>,
        Dept-Eng QLA2xxx Upstream <qla2xxx-upstream@cavium.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Junxiao Bi <junxiao.bi@oracle.com>
References: <5eb1eeaa-b148-7b90-eee4-e365ead49a5b@oracle.com>
 <8c7b011e-1379-c151-a187-94d8e0697fd9@oracle.com>
 <SN4PR0701MB363286637D0317358D61ECBFF56A0@SN4PR0701MB3632.namprd07.prod.outlook.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <675528c5-89d6-a4f5-e91a-6d75fdbef9af@oracle.com>
Date: Thu, 24 May 2018 17:09:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <SN4PR0701MB363286637D0317358D61ECBFF56A0@SN4PR0701MB3632.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8902 signatures=668700
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805240111
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Himanshu

Thanks god get response from your side finally :)
I get qla2xxx-upstream@qlogic.com from the maintainer information of driver/scsi/qla2xxx
Looks like it should be modified.

Thanks
Jianchao

On 05/24/2018 12:21 PM, Madhani, Himanshu wrote:
> Hi, 
> 
> Yes. We'll look at this issue. 
> 
> Thanks,
> Himanshu  
> 
>> -----Original Message-----
>> From: jianchao.wang [mailto:jianchao.w.wang@oracle.com]
>> Sent: Wednesday, May 23, 2018 6:51 PM
>> To: Dept-Eng QLA2xxx Upstream <qla2xxx-upstream@cavium.com>; Madhani,
>> Himanshu <Himanshu.Madhani@cavium.com>; jthumshirn@suse.de
>> Cc: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org;
>> jejb@linux.vnet.ibm.com; Martin K. Petersen <martin.petersen@oracle.com>;
>> Junxiao Bi <junxiao.bi@oracle.com>
>> Subject: Re: BUG: scsi/qla2xxx: BUG_ON(blk_queued_rq(req) is triggered in
>> blk_finish_request
>>
>> Would anyone please take a look at this ?
>>
>> Thanks in advance
>> Jianchao
>>
>> On 05/23/2018 11:55 AM, jianchao.wang wrote:
>>>
>>>
>>> Hi all
>>>
>>> Our customer met a panic triggered by BUG_ON in blk_finish_request.
>>> >From the dmesg log, the BUG_ON was triggered after command abort
>> occurred many times.
>>> There is a race condition in the following scenario.
>>>
>>> cpu A                                   cpu B
>>> kworker                                 interrupt
>>>
>>> scmd_eh_abort_handler()
>>>   -> scsi_try_to_abort_cmd()
>>>     -> qla2xxx_eh_abort()
>>>       -> qla2x00_eh_wait_on_command()   qla2x00_status_entry()
>>>                                           -> qla2x00_sp_compl()
>>>                                             -> qla2x00_sp_free_dma()
>>>   -> scsi_queue_insert()
>>>     -> __scsi_queue_insert()
>>>       -> blk_requeue_request()
>>>         -> blk_clear_rq_complete()
>>>                                             -> scsi_done
>>>                                               -> blk_complete_request
>>>                                                 -> blk_mark_rq_complete
>>>           -> elv_requeue_request()              -> __blk_complete_request()
>>>             -> __elv_add_request()
>>>             // req will be queued here
>>>                                                     BLK_SOFTIRQ
>>>                                                     scsi_softirq_done()
>>>                                                       -> scsi_finish_command()
>>>                                                         -> scsi_io_completion()
>>>                                                           -> scsi_end_request()
>>>                                                             -> blk_finish_request()  //
>> BUG_ON(blk_queued_rq(req)) !!!
>>>
>>> The issue will not be triggered most of time, because the request is marked as
>> complete by timeout path.
>>> So the scsi_done from qla2x00_sp_compl does nothing.
>>> But as the scenario above, if the complete state has been cleaned by
>> blk_requeue_request, we will get
>>> the request both requeued and completed, and then
>> BUG_ON(blk_queued_rq(req)) in blk_finish_request comes up.
>>>
>>> Is there any solution for this in qla2xxx driver side ?
>>>
>>> Thanks
>>> Jianchao
>>>
>>>
