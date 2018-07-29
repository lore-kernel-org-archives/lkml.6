Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65D8C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 13:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7F620873
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 13:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C7F620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbeG2P3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 11:29:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726324AbeG2P3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 11:29:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB2B6F2B3F;
        Sun, 29 Jul 2018 13:59:08 +0000 (UTC)
Received: from treble (ovpn-120-73.rdu2.redhat.com [10.10.120.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D3AD76CC;
        Sun, 29 Jul 2018 13:59:08 +0000 (UTC)
Date:   Sun, 29 Jul 2018 08:59:06 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jeremy Cline <jcline@redhat.com>
Cc:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] net: socket: Fix potential spectre v1 gadget in
 sock_is_registered
Message-ID: <20180729135906.lgqo5ue6it3hl2da@treble>
References: <20180727224302.5503-1-jcline@redhat.com>
 <20180727224302.5503-3-jcline@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180727224302.5503-3-jcline@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Sun, 29 Jul 2018 13:59:08 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Sun, 29 Jul 2018 13:59:08 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 10:43:02PM +0000, Jeremy Cline wrote:
> 'family' can be a user-controlled value, so sanitize it after the bounds
> check to avoid speculative out-of-bounds access.
> 
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeremy Cline <jcline@redhat.com>
> ---
>  net/socket.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/socket.c b/net/socket.c
> index f15d5cbb3ba4..608e29ae6baf 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -2672,7 +2672,8 @@ EXPORT_SYMBOL(sock_unregister);
>  
>  bool sock_is_registered(int family)
>  {
> -	return family < NPROTO && rcu_access_pointer(net_families[family]);
> +	return family < NPROTO &&
> +		rcu_access_pointer(net_families[array_index_nospec(family, NPROTO)]);
>  }
>  
>  static int __init sock_init(void)

This is another one where I think it would be better to do the nospec
clamp higher up the call chain.  The untrusted 'family' value comes from
__sock_diag_cmd():

__sock_diag_cmd
  sock_load_diag_module
    sock_is_registered

That function has a bounds check, and also uses the value in some other
array accesses:

	if (req->sdiag_family >= AF_MAX)
		return -EINVAL;

	if (sock_diag_handlers[req->sdiag_family] == NULL)
		sock_load_diag_module(req->sdiag_family, 0);

	mutex_lock(&sock_diag_table_mutex);
	hndl = sock_diag_handlers[req->sdiag_family];
	...

So I think clamping 'req->sdiag_family' right after the bounds check
would be the way to go.

-- 
Josh
