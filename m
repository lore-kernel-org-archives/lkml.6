Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp16B6kYbPlfBUM3FEBzkDwouM3dUQ6QFZss1cgYf6oXrj6tA5gw6jWw3tJjLHx0Ayqp0Lf
ARC-Seal: i=1; a=rsa-sha256; t=1527155988; cv=none;
        d=google.com; s=arc-20160816;
        b=ecSiclCiYEIUnVuOjxOCNSpYvIK/+Rp1jtfJWqOIiHLcnZwW85d7TNTN+30DO/ZZOd
         xHnJE0DMgEXFp1tJJiHdMbz4PqVzWLYsYYBMAuzUrFrERr3jUr57KyV+x8iTrx/HgiBs
         lm+poLaAnEJIupz6pHjmcTPkcCNlkLHfa9fz+oWQ+xpSVVGKDy/lzUQ9V3q7Rz18UWqG
         +LKzpFfSNFP9JgGajonRlEQ2VHbXp/cV+6nq/9+tfxthLHfX8bme3ew+Quuy2wjNnaaS
         +WXlSlA7n4ZOmoLjmKEJtVatTkXXl42lynkBw3gLKl2cRRpR8ouj74+dZxZOOWJEU2XD
         uxcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=kxRTwnqKW+jxLk8LHj6dy1Y8/kMVsOwkJeJpdHgL4q0=;
        b=z63zYnzGoWsGs7OfpZ6m1vuuY/qSZQuPg9C2dXgGUGwLs8ZyNQgHIJmhH28vT/SV9z
         r4vRAA4OaPQ6qm8M7I42SgnhQwIMj0cDeoNimgEnqholASb2BbBWD6vUjXHhUCUGNHJO
         b4Ii9Yfiw6Qoh+SNtYPsOmf6V30w7WBOacCr3TQpBN/NA2tFm0MDcUX1Mo36GPELtrYW
         ADSnNJ9Pq0lzMzUTR6hg/DQCGBaBsl/390MzGHAfcKvimUrKNpLT9x8bMVXhj33p7zQX
         59i26lEsmPOn74gYE+9aVEUInrgOyb1auyWT7i2vXKg5Etd2Cpu0NBJmtfk7lQPDdEw1
         teTw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=nABJRlBr;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=nABJRlBr;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Roman Mashak <mrv@mojatatu.com>,
	Davide Caratti <dcaratti@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 004/161] net/sched: fix refcnt leak in the error path of tcf_vlan_init()
Date: Thu, 24 May 2018 11:37:09 +0200
Message-Id: <20180524093018.881882967@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338604245785674?=
X-GMAIL-MSGID: =?utf-8?q?1601339117914525945?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Davide Caratti <dcaratti@redhat.com>

[ Upstream commit 5a4931ae0193f8a4a97e8260fd0df1d705d83299 ]

Similarly to what was done with commit a52956dfc503 ("net sched actions:
fix refcnt leak in skbmod"), fix the error path of tcf_vlan_init() to avoid
refcnt leaks when wrong value of TCA_VLAN_PUSH_VLAN_PROTOCOL is given.

Fixes: 5026c9b1bafc ("net sched: vlan action fix late binding")
CC: Roman Mashak <mrv@mojatatu.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_vlan.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -161,6 +161,8 @@ static int tcf_vlan_init(struct net *net
 			case htons(ETH_P_8021AD):
 				break;
 			default:
+				if (exists)
+					tcf_idr_release(*a, bind);
 				return -EPROTONOSUPPORT;
 			}
 		} else {
