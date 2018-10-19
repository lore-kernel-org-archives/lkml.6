Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F556ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0128621479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F3Jpyy10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0128621479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbeJSUKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:10:02 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43353 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbeJSUKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:10:02 -0400
Received: by mail-lf1-f68.google.com with SMTP id p34-v6so25040405lfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 05:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1H++qMzwQneFE3P82ChWKgRBDAJgC3rv7qUfQ9N9wnI=;
        b=F3Jpyy10kGvRwPwjPDIF9rFI6/HLaR4UofOkCuUmLa0QatWDlFZOoVkI755l/fOA+1
         a3HBral7r4ge1IIdt/QxgbpSYD2ZO1DVmBN8m2pgykRL6ztckkzLF7mAXgAHzais7Ujr
         LdK5aYOXD1Ga5DrGjkkF8cAF8WjFsykFM6mxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=1H++qMzwQneFE3P82ChWKgRBDAJgC3rv7qUfQ9N9wnI=;
        b=K+PD8QfAztH/aSYa+N4/lLHnpskxYkeX1a+EOSGrRktL6QNCmqqBbBkgAd31LDBJCK
         Hi33oHtjQKkK22cDIQcRdiVh79FfN8pRgG/NytY9hGeNp+g+MJdi1JtNM+jP5RjDgk1i
         090udItU/ErjqP8lkeU4IPMhMGkU838nI0mHcZbQkAFFOdgB8q/u8pvgmSRu5AXdYBoG
         89Zkp4e/wjHpze1H1fmxUdfyGm/YvUI+7EVVgzYq/XmCh2D7LFUPNXKP4wND4HQDUJsa
         DASfbIcA/Jq23sASCuO7TgRPGxuWwEtK6EFx3oW9ubIL6PJZaCi3rqHFgRmAYX9ym1Wf
         Rkpg==
X-Gm-Message-State: ABuFfoguZJhx52sDD8O9LLxflTc7TOmdWsnzr3xvQ9J1JxalrWOTDKME
        fBTXZ4x4E/8xOKGoBfW82ob2OQ==
X-Google-Smtp-Source: ACcGV6098NjmZuB/ObP6P8El6aEdSyCzaK7lyCtZeJ1LWy/SWiPuf/0ZTZPQkrty/21Hl0AReIhzzA==
X-Received: by 2002:a19:d612:: with SMTP id n18-v6mr2749803lfg.4.1539950652883;
        Fri, 19 Oct 2018 05:04:12 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id p140-v6sm3848811lfe.71.2018.10.19.05.04.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 05:04:12 -0700 (PDT)
Date:   Fri, 19 Oct 2018 15:04:09 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     davem@davemloft.net, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: don't flush mcast
 entries while switch promisc mode
Message-ID: <20181019120408.GA3909@khorivan>
Mail-Followup-To: Grygorii Strashko <grygorii.strashko@ti.com>,
        davem@davemloft.net, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181018180006.7065-1-ivan.khoronzhuk@linaro.org>
 <6c34a3ce-dbee-538e-bda7-8dd485315267@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6c34a3ce-dbee-538e-bda7-8dd485315267@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 07:03:06PM -0500, Grygorii Strashko wrote:
>
>
>On 10/18/18 1:00 PM, Ivan Khoronzhuk wrote:
>>No need now to flush mcast entries in switch mode while toggling to
>>promiscuous mode. It's not needed as vlan reg_mcast = ALL_PORTS
>>and mcast/vlan ports = ALL_PORTS, the same happening for vlan
>>unreg_mcast, it's set to ALL_PORT_MASK just after calling promisc
>>mode routine by calling set allmulti. I suppose main reason to flush
>>them is to use unreg_mcast to receive all to host port. Thus, now, all
>>mcast packets are received anyway and no reason to flush mcast entries
>>unsafely, as they were synced with __dev_mc_sync() previously and are
>>not restored. Another way is to _dev_mc_unsync() them, but no need.
>
>User have possibility to add additional mcast entries or edit existing 
>in switch-mode, which is now done using custom tool. So, Host in 
>promisc
>mode will not receive packets for mcast address X if port mask for this
>addr set to (ALL_PORTS - HOST_PORT). Am I missing smth?

I didn't take into account the custom tool changing entries directly,
but even in this case there is at least a couple of interesting
questions:

1) Before the patch applied only several days ago -
   5da1948969bc1991920987ce4361ea56046e5a98
   "ti: cpsw: fix lost of mcast packets while rx_mode update"
   It was impossible to do correctly anyway, as all mcast entries not
   in the mc list were flushed (after rx_mode cb), by:
   cpsw_ale_flush_multicast(cpsw->ale, ALE_ALL_PORTS, vid);
   and those in mc, rewritten by adding them back in corrected form.
   ... or this cb was not supposed to be called at all ...

2) What is the reason to add mcast switch entires
   (ALL_PORTS - HOST_PORT) if its function is added anyway by
   unreq_mcast & (ALL_PORTS - HOST_PORT) ?
   So, doesn't matter it's added or not - it will work :-|.

3) Even so, toggling promisc mode will clear all these changes anyway,
   even I will call _dev_mc_unsync() after flushing them.

4) If user can tune ALE table by hand, what stops him do it after moving
   to promisc mode, seems he knows what he's doing?

5) It could be possible only for not default vlan entries, but mcast
   vlan support is not supported yet. Who is gona restore those
   entries after promisc off?

This behaviour is arguable, and flushing mcast entries can bring more
issues then leaving. For me it doesn't matter, I can archive the same
by adding after flush one line, it's even shorter:
__dev_mc_unsync(priv->ndev, NULL);


>
>>
>>Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>>---
>>
>>Based on net-next/master
>>Tasted on am572x EVM and BBB
>>
>>  drivers/net/ethernet/ti/cpsw.c | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>>diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
>>index 226be2a56c1f..0e475020a674 100644
>>--- a/drivers/net/ethernet/ti/cpsw.c
>>+++ b/drivers/net/ethernet/ti/cpsw.c
>>@@ -638,9 +638,6 @@ static void cpsw_set_promiscious(struct net_device *ndev, bool enable)
>>  			} while (time_after(timeout, jiffies));
>>  			cpsw_ale_control_set(ale, 0, ALE_AGEOUT, 1);
>>-			/* Clear all mcast from ALE */
>>-			cpsw_ale_flush_multicast(ale, ALE_ALL_PORTS, -1);
>>-
>>  			/* Flood All Unicast Packets to Host port */
>>  			cpsw_ale_control_set(ale, 0, ALE_P0_UNI_FLOOD, 1);
>>  			dev_dbg(&ndev->dev, "promiscuity enabled\n");
>>
>
>-- 
>regards,
>-grygorii

-- 
Regards,
Ivan Khoronzhuk
