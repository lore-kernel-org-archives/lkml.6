Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524998670; cv=none;
        d=google.com; s=arc-20160816;
        b=loPU+Z8h02yZbKh2FNQMjEBtz1/+j9Meuqj/UkXDMImvQ9FTq54lSrdTo7d0vEezkY
         OUysslA72P8XqiJ295BRAuakMaODBcrhWayBW7eKPjti7/nJ5OYua/gs7b+66gdvxEG+
         G/Yqfcdavf+M5hgIifjZ7eSmBKXONpcbiNhtxnoNzwFncq1yM5HioF9WHDmBkR6E0cr/
         VzhGCeiFcURnug2fJDfwP4Xj7HsgaLFg7z0B9Tl00WaO11q5MfF+pCiEbwhW9DZJRlp1
         cEu0sH/YV5JR2ZXSP0/SKb5Mb5uJFBFcfm7gP62MPrX9A70gtDHjeU9oacxLwJHxnlIQ
         W3CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=OdIYny+LHErRkV+rZrFhIk3cpM7rLK52cLkASjRFWRo=;
        b=cehUbmyxrIPJzHdO7QXSYOc5ePiTcvazkqgUli3fPIAUfoaht55appJCOtMbpb58CT
         dCNsDUsMicl51LU9Zh9UtZ2PsJobjXkvC/Lad6HUrbXsxa0uQHuodeZXUH7ck0/bQBb3
         hDgd/X2gU+b6uKgnybQCkX+4QsLdVHZeJ4hLI3gSHCfyr87ejqgVsqFyNf0e7sojuD6/
         i4A/tozkqZ5ldWQkHQBhMk+R0DgmN3XbsTLotlxwlTSXl06Nu1lCK++ExarjxBoKLFq2
         VBI8h7l9QMs0WicvuFvWpLaO1UXqRSqW7F+hn8HwLYJkvISlmJWVIsu856ulvtrVriFE
         8Q7A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AB8JxZo8OufsylX9VOOS5gTJ1SQsWXIL8X48Wbq0trN036FcAuPgIhjMjBJBTOablb1Nib9GBW56lQ==
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
Subject: [PATCH net-next 1/2 v5] uevent: add alloc_uevent_skb() helper
Date: Sun, 29 Apr 2018 12:44:11 +0200
Message-Id: <20180429104412.22445-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180429104412.22445-1-christian.brauner@ubuntu.com>
References: <20180429104412.22445-1-christian.brauner@ubuntu.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599077005767717796?=
X-GMAIL-MSGID: =?utf-8?q?1599077005767717796?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds alloc_uevent_skb() in preparation for follow up patches.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
v4->v5:
* patch unchanged
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
