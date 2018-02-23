Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519414465-2-3997895534870614679
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519414465; b=E5OiVepvfHM4eaD3umncm7l4nCHco9Kh139fdmnNzarrisi
    a2DnvpAIrVPo4nGHLu1VV6Oxzoy1AQ/BfXL8YlZVBNdLKKURvGS/5E1Z1/Dwhs2E
    dJOyk6Xhsoz/aPVW2XjZ2ljIbkSpygdVz3iXqpkXt0/GQ1UzbDVcYJdGdsj0DIPW
    X80xh8Ld7EVF1TD/7M2y14osvsHAlkT60FPX+5CQc6tvOYqQgeE2pmMQpeHJKSyM
    jhjpoZaoo4zt/tnvJKJkl9heYboJzra1F/FDxPsQAoKPhnf/zq3TrYFf1x7AUyvc
    H0C6CpxAa/M6QUYY807kGYi0igdyxxcMFSqgDhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414465; bh=fxkKHlNe/trC7xfR3W5NiTBrMP
    clC8j1umgKa+AGHpQ=; b=aRjP76/jfTNiXPNtYW8wmCCzu2BeSIbeMB/SzQsJmG
    DwcPZWEriIgpu5xdQ0HVDRbWxS0OMg63J5cmaNVkm6xB8XdDkn6dn3P6CTFbJeq8
    E7oD5LbEyxfW3bXnUdG7ezsHXPJEYAIbCLomBrcxFh8CdQ5Es0h0DUOQ0svfH2Dt
    8xtqDrRzk/pFDutBQ+idzNT9he0r+9KT8s8sofpJc+EiDS3vbmrBMh+xOu/cyZ7y
    BlLXYBz11syn20TBZdzL5dNhfj3JedSPt2381r+Hu/XprtntZZMIh8DAb9bctVYE
    APNW2yGFJMrTQAivu1WcnbcCKYu0A01axpQuKyYJlp9w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753238AbeBWTeL (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:34:11 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45914 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934866AbeBWSvC (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:51:02 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 043/159] net: avoid skb_warn_bad_offload on IS_ERR
Date: Fri, 23 Feb 2018 19:25:51 +0100
Message-Id: <20180223170748.597729358@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willem de Bruijn <willemb@google.com>

commit 8d74e9f88d65af8bb2e095aff506aa6eac755ada upstream.

skb_warn_bad_offload warns when packets enter the GSO stack that
require skb_checksum_help or vice versa. Do not warn on arbitrary
bad packets. Packet sockets can craft many. Syzkaller was able to
demonstrate another one with eth_type games.

In particular, suppress the warning when segmentation returns an
error, which is for reasons other than checksum offload.

See also commit 36c92474498a ("net: WARN if skb_checksum_help() is
called on skb requiring segmentation") for context on this warning.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/core/dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2792,7 +2792,7 @@ struct sk_buff *__skb_gso_segment(struct
 
 	segs = skb_mac_gso_segment(skb, features);
 
-	if (unlikely(skb_needs_check(skb, tx_path)))
+	if (unlikely(skb_needs_check(skb, tx_path) && !IS_ERR(segs)))
 		skb_warn_bad_offload(skb);
 
 	return segs;
