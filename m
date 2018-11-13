Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9FBC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDF422507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="K9ULkexx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BDF422507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cumulusnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbeKMKYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:24:36 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43090 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730387AbeKMKYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:24:36 -0500
Received: by mail-pf1-f193.google.com with SMTP id g7-v6so5097029pfo.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 16:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hhXPboyK2v72FwSZ0+xAP/i5XUCZDW7UBvYMvKOCkg8=;
        b=K9ULkexxXSpbUNJ/eON+hnJ6Wk6gP2/N9AIvirgJqPSGaP7BeDH4P4bAVUkSsedAaR
         IDTXzqa6XziA2/2aJHhaFy/Hcsod649eprq9B4JWPyOzilFMTKsDiDzsAz4TS0/b8SaP
         riyZSm1Lh+XEfg726/kglsJCb884CDak52DwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hhXPboyK2v72FwSZ0+xAP/i5XUCZDW7UBvYMvKOCkg8=;
        b=lehTZlUZhECawhGtmJIC1QTLoAGvC+JpzCSGSJYfZd1XZwTOa81ER6ocj7LIlXu0tj
         76rKrLpahHxFnpQP4Vo1RvRxTVEBlFVEQGeBg738a7L4lXEu8BUiik7dBoHhAjJIfSt3
         nd3y32I1WlNmHYgzzdzFRaoO+2ukimtkKR8TlJJthwQKSWebuNrQbhnti5/q79JdXyvJ
         av8Qtgz5MZd15AxyKX+Zua+Ll9malGGczHMrH7wZNbuATSk6twW9T+oiBXsbkZZKa0aL
         d/qmH6E/5IYOt6UcpT9olKvpiqNqqUtp1jbF1aEdnkf1no/Pgu2VTOo3aLZ1ADZCC+sk
         i9zA==
X-Gm-Message-State: AGRZ1gLB3tlOR0MukvAxucFprd1u0qKf6euo9cVFXMzd7kfbCOIb/Tdc
        OdxOtwaw6jjKeNYeEzoK1ourWQ/NVaT+MA==
X-Google-Smtp-Source: AJdET5fmq6R+EEO8iuFTseGMYapEII01NrrL8FX6qC99VyyrtB5AJUXJYYkETxqADW/9kqQHmllFYQ==
X-Received: by 2002:a62:2643:: with SMTP id m64-v6mr2923865pfm.74.1542068943662;
        Mon, 12 Nov 2018 16:29:03 -0800 (PST)
Received: from [192.168.33.151] ([64.114.255.114])
        by smtp.googlemail.com with ESMTPSA id p11sm7406337pgn.60.2018.11.12.16.29.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 16:29:03 -0800 (PST)
Subject: Re: [PATCH tip/core/rcu 33/41] net/bridge: Replace call_rcu_bh() and
 rcu_barrier_bh()
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20181111194104.GA4787@linux.ibm.com>
 <20181111194410.6368-33-paulmck@linux.ibm.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <58d41678-edc9-9212-718c-a922ab151eda@cumulusnetworks.com>
Date:   Tue, 13 Nov 2018 02:29:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181111194410.6368-33-paulmck@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/18 9:44 PM, Paul E. McKenney wrote:
> Now that call_rcu()'s callback is not invoked until after all bh-disable
> regions of code have completed (in addition to explicitly marked
> RCU read-side critical sections), call_rcu() can be used in place
> of call_rcu_bh().  Similarly, rcu_barrier() can be used in place of
> rcu_barrier_bh().  This commit therefore makes these changes.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> Cc: Roopa Prabhu <roopa@cumulusnetworks.com>
> Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: <bridge@lists.linux-foundation.org>
> Cc: <netdev@vger.kernel.org>
> ---
>  net/bridge/br_mdb.c       |  2 +-
>  net/bridge/br_multicast.c | 14 +++++++-------
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 

Really like this change, makes life simpler.

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

