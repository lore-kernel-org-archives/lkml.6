Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu4SL/hNgFfkGNrMcXLQqbpPDjsjwXch7RnooTEOJKZhezuiMW0ZovMWK7JCrvMVSZqluek
ARC-Seal: i=1; a=rsa-sha256; t=1521483163; cv=none;
        d=google.com; s=arc-20160816;
        b=g/Eb+hFLGxe2nLufWobp/NbNXwhJsEH755QPs6w8L3PJFWQazCpEwfR+01rDT2GQFx
         rlPb6Nk32NO08mwfCCnP3TVwx9XuZ5xT15UTa9UPwuIlXSh3c4ha+D4spFzXl4m6+JUI
         BqsP+wjkje1pJX8LMNCNv4ukHf+dY1ID/TtkrtmniXQ6KvWwVBzND+i3kJfCsy0V2F7w
         4STsJDIvLsbsSEYana9J8af6awQZdDE5HJbXMUTkcM5o5ubupH6hGIIUMVmPzSDuGECB
         59SPELtTJ/jltTQvBQjmzpcjq9Uv+v9D76LEnQ7tgVXTBsz6eBs39KrRe5tWJBqMq3kx
         C+Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=m/tWwmcNfihDA+YIYx6JkzrGh0bVX4acZ52kTPrHO/U=;
        b=KFuVJ1qt5p0nwwfABGzYD/T1oFAOQljoldLk450duxqYxsqM1rIqzW2C5tszmO1z76
         kA4l/CRzRsFNIuUGzakOTPbIDNijCxVxK3Rd295ia97XIYaJH51YodDH5zoIxawv4dqe
         /Wty9jcwxUfeHvJjdeB3gZLn1JQmeuzmI4BKk1q2aTMu5HYYJTfd31AoMB+tiycXi0IG
         QqU19zly+dt4Tr+0xif6Ly+ihwMzYu2nGgVLiazafMz6WI/4QsmP5u5VvkEsFxJGYKbX
         55le/dXAalnL3W+MMXy6FGpBvycPHNMkFou55nHYzDPAaHXTsIh8TqFIhxi3lelzwCEX
         /ZBg==
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
Subject: [PATCH 4.4 022/134] batman-adv: handle race condition for claims between gateways
Date: Mon, 19 Mar 2018 19:05:05 +0100
Message-Id: <20180319171852.398262408@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390506286270414?=
X-GMAIL-MSGID: =?utf-8?q?1595390730037960529?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1603,10 +1603,22 @@ int batadv_bla_tx(struct batadv_priv *ba
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
