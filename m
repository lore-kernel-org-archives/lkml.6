Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B881EC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2612075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 16:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2612075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeIEVZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 17:25:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46418 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeIEVZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 17:25:42 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 85981C49;
        Wed,  5 Sep 2018 16:54:39 +0000 (UTC)
Date:   Wed, 5 Sep 2018 18:54:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-api@vger.kernel.org, linux-kbuild@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] UAPI: virtio_net: Fix use of C++ keywords as
 structural members
Message-ID: <20180905165436.GA25206@kroah.com>
References: <153616286704.23468.584491117180383924.stgit@warthog.procyon.org.uk>
 <153616289529.23468.7498785670556620808.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153616289529.23468.7498785670556620808.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 04:54:55PM +0100, David Howells wrote:
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

Ugh, ick, no!

Come on now, either put the whole C namespace stuff around the file, or
don't care about this at all.  Doing this whack-a-mole style is a mess.

"class" is a fine variable name for C code, there's no reason this has
to change here at all.

greg k-h
