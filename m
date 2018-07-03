Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F89C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1052147E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f7z+QjVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1052147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933769AbeGCQSP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:18:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46242 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932541AbeGCQSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ReGdEJtKWAKD6QJYaGZY+cHNE0GS9/qjWCIovmO73c0=; b=f7z+QjVjPC6Svk17wSXYfTsKF
        c0Dv6AQIaavG57VHne0srEOG0lNVW+8iQBqoHZzuPpXW+Dp5l5oH8sL2+SSnijtR3IfiiklVl7lKt
        Gpk86j6k/9mLgcSA5BhbscXHnEt7jKCHleNrtQj0gg8I1XNttW3LsI/AiMVwv0U1nAUyfQ9UaK5Zi
        EiYSK8QNHDI4rq1YJ7yAaUg/a7akHbEZlYZWD3HdNBZYOU/EPjlEHiU0A/4lyZZfHK9gOn71TXgIv
        mvt2Ind/PFrlL/vDV+w4C9oLUwDuPuwhIYVHEaFQfBFS3E1hi4hI/BXKobBhycOWTz1/Zq3QlTxiC
        sLmbxrYsA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1faO0K-0003Ac-Vz; Tue, 03 Jul 2018 16:18:13 +0000
Subject: Re: recvmsg bug not clear
To:     =?UTF-8?B?56mN5Li55bC8IERhbiBKYWNvYnNvbg==?= <jidanni@jidanni.org>,
        linux-kernel@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
References: <87601whg6r.fsf@jidanni.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <97b3d0e4-7920-4462-6bc6-8cca3e57c560@infradead.org>
Date:   Tue, 3 Jul 2018 09:18:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <87601whg6r.fsf@jidanni.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding netdev]

On 07/03/18 01:33, 積丹尼 Dan Jacobson wrote:
> Most users won't even know what string from this to google on to find
> out what this is all about:
> 
> 
> Jul 03 13:57:20 jidanni7 kernel: ------------[ cut here ]------------
> Jul 03 13:57:20 jidanni7 kernel: recvmsg bug 2: copied 73BCB6CD seq 70F17CBE rcvnxt 73BCB9AA fl 0
> Jul 03 13:57:20 jidanni7 kernel: WARNING: CPU: 2 PID: 1501 at /build/linux-uwVqDp/linux-4.16.16/net/ipv4/tcp.c:1881 tcp_recvmsg+0x649/0xb90
> Jul 03 13:57:20 jidanni7 kernel: Modules linked in: nft_r...
> 
> 
> So please make clearer messages.

That's a message from net/ipv4/tcp.c


-- 
~Randy
