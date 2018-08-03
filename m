Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688B1C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0119E2173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0119E2173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732564AbeHCLio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 07:38:44 -0400
Received: from nautica.notk.org ([91.121.71.147]:37063 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732522AbeHCLio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 07:38:44 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 36880C009; Fri,  3 Aug 2018 11:43:12 +0200 (CEST)
Date:   Fri, 3 Aug 2018 11:42:57 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     piaojun <piaojun@huawei.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Greg Kurz <groug@kaod.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH v3] net/9p/trans_virtio.c: add null terminal for mount tag
Message-ID: <20180803094257.GA21285@nautica>
References: <5B641ECC.5030401@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B641ECC.5030401@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

piaojun wrote on Fri, Aug 03, 2018:
> chan->tag is Non-null terminated which will result in printing messy code
> when debugging code. So we should add '\0' for tag to make the code more
> convenient and robust. In addition, I drop char->tag_len to simplify the
> code.

LGTM, I'll pick this up.

Thanks for the rework

> Signed-off-by: Jun Piao <piaojun@huawei.com>
> ---
>  net/9p/trans_virtio.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index d422bfc..46a5ab2 100644
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -89,10 +89,8 @@ struct virtio_chan {
>  	unsigned long p9_max_pages;
>  	/* Scatterlist: can be too big for stack. */
>  	struct scatterlist sg[VIRTQUEUE_NUM];
> -
> -	int tag_len;
>  	/*
> -	 * tag name to identify a mount Non-null terminated
> +	 * tag name to identify a mount null terminated
>  	 */
>  	char *tag;
> 
> @@ -525,14 +523,15 @@ static ssize_t p9_mount_tag_show(struct device *dev,
>  {
>  	struct virtio_chan *chan;
>  	struct virtio_device *vdev;
> +	int tag_len;
> 
>  	vdev = dev_to_virtio(dev);
>  	chan = vdev->priv;
> +	tag_len = strlen(chan->tag);
> 
> -	memcpy(buf, chan->tag, chan->tag_len);
> -	buf[chan->tag_len] = 0;
> +	memcpy(buf, chan->tag, tag_len + 1);
> 
> -	return chan->tag_len + 1;
> +	return tag_len + 1;
>  }
> 
>  static DEVICE_ATTR(mount_tag, 0444, p9_mount_tag_show, NULL);
> @@ -585,7 +584,7 @@ static int p9_virtio_probe(struct virtio_device *vdev)
>  		err = -EINVAL;
>  		goto out_free_vq;
>  	}
> -	tag = kmalloc(tag_len, GFP_KERNEL);
> +	tag = kzalloc(tag_len + 1, GFP_KERNEL);
>  	if (!tag) {
>  		err = -ENOMEM;
>  		goto out_free_vq;
> @@ -594,7 +593,6 @@ static int p9_virtio_probe(struct virtio_device *vdev)
>  	virtio_cread_bytes(vdev, offsetof(struct virtio_9p_config, tag),
>  			   tag, tag_len);
>  	chan->tag = tag;
> -	chan->tag_len = tag_len;
>  	err = sysfs_create_file(&(vdev->dev.kobj), &dev_attr_mount_tag.attr);
>  	if (err) {
>  		goto out_free_tag;
> @@ -654,8 +652,7 @@ static int p9_virtio_probe(struct virtio_device *vdev)
> 
>  	mutex_lock(&virtio_9p_lock);
>  	list_for_each_entry(chan, &virtio_chan_list, chan_list) {
> -		if (!strncmp(devname, chan->tag, chan->tag_len) &&
> -		    strlen(devname) == chan->tag_len) {
> +		if (!strcmp(devname, chan->tag)) {
>  			if (!chan->inuse) {
>  				chan->inuse = true;
>  				found = 1;
> -- 
