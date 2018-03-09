Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751877AbeCIB7r (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 20:59:47 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58524 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbeCIB7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 20:59:45 -0500
Subject: Re: [PATCH V4 2/5] nvme: add helper interface to flush in-flight
 requests
To: Sagi Grimberg <sagi@grimberg.me>, keith.busch@intel.com, axboe@fb.com,
        hch@lst.de
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <1520489971-31174-1-git-send-email-jianchao.w.wang@oracle.com>
 <1520489971-31174-3-git-send-email-jianchao.w.wang@oracle.com>
 <931a03f8-9c8b-fec4-0f89-04321a906710@grimberg.me>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <35c68f2a-8198-7db6-c381-420ac996802a@oracle.com>
Date: Fri, 9 Mar 2018 09:59:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <931a03f8-9c8b-fec4-0f89-04321a906710@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8826 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803090023
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sagi

Thanks for your precious time for review and comment.

On 03/09/2018 02:21 AM, Sagi Grimberg wrote:

>> +EXPORT_SYMBOL_GPL(nvme_abort_requests_sync);
>> +
>> +static void nvme_comp_req(struct request *req, void *data, bool reserved)
> 
> Not a very good name...

Yes, indeed.

> 
>> +{
>> +    struct nvme_ctrl *ctrl = (struct nvme_ctrl *)data;
>> +
>> +    if (!test_bit(NVME_REQ_ABORTED, &nvme_req(req)->flags))
>> +        return;
>> +
>> +    WARN_ON(!blk_mq_request_started(req));
>> +
>> +    if (ctrl->tagset && ctrl->tagset->ops->complete) {
> 
> What happens when this called on the admin tagset when the controller
> does not have an io tagset?

Yes, nvme_ctrl.admin_tagset should be used here for adminq request.


> 
>> +        clear_bit(NVME_REQ_ABORTED, &nvme_req(req)->flags);
>> +        /*
>> +         * We set the status to NVME_SC_ABORT_REQ, then ioq request
>> +         * will be requeued and adminq one will be failed.
>> +         */
>> +        nvme_req(req)->status = NVME_SC_ABORT_REQ;
>> +        /*
>> +         * For ioq request, blk_mq_requeue_request should be better
>> +         * here. But the nvme code will still setup the cmd even if
>> +         * the RQF_DONTPREP is set. We have to use .complete to free
>> +         * the cmd and then requeue it.
> 
> IMO, its better to fix nvme to not setup the command if RQF_DONTPREP is on (other than the things it must setup).

Yes, I used to consider change that.
But I'm not sure whether there is special consideration there.
If you and Keith think it is ok that not setup command when RQF_DONTPREP is set, we could do that.

> 
>> +         *
>> +         * For adminq request, invoking .complete directly will miss
>> +         * blk_mq_sched_completed_request, but this is ok because we
>> +         * won't have io scheduler for adminq.
>> +         */
>> +        ctrl->tagset->ops->complete(req);
> 
> I don't think that directly calling .complete is a good idea...

Yes, indeed.

Thanks a lot 
Jianchao
