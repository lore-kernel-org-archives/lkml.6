Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E761C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38D7264B0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F38D7264B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965403AbeFZDmi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 23:42:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:33540 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965340AbeFZDmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 23:42:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 20:42:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,273,1526367600"; 
   d="scan'208";a="70000837"
Received: from unknown (HELO [10.239.13.97]) ([10.239.13.97])
  by orsmga002.jf.intel.com with ESMTP; 25 Jun 2018 20:42:33 -0700
Message-ID: <5B31B71B.6080709@intel.com>
Date:   Tue, 26 Jun 2018 11:46:35 +0800
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
Subject: Re: [PATCH v34 2/4] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
References: <1529928312-30500-1-git-send-email-wei.w.wang@intel.com> <1529928312-30500-3-git-send-email-wei.w.wang@intel.com> <20180626002822-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180626002822-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/26/2018 09:37 AM, Michael S. Tsirkin wrote:
> On Mon, Jun 25, 2018 at 08:05:10PM +0800, Wei Wang wrote:
>
>> @@ -326,17 +353,6 @@ static void stats_handle_request(struct virtio_balloon *vb)
>>   	virtqueue_kick(vq);
>>   }
>>   
>> -static void virtballoon_changed(struct virtio_device *vdev)
>> -{
>> -	struct virtio_balloon *vb = vdev->priv;
>> -	unsigned long flags;
>> -
>> -	spin_lock_irqsave(&vb->stop_update_lock, flags);
>> -	if (!vb->stop_update)
>> -		queue_work(system_freezable_wq, &vb->update_balloon_size_work);
>> -	spin_unlock_irqrestore(&vb->stop_update_lock, flags);
>> -}
>> -
>>   static inline s64 towards_target(struct virtio_balloon *vb)
>>   {
>>   	s64 target;
>> @@ -353,6 +369,35 @@ static inline s64 towards_target(struct virtio_balloon *vb)
>>   	return target - vb->num_pages;
>>   }
>>   
>> +static void virtballoon_changed(struct virtio_device *vdev)
>> +{
>> +	struct virtio_balloon *vb = vdev->priv;
>> +	unsigned long flags;
>> +	s64 diff = towards_target(vb);
>> +
>> +	if (diff) {
>> +		spin_lock_irqsave(&vb->stop_update_lock, flags);
>> +		if (!vb->stop_update)
>> +			queue_work(system_freezable_wq,
>> +				   &vb->update_balloon_size_work);
>> +		spin_unlock_irqrestore(&vb->stop_update_lock, flags);
>> +	}
>> +
>> +	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>> +		virtio_cread(vdev, struct virtio_balloon_config,
>> +			     free_page_report_cmd_id, &vb->cmd_id_received);
>> +		if (vb->cmd_id_received !=
>> +		    VIRTIO_BALLOON_FREE_PAGE_REPORT_STOP_ID &&
>> +		    vb->cmd_id_received != vb->cmd_id_active) {
>> +			spin_lock_irqsave(&vb->stop_update_lock, flags);
>> +			if (!vb->stop_update)
>> +				queue_work(vb->balloon_wq,
>> +					   &vb->report_free_page_work);
>> +			spin_unlock_irqrestore(&vb->stop_update_lock, flags);
>> +		}
>> +	}
>> +}
>> +
>>   static void update_balloon_size(struct virtio_balloon *vb)
>>   {
>>   	u32 actual = vb->num_pages;
>> @@ -425,44 +470,253 @@ static void update_balloon_size_func(struct work_struct *work)
>>   		queue_work(system_freezable_wq, work);
>>   }
>>   
>> +static void free_page_vq_cb(struct virtqueue *vq)
>> +{
>> +	unsigned int len;
>> +	void *buf;
>> +	struct virtio_balloon *vb = vq->vdev->priv;
>> +
>> +	while (1) {
>> +		buf = virtqueue_get_buf(vq, &len);
>> +
>> +		if (!buf || buf == &vb->cmd_start || buf == &vb->cmd_stop)
>> +			break;
> If there's any buffer after this one we might never get another
> callback.

I think every used buffer can get the callback, because host takes from 
the arrays one by one, and puts back each with a vq notify.



>> +		free_pages((unsigned long)buf, ARRAY_ALLOC_ORDER);
>> +	}
>> +}
>> +
>>   static int init_vqs(struct virtio_balloon *vb)
>>   {
>> -	struct virtqueue *vqs[3];
>> -	vq_callback_t *callbacks[] = { balloon_ack, balloon_ack, stats_request };
>> -	static const char * const names[] = { "inflate", "deflate", "stats" };
>> -	int err, nvqs;
>> +	struct virtqueue *vqs[VIRTIO_BALLOON_VQ_MAX];
>> +	vq_callback_t *callbacks[VIRTIO_BALLOON_VQ_MAX];
>> +	const char *names[VIRTIO_BALLOON_VQ_MAX];
>> +	struct scatterlist sg;
>> +	int ret;
>>   
>>   	/*
>> -	 * We expect two virtqueues: inflate and deflate, and
>> -	 * optionally stat.
>> +	 * Inflateq and deflateq are used unconditionally. The names[]
>> +	 * will be NULL if the related feature is not enabled, which will
>> +	 * cause no allocation for the corresponding virtqueue in find_vqs.
>>   	 */
>> -	nvqs = virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ) ? 3 : 2;
>> -	err = virtio_find_vqs(vb->vdev, nvqs, vqs, callbacks, names, NULL);
>> -	if (err)
>> -		return err;
>> +	callbacks[VIRTIO_BALLOON_VQ_INFLATE] = balloon_ack;
>> +	names[VIRTIO_BALLOON_VQ_INFLATE] = "inflate";
>> +	callbacks[VIRTIO_BALLOON_VQ_DEFLATE] = balloon_ack;
>> +	names[VIRTIO_BALLOON_VQ_DEFLATE] = "deflate";
>> +	names[VIRTIO_BALLOON_VQ_STATS] = NULL;
>> +	names[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
>>   
>> -	vb->inflate_vq = vqs[0];
>> -	vb->deflate_vq = vqs[1];
>>   	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
>> -		struct scatterlist sg;
>> -		unsigned int num_stats;
>> -		vb->stats_vq = vqs[2];
>> +		names[VIRTIO_BALLOON_VQ_STATS] = "stats";
>> +		callbacks[VIRTIO_BALLOON_VQ_STATS] = stats_request;
>> +	}
>>   
>> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
>> +		names[VIRTIO_BALLOON_VQ_FREE_PAGE] = "free_page_vq";
>> +		callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = free_page_vq_cb;
>> +	}
>> +
>> +	ret = vb->vdev->config->find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX,
>> +					 vqs, callbacks, names, NULL, NULL);
>> +	if (ret)
>> +		return ret;
>> +
>> +	vb->inflate_vq = vqs[VIRTIO_BALLOON_VQ_INFLATE];
>> +	vb->deflate_vq = vqs[VIRTIO_BALLOON_VQ_DEFLATE];
>> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
>> +		vb->stats_vq = vqs[VIRTIO_BALLOON_VQ_STATS];
>>   		/*
>>   		 * Prime this virtqueue with one buffer so the hypervisor can
>>   		 * use it to signal us later (it can't be broken yet!).
>>   		 */
>> -		num_stats = update_balloon_stats(vb);
>> -
>> -		sg_init_one(&sg, vb->stats, sizeof(vb->stats[0]) * num_stats);
>> -		if (virtqueue_add_outbuf(vb->stats_vq, &sg, 1, vb, GFP_KERNEL)
>> -		    < 0)
>> -			BUG();
>> +		sg_init_one(&sg, vb->stats, sizeof(vb->stats));
>> +		ret = virtqueue_add_outbuf(vb->stats_vq, &sg, 1, vb,
>> +					   GFP_KERNEL);
>> +		if (ret) {
>> +			dev_warn(&vb->vdev->dev, "%s: add stat_vq failed\n",
>> +				 __func__);
>> +			return ret;
>> +		}
> Why the change? Is it more likely to happen now?

