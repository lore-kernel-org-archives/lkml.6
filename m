Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuJVk9fJ3WXXqnpghmBhyAhnvxKfIIyI5ETyNb8xAFkQ4uQPV49nnGrYBLRNDl13ljtutT8
ARC-Seal: i=1; a=rsa-sha256; t=1521214900; cv=none;
        d=google.com; s=arc-20160816;
        b=FZswXZrBz81LzqN7ltW9Z0o6XbnZkfFaZcmTVytmFw8vjSr3jiRiszQ9RFyIQu7+k/
         fJFPrwoRdyBSjJDz5Bc6M+0iZJ2HrAomjCYd8AoIF4Y9gD9XwEEoLDYlJ582+xyHEibw
         xqw8CO2DDeOLxfVTFylJGFLbZxztAkg8+NH1RAnv/7vu2i4rjEEmNVQS/OooN01jCkXZ
         Np0QpATWxr3opwtXBQz5Bgk7ENVaIeoDJRbF/PFC1JVdsloMDKRoa3NNfIhGB0phIDVH
         g7GR4IadYHUvq07gngBtlShGrLiRFnV41bAt6E6lLNUxTg15r8rKG8+YbtXdm2uOeuLC
         MmWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hMfcw88TKNYXHsZNdiDJ47ntVnZKETechUiaVomQWRI=;
        b=uewSeV1e93lP9Sq3k5DejqRDj3f9KxJw74puvOc9jYBvm2v0YBKBymR3wuPMkkvwRl
         sLlOcTcaPyy7TgL+gHbwZ/LO0RSmESbWUyrJYb+mvWEWmrVBnXQtTsdXHxuvJPQRhH4E
         Vxlj3MXZQM1Lb01W4czfK7/ImsnKhQ/4bxA2LlNVbf1g0VU+SldXUNKCuHb2q8Ro2LSN
         nVmrf7/7ic1jDvLr9Nn8CK7eC1qESmV4Idl7RtYUTR/5qVbHWGm4mDcYorwGJbrnyrFI
         TP5sO//15Bc1ueqKVCPe1+k4q3JaGGH/LKSLrluNM850cVp5nasstE/Q0tNh1Hkvrnig
         owZg==
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
Subject: [PATCH 4.15 057/128] net: xfrm: allow clearing socket xfrm policies.
Date: Fri, 16 Mar 2018 16:23:18 +0100
Message-Id: <20180316152339.672814818@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109072211741027?=
X-GMAIL-MSGID: =?utf-8?q?1595109435947325766?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1256,7 +1256,7 @@ EXPORT_SYMBOL(xfrm_policy_delete);
 
 int xfrm_sk_policy_insert(struct sock *sk, int dir, struct xfrm_policy *pol)
 {
-	struct net *net = xp_net(pol);
+	struct net *net = sock_net(sk);
 	struct xfrm_policy *old_pol;
 
 #ifdef CONFIG_XFRM_SUB_POLICY
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2056,6 +2056,13 @@ int xfrm_user_policy(struct sock *sk, in
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
 
