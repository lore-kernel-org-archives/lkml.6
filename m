Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0267C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E99218E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfADSjw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:39:52 -0500
Received: from mga09.intel.com ([134.134.136.24]:64254 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbfADSjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 13:39:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 10:39:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,439,1539673200"; 
   d="scan'208";a="123321123"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga002.jf.intel.com with ESMTP; 04 Jan 2019 10:39:51 -0800
Received: from fmsmsx126.amr.corp.intel.com (10.18.125.43) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 4 Jan 2019 10:39:51 -0800
Received: from fmsmsx120.amr.corp.intel.com ([169.254.15.173]) by
 FMSMSX126.amr.corp.intel.com ([169.254.1.70]) with mapi id 14.03.0415.000;
 Fri, 4 Jan 2019 10:39:51 -0800
From:   "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To:     YueHaibing <yuehaibing@huawei.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
Subject: RE: [PATCH -next] IB/qib: Add missing err handle for
 qib_user_sdma_rb_insert
Thread-Topic: [PATCH -next] IB/qib: Add missing err handle for
 qib_user_sdma_rb_insert
Thread-Index: AQHUmNOvcZQ8BMdw/0ODfWARf0srbKWfhbFQ
Date:   Fri, 4 Jan 2019 18:39:50 +0000
Message-ID: <32E1700B9017364D9B60AED9960492BC70C11891@fmsmsx120.amr.corp.intel.com>
References: <20181221021938.13784-1-yuehaibing@huawei.com>
In-Reply-To: <20181221021938.13784-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjE0YjYzNjgtYmNlNS00ZWMwLWFkYWYtZmFjZjA0MTRkYzE0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUEoydDdic0tkTGZ3NXV4ajFkSlAwNDBWbGU3VFpyTlBZMnYzbE5Nd0xYWU1kejduT0JhNW84YTVscisyelB5YSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.1.200.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/drivers/infiniband/hw/qib/qib_user_sdma.c
> b/drivers/infiniband/hw/qib/qib_user_sdma.c
> index 31c523b..e87c0a7 100644
> --- a/drivers/infiniband/hw/qib/qib_user_sdma.c
> +++ b/drivers/infiniband/hw/qib/qib_user_sdma.c
> @@ -237,6 +237,8 @@ qib_user_sdma_queue_create(struct device *dev,
> int unit, int ctxt, int sctxt)
> 
>  		ret = qib_user_sdma_rb_insert(&qib_user_sdma_rb_root,
>  					sdma_rb_node);
> +		if (ret == 0)
> +			goto err_rb;
>  	}
>  	pq->sdma_rb_node = sdma_rb_node;
> 
> --
> 2.7.0
> 

Thanks!

This patch is ok.

The NULL returned from this routine will result in an error return up to PSM which will fail.

The bail branch will do the necessary cleanup, including freeing the node that couldn't be added.

Acked-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
