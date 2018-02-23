Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519414775-2-14390678672281430354
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519414775; b=Eu4MX1HaECnemWEs7t6xyqg2bHTZ2upVYk0bYTufLqu2LJp
    VmlSQaTczUtWl2WZGwe6WazR3uGNk4+LPEvqdppKaQHS5QsNq9mz8RCjhd9bgU3E
    SdXu33Qls+JIv3g9MZhd/e3V2W1kvLKxHt1+4UmlyofjChCH0gs+8ig27MgsWfl8
    hbaFjQDP9SX6Fx0saL9L/9KXbnQSNJgSTTwHBc+rCDXUCnWzu59he0DFMeTltsGB
    ZUIVUBuPrwPpshIKce+RwCFHAIQ904QpbikCJL0GLaK+LTP/S9BJuQONApVQPioJ
    VmSpkRTU9BB5n5nTqSr82/8qseM9CznG7DfU+9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414775; bh=dteXsPpF51qloexJ6WpxCE8xty
    Rp0PeLtF+1+7sOBn8=; b=DC296WLzEcrpWN8Bs/yA4pUTas7mxXtXXKyw9Y/0bC
    77x2utfQOZnLyfOEO4fbPMG7Hbvpj9rLo6dAWC3A444yD6+7YOpwJbkFlrbKkw0N
    /h2RmzQOHdAn12lgJFkH87AikBItJJpZO/AxLyR7s0bWj08A3FFE0S0ruZhpHWbV
    9deF1RtMN1kqY/x9WIcxsABBbsmVlDmB7FrcDWQ4CIvXaDoT9iiMN4V/jraSqfr2
    LQumkkQ9i8ayjbH1OGgv67Qvh09lhjNZqYvg4n070a7P97plQdIktGH2TEmD7Mi7
    6/se2PaOk2p2mpgn4uc4VL+ndOF1BmPs1TrvSi6JbTIQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934588AbeBWStq (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:49:46 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45414 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934578AbeBWStn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:49:43 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 017/159] sctp: set frag_point in sctp_setsockopt_maxseg correctly
Date: Fri, 23 Feb 2018 19:25:25 +0100
Message-Id: <20180223170745.310285813@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -444,7 +444,8 @@ static inline int sctp_frag_point(const
 	if (asoc->user_frag)
 		frag = min_t(int, frag, asoc->user_frag);
 
-	frag = SCTP_TRUNC4(min_t(int, frag, SCTP_MAX_CHUNK_LEN));
+	frag = SCTP_TRUNC4(min_t(int, frag, SCTP_MAX_CHUNK_LEN -
+					    sizeof(struct sctp_data_chunk)));
 
 	return frag;
 }
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -3136,9 +3136,9 @@ static int sctp_setsockopt_mappedv4(stru
  */
 static int sctp_setsockopt_maxseg(struct sock *sk, char __user *optval, unsigned int optlen)
 {
+	struct sctp_sock *sp = sctp_sk(sk);
 	struct sctp_assoc_value params;
 	struct sctp_association *asoc;
-	struct sctp_sock *sp = sctp_sk(sk);
 	int val;
 
 	if (optlen == sizeof(int)) {
@@ -3154,26 +3154,35 @@ static int sctp_setsockopt_maxseg(struct
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
 
