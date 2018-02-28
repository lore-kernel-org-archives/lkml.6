Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbeB1AVI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 19:21:08 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:61211 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751304AbeB1AVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 19:21:05 -0500
X-IronPort-AV: E=Sophos;i="5.47,403,1515427200";
   d="scan'208";a="168917285"
Subject: Re: [PATCH] RDMA/core: reduce IB_POLL_BATCH constant
To: Max Gurtovoy <maxg@mellanox.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Sagi Grimberg <sagi@grimberg.me>
Cc: Chuck Lever <chuck.lever@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "leonro@mellanox.com" <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20180220205924.2035765-1-arnd@arndb.de>
 <1519161268.3737.12.camel@wdc.com>
 <F2FB1034-BFB6-45ED-878E-6FADD756157D@oracle.com>
 <c3eab137-1c37-0e6c-a53a-df2cf80653d2@grimberg.me>
 <0f90134c-3d40-1d24-711f-e4ab32802bd8@mellanox.com>
 <c1bcd5cc-381d-2d94-1278-f9fb5c9c0b14@grimberg.me>
 <20180227220958.GA21714@ziepe.ca>
 <193aaf91-c9d1-38b1-a89f-45f129ca5798@mellanox.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <d2875648-20d9-43b9-abf1-8ecbf049c4bf@wdc.com>
Date: Tue, 27 Feb 2018 16:21:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <193aaf91-c9d1-38b1-a89f-45f129ca5798@mellanox.com>
Content-Type: text/plain; charset=windows-1255; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/27/18 14:15, Max Gurtovoy wrote:
> -static int __ib_process_cq(struct ib_cq *cq, int budget, struct ib_wc 
> *poll_wc)
> +static int __ib_process_cq(struct ib_cq *cq, int budget, struct ib_wc 
> *poll_wc,
> +                          int batch)
>   {
> -       int i, n, completed = 0;
> -       struct ib_wc *wcs = poll_wc ? : cq->wc;
> +       int i, n, ib_poll_batch, completed = 0;
> +       struct ib_wc *wcs;
> +
> +       if (poll_wc) {
> +               wcs = poll_wc;
> +               ib_poll_batch = batch;
> +       } else {
> +               wcs = cq->wc;
> +               ib_poll_batch = IB_POLL_BATCH;
> +       }

Since this code has to be touched I think that we can use this 
opportunity to get rid of the "poll_wc ? : cq->wc" conditional and 
instead use what the caller passes. That will require to update all 
__ib_process_cq(..., ..., NULL) calls. I also propose to let the caller 
pass ib_poll_batch instead of figuring it out in this function. 
Otherwise the approach of this patch looks fine to me.

Thanks,

Bart.
