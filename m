Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226lL1W8w/lqGtm+ZcNuPAwUtTtmOYiETLLJkUkifaGS4Djj+e3C7SVGRlznRuH3L9VtUEMC
ARC-Seal: i=1; a=rsa-sha256; t=1519410852; cv=none;
        d=google.com; s=arc-20160816;
        b=BP/xyuGLqa5LPLjDGOcFTiAqx+mX8b0wqSbmLINPrZ4HX4aTOE6QbYBR6/+jZ1g3i8
         l0YE/H7RAGVL8nLcVJLOG0Ikh0OoQMalKfvB12kF20wh2c0gEWm7cjzY2ehYS15BQ5+1
         WjHExW19GgA2ZNA4pu4wFuJY8yMFDO6E+0cws/ULon1q7BjvVpoF8jnc3O4ql+benEpy
         nMRZimjVpgb+fk5uxM3Pqzg+htESZPeF8X/ZQHYnLjrF6SgS3mqcAe+Pqcip4uLceR/i
         DKJhNk4aq3izGBQzxsxexSvLS7fQMZYI6SgQQ3JRJLyq/3Hi/QKblTpZoibZN2Nqip3Z
         OzKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Z430NQdBWr/2EFJ1NtkrIp3coxA/9/ua68ie58fXdlc=;
        b=qQA2f5+8iKmtalOEpo4LqI4vsWWYwn6TEGjOJkROBRHu2gMTJtIhKqXdtGrSeGgvy/
         JlPK4Lq1jvPy3j4udJfg8tNicTQELgkvedwbSdrwIdQpP+CuNLg0AiReaATY3mlgt+2m
         QksnjtlPNgOjAz1fQ4Bc3pXTzX/2XD5M2egDjAqXOprSxp0hUADnUYG1QmgsDU66mVnc
         zbnw+Z7ZjW32jwMMINPNfN1dqTOjgClLvKMP5EzIwrNQLpw9zo0nl/MFrDLH8pwDjTcJ
         QJpm/FdNghldFuWVCYLAtD/bJCFOLEVLrMoikleD/hxtxAWZprIkPb/tSkiWTjlIAeV8
         DHkQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot <syzkaller@googlegroups.com>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 4.4 005/193] xfrm: Fix stack-out-of-bounds read on socket policy lookup.
Date: Fri, 23 Feb 2018 19:23:58 +0100
Message-Id: <20180223170326.927973666@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217754284204073?=
X-GMAIL-MSGID: =?utf-8?q?1593217754284204073?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steffen Klassert <steffen.klassert@secunet.com>

commit ddc47e4404b58f03e98345398fb12d38fe291512 upstream.

When we do tunnel or beet mode, we pass saddr and daddr from the
template to xfrm_state_find(), this is ok. On transport mode,
we pass the addresses from the flowi, assuming that the IP
addresses (and address family) don't change during transformation.
This assumption is wrong in the IPv4 mapped IPv6 case, packet
is IPv4 and template is IPv6.

Fix this by catching address family missmatches of the policy
and the flow already before we do the lookup.

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xfrm/xfrm_policy.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1225,9 +1225,15 @@ static struct xfrm_policy *xfrm_sk_polic
 	read_lock_bh(&net->xfrm.xfrm_policy_lock);
 	pol = rcu_dereference(sk->sk_policy[dir]);
 	if (pol != NULL) {
-		bool match = xfrm_selector_match(&pol->selector, fl, family);
+		bool match;
 		int err = 0;
 
+		if (pol->family != family) {
+			pol = NULL;
+			goto out;
+		}
+
+		match = xfrm_selector_match(&pol->selector, fl, family);
 		if (match) {
 			if ((sk->sk_mark & pol->mark.m) != pol->mark.v) {
 				pol = NULL;
