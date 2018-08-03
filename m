Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADA8C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 01:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A56F2170A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 01:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A56F2170A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732337AbeHCDkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 23:40:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10615 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729765AbeHCDkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 23:40:08 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9740B22FC7C56;
        Fri,  3 Aug 2018 09:46:14 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.399.0; Fri, 3 Aug 2018
 09:46:14 +0800
Subject: Re: [V9fs-developer] [PATCH v2] net/9p/trans_virtio.c: add null
 terminal for mount tag
To:     Greg Kurz <groug@kaod.org>
References: <5B6262F4.9080601@huawei.com> <20180802015439.GA27403@nautica>
 <5B62658A.3010605@huawei.com> <20180802152339.194c2820@bahia.lan>
CC:     Dominique Martinet <asmadeus@codewreck.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>,
        Ron Minnich <rminnich@sandia.gov>
From:   piaojun <piaojun@huawei.com>
Message-ID: <5B63B3CE.3040601@huawei.com>
Date:   Fri, 3 Aug 2018 09:45:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20180802152339.194c2820@bahia.lan>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg and Dominique,

We'd better reach an agreement about the patch fix. In my opinion,
replacing strlen(chan->tag) with a local variable sounds reasonable, and
changing strncmp to strcmp may be little beneficial, as strcmp is more
dangerours such as buffer-flow. So I'd like to hear your suggestion for
the next version of the patch, or this patch is good enough?

Thanks,
Jun

On 2018/8/2 21:23, Greg Kurz wrote:
> On Thu, 2 Aug 2018 09:59:38 +0800
> piaojun <piaojun@huawei.com> wrote:
> 
>> Hi Dominique,
>>
>> On 2018/8/2 9:54, Dominique Martinet wrote:
>>> piaojun wrote on Thu, Aug 02, 2018:  
>>>> chan->tag is Non-null terminated which will result in printing messy code
>>>> when debugging code. So we should add '\0' for tag to make the code more
>>>> convenient and robust. In addition, I drop char->tag_len to simplify the
>>>> code.  
>>>
>>> Some new lines in commit message would be appreciated.
>>>
>>> That aside, I have a couple of nitpicks, but it looks good to me - thanks
>>>   
>>>>
>>>> Signed-off-by: Jun Piao <piaojun@huawei.com>
>>>> ---
>>>>  net/9p/trans_virtio.c | 15 +++++----------
>>>>  1 file changed, 5 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
>>>> index d422bfc..0fe9c37 100644
>>>> --- a/net/9p/trans_virtio.c
>>>> +++ b/net/9p/trans_virtio.c
>>>> @@ -89,10 +89,8 @@ struct virtio_chan {
>>>>  	unsigned long p9_max_pages;
>>>>  	/* Scatterlist: can be too big for stack. */
>>>>  	struct scatterlist sg[VIRTQUEUE_NUM];
>>>> -
>>>> -	int tag_len;
>>>>  	/*
>>>> -	 * tag name to identify a mount Non-null terminated
>>>> +	 * tag name to identify a mount null terminated
>>>>  	 */
>>>>  	char *tag;
>>>>
>>>> @@ -529,10 +527,9 @@ static ssize_t p9_mount_tag_show(struct device *dev,
>>>>  	vdev = dev_to_virtio(dev);
>>>>  	chan = vdev->priv;
>>>>
>>>> -	memcpy(buf, chan->tag, chan->tag_len);
>>>> -	buf[chan->tag_len] = 0;
>>>> +	memcpy(buf, chan->tag, strlen(chan->tag) + 1);
>>>>
>>>> -	return chan->tag_len + 1;
>>>> +	return strlen(chan->tag) + 1;  
>>>
>>> Use a local variable for strlen(chan->tag)?
>>>   
>> Yes, local variable looks better.
>>
>>>>  }
>>>>
>>>>  static DEVICE_ATTR(mount_tag, 0444, p9_mount_tag_show, NULL);
>>>> @@ -585,7 +582,7 @@ static int p9_virtio_probe(struct virtio_device *vdev)
>>>>  		err = -EINVAL;
>>>>  		goto out_free_vq;
>>>>  	}
>>>> -	tag = kmalloc(tag_len, GFP_KERNEL);
>>>> +	tag = kzalloc(tag_len + 1, GFP_KERNEL);
>>>>  	if (!tag) {
>>>>  		err = -ENOMEM;
>>>>  		goto out_free_vq;
>>>> @@ -594,7 +591,6 @@ static int p9_virtio_probe(struct virtio_device *vdev)
>>>>  	virtio_cread_bytes(vdev, offsetof(struct virtio_9p_config, tag),
>>>>  			   tag, tag_len);
>>>>  	chan->tag = tag;
>>>> -	chan->tag_len = tag_len;
>>>>  	err = sysfs_create_file(&(vdev->dev.kobj), &dev_attr_mount_tag.attr);
>>>>  	if (err) {
>>>>  		goto out_free_tag;
>>>> @@ -654,8 +650,7 @@ static int p9_virtio_probe(struct virtio_device *vdev)
>>>>
>>>>  	mutex_lock(&virtio_9p_lock);
>>>>  	list_for_each_entry(chan, &virtio_chan_list, chan_list) {
>>>> -		if (!strncmp(devname, chan->tag, chan->tag_len) &&
>>>> -		    strlen(devname) == chan->tag_len) {
>>>> +		if (!strncmp(devname, chan->tag, strlen(chan->tag) + 1)) {  
>>>
>>> strncmp(x, y, strlen(y)+1) is precisely what strcmp does so let's use
>>> the simpler version
>>>   
>> strcmp looks simpler, and I will wait for a while to hear more
>> suggestions, and then post another patch for these fixes.
>>
> 
> Nothing more to add. Please go ahead.
> 
>> Thanks,
>> Jun
>>
>> ------------------------------------------------------------------------------
>> Check out the vibrant tech community on one of the world's most
>> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>> _______________________________________________
>> V9fs-developer mailing list
>> V9fs-developer@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/v9fs-developer
> 
> .
> 
