Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFBEC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33BC0207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B/t4Ch3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33BC0207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbeJXUEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 16:04:01 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45987 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbeJXUEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 16:04:01 -0400
Received: by mail-lf1-f67.google.com with SMTP id c24-v6so3673952lfi.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 04:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AVeS+IaZEJucHxYD9CONZhvJSuR9Scjsnhgk8X4pErA=;
        b=B/t4Ch3ArzNOOb85n+w5yJIxPM1vokwwebNasEsNqlDDj/89FetVPb4X9jAZazKzNz
         gf5XuM5KOKemCVAKQ49el6CFdtv97/SDpUi2hQgZ1kdVY3zm8QC+Cf/W4kY1eE5eAZbI
         zipn859uwT1gzsVxsHqlrXYfXDOoZz/R3wNKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=AVeS+IaZEJucHxYD9CONZhvJSuR9Scjsnhgk8X4pErA=;
        b=jebAX48MhpxX2VxjMqV5kjKBvNMmE19spqlvAWoX21YxkmteCnOpVnFQxqDqP2y4Tm
         yyyhrR9DwtusjlTm0xwroUyNyNxrP8OuUnruv+bmjCfnU9Wv6zK4QZGoNIqOAI/q0s+d
         RjkX/CXSd8GfGRIjGj7iMpvJz9epywKN0uhZa6pSxVZye0VyKSB4J23l2hCqPGLbLRPC
         Tzwkb2/mNUfDTuGTooBV36b0tO4Ai2+VQZylcvGey8Gae8GIPhXQbWCVNn8qSkhtTW/y
         /nx4mpYWd9p5h10e3E+ZuGTRPWPT9f1/0LFWO0yKHsz9nUlk3pTozsP2Rbl5qjmLqo/b
         6WKw==
X-Gm-Message-State: AGRZ1gI4DCKsEY1YljYLm9lQETi/4KzYWYlPUS2xDtOnFAnMmtX7YpkN
        GerGN67gSJxXpZBHdST5aTV/pA==
X-Google-Smtp-Source: AJdET5ewVV4nOVx3Lco8FJd0VY/HYtAesmiANgFdHzOKE26ciutOfjwvHI7Cira4WQdyaYC/jSZfxA==
X-Received: by 2002:a19:4345:: with SMTP id m5mr3223146lfj.142.1540380973365;
        Wed, 24 Oct 2018 04:36:13 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id 18-v6sm387016ljg.50.2018.10.24.04.36.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 04:36:12 -0700 (PDT)
Date:   Wed, 24 Oct 2018 14:36:10 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexander.h.duyck@intel.com
Subject: Re: [RFC PATCH net-next 3/4] net: ethernet: ti: cpsw: fix vlan mcast
Message-ID: <20181024113609.GC4892@khorivan>
Mail-Followup-To: grygorii.strashko@ti.com, davem@davemloft.net,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexander.h.duyck@intel.com
References: <20181016182035.18234-1-ivan.khoronzhuk@linaro.org>
 <20181016182035.18234-4-ivan.khoronzhuk@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181016182035.18234-4-ivan.khoronzhuk@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 09:20:34PM +0300, Ivan Khoronzhuk wrote:
>At this moment, mcast addresses are added only for real device only
>(reserved vlans for dual-emac mode), even if a mcast address was added
>for some vlan only, thus ALE doesn't have corresponding vlan mcast
>entries after vlan socket joined multicast group. So ALE drops vlan
>frames with mcast addresses intended for vlans and potentially can
>receive mcast frames for base ndev. That's not correct. So, fix it by
>creating only vlan/mcast entries as requested. Patch doesn't use any
>additional lists and is based on device mc address list and cpsw ALE
>table entries.
>
>Also, move device to allmulti state if no space for new mcast entries.
>
>Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

I won't update allmulti state on v2, will do that separately as it
requires also splitting allmulti between interfaces in dual-mac mode.
Would be nice to move allmulti and promisc to ndo_change_rx_flags()
and do updates only if flag is changed, not for every address change.

Also there is an ability to set allmulti per vlan device and even
dev->allmulti counter can be used for that and it works, but in case
of allmulti flag there is no event from dev core if it's already set
(only allmuilti counter is changed w/o event). Thus no event to
segregate it between vlans. Adding update to dev core can lead to
more frequent rx_mode event and w/o reason for those devices who
doesn't care. I'm just wondering, why not to add smth like
IFF_VLAN_MCAST_FLT to dev->priv_flags and based on it generate
event differently or even do more stuff ....

Or leave it as is and set allmulti for every vlan, that seems
like a stub.

[...]

-- 
Regards,
Ivan Khoronzhuk
