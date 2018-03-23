Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804372-2-6547860206388586923
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
    t=1521804372; b=VaDa9M2LD4UidGYBcEC9nftwuwGZn1Zj9tnBa41UWBz0Knk
    Ild2GtxOtH8C2C/q0UkbagrEVUOjaE/5rHRt1/FJF+b82dLRNqx9ambcM7TmMZYK
    Q1QEFUCiR8quJ473U8vaa2bH+Eeolp13CcbwbquCvrGTlfUA5GxXYxHmbSvzSLbi
    gQL43F1bLoaXifIXss53H5HEJ6TnCeqylRfgf5w5Wz2CndWxaY9sOaWxp2fsQxul
    QV/SON8ZgBHKZ8EeWPIj3qHSklozxZYENVUyBzKS2R83upzzmQn8ra7LstfwoYZb
    G2/s6zXhIHm7kQBipzGyfIbSqQJWNe5wlVYykmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804372; bh=PC7D/akFyNE/ZoDz2DYcxrmTNZ
    cFwZpg0vSDACkFH+Q=; b=i+MMzxxxA/Ty0pWmC2JcYS/PteehX1Hk1BI3fW0uK1
    Go5J0Ft9TtXpbXjYgJPYqJVx8qY7frqolHK6GboFgGuVRqH8xiamtIePCq3kgQ8M
    Fa86vr8e1u7BaWUhhPJAgZedmovRihx+XjEcj8b3KqX0MzMa/rSwZX6t0FsY3Oj3
    A0qHcKNhRMSvz6WgwusPuePFVDsuN+wZW7FuV0TvzMvmh2Z2pJkgY2WDNMNFG0QZ
    eT9XXiMLR089pEKOQ4HWO9ROHyQKxzdSVpVBf2KEuKSzDzA/bl6iwq2M6csWjj/N
    xTnefiSqWoOHD1wrz96ab2A5n+7xuoAiXCk12pqyRlEw==
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
        id S1754790AbeCWKHT (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:07:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41164 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932447AbeCWKHS (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:07:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gao Feng <fgao@ikuai8.com>,
        Liping Zhang <zlpnobody@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 058/177] netfilter: xt_CT: fix refcnt leak on error path
Date: Fri, 23 Mar 2018 10:53:06 +0100
Message-Id: <20180323094207.910203307@linuxfoundation.org>
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

From: Gao Feng <fgao@ikuai8.com>


[ Upstream commit 470acf55a021713869b9bcc967268ac90c8a0fac ]

There are two cases which causes refcnt leak.

1. When nf_ct_timeout_ext_add failed in xt_ct_set_timeout, it should
free the timeout refcnt.
Now goto the err_put_timeout error handler instead of going ahead.

2. When the time policy is not found, we should call module_put.
Otherwise, the related cthelper module cannot be removed anymore.
It is easy to reproduce by typing the following command:
  # iptables -t raw -A OUTPUT -p tcp -j CT --helper ftp --timeout xxx

Signed-off-by: Gao Feng <fgao@ikuai8.com>
Signed-off-by: Liping Zhang <zlpnobody@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/xt_CT.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/net/netfilter/xt_CT.c
+++ b/net/netfilter/xt_CT.c
@@ -168,8 +168,10 @@ xt_ct_set_timeout(struct nf_conn *ct, co
 		goto err_put_timeout;
 	}
 	timeout_ext = nf_ct_timeout_ext_add(ct, timeout, GFP_ATOMIC);
-	if (timeout_ext == NULL)
+	if (!timeout_ext) {
 		ret = -ENOMEM;
+		goto err_put_timeout;
+	}
 
 	rcu_read_unlock();
 	return ret;
@@ -201,6 +203,7 @@ static int xt_ct_tg_check(const struct x
 			  struct xt_ct_target_info_v1 *info)
 {
 	struct nf_conntrack_zone zone;
+	struct nf_conn_help *help;
 	struct nf_conn *ct;
 	int ret = -EOPNOTSUPP;
 
@@ -249,7 +252,7 @@ static int xt_ct_tg_check(const struct x
 	if (info->timeout[0]) {
 		ret = xt_ct_set_timeout(ct, par, info->timeout);
 		if (ret < 0)
-			goto err3;
+			goto err4;
 	}
 	__set_bit(IPS_CONFIRMED_BIT, &ct->status);
 	nf_conntrack_get(&ct->ct_general);
@@ -257,6 +260,10 @@ out:
 	info->ct = ct;
 	return 0;
 
+err4:
+	help = nfct_help(ct);
+	if (help)
+		module_put(help->helper->me);
 err3:
 	nf_ct_tmpl_free(ct);
 err2:
