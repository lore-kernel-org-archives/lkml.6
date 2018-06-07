Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id MSnUI7pxGVvBbwAAmS7hNA
	; Thu, 07 Jun 2018 17:59:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 18E906074D; Thu,  7 Jun 2018 17:59:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7E56760590;
	Thu,  7 Jun 2018 17:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7E56760590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935987AbeFGR7K (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:59:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935049AbeFGR7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:59:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 20943401EF1B;
        Thu,  7 Jun 2018 17:59:08 +0000 (UTC)
Received: from redhat.com (ovpn-120-226.rdu2.redhat.com [10.10.120.226])
        by smtp.corp.redhat.com (Postfix) with SMTP id D12E91C703;
        Thu,  7 Jun 2018 17:59:06 +0000 (UTC)
Date: Thu, 7 Jun 2018 20:59:06 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: syzbot <syzbot+87cfa083e727a224754b@syzkaller.appspotmail.com>,
        avagin@openvz.org, davem@davemloft.net, dingtianhong@huawei.com,
        edumazet@google.com, elena.reshetova@intel.com,
        jasowang@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthew@mjdsystems.ca,
        mingo@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org, willemb@google.com
Subject: Re: KMSAN: uninit-value in _copy_to_iter (2)
Message-ID: <20180607205611-mutt-send-email-mst@kernel.org>
References: <000000000000a5b2b1056a86e98c@google.com>
 <000000000000cf4578056ab12452@google.com>
 <20180607183627-mutt-send-email-mst@kernel.org>
 <20180607174355.GR30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607174355.GR30522@ZenIV.linux.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 07 Jun 2018 17:59:08 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 07 Jun 2018 17:59:08 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 06:43:55PM +0100, Al Viro wrote:
> On Thu, Jun 07, 2018 at 06:38:48PM +0300, Michael S. Tsirkin wrote:
> > #syz test: https://github.com/google/kmsan.git/master d2d741e5d1898dfde1a75ea3d29a9a3e2edf0617
> > 
> > Subject: vhost: fix info leak
> > 
> > Fixes: CVE-2018-1118
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index f0be5f35ab28..9beefa6ed1ce 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -2345,6 +2345,9 @@ struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
> >  	struct vhost_msg_node *node = kmalloc(sizeof *node, GFP_KERNEL);
> >  	if (!node)
> >  		return NULL;
> > +
> > +	/* Make sure all padding within the structure is initialized. */
> > +	memset(&node->msg, 0, sizeof node->msg);
> 
> Umm...  Maybe kzalloc(), then?  You have
> 
> struct vhost_msg_node {
>   struct vhost_msg msg;
>   struct vhost_virtqueue *vq;
>   struct list_head node;
> };
> 
> and that's what, 68 bytes in msg, then either 4 bytes pointer or
> 4 bytes padding + 8 bytes pointer, then two pointers?  How much
> does explicit partial memset() save you here?

Yes but 0 isn't a nop here so if this struct is used without
a sensible initialization, it will crash elsewhere.
I prefer KASAN to catch such uses.


> >  	node->vq = vq;
> >  	node->msg.type = type;
> >  	return node;