Actually this part remains the same as the previous versions (e.g. v32). 
It is changed because we agreed that using BUG() isn't necessary here, 
and better to bail out nicely.



>
> +/*
> + * virtio_balloon_send_hints - send arrays of hints to host
> + * @vb: the virtio_balloon struct
> + * @arrays: the arrays of hints
> + * @array_num: the number of arrays give by the caller
> + * @last_array_hints: the number of hints in the last array
> + *
> + * Send hints to host array by array. This begins by sending a start cmd,
> + * which contains a cmd id received from host and the free page block size in
> + * bytes of each hint. At the end, a stop cmd is sent to host to indicate the
> + * end of this reporting. If host actively requests to stop the reporting, free
> + * the arrays that have not been sent.
> + */
> +static void virtio_balloon_send_hints(struct virtio_balloon *vb,
> +				      __le64 **arrays,
> +				      uint32_t array_num,
> +				      uint32_t last_array_hints)
> +{
> +	int err, i = 0;
> +	struct scatterlist sg;
> +	struct virtqueue *vq = vb->free_page_vq;
> +
> +	/* Start by sending the received cmd id to host with an outbuf. */
> +	err = send_start_cmd_id(vb);
> +	if (unlikely(err))
> +		goto out_err;
> +	/* Kick host to start taking entries from the vq. */
> +	virtqueue_kick(vq);
> +
> +	for (i = 0; i < array_num; i++) {
> +		/*
> +		 * If a stop id or a new cmd id was just received from host,
> +		 * stop the reporting, and free the remaining arrays that
> +		 * haven't been sent to host.
> +		 */
> +		if (vb->cmd_id_received != vb->cmd_id_active)
> +			goto out_free;
> +
> +		if (i + 1 == array_num)
> +			sg_init_one(&sg, (void *)arrays[i],
> +				    last_array_hints * sizeof(__le64));
> +		else
> +			sg_init_one(&sg, (void *)arrays[i], ARRAY_ALLOC_SIZE);
> +		err = virtqueue_add_inbuf(vq, &sg, 1, (void *)arrays[i],
> +					  GFP_KERNEL);
> +		if (unlikely(err))
> +			goto out_err;
> +	}
> +
> +	/* End by sending a stop id to host with an outbuf. */
> +	err = send_stop_cmd_id(vb);
> +	if (unlikely(err))
> +		goto out_err;
> Don't we need to kick here?

I think not needed, because we have kicked host about starting the 
report, and the host side optimization won't exit unless receiving this 
stop sign or the migration thread asks to exit.

>
>> +	int i;
>> +
>> +	max_entries = max_free_page_blocks(ARRAY_ALLOC_ORDER);
>> +	entries_per_page = PAGE_SIZE / sizeof(__le64);
>> +	entries_per_array = entries_per_page * (1 << ARRAY_ALLOC_ORDER);
>> +	max_array_num = max_entries / entries_per_array +
>> +			!!(max_entries % entries_per_array);
>> +	arrays = kmalloc_array(max_array_num, sizeof(__le64 *), GFP_KERNEL);
> Instead of all this mess, how about get_free_pages here as well?

Sounds good, will replace kmalloc_array with __get_free_pages(), but 
still need the above calculation to get max_array_num.

>
> Also why do we need GFP_KERNEL for this?

I guess it is better to use "__GFP_ATOMIC | __GFP_NOMEMALLOC", thanks.

>
>
>> +	if (!arrays)
>> +		return NULL;
>> +
>> +	for (i = 0; i < max_array_num; i++) {
> So we are getting a ton of memory here just to free it up a bit later.
> Why doesn't get_from_free_page_list get the pages from free list for us?
> We could also avoid the 1st allocation then - just build a list
> of these.

That wouldn't be a good choice for us. If we check how the regular 
allocation works, there are many many things we need to consider when 
pages are allocated to users. For example, we need to take care of the 
nr_free counter, we need to check the watermark and perform the related 
actions. Also the folks working on arch_alloc_page to monitor page 
allocation activities would get a surprise..if page allocation is 
allowed to work in this way.





>
>> +		arrays[i] =
>> +		(__le64 *)__get_free_pages(__GFP_ATOMIC | __GFP_NOMEMALLOC,
>> +					   ARRAY_ALLOC_ORDER);
> Coding style says:
>
> Descendants are always substantially shorter than the parent and
> are placed substantially to the right.

Thanks, will rearrange it:

arrays[i] = (__le64 *)__get_free_pages(__GFP_ATOMIC |
				__GFP_NOMEMALLOC, ARRAY_ALLOC_ORDER);



>
>> +		if (!arrays[i]) {
> Also if it does fail (small guest), shall we try with less arrays?

I think it's not needed. If the free list is empty, no matter it is a 
huge guest or a small guest, get_from_free_page_list() will load nothing 
even we pass a small array to it.


Best,
Wei
