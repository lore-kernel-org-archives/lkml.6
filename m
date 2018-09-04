Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA898C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858AB20645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="KVYEpa0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858AB20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeIDTm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:42:29 -0400
Received: from mail-eopbgr00074.outbound.protection.outlook.com ([40.107.0.74]:6976
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726015AbeIDTm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHaRxXCTRjudGKy77pOOXD/31WKZaABMLxlBx4vHOUA=;
 b=KVYEpa0gUkMaP1eQknHkuQ59xMvSeah8cNlJbGzKCgsSMK+JisVdyvOvTZuevAlHlF+83hfnliFRxhEVkOZNUlAFKUV2PU1/tzXKnoLX3nkobxyPnNI/bMDN7n2BEdVXqaR0SPprY/w/FrSHGCtz6rjQFXDvO7JSmcRHY5YMLRo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 AM0PR05MB4450.eurprd05.prod.outlook.com (2603:10a6:208:5a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.17; Tue, 4 Sep 2018 15:16:51 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@mellanox.com>)
        id 1fxD4I-0003HS-32; Tue, 04 Sep 2018 09:16:38 -0600
Date:   Tue, 4 Sep 2018 09:16:38 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH v5 10/13] nvme-pci: Add support for P2P memory in requests
Message-ID: <20180904151638.GL335@mellanox.com>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-11-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830185352.3369-11-logang@deltatee.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: CY4PR19CA0042.namprd19.prod.outlook.com
 (2603:10b6:903:103::28) To AM0PR05MB4450.eurprd05.prod.outlook.com
 (2603:10a6:208:5a::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48601582-2c46-4c78-d74c-08d6127970ba
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB4450;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;3:09Qq+d7d1qOWd+axK8l3K+GBSnObl0tmW2KWtLj+QrchqL5/BYQAsSbxKxnjWVXYyeOUKtzxCD/acqsNVwKqZx6bz3B4KYA3bOfYA1HU9+3DDiz24jK2YNK9cZjs4dguW1hsQPnwvkRBobsjhp08+opqdxviiGmnVIPL0momZIlnbo6mBjbn6uFMwR750L3de/0N1gu7ftk+/vv+dptz+tZRGHdD9bb6IVsrlco+2PzOXM361FZWmpCRy71pRV0u;25:O1iTsOJMqeaGH9SEh9uz9qvEaxHa2eJ5tGX9guDOuEhbiecWE9OCtHtHOT1c58a0PlpU3vIzLIswnhNZKSRP56LSGZsubC/D9lssOIDe08q73rXlbIsC6K2MzOCE2sR3CQ5QfP/lmsW8HT+zgCe1cXXxMoNHbyVFFOxFj0i9xVvTDBZoSSNmsZDcRd0VzdUkFbbkJBfLuQn6YWlvG/Fr3akJMyuuAeJkMZSbdt0GvtpuPLuKQA9JTQdZvj9AaHFd7iy5nrYgWr3BfSbZtEU/Tz5zisq6TTxJtZuOwxAsIOhNJ4KZeMxgP5tQowOkFf+k/8qLl66BKx8UwQKyEIuKpw==;31:91OKW1nGjZTNeVLVXpZMOfgaGVC3pTd3rQivvTnX5WznCnUR4HT9u5EOLrVX5elP/oKsqYs6d9W9beVtYAIU10O1i39opzaFzAkiZWIdd/QGuGxV79IzEux8HUGv/7VYgLmP7cahtXr1EpbOZmoW4JlC2ysVdHppGBRelmpwUupLhXFON+SK+8pHm3tCkfavvuOQyt5xkDCirTdNEe1kIHNLOXGAgze2xfdmzozVBs8=
X-MS-TrafficTypeDiagnostic: AM0PR05MB4450:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;20:53cRY8aWRqbz1yeLSTQDpRi5mO6QMvVVSFS4ufNvpGkGDl7xRmVQxSgC02epRWe5d47voVfHGzo6AdcCpnRYODFpPoNCZz763KFYxng0KBezUMjCGXcX/wxT7qdj/nxt1DGkg56/jlYmd2bAa16cIyMMtRW2xzwuBhhloQQkfvrTLDsBEAj21i/KrtDyzB3SayXrxYN+3Gof3Cb/uaWCD1ZaqIqzmq+3SFibX7jIxKPwgZ6XM2pI1if+ffc9DmAkC49z7NVpvQ460DXPfRl22LOnIf0N+SKzE0zzTbHUFzmofcdUNCN9vRPM3f/3I+9mjSj+cYuNWEjv0s5CA9RQOm/aNGXzNbJsJEREtV3Ex+acspHEvMaNh2rN8l/N0pLIENhgBJNM88ybRJikFZXLYXe/ecBwQVCN8QD8RvXHS2bbygin5EavvneDMsdj+03zWgGJlSnJhiJPGmmSv0/SvZOe/PrWAtB9JGdkkuP5IzZ0fICxxLIsATfDc9zv6BA7;4:dq8EfYl/CPpe5fyEzBPW5QRCZ+PzMY1f057k3xlfNF9/NspRsO5XkYKTyDeER/mxYS+09tyyWwzVuw+ysxgiL6FtQYR9KFw74oLROZikz9n2sgVPFjJ2Tv6B1HuREiAp4Hoxp5zcigybY9DjSNcP7ghgtjbfxtIZQMcoklGeDkpvN13C4Nu1AgY0zEOf3pufJq+oiTF7cuJhJrqjja3lYiBntsU1slxlI300s/wgl2MlMLMe+o8LN0SGv3o8i1gOuU/l7+cg+7XkN06wppiBCQ==
X-Microsoft-Antispam-PRVS: <AM0PR05MB4450114B6BE1DC9D0E90735DCF030@AM0PR05MB4450.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699016);SRVR:AM0PR05MB4450;BCL:0;PCL:0;RULEID:;SRVR:AM0PR05MB4450;
X-Forefront-PRVS: 0785459C39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(366004)(396003)(189003)(199004)(9746002)(122856001)(9786002)(4326008)(23726003)(6246003)(68736007)(229853002)(8676002)(7416002)(6916009)(5660300001)(53936002)(476003)(186003)(386003)(2616005)(446003)(11346002)(86362001)(50466002)(8936002)(33656002)(26005)(1076002)(6116002)(3846002)(486006)(36756003)(7736002)(106356001)(105586002)(83796002)(52116002)(81156014)(57986006)(14444005)(69596002)(316002)(2906002)(66066001)(16586007)(305945005)(478600001)(54906003)(58126008)(81166006)(76176011)(97736004)(47776003)(46656002)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4450;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR05MB4450;23:zoHgLmquERkRaiSMz+XVEsbNJtw/9JTpay2hdJzly?=
 =?us-ascii?Q?U9jZK08wDA7bfrxUdUJy7IG6nLBr3fc3C9Gj+csVz/3KygBC3GRw8kJfunlV?=
 =?us-ascii?Q?FYB2weW/fIsuvReXcdIA1JTPEbhv/7pc6lSkpwDioWAY0kxngWkYcHXWZKnh?=
 =?us-ascii?Q?XqyekhJxM5+ufT9ounwsbYkYwMseZE7Uoz/+aDLjoCFfR+jNFLIQlTQqegYS?=
 =?us-ascii?Q?MAN1+Gj3S9qXe/M9L+yIctS02loYIstqZBq5lquTAZ3cqMZ0AHMcQ9rAZ997?=
 =?us-ascii?Q?jtJJgt7gSYgyvf4FYdMxVjRAFSu9E2ofCJO0VmUekX1izkezkXfVhC0YSpTz?=
 =?us-ascii?Q?Lv+GTxVBj0FUh1Qatr5kz7kpS7Pd5Nkg8jsw6jD4cEdhqIhNRX4WfLeTduaQ?=
 =?us-ascii?Q?nWPptUjJEAWkT/C12G2gFWtqBg9Q7/0dXjDYC+cVKMR7zvjJ6ev7U/HbdnbL?=
 =?us-ascii?Q?3aQvlrui7RUsF5DEpWjKYALpVoM9Bh/iof0mOBkHOCwqPx93bHcKuNZXjq34?=
 =?us-ascii?Q?8vQAASbn3BYd14QDMe9H5ZkEetrP7tjXSXF85eqcRmSyD6tFGonDQVH1OZnp?=
 =?us-ascii?Q?PZIzjcz2cpPDW9dTy0S9Y2qVXMeqV139J4j6aL4eTQBE9+D3Mn7Gv4Ic1fDO?=
 =?us-ascii?Q?/VcdPtUAD1TOS4lKoDJirvUicxMoAlpGUVetD1nBROVHnCuFCHsL513hKGJ4?=
 =?us-ascii?Q?RnEw6U8pGHvTVuZlba9mLkF1DY2VIhLkf9Y5jc8ENhOTbQPmbDqJScI64FXh?=
 =?us-ascii?Q?+Rr5tkx3sOV73uxEsmZo2pleDxwo6j+nq4mhNzkFyyJ8UDxtrABeJ3OmSA+r?=
 =?us-ascii?Q?3vDEiano7xD//mu6F7PfTrNrGQJCX/iLLSkBQLIeSjzpxV3TdNOf/6scVhHP?=
 =?us-ascii?Q?5u3pOOaaUXHUSi9lohJTRvaRfDF52pndr2rH/J9IZ/Lk9siLUx/cNH9Dz/jt?=
 =?us-ascii?Q?qONja/132mjcAzEASJlOpjHGpSBgcyn9KdSdUaEGj6N9edVyKEInpJCleYQp?=
 =?us-ascii?Q?Pn+6c0PrkOKDE67LMVsPx9lDZVk8jUuvn7tIAqYXemN75Mqe/1C/dzppGwjE?=
 =?us-ascii?Q?fRLiKUtoFRcd7M1m6QHYDuNK31y48ZfYU0xhBbq3RlgAjNvhq0D9RvGrjFBd?=
 =?us-ascii?Q?mFJhlRIzdyRlEH4+sZVDzU2mtoffoOZWsP8MfnLbYA9erMquQ2ssp8YU6CTL?=
 =?us-ascii?Q?mOBeCi4kx9iQJ0rizNh+TD6hvDRbq1BW9MUuJMuMOtlZ3BDbVvTRaEinLI9y?=
 =?us-ascii?Q?/hlVtX2biuSAqlfSazflDfzxLCxtGK65IHpiZ7RJPV8tQQVOdwA5KtU5Lqw1?=
 =?us-ascii?Q?OJyMg5t1vogG94AMQK7d0sUX9nmsB6vsayCCMGLChPRv06Ve4oIrXQeadbHZ?=
 =?us-ascii?Q?Os/TLKdBWXRpDjq+Tv108FAAhY=3D?=
