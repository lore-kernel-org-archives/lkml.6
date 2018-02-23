Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519414492-5-5097683829476410168
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
    t=1519414492; b=sPWIibjY5o0z2cNP+Rb64wR8WwsapuPE641PH34b3qAsyNq
    auDARhAiEHf+2pTGLuyJXJzojZH0fd71alzkFZvmrytl+9il5tOSgdctA5eeOvIj
    9YhRD4lI/K/KXHUD9gVHREZVDcdV9IcaivukcW5479lQNx6JIuHrRB6EV+R2eD95
    ItY/0s1c9Zd9lY/m0HmaOtuOVFvMj4rqMtidzRP72A2dGvJY22Ky/liMCgUUVmBh
    R+7OUQbByDHkpbiFAwODrKt6j5Jv+ymPeEUSPeoxQ2VEafSeY2jF1f+84tr5Wwft
    ahuyLD6WVlW1O/joKOK6QzBBBzifkgl3n1OO8Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414492; bh=OXLJB2jUIh2owRri2iMgtZp6v8
    uvNOpO9y0JT58Mcts=; b=UAr5O8+7Qd73XCpgDb/I9oxBszlboo6zueWGSem0nA
    g1jaj38BvrkqqQCFnnDjTF9cMtQNSASvf7t6hBMR2LEa80/HxOltFDy1pbpUS1ff
    QsEZoYQnn1F0P/NWrw3F8be6mYnIXuyN72mjtSWwioNttH7rbdSuZKX3kCf6Y4Jg
    3LaN1U5J/w9O8jpem4jGLGD0I1fwJMVE9iEkNlZjv7BbVPBJW+Yj3D1PpHkpJW81
    idcCUEK897cORjFI8Gd/i02oh9tLgQQJcu2GU+pabdS0DZhDPvb17vacHogqrjRE
    ieeEe4okcXGCl4S3YK1QzRr1Qymmtm3oWBBllC9YWepA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934848AbeBWSux (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:50:53 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45816 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934306AbeBWSuu (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:50:50 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+e149f7d1328c26f9c12f@syzkaller.appspotmail.com,
        Florian Westphal <fw@strlen.de>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 4.14 009/159] xfrm: dont call xfrm_policy_cache_flush while holding spinlock
Date: Fri, 23 Feb 2018 19:25:17 +0100
Message-Id: <20180223170744.323363188@linuxfoundation.org>
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

From: Florian Westphal <fw@strlen.de>

commit b1bdcb59b64f806ef08d25a85c39ffb3ad841ce6 upstream.

xfrm_policy_cache_flush can sleep, so it cannot be called while holding
a spinlock.  We could release the lock first, but I don't see why we need
to invoke this function here in first place, the packet path won't reuse
an xdst entry unless its still valid.

While at it, add an annotation to xfrm_policy_cache_flush, it would
have probably caught this bug sooner.

Fixes: ec30d78c14a813 ("xfrm: add xdst pcpu cache")
Reported-by: syzbot+e149f7d1328c26f9c12f@syzkaller.appspotmail.com
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xfrm/xfrm_policy.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -975,8 +975,6 @@ int xfrm_policy_flush(struct net *net, u
 	}
 	if (!cnt)
 		err = -ESRCH;
-	else
-		xfrm_policy_cache_flush();
 out:
 	spin_unlock_bh(&net->xfrm.xfrm_policy_lock);
 	return err;
@@ -1738,6 +1736,8 @@ void xfrm_policy_cache_flush(void)
 	bool found = 0;
 	int cpu;
 
+	might_sleep();
+
 	local_bh_disable();
 	rcu_read_lock();
 	for_each_possible_cpu(cpu) {
