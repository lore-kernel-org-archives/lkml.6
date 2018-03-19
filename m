Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521461856; cv=none;
        d=google.com; s=arc-20160816;
        b=n/t+cE2jbAe0wFRgWrkPhQiooEZBoEQI0FM4rzwTmjB/wjtkAwbi4KUtTkWOXYmjOl
         JXP5vYsORyCKv9tjL3UoZ2l5tZlk2ZrC7O/hkEXP+RaNvSNSSFm0FLus7QAa4MU5ClTl
         acvSYqLC2UKgoQj1lqIs6IZisJKX9FtdmxhsRVVs9m6m2ghDIc9Lv31AQ2f/pC++RAYr
         YYFcHPJcMIB0tFg03J1AQ2wJvIg6U1bBrK+NLomKDNWYye9T5hdBB6jaARZKSHS1x7i2
         M5zSBUBzKvTYDfHSbxs1Npg90rvTcAATmILWvIPl36/0bNKWJCegk7rlnLtTNKpEYJjR
         co9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=0iZTM7zhHjNmqumykyD50BbOZeddOt4/VHW7pBD7T+c=;
        b=CoLKxSCsMcWDkIBBf3degsg7qmfyiseRedQOe5oL30JPVgSgJ/u5wvgWyQOmCUBoKl
         1zESZ00XXkJUcKhjD9VzsjdrG5qf1c8m/MKiwiEWi3zxVujTDqoD26WyDcOqc+pUzoma
         4HtWWUzSlE5m3TOMUI54Q7/R34FRYCPgnwkv6Ny+QmG54br2uxhSjoWueDGrx9Pa7jj0
         weuFLoTYr+eYg/Xbai+p6cdvkXXpd3GX7Pp+inUFndCf8dUhcdUMVJrDjMUdrTPVvWI7
         q2mRLnYZ6xMGbJ8kCCHqYEcvHR1ghakGPML4fs0nlBt8wXcH6kI9FKpExSM4eWFHJ34n
         JYag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AG47ELvHxmpmlYlV0uCHgu396z03GfGPpORNo9Z+YKDFi6OcmvWXqU1qtkvB46bgJFCPRjNJh98TnQ==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: ebiederm@xmission.com,
	gregkh@linuxfoundation.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: serge@hallyn.com,
	avagin@virtuozzo.com,
	ktkhai@virtuozzo.com,
	Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH net-next 1/2 v4] net: add uevent socket member
Date: Mon, 19 Mar 2018 13:17:30 +0100
Message-Id: <20180319121731.14449-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.15.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595368388087752146?=
X-GMAIL-MSGID: =?utf-8?q?1595368388087752146?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This commit adds struct uevent_sock to struct net. Since struct uevent_sock
records the position of the uevent socket in the uevent socket list we can
trivially remove it from the uevent socket list during cleanup. This speeds
up the old removal codepath.
Note, list_del() will hit __list_del_entry_valid() in its call chain which
will validate that the element is a member of the list. If it isn't it will
take care that the list is not modified.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
Changelog v3->v4:
* non-functional change: remove return from function returning void

Changelog v2->v3:
* patch added
  This patch was split out of the follow up patch
  Subject: [PATCH 2/2 v3] netns: send uevent messages

Changelog v1->v2:
* patch not present

Changelog v0->v1:
* patch not present
---
 include/net/net_namespace.h |  4 +++-
 lib/kobject_uevent.c        | 17 +++++++----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index f306b2aa15a4..abd7d91bffac 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -40,7 +40,7 @@ struct net_device;
 struct sock;
 struct ctl_table_header;
 struct net_generic;
-struct sock;
+struct uevent_sock;
 struct netns_ipvs;
 
 
@@ -79,6 +79,8 @@ struct net {
 	struct sock 		*rtnl;			/* rtnetlink socket */
 	struct sock		*genl_sock;
 
+	struct uevent_sock	*uevent_sock;		/* uevent socket */
+
 	struct list_head 	dev_base_head;
 	struct hlist_head 	*dev_name_head;
 	struct hlist_head	*dev_index_head;
diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 9fe6ec8fda28..8dd992e8638d 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -32,11 +32,13 @@ u64 uevent_seqnum;
 #ifdef CONFIG_UEVENT_HELPER
 char uevent_helper[UEVENT_HELPER_PATH_LEN] = CONFIG_UEVENT_HELPER_PATH;
 #endif
-#ifdef CONFIG_NET
+
 struct uevent_sock {
 	struct list_head list;
 	struct sock *sk;
 };
+
+#ifdef CONFIG_NET
 static LIST_HEAD(uevent_sock_list);
 #endif
 
@@ -621,6 +623,9 @@ static int uevent_net_init(struct net *net)
 		kfree(ue_sk);
 		return -ENODEV;
 	}
+
+	net->uevent_sock = ue_sk;
+
 	mutex_lock(&uevent_sock_mutex);
 	list_add_tail(&ue_sk->list, &uevent_sock_list);
 	mutex_unlock(&uevent_sock_mutex);
@@ -629,17 +634,9 @@ static int uevent_net_init(struct net *net)
 
 static void uevent_net_exit(struct net *net)
 {
-	struct uevent_sock *ue_sk;
+	struct uevent_sock *ue_sk = net->uevent_sock;
 
 	mutex_lock(&uevent_sock_mutex);
-	list_for_each_entry(ue_sk, &uevent_sock_list, list) {
-		if (sock_net(ue_sk->sk) == net)
-			goto found;
-	}
-	mutex_unlock(&uevent_sock_mutex);
-	return;
-
-found:
 	list_del(&ue_sk->list);
 	mutex_unlock(&uevent_sock_mutex);
 
-- 
2.15.1
