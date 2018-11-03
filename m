Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55E2C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6063720833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 17:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6063720833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbeKDCP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 22:15:57 -0400
Received: from smtprelay0172.hostedemail.com ([216.40.44.172]:53648 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726849AbeKDCP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 22:15:57 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 1A4C8100E86C2;
        Sat,  3 Nov 2018 17:04:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: move52_5dddede97f55d
X-Filterd-Recvd-Size: 1737
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sat,  3 Nov 2018 17:04:04 +0000 (UTC)
Message-ID: <945a90d62aa45c4b53349ba0a104574759d40efe.camel@perches.com>
Subject: Re: [PATCH] tcp: do not update snd_una if it is same with ack_seq
From:   Joe Perches <joe@perches.com>
To:     Yafang Shao <laoar.shao@gmail.com>, davem@davemloft.net,
        edumazet@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 03 Nov 2018 10:04:03 -0700
In-Reply-To: <1541264071-9905-1-git-send-email-laoar.shao@gmail.com>
References: <1541264071-9905-1-git-send-email-laoar.shao@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-11-04 at 00:54 +0800, Yafang Shao wrote:
> In the slow path, TCP_SKB_SB(skb)->ack_seq may be same with tp->snd_una,
> and under this condition we don't need to update the snd_una.
> 
> Furthermore, tcp_ack_update_window() is only called in slow path,
> so introducing this check won't affect the fast path processing.
[]
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
[]
> @@ -3610,7 +3611,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
>  	if (flag & FLAG_UPDATE_TS_RECENT)
>  		tcp_replace_ts_recent(tp, TCP_SKB_CB(skb)->seq);
>  
> -	if (!(flag & FLAG_SLOWPATH) && after(ack, prior_snd_una)) {
> +	if (!(flag & FLAG_SLOWPATH) && flag & FLAG_SND_UNA_ADVANCED) {

stylistic nit:

While the precedence is correct in any case,
perhaps adding parentheses around
	flag & FLAG_SND_UNA_ADVANCED
would make it more obvious.


