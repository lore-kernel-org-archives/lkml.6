Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4098462-1520452960-2-11739031182355487670
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
    t=1520452952; b=rg0xXx2rkhJu93jOet6bFlC+PQDT/j7JurC/EFMYrfYXW+F
    9nQNxXyzYyWjYIZJVgA5gARHbA7msLb1RPSUezcqwzMIZDuiBx8UGev5HkSrU/Co
    uw9aCD00AJa9q0D5F1BmCkVD0E2fuGBKJgc9ygAIZeAaQQ5NzhPPgmEHDzi5eQoe
    gldCSujNiaTCsKiRmlv9skL8K17BCAWuhTDGWoHpXsmIgjJVBlGwkaiu04BWBiaP
    k7W9n/uqkJAX2B5VkX9T2ioZaZM8G5eS2Z+86jV/vHrwUYuv41ByWPAnHoLJ8rEl
    +gAGhgfULolj2TZ1XRFz5UweVatO/Kk7f/MoFrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520452952; bh=RbiYitNPdIPTtrEGn8Cgs6Ks1h
    NYhuXBYwNf4ZKXzlg=; b=pZ+wyZHnX1BRNgHbgE9FxFXd50g2nyWGSdvuvCw/UM
    YtfPYQ5s2cCCKAYGB+qrDv0hatQxmlVa/2DEJpGIW2zwD2nF4fMVo4OdHPGoe3Cw
    1HPVl82gyZ75TLA7ZaLEvPXwiD+ichK/72BgK3+VTeG3SUrRuWLvbzvUbaSXjNoO
    mYtn5/n4Ni/UB7AcYCStEyvOQz0ZUeeDS3nI2HY9+HbSBl1PWJKQtcz+SJgpFMir
    W0kHHEGaxiWS+dy0C2NSso5GMByQL/Lp/VTUE4pKYh6JeTgMiLyHNVPxQkS0X2b6
    Q3f5Z5/BWZlO2/X5L4a9mld8ORpzC7DhAFUJKVRhAE6w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965667AbeCGUB7 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 15:01:59 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44768 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965611AbeCGTqs (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:46:48 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 070/110] netlink: put module reference if dump start fails
Date: Wed,  7 Mar 2018 11:38:53 -0800
Message-Id: <20180307191048.587694479@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
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

From: "Jason A. Donenfeld" <Jason@zx2c4.com>


[ Upstream commit b87b6194be631c94785fe93398651e804ed43e28 ]

Before, if cb->start() failed, the module reference would never be put,
because cb->cb_running is intentionally false at this point. Users are
generally annoyed by this because they can no longer unload modules that
leak references. Also, it may be possible to tediously wrap a reference
counter back to zero, especially since module.c still uses atomic_inc
instead of refcount_inc.

This patch expands the error path to simply call module_put if
cb->start() fails.

Fixes: 41c87425a1ac ("netlink: do not set cb_running if dump's start() errs")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netlink/af_netlink.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2276,7 +2276,7 @@ int __netlink_dump_start(struct sock *ss
 	if (cb->start) {
 		ret = cb->start(cb);
 		if (ret)
-			goto error_unlock;
+			goto error_put;
 	}
 
 	nlk->cb_running = true;
@@ -2296,6 +2296,8 @@ int __netlink_dump_start(struct sock *ss
 	 */
 	return -EINTR;
 
+error_put:
+	module_put(control->module);
 error_unlock:
 	sock_put(sk);
 	mutex_unlock(nlk->cb_mutex);
