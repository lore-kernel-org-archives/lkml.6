Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3614C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7A420870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:36:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7A420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbeIJUbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:31:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44834 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728043AbeIJUbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:31:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 78C2B40241C4;
        Mon, 10 Sep 2018 15:36:45 +0000 (UTC)
Received: from localhost (ovpn-204-175.brq.redhat.com [10.40.204.175])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 458862166BA3;
        Mon, 10 Sep 2018 15:36:42 +0000 (UTC)
Date:   Mon, 10 Sep 2018 17:36:40 +0200
From:   Jiri Benc <jbenc@redhat.com>
To:     Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ip6_gre: simplify gre header parsing in ip6gre_err
Message-ID: <20180910173640.117bf42f@redhat.com>
In-Reply-To: <1536567909-25089-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
References: <1536567909-25089-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 10 Sep 2018 15:36:45 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 10 Sep 2018 15:36:45 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jbenc@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2018 16:25:09 +0800, Haishuang Yan wrote:
> +	if (gre_parse_header(skb, &tpi, &csum_err, htons(ETH_P_IPV6),
> +			     offset) < 0) {
> +		if (!csum_err)		/* ignore csum errors. */
> +			return;
>  	}

gre_parse_header stops parsing when csum_err is encountered. Which
means tpi.key is undefined...

>  
> -	if (!pskb_may_pull(skb, offset + grehlen))
> -		return;
>  	ipv6h = (const struct ipv6hdr *)skb->data;
> -	greh = (const struct gre_base_hdr *)(skb->data + offset);
> -	key = key_off ? *(__be32 *)(skb->data + key_off) : 0;
> -
>  	t = ip6gre_tunnel_lookup(skb->dev, &ipv6h->daddr, &ipv6h->saddr,
> -				 key, greh->protocol);
> +				 tpi.key, tpi.proto);

...and can't be used here.

 Jiri
