Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48L+sOeSAeyN0U5JWCNkrwTqm6Pgtssc8u6/F+91SQ2f5AhjUC9cEKRe72fG9LI8LXYAKQx
ARC-Seal: i=1; a=rsa-sha256; t=1523473141; cv=none;
        d=google.com; s=arc-20160816;
        b=BcIRmNenJHfWnnOlJjky7W20FYjUd/9lKdTlJLU44s1cppaHjxYQlmLxKo8KnRZ0Oh
         0wX0l15xj5qifjb/7cQuKClTqGaelRt7iOzJizma4LedLy0We/qCp+ByKFSIwcZ+F8bK
         cRvJFpCm9FvW1FgSjwjFffhGDZt3hDaJMugzlnc1AyW6hj+by2OvseF1YzDbX+WNslpv
         CUQaOIhHzfcUh3XE2XI+sQoAHt1O6qpxKYvglvT/9QBEdbn2JXS2SJIaCkkSpzg1BK+F
         IMwy8L19lF1Lii8qnLBRMMa5JIHDeDRatkPOXm/5hhSFONdAS5BlJyPzFDyDrGv4pFmU
         57xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KKYhjfEEp3Y+WkyTyC7GvSXlsBBkb/owsYfOP71+Xdo=;
        b=kBu/Nir56bZ4S+hvoocknewPEUG0WXyFyYn1yzyuUpQ/8ojE0ULJmDE3I2H9sjqg+s
         n2kmkc2+d61vhUu2pFlld1i6WiXCPZfmCufPnFLUx+y8PiyxSY4+LIy/nPrey+iKvlVV
         ZuhxxZcCsUI5wAurdR54NJ7v3YjEdtUSlrhHLIveCHPkWlfM3316n5QRwaUbYjXDhdG4
         uoqjioLf7keHP+06E4oSP8KPtJjtAqb4e6zX9AXLvn+AUlbdbEBOjawuVlok74wwYoID
         L0n00/h+qqIx/i7VQAL0viSk34Iosls+08n3/kTRmm3IXufI9qC3nqVjjFxH7Hw3fC1J
         Lauw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paul Fiterau Brostean <p.fiterau-brostean@science.ru.nl>,
	Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 109/310] tcp: better validation of received ack sequences
Date: Wed, 11 Apr 2018 20:34:08 +0200
Message-Id: <20180411183626.889595034@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476597617030278?=
X-GMAIL-MSGID: =?utf-8?q?1597477372352645517?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit d0e1a1b5a833b625c93d3d49847609350ebd79db ]

Paul Fiterau Brostean reported :

<quote>
Linux TCP stack we analyze exhibits behavior that seems odd to me.
The scenario is as follows (all packets have empty payloads, no window
scaling, rcv/snd window size should not be a factor):

       TEST HARNESS (CLIENT)                        LINUX SERVER

   1.  -                                          LISTEN (server listen,
then accepts)

   2.  - --> <SEQ=100><CTL=SYN>               --> SYN-RECEIVED

   3.  - <-- <SEQ=300><ACK=101><CTL=SYN,ACK>  <-- SYN-RECEIVED

   4.  - --> <SEQ=101><ACK=301><CTL=ACK>      --> ESTABLISHED

   5.  - <-- <SEQ=301><ACK=101><CTL=FIN,ACK>  <-- FIN WAIT-1 (server
opts to close the data connection calling "close" on the connection
socket)

   6.  - --> <SEQ=101><ACK=99999><CTL=FIN,ACK> --> CLOSING (client sends
FIN,ACK with not yet sent acknowledgement number)

   7.  - <-- <SEQ=302><ACK=102><CTL=ACK>      <-- CLOSING (ACK is 102
instead of 101, why?)

... (silence from CLIENT)

   8.  - <-- <SEQ=301><ACK=102><CTL=FIN,ACK>  <-- CLOSING
(retransmission, again ACK is 102)

