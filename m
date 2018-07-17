Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B911EECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75291208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75291208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbeGQGSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 02:18:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41640 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727293AbeGQGSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 02:18:40 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9F12D401EF05;
        Tue, 17 Jul 2018 05:47:49 +0000 (UTC)
Received: from epycfail (ovpn-200-23.brq.redhat.com [10.40.200.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AFB322026D68;
        Tue, 17 Jul 2018 05:47:47 +0000 (UTC)
Date:   Tue, 17 Jul 2018 07:47:42 +0200
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Boris Pismenny <borisp@mellanox.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20180717074742.62101999@epycfail>
In-Reply-To: <20180717123306.3e030fde@canb.auug.org.au>
References: <20180717123306.3e030fde@canb.auug.org.au>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 17 Jul 2018 05:47:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 17 Jul 2018 05:47:49 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'sbrivio@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2018 12:33:06 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> Today's linux-next merge of the net-next tree got a conflict in:
> 
>   include/linux/skbuff.h
> 
> between commit:
> 
>   8b7008620b84 ("net: Don't copy pfmemalloc flag in __copy_skb_header()")
> 
> from the net tree and commit:
> 
>   784abe24c903 ("net: Add decrypted field to skb")
> 
> from the net-next tree.
>
> [...]
>
> @@@ -736,7 -737,11 +738,11 @@@ struct sk_buff 
>   				peeked:1,
>   				head_frag:1,
>   				xmit_more:1,
>  +				pfmemalloc:1;
> + #ifdef CONFIG_TLS_DEVICE
>  -				decrypted:1;
>  -#else
>  -				__unused:1;
> ++	__u8			decrypted:1,
> ++				__unused:7;
> + #endif
>   
>   	/* fields enclosed in headers_start/headers_end are copied
>   	 * using a single memcpy() in __copy_skb_header()

I checked the layout of sk_buff after this, we already had a 1-byte
hole there, that now becomes a 7-bits hole (or disappears with
__unused). That's fine.

Boris, I read your commit 784abe24c903 ("net: Add decrypted field to
skb") just now.

I think 'decrypted' shouldn't go there, because you then copy it on
copy and clone: if you move if after headers_start[0] you don't need to
explicitly copy it in __copy_skb_header().

While at it, the copy you added in __skb_clone() is redundant (no
matter the position of 'decrypted').

I can send a clean-up patch against net-next. I guess this might cause
again a linux-next merge conflict, but it's again trivial (the __unused
field above would go away).

-- 
Stefano
