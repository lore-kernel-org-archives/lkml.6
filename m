Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD388C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DAB920BEC
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DAB920BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbeGLLwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:52:31 -0400
Received: from nautica.notk.org ([91.121.71.147]:56412 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbeGLLwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:52:31 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id F23D5C009; Thu, 12 Jul 2018 13:43:19 +0200 (CEST)
Date:   Thu, 12 Jul 2018 13:43:04 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Tomas Bortoli <tomasbortoli@gmail.com>
Cc:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net,
        viro@ZenIV.linux.org.uk, davem@davemloft.net,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Subject: Re: [V9fs-developer] [PATCH] p9_parse_header() validate PDU length
Message-ID: <20180712114304.GB17774@nautica>
References: <20180712110211.25535-1-tomasbortoli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180712110211.25535-1-tomasbortoli@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Bortoli wrote on Thu, Jul 12, 2018:
> This patch adds checks to the p9_parse_header() function to
> verify that the length found within the header coincides with the actual
> length of the PDU. Furthermore, it checks that the length stays within the
> acceptable range. To do this the patch brings the actual length of the PDU
> from the different transport layers (rdma and virtio). For TCP (trans_fd.c)
> the length is not know before, so we get it from the header but we check it
> anyway that it's within the valid range.

Just a note on transports here, I totally had forgotten about trans_xen
when we discussed this earlier as it is fairly new, but it looks like it
sets the length in the fcall properly so it should work without any
change.

I however cannot test trans=xen, so if someone could either point me to
how to set that up (I couldn't find any decent documentation) or do some
very basic tests that would be great.

> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
> Reported-by: syzbot+65c6b72f284a39d416b4@syzkaller.appspotmail.com

Looks good to me, as the rdma/virtio part come from my suggestion:
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>

> diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
> index 3d414acb7015..002badbcc9c0 100644
> --- a/net/9p/trans_rdma.c
> +++ b/net/9p/trans_rdma.c
> @@ -319,7 +319,7 @@ recv_done(struct ib_cq *cq, struct ib_wc *wc)
>  
>  	if (wc->status != IB_WC_SUCCESS)
>  		goto err_out;
> -
> +	c->rc->size = wc->byte_len;

(nitpick, I'd keep the empty line here. If you don't mind I'll add it
back in my tree; this doesn't warrant a v2)

-- 
Dominique Martinet
