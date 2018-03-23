Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025519-1521802220-2-7680381336351176823
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521802219; b=EzUskUYFJqpeXiZYIHJQTBr8Ca5JmsfjeoK2tjcxGnXEFAG
    4h0CiunsuZeGJpqCWQqZoH5ZFmbi/zDWQf8RBATQazhFSqAk77zh6IRt0bxs7HwJ
    bFD5aLr6vTUAFw5vucRUn6YPacD+mfJqCY8dHjqPhmV0v9jUqJupHDenhgfHpOi1
    T6gV0e8NI8LAT1FSjGj+Jge5tInqAQHAXRoHmVopt0kFPWfhmvTZzkesfnUAJ/hn
    qQS2AdxO1TOKjddFEDX+npxPyMR73gaOcp5rdQOyooV+FOYW6E1ty4DWmOEli/za
    jPfIZh28Yeet9M9oEtjUZFIGAfdQ4qulOEQEKsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521802219; bh=StFHjA8onAPpn58Zp7uW8E2Fha
    fJ0Z6Du3xS/DDkD7w=; b=GD/S/HDQ5YOyVSsvQEB3VHbJmKcRfXWqpKuHbJpmLV
    E2rtnAOZEwbZnij+mrTxpPaJF/fEJh4jR7orc3CsHzn0jo+5c5hBf7B8z5JEnaPh
    tPwVNRkGmuMi83VDfHFJGEUbpTJ4QMOgSRN+qothqaYtvFUlkEeOI6VmYgEUkxXI
    ttq6qiJbOko3fvI9a1mkiDtqqHA2txPn4OOSHQ9x5K5NG323IBWMayxJFMsPsHZX
    xiO/Tg6A0fh32Qbfj3aTPYZUaifXT1jRPirLPt9+f2jan/rlvSvLwNyU74VNlL5z
    aa8of1bs48rGX+YXFFksMbUjocpTuwOPJwJQ7ket0GUA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933313AbeCWKOj (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:14:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45312 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933345AbeCWKOh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:14:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Sebastian Reichel <sre@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 33/97] HSI: ssi_protocol: double free in ssip_pn_xmit()
Date: Fri, 23 Mar 2018 10:54:20 +0100
Message-Id: <20180323094159.518124544@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit 3026050179a3a9a6f5c892c414b5e36ecf092081 ]

If skb_pad() fails then it frees skb and we don't need to free it again
at the end of the function.

Fixes: dc7bf5d7 ("HSI: Introduce driver for SSI Protocol")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hsi/clients/ssi_protocol.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/hsi/clients/ssi_protocol.c
+++ b/drivers/hsi/clients/ssi_protocol.c
@@ -976,7 +976,7 @@ static int ssip_pn_xmit(struct sk_buff *
 		goto drop;
 	/* Pad to 32-bits - FIXME: Revisit*/
 	if ((skb->len & 3) && skb_pad(skb, 4 - (skb->len & 3)))
-		goto drop;
+		goto inc_dropped;
 
 	/*
 	 * Modem sends Phonet messages over SSI with its own endianess...
@@ -1028,8 +1028,9 @@ static int ssip_pn_xmit(struct sk_buff *
 drop2:
 	hsi_free_msg(msg);
 drop:
-	dev->stats.tx_dropped++;
 	dev_kfree_skb(skb);
+inc_dropped:
+	dev->stats.tx_dropped++;
 
 	return 0;
 }
