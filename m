Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA7EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E0521547
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E0521547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeI0VGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:06:12 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:50446 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbeI0VGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:06:12 -0400
Received: from localhost.localdomain (p200300E9D7234A78891558B353DFC2C9.dip0.t-ipconnect.de [IPv6:2003:e9:d723:4a78:8915:58b3:53df:c2c9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id B41D6C87C0;
        Thu, 27 Sep 2018 16:47:33 +0200 (CEST)
Subject: Re: [PATCH] ieee802154: remove a redundant local variable 'i'
To:     zhong jiang <zhongjiang@huawei.com>, davem@davemloft.net
Cc:     alex.aring@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1537368097-60101-1-git-send-email-zhongjiang@huawei.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <42999ee5-20c2-5d2c-4ca3-e5bb8f5a3864@datenfreihafen.org>
Date:   Thu, 27 Sep 2018 16:47:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1537368097-60101-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On 19/09/2018 16:41, zhong jiang wrote:
> The local variable 'i' is never used after being assigned.
> hence it should be redundant adn can be removed.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  net/ieee802154/nl802154.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
> index 99f6c25..5b90151 100644
> --- a/net/ieee802154/nl802154.c
> +++ b/net/ieee802154/nl802154.c
> @@ -445,7 +445,6 @@ static int nl802154_send_wpan_phy(struct cfg802154_registered_device *rdev,
>  {
>  	struct nlattr *nl_cmds;
>  	void *hdr;
> -	int i;
>  
>  	hdr = nl802154hdr_put(msg, portid, seq, flags, cmd);
>  	if (!hdr)
> @@ -508,7 +507,6 @@ static int nl802154_send_wpan_phy(struct cfg802154_registered_device *rdev,
>  	if (!nl_cmds)
>  		goto nla_put_failure;
>  
> -	i = 0;
>  #define CMD(op, n)							\
>  	do {								\
>  		if (rdev->ops->op) {					\
> 

Sorry, but this patch is wrong. The variable i is used in line 513
inside the CMD() macro. The compiler clearly tells this when running
with your patch:

net/ieee802154/nl802154.c: In function ‘nl802154_send_wpan_phy’:
net/ieee802154/nl802154.c:513:4: error: ‘i’ undeclared (first use in
this function)

I would appreciate if patches sent out would at least be compile tested.

regards
Stefan Schmidt
