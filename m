Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751047AbeBJDOw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 22:14:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52278 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeBJDOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 22:14:51 -0500
Subject: Re: [PATCH V2 0/6]nvme-pci: fixes on nvme_timeout and
 nvme_dev_disable
To: Keith Busch <keith.busch@intel.com>
Cc: axboe@fb.com, hch@lst.de, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
References: <1517822415-11710-1-git-send-email-jianchao.w.wang@oracle.com>
 <073ce416-fd26-b41a-187d-1db9210c48b0@grimberg.me>
 <20180208175606.GD5039@localhost.localdomain>
 <db5fe34b-3ffb-a658-d4d6-a1c619b2d590@oracle.com>
 <20180209171231.GB6970@localhost.localdomain>
 <de6fd2ac-fc69-1b3b-c206-7abfce24ac70@oracle.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <1aa130e6-a1ff-bd17-a141-1a52f596dd8b@oracle.com>
Date: Sat, 10 Feb 2018 10:59:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <de6fd2ac-fc69-1b3b-c206-7abfce24ac70@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8800 signatures=668666
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=962
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802100039
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith

On 02/10/2018 10:32 AM, jianchao.wang wrote:
> Hi Keith
> 
> Thanks for your kindly response here.
> That's really appreciated.
> 
> On 02/10/2018 01:12 AM, Keith Busch wrote:
>> On Fri, Feb 09, 2018 at 09:50:58AM +0800, jianchao.wang wrote:
>>>
>>> if we set NVME_REQ_CANCELLED and return BLK_EH_HANDLED as the RESETTING case,
>>> nvme_reset_work will hang forever, because no one could complete the entered requests.
>>
>> Except it's no longer in the "RESETTING" case since you added the
>> "CONNECTING" state, so that's already broken for other reasons...
>>
> 
> Yes, but as your patch, we have to fail the IOs and even kill the controller.
> In fact, up to nvme_wait_freeze in nvme_reset_work, the RECONNECTING state has been completed.
> We even could say it is in LIVE state. Maybe we should recover the controller again instead
> of fail the IOs and kill the controller.
> 
> On the other hand, can you share with me why we cannot use blk_set_preempt_only to replace
> blk_freeze_queue ? we just want to gate the new bios out of generic_make_request and we 
> needn't use the preempt requests.
> 
> Looking forward your advice and directive.

Avoid wait_freeze in nvme_reset_work should be a better way to fix this defect.

> 
> Thanks
> Jianchao
