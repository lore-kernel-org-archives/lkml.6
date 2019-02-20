Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7368C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857C32147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="Qhfmgw3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfBTNLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:11:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44211 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfBTNLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:11:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id w2so11291058wrt.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 05:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rM4zd/K3fOxUvugoKDuN9cL1E/peaKMPk4qsTRNbnCI=;
        b=Qhfmgw3Q4a/NlHdUoqbv2OdYtbub7rnRhBhjsmkT5mdAuUgE+qXfcdQeBd/setHF0G
         Sh3XHQ0sjVW4K9/0pJFBmeYPnNawOdhr5mbF7aTg4o65TfLocSrG/Oe4D0NkXBvwu1/I
         FLXqd4qBN+7haqakwE0zxUb4bpfnPuR7HQ8Es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rM4zd/K3fOxUvugoKDuN9cL1E/peaKMPk4qsTRNbnCI=;
        b=Ly02CVK6BYpGZTB87zx2A9iswmLrVUXi6vho8ELYsatNu5oqf5xVtqlRKBgUaJQt6Z
         njTeRn7w1a7e/QApTrL47+h/atdyIm4lRy3j93WcS9+gEctd7P5dTLrTDeYwTz54hzp3
         QluXDZ2BiaeTTe3jRDbLXOy8rIz6eCojAjRvOPbTj60fBHO4lPLvudXXQQ+78yA9jaEu
         QAIr8xnQMUAhAZu66AILPDaJMdzA+Jv3zC9IdosWX2IXjTX91qlcih0GzpFnbcBonInf
         1ZY0t2aLdISMXywCmoJRXrL4J9DTArLLOVdqpiDCoHhALwRi+LlMhmzmySFH4jeHDZfW
         L5sw==
X-Gm-Message-State: AHQUAubiRm0d1blR8yGBZDgWGJfyVkUON9Am65p7sCvFBqrkFSItyMEh
        1PgHY+A6+AlbEbwtKdD5bH4BMA==
X-Google-Smtp-Source: AHgI3IYqEmY/ymZAcI1r1HdQbduo9M+a3d9shqFabpikp0asEvQplJ1pk5pYCk2hKvmBYLp3UoSJRA==
X-Received: by 2002:a5d:458b:: with SMTP id p11mr25282346wrq.22.1550668290172;
        Wed, 20 Feb 2019 05:11:30 -0800 (PST)
Received: from [192.168.0.107] (79-100-158-105.ip.btc-net.bg. [79.100.158.105])
        by smtp.gmail.com with ESMTPSA id u184sm12433499wmg.45.2019.02.20.05.11.29
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 05:11:29 -0800 (PST)
Subject: Re: [PATCH 4.19 01/24] bridge: do not add port to router list when
 receives query with source 0.0.0.0
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
To:     Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ying Xu <yinxu@redhat.com>, Hangbin Liu <liuhangbin@gmail.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>
References: <20181102182839.725385066@linuxfoundation.org>
 <20181102182839.913422845@linuxfoundation.org>
 <07d315a2-d735-3d8b-686c-9c52acf91bf1@newmedia-net.de>
 <20190217164809.GA24091@kroah.com>
 <7978727a-eacc-779c-771f-f4c3013237f3@newmedia-net.de>
 <0425449f-f6d9-c492-d7c8-ba202db88d26@newmedia-net.de>
 <962f3d1f-23eb-647c-74cb-b277212299e7@cumulusnetworks.com>
Message-ID: <e9423963-c847-0406-4158-1b6f470e8b61@cumulusnetworks.com>
Date:   Wed, 20 Feb 2019 15:11:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <962f3d1f-23eb-647c-74cb-b277212299e7@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/2019 15:09, Nikolay Aleksandrov wrote:
> On 20/02/2019 14:48, Sebastian Gottschall wrote:
>> *reminder*
>>
> [snip]
>>>>>>    }
>>>>>>    static void br_ip4_multicast_query(struct net_bridge *br,
>>>> Is this also a problem in 4.20?  This patch went into 4.20-rc1, so it
>>>> has been around for a while with no reported issues that I can find.
>>>> Any pointers to the reports?
>>>
>>> i need to check this. i found this patch in 4.9, 4.14 and 4.4
>>> the rest was picked up from the mailinglist. according to the git sources of 4.20 and 5.0 the same code is in there as well
>>>
>>> i just got the report from users today and was able to reproduce it with iptv streams. just by disabling the code it was working again.
>>>
>>> Sebastian
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>>>
>>>
> 
> Could you please include more details about the setup that's broken ?
> Note that we were warned[1] of potential breakage from this change
> after it went in and regardless of the suggestion from the RFC we'll
> probably have to revert this patch.
> 
> Ying Xu as author of the patch, any thoughts ?
> 

My bad, it's Hangbin Liu's patch. It was reported by Ying Xu.

> Also adding Linus Lüssing to the CC as he was the one who warned against it.
> Note that the warning was sent as a reply to my breakage fix, but it was intended
> for the original patch.
> 
> Thanks,
>  Nik
> 
> [1] https://www.mail-archive.com/netdev@vger.kernel.org/msg272944.html
> 

