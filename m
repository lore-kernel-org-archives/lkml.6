Return-Path: <mika.westerberg@linux.intel.com>
X-Google-Smtp-Source: AG47ELsg72/UhvuUQx9tQSziUXajwLHyQl8Y6Purgkgj8upcw/ka6yqSo2GSvBPUEWRXgDbwnKdz
ARC-Seal: i=1; a=rsa-sha256; t=1521476830; cv=none;
        d=google.com; s=arc-20160816;
        b=tV51qS/YygryHhEEiEONIVtHeFWAiUWQG3+DA9fXiCGKOlNUuJj9KrOdiKpD+4fSzH
         0c5EflqImZXiKSKZF3t3j6+QVXmG+Nu7nERzKbdOiN3y5YQVDx/3oS76tipxKP6fDlax
         0avp/3HzF9XBafNsP9oetrKvmlq8YBiZ861tI0lAAP83gKt0pM1ugvpxfimoQouRzWVw
         7gh7CbvP24jVGxqv+lmZvj52p1AxmZ6tlDIxbY3owQO235hpi9F25jP4lCxHQSBJrnVw
         co6be1GScPBgEcLrYq9Z6Mhnqu1dtejSE0pe+6Ffgpy1AqSLUz+OVd8M2Bsivg/osWtR
         plhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=njidZS1bQHdsx60Prv2VN9xF9UgKdr6AKz5ZpSdBweQ=;
        b=oM0LCLMuVR/CPUxS2lmA9wcl9/Ntmn/3x+jPsjwFrQuyyzahyjOdqg/i4H5JPqvaGg
         OT00FcJtZDqVpz5tn2fNesftYXRKzxwGEirqZ/vRY3iZxYRwljmPQ95o22OCag9M+x0Y
         unYIr63smMxvrF+geXuGelTqqHV6rNrYquj8HqlItv33qZXiw7vD73fr3GdE10ObXOez
         Jhq6P7xgFYtsHBznO0KirAQqxVh12RRMPYoZOvGlScSW2txQ9Pmats8d0dd84opM+HmT
         XJkI2XcHJk+ACfv7BsOD2LXa9hIUt/gdPrbqJAmLwSsDmtsIFZFoPIv9WcUaCrGwxzAR
         Yr7A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="209529721"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <yehezkel.bernat@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Radion Mirchevsky <radion.mirchevsky@intel.com>
Subject: [PATCH 11/19] thunderbolt: Add tb_switch_find_by_route()
Date: Mon, 19 Mar 2018 19:26:55 +0300
Message-Id: <20180319162703.5331-12-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
References: <20180319162703.5331-1-mika.westerberg@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595384089082313918?=
X-GMAIL-MSGID: =?utf-8?q?1595384089082313918?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Radion Mirchevsky <radion.mirchevsky@intel.com>

With the new ICM messaging there is need for find switch by route string
instead of link and depth. Add new function that makes it possible.

Signed-off-by: Radion Mirchevsky <radion.mirchevsky@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/thunderbolt/switch.c | 33 +++++++++++++++++++++++++++++++++
 drivers/thunderbolt/tb.h     |  1 +
 2 files changed, 34 insertions(+)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 2a0bded44922..4e2b2097bbfc 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1479,6 +1479,7 @@ struct tb_sw_lookup {
 	u8 link;
 	u8 depth;
 	const uuid_t *uuid;
+	u64 route;
 };
 
 static int tb_switch_match(struct device *dev, void *data)
@@ -1494,6 +1495,11 @@ static int tb_switch_match(struct device *dev, void *data)
 	if (lookup->uuid)
 		return !memcmp(sw->uuid, lookup->uuid, sizeof(*lookup->uuid));
 
+	if (lookup->route) {
+		return sw->config.route_lo == lower_32_bits(lookup->route) &&
+		       sw->config.route_hi == upper_32_bits(lookup->route);
+	}
+
 	/* Root switch is matched only by depth */
 	if (!lookup->depth)
 		return !sw->depth;
@@ -1551,6 +1557,33 @@ struct tb_switch *tb_switch_find_by_uuid(struct tb *tb, const uuid_t *uuid)
 	return NULL;
 }
 
+/**
+ * tb_switch_find_by_route() - Find switch by route string
+ * @tb: Domain the switch belongs
+ * @route: Route string to look for
+ *
+ * Returned switch has reference count increased so the caller needs to
+ * call tb_switch_put() when done with the switch.
+ */
+struct tb_switch *tb_switch_find_by_route(struct tb *tb, u64 route)
+{
+	struct tb_sw_lookup lookup;
+	struct device *dev;
+
+	if (!route)
+		return tb_switch_get(tb->root_switch);
+
+	memset(&lookup, 0, sizeof(lookup));
+	lookup.tb = tb;
+	lookup.route = route;
+
+	dev = bus_find_device(&tb_bus_type, NULL, &lookup, tb_switch_match);
+	if (dev)
+		return tb_to_switch(dev);
+
+	return NULL;
+}
+
 void tb_switch_exit(void)
 {
 	ida_destroy(&nvm_ida);
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index c7bd77e9c2c3..2cd6085a6e10 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -386,6 +386,7 @@ struct tb_switch *get_switch_at_route(struct tb_switch *sw, u64 route);
 struct tb_switch *tb_switch_find_by_link_depth(struct tb *tb, u8 link,
 					       u8 depth);
 struct tb_switch *tb_switch_find_by_uuid(struct tb *tb, const uuid_t *uuid);
+struct tb_switch *tb_switch_find_by_route(struct tb *tb, u64 route);
 
 static inline struct tb_switch *tb_switch_get(struct tb_switch *sw)
 {
-- 
2.16.2
