Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C69C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976C62075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 976C62075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbeIFTiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:38:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45692 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725819AbeIFTiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:38:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 98649412CA60;
        Thu,  6 Sep 2018 15:02:05 +0000 (UTC)
Received: from redhat.com (ovpn-120-232.rdu2.redhat.com [10.10.120.232])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3813C2166B41;
        Thu,  6 Sep 2018 15:02:05 +0000 (UTC)
Date:   Thu, 6 Sep 2018 11:02:04 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-api@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] UAPI: virtio_net: Fix use of C++ keywords as
 structural members [ver #2]
Message-ID: <20180906104208-mutt-send-email-mst@kernel.org>
References: <153622549721.14298.8116794954073122489.stgit@warthog.procyon.org.uk>
 <153622552270.14298.14568295161017777604.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153622552270.14298.14568295161017777604.stgit@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 06 Sep 2018 15:02:05 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 06 Sep 2018 15:02:05 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 10:18:42AM +0100, David Howells wrote:
> The virtio_net_ctrl_hdr struct uses a C++ keyword as structural members.  Fix
> this by inserting an anonymous union that provides an alternative name and
> then hide the reserved name in C++.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: "Michael S. Tsirkin" <mst@redhat.com>
> cc: Jason Wang <jasowang@redhat.com>
> cc: virtualization@lists.linux-foundation.org
> ---
> 
>  include/uapi/linux/virtio_net.h |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index a3715a3224c1..967142bc0e05 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -150,7 +150,12 @@ struct virtio_net_hdr_mrg_rxbuf {
>   * command goes in between.
>   */
>  struct virtio_net_ctrl_hdr {
> -	__u8 class;
> +	union {
> +#ifndef __cplusplus
> +		__u8 class;
> +#endif
> +		__u8 _class;
> +	};
>  	__u8 cmd;
>  } __attribute__((packed));
>  

So if we are going to do this, I think I'd prefer something like:

struct virtio_net_ctrl_hdr_v2 {
	__u8 cmd_class;
  	__u8 cmd;
};

And then hide the whole old structure. This also gets rid of the packed
keyword which we don't really need here.

Only issue is virtio_net_ctrl_hdr_v2 is ugly. But oh well.

And then rework at least QEMU to use the v2 of the header.

Quite a bit of churn, so I don't think it makes sense to apply just this
one in isolation - only if rest of the changes go in.


-- 
MST
