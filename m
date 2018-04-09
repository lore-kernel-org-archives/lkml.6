Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754359AbeDITju (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 15:39:50 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35943 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754264AbeDITjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 15:39:44 -0400
X-Google-Smtp-Source: AIpwx49XGh1g00Mdj46GIRNLNcCJsA/T+k7sXpNbzpyLLIDaXLLqIuFquSUMGE4vRhLD7Rl3PhgpKQ==
Subject: Re: [PATCH] rapidio: use a reference count for struct mport_dma_req
To: Ioan Nicu <ioan.nicu.ext@nokia.com>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Barry Wood <barry.wood@idt.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Logan Gunthorpe <logang@deltatee.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Frank Kunz <frank.kunz@nokia.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-kernel@vger.kernel.org
References: <20180405203342.GA16191@nokia.com>
From: Alex Bounine <alex.bou9@gmail.com>
Message-ID: <2dbed6e5-2244-2de3-ad1a-9d010fa94b5e@gmail.com>
Date: Mon, 9 Apr 2018 15:39:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180405203342.GA16191@nokia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018-04-05 04:33 PM, Ioan Nicu wrote:
> Once the dma request is passed to the DMA engine, the DMA
> subsystem would hold a pointer to this structure and could
> call the completion callback after do_dma_request() has
> timed out.
> 
> The current code deals with this by putting timed out SYNC
> requests to a pending list and freeing them later, when the
> mport cdev device is released. But this still does not
> guarantee that the DMA subsystem is really done with those
> transfers, so in theory dma_xfer_callback/dma_req_free
> could be called after mport_cdev_release_dma and could
> potentially access already freed memory.
> 
> This patch simplifies the current handling by using a kref
> in the mport dma request structure, so that it gets freed
> only when nobody uses it anymore.
> 
> This also simplifies the code a bit, as FAF transfers are
> now handled in the same way as SYNC and ASYNC transfers.
> There is no need anymore for the pending list and for the
> dma workqueue which was used in case of FAF transfers, so
> we remove them both.
> 
> Signed-off-by: Ioan Nicu <ioan.nicu.ext@nokia.com>
> ---
>   drivers/rapidio/devices/rio_mport_cdev.c | 122 +++++--------------------------
>   1 file changed, 18 insertions(+), 104 deletions(-)

Acked-by: Alexandre Bounine <alex.bou9@gmail.com>
