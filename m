Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqccV8GatrQI8bhattcrrIjjQ2XaiXUJLt8jyKmLHH3OJZ8bChI8uBg+MkMhJmroSfsvMkf
ARC-Seal: i=1; a=rsa-sha256; t=1526631568; cv=none;
        d=google.com; s=arc-20160816;
        b=1Gi34cegd8f1ko6RXV2lXBKdnQzSuJWmFayB9GAgvnplZKAxjMMo2CrnWOe7150+wf
         HTXtZg/EJOKq6PnGY3LekX92nYkVEAmBPvRpsDjvgGA5LANM0cBW6j86IqMkGXAvYhcS
         EUOe5R4hAtjOJJtd53aVW7IprxopBsrv5GBoG7xvzDFI84OwW7xFILs05Y85uBvvZvjR
         74LYQnmH3lReUoYkht3CwqzPTvrSv6/502pNyeJWd9VjxShJWfMHcorTruXKcp+TdA2l
         JpTjC5nsjsRsWelLVqAIYkZaVe10Tiep045l998zglctOHrTX4EpOnjcsVVAOmEr967P
         Q19g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=7ejGrVfRSDYlHWRbqGXddUXBAMj8leeqT9O76JvW/Yw=;
        b=EYjrN2e3bRfchdUEywu28eUo1nU/Kl3YsdZUxLljjRA1U2worItfvrl3Kn7/gsA3no
         IEM9tybs4qx9THe+hRaa3Dbvzqk9cs8eMTvEY7IR+RzcJZsOaIezObv7k0cR0iz4Km2x
         Og0rYmUicjeApd6Iq19N0ol7Z8r7TylOJ98rBFr2PdP6FfazmOCD0UjVBmV6Ofmg0Xxa
         IX6qkNabvbM+CvHyd+gi5tTSmpryIqaglMvW+2U/dpKKlmlltH5NpCOrfS5mvo5Ffcko
         tDU+yweCtSwfbe6n4/DkcdodxQZZeP6R/ne6vHOx/Bxli7YheRjjII9gpgn8zn5WOfXP
         eHwA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=HTQSkRuq;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=HTQSkRuq;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Roman Mashak <mrv@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 13/45] net sched actions: fix refcnt leak in skbmod
Date: Fri, 18 May 2018 10:15:30 +0200
Message-Id: <20180518081530.998937972@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789193125725958?=
X-GMAIL-MSGID: =?utf-8?q?1600789223777255599?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roman Mashak <mrv@mojatatu.com>

[ Upstream commit a52956dfc503f8cc5cfe6454959b7049fddb4413 ]

When application fails to pass flags in netlink TLV when replacing
existing skbmod action, the kernel will leak refcnt:

$ tc actions get action skbmod index 1
total acts 0

        action order 0: skbmod pipe set smac 00:11:22:33:44:55
         index 1 ref 1 bind 0

For example, at this point a buggy application replaces the action with
index 1 with new smac 00:aa:22:33:44:55, it fails because of zero flags,
however refcnt gets bumped:

$ tc actions get actions skbmod index 1
total acts 0

        action order 0: skbmod pipe set smac 00:11:22:33:44:55
         index 1 ref 2 bind 0
$

Tha patch fixes this by calling tcf_idr_release() on existing actions.

Fixes: 86da71b57383d ("net_sched: Introduce skbmod action")
Signed-off-by: Roman Mashak <mrv@mojatatu.com>
Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_skbmod.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/net/sched/act_skbmod.c
+++ b/net/sched/act_skbmod.c
@@ -131,8 +131,11 @@ static int tcf_skbmod_init(struct net *n
 	if (exists && bind)
 		return 0;
 
-	if (!lflags)
+	if (!lflags) {
+		if (exists)
+			tcf_idr_release(*a, bind);
 		return -EINVAL;
+	}
 
 	if (!exists) {
 		ret = tcf_idr_create(tn, parm->index, est, a,
