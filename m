Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17C9C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75DA2098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b="KIvgpaJ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75DA2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=blackhole.kfki.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeJCPRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 11:17:24 -0400
Received: from smtp1.kfki.hu ([148.6.0.26]:37208 "EHLO smtp1.kfki.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbeJCPRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 11:17:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp1.kfki.hu (Postfix) with ESMTP id CDDBB3C8008F;
        Wed,  3 Oct 2018 10:30:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        blackhole.kfki.hu; h=mime-version:user-agent:references
        :message-id:in-reply-to:from:from:date:date:received:received
        :received; s=20151130; t=1538555398; x=1540369799; bh=Qnw4RO6D0s
        ADF7cBf/kD2/lFJbRGPLk7ONwpLrB5ZvA=; b=KIvgpaJ/ZAHECeME4e8PUGG0Z3
        waRZuX5jzh40w/tZGTWZo8kQsvfHLxgeFsShfvMDWlxsP07eLDI95f4SOGGoEuGI
        P0tf9ybV2qzHlslh2RYUzslJ4SUN6qRbIi5qRS4nq0xJlYiyStVed/yusYaLKbLw
        ECn93FQrehmOATkOQ=
X-Virus-Scanned: Debian amavisd-new at smtp1.kfki.hu
Received: from smtp1.kfki.hu ([127.0.0.1])
        by localhost (smtp1.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP; Wed,  3 Oct 2018 10:29:58 +0200 (CEST)
Received: from blackhole.kfki.hu (blackhole.szhk.kfki.hu [148.6.240.2])
        by smtp1.kfki.hu (Postfix) with ESMTP id 6A4273C80026;
        Wed,  3 Oct 2018 10:29:58 +0200 (CEST)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
        id 0698624A6D; Wed,  3 Oct 2018 10:29:57 +0200 (CEST)
Date:   Wed, 3 Oct 2018 10:29:57 +0200 (CEST)
From:   Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
To:     Lance Roy <ldr709@gmail.com>
cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 14/16] netfilter: Replace spin_is_locked() with lockdep
In-Reply-To: <20181003053902.6910-15-ldr709@gmail.com>
Message-ID: <alpine.DEB.2.11.1810031028410.30353@blackhole.kfki.hu>
References: <20181003053902.6910-1-ldr709@gmail.com> <20181003053902.6910-15-ldr709@gmail.com>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Oct 2018, Lance Roy wrote:

> lockdep_assert_held() is better suited to checking locking requirements,
> since it won't get confused when someone else holds the lock. This is
> also a step towards possibly removing spin_is_locked().
> 
> Signed-off-by: Lance Roy <ldr709@gmail.com>
> Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> Cc: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
> Cc: Florian Westphal <fw@strlen.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: <netfilter-devel@vger.kernel.org>
> Cc: <coreteam@netfilter.org>
> Cc: <netdev@vger.kernel.org>
> ---
>  net/netfilter/ipset/ip_set_hash_gen.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>

Best regards,
Jozsef

> diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/ip_set_hash_gen.h
> index 8a33dac4e805..e287da68d5fa 100644
> --- a/net/netfilter/ipset/ip_set_hash_gen.h
> +++ b/net/netfilter/ipset/ip_set_hash_gen.h
> @@ -15,7 +15,7 @@
>  
>  #define __ipset_dereference_protected(p, c)	rcu_dereference_protected(p, c)
>  #define ipset_dereference_protected(p, set) \
> -	__ipset_dereference_protected(p, spin_is_locked(&(set)->lock))
> +	__ipset_dereference_protected(p, lockdep_is_held(&(set)->lock))
>  
>  #define rcu_dereference_bh_nfnl(p)	rcu_dereference_bh_check(p, 1)
>  
> -- 
> 2.19.0
> 
> 

-
E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.mta.hu
PGP key : http://www.kfki.hu/~kadlec/pgp_public_key.txt
Address : Wigner Research Centre for Physics, Hungarian Academy of Sciences
          H-1525 Budapest 114, POB. 49, Hungary
