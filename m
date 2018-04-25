Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+uA/RB8t3taZtNip2aOdYlFSYLwpsO9J+sJjRIIcNSXbh7StB/nITHyrlM5Ulgnl26Bd2/
ARC-Seal: i=1; a=rsa-sha256; t=1524652668; cv=none;
        d=google.com; s=arc-20160816;
        b=aRGlzv4NtKpz6xI1/rCewUDfaqqzU2a/UbLruSJRGFuTofN8G39CBktyicaDCrqkpD
         NgZaZ8Q+uUXcgzXfJddzgoup43K2GtpDlmOOO71kbFd4e6J3QRdRbwI4xoCbTqFRgNbP
         dpFaZRRroJDPhmulIUrvju4Fay9BdVXtzSyaRLrcc8P/i03rj28Op9LYHJE5Xt4PQLrg
         doHTUyMTcVBBrpVtRakTzWlUxRqV7rgEPeI0OTvRlUzhefa2bP8DB9BCmnkYHnIjseyu
         5B0bpFn0NVmTuaCMJDdxlaMMbmWXlBzWyjwJzb5nn4ttmLHri8UoFHIxpFI3jarzsFMn
         SXTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZXOnOkuPAbAsbNAj5f9XueNVQhDdzeQ6GSzIW5HZH1Y=;
        b=0LAUPyIUrjQWRFKvv/MOluWbwhZB7hr2AYyCXTkAITTfXsEHa474LlASoCqDE3yITP
         gGuJoLKeMZsDdDSkv00mng6E6nxnttrmi6Xgxu8PPkT5JTmWkn97aUeI9BO43izr1A5Z
         u9yOrAFrRptPQcrwtpKtPhWjQ88Uc/b/1fUWDhCmrQmdJmjeI+w0rGNWROaDPBzViO2i
         rD1ECtagXnZ3q/Mnbr02BjIUI46Pp6TfYr89CiPB84w41asH6rHISyCptaFuIejQU5Qn
         w7FZ7OVx0qL6wWT9DJ0K4o3ObzJ0wGGxefDKTXgafSX2ZLCrrnasvozPCGvcxfvnX2lX
         ak0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 025/183] netfilter: ipv6: nf_defrag: Pass on packets to stack per RFC2460
Date: Wed, 25 Apr 2018 12:34:05 +0200
Message-Id: <20180425103243.611683060@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714196519182699?=
X-GMAIL-MSGID: =?utf-8?q?1598714196519182699?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>


[ Upstream commit 83f1999caeb14e15df205e80d210699951733287 ]

ipv6_defrag pulls network headers before fragment header. In case of
an error, the netfilter layer is currently dropping these packets.
This results in failure of some IPv6 standards tests which passed on
older kernels due to the netfilter framework using cloning.

The test case run here is a check for ICMPv6 error message replies
when some invalid IPv6 fragments are sent. This specific test case is
listed in https://www.ipv6ready.org/docs/Core_Conformance_Latest.pdf
in the Extension Header Processing Order section.

A packet with unrecognized option Type 11 is sent and the test expects
an ICMP error in line with RFC2460 section 4.2 -

11 - discard the packet and, only if the packet's Destination
     Address was not a multicast address, send an ICMP Parameter
     Problem, Code 2, message to the packet's Source Address,
     pointing to the unrecognized Option Type.

Since netfilter layer now drops all invalid IPv6 frag packets, we no
longer see the ICMP error message and fail the test case.

To fix this, save the transport header. If defrag is unable to process
the packet due to RFC2460, restore the transport header and allow packet
to be processed by stack. There is no change for other packet
processing paths.

Tested by confirming that stack sends an ICMP error when it receives
these packets. Also tested that fragmented ICMP pings succeed.

v1->v2: Instead of cloning always, save the transport_header and
restore it in case of this specific error. Update the title and
commit message accordingly.

Signed-off-by: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/netfilter/nf_conntrack_reasm.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -230,7 +230,7 @@ static int nf_ct_frag6_queue(struct frag
 
 	if ((unsigned int)end > IPV6_MAXPLEN) {
 		pr_debug("offset is too large.\n");
-		return -1;
+		return -EINVAL;
 	}
 
 	ecn = ip6_frag_ecn(ipv6_hdr(skb));
@@ -263,7 +263,7 @@ static int nf_ct_frag6_queue(struct frag
 			 * this case. -DaveM
 			 */
 			pr_debug("end of fragment not rounded to 8 bytes.\n");
-			return -1;
+			return -EPROTO;
 		}
 		if (end > fq->q.len) {
 			/* Some bits beyond end -> corruption. */
@@ -357,7 +357,7 @@ found:
 discard_fq:
 	inet_frag_kill(&fq->q, &nf_frags);
 err:
-	return -1;
+	return -EINVAL;
 }
 
 /*
@@ -566,6 +566,7 @@ find_prev_fhdr(struct sk_buff *skb, u8 *
 
 int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user)
 {
+	u16 savethdr = skb->transport_header;
 	struct net_device *dev = skb->dev;
 	int fhoff, nhoff, ret;
 	struct frag_hdr *fhdr;
@@ -599,8 +600,12 @@ int nf_ct_frag6_gather(struct net *net,
 
 	spin_lock_bh(&fq->q.lock);
 
-	if (nf_ct_frag6_queue(fq, skb, fhdr, nhoff) < 0) {
-		ret = -EINVAL;
+	ret = nf_ct_frag6_queue(fq, skb, fhdr, nhoff);
+	if (ret < 0) {
+		if (ret == -EPROTO) {
+			skb->transport_header = savethdr;
+			ret = 0;
+		}
 		goto out_unlock;
 	}
 
