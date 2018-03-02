Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvOv/LlRuMofkMmWx30wcWhDRKH3VzXSreFu9g9Z+2X0IOfSRDYdOq+lMZQpRU3hrSa2CnY
ARC-Seal: i=1; a=rsa-sha256; t=1519981182; cv=none;
        d=google.com; s=arc-20160816;
        b=kssGIcvOLG/qyQVBM9g6FrvYpDxq/tT6oyDZ51QfRcOJpiaSWwHwQBLoW3CxPs/NC5
         rdCJYS1unpY2kCtOhnSCcTuBO7eqwrOADUAkHPsUr7K6lyKDmOKxq7aLjyBzF+tWHGXY
         CgUbxbCnRXzQz27eVddlJJHTxQyITy1Z9t7QLf1TiNFTqJrRwYjefCOxRBgy6hVWh0FR
         zJC+oGrT/nSKD09BpUNNXN4J10xULeJkzAfpWjnug3qmj41cjc5zO0rZ+o7d8/3H0+nt
         lY5qCtjy8fRu4HZLYI/KeMLJyzgIliZ0XCv5Q+LbqO03AmGMtWrQUmAPMS7lpPDgIz3c
         uIDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+F0eZHxX1YNGP+5Rf3n2IfDIvaCzs/OYPgjpmXpkwRQ=;
        b=TaCxYwMf6nzUM3sa8oTOSq5trm9Y05k+Ic2WK8a3FmgZ9l7YYhlp9RHwuFdS68yYOx
         SYMvqzD0d72gcjwDrm4uG1ezk0h5tAC4kFE6upljZbxVx5Ajg8vRleX4HDinLtxofH3O
         N+kGRJTNmXgNQZsE7Srp/JF7Fhdue7hNCpinO3y5PLRgkgJcnejl5rQwd0vZK0pDjCMx
         JKauChEfJba2Mt67x6PksrFLjAONf9LMJJ/1cO7OmBrjzh03xBKCQdagHJi9QB0Gw0Lk
         dGdPfgotkjrZhRoR3bYphbTQXM1XbTaLiLXO8x1F3RgeIVawbfjAMsyUo7cd2zbfO7Rw
         4sYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 018/115] sctp: fix the issue that a __u16 variable may overflow in sctp_ulpq_renege
Date: Fri,  2 Mar 2018 09:50:21 +0100
Message-Id: <20180302084504.604877649@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815788754560277?=
X-GMAIL-MSGID: =?utf-8?q?1593815788754560277?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>


[ Upstream commit 5c468674d17056148da06218d4da5d04baf22eac ]

Now when reneging events in sctp_ulpq_renege(), the variable freed
could be increased by a __u16 value twice while freed is of __u16
type. It means freed may overflow at the second addition.

This patch is to fix it by using __u32 type for 'freed', while at
it, also to remove 'if (chunk)' check, as all renege commands are
generated in sctp_eat_data and it can't be NULL.

Reported-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/ulpqueue.c |   24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

--- a/net/sctp/ulpqueue.c
+++ b/net/sctp/ulpqueue.c
@@ -1084,29 +1084,21 @@ void sctp_ulpq_partial_delivery(struct s
 void sctp_ulpq_renege(struct sctp_ulpq *ulpq, struct sctp_chunk *chunk,
 		      gfp_t gfp)
 {
-	struct sctp_association *asoc;
-	__u16 needed, freed;
+	struct sctp_association *asoc = ulpq->asoc;
+	__u32 freed = 0;
+	__u16 needed;
 
-	asoc = ulpq->asoc;
-
-	if (chunk) {
-		needed = ntohs(chunk->chunk_hdr->length);
-		needed -= sizeof(struct sctp_data_chunk);
-	} else
-		needed = SCTP_DEFAULT_MAXWINDOW;
-
-	freed = 0;
+	needed = ntohs(chunk->chunk_hdr->length) -
+		 sizeof(struct sctp_data_chunk);
 
 	if (skb_queue_empty(&asoc->base.sk->sk_receive_queue)) {
 		freed = sctp_ulpq_renege_order(ulpq, needed);
-		if (freed < needed) {
+		if (freed < needed)
 			freed += sctp_ulpq_renege_frags(ulpq, needed - freed);
-		}
 	}
 	/* If able to free enough room, accept this chunk. */
-	if (chunk && (freed >= needed)) {
-		int retval;
-		retval = sctp_ulpq_tail_data(ulpq, chunk, gfp);
+	if (freed >= needed) {
+		int retval = sctp_ulpq_tail_data(ulpq, chunk, gfp);
 		/*
 		 * Enter partial delivery if chunk has not been
 		 * delivered; otherwise, drain the reassembly queue.
