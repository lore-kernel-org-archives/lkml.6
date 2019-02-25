Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28477C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AEE20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="KIoCNntS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfBYXWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 18:22:02 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46106 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728917AbfBYXWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 18:22:01 -0500
Received: by mail-ed1-f65.google.com with SMTP id f2so9106506edy.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 15:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+l7fWVEIc4qJFPlvVEUgH+VtZSJjbrNPa6C7HsCZzqE=;
        b=KIoCNntS9Zd1pfYf25aEcKk9gKvUDrar9kV93q+huP6b07Hzytn/8Rga9/ScegPw26
         arzWnM0L3KO2TnP/9oaHkBOQsmoFqr3fa8+sZqvWPXeHzmn/rNlO+h/W0zJKtvHBQG9n
         ibL/v9u75eGhiwCmwtb2DhySSGsSJY23h8XKfkzEIS9uGGnw92siqqEHLmhZ+M9S337Q
         c1+SXimWF/j6kVCQr4/rIeYLylOHJKsF/D1owTJ4WAwcKLWL5Mo6i1sADbKuX8V/wk7q
         hiXywFXpf59bMZ94B780To2+mRdY0GVsqE606tCtji0jTDzre6Z2UTXn7664vfGK4HS3
         EyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+l7fWVEIc4qJFPlvVEUgH+VtZSJjbrNPa6C7HsCZzqE=;
        b=Xoys893nasIX9BdFEWJ7H08xNMGETYFsdrrQwHCmZYKm7AHeyOyHa2tH4GT4jq6d+2
         Zv3Axe7++y2s40g2Hfsi3Vj7jVFJG+XWaEpO66B1MJVwppWXb5ZssqX5uH7EIyoPdc5b
         aZRTZgWPUU+/1varIKwmTkmdGTW8YhqR8jlXVZgNkY6HP2ZlyvsmFaTx/TgL4OvRgeNb
         WDPHOJfD0HbUz3I2EtFmOxykIKBXigbM61uijoOUUNb5eOD6kuwvi+l+eA966AahX5wC
         gM04u8ucjvvZjbe8mcgkMluFFiEd9afeSk5OsLCZZER8H/j5ttbtNd5tQX6idVUh621Q
         +MtQ==
X-Gm-Message-State: AHQUAua4mbw4viq/Zh1t1U0BgncGfNSRGiNKT8GpXMu4hR1ieV9pzffB
        o3FT0Qm7+MWWw0JvW54iqGRIPg==
X-Google-Smtp-Source: AHgI3IayBrp5NclCl08Buq0xOVQPkHfi3BuyC3zKkIaY9egABeRKA9u5ofkpSu7pPtXBJub3ri3w3w==
X-Received: by 2002:aa7:db14:: with SMTP id t20mr16232232eds.231.1551136920057;
        Mon, 25 Feb 2019 15:22:00 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id a58sm2998025eda.91.2019.02.25.15.21.58
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 15:21:59 -0800 (PST)
Subject: Re: [PATCH] rtnetlink: Synchronze net in rtnl_unregister()
To:     Eric Dumazet <eric.dumazet@gmail.com>, linux-kernel@vger.kernel.org
Cc:     0x7f454c46@gmail.com, "David S. Miller" <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        netdev@vger.kernel.org
References: <20190225212721.2908-1-dima@arista.com>
 <eb7bca34-2b6a-1140-b230-71f333b42807@gmail.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <d20c023b-33d5-4c48-a404-e2ba05f98a99@arista.com>
Date:   Mon, 25 Feb 2019 23:21:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <eb7bca34-2b6a-1140-b230-71f333b42807@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 2/25/19 11:09 PM, Eric Dumazet wrote:
> On 02/25/2019 01:27 PM, Dmitry Safonov wrote:
>> While it's possible to document that rtnl_unregister() requires
>> synchronize_net() afterwards - unlike rtnl_unregister_all(), I believe
>> the module exit is very much slow-path.
> 
> rtnl_unregister_all() needs the sychronize_rcu() at this moment
> because of the kfree(tab), not because of the kfree_rcu(link, rcu);

I may be wrong here, but shouldn't we wait for grace period to elapse by
the reason that rtnl_msg_handlers are protected by RCU, not only by rtnl?
Like, without synchronize_net() in rtnl_unregister() - what prevents
module exit race to say, rtnetlink_rcv_msg()=>rtnl_get_link()?


>> --- a/net/core/rtnetlink.c
>> +++ b/net/core/rtnetlink.c
>> @@ -308,7 +308,9 @@ int rtnl_unregister(int protocol, int msgtype)
>>  	rcu_assign_pointer(tab[msgindex], NULL);
>>  	rtnl_unlock();
>>  
>> -	kfree_rcu(link, rcu);
>> +	synchronize_net();
>> +
>> +	kfree(link);
> 
> 
> I really do not see a difference here (other than this being much slower of course)
> 
> If the caller needs rcu_barrier(), then add it in the caller ?

Well, sure - but it seems confusing that rtnl_unregister() will require
synchronize_rcu(), while rtnl_unregister_all() will not.
And I thought no one would care about another synchronize_rcu() in exit
path.

Thanks,
          Dmitry
