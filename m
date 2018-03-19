Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuSiY+9RI1c8fKGN1twMPCX0f8UBJwX3XhmOBHOCtbOsqhUVyrxROCVY0RNPiLUZ5iqhaHx
ARC-Seal: i=1; a=rsa-sha256; t=1521483698; cv=none;
        d=google.com; s=arc-20160816;
        b=vEgaI4akbY/a6uP2c7J1OMfNBsk1gGwbtH+gkkNd8zjUoJcN7aY2OGJtzS+ARvy6uW
         sIgMy1B4HQA+rXEGP9ePDw8jNZ2xgAGJitDtreTsoRNE/DNAIYj/2hLBBh63Mchp0mWS
         uSJH7flzjor1/obKqG5xbYyIaVQQl+vwB9ogtp5+rKP80OHHYaJwZ2QEZuwGxXX+plkJ
         Wq/DYq+ASwbLkEDAAFYfQx/iM9NaPEfV425vQ+N54NKTlJ989YHHJrQKoAS7LPEG1pml
         B6yiS/Fg5bFzh9XB+w5zqUnEpSBcNTHB0vDk7+eyRN3mCXNDvjDYc+NYFOskK9mvvjrL
         UVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Gv5uNCfuSpIm8ZTExakhATehXXsuld+lUP4QTKvXSKo=;
        b=Op1BtcvM/pp8uyWCNXtNgz7FVw2nqubEK9IhUIp/t6lk739s6o2JoUVtujcoaAfCT0
         vj2dXOIDCxGK6rR++k4OP+0a68MWXoAGyqfSV/WnT4onayzHyH2x09Ynaz6olIRg48Sb
         pUi8/oJJp1X55bfpX9lg2k02Xn/7NdE6KaHTjhKljKDbULZwz088X8DD0Kve/Fm9rL87
         nORHfP9i7Qm1rY6HVpHno0fepYfV0N+N8pvsWbrzvJeCUSzd7YapYIN31uxHEnzy/2iK
         +6PMePtf0vjtuxcIUi3X+LXA3mCOaYBbPAJFZljAyAIW3njCjrOfIqt4KtVGkS4fbWV9
         NyNg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 084/241] bonding: refine bond_fold_stats() wrap detection
Date: Mon, 19 Mar 2018 19:05:49 +0100
Message-Id: <20180319180754.675387089@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390874214479458?=
X-GMAIL-MSGID: =?utf-8?q?1595391290327686570?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit 142c6594acbcc32391af9c15f8cd65c6c177698f ]

Some device drivers reset their stats at down/up events, possibly
fooling bonding stats, since they operate with relative deltas.

It is nearly not possible to fix drivers, since some of them compute the
tx/rx counters based on per rx/tx queue stats, and the queues can be
reconfigured (ethtool -L) between the down/up sequence.

Lets avoid accumulating 'negative' values that render bonding stats
useless.

It is better to lose small deltas, assuming the bonding stats are
fetched at a reasonable frequency.

Fixes: 5f0c5f73e5ef ("bonding: make global bonding stats more reliable")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_main.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3331,12 +3331,17 @@ static void bond_fold_stats(struct rtnl_
 	for (i = 0; i < sizeof(*_res) / sizeof(u64); i++) {
 		u64 nv = new[i];
 		u64 ov = old[i];
+		s64 delta = nv - ov;
 
 		/* detects if this particular field is 32bit only */
 		if (((nv | ov) >> 32) == 0)
-			res[i] += (u32)nv - (u32)ov;
-		else
-			res[i] += nv - ov;
+			delta = (s64)(s32)((u32)nv - (u32)ov);
+
+		/* filter anomalies, some drivers reset their stats
+		 * at down/up events.
+		 */
+		if (delta > 0)
+			res[i] += delta;
 	}
 }
 
