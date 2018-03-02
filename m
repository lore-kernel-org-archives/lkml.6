Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164219AbeCBCQp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 21:16:45 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:55152 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163939AbeCBCQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 21:16:43 -0500
Subject: Re: [PATCH V2] scsi: core: use blk_mq_requeue_request in
 __scsi_queue_insert
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>
References: <1519808113-2863-1-git-send-email-jianchao.w.wang@oracle.com>
 <1519840355.2777.8.camel@wdc.com>
 <624cedc6-9658-7b76-9c63-61c30fdfe6be@oracle.com>
 <1519926225.2675.6.camel@wdc.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <c575c4d0-ee5a-6123-d44e-7be93650e3f4@oracle.com>
Date: Fri, 2 Mar 2018 10:16:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519926225.2675.6.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8819 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803020021
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart

Thanks for your precious time and detailed summary.

On 03/02/2018 01:43 AM, Bart Van Assche wrote:
> Yes, the block layer core guarantees that scsi_mq_get_budget() will be called
> before scsi_queue_rq(). I think the full picture is as follows:
> * Before scsi_queue_rq() calls .queuecommand(), get_device() is called for the
>   SCSI device and the device, target and host busy counters are incremented.

Supply some details here:
scsi_mq_get_budget before calling .queuecommand get_device and increase device_busy.
scsi_queue_rq increases target_busy and host_busy.

> * If the SCSI core decides to requeue a command, scsi_queue_insert() causes
>   __scsi_queue_insert() to call scsi_device_unbusy(). That last function
>   decreases the device, target and host busy counters but not put_device(sdev).
>   Hence the need for a separate put_device() call after requeuing.
> 
> It's unfortunate that the SCSI core became so asymmetric. Anyway, since I am
> now convinced that this patch is correct, feel free to add:
> 
> Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>


Sincerely
Jianchao
