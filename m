Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrkI5ody7I8DRxhR5E4THFLZmsWNCKXEcn+93MPlqFoPdXxsmkhie3/lc4125hFrOFZqLpK
ARC-Seal: i=1; a=rsa-sha256; t=1526631539; cv=none;
        d=google.com; s=arc-20160816;
        b=XGHzZp2u5Lb72UfjHJUipRuV7IdW1gN+3Hf4NZlGHJEFXUEPMRTBgaT0xt8GVsR7N9
         K9sY1TARmquX1deIJLk55PjCEgGlRCJV2ukjiB45wFxdQwgIRLVqs98U90uUK5HX8ZXS
         tGBo0mx3JlO6rEyQKGCRJlIB2/DjNTgkpg/PHrLna1AR9pxc9rvmvECLlZ/xUwxFIPnL
         1uNxC8Pdhcm082WguKYqJq/X1x2qCOFHpgGcH4zxzeaZAGjCymeKEF4UNXLSdTZ50UAO
         QIT5n+0Z76xM6WgjZNTZ7r7CVOb2ptG7E/5TINJUmxzAFYkWZxcIS5p/vBE9xlmxuOep
         Eeiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=e59970oXoqXHPnBV6hiR9tB+26RhnDGyWBiw6+mgwY4=;
        b=P1pEIpDBJkXhGfbWLJAZug6DcPRj2MLokHnU0nuph6oC01rDGjrs2M9PiJ+1l8Zo4G
         RTnREcUzQxBrlOOI10LhOYiidws7md18Xz1nQgFDhZR49NeY0U86aTgNuf3dBgQDElQt
         9GH0tonhJX2p5vNRal6+3q7bK2DsvCikTbChh8sgB+j3XEOtHBiRWGXNvQSH14sQDg3h
         NR6xZ1EtETfrOZIEz/kbwNUhdBA35t2C+Enoct5KIgC13MqYWZox39VYYwTajVz1q20O
         Yt/AI04n1onhf2oozHVvTHQYFbUy+aRXgjwXy6XaLUndV6DIkjfR9jGhKpHtGBZ4QDd+
         ecQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=V3/VanWm;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=V3/VanWm;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Roman Mashak <mrv@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 13/55] net sched actions: fix refcnt leak in skbmod
Date: Fri, 18 May 2018 10:15:09 +0200
Message-Id: <20180518081458.104164279@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518081457.428920292@linuxfoundation.org>
References: <20180518081457.428920292@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789193125725958?=
X-GMAIL-MSGID: =?utf-8?q?1600789193125725958?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
