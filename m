Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752259AbeBECXL (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 21:23:11 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48310 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751991AbeBECXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 21:23:08 -0500
Subject: Re: [PATCH 4/6] nvme-pci: break up nvme_timeout and nvme_dev_disable
To: Keith Busch <keith.busch@intel.com>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1517554849-7802-1-git-send-email-jianchao.w.wang@oracle.com>
 <1517554849-7802-5-git-send-email-jianchao.w.wang@oracle.com>
 <20180202183103.GI24417@localhost.localdomain>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <584a703f-98e9-a07b-ad44-6fa51b119c02@oracle.com>
Date: Mon, 5 Feb 2018 10:22:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180202183103.GI24417@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8795 signatures=668662
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=765
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802050029
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith

Thanks for you kindly response and comment.
That's really appreciated.

On 02/03/2018 02:31 AM, Keith Busch wrote:
> On Fri, Feb 02, 2018 at 03:00:47PM +0800, Jianchao Wang wrote:
>> Currently, the complicated relationship between nvme_dev_disable
>> and nvme_timeout has become a devil that will introduce many
>> circular pattern which may trigger deadlock or IO hang. Let's
>> enumerate the tangles between them:
>>  - nvme_timeout has to invoke nvme_dev_disable to stop the
>>    controller doing DMA access before free the request.
>>  - nvme_dev_disable has to depend on nvme_timeout to complete
>>    adminq requests to set HMB or delete sq/cq when the controller
>>    has no response.
>>  - nvme_dev_disable will race with nvme_timeout when cancels the
>>    outstanding requests.
> 
> Your patch is releasing a command back to the OS with the
> PCI controller bus master still enabled. This could lead to data or
> memory corruption.
> 

There are two cases nvme_timeout will return.
BLK_EH_HANDLED
BLK_EH_NOT_HANDLED

For the 1st case, the patch will disable the controller.
Then the controller will stop processing any outstanding command and delete the sq/cq queues as the protocol.
Looks like it is still not enough, I will to disable the _pci_in nvme_pci_disable_dev_directly next version. 
Really thanks for your directive here.

For the 2nd case, it will return BLK_EH_NOT_HANDLED.
blk_mq_rq_timed_out will do nothing for this case.
All the command will be handled after all the things are disabled.

> In any case, it's not as complicated as you're making it out to
> be. It'd be easier to just enforce the exisiting rule that commands
> issued in the disabling path not depend on completions or timeout
> handling. All of commands issued in this path already do this except
> for HMB disabling. Let'sjust fix that command, right?
> 
We will still met nvme_timeout will invoke nvme_dev_disable and cannot synchronize on the outstanding
requests. This is really a devil and will be a block to do other improvements.
This patch just do two things:
1. grab all the previous outstanding requests with blk_abort_request. Then release them after the controller is totally disabled/shutdown.
   consequently, during the disable/shutdown and initializing procedure, nvme_timeout path only need to serve them. And this also could
   ensure there will be _no_ any outstanding requests after nvme_dev_disable.
2. fail the adminq command issued during disable/shutdown and initializing procedure when the controller no response. we need to do two 
   steps for this, disable the controller/pci and complete the command. Then nvme_timeout will not need to invoke nvme_dev_disable and nvme_dev_disable
   will be independent.
 
Please consider this.

Many thanks
Jianchao
