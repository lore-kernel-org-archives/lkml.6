Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3443417-1521218219-2-1707154627637679415
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521218219; b=xDVMHaNCdrSCUpPgKGbxVcimlfGZZWmvNYc0K4aAUziSUy3
    KYG8gg1RL2pjJGx9yUDZkl1YQFWtD0V5zRNYAST+3CuuzTVp90MVI6wWk9m09oxa
    +QkEGxN49VJVRUqvdi5/ZtAEdABD0js/1srPu288id6HJhBKiJ702NQ1ZPdeXlWu
    eKxu78IJSvivWBJTrkS2S6M107sSRHOeVmy/CrdTCV2gOkhMLV5503kNZhnvJoB2
    Jl0GqOrDT7+ivD9n8hNqXs/w/ol8MJ8NFfH5EudykfRmiY6k/eUtlPNwYp6dzu9u
    Yf7lt7q+6wy0Xk/+TY8Kp2Q0E6PaKyr4DoAoZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:cc:subject:from
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521218219; bh=gdc8Q79A5gxILFUBVxS2zKvEuBiJbOBpjy6iAkKigTo=; b=d
    L8yxBvJzs7+IymcNnS8bfZEaZirW2ZnkBlPO5P8GqODTNC15Ch599ER/lh/qn5tC
    quFaYXW+zvS4KNzpFypYcnwH2+lIqnAWQ/UGLDnFfVWDEPgMoNcUXkQJ5jJ9CT3A
    6RKNxUB7WToMZ17P9GyCviuQF6p3fTf4x4nrM3ZtQUXIoQ2PQwxRH1ABYm3YYmgP
    3eG8U8qf/J5wG+RehT7C88iyACaDz1JYk1AF4PAirQeCtkgLmARw5NhVV6ko53aW
    i964/kLiSPkdkvIwbuv3XL818c44FPrkk7CZWWdcc+lFCbbsQGNK6bWdXGYOoQsC
    h210DmeKEqo6RI1MaSPdQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeCPQgd (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 12:36:33 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:34272 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752724AbeCPQgb (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 12:36:31 -0400
Date: Fri, 16 Mar 2018 12:36:29 -0400 (EDT)
Message-Id: <20180316.123629.52512148155674649.davem@davemloft.net>
To: nicolas.dichtel@6wind.com
Cc: ben.hutchings@codethink.co.uk, netdev@vger.kernel.org,
        stable@vger.kernel.org, johannes.berg@intel.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] netlink: avoid a double skb free in genlmsg_mcast()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180314201023.12407-1-nicolas.dichtel@6wind.com>
References: <1520899459.23626.87.camel@codethink.co.uk>
        <20180314201023.12407-1-nicolas.dichtel@6wind.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Wed, 14 Mar 2018 21:10:23 +0100

> nlmsg_multicast() consumes always the skb, thus the original skb must be
> freed only when this function is called with a clone.
> 
> Fixes: cb9f7a9a5c96 ("netlink: ensure to loop over all netns in genlmsg_multicast_allns()")
> Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

Yeah these "clone until final send" loops can be tricky to manage.

Good catch, applied and queued up for -stable, thanks.