X-Microsoft-Antispam-Message-Info: FZPe5R91JI6XXARpFtfFf954pQvlhPEnOzMTbLA1BBmzAB3KrnKTb2lOzKR5scQdH8Gtuu9mWmhAOACNytV4YkW3dTgml12U6sHavwYhgo3v5vAI0J0wQ/G1TzfMSZzWIsaREvVo86ZZ38M9qA6L8FMKYteTqxZL6uN8YF5zZ3EhxV0Yjz1WdU7fcfwb/c5uHjEEopapMmPZsfTNDDWf3kA7qT6Z215Sm0XCPl9n0NZ2yhhKcAev5Vyd/+BVMf2m8fO0JbPiseDEwLuaTg7MdfCV7EiXWtN4LqWjzsEpWUX6qgTXdgU9GFcyBWBkmvpxwrt81oqX9v6EEEp/RkUtNxgOobnP0M8/d5XeaslB8hY=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR05MB4450;6:vmNBoYRfBj1AKx8onvSgS6xl417ZvH/7OItw/sWjO/9NY4FnhJNE6QVoglqYWvJMYiigPvBN3gMm3ib8iiT555SfVmTYIYYbXTXig/cb7ya5QCiw8Kgen4sMehPAis4WiqZyGXVt1lfZnm0W+WdUTZgD2xT96xjawwxv3Zm2XIJ1zzG//lVtnY3yNBPjDWHucil+vJjcUWOvW0ecA/s+2EBX/Ec+pRhzzfXiBt0+pFe+p0YBQDH3jB3kLBjoX7Ed8HBvhronehyFx6JUXfs9LoBeffULYU/SLSDPxWd2NkO8JVTmT4lUaoiLe0xd0pXSpKcyybSTXK/G1HgI+rCzyZlFI5MvwMCCvZQAM+vTZHAF00/QqVWohMpbiJq+skT2Pb2bsTLEnAalVvkt3OLOisnapVS2ICPaVTepktnDWSe/L5xHCUvx9aPl18Kho25ZxuZEK7rH2eufYv5AyVaIgQ==;5:ZPjpBH2qJI2BKodEgwkGhdZvpYsa3ttPby975FuxN2pm5wZbXuKi6x50K6qfv43W7BhNDBkOrSTol1CGr7tE46d5697GeeyHZ2HFFvkXw3zbJ1q5wdBACTWfCwP77w1Eidbe9QBgtqToEFml71QAfWIjP66C8aJOuHaJSE2BIzc=;7:JTDnaqbKMRr3z3veSH/MRSlelk+Lwxd6/JGIQ8n9OgsP0FJI5FbDjmLzvjB7HT+Bl5RZv4YsarNKt3cZUSVnlwn/EYLQUn4wci9u8lSW5xsXy5ybD1VD44gIO/hE4PCcntSuqlyxe8D4vxAcLFWcD1OqgotJtc92tukpF3ZjtZ6y+3WmyHJ37fdVEgV7HUX9yWE7yb2vcrLHKyg8wYG0AJgZBPEdbITbCP9TsDAd+6PaS6raJNZx5WPaG4Wm8FZQ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2018 15:16:51.1099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48601582-2c46-4c78-d74c-08d6127970ba
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4450
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 12:53:49PM -0600, Logan Gunthorpe wrote:
> For P2P requests, we must use the pci_p2pmem_map_sg() function
> instead of the dma_map_sg functions.
> 
> With that, we can then indicate PCI_P2P support in the request queue.
> For this, we create an NVME_F_PCI_P2P flag which tells the core to
> set QUEUE_FLAG_PCI_P2P in the request queue.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>  drivers/nvme/host/core.c |  4 ++++
>  drivers/nvme/host/nvme.h |  1 +
>  drivers/nvme/host/pci.c  | 17 +++++++++++++----
>  3 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index dd8ec1dd9219..6033ce2fd3e9 100644
> +++ b/drivers/nvme/host/core.c
> @@ -3051,7 +3051,11 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  	ns->queue = blk_mq_init_queue(ctrl->tagset);
>  	if (IS_ERR(ns->queue))
>  		goto out_free_ns;
> +
>  	blk_queue_flag_set(QUEUE_FLAG_NONROT, ns->queue);
> +	if (ctrl->ops->flags & NVME_F_PCI_P2PDMA)
> +		blk_queue_flag_set(QUEUE_FLAG_PCI_P2PDMA, ns->queue);
> +
>  	ns->queue->queuedata = ns;
>  	ns->ctrl = ctrl;
>  
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index bb4a2003c097..4030743c90aa 100644
> +++ b/drivers/nvme/host/nvme.h
> @@ -343,6 +343,7 @@ struct nvme_ctrl_ops {
>  	unsigned int flags;
>  #define NVME_F_FABRICS			(1 << 0)
>  #define NVME_F_METADATA_SUPPORTED	(1 << 1)
> +#define NVME_F_PCI_P2PDMA		(1 << 2)
>  	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
>  	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
>  	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 2902585c6ddf..bb2120d30e39 100644
> +++ b/drivers/nvme/host/pci.c
> @@ -737,8 +737,13 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>  		goto out;
>  
>  	ret = BLK_STS_RESOURCE;
> -	nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents, dma_dir,
> -			DMA_ATTR_NO_WARN);
> +
> +	if (is_pci_p2pdma_page(sg_page(iod->sg)))
> +		nr_mapped = pci_p2pdma_map_sg(dev->dev, iod->sg, iod->nents,
> +					  dma_dir);
> +	else
> +		nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
> +					     dma_dir,  DMA_ATTR_NO_WARN);
>  	if (!nr_mapped)
>  		goto out;
>  
> @@ -780,7 +785,10 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
>  			DMA_TO_DEVICE : DMA_FROM_DEVICE;
>  
>  	if (iod->nents) {
> -		dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
> +		/* P2PDMA requests do not need to be unmapped */
> +		if (!is_pci_p2pdma_page(sg_page(iod->sg)))
> +			dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);

This seems like a poor direction, if we add IOMMU hairpin support we
will need unmapping.

Jason
