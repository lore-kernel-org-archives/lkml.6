Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AB8JxZrmdASJ6828DvYxVfp59j9glYtqprQeo4mQIPp7Lf/Tkk4l1+vNm/0+haLDuo5sr7B/+Xq3
ARC-Seal: i=1; a=rsa-sha256; t=1524652942; cv=none;
        d=google.com; s=arc-20160816;
        b=hkDhylI4S6AA6PezeiIPblIBK4ZGHHTGZOdm/31mr0dw61v8kVvWm3ubjn0BakqHJq
         EzQjPbFfzdbQd1NME+tP81zN4Rnpz70WT3Wt1QKkG8qUsfC6HtevE3LtrKe2ShnXnK3W
         aEgeHsQFIRm5VVGgnCX5NkMAKcBjiG09kOKgnBgeiGgaNZyLTgMQGvsgjsg4kJ/ovgqT
         KRLeR3QU6025moVAYHf4mVgotFYTvxhUDZx87EaKZTddYC6whoS7WRgjdE2GbkQFC4GL
         ex+p/lqERspyroPW46vxIRs+y4jE7/x7kUXIasX9QiGykOuFG9VKuk9HarImJoZK0Up1
         ELZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YsGpDzDyiiLzA5hoVU8xZGetloa5OqYXJQdQYfVe4uk=;
        b=dR41sGSud62VWgrdIROBsrntHWu2YYXpju7kmVijPi0wPPR3ynP48/N/XUyB7oS1wd
         BdQHc6cbd187pRJZpuMRETuKP8DFiYdcufjJHxfcCKzfI48pT5DeZFFRp9vnttcl1bsw
         FBRn2tCA/1kcaHHK0oibs3B+SICe1APHfVMbkAXqihFUEGb/jQ7+fDj0L9Pa1R/11p94
         pSmrhWTFCbfBUDpolbXMDYaK8GSDi+TOavEh0ZeAXyGfJm8VL2G/xjeqxxUtgR7kKT04
         Pd9NHU+QAVSrSFg80onVbobMAHQibOZ9v2dQOBeWns+IzCwXWzzJhZKl7e+dyOGK4WPi
         gBCQ==
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
Subject: [PATCH 4.14 126/183] netfilter: ipv6: nf_defrag: Kill frag queue on RFC2460 failure
Date: Wed, 25 Apr 2018 12:35:46 +0200
Message-Id: <20180425103247.494874862@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714484305945008?=
X-GMAIL-MSGID: =?utf-8?q?1598714484305945008?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>


[ Upstream commit ea23d5e3bf340e413b8e05c13da233c99c64142b ]

Failures were seen in ICMPv6 fragmentation timeout tests if they were
run after the RFC2460 failure tests. Kernel was not sending out the
ICMPv6 fragment reassembly time exceeded packet after the fragmentation
reassembly timeout of 1 minute had elapsed.

This happened because the frag queue was not released if an error in
IPv6 fragmentation header was detected by RFC2460.

Fixes: 83f1999caeb1 ("netfilter: ipv6: nf_defrag: Pass on packets to stack per RFC2460")
Signed-off-by: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/netfilter/nf_conntrack_reasm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -263,6 +263,7 @@ static int nf_ct_frag6_queue(struct frag
 			 * this case. -DaveM
 			 */
 			pr_debug("end of fragment not rounded to 8 bytes.\n");
+			inet_frag_kill(&fq->q, &nf_frags);
 			return -EPROTO;
 		}
 		if (end > fq->q.len) {
