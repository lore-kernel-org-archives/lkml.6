Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+zy84bplfukc9v8g8a19DwezxAj3DSHtvV3i+Oad8ICbWSF5bBITa8fY9Y4ptl+7AciwjY
ARC-Seal: i=1; a=rsa-sha256; t=1523022170; cv=none;
        d=google.com; s=arc-20160816;
        b=yCTMUrM0Dd3SQmXpA108geJTl+C0ZvemYUre7FjUtKhoKizKoUbR1jkjwUcwEEXbbc
         FzwcFGlRtV2T/Pxmn8Jjixo/n/LtccE7KwkVUoT0BQRmSO+uxSClyj5rZ1lWcKvKGzXH
         G91iYjVRJp0+IiQo7r01XNPQTRFhvcyrFNbG0Z7HwCdyHM7BzOHapmm/ESUiC3cEMtit
         TwE9Pnq3F8XLVEjScAmsGl5Ip83OtyN4Dy7RUlbmD3GGAbI3OR3zsy4wQZ2WFcEq78H0
         fNTqo4lNQdtvXkxfLIXzHVBlHlyyz0DcZw76HM5t0SrvIZimYdQa1Y7lkNMUiw/0fBhw
         RN2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SleOJK9YIeauy/WSJ3N5taT8jgQna/eYzxVdshtuAwk=;
        b=nLrYCELwc4iOj852sRgmrcEoO6sPXJQE4ITiDqXJetgRDvbX2MQCSqjThkO7xb20rM
         2UXFyAy1nurcmtVJ4VDDVi0lT9bveNv0yhrhIW02mKAepefzHw9oEJ8qOZsUkmVRyq/7
         nzO048MBZXVZuJQKsR7JIz6csZwnwdTseYAUQXMQJfxvSSeb6ZLII0SdoSSiPr1GSF0Y
         Qycg80xKgoIcTbnhAf88j5+7aGW4EQmPO1DvrDzsIRfXopNFHIDlLxusHA1j8VbjCviR
         eI4QQBe5wLeFJ1w9oaRvr1CR5Vp2/YSXBng9wnYtc9SM+r9WcQQZo+7nW24xlA1YvUt9
         Eznw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+0ab777c27d2bb7588f73@syzkaller.appspotmail.com,
	Mathias Krause <minipli@googlemail.com>,
	Florian Westphal <fw@strlen.de>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: [PATCH 4.15 20/72] xfrm_user: uncoditionally validate esn replay attribute struct
Date: Fri,  6 Apr 2018 15:23:55 +0200
Message-Id: <20180406084351.106100049@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003589769714766?=
X-GMAIL-MSGID: =?utf-8?q?1597004496046098918?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit d97ca5d714a5334aecadadf696875da40f1fbf3e upstream.

The sanity test added in ecd7918745234 can be bypassed, validation
only occurs if XFRM_STATE_ESN flag is set, but rest of code doesn't care
and just checks if the attribute itself is present.

So always validate.  Alternative is to reject if we have the attribute
without the flag but that would change abi.

Reported-by: syzbot+0ab777c27d2bb7588f73@syzkaller.appspotmail.com
Cc: Mathias Krause <minipli@googlemail.com>
Fixes: ecd7918745234 ("xfrm_user: ensure user supplied esn replay window is valid")
Fixes: d8647b79c3b7e ("xfrm: Add user interface for esn and big anti-replay windows")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/xfrm/xfrm_user.c |   21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -121,22 +121,17 @@ static inline int verify_replay(struct x
 	struct nlattr *rt = attrs[XFRMA_REPLAY_ESN_VAL];
 	struct xfrm_replay_state_esn *rs;
 
-	if (p->flags & XFRM_STATE_ESN) {
-		if (!rt)
-			return -EINVAL;
-
-		rs = nla_data(rt);
+	if (!rt)
+		return (p->flags & XFRM_STATE_ESN) ? -EINVAL : 0;
 
-		if (rs->bmp_len > XFRMA_REPLAY_ESN_MAX / sizeof(rs->bmp[0]) / 8)
-			return -EINVAL;
+	rs = nla_data(rt);
 
-		if (nla_len(rt) < (int)xfrm_replay_state_esn_len(rs) &&
-		    nla_len(rt) != sizeof(*rs))
-			return -EINVAL;
-	}
+	if (rs->bmp_len > XFRMA_REPLAY_ESN_MAX / sizeof(rs->bmp[0]) / 8)
+		return -EINVAL;
 
-	if (!rt)
-		return 0;
+	if (nla_len(rt) < (int)xfrm_replay_state_esn_len(rs) &&
+	    nla_len(rt) != sizeof(*rs))
+		return -EINVAL;
 
 	/* As only ESP and AH support ESN feature. */
 	if ((p->id.proto != IPPROTO_ESP) && (p->id.proto != IPPROTO_AH))