Now, note that packet 6 while having the expected sequence number,
acknowledges something that wasn't sent by the server. So I would
expect
the packet to maybe prompt an ACK response from the server, and then be
ignored. Yet it is not ignored and actually leads to an increase of the
acknowledgement number in the server's retransmission of the FIN,ACK
packet. The explanation I found is that the FIN  in packet 6 was
processed, despite the acknowledgement number being unacceptable.
Further experiments indeed show that the server processes this FIN,
transitioning to CLOSING, then on receiving an ACK for the FIN it had
send in packet 5, the server (or better said connection) transitions
from CLOSING to TIME_WAIT (as signaled by netstat).

</quote>

Indeed, tcp_rcv_state_process() calls tcp_ack() but
does not exploit the @acceptable status but for TCP_SYN_RECV
state.

What we want here is to send a challenge ACK, if not in TCP_SYN_RECV
state. TCP_FIN_WAIT1 state is not the only state we should fix.

Add a FLAG_NO_CHALLENGE_ACK so that tcp_rcv_state_process()
can choose to send a challenge ACK and discard the packet instead
of wrongly change socket state.

With help from Neal Cardwell.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Paul Fiterau Brostean <p.fiterau-brostean@science.ru.nl>
Cc: Neal Cardwell <ncardwell@google.com>
Cc: Yuchung Cheng <ycheng@google.com>
Cc: Soheil Hassas Yeganeh <soheil@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c |   24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -115,6 +115,7 @@ int sysctl_tcp_invalid_ratelimit __read_
 #define FLAG_DSACKING_ACK	0x800 /* SACK blocks contained D-SACK info */
 #define FLAG_SACK_RENEGING	0x2000 /* snd_una advanced to a sacked seq */
 #define FLAG_UPDATE_TS_RECENT	0x4000 /* tcp_replace_ts_recent() */
+#define FLAG_NO_CHALLENGE_ACK	0x8000 /* do not call tcp_send_challenge_ack()	*/
 
 #define FLAG_ACKED		(FLAG_DATA_ACKED|FLAG_SYN_ACKED)
 #define FLAG_NOT_DUP		(FLAG_DATA|FLAG_WIN_UPDATE|FLAG_ACKED)
@@ -3618,7 +3619,8 @@ static int tcp_ack(struct sock *sk, cons
 	if (before(ack, prior_snd_una)) {
 		/* RFC 5961 5.2 [Blind Data Injection Attack].[Mitigation] */
 		if (before(ack, prior_snd_una - tp->max_window)) {
-			tcp_send_challenge_ack(sk, skb);
+			if (!(flag & FLAG_NO_CHALLENGE_ACK))
+				tcp_send_challenge_ack(sk, skb);
 			return -1;
 		}
 		goto old_ack;
@@ -5969,13 +5971,17 @@ int tcp_rcv_state_process(struct sock *s
 
 	/* step 5: check the ACK field */
 	acceptable = tcp_ack(sk, skb, FLAG_SLOWPATH |
-				      FLAG_UPDATE_TS_RECENT) > 0;
+				      FLAG_UPDATE_TS_RECENT |
+				      FLAG_NO_CHALLENGE_ACK) > 0;
 
+	if (!acceptable) {
+		if (sk->sk_state == TCP_SYN_RECV)
+			return 1;	/* send one RST */
+		tcp_send_challenge_ack(sk, skb);
+		goto discard;
+	}
 	switch (sk->sk_state) {
 	case TCP_SYN_RECV:
-		if (!acceptable)
-			return 1;
-
 		if (!tp->srtt_us)
 			tcp_synack_rtt_meas(sk, req);
 
@@ -6045,14 +6051,6 @@ int tcp_rcv_state_process(struct sock *s
 		 * our SYNACK so stop the SYNACK timer.
 		 */
 		if (req) {
-			/* Return RST if ack_seq is invalid.
-			 * Note that RFC793 only says to generate a
-			 * DUPACK for it but for TCP Fast Open it seems
-			 * better to treat this case like TCP_SYN_RECV
-			 * above.
-			 */
-			if (!acceptable)
-				return 1;
 			/* We no longer need the request sock. */
 			reqsk_fastopen_remove(sk, req, false);
 			tcp_rearm_rto(sk);
