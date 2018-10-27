Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0AEC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 15:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE4920843
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 15:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="VEmHxnFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE4920843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbeJ1ATX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 20:19:23 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:21154 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbeJ1ATX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 20:19:23 -0400
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 72EF644ACE8;
        Sat, 27 Oct 2018 17:37:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1540654678;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UQGZUDD2Qa1IFQ+jw7Rw7vaCO9LedMpdFJ+V0AnRi3Y=;
        b=VEmHxnFBGlzLK/R7/F7ipZoEHVbi4ANqZpKG0TC7VlNgAzrmnZmQR2c3awLAk+T7hlAxyj
        xDnvnD6jxv1uA5hDstbcvNqlDqjJLPeZaTh3AiZLmOo7cFaGADaCDGcNWZZ3lRvjwWsdbg
        Tsd/HkNTAeGndJ0VcePxcquLUMN2cI4=
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name 72EF644ACE8
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 27 Oct 2018 17:37:58 +0200
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Dave Taht <dave.taht@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        =?UTF-8?Q?Ji=C5=99=C3=AD_P=C3=ADrko?= <jiri@resnulli.us>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: CAKE and r8169 cause panic on upload in v4.19
In-Reply-To: <1beabdd3-dbac-de8a-07b0-d0788b1dbc38@gmail.com>
References: <61d09f0db41f269cc9ee13dd68a5c285@natalenko.name>
 <fbd7f0b8-10c8-be17-fce6-327a95d8ea2e@gmail.com>
 <CAA93jw7xoaokrN4oGAyqh6JHAn8nJpUpp_wj-iy+GWNoV-ipNA@mail.gmail.com>
 <b80e6819da8ea74f18b6ec0aaf9128fa@natalenko.name>
 <1beabdd3-dbac-de8a-07b0-d0788b1dbc38@gmail.com>
Message-ID: <644dc057e822273fcbc538b2056908ce@natalenko.name>
X-Sender: oleksandr@natalenko.name
User-Agent: Roundcube Webmail/1.3.7
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1540654678;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UQGZUDD2Qa1IFQ+jw7Rw7vaCO9LedMpdFJ+V0AnRi3Y=;
        b=rXPXI+mAEHkIf/985WA/j3j1VMeBla+ugV82ldDFOz52i5d9OGWB4ialqbvxeBcQkAj8rB
        QHiG2M44IkVG9JgXWBlHSPNMzRFXqA/J7KkRrfrEIO08gMmwH+UTv6MQIzsE7pXgBHZklH
        QDuzu9yuUpqTAwQjje/DbnL7D3FO3To=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1540654678; a=rsa-sha256;
        cv=none;
        b=o2cu3fHMjHuTK8eLoG90SGaLM0zX9nzeGrkEzIFReQNQBzZ5ta9aBM7Jsx9tRIHUAUJjklxXiXK3E+ZIixEHQnpte4I5ppwoyeqRTiX9mes0ms1L4/npyaVerz7M6I+fFmDjH5s45KqFYB4guvB3BfgLvCOwa2oudet6BYriqic=
ARC-Authentication-Results: i=1;
        vulcan.natalenko.name;
        auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On 27.10.2018 15:43, Heiner Kallweit wrote:
> In net-next there's the following patch which mentions in the
> description that it "eliminates spurious list pointer poisoning":
> 992cba7e276d ("net: Add and use skb_list_del_init().")
> And spurious list pointer poisoning is what we see here (IMO).
> 
> As an idea this patch and a8305bff6852 ("net: Add and use
> skb_mark_not_on_list().")
> from net-next could be applied on top of 4.19. Would be curious
> whether it fixes the issue.

Applied both, still panics. %r12/%r15 are still poisoned too.

-- 
   Oleksandr Natalenko (post-factum)
