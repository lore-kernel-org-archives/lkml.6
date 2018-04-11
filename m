Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/X5r4RYI3l+AA1t8rXQJZRWm+s812I7Wx+jISct0okkALKv1jl5EBRNLBkSXvSfbbbI9eA
ARC-Seal: i=1; a=rsa-sha256; t=1523472214; cv=none;
        d=google.com; s=arc-20160816;
        b=RQ5Kjw7an3E60yVxeqf1+deR/WA0Jpt7j9HLC7Ov0WCxrsW1ONYAspTqIR4KzL4Ukj
         dUBU3XHP2UpgdZVEKlLeU3r1jW3XgVQ80l2XFtCz+CxU7YPrplTkgPiXWvoQWc/MAMMc
         VFbXE/8jEnmQROsN1VprN9mbRYYbNaTS7PhIHntAMF4jUS0aO/oMQXfzJJhSVw0mKqCo
         OyC8pGBtmgRkUa8PbTF5z2+bhwy+TH+wR2K2XwdjXdYIYreHN0z8UcztKWmKN5kQ0rCc
         xyRVFrlZ5Ss123O1rODSC/Ct41tI+9bfRQ3TUPhtX+LbBIRXHnu5t/FB6BccCKhzyKDC
         yEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uPxv1ceMFaR6TDcj6NUmPN6S3wtNcy2Og1IgYV7jlKY=;
        b=wDvEQw1kpc7bymSQeuERG91jvxAwLVzqc4+ZWmWjAuV64PDti2lhysx0YyB7Yhsc+r
         rEceTA7RxbiPJknid2QSttaZCRWv/x4X1NFXfQGVbEbBZ0bisB/s++TqCf7piKyPFEeI
         CZMxGASfITJnKqDt3RcIyHDgs+gd7kQxJ+ArU+ohHcyUVxBdbnkPF161Q2PE+l7qynau
         658YIZ7hojJfTCAIbWZTOQ49PMW8ujVUZmOA4zfFRembQJhsbg39zJcvROY+kBiKH2WF
         3XlGBosMmyWCHUNmhHtDPUmrxxFtM7Cbtw6B+ql1de2C8Nunn/eBC1wcI0zzhSX/DgcI
         voew==
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
Subject: [PATCH 3.18 084/121] sparc64: ldc abort during vds iso boot
Date: Wed, 11 Apr 2018 20:36:27 +0200
Message-Id: <20180411183501.332689466@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476401088199108?=
X-GMAIL-MSGID: =?utf-8?q?1597476401088199108?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1693,9 +1693,14 @@ static int read_nonraw(struct ldc_channe
 
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
