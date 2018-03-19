Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuTM1hyB5V070LdnGdC0Cjptck8SSjUCrqjyKW3B5d0nRSqw6JKgfixl8tNYpSlNB+Ee9Vi
ARC-Seal: i=1; a=rsa-sha256; t=1521483301; cv=none;
        d=google.com; s=arc-20160816;
        b=jNDd8S7Y3oW1JQxiYK1RA5X5zVMtVV4Rc113srUp3LFR7KeCmUGGcxnT4gmnFq3ClH
         dmPs4qXeQvL6Urh7wzo3WW5HQHfI7Gc4n2+s2bTK+FOZZ2SiqkqIxKQjMNfCE2OLtRiA
         d0apuGhwa8+AUEmi4YWB3QBE+761XC7qdWocsVCsRDcS2V2oND/b7pAp3LbIGkioQg0P
         6fnm+3rHvZxaflKCWLzRSSKI4ySNf92n40TOVFruN+dMC3wRJkRk0rNanvnXUTEnrNGD
         Nqz8P8XAGVEZELEnQG6sQWEri74AT3CrcqYW99bgueDZTCKJkmbqZdZHoMRNFzzdhFgV
         uT1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=z3ocbS9Kvlmoo1vbNEVeCpcSZ3WVCkF2pzkyG3IaFT0=;
        b=IRuP7p2G6ZzwKiD+KXVNiSAE2gHY7cxzcLl3Ic5bIs4UyQt3HOBsUxAhYEEHVxd5o+
         z121Qg+ylg1bDYTCmrZT6DW2xYI/yFu00rmp5Mhlw9MQwZOU3osTxxDlc4r1fBUYSAqM
         KXHGLgQw3gl6O6sBSx89G6X7inZqpkqO2mISOrT24BFEOgcA9JY16XoNP7G85wLpeoWg
         a8guy9cfU+2mkmY/TPqxtPiZCdu3Un7hXCAb0inJnNfaOmwx2wDvdP0pQdO+EMsIaCrM
         S1HsywO2pPANPGzwy3BNgsTyVFruzK5BA/TIw8SWkZo+wUl11DPPj4pQb16r9NuU0ntv
         mr2Q==
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
Subject: [PATCH 4.4 040/134] bonding: refine bond_fold_stats() wrap detection
Date: Mon, 19 Mar 2018 19:05:23 +0100
Message-Id: <20180319171855.117165172@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390874214479458?=
X-GMAIL-MSGID: =?utf-8?q?1595390874214479458?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3276,12 +3276,17 @@ static void bond_fold_stats(struct rtnl_
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
 
