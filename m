Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsguPFQXW1TkBeYf6o87yrcxUx1S/ynP41yyEuVVu8CtaHIRipY4oJzMd5dXO0GdHWoG+RR
ARC-Seal: i=1; a=rsa-sha256; t=1521483039; cv=none;
        d=google.com; s=arc-20160816;
        b=UlaeiQ1HmSdBTTUJ41HpD6DgjQSkC9wkx3qS1DSNfzJfoWII/1/ri1FNMHrnLqlgT2
         oePpX48vXWzu+WiTLrOf4JERLEE7oVHMeacpn87paJ1EWl8iibqGR8cEQ7fBjiIT3ETr
         XdogarNT2hYgKdesputPSA0HGS0K2pUJbA4DYEDs456ZZPQI3F0d/trmOOWqVpaeknE7
         1HrW9b0gKnR+ieH31mreKCEUWEr+so+K9Npi3PWwcFuRcWgNTzeAmS2xdijwGN7nhPo2
         YVsm2mhEk65Rk17jpK0q0b0ZhxYKmgDa1S4cY7SV2o69dckif5lzA2EBllPKpYqTwTuf
         VQmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=7FKPauKmaCQhhbaG9598Joax+VJsGdcKJklN5nVM9pw=;
        b=JeFrn7eNTVgWrpAidp6JIgudNyMsdEBJ/2PLmM+R9NVo3rzfEshFr59bVRw86D4LxA
         GOs3K1zyVL22taSj6B2XWE/QYXGJRN/vNlb8qe35aAh4mWtlf7qUnGQsSwMqqKncukEN
         b251rMPKgdkuusnleLMBMqADM9Ho0H0r2LVT6/vWjuNhUUmNEBmvl03WdqCtIe+B6T7R
         zrT8paz3n8pIjYeGYiIb6Mv5YmUAyiNouYCVuMFPOufoD03j9S+zVxnh58W5dQ8fZejl
         Nlq//d5GRnGSFI2/pY0RXz3WyWtTANGhbeRzRP0Z46s6tasP1VfK5SAkmt0slATwdwaI
         aL7w==
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
Subject: [PATCH 3.18 46/68] net: xfrm: allow clearing socket xfrm policies.
Date: Mon, 19 Mar 2018 19:06:24 +0100
Message-Id: <20180319171834.377382351@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390600351350074?=
X-GMAIL-MSGID: =?utf-8?q?1595390600351350074?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1292,7 +1292,7 @@ EXPORT_SYMBOL(xfrm_policy_delete);
 
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
 
