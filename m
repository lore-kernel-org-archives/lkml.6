Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752619AbeA3Dlu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 22:41:50 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:42362 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752186AbeA3Dlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 22:41:49 -0500
Subject: Re: [PATCH] nvme-pci: use NOWAIT flag for nvme_set_host_mem
To: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>
Cc: axboe@fb.com, hch@lst.de, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1517195255-21832-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180129160145.GA25515@localhost.localdomain>
 <1b7d3700-945f-9272-b6aa-d2ebeaf0cb1e@grimberg.me>
 <20180129201716.GB25515@localhost.localdomain>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <c3116e1b-481a-1b3f-b29c-7de95929ecb8@oracle.com>
Date: Tue, 30 Jan 2018 11:41:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180129201716.GB25515@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8789 signatures=668655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=854
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1801300046
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith and Sagi

Thanks for your kindly response. :)

On 01/30/2018 04:17 AM, Keith Busch wrote:
> On Mon, Jan 29, 2018 at 09:55:41PM +0200, Sagi Grimberg wrote:
>>> Thanks for the fix. It looks like we still have a problem, though.
>>> Commands submitted with the "shutdown_lock" held need to be able to make
>>> forward progress without relying on a completion, but this one could
>>> block indefinitely.
>>
>> Can you explain to me why is the shutdown_lock needed to synchronize
>> nvme_dev_disable? More concretely, how is nvme_dev_disable different
>> from other places where we rely on the ctrl state to serialize stuff?
>>
>> The only reason I see would be to protect against completion-after-abort
>> scenario but I think the block layer should protect against it (checks
>> if the request timeout timer fired).
> 
> We can probably find a way to use the state machine for this. Disabling
> the controller pre-dates the state machine, and the mutex is there to
> protect against two actors shutting the controller down at the same
> time, like a hot removal at the same time as a timeout handling reset.
> 

Another point that confuses me is that whether nvme_set_host_mem is necessary
in nvme_dev_disable ?
As the comment:
----
		/*
		 * If the controller is still alive tell it to stop using the
		 * host memory buffer.  In theory the shutdown / reset should
		 * make sure that it doesn't access the host memoery anymore,
		 * but I'd rather be safe than sorry..
		 */
		if (dev->host_mem_descs)
			nvme_set_host_mem(dev, 0);
----
It is to avoid accessing to host memory from controller. But the host memory is just
freed when nvme_remove. It looks like we just need to do this in nvme_remove.
For example:
-----
@@ -2553,6 +2545,14 @@ static void nvme_remove(struct pci_dev *pdev)
        flush_work(&dev->ctrl.reset_work);
        nvme_stop_ctrl(&dev->ctrl);
        nvme_remove_namespaces(&dev->ctrl);
+       /*
+        * If the controller is still alive tell it to stop using the
+        * host memory buffer.  In theory the shutdown / reset should
+        * make sure that it doesn't access the host memoery anymore,
+        * but I'd rather be safe than sorry..
+        */
+       if (dev->host_mem_descs)
+               nvme_set_host_mem(dev, 0);
        nvme_dev_disable(dev, true);
        nvme_free_host_mem(dev);
----

If anything missed, please point out.
That's really appreciated.

Sincerely
Jianchao
