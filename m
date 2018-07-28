Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6883FC67790
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 00:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A97A20862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 00:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A97A20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389248AbeG1CXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 22:23:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42103 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388902AbeG1CXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 22:23:34 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 60618EFEBCDE6;
        Sat, 28 Jul 2018 08:59:06 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.382.0; Sat, 28 Jul 2018
 08:59:06 +0800
Subject: Re: [V9fs-developer] [PATCH] 9p: fix multiple
 NULL-pointer-dereferences
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Tomas Bortoli <tomasbortoli@gmail.com>
References: <20180727110558.5479-1-tomasbortoli@gmail.com>
 <20180727153904.GA500@nautica>
CC:     <v9fs-developer@lists.sourceforge.net>,
        <syzkaller@googlegroups.com>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
From:   piaojun <piaojun@huawei.com>
Message-ID: <5B5BBFCE.50002@huawei.com>
Date:   Sat, 28 Jul 2018 08:58:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20180727153904.GA500@nautica>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomas & Dominique,

I could not recieve the original patch. Did the patch CC v9fs developer
maillist?

Thanks,
Jun

On 2018/7/27 23:39, Dominique Martinet wrote:
> Tomas Bortoli wrote on Fri, Jul 27, 2018:
>> Added checks to prevent GPFs from raising.
>>
>> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
>> Reported-by: syzbot+1a262da37d3bead15c39@syzkaller.appspotmail.com
> 
> LGTM, I'll take this. Thanks!
> 
> Just a note for future patchs that have multiple versions, it's usually
> good to write in the subject [PATCH v2] (then v3 etc) so we can easily
> tell it's a new version.
> If the thread isn't too long I'd also recommend considering setting a
> reply-to to the previous patch so we can easily compare versions/write
> off old patches.
> 
>> ---
>>  net/9p/trans_fd.c     | 5 ++++-
>>  net/9p/trans_rdma.c   | 3 +++
>>  net/9p/trans_virtio.c | 3 +++
>>  net/9p/trans_xen.c    | 3 +++
>>  4 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
>> index 964260265b13..e2ef3c782c53 100644
>> --- a/net/9p/trans_fd.c
>> +++ b/net/9p/trans_fd.c
>> @@ -945,7 +945,7 @@ p9_fd_create_tcp(struct p9_client *client, const char *addr, char *args)
>>  	if (err < 0)
>>  		return err;
>>  
>> -	if (valid_ipaddr4(addr) < 0)
>> +	if (addr == NULL || valid_ipaddr4(addr) < 0)
>>  		return -EINVAL;
>>  
>>  	csocket = NULL;
>> @@ -995,6 +995,9 @@ p9_fd_create_unix(struct p9_client *client, const char *addr, char *args)
>>  
>>  	csocket = NULL;
>>  
>> +	if (addr == NULL)
>> +		return -EINVAL;
>> +
>>  	if (strlen(addr) >= UNIX_PATH_MAX) {
>>  		pr_err("%s (%d): address too long: %s\n",
>>  		       __func__, task_pid_nr(current), addr);
>> diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
>> index 2649b2ebf961..2ab4574183c9 100644
>> --- a/net/9p/trans_rdma.c
>> +++ b/net/9p/trans_rdma.c
>> @@ -645,6 +645,9 @@ rdma_create_trans(struct p9_client *client, const char *addr, char *args)
>>  	struct rdma_conn_param conn_param;
>>  	struct ib_qp_init_attr qp_attr;
>>  
>> +	if (addr == NULL)
>> +		return -EINVAL;
>> +
>>  	/* Parse the transport specific mount options */
>>  	err = parse_opts(args, &opts);
>>  	if (err < 0)
>> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
>> index 06dcd3cc6a29..8ca356eb66bb 100644
>> --- a/net/9p/trans_virtio.c
>> +++ b/net/9p/trans_virtio.c
>> @@ -654,6 +654,9 @@ p9_virtio_create(struct p9_client *client, const char *devname, char *args)
>>  	int ret = -ENOENT;
>>  	int found = 0;
>>  
>> +	if (devname == NULL)
>> +		return -EINVAL;
>> +
>>  	mutex_lock(&virtio_9p_lock);
>>  	list_for_each_entry(chan, &virtio_chan_list, chan_list) {
>>  		if (!strncmp(devname, chan->tag, chan->tag_len) &&
>> diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
>> index 2e2b8bca54f3..c2d54ac76bfd 100644
>> --- a/net/9p/trans_xen.c
>> +++ b/net/9p/trans_xen.c
>> @@ -94,6 +94,9 @@ static int p9_xen_create(struct p9_client *client, const char *addr, char *args)
>>  {
>>  	struct xen_9pfs_front_priv *priv;
>>  
>> +	if (addr == NULL)
>> +		return -EINVAL;
>> +
>>  	read_lock(&xen_9pfs_lock);
>>  	list_for_each_entry(priv, &xen_9pfs_devs, list) {
>>  		if (!strcmp(priv->tag, addr)) {
> 
