Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtvbtfNk7+hBO8USdzTxTZk8r7rBD/hsu1lY4lKjKBRFy5GkaJkYeHX7ZjXBFoJsa5Gs0s/
ARC-Seal: i=1; a=rsa-sha256; t=1521483605; cv=none;
        d=google.com; s=arc-20160816;
        b=hbjrlRiI5ZnzZmNNDQ6yTaE7begU40uTrn3DrCmhaDcT11eGjOKLhI5BALODvB5ZfB
         Q2Tpv3jFj3J0rOFFwPoIT2Sp+RuxK4KiTWwANfeqZM+KM6IR9dWOi2bA5M09Z6NGKu/I
         d+vLAp13+WgJXtXeuab0XJlk5Qg7s/gKpgru5XBrj4enSbXQAdhRLTL01TvdQ/9eTaUr
         SXeQqAVx1h/wvC75qXw2kki5pQq5jeRV4/PKNWfHttnINt5MOg/BKcZD18fiER+HRCzb
         UiNkuig4swKHM+6D24gsYI++iyoRwgh+p2GarBWbcYM4Vzl4GK4ELPX7XjxUhbA1pHzW
         KRpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wTYOY/im2wLdK3Ivc5DkdMYyyq7X8PlFFl34t0wkqe0=;
        b=bSXHArG2rMmJF5KT26N8LEG7YDH10pv90afwl1zSHKjrSGpZlX6OvB6skEWNygeEpZ
         Rh6SlzL7Y+RllTgGYmuhhD5gY80kOJs4KWgjgBlUxUixNrMWx91vij5hzyRzSZ9nAjqL
         VpA8U9XjKLJnWHb+iv3ScgsfehzDMmr+V8pym6nxKxO0/svvHT8jjGCqDznapMKKIl1U
         Ia8WoGGtb8BSD7odYReDqa8SsOb8vtUUYpe2yfoxP3a9zQr05DVOcyArlL/CogzbvXTW
         Uc6WI89hSAs4Uq63naTb2N6s1mz94MeDVh1YScKCurjiwVR1847XTBgY5LsH2pIqaAUs
         BZnw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Andreas Pape <apape@phoenixcontact.com>,
	Sven Eckelmann <sven@narfation.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 049/241] batman-adv: handle race condition for claims between gateways
Date: Mon, 19 Mar 2018 19:05:14 +0100
Message-Id: <20180319180753.240133786@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390506286270414?=
X-GMAIL-MSGID: =?utf-8?q?1595391192971257223?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Pape <APape@phoenixcontact.com>


[ Upstream commit a3a5129e122709306cfa6409781716c2933df99b ]

Consider the following situation which has been found in a test setup:
Gateway B has claimed client C and gateway A has the same backbone
network as B. C sends a broad- or multicast to B and directly after
this packet decides to send another packet to A due to a better TQ
value. B will forward the broad-/multicast into the backbone as it is
the responsible gw and after that A will claim C as it has been
chosen by C as the best gateway. If it now happens that A claims C
before it has received the broad-/multicast forwarded by B (due to
backbone topology or due to some delay in B when forwarding the
packet) we get a critical situation: in the current code A will
immediately unclaim C when receiving the multicast due to the
roaming client scenario although the position of C has not changed
in the mesh. If this happens the multi-/broadcast forwarded by B
will be sent back into the mesh by A and we have looping packets
until one of the gateways claims C again.
In order to prevent this, unclaiming of a client due to the roaming
client scenario is only done after a certain time is expired after
the last claim of the client. 100 ms are used here, which should be
slow enough for big backbones and slow gateways but fast enough not
to break the roaming client use case.

Acked-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
[sven@narfation.org: fix conflicts with current version]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/bridge_loop_avoidance.c |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1964,10 +1964,22 @@ bool batadv_bla_tx(struct batadv_priv *b
 		/* if yes, the client has roamed and we have
 		 * to unclaim it.
 		 */
-		batadv_handle_unclaim(bat_priv, primary_if,
-				      primary_if->net_dev->dev_addr,
-				      ethhdr->h_source, vid);
-		goto allow;
+		if (batadv_has_timed_out(claim->lasttime, 100)) {
+			/* only unclaim if the last claim entry is
+			 * older than 100 ms to make sure we really
+			 * have a roaming client here.
+			 */
+			batadv_dbg(BATADV_DBG_BLA, bat_priv, "bla_tx(): Roaming client %pM detected. Unclaim it.\n",
+				   ethhdr->h_source);
+			batadv_handle_unclaim(bat_priv, primary_if,
+					      primary_if->net_dev->dev_addr,
+					      ethhdr->h_source, vid);
+			goto allow;
+		} else {
+			batadv_dbg(BATADV_DBG_BLA, bat_priv, "bla_tx(): Race for claim %pM detected. Drop packet.\n",
+				   ethhdr->h_source);
+			goto handled;
+		}
 	}
 
 	/* check if it is a multicast/broadcast frame */
