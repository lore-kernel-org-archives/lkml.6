Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56EBC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BE5208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BE5208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388739AbeG0RBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 13:01:49 -0400
Received: from nautica.notk.org ([91.121.71.147]:35086 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731160AbeG0RBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 13:01:49 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id A468FC01B; Fri, 27 Jul 2018 17:39:19 +0200 (CEST)
Date:   Fri, 27 Jul 2018 17:39:04 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     davem@davemloft.net, v9fs-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com
Subject: Re: [PATCH] 9p: fix multiple NULL-pointer-dereferences
Message-ID: <20180727153904.GA500@nautica>
References: <20180727110558.5479-1-tomasbortoli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180727110558.5479-1-tomasbortoli@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Bortoli wrote on Fri, Jul 27, 2018:
> Added checks to prevent GPFs from raising.
> 
> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> Reported-by: syzbot+1a262da37d3bead15c39@syzkaller.appspotmail.com

LGTM, I'll take this. Thanks!

Just a note for future patchs that have multiple versions, it's usually
good to write in the subject [PATCH v2] (then v3 etc) so we can easily
tell it's a new version.
If the thread isn't too long I'd also recommend considering setting a
reply-to to the previous patch so we can easily compare versions/write
off old patches.

> ---
>  net/9p/trans_fd.c     | 5 ++++-
>  net/9p/trans_rdma.c   | 3 +++
>  net/9p/trans_virtio.c | 3 +++
>  net/9p/trans_xen.c    | 3 +++
>  4 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> index 964260265b13..e2ef3c782c53 100644
> --- a/net/9p/trans_fd.c
> +++ b/net/9p/trans_fd.c
> @@ -945,7 +945,7 @@ p9_fd_create_tcp(struct p9_client *client, const char *addr, char *args)
>  	if (err < 0)
>  		return err;
>  
> -	if (valid_ipaddr4(addr) < 0)
> +	if (addr == NULL || valid_ipaddr4(addr) < 0)
>  		return -EINVAL;
>  
>  	csocket = NULL;
> @@ -995,6 +995,9 @@ p9_fd_create_unix(struct p9_client *client, const char *addr, char *args)
>  
>  	csocket = NULL;
>  
> +	if (addr == NULL)
> +		return -EINVAL;
> +
>  	if (strlen(addr) >= UNIX_PATH_MAX) {
>  		pr_err("%s (%d): address too long: %s\n",
>  		       __func__, task_pid_nr(current), addr);
> diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
> index 2649b2ebf961..2ab4574183c9 100644
> --- a/net/9p/trans_rdma.c
> +++ b/net/9p/trans_rdma.c
> @@ -645,6 +645,9 @@ rdma_create_trans(struct p9_client *client, const char *addr, char *args)
>  	struct rdma_conn_param conn_param;
>  	struct ib_qp_init_attr qp_attr;
>  
> +	if (addr == NULL)
> +		return -EINVAL;
> +
>  	/* Parse the transport specific mount options */
>  	err = parse_opts(args, &opts);
>  	if (err < 0)
> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index 06dcd3cc6a29..8ca356eb66bb 100644
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -654,6 +654,9 @@ p9_virtio_create(struct p9_client *client, const char *devname, char *args)
>  	int ret = -ENOENT;
>  	int found = 0;
>  
> +	if (devname == NULL)
> +		return -EINVAL;
> +
>  	mutex_lock(&virtio_9p_lock);
>  	list_for_each_entry(chan, &virtio_chan_list, chan_list) {
>  		if (!strncmp(devname, chan->tag, chan->tag_len) &&
> diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
> index 2e2b8bca54f3..c2d54ac76bfd 100644
> --- a/net/9p/trans_xen.c
> +++ b/net/9p/trans_xen.c
> @@ -94,6 +94,9 @@ static int p9_xen_create(struct p9_client *client, const char *addr, char *args)
>  {
>  	struct xen_9pfs_front_priv *priv;
>  
> +	if (addr == NULL)
> +		return -EINVAL;
> +
>  	read_lock(&xen_9pfs_lock);
>  	list_for_each_entry(priv, &xen_9pfs_devs, list) {
>  		if (!strcmp(priv->tag, addr)) {

-- 
Dominique Martinet
