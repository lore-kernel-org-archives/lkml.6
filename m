Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu/iQAWijv7wsgW4SBE+K7sV3IYqo3WqKOGdjTpI0IdMsFaXxQ3mycxGp0tfWg4Zem/JVQe
ARC-Seal: i=1; a=rsa-sha256; t=1521483333; cv=none;
        d=google.com; s=arc-20160816;
        b=ABGd+R2x3HBRY30eeckPJcVaQHroGK0WQR2/2a3BWFbrRYTxzflOejoYylzNaACz4H
         bMyPB3Mj6avXto2VpF1SL30OdSqdflhK3YCCTXSGfeTDE3xlOt2nydMkQqsxX73T14UH
         /ojjspZ9q/Q1VsfoL4TF6JgQepUzK+kGo+SstHf3nnXBkQbxPhAXkb+sde843bUMMdcN
         woGvTbjTszALWLqFiUxRt4MbBHOj8KJPIZQrbGgXLiYMtSStbkuKH4vvufbMZ6si0hzY
         dWd6AG8qwwPxVft3IaD97Bw7XAzH89C3RCROt8p+wkaOO5eQIpCLAmDQUfLUk/tokXe9
         /Vfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fQHCQiF7PGlaEAx2QMjdrF5ff9lwvW5J6dsyr2TI2+I=;
        b=Xu3ouhWqKNrxfRFKxNynBFpN82Tj875FN5mU14Zm6utgQqT+56OCPceyvu1BQLzo0W
         0oAKgYSU3/l/I+D5ez2vJS4JEgcNYjjoqgZa9EURr3RD7htpEKvrTnWM5sZTaNyQpgl0
         q0NzC4IWM6GX0qFwGdCxCllw0wjamwHw0pJn2djFB4iqiFT3+7G5b2S4uwhELYRRG4w7
         6PDSb2hckMkjY1HBtsRDTpAL/lOprgP83zQwLqjNyzLEtG4JVNO70M2Goz+b6IilgJa2
         0Atr/Zw7e2uRfdWepb5GPDr3XPIMSCjwKVWXei7HuU6Tkst6ZX7JCCUgx21C2s8iisd3
         yELA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lorenzo Colitti <lorenzo@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 086/134] net: xfrm: allow clearing socket xfrm policies.
Date: Mon, 19 Mar 2018 19:06:09 +0100
Message-Id: <20180319171901.737465095@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390600351350074?=
X-GMAIL-MSGID: =?utf-8?q?1595390907800430934?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Colitti <lorenzo@google.com>


[ Upstream commit be8f8284cd897af2482d4e54fbc2bdfc15557259 ]

Currently it is possible to add or update socket policies, but
not clear them. Therefore, once a socket policy has been applied,
the socket cannot be used for unencrypted traffic.

This patch allows (privileged) users to clear socket policies by
passing in a NULL pointer and zero length argument to the
{IP,IPV6}_{IPSEC,XFRM}_POLICY setsockopts. This results in both
the incoming and outgoing policies being cleared.

The simple approach taken in this patch cannot clear socket
policies in only one direction. If desired this could be added
in the future, for example by continuing to pass in a length of
zero (which currently is guaranteed to return EMSGSIZE) and
making the policy be a pointer to an integer that contains one
of the XFRM_POLICY_{IN,OUT} enum values.

An alternative would have been to interpret the length as a
signed integer and use XFRM_POLICY_IN (i.e., 0) to clear the
input policy and -XFRM_POLICY_OUT (i.e., -1) to clear the output
policy.

Tested: https://android-review.googlesource.com/539816
Signed-off-by: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/xfrm/xfrm_policy.c |    2 +-
 net/xfrm/xfrm_state.c  |    7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1313,7 +1313,7 @@ EXPORT_SYMBOL(xfrm_policy_delete);
 
 int xfrm_sk_policy_insert(struct sock *sk, int dir, struct xfrm_policy *pol)
 {
-	struct net *net = xp_net(pol);
+	struct net *net = sock_net(sk);
 	struct xfrm_policy *old_pol;
 
 #ifdef CONFIG_XFRM_SUB_POLICY
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1845,6 +1845,13 @@ int xfrm_user_policy(struct sock *sk, in
 	struct xfrm_mgr *km;
 	struct xfrm_policy *pol = NULL;
 
+	if (!optval && !optlen) {
+		xfrm_sk_policy_insert(sk, XFRM_POLICY_IN, NULL);
+		xfrm_sk_policy_insert(sk, XFRM_POLICY_OUT, NULL);
+		__sk_dst_reset(sk);
+		return 0;
+	}
+
 	if (optlen <= 0 || optlen > PAGE_SIZE)
 		return -EMSGSIZE;
 
