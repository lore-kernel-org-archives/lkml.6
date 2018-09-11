Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19148C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA2620865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 06:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA2620865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbeIKLpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 07:45:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726483AbeIKLpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 07:45:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B5E04406F8B9;
        Tue, 11 Sep 2018 06:47:49 +0000 (UTC)
Received: from localhost (ovpn-204-197.brq.redhat.com [10.40.204.197])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B60C2156889;
        Tue, 11 Sep 2018 06:47:48 +0000 (UTC)
Date:   Tue, 11 Sep 2018 08:47:46 +0200
From:   Jiri Benc <jbenc@redhat.com>
To:     Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ip6_gre: simplify gre header parsing in ip6gre_err
Message-ID: <20180911084746.486bc78e@redhat.com>
In-Reply-To: <F6F07B41-345D-4416-B9C7-D5509715D33F@cmss.chinamobile.com>
References: <1536567909-25089-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
        <20180910173640.117bf42f@redhat.com>
        <F6F07B41-345D-4416-B9C7-D5509715D33F@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 11 Sep 2018 06:47:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 11 Sep 2018 06:47:49 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jbenc@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018 10:19:31 +0800, Haishuang Yan wrote:
> Since csum_err may not be used outside, how about refactoring gre_parse_header function like this:
> 
> --- a/net/ipv4/gre_demux.c
> +++ b/net/ipv4/gre_demux.c
> @@ -86,7 +86,7 @@ int gre_parse_header(struct sk_buff *skb, struct tnl_ptk_info *tpi,
> 
>         options = (__be32 *)(greh + 1);
>         if (greh->flags & GRE_CSUM) {
> -               if (skb_checksum_simple_validate(skb)) {
> +               if (csum_err && skb_checksum_simple_validate(skb)) {

Something like this, yes.

Thanks!

 Jiri
