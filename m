Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id f2RiI9NuGVvnWAAAmS7hNA
	; Thu, 07 Jun 2018 17:44:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5BF0B6074D; Thu,  7 Jun 2018 17:44:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 866DF6063F;
	Thu,  7 Jun 2018 17:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 866DF6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935004AbeFGRoW (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:44:22 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51046 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933088AbeFGRoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:44:21 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fQyx1-0001Fs-QP; Thu, 07 Jun 2018 17:43:55 +0000
Date: Thu, 7 Jun 2018 18:43:55 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: syzbot <syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com>,
        avagin@openvz.org, davem@davemloft.net, dingtianhong@huawei.com,
        edumazet@google.com, elena.reshetova@intel.com,
        jasowang@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthew@mjdsystems.ca,
        mingo@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org, willemb@google.com
Subject: Re: KMSAN: uninit-value in _copy_to_iter (2)
Message-ID: <20180607174355.GR30522@ZenIV.linux.org.uk>
References: <000000000000a5b2b1056a86e98c@google.com>
 <000000000000cf4578056ab12452@google.com>
 <20180607183627-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607183627-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 06:38:48PM +0300, Michael S. Tsirkin wrote:
> #syz test: https://github.com/google/kmsan.git/master d2d741e5d1898dfde1a75ea3d29a9a3e2edf0617
> 
> Subject: vhost: fix info leak
> 
> Fixes: CVE-2018-1118
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index f0be5f35ab28..9beefa6ed1ce 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2345,6 +2345,9 @@ struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
>  	struct vhost_msg_node *node = kmalloc(sizeof *node, GFP_KERNEL);
>  	if (!node)
>  		return NULL;
> +
> +	/* Make sure all padding within the structure is initialized. */
> +	memset(&node->msg, 0, sizeof node->msg);

Umm...  Maybe kzalloc(), then?  You have

struct vhost_msg_node {
  struct vhost_msg msg;
  struct vhost_virtqueue *vq;
  struct list_head node;
};

and that's what, 68 bytes in msg, then either 4 bytes pointer or
4 bytes padding + 8 bytes pointer, then two pointers?  How much
does explicit partial memset() save you here?

>  	node->vq = vq;
>  	node->msg.type = type;
>  	return node;
