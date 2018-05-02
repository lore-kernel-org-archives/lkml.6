Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751708AbeEBWNH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 18:13:07 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:33186 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751566AbeEBWNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 18:13:01 -0400
X-Google-Smtp-Source: AB8JxZrLSXz5Ymvh+xJYIyoIAbmZgxOWmy9r23AKgYc07kywAyX7FqUtEimlbOf1Pnb1wuZSBD7SGg==
From: Wenwen Wang <wang6495@umn.edu>
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-sctp@vger.kernel.org (open list:SCTP PROTOCOL),
        netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] sctp: fix a potential missing-check bug
Date: Wed,  2 May 2018 17:12:45 -0500
Message-Id: <1525299165-27098-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In sctp_setsockopt_maxseg(), the integer 'val' is compared against min_len
and max_len to check whether it is in the appropriate range. If it is not,
an error code -EINVAL will be returned. This is enforced by a security
check. But, this check is only executed when 'val' is not 0. In fact, if
'val' is 0, it will be assigned with a new value (if the return value of
the function sctp_id2assoc() is not 0) in the following execution. However,
this new value of 'val' is not checked before it is used to assigned to
asoc->user_frag. That means it is possible that the new value of 'val'
could be out of the expected range. This can cause security issues
such as buffer overflows, e.g., the new value of 'val' is used as an index
to access a buffer.

This patch inserts a check for the new value of 'val' to see if it is in
the expected range. If it is not, an error code -EINVAL will be returned.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 net/sctp/socket.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 80835ac..2beb601 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -3212,6 +3212,7 @@ static int sctp_setsockopt_maxseg(struct sock *sk, char __user *optval, unsigned
 	struct sctp_af *af = sp->pf->af;
 	struct sctp_assoc_value params;
 	struct sctp_association *asoc;
+	int min_len, max_len;
 	int val;
 
 	if (optlen == sizeof(int)) {
@@ -3231,19 +3232,15 @@ static int sctp_setsockopt_maxseg(struct sock *sk, char __user *optval, unsigned
 		return -EINVAL;
 	}
 
-	if (val) {
-		int min_len, max_len;
+	min_len = SCTP_DEFAULT_MINSEGMENT - af->net_header_len;
+	min_len -= af->ip_options_len(sk);
+	min_len -= sizeof(struct sctphdr) +
+		   sizeof(struct sctp_data_chunk);
 
-		min_len = SCTP_DEFAULT_MINSEGMENT - af->net_header_len;
-		min_len -= af->ip_options_len(sk);
-		min_len -= sizeof(struct sctphdr) +
-			   sizeof(struct sctp_data_chunk);
+	max_len = SCTP_MAX_CHUNK_LEN - sizeof(struct sctp_data_chunk);
 
-		max_len = SCTP_MAX_CHUNK_LEN - sizeof(struct sctp_data_chunk);
-
-		if (val < min_len || val > max_len)
-			return -EINVAL;
-	}
+	if (val && (val < min_len || val > max_len))
+		return -EINVAL;
 
 	asoc = sctp_id2assoc(sk, params.assoc_id);
 	if (asoc) {
@@ -3253,6 +3250,8 @@ static int sctp_setsockopt_maxseg(struct sock *sk, char __user *optval, unsigned
 			val -= sizeof(struct sctphdr) +
 			       sctp_datachk_len(&asoc->stream);
 		}
+		if (val < min_len || val > max_len)
+			return -EINVAL;
 		asoc->user_frag = val;
 		asoc->frag_point = sctp_frag_point(asoc, asoc->pathmtu);
 	} else {
-- 
2.7.4
