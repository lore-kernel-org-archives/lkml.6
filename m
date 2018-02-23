Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226yyPTxDwITb4vMZpIo+wb9LdmiViDcsAhqFAMfX0HDl78jp0EosL45LDupobu0CoOubI3p
ARC-Seal: i=1; a=rsa-sha256; t=1519412125; cv=none;
        d=google.com; s=arc-20160816;
        b=E1a33KmtzQW1UK0w1vQ1K2vm4bAqnmgCU3k8905tC2WkUp8FhPMh2RCl0EKamEWLc+
         l3i1X8DGaBkTk1QZ53H8uooExkpXNYnNO6DDWSaf/aWgbVw2iVjaGuY6PmobW55qlSSP
         hO6SHVbno9BTcLgcrh+npnFbAav0ncYdNyRM7wanjmjvpx30cKHFABOMhe87olbf3K3V
         pqNZ+tR1tbn9LAwVuTutXcSfdHmiDKUPA5WjhrmzUVY//EKFPfqyHHNqQKvuUwAW5z/I
         Z084wjxBcDwfKFMB8WcgXvcfurrHm8OJS0Py10ck6Zslfps7tCt2sl2BvwCHuFuwlfTH
         zpEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oHceiN7rB29N2wNG1d4+uAMO/oCzeQFn1qOfgyI4vwU=;
        b=0LrSVquNEEhVm88IlxMQ7Ecmo+7noWrA0yQyG60LDpMwQgrb94tRdfauN2QNfkwTCW
         AQsE4hAk0maRKOXpv5FHlw3OvfOItfi3oBTbL6BnGC/Gio2csp5dibX0/VR0o5U1l4WF
         wz5wqGOa0sWUy8BVSTt1NPMTVv6sFC0Y9bBfB+QdbgQZ2bBHS4q1bHYEiiJOXUmnhuhA
         Uxl9CxAMotF9CpI2F5avM410LAMzS21i4Va4rbCR8Lp7gPgT8SOXw0tr0WaHnaRPAA5c
         XW8WvPm62/c41NMnwpc/NmDtgYJQJduIiJP/UPXx5NMzuI1Jg/CGUGgZBsRdoIHZacY9
         oYVA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Aviv Heller <avivh@mellanox.com>,
	Yevgeny Kliteynik <kliteyn@mellanox.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 133/159] xfrm: Fix xfrm_input() to verify state is valid when (encap_type < 0)
Date: Fri, 23 Feb 2018 19:27:21 +0100
Message-Id: <20180223170759.188697997@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219088067808189?=
X-GMAIL-MSGID: =?utf-8?q?1593219088067808189?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aviv Heller <avivh@mellanox.com>


[ Upstream commit 4ce3dbe397d7b6b15f272ae757c78c35e9e4b61d ]

Code path when (encap_type < 0) does not verify the state is valid
before progressing.

This will result in a crash if, for instance, x->km.state ==
XFRM_STATE_ACQ.

Fixes: 7785bba299a8 ("esp: Add a software GRO codepath")
Signed-off-by: Aviv Heller <avivh@mellanox.com>
Signed-off-by: Yevgeny Kliteynik <kliteyn@mellanox.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/xfrm/xfrm_input.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -207,7 +207,7 @@ int xfrm_input(struct sk_buff *skb, int
 	xfrm_address_t *daddr;
 	struct xfrm_mode *inner_mode;
 	u32 mark = skb->mark;
-	unsigned int family;
+	unsigned int family = AF_UNSPEC;
 	int decaps = 0;
 	int async = 0;
 	bool xfrm_gro = false;
@@ -216,6 +216,16 @@ int xfrm_input(struct sk_buff *skb, int
 
 	if (encap_type < 0) {
 		x = xfrm_input_state(skb);
+
+		if (unlikely(x->km.state != XFRM_STATE_VALID)) {
+			if (x->km.state == XFRM_STATE_ACQ)
+				XFRM_INC_STATS(net, LINUX_MIB_XFRMACQUIREERROR);
+			else
+				XFRM_INC_STATS(net,
+					       LINUX_MIB_XFRMINSTATEINVALID);
+			goto drop;
+		}
+
 		family = x->outer_mode->afinfo->family;
 
 		/* An encap_type of -1 indicates async resumption. */
