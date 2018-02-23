Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3795596-1519416571-3-13011932791558990437
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
    t=1519416571; b=WDzKFN2A0UddQWJYJxvSTDwKX/pqq6c4rRaoS9tVjdqTI2S
    Aqs6s965GOSW7W5/FKrma+SaroX/x7vH5J9vvwARnLBykR9P8IE5FGPmtx/Rfxgq
    IsnSQ/yER2i5uxIGxCySlfLgpixjBLXYP+JxCgfX5V3ykkxVbG8/xT1DCIZXncUc
    /DpR4Nkz5aZ5+hxhvQSaGtYT/tRnovi5WJhUV7b+OB4OmEPHE5nRAOJpvg9JNaLS
    4rTSZh8sFC7nIHDPBfwavVWV3SZD6od/1hjS+VWTcHM92Yghn84MalBAEKomJi6+
    WNAEhcNTGi2nUgOIxKH68cgBpb4sLqr1eDvO4hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519416571; bh=5fOCUHfDZ++buVKgMshL7cnAbf
    4cmIxaUiVExn6HKAk=; b=Vywwn+ALqNldXKfDDbPQtNVCf/y/ST+YB7N3FpTHIJ
    944BBBJXwecMr/+m2ZQ7F/9llXKGGw610w1DHRSwDqB+vp7tkiB1UuCa45pLCA8r
    D/WMurn3p3Kn4HrdhkhZm6YJzDWu8V6QZk2tWjHvpyuEZkd3iphd4fc4TJ2Gy4DZ
    ah1q5KeE3EJ6kWDJqPsX2HPeovo5FfK0d1ZLYlRiQ5wNxmsoZeCrlS21HSJEXxsq
    xNfHKjBO3vLxg9hG3aqiENMuC3enS7WNBklMV/OFGC0VpYtLSPp+VEl2YmbU3LqN
    8OxF/C2hEyNvJfue06ZnX1/ompzxMblZuv+HjGwbkdAA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933123AbeBWUJP (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 15:09:15 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41500 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933026AbeBWSmX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:42:23 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+8865eaff7f9acd593945@syzkaller.appspotmail.com,
        Tom Herbert <tom@quantonium.net>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 003/145] kcm: Only allow TCP sockets to be attached to a KCM mux
Date: Fri, 23 Feb 2018 19:25:09 +0100
Message-Id: <20180223170725.169691035@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Herbert <tom@quantonium.net>

commit 581e7226a5d43f629eb6399a121f85f6a15f81be upstream.

TCP sockets for IPv4 and IPv6 that are not listeners or in closed
stated are allowed to be attached to a KCM mux.

Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
Reported-by: syzbot+8865eaff7f9acd593945@syzkaller.appspotmail.com
Signed-off-by: Tom Herbert <tom@quantonium.net>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/kcm/kcmsock.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1381,8 +1381,13 @@ static int kcm_attach(struct socket *soc
 	if (!csk)
 		return -EINVAL;
 
-	/* We must prevent loops or risk deadlock ! */
-	if (csk->sk_family == PF_KCM)
+	/* Only allow TCP sockets to be attached for now */
+	if ((csk->sk_family != AF_INET && csk->sk_family != AF_INET6) ||
+	    csk->sk_protocol != IPPROTO_TCP)
+		return -EOPNOTSUPP;
+
+	/* Don't allow listeners or closed sockets */
+	if (csk->sk_state == TCP_LISTEN || csk->sk_state == TCP_CLOSE)
 		return -EOPNOTSUPP;
 
 	psock = kmem_cache_zalloc(kcm_psockp, GFP_KERNEL);
