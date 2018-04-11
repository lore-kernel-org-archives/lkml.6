Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+rInw0DoSGGjUDGfsgbBOlzy+3vDrYEKiFb8QyBqOZ56S9BpKUKqqqmntzdgwkmnSemG3Z
ARC-Seal: i=1; a=rsa-sha256; t=1523472691; cv=none;
        d=google.com; s=arc-20160816;
        b=kRqhiJKgY85jqzoTv0mLpxCD6FseSOhALJOtwVQlS7WV8aSrHRLN+aHg0PkkvuaEKC
         5GI+ZrPnf4WNFvfPCSGZNcXGeGqNQY6vX1RuCpI3EY7hiU1Wu4zYI4BJmS+muZ8mIcJm
         bsowRYd3WtmAE6Uq8TtDZI+12MCm1mLNcentR8PiTwepJhRNMugjNAJihBT/oG09Sr3l
         hOJDg389k7VPgBfcH8KLLE3PmonSqgapw2Whkax3mrVUCPspL6k8rYCKVDXFbHivWgsV
         MZjM3tEbRNuqa49ODLXqUEeE6avNyBBeHfU0se7jqWkwciochJD5VSOfqbhAuGVAkcC3
         Mp8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CQqi1xQROkROuBK2r+KjSIVCI47TFsJwOtFWnPJUb6Q=;
        b=eJ4aH/p6KpIuP8igLQNdNx8WXCb/H0/89ZulpG4Ge3x3nbNrDr/FD9GlwJySpbpcBS
         GkcS9ohQVGulsGRuzlLpKxrfPOMKuq3RODDRko+bCKzC3ZLgbBiFerNLTs57dcLUm/3y
         GgOSZdEGWw33Jjxlel10SkWTZsUznInRYuIiuMQpVIH+G3NUJrVC1JCUq7+p9ywPybr/
         vTEbH7JG5IeJE/ZT5WCjmOo5wRm3Wk5l8LSEIynZkhIiWkJP9Bs7bMlwFbMUxnQu14YC
         gTvOopvuseTA5aJJt22UjGTXLXmpit0MuYGMozhqHuF8nmXAl2NHJx1islxLbwORRZph
         Mlag==
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
Subject: [PATCH 4.4 141/190] sparc64: ldc abort during vds iso boot
Date: Wed, 11 Apr 2018 20:36:27 +0200
Message-Id: <20180411183600.871074219@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476401088199108?=
X-GMAIL-MSGID: =?utf-8?q?1597476900968832386?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
