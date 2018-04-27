Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp9kH3Nej6tHrRHRz0PMSeOj1c7vF3EBMDvgmD2qLntrnCLfPi+LNKTg+L5+zdq/miX1Hc6
ARC-Seal: i=1; a=rsa-sha256; t=1524838357; cv=none;
        d=google.com; s=arc-20160816;
        b=pH1DE+tBt88WsjRnvq0F1HDwfTCCaYR9lqwtxwi4lkABDG8+Vak5l2QZG7EPhASeV8
         slOpfDj/d/Ev8qGn9EYV/lmu5YaE5Uc1OnYy9RiKn4bm4S1kkst4XQr3EhP4M6sjgjsE
         T8g52Q9h/UNr0rZXK+vgvhJWWTYqBMpyUS7w+5nlvLsGHJwGrJwrqwoMWdi3DuKTOkK0
         WsQTVcyZUHIn9NQByOR3kXqGwDy9tICUDnC+zs05msI5AAKpjkz6ftOjUkWS4CEGJK3R
         3Ja3SPmSZ253z8CiJGHhgY3GOiH+j624526gZXENiTFu8rHFKQjVP+DsNdwzsJVfSnpy
         ELlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=7BVEN3zhcKcPCblJKUlLEIbqfQzYU5KdwuR3zB04X14=;
        b=pp+WlM9bRuk3mX+JyDU40L8mxHbVns90siLUY7Fp3us5p9zTpmSEpnifh3Sp+cmJ/N
         GGuDECt/mxHhX3YAHnp3V5b/wkjmb4LcUJVFE2x95BXYUuIoYRhCNPGY3MoVY6t4eaXL
         OaQl+rJMGywxHN2OLarQVTcZJPO8TIK4AqEwLpgjyZ/G/0urrOYUMh+P9aCNkGVts4W0
         lP9L50H6Tz9qwxHEF06tM3UuNUYQ2FeWt4SMLqNYjxWeYk2hWFziQEoyNGV0lxH5HVHH
         mBE6LazqmFN0QqCxSfsD5IyHAGJI8d4//Dlm8TskfcUXu8b/uqMiS5LzOpcHsiIZmfdd
         Rq7w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9400B21895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Guillaume Nault <g.nault@alphalink.fr>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 42/81] l2tp: hold reference on tunnels printed in pppol2tp proc file
Date: Fri, 27 Apr 2018 15:58:44 +0200
Message-Id: <20180427135745.586803394@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908905488571906?=
X-GMAIL-MSGID: =?utf-8?q?1598908905488571906?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guillaume Nault <g.nault@alphalink.fr>


[ Upstream commit 0e0c3fee3a59a387aeecc4fca6f3a2e9615a5443 ]

Use l2tp_tunnel_get_nth() instead of l2tp_tunnel_find_nth(), to be safe
against concurrent tunnel deletion.

Unlike sessions, we can't drop the reference held on tunnels in
pppol2tp_seq_show(). Tunnels are reused across several calls to
pppol2tp_seq_start() when iterating over sessions. These iterations
need the tunnel for accessing the next session. Therefore the only safe
moment for dropping the reference is just before searching for the next
tunnel.

Normally, the last invocation of pppol2tp_next_tunnel() doesn't find
any new tunnel, so it drops the last tunnel without taking any new
reference. However, in case of error, pppol2tp_seq_stop() is called
directly, so we have to drop the reference there.

Fixes: fd558d186df2 ("l2tp: Split pppol2tp patch into separate l2tp and ppp parts")
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/l2tp/l2tp_ppp.c |   24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1559,16 +1559,19 @@ struct pppol2tp_seq_data {
 
 static void pppol2tp_next_tunnel(struct net *net, struct pppol2tp_seq_data *pd)
 {
+	/* Drop reference taken during previous invocation */
+	if (pd->tunnel)
+		l2tp_tunnel_dec_refcount(pd->tunnel);
+
 	for (;;) {
-		pd->tunnel = l2tp_tunnel_find_nth(net, pd->tunnel_idx);
+		pd->tunnel = l2tp_tunnel_get_nth(net, pd->tunnel_idx);
 		pd->tunnel_idx++;
 
-		if (pd->tunnel == NULL)
-			break;
+		/* Only accept L2TPv2 tunnels */
+		if (!pd->tunnel || pd->tunnel->version == 2)
+			return;
 
-		/* Ignore L2TPv3 tunnels */
-		if (pd->tunnel->version < 3)
-			break;
+		l2tp_tunnel_dec_refcount(pd->tunnel);
 	}
 }
 
@@ -1617,7 +1620,14 @@ static void *pppol2tp_seq_next(struct se
 
 static void pppol2tp_seq_stop(struct seq_file *p, void *v)
 {
-	/* nothing to do */
+	struct pppol2tp_seq_data *pd = v;
+
+	if (!pd || pd == SEQ_START_TOKEN)
+		return;
+
+	/* Drop reference taken by last invocation of pppol2tp_next_tunnel() */
+	if (pd->tunnel)
+		l2tp_tunnel_dec_refcount(pd->tunnel);
 }
 
 static void pppol2tp_seq_tunnel_show(struct seq_file *m, void *v)
