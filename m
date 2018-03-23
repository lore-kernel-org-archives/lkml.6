Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521803647-2-5086657906238256803
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
    t=1521803647; b=Npz+UzUfZrQwRQUxSXqzGET7MbYQ8ZonE+CKZEhj63MH5UQ
    xfyG4N0qAYK62pnA4S4otK1Gp0RYiIsnboD04/NdZToTiGcPDLdkHnRNeISPDea7
    iUcn7M4cyXknS8KP+xIORe1PeAPKRTcQaDwBwpVBdqPZe94ZHU3HugEHaXaAXP7Q
    LX94zceMEaqOo2yx+Sp5jVd9BsXtLg4bAp2hcQCiCo/wdZf3ukEQ6wbGctrtpOgp
    QyXfRBspyCQVtEpDlqdaocoJzPGvEGUZ24UxBihvAKtTftDYWk723X6M66TovY9p
    jTl8Pgx02KQcTd2S7AJbZp9OAbLN9F45r+DLVjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803647; bh=FQts0s2eyJ4eNCzZ6oqN/8U3Bi
    xMD90uyk83ddqpcus=; b=s7j1F+QDVzanAcoCtx7q7bPYvbQixzWpVK2drMwfLt
    8/w6YjosvKbAZDyjlynrH5J5NASjV9CVyo/JkkFUG2OIBnSeHRHbaXVaFex8EA5h
    zv96/0cgkrBYeReUTk/nUsnXQeY24BIL+zW/1U2uYHA5COUvUnhpWu3uvurcAwwO
    Lh5IJ6CVKkHzpeW2RtbC/Zma6p12B4NhEWNLvI4rS9CpnDdVYzeWH7X11zVgQjpD
    +ybqe4Vb0+uv78jHCIWI1g2rE74MP8EkmOv0DWS+qJunDnN90ma+q4Kfne29a4na
    CdhP8U58r+bTNaDVtZ9W3C+CW9El5orcMJPEhjU5TJyA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
        id S932697AbeCWKK0 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:10:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42522 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932684AbeCWKKZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:10:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Loic Poulain <loic.poulain@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 135/177] Bluetooth: btqcomsmd: Fix skb double free corruption
Date: Fri, 23 Mar 2018 10:54:23 +0100
Message-Id: <20180323094211.166951345@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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

From: Loic Poulain <loic.poulain@linaro.org>


[ Upstream commit 67b8fbead4685b36d290a0ef91c6ddffc4920ec9 ]

In case of hci send frame failure, skb is still owned
by the caller (hci_core) and then should not be freed.

This fixes crash on dragonboard-410c when sending SCO
packet. skb is freed by both btqcomsmd and hci_core.

Fixes: 1511cc750c3d ("Bluetooth: Introduce Qualcomm WCNSS SMD based HCI driver")
Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/btqcomsmd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/bluetooth/btqcomsmd.c
+++ b/drivers/bluetooth/btqcomsmd.c
@@ -85,7 +85,8 @@ static int btqcomsmd_send(struct hci_dev
 		break;
 	}
 
-	kfree_skb(skb);
+	if (!ret)
+		kfree_skb(skb);
 
 	return ret;
 }
