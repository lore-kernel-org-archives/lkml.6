Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo8oVgaUxxtvt8GHBzajOHK3cLRH1608d0ElDQuwd/kCAYxTUVO07QV0LbgYGYf+RNhNa5A
ARC-Seal: i=1; a=rsa-sha256; t=1526631445; cv=none;
        d=google.com; s=arc-20160816;
        b=BLNTPbMcinWoiuJC0V4+0SkkJpnWQXG32ZQ3WDaVLZIYEBLSuTlqx0oylEw74TUrBc
         sNEvcgL78lA4QNIUOmsCmYgCZbNj6JJgaZKbckUHoIRTiAUjFnwxz1JZQHUcrC2zwoTa
         gCLK2YKCjsLi8OTqYi4wccgjphqgOpC0CatwxmEmgz6PscytCkqnZ+oGCbQ7SFvvHIHo
         IVnSIE5NJ1RaKVWzU4Vb6ZZf/xV+euNoQ5Z8EN5xutpb+h/Sw/uFp+Zch2XmyPG8A/1V
         XBetTDFonun4n+K7iiCDskQLCqxdL9BtzYSb/JLUw2g3T4IkFDDt/GOGv6KHlIoPUlkw
         sKIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Hi9CWVo8ahDgCl83KFNK+7vDFeDI9JL16skVLL2ria0=;
        b=Lr/DCCNsNfd5mTS/gNtyi789cuSMr8OzmA0rECULuNI8ajh2+W+KxUsPjLVAeldoWa
         K0zV1lF0Zi8Gg2C/chSh1ZiBrJ/OtkhqBcYr2xWsYuL5sMSyrmSvFdj2DKe7aFrfBbCH
         +ASJqSuNfCCO9U2QpEr4K4JGyEIlsYCUnOEtW2+MAGicpi+BfJNn/N/iyrSRgepJ/QQR
         o80+5MbIAv581UKBAZvwGmEmS2XBls0QoAXGE2nA2u8GewNA9M+/+VmLA1ID7bmsj6ba
         GiBVFqnfvD+JoEA0fdPuZWuf2mPRpsFpUhvrisZZbBiDtdR/HgKgsf8klGatwMtpbmLF
         q+tA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=pyn+iZvU;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=pyn+iZvU;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 23/55] sctp: delay the authentication for the duplicated cookie-echo chunk
Date: Fri, 18 May 2018 10:15:19 +0200
Message-Id: <20180518081458.579107395@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789094206270984?=
X-GMAIL-MSGID: =?utf-8?q?1600789094206270984?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 59d8d4434f429b4fa8a346fd889058bda427a837 ]

Now sctp only delays the authentication for the normal cookie-echo
chunk by setting chunk->auth_chunk in sctp_endpoint_bh_rcv(). But
for the duplicated one with auth, in sctp_assoc_bh_rcv(), it does
authentication first based on the old asoc, which will definitely
fail due to the different auth info in the old asoc.

The duplicated cookie-echo chunk will create a new asoc with the
auth info from this chunk, and the authentication should also be
done with the new asoc's auth info for all of the collision 'A',
'B' and 'D'. Otherwise, the duplicated cookie-echo chunk with auth
will never pass the authentication and create the new connection.

This issue exists since very beginning, and this fix is to make
sctp_assoc_bh_rcv() follow the way sctp_endpoint_bh_rcv() does
for the normal cookie-echo chunk to delay the authentication.

While at it, remove the unused params from sctp_sf_authenticate()
and define sctp_auth_chunk_verify() used for all the places that
do the delayed authentication.

v1->v2:
  fix the typo in changelog as Marcelo noticed.

Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/associola.c    |   30 ++++++++++++++++
 net/sctp/sm_statefuns.c |   86 +++++++++++++++++++++++++-----------------------
 2 files changed, 75 insertions(+), 41 deletions(-)

