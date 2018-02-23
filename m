Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519415933-2-12733164447635447975
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415933; b=uDuzL07UUrksChGbWhR/WBcy9fomjienv9D93Vkaqa5bMyR
    Wetzwu8MGG4LW7+2BMbV75jMg/XjrMM9v9p3Y8xwQqYs3pGf6CeKFmFHmj9sR+Qe
    TBBoGNakfRoQ2x78M6dbVTJexZgVTrILB0sAbr7FvrZXZrKI0cR5NG/USFUt9ivw
    7kb9FxTV9YBWnsIL+OJ4DkMoEWaeP/3LlrA44wvfvCb+60JSxn4afsfYWoSuDCSa
    MdZX05hSaL65R3IfJtqhx/ZtH7j+pT/ZvsJchU15HJlO5p2x8d6pWONrXPLDs8WV
    5EDjF5jW971mOS+wKQhMrv0VrTd+1bKpX9nrG8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415933; bh=ugjOhb944uM2i0SVgd+bjWFNyJ
    oJoE8N8VeDjaZuil4=; b=W+cv/Sv2OcKrvpygcON4wT/gAs1mi4kc64jYFA/yT/
    N2vID+ZJehXsjo1Mmtudb0e4V02o8hofd7Sctl93pA2Hbr9cUFDVlVMpQEdsU4Lr
    1HhwkLCCWGT1Qm39202bzaThRt1X3oTalZ2D/V4VBb4Qb24NipLXMtvjrl49uZZw
    UD1/k5emy62rhtpazc65ISHnmHQuehewRsTjp1mRlbC6xr1TEBA7nryoL/vyx15O
    8TfdgYg5yFx5mox4iIlSixNteseyX4Kqt6FNn25LikJtn+8bR0XJaVRKYLmBjbF2
    dgDGeC8tuHNQ0sQoNZ93pW22IKcC3sBqY1W4caAg6yAw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754993AbeBWT6h (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:58:37 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:42440 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933492AbeBWSoH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:44:07 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 009/145] sctp: set frag_point in sctp_setsockopt_maxseg correctly
Date: Fri, 23 Feb 2018 19:25:15 +0100
Message-Id: <20180223170725.939750944@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

commit ecca8f88da5c4260cc2bccfefd2a24976704c366 upstream.

Now in sctp_setsockopt_maxseg user_frag or frag_point can be set with
val >= 8 and val <= SCTP_MAX_CHUNK_LEN. But both checks are incorrect.

val >= 8 means frag_point can even be less than SCTP_DEFAULT_MINSEGMENT.
Then in sctp_datamsg_from_user(), when it's value is greater than cookie
echo len and trying to bundle with cookie echo chunk, the first_len will
overflow.

The worse case is when it's value is equal as cookie echo len, first_len
becomes 0, it will go into a dead loop for fragment later on. In Hangbin
syzkaller testing env, oom was even triggered due to consecutive memory
allocation in that loop.

Besides, SCTP_MAX_CHUNK_LEN is the max size of the whole chunk, it should
deduct the data header for frag_point or user_frag check.

This patch does a proper check with SCTP_DEFAULT_MINSEGMENT subtracting
the sctphdr and datahdr, SCTP_MAX_CHUNK_LEN subtracting datahdr when
setting frag_point via sockopt. It also improves sctp_setsockopt_maxseg
codes.

Suggested-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Reported-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/net/sctp/sctp.h |    3 ++-
 net/sctp/socket.c       |   29 +++++++++++++++++++----------
 2 files changed, 21 insertions(+), 11 deletions(-)

--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -433,7 +433,8 @@ static inline int sctp_frag_point(const
 	if (asoc->user_frag)
 		frag = min_t(int, frag, asoc->user_frag);
 
-	frag = SCTP_TRUNC4(min_t(int, frag, SCTP_MAX_CHUNK_LEN));
+	frag = SCTP_TRUNC4(min_t(int, frag, SCTP_MAX_CHUNK_LEN -
+					    sizeof(struct sctp_data_chunk)));
 
 	return frag;
 }
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -3125,9 +3125,9 @@ static int sctp_setsockopt_mappedv4(stru
  */
 static int sctp_setsockopt_maxseg(struct sock *sk, char __user *optval, unsigned int optlen)
 {
+	struct sctp_sock *sp = sctp_sk(sk);
 	struct sctp_assoc_value params;
 	struct sctp_association *asoc;
-	struct sctp_sock *sp = sctp_sk(sk);
 	int val;
 
 	if (optlen == sizeof(int)) {
@@ -3143,26 +3143,35 @@ static int sctp_setsockopt_maxseg(struct
 		if (copy_from_user(&params, optval, optlen))
 			return -EFAULT;
 		val = params.assoc_value;
-	} else
+	} else {
 		return -EINVAL;
+	}
 
-	if ((val != 0) && ((val < 8) || (val > SCTP_MAX_CHUNK_LEN)))
-		return -EINVAL;
+	if (val) {
+		int min_len, max_len;
 
-	asoc = sctp_id2assoc(sk, params.assoc_id);
-	if (!asoc && params.assoc_id && sctp_style(sk, UDP))
-		return -EINVAL;
+		min_len = SCTP_DEFAULT_MINSEGMENT - sp->pf->af->net_header_len;
+		min_len -= sizeof(struct sctphdr) +
+			   sizeof(struct sctp_data_chunk);
+
+		max_len = SCTP_MAX_CHUNK_LEN - sizeof(struct sctp_data_chunk);
 
+		if (val < min_len || val > max_len)
+			return -EINVAL;
+	}
+
+	asoc = sctp_id2assoc(sk, params.assoc_id);
 	if (asoc) {
 		if (val == 0) {
-			val = asoc->pathmtu;
-			val -= sp->pf->af->net_header_len;
+			val = asoc->pathmtu - sp->pf->af->net_header_len;
 			val -= sizeof(struct sctphdr) +
-					sizeof(struct sctp_data_chunk);
+			       sizeof(struct sctp_data_chunk);
 		}
 		asoc->user_frag = val;
 		asoc->frag_point = sctp_frag_point(asoc, asoc->pathmtu);
 	} else {
+		if (params.assoc_id && sctp_style(sk, UDP))
+			return -EINVAL;
 		sp->user_frag = val;
 	}
 
