Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E23FECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30CA2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30CA2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731967AbeGMUw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:52:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52788 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731883AbeGMUw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:52:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7009E40122CF;
        Fri, 13 Jul 2018 20:36:13 +0000 (UTC)
Received: from doriath (ovpn-117-239.phx2.redhat.com [10.3.117.239])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F824112C268;
        Fri, 13 Jul 2018 20:36:00 +0000 (UTC)
Date:   Fri, 13 Jul 2018 16:35:59 -0400
From:   Luiz Capitulino <lcapitulino@redhat.com>
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, jack@suse.cz,
        stefanha@redhat.com, dan.j.williams@intel.com, riel@surriel.com,
        haozhong.zhang@intel.com, nilal@redhat.com, kwolf@redhat.com,
        pbonzini@redhat.com, ross.zwisler@intel.com, david@redhat.com,
        xiaoguangrong.eric@gmail.com, hch@infradead.org, mst@redhat.com,
        niteshnarayanlal@hotmail.com, imammedo@redhat.com,
        eblake@redhat.com
Subject: Re: [RFC v3 1/2] libnvdimm: Add flush callback for virtio pmem
Message-ID: <20180713163559.692aca30@doriath>
In-Reply-To: <20180713075232.9575-2-pagupta@redhat.com>
References: <20180713075232.9575-1-pagupta@redhat.com>
 <20180713075232.9575-2-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 13 Jul 2018 20:36:13 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 13 Jul 2018 20:36:13 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lcapitulino@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jul 2018 13:22:30 +0530
Pankaj Gupta <pagupta@redhat.com> wrote:

> This patch adds functionality to perform flush from guest to host
> over VIRTIO. We are registering a callback based on 'nd_region' type.
> As virtio_pmem driver requires this special flush interface, for rest
> of the region types we are registering existing flush function.
> Also report the error returned by virtio flush interface.

This patch doesn't apply against latest upstream. A few more comments
below.

> 
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  drivers/nvdimm/nd.h          |  1 +
>  drivers/nvdimm/pmem.c        |  4 ++--
>  drivers/nvdimm/region_devs.c | 24 ++++++++++++++++++------
>  include/linux/libnvdimm.h    |  5 ++++-
>  4 files changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
> index 32e0364..1b62f79 100644
> --- a/drivers/nvdimm/nd.h
> +++ b/drivers/nvdimm/nd.h
> @@ -159,6 +159,7 @@ struct nd_region {
>  	struct badblocks bb;
>  	struct nd_interleave_set *nd_set;
>  	struct nd_percpu_lane __percpu *lane;
> +	int (*flush)(struct device *dev);
>  	struct nd_mapping mapping[0];
>  };
>  
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 9d71492..29fd2cd 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -180,7 +180,7 @@ static blk_qc_t pmem_make_request(struct request_queue *q, struct bio *bio)
>  	struct nd_region *nd_region = to_region(pmem);
>  
>  	if (bio->bi_opf & REQ_FLUSH)
> -		nvdimm_flush(nd_region);
> +		bio->bi_status = nvdimm_flush(nd_region);
>  
>  	do_acct = nd_iostat_start(bio, &start);
>  	bio_for_each_segment(bvec, bio, iter) {
> @@ -196,7 +196,7 @@ static blk_qc_t pmem_make_request(struct request_queue *q, struct bio *bio)
>  		nd_iostat_end(bio, start);
>  
>  	if (bio->bi_opf & REQ_FUA)
> -		nvdimm_flush(nd_region);
> +		bio->bi_status = nvdimm_flush(nd_region);
>  
>  	bio_endio(bio);
>  	return BLK_QC_T_NONE;
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index a612be6..124aae7 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -1025,6 +1025,7 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
>  	dev->of_node = ndr_desc->of_node;
>  	nd_region->ndr_size = resource_size(ndr_desc->res);
>  	nd_region->ndr_start = ndr_desc->res->start;
> +	nd_region->flush = ndr_desc->flush;
>  	nd_device_register(dev);
>  
>  	return nd_region;
> @@ -1065,13 +1066,10 @@ struct nd_region *nvdimm_volatile_region_create(struct nvdimm_bus *nvdimm_bus,
>  }
>  EXPORT_SYMBOL_GPL(nvdimm_volatile_region_create);
>  
> -/**
> - * nvdimm_flush - flush any posted write queues between the cpu and pmem media
> - * @nd_region: blk or interleaved pmem region
> - */
> -void nvdimm_flush(struct nd_region *nd_region)
> +void pmem_flush(struct device *dev)
>  {
> -	struct nd_region_data *ndrd = dev_get_drvdata(&nd_region->dev);
> +	struct nd_region_data *ndrd = dev_get_drvdata(dev);
> +	struct nd_region *nd_region = to_nd_region(dev);
>  	int i, idx;
>  
>  	/*
> @@ -1094,6 +1092,20 @@ void nvdimm_flush(struct nd_region *nd_region)
>  			writeq(1, ndrd_get_flush_wpq(ndrd, i, idx));
>  	wmb();
>  }
> +
> +/**
> + * nvdimm_flush - flush any posted write queues between the cpu and pmem media
> + * @nd_region: blk or interleaved pmem region
> + */
> +int nvdimm_flush(struct nd_region *nd_region)
> +{
> +	if (nd_region->flush)
> +		return(nd_region->flush(&nd_region->dev));
> +
> +	pmem_flush(&nd_region->dev);

IMHO, a better way of doing this would be to allow nvdimm_flush() to
be overridden. That is, in nd_region_create() you set nd_region->flush
to the original nvdimm_flush() if ndr_desc->flush is NULL. And then
always call nd_region->flush() where nvdimm_flush() is called today.

> +
> +	return 0;
> +}
>  EXPORT_SYMBOL_GPL(nvdimm_flush);
>  
>  /**
> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> index 097072c..33b617f 100644
> --- a/include/linux/libnvdimm.h
> +++ b/include/linux/libnvdimm.h
> @@ -126,6 +126,7 @@ struct nd_region_desc {
>  	int numa_node;
>  	unsigned long flags;
>  	struct device_node *of_node;
> +	int (*flush)(struct device *dev);
>  };
>  
>  struct device;
> @@ -201,7 +202,9 @@ unsigned long nd_blk_memremap_flags(struct nd_blk_region *ndbr);
>  unsigned int nd_region_acquire_lane(struct nd_region *nd_region);
>  void nd_region_release_lane(struct nd_region *nd_region, unsigned int lane);
>  u64 nd_fletcher64(void *addr, size_t len, bool le);
> -void nvdimm_flush(struct nd_region *nd_region);
> +int nvdimm_flush(struct nd_region *nd_region);
> +void pmem_set_flush(struct nd_region *nd_region, void (*flush)
> +					(struct device *));

It seems pmem_set_flush() doesn't exist.

>  int nvdimm_has_flush(struct nd_region *nd_region);
>  int nvdimm_has_cache(struct nd_region *nd_region);
>  

