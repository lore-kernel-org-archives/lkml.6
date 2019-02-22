Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888F3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1D6206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfBVROj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:14:39 -0500
Received: from opengridcomputing.com ([72.48.214.68]:36764 "EHLO
        smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725832AbfBVROi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 12:14:38 -0500
Received: from [10.10.0.239] (cody.ogc.int [10.10.0.239])
        by smtp.opengridcomputing.com (Postfix) with ESMTPSA id E487F22775;
        Fri, 22 Feb 2019 11:14:37 -0600 (CST)
Subject: Re: [PATCH] RDMA/cma: Make CM response timeout and # CM retries
 configurable
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?H=c3=a5kon_Bugge?= <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190217170909.1178575-1-haakon.bugge@oracle.com>
 <20190222163637.GA9819@ziepe.ca>
From:   Steve Wise <swise@opengridcomputing.com>
Message-ID: <afadc799-b547-5c20-64d2-75fa0f64cd9e@opengridcomputing.com>
Date:   Fri, 22 Feb 2019 11:14:44 -0600
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190222163637.GA9819@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/22/2019 10:36 AM, Jason Gunthorpe wrote:
> On Sun, Feb 17, 2019 at 06:09:09PM +0100, Håkon Bugge wrote:
>> During certain workloads, the default CM response timeout is too
>> short, leading to excessive retries. Hence, make it configurable
>> through sysctl. While at it, also make number of CM retries
>> configurable.
>>
>> The defaults are not changed.
>>
>> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
>>  drivers/infiniband/core/cma.c | 51 ++++++++++++++++++++++++++++++-----
>>  1 file changed, 44 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
>> index c43512752b8a..ce99e1cd1029 100644
>> +++ b/drivers/infiniband/core/cma.c
>> @@ -43,6 +43,7 @@
>>  #include <linux/inetdevice.h>
>>  #include <linux/slab.h>
>>  #include <linux/module.h>
>> +#include <linux/sysctl.h>
>>  #include <net/route.h>
>>  
>>  #include <net/net_namespace.h>
>> @@ -68,13 +69,46 @@ MODULE_AUTHOR("Sean Hefty");
>>  MODULE_DESCRIPTION("Generic RDMA CM Agent");
>>  MODULE_LICENSE("Dual BSD/GPL");
>>  
>> -#define CMA_CM_RESPONSE_TIMEOUT 20
>>  #define CMA_QUERY_CLASSPORT_INFO_TIMEOUT 3000
>> -#define CMA_MAX_CM_RETRIES 15
>>  #define CMA_CM_MRA_SETTING (IB_CM_MRA_FLAG_DELAY | 24)
>>  #define CMA_IBOE_PACKET_LIFETIME 18
>>  #define CMA_PREFERRED_ROCE_GID_TYPE IB_GID_TYPE_ROCE_UDP_ENCAP
>>  
>> +#define CMA_DFLT_CM_RESPONSE_TIMEOUT 20
>> +static int cma_cm_response_timeout = CMA_DFLT_CM_RESPONSE_TIMEOUT;
>> +static int cma_cm_response_timeout_min = 8;
>> +static int cma_cm_response_timeout_max = 31;
>> +#undef CMA_DFLT_CM_RESPONSE_TIMEOUT
>> +
>> +#define CMA_DFLT_MAX_CM_RETRIES 15
>> +static int cma_max_cm_retries = CMA_DFLT_MAX_CM_RETRIES;
>> +static int cma_max_cm_retries_min = 1;
>> +static int cma_max_cm_retries_max = 100;
>> +#undef CMA_DFLT_MAX_CM_RETRIES
>> +
>> +static struct ctl_table_header *cma_ctl_table_hdr;
>> +static struct ctl_table cma_ctl_table[] = {
>> +	{
>> +		.procname	= "cma_cm_response_timeout",
>> +		.data		= &cma_cm_response_timeout,
>> +		.maxlen		= sizeof(cma_cm_response_timeout),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dointvec_minmax,
>> +		.extra1		= &cma_cm_response_timeout_min,
>> +		.extra2		= &cma_cm_response_timeout_max,
>> +	},
>> +	{
>> +		.procname	= "cma_max_cm_retries",
>> +		.data		= &cma_max_cm_retries,
>> +		.maxlen		= sizeof(cma_max_cm_retries),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dointvec_minmax,
>> +		.extra1		= &cma_max_cm_retries_min,
>> +		.extra2		= &cma_max_cm_retries_max,
>> +	},
>> +	{ }
>> +};
> Is sysctl the right approach here? Should it be rdma tool instead?
>
> Jason

There are other rdma sysctls currently:  net.rdma_ucm.max_backlog and
net.iw_cm.default_backlog.  The core network stack seems to use sysctl
and not ip tool to set basically globals.

To use rdma tool, we'd have to have some concept of a "module" object, I
guess.  IE there's dev, link, and resource rdma tool objects currently. 
But these cma timeout settings are really not per dev, link, nor a
resource.   Maybe we have just a "core" object:  rdma core set
cma_max_cm_retries min 8 max 30.



