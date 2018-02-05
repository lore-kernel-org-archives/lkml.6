Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752381AbeBEC0b (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 21:26:31 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:52380 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752166AbeBEC0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 21:26:23 -0500
Subject: Re: [PATCH 2/6] nvme-pci: fix the freeze and quiesce for shutdown and
 reset case
To: Keith Busch <keith.busch@intel.com>
Cc: axboe@fb.com, linux-kernel@vger.kernel.org, hch@lst.de,
        linux-nvme@lists.infradead.org, sagi@grimberg.me
References: <1517554849-7802-1-git-send-email-jianchao.w.wang@oracle.com>
 <1517554849-7802-3-git-send-email-jianchao.w.wang@oracle.com>
 <20180202182413.GH24417@localhost.localdomain>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <d93d115b-bdb1-24c0-71be-72f1b7563e5a@oracle.com>
Date: Mon, 5 Feb 2018 10:26:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180202182413.GH24417@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8795 signatures=668662
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802050029
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith

Thanks for your kindly response.

On 02/03/2018 02:24 AM, Keith Busch wrote:
> On Fri, Feb 02, 2018 at 03:00:45PM +0800, Jianchao Wang wrote:
>> Currently, request queue will be frozen and quiesced for both reset
>> and shutdown case. This will trigger ioq requests in RECONNECTING
>> state which should be avoided to prepare for following patch.
>> Just freeze request queue for shutdown case and drain all the resudual
>> entered requests after controller has been shutdown.

> Freezing is not just for shutdown. It's also used so
> blk_mq_update_nr_hw_queues will work if the queue count changes across
> resets.
blk_mq_update_nr_hw_queues will freeze the queue itself. Please refer to.
static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
							int nr_hw_queues)
{
	struct request_queue *q;

	lockdep_assert_held(&set->tag_list_lock);

	if (nr_hw_queues > nr_cpu_ids)
		nr_hw_queues = nr_cpu_ids;
	if (nr_hw_queues < 1 || nr_hw_queues == set->nr_hw_queues)
		return;

	list_for_each_entry(q, &set->tag_list, tag_set_list)
		blk_mq_freeze_queue(q);

	set->nr_hw_queues = nr_hw_queues;
	blk_mq_update_queue_map(set);
	list_for_each_entry(q, &set->tag_list, tag_set_list) {
		blk_mq_realloc_hw_ctxs(set, q);
		blk_mq_queue_reinit(q);
	}

	list_for_each_entry(q, &set->tag_list, tag_set_list)
		blk_mq_unfreeze_queue(q);
}

Thanks
Jianchao
