Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161F4C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CF120843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CF120843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeICMwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 08:52:45 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:58476 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbeICMwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 08:52:45 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1fwkIj-0003Qs-Cc; Mon, 03 Sep 2018 10:33:37 +0200
Message-ID: <1535963610.3437.10.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: fix TX status reporting for ieee80211s
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Yuan-Chi Pang <fu3mo6goo@gmail.com>
Cc:     davem@davemloft.net, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 03 Sep 2018 10:33:30 +0200
In-Reply-To: <1535699575-5672-1-git-send-email-fu3mo6goo@gmail.com> (sfid-20180831_091323_224304_305F21B4)
References: <1535699575-5672-1-git-send-email-fu3mo6goo@gmail.com>
         (sfid-20180831_091323_224304_305F21B4)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-31 at 15:12 +0800, Yuan-Chi Pang wrote:

>  void ieee80211s_init(void);
>  void ieee80211s_update_metric(struct ieee80211_local *local,
> -			      struct sta_info *sta, struct sk_buff *skb);
> +			struct sta_info *sta, struct ieee80211_tx_status *st);

please keep things indented properly

>  void ieee80211s_update_metric(struct ieee80211_local *local,
> -		struct sta_info *sta, struct sk_buff *skb)
> +		struct sta_info *sta, struct ieee80211_tx_status *st)

and maybe fix the indentation here while you're changing it

>  {
> -	struct ieee80211_tx_info *txinfo = IEEE80211_SKB_CB(skb);
> -	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
> +	struct ieee80211_tx_info *txinfo = st->info;
>  	int failed;
>  
> -	if (!ieee80211_is_data(hdr->frame_control))
> -		return;

Why are you removing this condition? You didn't say anything about that.

I sort of see why (you no longer even have the skb/hdr), but you should
indicate why this is OK.
 
>  		rate_control_tx_status(local, sband, status);
> +		if (ieee80211_vif_is_mesh(&sta->sdata->vif))
> +			ieee80211s_update_metric(local, sta, status)

This is the only "real" change I guess, some more description about it
would be good.

I can sort of reverse engineer it from your commit log, but you should
be more explicit.

johannes
