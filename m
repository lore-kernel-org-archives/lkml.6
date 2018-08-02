Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95DBC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48677208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 01:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48677208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732292AbeHBDni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 23:43:38 -0400
Received: from nautica.notk.org ([91.121.71.147]:55480 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731503AbeHBDni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 23:43:38 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 22291C009; Thu,  2 Aug 2018 03:54:54 +0200 (CEST)
Date:   Thu, 2 Aug 2018 03:54:39 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     piaojun <piaojun@huawei.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Greg Kurz <groug@kaod.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH v2] net/9p/trans_virtio.c: add null terminal for mount tag
Message-ID: <20180802015439.GA27403@nautica>
References: <5B6262F4.9080601@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5B6262F4.9080601@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

piaojun wrote on Thu, Aug 02, 2018:
> chan->tag is Non-null terminated which will result in printing messy code
> when debugging code. So we should add '\0' for tag to make the code more
> convenient and robust. In addition, I drop char->tag_len to simplify the
> code.

Some new lines in commit message would be appreciated.

That aside, I have a couple of nitpicks, but it looks good to me - thanks

> 
> Signed-off-by: Jun Piao <piaojun@huawei.com>
> ---
>  net/9p/trans_virtio.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index d422bfc..0fe9c37 100644
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
> @@ -529,10 +527,9 @@ static ssize_t p9_mount_tag_show(struct device *dev,
>  	vdev = dev_to_virtio(dev);
>  	chan = vdev->priv;
> 
> -	memcpy(buf, chan->tag, chan->tag_len);
> -	buf[chan->tag_len] = 0;
> +	memcpy(buf, chan->tag, strlen(chan->tag) + 1);
> 
> -	return chan->tag_len + 1;
> +	return strlen(chan->tag) + 1;

Use a local variable for strlen(chan->tag)?

>  }
> 
>  static DEVICE_ATTR(mount_tag, 0444, p9_mount_tag_show, NULL);
> @@ -585,7 +582,7 @@ static int p9_virtio_probe(struct virtio_device *vdev)
>  		err = -EINVAL;
>  		goto out_free_vq;
>  	}
> -	tag = kmalloc(tag_len, GFP_KERNEL);
> +	tag = kzalloc(tag_len + 1, GFP_KERNEL);
>  	if (!tag) {
>  		err = -ENOMEM;
>  		goto out_free_vq;
> @@ -594,7 +591,6 @@ static int p9_virtio_probe(struct virtio_device *vdev)
>  	virtio_cread_bytes(vdev, offsetof(struct virtio_9p_config, tag),
>  			   tag, tag_len);
>  	chan->tag = tag;
> -	chan->tag_len = tag_len;
>  	err = sysfs_create_file(&(vdev->dev.kobj), &dev_attr_mount_tag.attr);
>  	if (err) {
>  		goto out_free_tag;
> @@ -654,8 +650,7 @@ static int p9_virtio_probe(struct virtio_device *vdev)
> 
>  	mutex_lock(&virtio_9p_lock);
>  	list_for_each_entry(chan, &virtio_chan_list, chan_list) {
> -		if (!strncmp(devname, chan->tag, chan->tag_len) &&
> -		    strlen(devname) == chan->tag_len) {
> +		if (!strncmp(devname, chan->tag, strlen(chan->tag) + 1)) {

strncmp(x, y, strlen(y)+1) is precisely what strcmp does so let's use
the simpler version

-- 
Dominique