--- a/net/sctp/associola.c
+++ b/net/sctp/associola.c
@@ -1024,8 +1024,9 @@ static void sctp_assoc_bh_rcv(struct wor
 	struct sctp_endpoint *ep;
 	struct sctp_chunk *chunk;
 	struct sctp_inq *inqueue;
-	int state;
+	int first_time = 1;	/* is this the first time through the loop */
 	int error = 0;
+	int state;
 
 	/* The association should be held so we should be safe. */
 	ep = asoc->ep;
@@ -1036,6 +1037,30 @@ static void sctp_assoc_bh_rcv(struct wor
 		state = asoc->state;
 		subtype = SCTP_ST_CHUNK(chunk->chunk_hdr->type);
 
+		/* If the first chunk in the packet is AUTH, do special
+		 * processing specified in Section 6.3 of SCTP-AUTH spec
+		 */
+		if (first_time && subtype.chunk == SCTP_CID_AUTH) {
+			struct sctp_chunkhdr *next_hdr;
+
+			next_hdr = sctp_inq_peek(inqueue);
+			if (!next_hdr)
+				goto normal;
+
+			/* If the next chunk is COOKIE-ECHO, skip the AUTH
+			 * chunk while saving a pointer to it so we can do
+			 * Authentication later (during cookie-echo
+			 * processing).
+			 */
+			if (next_hdr->type == SCTP_CID_COOKIE_ECHO) {
+				chunk->auth_chunk = skb_clone(chunk->skb,
+							      GFP_ATOMIC);
+				chunk->auth = 1;
+				continue;
+			}
+		}
+
+normal:
 		/* SCTP-AUTH, Section 6.3:
 		 *    The receiver has a list of chunk types which it expects
 		 *    to be received only after an AUTH-chunk.  This list has
@@ -1074,6 +1099,9 @@ static void sctp_assoc_bh_rcv(struct wor
 		/* If there is an error on chunk, discard this packet. */
 		if (error && chunk)
 			chunk->pdiscard = 1;
+
+		if (first_time)
+			first_time = 0;
 	}
 	sctp_association_put(asoc);
 }
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -153,10 +153,7 @@ static enum sctp_disposition sctp_sf_vio
 					struct sctp_cmd_seq *commands);
 
 static enum sctp_ierror sctp_sf_authenticate(
-					struct net *net,
-					const struct sctp_endpoint *ep,
 					const struct sctp_association *asoc,
-					const union sctp_subtype type,
 					struct sctp_chunk *chunk);
 
 static enum sctp_disposition __sctp_sf_do_9_1_abort(
@@ -621,6 +618,38 @@ enum sctp_disposition sctp_sf_do_5_1C_ac
 	return SCTP_DISPOSITION_CONSUME;
 }
 
+static bool sctp_auth_chunk_verify(struct net *net, struct sctp_chunk *chunk,
+				   const struct sctp_association *asoc)
+{
+	struct sctp_chunk auth;
+
+	if (!chunk->auth_chunk)
+		return true;
+
+	/* SCTP-AUTH:  auth_chunk pointer is only set when the cookie-echo
+	 * is supposed to be authenticated and we have to do delayed
+	 * authentication.  We've just recreated the association using
+	 * the information in the cookie and now it's much easier to
+	 * do the authentication.
+	 */
+
+	/* Make sure that we and the peer are AUTH capable */
+	if (!net->sctp.auth_enable || !asoc->peer.auth_capable)
+		return false;
+
+	/* set-up our fake chunk so that we can process it */
+	auth.skb = chunk->auth_chunk;
+	auth.asoc = chunk->asoc;
+	auth.sctp_hdr = chunk->sctp_hdr;
+	auth.chunk_hdr = (struct sctp_chunkhdr *)
+				skb_push(chunk->auth_chunk,
+					 sizeof(struct sctp_chunkhdr));
+	skb_pull(chunk->auth_chunk, sizeof(struct sctp_chunkhdr));
+	auth.transport = chunk->transport;
+
+	return sctp_sf_authenticate(asoc, &auth) == SCTP_IERROR_NO_ERROR;
+}
+
 /*
  * Respond to a normal COOKIE ECHO chunk.
  * We are the side that is being asked for an association.
@@ -758,37 +787,9 @@ enum sctp_disposition sctp_sf_do_5_1D_ce
 	if (error)
 		goto nomem_init;
 
-	/* SCTP-AUTH:  auth_chunk pointer is only set when the cookie-echo
-	 * is supposed to be authenticated and we have to do delayed
-	 * authentication.  We've just recreated the association using
-	 * the information in the cookie and now it's much easier to
-	 * do the authentication.
-	 */
-	if (chunk->auth_chunk) {
-		struct sctp_chunk auth;
-		enum sctp_ierror ret;
-
-		/* Make sure that we and the peer are AUTH capable */
-		if (!net->sctp.auth_enable || !new_asoc->peer.auth_capable) {
-			sctp_association_free(new_asoc);
-			return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
-		}
-
-		/* set-up our fake chunk so that we can process it */
-		auth.skb = chunk->auth_chunk;
-		auth.asoc = chunk->asoc;
-		auth.sctp_hdr = chunk->sctp_hdr;
-		auth.chunk_hdr = (struct sctp_chunkhdr *)
-					skb_push(chunk->auth_chunk,
-						 sizeof(struct sctp_chunkhdr));
-		skb_pull(chunk->auth_chunk, sizeof(struct sctp_chunkhdr));
-		auth.transport = chunk->transport;
-
-		ret = sctp_sf_authenticate(net, ep, new_asoc, type, &auth);
-		if (ret != SCTP_IERROR_NO_ERROR) {
-			sctp_association_free(new_asoc);
-			return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
-		}
+	if (!sctp_auth_chunk_verify(net, chunk, new_asoc)) {
+		sctp_association_free(new_asoc);
+		return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
 	}
 
 	repl = sctp_make_cookie_ack(new_asoc, chunk);
@@ -1758,13 +1759,15 @@ static enum sctp_disposition sctp_sf_do_
 			       GFP_ATOMIC))
 		goto nomem;
 
