Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+YtFqnuf2lXoRm9EuOBcVP5lYI21+76bAvgQVlSXDotzc/UyhDt7VBaJtXeaiwHBqOywB7
ARC-Seal: i=1; a=rsa-sha256; t=1523473414; cv=none;
        d=google.com; s=arc-20160816;
        b=OPBhUPUQxR2QyKJUp1+hFNtNY4udIe8iIPWkPhjLqH/MgIxeg7XOldghS5oEF0z9vO
         4jRX1sp+sAMB5aOop/1QZboK1ygOmlS9K+Aozh5aamHIPMVz9Rk+T5ReqdL5epNo+9fJ
         SfQJT9FoZcwIvH6GPWRU/5wOOQnVb4lpK12UHODxGhJ6Gu0v0pKRPO31LytW7hxwApIL
         2FEamcPiDq2xtNuUKpbs3+vQgrn4ki4anAeGLdK1W8SMqxQJSGnafHKtMpvrL0dfWwxe
         p/E3cpEcvyvIOy+8QVo0NRCumS+EL0QAYqisS3NW7adko7y8HioZXwneC5qEl+iJkBLP
         ihTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=alYglEAltJa407oohQwgGsJ9owcT3QPkOxb4qoWHRQc=;
        b=b689GV9ZA3LEXrrgvfA6Gdl5byDPr7GbNG8jti7/X/FdSHl02JjZMCgAbOLHp9hHpA
         U1ImAJni1n3RlKjjqNzfVQ92bKVXC78iwnLyw0QspJYDlte9Sd4FfsZehA7YE/mzDU+g
         HlHEoQOI6RfjaHRP8G6p6fLQmJZ3+sKEgkdtFok1wUTw+V9bULpfssCU5yas0lfOoryc
         J3Q75uz9XtV1/CQoDpmomha9TkHHzJbWQ46CS5Ay4esbIHF9vHGHMQP50NzpIsB/3miH
         1a5IgKqXPOtYQ9Tvg58iLu1fJmMkg02cKiROe4PoL0SUtygC2uWNkoyx41rEE51hbuF0
         0u8A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jagannathan Raman <jag.raman@oracle.com>,
	Aaron Young <aaron.young@oracle.com>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Bijan Mottahedeh <bijan.mottahedeh@oracle.com>,
	Liam Merwick <liam.merwick@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 239/310] sparc64: ldc abort during vds iso boot
Date: Wed, 11 Apr 2018 20:36:18 +0200
Message-Id: <20180411183632.768848978@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476401088199108?=
X-GMAIL-MSGID: =?utf-8?q?1597477659560681305?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jag Raman <jag.raman@oracle.com>


[ Upstream commit 6c95483b768c62f8ee933ae08a1bdbcb78b5410f ]

Orabug: 20902628

When an ldc control-only packet is received during data exchange in
read_nonraw(), a new rx head is calculated but the rx queue head is not
actually advanced (rx_set_head() is not called) and a branch is taken to
'no_data' at which point two things can happen depending on the value
of the newly calculated rx head and the current rx tail:

- If the rx queue is determined to be not empty, then the wrong packet
  is picked up.

- If the rx queue is determined to be empty, then a read error (EAGAIN)
  is eventually returned since it is falsely assumed that more data was
  expected.

The fix is to update the rx head and return in case of a control only
packet during data exchange.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Aaron Young <aaron.young@oracle.com>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Reviewed-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sparc/kernel/ldc.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -1733,9 +1733,14 @@ static int read_nonraw(struct ldc_channe
 
 		lp->rcv_nxt = p->seqid;
 
+		/*
+		 * If this is a control-only packet, there is nothing
+		 * else to do but advance the rx queue since the packet
+		 * was already processed above.
+		 */
 		if (!(p->type & LDC_DATA)) {
 			new = rx_advance(lp, new);
-			goto no_data;
+			break;
 		}
 		if (p->stype & (LDC_ACK | LDC_NACK)) {
 			err = data_ack_nack(lp, p);
