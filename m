Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396E3ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C3520846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C3520846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388207AbeGWL1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:27:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:62236 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388021AbeGWL1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:27:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2018 03:26:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,393,1526367600"; 
   d="scan'208";a="74686894"
Received: from unknown (HELO [10.239.13.97]) ([10.239.13.97])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jul 2018 03:26:29 -0700
Message-ID: <5B55AE56.5030404@intel.com>
Date:   Mon, 23 Jul 2018 18:30:46 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, pbonzini@redhat.com,
        liliang.opensource@gmail.com, yang.zhang.wz@gmail.com,
        quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com,
        peterx@redhat.com
Subject: Re: [PATCH v36 2/5] virtio_balloon: replace oom notifier with shrinker
References: <1532075585-39067-1-git-send-email-wei.w.wang@intel.com> <1532075585-39067-3-git-send-email-wei.w.wang@intel.com> <20180722174125-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180722174125-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/22/2018 10:48 PM, Michael S. Tsirkin wrote:
> On Fri, Jul 20, 2018 at 04:33:02PM +0800, Wei Wang wrote:
>>   
>> +static unsigned long virtio_balloon_shrinker_scan(struct shrinker *shrinker,
>> +						  struct shrink_control *sc)
>> +{
>> +	unsigned long pages_to_free = balloon_pages_to_shrink,
>> +		      pages_freed = 0;
>> +	struct virtio_balloon *vb = container_of(shrinker,
>> +					struct virtio_balloon, shrinker);
>> +
>> +	/*
>> +	 * One invocation of leak_balloon can deflate at most
>> +	 * VIRTIO_BALLOON_ARRAY_PFNS_MAX balloon pages, so we call it
>> +	 * multiple times to deflate pages till reaching
>> +	 * balloon_pages_to_shrink pages.
>> +	 */
>> +	while (vb->num_pages && pages_to_free) {
>> +		pages_to_free = balloon_pages_to_shrink - pages_freed;
>> +		pages_freed += leak_balloon(vb, pages_to_free);
>> +	}
>> +	update_balloon_size(vb);
> Are you sure that this is never called if count returned 0?

Yes. Please see do_shrink_slab, it just returns if count is 0.

>
>> +
>> +	return pages_freed / VIRTIO_BALLOON_PAGES_PER_PAGE;
>> +}
>> +
>> +static unsigned long virtio_balloon_shrinker_count(struct shrinker *shrinker,
>> +						   struct shrink_control *sc)
>> +{
>> +	struct virtio_balloon *vb = container_of(shrinker,
>> +					struct virtio_balloon, shrinker);
>> +
>> +	/*
>> +	 * We continue to use VIRTIO_BALLOON_F_DEFLATE_ON_OOM to handle the
>> +	 * case when shrinker needs to be invoked to relieve memory pressure.
>> +	 */
>> +	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
>> +		return 0;
> So why not skip notifier registration when deflate on oom
> is clear?

Sounds good, thanks.


>   	vb->vb_dev_info.inode->i_mapping->a_ops = &balloon_aops;
>   #endif
> +	err = virtio_balloon_register_shrinker(vb);
> +	if (err)
> +		goto out_del_vqs;
>   
> So we can get scans before device is ready. Leak will fail
> then. Why not register later after device is ready?

Probably no.

- it would be better not to set device ready when register_shrinker failed.
- When the device isn't ready, ballooning won't happen, that is, 
vb->num_pages will be 0, which results in shrinker_count=0 and 
shrinker_scan won't be called.

So I think it would be better to have shrinker registered before 
device_ready.

Best,
Wei
