Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAF4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0129620652
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 00:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="JRT6pgOe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbfBZAJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 19:09:15 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38330 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728906AbfBZAJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 19:09:15 -0500
Received: by mail-ed1-f65.google.com with SMTP id h58so9213843edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 16:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ymDyCXCkPgJByMEbju/OzGZ0DRRtO6UIdhby8XUnXWY=;
        b=JRT6pgOeLkdtp6poblhwg24Flc5pbkhtT2OA2Sg12ZCeWZ2QchXhu/aqwpmAUi1kJy
         fWYDl/06iOffNf3TJppHICGdGXJc/M/hnGC6uMS3AZmR8G16ALtvEp5JMGOl82nJRGXd
         A3fyMfNf51woivYEmvGUyh8NJrZnHKM+mgv/4QNGakOTiGaPLp+05RR4SNXEw9mter+g
         GeZRn0jJjLQU2qpYBvJMcAzix1+2rv22bvQrn6wp45IMII1Eo5k1M6o43ZnoNpG/lfT+
         tFDN1J0vrFFZF5sbdlC487Za0ABE5/Mra+BmxZuLzyN2UF/1GDvS2LE52/i1ikWXAUg6
         Kzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ymDyCXCkPgJByMEbju/OzGZ0DRRtO6UIdhby8XUnXWY=;
        b=Wd32gEeOXr3IeWeIRGh0IgKjLeKHlQZXrVDAxA1GJrOclMUO2bV0lq+mWeheMUmSxb
         wUm8qPlo0onC59RORNMkMaNy4i4XAEKSt+RqXNAilp239O9ku/YS3bqj9qZA4yEyCvIW
         LXgxVdNurc/NV8EL2Wo884sZ76/C9Wie+0ZcbvlGJs7ae/WmMv+8OQSes3mG896t6D3K
         jorDxOulSoGkKIFu4kt7BWephvq4P7OpRNq/4ynfJDmKjEM0O4YwZlsjYQr+oVjTRi9M
         y/QusNV2UtyNLmGRyRSjvB3TMJqR6XXPiSELdZN1waoh2v8J9Aps3XcAdZGcsVG40MH7
         selg==
X-Gm-Message-State: AHQUAuYpnVVWj5gIGm5Ys/h3MPA8TY4zEM+y73oy5MOyMTechKnmBPaG
        j/LU0pB0YfTdcZ3rv2zVlH7eHQ==
X-Google-Smtp-Source: AHgI3IatZsEbv/MXXtKJQE+eoB1ifAt6S3zpm2rCGcncxqebI8/FevSlkZqJVYsVNn7dJ+2D9CZHTA==
X-Received: by 2002:a17:906:4ec6:: with SMTP id i6mr15025001ejv.56.1551139753002;
        Mon, 25 Feb 2019 16:09:13 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id d15sm2960714edv.20.2019.02.25.16.09.11
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 16:09:12 -0800 (PST)
Subject: Re: [PATCH] rtnetlink: Synchronze net in rtnl_unregister()
To:     Eric Dumazet <eric.dumazet@gmail.com>, linux-kernel@vger.kernel.org
Cc:     0x7f454c46@gmail.com, "David S. Miller" <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        netdev@vger.kernel.org
References: <20190225212721.2908-1-dima@arista.com>
 <eb7bca34-2b6a-1140-b230-71f333b42807@gmail.com>
 <d20c023b-33d5-4c48-a404-e2ba05f98a99@arista.com>
 <5079b888-a62f-991a-6f0b-1248d23d0045@gmail.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <fe1912d1-a047-8a23-bc66-b49c894a8ee9@arista.com>
Date:   Tue, 26 Feb 2019 00:09:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <5079b888-a62f-991a-6f0b-1248d23d0045@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/19 11:31 PM, Eric Dumazet wrote:
> On 02/25/2019 03:21 PM, Dmitry Safonov wrote:
>> Well, sure - but it seems confusing that rtnl_unregister() will require
>> synchronize_rcu(), while rtnl_unregister_all() will not.
> 
> rtnl_unregister_all() is a different beast, since it removes the whole rtnl_msg_handlers[protocol]
> 
> rtnl_unregister() only removes a subset, with different usages.
> 
>> And I thought no one would care about another synchronize_rcu() in exit
>> path.
> 
> We definitely care about things be done properly.
> 
> If synchronize_rcu() is needed there, be it, but kfree_rcu() seems to be fine.
> 
> In any case, I believe you need to more carefully explain what is the problem here,
> because I could not really see it.

Ugh, sorry - it seems that I haven't had enough coffee today.

I've read again rtnetlink_rcv_msg(), who is the only user of
rtnl_msg_handlers[] under read_lock, and it calls try_module_get(owner).

Sorry for the noise,
          Dmitry
