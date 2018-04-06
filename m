Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49i4NHr6Onzj3I0hOEwAdlOVOSPSac1HUzxO+dVmXQIZPqOkedap0/k7omEBC7JCLOSCLpm
ARC-Seal: i=1; a=rsa-sha256; t=1523021654; cv=none;
        d=google.com; s=arc-20160816;
        b=x0Po/yK8lNu1tPYh6bl/bYp3vwe22HpjiAvqCHgJqsmM1H9LJAaykvT/lD9dorJpJg
         Af4Q6sto6b2gazrgMK8yVha0gXxAoiV9BnUCUo6EW14Dg99/7xbW/PmyRyLTJfbpQP/4
         jkch9PEkkufSVv4NpcBR9c55g5BlaBPP3uRGkTtDaN2D7tjfCzv6kcGgdhiUokT9JIP2
         wqFTSLln6A863FIKid/ifLu3V5kLOLhecp7Pgrnld+EmDldlwXzzmuJmtLCK6qLHqQAd
         pXBzy2u6L0Ww2vVrwZhMk3lcSLECfUWHTcSd8BjB0w2QLafbu/8enepWhBCIjv5Knn4V
         ycNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RZlTVomttObMDN6k4CYBsEkJBCM/V5MEZiSlqckygAg=;
        b=v1oGbLUp6mN8wjQgtRtl5h/90uczclzZy00oT6Ztu54MYh+39/besyx1Zg3PwIaYDV
         UCypAUFoU/Os+O2Ydnz8D5YBkbpLZ4tSsw4SDL8NrF5ikgAMQDyScEiNod5D+dXEgrKW
         /be5mzw2gCpdxTvBxnDgn9SqvdR+9YoGMiEjLZHF1ZX0Un3aoxvUYlxqlTB92AqJDYWb
         k7rGdSWh1dOUmQiH/SFeyF1mHYR+sjn4iM3rIw/McLgxcaRFzzD0e+i90MQVQowUdoEZ
         xBQ5asZ5xyu4c1ezorXAfZvrbGm62+7RS9LlhcPfXNJ2L+h3sSqWYKK0uVwga+eI7/lF
         W+aw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 4.9 043/102] xfrm: Refuse to insert 32 bit userspace socket policies on 64 bit systems
Date: Fri,  6 Apr 2018 15:23:24 +0200
Message-Id: <20180406084337.671553443@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003595252777127?=
X-GMAIL-MSGID: =?utf-8?q?1597003954506442850?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steffen Klassert <steffen.klassert@secunet.com>

commit 19d7df69fdb2636856dc8919de72fc1bf8f79598 upstream.

We don't have a compat layer for xfrm, so userspace and kernel
structures have different sizes in this case. This results in
a broken configuration, so refuse to configure socket policies
when trying to insert from 32 bit userspace as we do it already
with policies inserted via netlink.

Reported-and-tested-by: syzbot+e1a1577ca8bcb47b769a@syzkaller.appspotmail.com
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xfrm/xfrm_state.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1883,6 +1883,11 @@ int xfrm_user_policy(struct sock *sk, in
 	struct xfrm_mgr *km;
 	struct xfrm_policy *pol = NULL;
 
+#ifdef CONFIG_COMPAT
+	if (in_compat_syscall())
+		return -EOPNOTSUPP;
+#endif
+
 	if (!optval && !optlen) {
 		xfrm_sk_policy_insert(sk, XFRM_POLICY_IN, NULL);
 		xfrm_sk_policy_insert(sk, XFRM_POLICY_OUT, NULL);
