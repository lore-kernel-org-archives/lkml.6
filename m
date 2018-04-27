Return-Path: <christianvanbrauner@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524824729; cv=none;
        d=google.com; s=arc-20160816;
        b=R8nSrjEpNPGTcincbbjnqpnXbQhhUMv668DA5QZNA8rKlPQGNgBPE3xOYF61ROm3yS
         BxrpQT3fPToGG8wHDsZosPrw+Pls0UmqOy/h28uZ00n9gI1DasAemVUyN1ZCVnh4hzYM
         TGC20ABdAtSU5S8wJqybKJLCubMf2rhxdbO6++r3XXOHpIbIwQpBNJ1z4ys5eQlEiAxa
         d0uICboY/m2nw/dHtu7PTE1bED3fn0j8GCRix+wZ7XWowe6jGRqOLBMv/GlH2Or7JsQq
         RfL7qj2BHar7d1xnGIun4fFgQE6PRFpECiEtyJ26DPhtwJ3RaqinlvskWJ5OCw3jBlg9
         Ykdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=2Jl+8SQIeO7MEoAMCxS2eFAe+IgVBf/Upf2n4x18n5w=;
        b=Dt3gTD3wTDLbqxFjjxelakz1K51dNGFQ+Z9A9JxNxPv/1Tsf+LwraJZkr/a6VKFFrL
         on8xe6tJcUg7J9Fm5dJsZaQdsRYAYHo+sG2Q4UVVI5zIUmcRp73Urb0My8jyRwznAOpm
         A05pV4LQFiB+TEK30J2vayclJtaCp/hTDyXU8lzCeG/xRtSYL2FbuYi9noh7OlD/MUt3
         lGFgZ02gGc2GAk5PMDLxdtXMjpSmRvd6tUXOEC0kyZPTYjFt/vj1tTtxPOAgg73JNx+B
         4KCAHfWl838lLE55AW5nTmPXrdmewvS4ZUGGdjGb8F1Rf+X/rcGaX6u638EFS13NAYCm
         7dAA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christianvanbrauner@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=christianvanbrauner@gmail.com
X-Google-Smtp-Source: AB8JxZowJOinpooA7V77TzKzuW2tRJVbVG26CLy78/NZURgxY/E6Jzp/pxMaVVK/8d3ThsNDP4hBVg==
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
Subject: [PATCH net-next 1/2 v3] uevent: add alloc_uevent_skb() helper
Date: Fri, 27 Apr 2018 12:23:05 +0200
Message-Id: <20180427102306.8617-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427102306.8617-1-christian.brauner@ubuntu.com>
References: <20180427102306.8617-1-christian.brauner@ubuntu.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598894615374917391?=
X-GMAIL-MSGID: =?utf-8?q?1598894615374917391?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds alloc_uevent_skb() in preparation for follow up patches.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 lib/kobject_uevent.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 15ea216a67ce..c3cb110f663b 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -296,6 +296,31 @@ static void cleanup_uevent_env(struct subprocess_info *info)
 }
 #endif
 
+static struct sk_buff *alloc_uevent_skb(struct kobj_uevent_env *env,
+					const char *action_string,
+					const char *devpath)
+{
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
+	NETLINK_CB(skb).dst_group = 1;
+
+	return skb;
+}
+
 static int kobject_uevent_net_broadcast(struct kobject *kobj,
 					struct kobj_uevent_env *env,
 					const char *action_string,
@@ -314,22 +339,10 @@ static int kobject_uevent_net_broadcast(struct kobject *kobj,
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
