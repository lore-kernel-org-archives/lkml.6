Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752468AbeBFBrE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 20:47:04 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58080 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbeBFBq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 20:46:58 -0500
Subject: Re: [PATCH 2/6] nvme-pci: fix the freeze and quiesce for shutdown and
 reset case
To: Keith Busch <keith.busch@intel.com>
Cc: axboe@fb.com, linux-kernel@vger.kernel.org, hch@lst.de,
        linux-nvme@lists.infradead.org, sagi@grimberg.me
References: <1517554849-7802-1-git-send-email-jianchao.w.wang@oracle.com>
 <1517554849-7802-3-git-send-email-jianchao.w.wang@oracle.com>
 <20180202182413.GH24417@localhost.localdomain>
 <d93d115b-bdb1-24c0-71be-72f1b7563e5a@oracle.com>
 <20180205151314.GP24417@localhost.localdomain>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <d218f5f5-45f7-6036-00a5-48769101080f@oracle.com>
Date: Tue, 6 Feb 2018 09:46:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180205151314.GP24417@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8796 signatures=668662
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802060018
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith

Thanks for your kindly response.

On 02/05/2018 11:13 PM, Keith Busch wrote:
>  but how many requests are you letting enter to their demise by
> freezing on the wrong side of the reset?

There are only two difference with this patch from the original one.
1. Don't freeze the queue for the reset case. At the moment, the outstanding requests will be requeued back to blk-mq queues.
   The new entered requests during reset will also stay in blk-mq queues. All this requests will not enter into nvme driver layer
   due to quiescent request_queues. And they will be issued after the reset is completed successfully.
2. Drain the request queue before nvme_dev_disable. This is nearly same with the previous rule which will also unquiesce the queue
   and let the requests be able to be drained. The only difference is this patch will invoke wait_freeze in nvme_dev_disable instead
   of nvme_reset_work.

We don't sacrifice any request. This patch do the same thing with the previous one and make things clearer.
:)


Thanks
Jianchao