+	if (!sctp_auth_chunk_verify(net, chunk, new_asoc))
+		return SCTP_DISPOSITION_DISCARD;
+
 	/* Make sure no new addresses are being added during the
 	 * restart.  Though this is a pretty complicated attack
 	 * since you'd have to get inside the cookie.
 	 */
-	if (!sctp_sf_check_restart_addrs(new_asoc, asoc, chunk, commands)) {
+	if (!sctp_sf_check_restart_addrs(new_asoc, asoc, chunk, commands))
 		return SCTP_DISPOSITION_CONSUME;
-	}
 
 	/* If the endpoint is in the SHUTDOWN-ACK-SENT state and recognizes
 	 * the peer has restarted (Action A), it MUST NOT setup a new
@@ -1870,6 +1873,9 @@ static enum sctp_disposition sctp_sf_do_
 			       GFP_ATOMIC))
 		goto nomem;
 
+	if (!sctp_auth_chunk_verify(net, chunk, new_asoc))
+		return SCTP_DISPOSITION_DISCARD;
+
 	/* Update the content of current association.  */
 	sctp_add_cmd_sf(commands, SCTP_CMD_UPDATE_ASSOC, SCTP_ASOC(new_asoc));
 	sctp_add_cmd_sf(commands, SCTP_CMD_NEW_STATE,
@@ -1964,6 +1970,9 @@ static enum sctp_disposition sctp_sf_do_
 	 * a COOKIE ACK.
 	 */
 
+	if (!sctp_auth_chunk_verify(net, chunk, asoc))
+		return SCTP_DISPOSITION_DISCARD;
+
 	/* Don't accidentally move back into established state. */
 	if (asoc->state < SCTP_STATE_ESTABLISHED) {
 		sctp_add_cmd_sf(commands, SCTP_CMD_TIMER_STOP,
@@ -4108,10 +4117,7 @@ gen_shutdown:
  * The return value is the disposition of the chunk.
  */
 static enum sctp_ierror sctp_sf_authenticate(
-					struct net *net,
-					const struct sctp_endpoint *ep,
 					const struct sctp_association *asoc,
-					const union sctp_subtype type,
 					struct sctp_chunk *chunk)
 {
 	struct sctp_authhdr *auth_hdr;
@@ -4209,7 +4215,7 @@ enum sctp_disposition sctp_sf_eat_auth(s
 						  commands);
 
 	auth_hdr = (struct sctp_authhdr *)chunk->skb->data;
-	error = sctp_sf_authenticate(net, ep, asoc, type, chunk);
+	error = sctp_sf_authenticate(asoc, chunk);
 	switch (error) {
 	case SCTP_IERROR_AUTH_BAD_HMAC:
 		/* Generate the ERROR chunk and discard the rest
