Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753267AbeBKLgp (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 06:36:45 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35163 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752460AbeBKLgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 06:36:44 -0500
X-Google-Smtp-Source: AH8x225+WGXbbKHW4rm5pm78vuLncdP1GSy7mLI4KS4OJyiDx/FbSB4W6s9U39AK4w6enWwQxUugCA==
Subject: Re: [PATCH 8/9] nvme-pci: break up nvme_timeout and nvme_dev_disable
To: Jianchao Wang <jianchao.w.wang@oracle.com>, keith.busch@intel.com,
        axboe@fb.com, hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
 <1518341920-1060-9-git-send-email-jianchao.w.wang@oracle.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4f2268ba-6b6a-8273-594c-b63fdb7b6a96@grimberg.me>
Date: Sun, 11 Feb 2018 13:36:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518341920-1060-9-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jianchao,

> Currently, the complicated relationship between nvme_dev_disable
> and nvme_timeout has become a devil that will introduce many
> circular pattern which may trigger deadlock or IO hang. Let's
> enumerate the tangles between them:
>   - nvme_timeout has to invoke nvme_dev_disable to stop the
>     controller doing DMA access before free the request.
>   - nvme_dev_disable has to depend on nvme_timeout to complete
>     adminq requests to set HMB or delete sq/cq when the controller
>     has no response.
>   - nvme_dev_disable will race with nvme_timeout when cancels the
>     previous outstanding requests.
> 2nd case is necessary. This patch is to break up 1st and 3th case.
> 
> To achieve this:
> Use blk_abort_request to force all the previous outstanding requests
> expired in nvme_dev_disable. Set NVME_REQ_CANCELLED and return
> BLK_EH_NOT_HANDLED in nvme_timeout. Then the request will not be
> completed and freed. We needn't invoke nvme_dev_disable any more.
> 
> We use NVME_REQ_CANCELLED to identify them. After the controller is
> totally disabled/shutdown, we invoke blk_mq_rq_update_aborted_gstate
> to clear requests and invoke blk_mq_complete_request to complete them.
> In addition, to identify the previous adminq/IOq request and adminq
> requests from nvme_dev_disable, we introduce
> NVME_PCI_OUTSTANDING_GRABBING and NVME_PCI_OUTSTANDING_GRABBED to
> let nvme_timeout be able to distinguish them.
> 
> For the adminq requests from nvme_dev_disable/nvme_reset_work:
> invoke nvme_disable_ctrl directly, then set NVME_REQ_CANCELLED and
> return BLK_EH_HANDLED. nvme_dev_disable/nvme_reset_work will
> see the error.

I think this is going in the wrong direction. Every state that is needed
to handle serialization should be done in core ctrl state. Moreover,
please try to avoid handling this locally in nvme-pci, place common
helpers in nvme-core and use them. I won't be surprised if fc would
need some of these.

Also, can we try and not disable the controller from nvme_timeout? I'm
not sure I understand why is this needed at all. What's wrong with
scheduling a controller reset/delete? Why is something like
nvme_pci_disable_ctrl_directly needed?

I'd like to see an effort to consolidate error handling paths rather
than enhancing the current skew...
