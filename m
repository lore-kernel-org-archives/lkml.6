Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521284911; cv=none;
        d=google.com; s=arc-20160816;
        b=isL0cUu+qAubw0gYQ7XhaV+XMEovmvYCd5XXTa80u5qV7OAv9z77xoUE6MF6vMPwBF
         xt8DScrZtBd26+1abM7g8BTFeQQY8v0IgWp/yCdCWBKjA3/isqtRAoLHLSEKfVt0f6np
         HK5MkPXG5lq/NYzS8Nwe+YSQTvy0DMkkrkVcdhyaP1aD48Fph3e4HBCnOh9qMiUy4x6Y
         W9gr8R/Ax6rtbT599rEr4Y1FOp8DJhxks33K0s/+uZ9u4XQGbo3j8HLj2vGj27ohiec1
         Pe3tDOWdnP+smmQTxv3aBa1bhOXsCPEM+Hqt35myWJ9C8rN6d4wpDD7r1rG95tcaNidW
         3P6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=9mVGSYcsI8H+36oI/xwnlNInsT8ktEiG0gBQj6GI6z4=;
        b=xKpHEGVNIDrpUMVaWB/je2oPSck5yBo7yZ1iA41l5/EVJfb+2aDm3VV/qIPWdbxTjX
         KtUKhEV3XhLRKIS3FiKceZ3iqsMVTuc+yl6ahqffzfoUzbWLPHwtFidh2E4h0kil1Mpr
         rNoIg1JVmvJudD57Fx+eGIS2Rj++SHGj5jGbhf0oeLAtJZGuuhLFFbah4z4gDu1MbEWS
         d6y9ssQWq1ZwvrXmiOHSPARBrkwUJISkaBMxFQMmYJNRb6YImUa1/KPjCSBP0FXq1/hx
         Ua2F9fI2cV1u71SpSGhJXSTgUI3UGf0a0R2WQWFbe+iHmLCSUwnRXU3rL6AwhyvgcPQq
         tgyA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AG47ELvVRVkNoAxEWL+P77C3taOJBSXIY5EL3QWkwejKj3P6zt4b3Ck2I22r8V6JF3pwwpWOFwq/UA==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: ebiederm@xmission.com,
	gregkh@linuxfoundation.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: serge@hallyn.com,
	avagin@virtuozzo.com,
	ktkhai@virtuozzo.com,
	Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 1/2 v3] net: add uevent socket member
Date: Sat, 17 Mar 2018 12:08:25 +0100
Message-Id: <20180317110826.1581-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.15.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595182847034826440?=
X-GMAIL-MSGID: =?utf-8?q?1595182847034826440?=
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
 lib/kobject_uevent.c        | 19 +++++++++----------
 2 files changed, 12 insertions(+), 11 deletions(-)

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
index 9fe6ec8fda28..cbdc60542cab 100644
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
@@ -629,22 +634,16 @@ static int uevent_net_init(struct net *net)
 
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
 
 	netlink_kernel_release(ue_sk->sk);
 	kfree(ue_sk);
+
+	return;
 }
 
 static struct pernet_operations uevent_net_ops = {
-- 
2.15.1
