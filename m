Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752809AbeDRSvh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 14:51:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:47333 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752166AbeDRSvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 14:51:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,466,1517904000";
   d="scan'208";a="38491060"
From: "Weiny, Ira" <ira.weiny@intel.com>
To: =?utf-8?B?SMOla29uIEJ1Z2dl?= <Haakon.Bugge@oracle.com>,
        Doug Ledford <dledford@redhat.com>, "Hiatt, Don" <don.hiatt@intel.com>,
        "Dasaratharaman Chandramouli" <dasaratharaman.chandramouli@intel.com>,
        "Hefty, Sean" <sean.hefty@intel.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] IB/core: Make ib_mad_client_id atomic
Thread-Topic: [PATCH] IB/core: Make ib_mad_client_id atomic
Thread-Index: AQHT1yEVepSwssTlDUySP6Lhu4WvI6QG3YHQ
Date: Wed, 18 Apr 2018 18:51:29 +0000
Message-ID: <2807E5FD2F6FDA4886F6618EAC48510E67DF2158@CRSMSX101.amr.corp.intel.com>
References: <20180418142450.15581-1-Haakon.Bugge@oracle.com>
In-Reply-To: <20180418142450.15581-1-Haakon.Bugge@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzgzZTM0NGYtM2ZlYS00YTNlLWE0NzEtOTE2YjE5M2Q1YjU2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6IjNyVUwrV2Y2cG1KU3hqY2FYNHFVVkdyMFZxWlFCaUJreEFwcmZRV2t5TTA9In0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3IIphFJ025746

> 
> Two kernel threads may get the same value for agent.hi_tid, if the agents are
> registered for different ports. As of now, this works, as the agent list is per port.
> 
> It is however confusing and not future robust. Hence, making it atomic.
> 
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> Reviewed-by: Jack Morgenstein <jackm@dev.mellanox.co.il>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/infiniband/core/mad.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c index
> c50596f7f98a..b28452a55a08 100644
> --- a/drivers/infiniband/core/mad.c
> +++ b/drivers/infiniband/core/mad.c
> @@ -59,7 +59,7 @@ module_param_named(recv_queue_size, mad_recvq_size,
> int, 0444);  MODULE_PARM_DESC(recv_queue_size, "Size of receive queue in
> number of work requests");
> 
>  static struct list_head ib_mad_port_list;
> -static u32 ib_mad_client_id = 0;
> +static atomic_t ib_mad_client_id = ATOMIC_INIT(0);
> 
>  /* Port list lock */
>  static DEFINE_SPINLOCK(ib_mad_port_list_lock);
> @@ -377,7 +377,7 @@ struct ib_mad_agent *ib_register_mad_agent(struct
> ib_device *device,
>  	}
> 
>  	spin_lock_irqsave(&port_priv->reg_lock, flags);
> -	mad_agent_priv->agent.hi_tid = ++ib_mad_client_id;
> +	mad_agent_priv->agent.hi_tid =
> atomic_inc_return(&ib_mad_client_id);
> 
>  	/*
>  	 * Make sure MAD registration (if supplied)
> --
> 2.13.6
