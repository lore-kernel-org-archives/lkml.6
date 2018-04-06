Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49KKf/sTnyPOmvtR/0tkan6r5O073JNXJh1xY1YR+lsi6ie7UYSAgvy18IIkdG3AYChoUwV
ARC-Seal: i=1; a=rsa-sha256; t=1523021417; cv=none;
        d=google.com; s=arc-20160816;
        b=wz2QynobsNMeYzDgSaPlc+vjhRkna5jPgPSad7snusba1vNGcDO0zDH2jJeKT99rOr
         1lhu0e+f2ef59Bsz5PxuOtbp5+eMF/bes/kDX0AR5UP+sye3PxL++TErIoiiQy0YJ/yf
         I93t9b6lhirt81h2NE6aWQ+B1tHqu+q7AmsPIHYYW9KmUBHlqJtDT5UNX2VGS2LGip7m
         CLSRaowVbEzINq0+GHQtBg6XjFKXTX65TD7gA8z20jGur/U/MAfbTvp+W2m0iZq1YCb4
         iEUPiUM0iZANIJwNBbNeshsviybIlrkYGkq9jwh0oWjIt5nhDaAjbu7qMI4mBxo7iIF6
         HAig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tY/YgS+XmkntmZU0iqwZe4QoCoR+lKFZeEpygF2OU+E=;
        b=nVaNUiZtFhquLwaMtEoX9w4GPcqO6PHSlQuws7QhgNSIx6PDzgebrYZWTha0PssoAv
         QqmfQXCU7PFP2OvumLETgqjBIJBDHq8Kc9qhiqJcL4ZgxxV00ymgZbLPYaDVn+7snak2
         eQB/mZtkShUvWpsfmSSQFUKy/sWk4Xnjo+Aqy807IznFdIVsjEMjwEZKWcW5Vb63yW78
         AOxzW3aLRtvV5CGqL2x2l6Jr3XRpAnWGBqfIebQl09wyqquBqFolYOfwDCPe9/m2u/9h
         TYLWHbLTCOkFyWYtmHXHZD6iUi2FEfb42PatdN1I8L2cgvn8xQYubi0vm4eRusjYOPzF
         Fw1A==
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
Subject: [PATCH 4.4 29/72] xfrm_user: uncoditionally validate esn replay attribute struct
Date: Fri,  6 Apr 2018 15:23:30 +0200
Message-Id: <20180406084307.599112744@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003589769714766?=
X-GMAIL-MSGID: =?utf-8?q?1597003706037607953?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 
-		if (nla_len(rt) < xfrm_replay_state_esn_len(rs) &&
-		    nla_len(rt) != sizeof(*rs))
-			return -EINVAL;
-	}
+	if (rs->bmp_len > XFRMA_REPLAY_ESN_MAX / sizeof(rs->bmp[0]) / 8)
+		return -EINVAL;
 
-	if (!rt)
-		return 0;
+	if (nla_len(rt) < xfrm_replay_state_esn_len(rs) &&
+	    nla_len(rt) != sizeof(*rs))
+		return -EINVAL;
 
 	/* As only ESP and AH support ESN feature. */
 	if ((p->id.proto != IPPROTO_ESP) && (p->id.proto != IPPROTO_AH))
