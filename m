Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+Vunqt3Voktb9c0GFd4YWnBOprlvVaN9rKlOe0bKGl0+esDcMCnkvX5GvLv+pBCPQ2vwHA
ARC-Seal: i=1; a=rsa-sha256; t=1523021306; cv=none;
        d=google.com; s=arc-20160816;
        b=mMCn0x4M0Hkx4XIbw8igRPSdMOUxUY1cQvapU0zf0Dt/r3t0c4tlnBKQwTuNFcfvKm
         N4fPpdwNicHoVvpyhR8eBQ03Q4gfND3/jO6Mxwv/9k/l4TJjO44ejm43gzKhctMTz2Qe
         6cQSA55Tzf9v77tRTypyxDj1kkgh6POGFZ7tj96zPaGAk18pAtzyBrPY7rcjIa8ZQ+Bi
         tOrGXge1NVQIZWY9BR5RPw8Htf1TXJRiwDIcqpSRqrf+N8xmhwZ5PiMJnJ6rydLHn+UZ
         Nr7IbOO9gVR8QTP0NpzO6Icps9gXTgrKR2G+mTqdxWYpMhiKL91DoDGyPcnsmZAs5ffV
         cviQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9Xeg2PKFoMFVxg/qlEPhdV1mFLJhHc850kpewIaoIk8=;
        b=xN5wfH+Dfusmg6k6QmDvGFYAzdzyL85hNqfO7tNHN5+DhmpUCjTrNcjOLCB4f6R1s7
         YO03FfpM9YZ/H3mZk/NQgZ8g7zw9FwnU6E+eg8AckzqcGAAVni6nCdDZ/WxxKXjw+kWI
         XuZaUbemoKJOPOFivDtxLIvdNtjgSBc9O8AnrqmOAbaN9AxUOEzf/SPrEp9ECIVoIBSt
         aexYU9UWD95qVllCm7udE4onY31+v1lnJo6BW49005JZW4qdAqvGXASViBC5qKuLkQgv
         CkmTHjIfa3LoeTCyMo9ma+n1fQgJdAXDFXbnP6zr5whkDws+eUbunoJh9pUFubzQNDo8
         3W4g==
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
Subject: [PATCH 3.18 50/93] xfrm_user: uncoditionally validate esn replay attribute struct
Date: Fri,  6 Apr 2018 15:23:19 +0200
Message-Id: <20180406084227.099421782@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003589769714766?=
X-GMAIL-MSGID: =?utf-8?q?1597003589769714766?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -120,22 +120,17 @@ static inline int verify_replay(struct x
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
