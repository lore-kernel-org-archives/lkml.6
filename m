Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752586AbeDSBvt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 21:51:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41474 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeDSBvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 21:51:47 -0400
Subject: Re: PATCH V4 0/5 nvme-pci: fixes on nvme_timeout and nvme_dev_disable
To: Ming Lei <ming.lei@redhat.com>
Cc: keith.busch@intel.com, sagi@grimberg.me, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, axboe@fb.com, hch@lst.de
References: <1520489971-31174-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180417151700.GC16286@ming.t460p>
 <a6e1de6d-6086-d467-d9ce-641bcd07b983@oracle.com>
 <20180418154032.GA22533@ming.t460p>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <2b985ef5-223f-6a11-45b4-e570c8a93bb3@oracle.com>
Date: Thu, 19 Apr 2018 09:51:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418154032.GA22533@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8867 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=857
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804190017
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming

Thanks for your kindly response.

On 04/18/2018 11:40 PM, Ming Lei wrote:
>> Regarding to this patchset, it is mainly to fix the dependency between
>> nvme_timeout and nvme_dev_disable, as your can see:
>> nvme_timeout will invoke nvme_dev_disable, and nvme_dev_disable have to
>> depend on nvme_timeout when controller no response.
> Do you mean nvme_disable_io_queues()? If yes, this one has been handled
> by wait_for_completion_io_timeout() already, and looks the block timeout
> can be disabled simply. Or are there others?
> 
Here is one possible scenario currently

nvme_dev_disable // hold shutdown_lock             nvme_timeout
  -> nvme_set_host_mem                               -> nvme_dev_disable
    -> nvme_submit_sync_cmd                            -> try to require shutdown_lock 
      -> __nvme_submit_sync_cmd
        -> blk_execute_rq
          //if sysctl_hung_task_timeout_secs == 0
          -> wait_for_completion_io
And maybe nvme_dev_disable need to issue other commands in the future.

Even if we could fix these kind of issues as nvme_disable_io_queues, 
it is still a risk I think.

Thanks
Jianchao
