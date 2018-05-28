Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425510AbeE1Qxd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:53:33 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44525 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932352AbeE1Qx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 12:53:28 -0400
X-Google-Smtp-Source: AB8JxZpKsDS3YVq9AsmZcPhh+o56rsjrccyVzwWrAEm0Iun95Jzz4rDBWKXv1lkBovclNiYw5nQ0kQ==
Date: Mon, 28 May 2018 10:53:23 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
Cc: dledford@redhat.com, linux-rdma@vger.kernel.org, lijun_nudt@163.com,
        oulijun@huawei.com, charles.chenxin@huawei.com,
        linux-kernel@vger.kernel.org, leonro@mellanox.com
Subject: Re: [PATCH V3 rdma-next 4/4] RDMA/hns: Implement the
 disassociate_ucontext API
Message-ID: <20180528165323.GC17505@ziepe.ca>
References: <1527324107-56593-1-git-send-email-xavier.huwei@huawei.com>
 <1527324107-56593-5-git-send-email-xavier.huwei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527324107-56593-5-git-send-email-xavier.huwei@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2018 at 04:41:47PM +0800, Wei Hu (Xavier) wrote:
> This patch implemented the IB core disassociate_ucontext API.
> 
> Signed-off-by: Wei Hu (Xavier) <xavier.huwei@huawei.com>
> 
> v2->v3: Addressed the comments from Jason. The related link:
> 	https://lkml.org/lkml/2018/5/22/967
> v1->v2: no change.
>  drivers/infiniband/hw/hns/hns_roce_device.h |  8 ++++
>  drivers/infiniband/hw/hns/hns_roce_main.c   | 70 ++++++++++++++++++++++++++++-
>  2 files changed, 77 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index da8512b..31221d5 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -217,11 +217,19 @@ struct hns_roce_uar {
>  	unsigned long	logic_idx;
>  };
>  
> +struct hns_roce_vma_data {
> +	struct list_head list;
> +	struct vm_area_struct *vma;
> +	struct mutex *vma_list_mutex;
> +};

This stuff is basically shared in all the drivers too - would it make
sense to maintain this information and do the zap_pte in the core code
as well?

There is no way to implement dis-associate without also doing the
zaps..

Jason
