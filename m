Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524943239; cv=none;
        d=google.com; s=arc-20160816;
        b=hEQeUiiRWaAZZU8eVtVBlb41JLxhYvSFzgvNkicmzfE+QMVnLuhq5aYMgM++0tOF2g
         Os/0BDXHraW5axiAg3Npc/pISBQWvdFm8hMBmdTWJhytxj1x+3oB4Cye91oUWd+8H3nz
         gIsExz6/1YBh8n8cyWijgOB5Fgu2t7Mp7Vh95Uh8708oF3uUS4IHvSUMwYekIlD4/X0A
         NxMq4wT2e/j/MR6GZYREo3Z0bc+JEmsJgmEa3lcvchgSv2ZibAvwsCUmYd9Oh6pBW/M2
         WmK1g45YDndqrfTFvNpGNj51YeRa6WJUaAWfmOw7zPgmAYM60Xfkk80AFzC4FVaH5m90
         31Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=kmTVJ2sYG/ViKy9Hf7JBN1GZJusI2xLIOaQID71TufQ=;
        b=fmExGZnHsE60jOCV22zgVS/OokBxGt/1j7BsBhkmswj9X7C3aJTaoX57ovA+dv4uaB
         J2uBeVzowdDC/7JBVLLMBkc9cvmslIFkRQmlazlhrhXqxJA9BkqtMLIAElhbVj1R412W
         qGEnBhcyZzT9LVSa3PgN12cv4dIPhLa3K7tCQaen2N7vqSOnaloU3n5rOwf3jUeyTHyu
         +R2zos3s3t7cFeG3nN2MzpXoqB9W0QgD02G+z3N9TsWftxhkxUGCJqbtUQ/eE9NoxDfM
         j5AKKq0UZamYprPdhx3xDJ9XBEq1TK1uiyHBrd4bJfUD1Z0hcva21uIC/GT7yIMXM/Mz
         aTzg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AB8JxZpRTd0duAYf46MzRz+DBa230kLZ5JjY9OCgz5OFf7UGn3y1JS1rt0tO8f20A/rI7jjCQDmY/g==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: ebiederm@xmission.com,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: avagin@virtuozzo.com,
	ktkhai@virtuozzo.com,
	serge@hallyn.com,
	gregkh@linuxfoundation.org,
	Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH net-next 1/2 v4] uevent: add alloc_uevent_skb() helper
Date: Sat, 28 Apr 2018 21:20:24 +0200
Message-Id: <20180428192025.2075-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180428192025.2075-1-christian.brauner@ubuntu.com>
References: <20180428192025.2075-1-christian.brauner@ubuntu.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599018882280223334?=
X-GMAIL-MSGID: =?utf-8?q?1599018882280223334?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds alloc_uevent_skb() in preparation for follow up patches.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
v3->v4:
* non-functional changes:
  initialize some variables again explicitly to make it obvious to
  readers that they are correctly set
v2->v3:
* new approach: patch added
v1->v2:
* different approach in different patchset
v0->v1:
* different approach in different patchset
---
 lib/kobject_uevent.c | 47 ++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 15ea216a67ce..649bf60a9440 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -22,6 +22,7 @@
 #include <linux/socket.h>
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
+#include <linux/uidgid.h>
 #include <linux/uuid.h>
 #include <linux/ctype.h>
 #include <net/sock.h>
@@ -296,6 +297,38 @@ static void cleanup_uevent_env(struct subprocess_info *info)
 }
 #endif
 
+#ifdef CONFIG_NET
+static struct sk_buff *alloc_uevent_skb(struct kobj_uevent_env *env,
+					const char *action_string,
+					const char *devpath)
+{
+	struct netlink_skb_parms *parms;
+	struct sk_buff *skb = NULL;
+	char *scratch;
+	size_t len;
+
+	/* allocate message with maximum possible size */
+	len = strlen(action_string) + strlen(devpath) + 2;
+	skb = alloc_skb(len + env->buflen, GFP_KERNEL);
+	if (!skb)
+		return NULL;
+
+	/* add header */
+	scratch = skb_put(skb, len);
+	sprintf(scratch, "%s@%s", action_string, devpath);
+
+	skb_put_data(skb, env->buf, env->buflen);
+
+	parms = &NETLINK_CB(skb);
+	parms->creds.uid = GLOBAL_ROOT_UID;
+	parms->creds.gid = GLOBAL_ROOT_GID;
+	parms->dst_group = 1;
+	parms->portid = 0;
+
+	return skb;
+}
+#endif
+
 static int kobject_uevent_net_broadcast(struct kobject *kobj,
 					struct kobj_uevent_env *env,
 					const char *action_string,
@@ -314,22 +347,10 @@ static int kobject_uevent_net_broadcast(struct kobject *kobj,
 			continue;
 
 		if (!skb) {
-			/* allocate message with the maximum possible size */
-			size_t len = strlen(action_string) + strlen(devpath) + 2;
-			char *scratch;
-
 			retval = -ENOMEM;
-			skb = alloc_skb(len + env->buflen, GFP_KERNEL);
+			skb = alloc_uevent_skb(env, action_string, devpath);
 			if (!skb)
 				continue;
-
-			/* add header */
-			scratch = skb_put(skb, len);
-			sprintf(scratch, "%s@%s", action_string, devpath);
-
-			skb_put_data(skb, env->buf, env->buflen);
-
-			NETLINK_CB(skb).dst_group = 1;
 		}
 
 		retval = netlink_broadcast_filtered(uevent_sock, skb_get(skb),
-- 
2.17.0
