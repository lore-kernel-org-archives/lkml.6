Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49qedCzKwJcHh5oAxtLtaDXizFFmtcxfewHbt1Oyv/uD6ZjJFrHmxZ4ETm7IpHH1J2HADYC
ARC-Seal: i=1; a=rsa-sha256; t=1523021474; cv=none;
        d=google.com; s=arc-20160816;
        b=AwC2fJr+KTN1uXJ+2KqXlbUlBnHqJQ43hOoKfxWPca1S7k2FQlc69rc0TX+cuNvXeY
         ahM6oaUXkiF/p+cqLswEXlGXRVikgDJVRpjJ15nQoPoRUcSBqa6yMvzTN0oxTpKKeX6T
         /Rb/j+ST1PKA0L4Lg4TkfWe4AFbu7PQnXFaQ3pFxydUTxgxwA2Tw+SNxcU/e4TNzpiB2
         099qUapBEBmHzwmSF7L8XFnnGD/WSKKhjJtmLKAD8VUjMZbQxM5EKlwF0bwY8eNrdvoo
         GiwQhGC9WcYEzYp7cdzz7O8R7BDRbTYiPUb7gssrvu9mcQcbBQoysnqlMsonuMFJEWYu
         pKnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vsqRfVTyGtfnVlOCOGLsb2vbLnKMM2NJaSlnOVRdSYI=;
        b=N5yPAS2X9KCqa3K+/BOjTMjfDLZbR7cFx3ueS4ar2JGU8AMmtOPgHyG/JJl71X+n4v
         aFc7Hdu1IGc8X260COgHIRgQ9lJ/MGu7QVEkjReLyfgnYMh4BLDjrEHGh+SmRqVKh6ah
         sCUDy+himeUYlG0VnfDsw5fO9lR8qKviwO5kxOZjfQdqrLMwrBa02M5D/lVRk6YsH5u3
         cu7b1BcvyAlnZOT0oEfDJ+jVQOXmc7CtCA0mCR7++HMRhe2Smf0XGwl2l1+Je4gMRbf9
         +SjJYlMboDcUjVqNk6AYOKmjEMSVHtFo79e2kBJo+3xmSbseSeorzT7zIj0kGJ+qQMf3
         Enfg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 17/72] netfilter: nf_nat_h323: fix logical-not-parentheses warning
Date: Fri,  6 Apr 2018 15:23:18 +0200
Message-Id: <20180406084306.503352037@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003766451728726?=
X-GMAIL-MSGID: =?utf-8?q?1597003766451728726?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nick Desaulniers <ndesaulniers@google.com>

commit eee6ebbac18a189ef33d25ea9b8bcae176515e49 upstream.

Clang produces the following warning:

net/ipv4/netfilter/nf_nat_h323.c:553:6: error:
logical not is only applied to the left hand side of this comparison
  [-Werror,-Wlogical-not-parentheses]
