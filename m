Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/0bSrYgvonedKahewQWQZbPHNvjjW9fEtsZ631pizdLWMheE5HFFJUjpPYdQxvxQGHLmwL
ARC-Seal: i=1; a=rsa-sha256; t=1523473025; cv=none;
        d=google.com; s=arc-20160816;
        b=wKDlQB7pk+rorI8WdU9WwGp4aiZDqIzqylZok+6JRFqSwhNxPqqkEcjbEvEgEKs/ZS
         KhCHrA2lNqgMJcWq/zsLR/9K67ZTOlbnQ4HKqTNIDEK+LWTJN80LKxmwJYdyEFaIlXC4
         v+jHNu3b/hvW2YRyw3T0xgeClaKynJaPk4hwfyBxMf4FSCZTRvdW1g6oqxJ0HBi8zcWz
         9F3B4pPfL1s3aah92LoPtGAVPFsC35kkE6uGquR5FU+1DVgTtb/BmVn9dZniZ3mLL4SX
         NANwWSo2CQcG3ikZLPY+jlNU8q/1W9/OqhJ+Axupbhkto6XK6808VmgEfjCfXBLqenc8
         5r2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6SnY0h7LM/WGHccSlmtzOeEVSs6x0sC04NtugfRy0eE=;
        b=bxE3vcDVn1iXBTCqaUEj4dUP2vr854dppH1jn8xD/3xaxd45ugKKRiC1uEgLlu1wKD
         VDdM/BDgxXoN9UPvzhUVP0a+fN5hcBaGTEdMgwowDSIapEV42j9nA6z0uhkk3NusceJW
         IXVrPanNW82psL4Lv33eIhrfi5wITU4ObqEjtlCJCkjJEa3LVkiiY5SrTjmLkXhvUhQB
         d9BhONgEVuZf/tD57UvVBzFa8dVeE/zHF1bVxzQJb7RJvnBxOppLH/UB9iyWNthne4L3
         v6r3pD1k1yuAThw6tlx9BJ+ZyvGf8Dtn0jUeP6APnH1+jSOu/nfxXkoFUpXM4/qK6Dg3
         2Plg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	linzhang <xiaolou4617@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 068/310] net: x25: fix one potential use-after-free issue
Date: Wed, 11 Apr 2018 20:33:27 +0200
Message-Id: <20180411183625.247125347@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476110587421066?=
X-GMAIL-MSGID: =?utf-8?q?1597477250753043656?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: linzhang <xiaolou4617@gmail.com>


[ Upstream commit 64df6d525fcff1630098db9238bfd2b3e092d5c1 ]

The function x25_init is not properly unregister related resources
on error handler.It is will result in kernel oops if x25_init init
failed, so add properly unregister call on error handler.

Also, i adjust the coding style and make x25_register_sysctl properly
return failure.

Signed-off-by: linzhang <xiaolou4617@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/x25.h        |    4 ++--
 net/x25/af_x25.c         |   24 ++++++++++++++++--------
 net/x25/sysctl_net_x25.c |    5 ++++-
 3 files changed, 22 insertions(+), 11 deletions(-)

--- a/include/net/x25.h
+++ b/include/net/x25.h
@@ -298,10 +298,10 @@ void x25_check_rbuf(struct sock *);
 
 /* sysctl_net_x25.c */
 #ifdef CONFIG_SYSCTL
-void x25_register_sysctl(void);
+int x25_register_sysctl(void);
 void x25_unregister_sysctl(void);
 #else
-static inline void x25_register_sysctl(void) {};
+static inline int x25_register_sysctl(void) { return 0; };
 static inline void x25_unregister_sysctl(void) {};
 #endif /* CONFIG_SYSCTL */
 
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -1790,32 +1790,40 @@ void x25_kill_by_neigh(struct x25_neigh
 
 static int __init x25_init(void)
 {
-	int rc = proto_register(&x25_proto, 0);
+	int rc;
 
-	if (rc != 0)
+	rc = proto_register(&x25_proto, 0);
+	if (rc)
 		goto out;
 
 	rc = sock_register(&x25_family_ops);
-	if (rc != 0)
+	if (rc)
 		goto out_proto;
 
 	dev_add_pack(&x25_packet_type);
 
 	rc = register_netdevice_notifier(&x25_dev_notifier);
-	if (rc != 0)
+	if (rc)
 		goto out_sock;
 
-	pr_info("Linux Version 0.2\n");
+	rc = x25_register_sysctl();
+	if (rc)
+		goto out_dev;
 
-	x25_register_sysctl();
 	rc = x25_proc_init();
-	if (rc != 0)
-		goto out_dev;
+	if (rc)
+		goto out_sysctl;
+
+	pr_info("Linux Version 0.2\n");
+
 out:
 	return rc;
+out_sysctl:
+	x25_unregister_sysctl();
 out_dev:
 	unregister_netdevice_notifier(&x25_dev_notifier);
 out_sock:
+	dev_remove_pack(&x25_packet_type);
 	sock_unregister(AF_X25);
 out_proto:
 	proto_unregister(&x25_proto);
--- a/net/x25/sysctl_net_x25.c
+++ b/net/x25/sysctl_net_x25.c
@@ -73,9 +73,12 @@ static struct ctl_table x25_table[] = {
 	{ 0, },
 };
 
-void __init x25_register_sysctl(void)
+int __init x25_register_sysctl(void)
 {
 	x25_table_header = register_net_sysctl(&init_net, "net/x25", x25_table);
+	if (!x25_table_header)
+		return -ENOMEM;
+	return 0;
 }
 
 void x25_unregister_sysctl(void)
