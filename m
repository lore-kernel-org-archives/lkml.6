Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA3CC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38470205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 17:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38470205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=opteya.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeIEWOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 18:14:47 -0400
Received: from ou.quest-ce.net ([195.154.187.82]:42241 "EHLO ou.quest-ce.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeIEWOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 18:14:47 -0400
Received: from [37.169.125.128] (helo=test.quest-ce.net)
        by ou.quest-ce.net with esmtpsa (TLS1.1:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <ydroneaud@opteya.com>)
        id 1fxbMB-000DEW-Cb; Wed, 05 Sep 2018 19:12:43 +0200
Message-ID: <1c57005277ac723ebb670a1dc847a205f0529d53.camel@opteya.com>
From:   Yann Droneaud <ydroneaud@opteya.com>
To:     David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        codalist@coda.cs.cmu.edu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 05 Sep 2018 19:12:37 +0200
In-Reply-To: <153616291029.23468.16421004714304578585.stgit@warthog.procyon.org.uk>
References: <153616286704.23468.584491117180383924.stgit@warthog.procyon.org.uk>
         <153616291029.23468.16421004714304578585.stgit@warthog.procyon.org.uk>
Organization: OPTEYA
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 37.169.125.128
X-SA-Exim-Mail-From: ydroneaud@opteya.com
Subject: Re: [PATCH 05/11] UAPI: coda: Don't use internal kernel structs in
 UAPI
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on ou.quest-ce.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 05 septembre 2018 à 16:55 +0100, David Howells a écrit :
> The size and layout of internal kernel structures may not be relied
> upon outside of the kernel and may even change in a containerised
> environment if a container image is frozen and shifted to another
> machine.
> 
> Excise these from Coda's upc_req struct.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jan Harkes <jaharkes@cs.cmu.edu>
> cc: coda@cs.cmu.edu
> cc: codalist@coda.cs.cmu.edu
> cc: linux-fsdevel@vger.kernel.org
> ---
> 
>  include/uapi/linux/coda_psdev.h |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/uapi/linux/coda_psdev.h b/include/uapi/linux/coda_psdev.h
> index aa6623efd2dd..9c3acde393cd 100644
> --- a/include/uapi/linux/coda_psdev.h
> +++ b/include/uapi/linux/coda_psdev.h
> @@ -10,14 +10,18 @@
>  
>  /* messages between coda filesystem in kernel and Venus */
>  struct upc_req {
> +#ifdef __KERNEL__
>  	struct list_head    uc_chain;
> +#endif
>  	caddr_t	            uc_data;
>  	u_short	            uc_flags;
>  	u_short             uc_inSize;  /* Size is at most 5000 bytes */
>  	u_short	            uc_outSize;
>  	u_short	            uc_opcode;  /* copied from data to save lookup */
>  	int		    uc_unique;
> +#ifdef __KERNEL__
>  	wait_queue_head_t   uc_sleep;   /* process' wait queue */
> +#endif
>  };
>  

This structure should not have been exposed to userspace in the first
place: it's unusable by userspace as it is. It was incorrect to have it
outside of #ifdef __KERNEL__ before commit 607ca46e97a1b ... 

... and it's not exchanged between kernel and userspace, see
coda_psdev_write():

        struct upc_req *req = NULL;

        ...

        if (copy_from_user(req->uc_data, buf, nbytes)) {
                req->uc_flags |= CODA_REQ_ABORT;
                wake_up(&req->uc_sleep);
                retval = -EFAULT;
                goto out;
        }

Only data, a caddr_t, is read from userspace.

So the structure can be moved back to <linux/coda_psdev.h>.

>  #define CODA_REQ_ASYNC  0x1
> 

All CODA_REQ_* defines internals to kernel side and not exchanged with userspace.

Please move them back to <linux/coda_psdev.h>

Regards.

-- 
Yann Droneaud
OPTEYA