if (!set_h225_addr(skb, protoff, data, dataoff, taddr,
    ^
add parentheses after the '!' to evaluate the comparison first
add parentheses around left hand side expression to silence this warning

There's not necessarily a bug here, but it's cleaner to return early,
ex:

if (x)
  return
...

rather than:

if (x == 0)
  ...
else
  return

Also added a return code check that seemed to be missing in one
instance.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/netfilter/nf_nat_h323.c |   57 ++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

--- a/net/ipv4/netfilter/nf_nat_h323.c
+++ b/net/ipv4/netfilter/nf_nat_h323.c
@@ -252,16 +252,16 @@ static int nat_rtp_rtcp(struct sk_buff *
 	if (set_h245_addr(skb, protoff, data, dataoff, taddr,
 			  &ct->tuplehash[!dir].tuple.dst.u3,
 			  htons((port & htons(1)) ? nated_port + 1 :
-						    nated_port)) == 0) {
-		/* Save ports */
-		info->rtp_port[i][dir] = rtp_port;
-		info->rtp_port[i][!dir] = htons(nated_port);
-	} else {
+						    nated_port))) {
 		nf_ct_unexpect_related(rtp_exp);
 		nf_ct_unexpect_related(rtcp_exp);
 		return -1;
 	}
 
+	/* Save ports */
+	info->rtp_port[i][dir] = rtp_port;
+	info->rtp_port[i][!dir] = htons(nated_port);
+
 	/* Success */
 	pr_debug("nf_nat_h323: expect RTP %pI4:%hu->%pI4:%hu\n",
 		 &rtp_exp->tuple.src.u3.ip,
@@ -370,15 +370,15 @@ static int nat_h245(struct sk_buff *skb,
 	/* Modify signal */
 	if (set_h225_addr(skb, protoff, data, dataoff, taddr,
 			  &ct->tuplehash[!dir].tuple.dst.u3,
-			  htons(nated_port)) == 0) {
-		/* Save ports */
-		info->sig_port[dir] = port;
-		info->sig_port[!dir] = htons(nated_port);
-	} else {
+			  htons(nated_port))) {
 		nf_ct_unexpect_related(exp);
 		return -1;
 	}
 
+	/* Save ports */
+	info->sig_port[dir] = port;
+	info->sig_port[!dir] = htons(nated_port);
+
 	pr_debug("nf_nat_q931: expect H.245 %pI4:%hu->%pI4:%hu\n",
 		 &exp->tuple.src.u3.ip,
 		 ntohs(exp->tuple.src.u.tcp.port),
@@ -462,24 +462,27 @@ static int nat_q931(struct sk_buff *skb,
 	/* Modify signal */
 	if (set_h225_addr(skb, protoff, data, 0, &taddr[idx],
 			  &ct->tuplehash[!dir].tuple.dst.u3,
-			  htons(nated_port)) == 0) {
-		/* Save ports */
-		info->sig_port[dir] = port;
-		info->sig_port[!dir] = htons(nated_port);
-
-		/* Fix for Gnomemeeting */
-		if (idx > 0 &&
-		    get_h225_addr(ct, *data, &taddr[0], &addr, &port) &&
-		    (ntohl(addr.ip) & 0xff000000) == 0x7f000000) {
-			set_h225_addr(skb, protoff, data, 0, &taddr[0],
-				      &ct->tuplehash[!dir].tuple.dst.u3,
-				      info->sig_port[!dir]);
-		}
-	} else {
+			  htons(nated_port))) {
 		nf_ct_unexpect_related(exp);
 		return -1;
 	}
 
+	/* Save ports */
+	info->sig_port[dir] = port;
+	info->sig_port[!dir] = htons(nated_port);
+
+	/* Fix for Gnomemeeting */
+	if (idx > 0 &&
+	    get_h225_addr(ct, *data, &taddr[0], &addr, &port) &&
+	    (ntohl(addr.ip) & 0xff000000) == 0x7f000000) {
+		if (set_h225_addr(skb, protoff, data, 0, &taddr[0],
+				  &ct->tuplehash[!dir].tuple.dst.u3,
+				  info->sig_port[!dir])) {
+			nf_ct_unexpect_related(exp);
+			return -1;
+		}
+	}
+
 	/* Success */
 	pr_debug("nf_nat_ras: expect Q.931 %pI4:%hu->%pI4:%hu\n",
 		 &exp->tuple.src.u3.ip,
@@ -550,9 +553,9 @@ static int nat_callforwarding(struct sk_
 	}
 
 	/* Modify signal */
-	if (!set_h225_addr(skb, protoff, data, dataoff, taddr,
-			   &ct->tuplehash[!dir].tuple.dst.u3,
-			   htons(nated_port)) == 0) {
+	if (set_h225_addr(skb, protoff, data, dataoff, taddr,
+			  &ct->tuplehash[!dir].tuple.dst.u3,
+			  htons(nated_port))) {
 		nf_ct_unexpect_related(exp);
 		return -1;
 	}
