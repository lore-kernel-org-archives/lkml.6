Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225x5F6cudGKBZ8REkJ66OsH6JT1CfvmFLBXpQ/Xmk+HlH7yZCdq6CBvxn1gtM9VHfrn5wLm
ARC-Seal: i=1; a=rsa-sha256; t=1519410771; cv=none;
        d=google.com; s=arc-20160816;
        b=hFz/GXrn1yPzDbOXRtZZhiSHOFxEAcxu5vlBqGCuIeUmKyb1CCks09xuS/pmEi2hzx
         mlmxf4jC7aak4KYHP+rA8IjR2RSgiyTClYEWaWGGSnk6FMy0TBSZwdPPZ/CQcg2gymAQ
         V0PTPnWnNDUSCrIkU3fmRTgE9UHqgzxLmsdKEoQgIQ/IAs90jTaoOU8ZcFgQeIjTnM++
         gPxES4C+WCLCxYB/qMGfl5WJzQDx2m6ieqzwQ0fbRTRDQUYh9yy26qDWRzWINfXK5tZb
         lOR58nZpv2U3I8nbC7yW2ZQZS+EejDk0jxScpaiqSgeMjeQTNRzc/AfyEHfNS+Oud2U/
         yutw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jcFRP/7liJp1sR76Y4+1Dc8yia+CBeviJNiMq+7opdg=;
        b=THaipU1r/mWqv/eXqkMFwkK3KOHdDJYjRK2T33No0q5cbl89loEgqozj2p5owNi59T
         HHg3Ta/wMLH5tSe9MY5F8P1JImXNcLGa8fUNqkJb6N5Ga5yh4LEpb3Z75o+5TXm0DmPB
         wZ5g+ouVmbPDHUpdutPixtKFdutXhvXLKtgE7mHtRZdWbnZcI68Y3xex1nJUVXCIJaqa
         kWJPgvOaEHmyMY5ssdKbuOXrfOWk/3mWaAgUUvd5uWJPWEyTjfnfU7uk2VV9i0AvxDR+
         918XS+BS7cay7alySFml/IzrA0lSKtViw91P7SrZk53/6c+CQFlfYYTQbSi/NSPpLeuO
         fQ/w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Manoj Boopathi Raj <manojboopathi@google.com>
Subject: [PATCH 4.4 001/193] net: add dst_cache support
Date: Fri, 23 Feb 2018 19:23:54 +0100
Message-Id: <20180223170326.200577903@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217669490499628?=
X-GMAIL-MSGID: =?utf-8?q?1593217669490499628?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

commit 911362c70df5b766c243dc297fadeaced786ffd8 upstream.

This patch add a generic, lockless dst cache implementation.
The need for lock is avoided updating the dst cache fields
only in per cpu scope, and requiring that the cache manipulation
functions are invoked with the local bh disabled.

The refresh_ts and reset_ts fields are used to ensure the cache
consistency in case of cuncurrent cache update (dst_cache_set*) and
reset operation (dst_cache_reset).

Consider the following scenario:

CPU1:                                   	CPU2:
  <cache lookup with emtpy cache: it fails>
  <get dst via uncached route lookup>
						<related configuration changes>
                                        	dst_cache_reset()
  dst_cache_set()

The dst entry set passed to dst_cache_set() should not be used
for later dst cache lookup, because it's obtained using old
configuration values.

Since the refresh_ts is updated only on dst_cache lookup, the
cached value in the above scenario will be discarded on the next
lookup.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Suggested-and-acked-by: Hannes Frederic Sowa <hannes@stressinduktion.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Manoj Boopathi Raj <manojboopathi@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/net/dst_cache.h |   97 +++++++++++++++++++++++++++
 net/Kconfig             |    4 +
 net/core/Makefile       |    1 
 net/core/dst_cache.c    |  168 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 270 insertions(+)

--- /dev/null
+++ b/include/net/dst_cache.h
@@ -0,0 +1,97 @@
+#ifndef _NET_DST_CACHE_H
+#define _NET_DST_CACHE_H
+
+#include <linux/jiffies.h>
+#include <net/dst.h>
+#if IS_ENABLED(CONFIG_IPV6)
+#include <net/ip6_fib.h>
+#endif
+
+struct dst_cache {
+	struct dst_cache_pcpu __percpu *cache;
+	unsigned long reset_ts;
+};
+
+/**
+ *	dst_cache_get - perform cache lookup
+ *	@dst_cache: the cache
+ *
+ *	The caller should use dst_cache_get_ip4() if it need to retrieve the
+ *	source address to be used when xmitting to the cached dst.
+ *	local BH must be disabled.
+ */
+struct dst_entry *dst_cache_get(struct dst_cache *dst_cache);
+
+/**
+ *	dst_cache_get_ip4 - perform cache lookup and fetch ipv4 source address
+ *	@dst_cache: the cache
+ *	@saddr: return value for the retrieved source address
+ *
+ *	local BH must be disabled.
+ */
+struct rtable *dst_cache_get_ip4(struct dst_cache *dst_cache, __be32 *saddr);
+
+/**
+ *	dst_cache_set_ip4 - store the ipv4 dst into the cache
+ *	@dst_cache: the cache
+ *	@dst: the entry to be cached
+ *	@saddr: the source address to be stored inside the cache
+ *
+ *	local BH must be disabled.
+ */
+void dst_cache_set_ip4(struct dst_cache *dst_cache, struct dst_entry *dst,
+		       __be32 saddr);
+
+#if IS_ENABLED(CONFIG_IPV6)
+
+/**
+ *	dst_cache_set_ip6 - store the ipv6 dst into the cache
+ *	@dst_cache: the cache
+ *	@dst: the entry to be cached
+ *	@saddr: the source address to be stored inside the cache
+ *
+ *	local BH must be disabled.
+ */
+void dst_cache_set_ip6(struct dst_cache *dst_cache, struct dst_entry *dst,
+		       const struct in6_addr *addr);
+
+/**
+ *	dst_cache_get_ip6 - perform cache lookup and fetch ipv6 source address
+ *	@dst_cache: the cache
+ *	@saddr: return value for the retrieved source address
+ *
+ *	local BH must be disabled.
+ */
+struct dst_entry *dst_cache_get_ip6(struct dst_cache *dst_cache,
+				    struct in6_addr *saddr);
+#endif
+
+/**
+ *	dst_cache_reset - invalidate the cache contents
+ *	@dst_cache: the cache
+ *
+ *	This do not free the cached dst to avoid races and contentions.
+ *	the dst will be freed on later cache lookup.
+ */
+static inline void dst_cache_reset(struct dst_cache *dst_cache)
+{
+	dst_cache->reset_ts = jiffies;
+}
+
+/**
+ *	dst_cache_init - initialize the cache, allocating the required storage
+ *	@dst_cache: the cache
+ *	@gfp: allocation flags
+ */
+int dst_cache_init(struct dst_cache *dst_cache, gfp_t gfp);
+
+/**
+ *	dst_cache_destroy - empty the cache and free the allocated storage
+ *	@dst_cache: the cache
+ *
+ *	No synchronization is enforced: it must be called only when the cache
+ *	is unsed.
+ */
+void dst_cache_destroy(struct dst_cache *dst_cache);
+
+#endif
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -383,6 +383,10 @@ config LWTUNNEL
 	  weight tunnel endpoint. Tunnel encapsulation parameters are stored
 	  with light weight tunnel state associated with fib routes.
 
+config DST_CACHE
+	bool "dst cache"
+	default n
+
 endif   # if NET
 
 # Used by archs to tell that they support BPF_JIT
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -24,3 +24,4 @@ obj-$(CONFIG_NET_PTP_CLASSIFY) += ptp_cl
 obj-$(CONFIG_CGROUP_NET_PRIO) += netprio_cgroup.o
 obj-$(CONFIG_CGROUP_NET_CLASSID) += netclassid_cgroup.o
 obj-$(CONFIG_LWTUNNEL) += lwtunnel.o
+obj-$(CONFIG_DST_CACHE) += dst_cache.o
--- /dev/null
+++ b/net/core/dst_cache.c
@@ -0,0 +1,168 @@
+/*
+ * net/core/dst_cache.c - dst entry cache
+ *
+ * Copyright (c) 2016 Paolo Abeni <pabeni@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/percpu.h>
+#include <net/dst_cache.h>
+#include <net/route.h>
+#if IS_ENABLED(CONFIG_IPV6)
+#include <net/ip6_fib.h>
+#endif
+#include <uapi/linux/in.h>
+
+struct dst_cache_pcpu {
+	unsigned long refresh_ts;
+	struct dst_entry *dst;
+	u32 cookie;
+	union {
+		struct in_addr in_saddr;
+		struct in6_addr in6_saddr;
+	};
+};
+
+void dst_cache_per_cpu_dst_set(struct dst_cache_pcpu *dst_cache,
+			       struct dst_entry *dst, u32 cookie)
+{
+	dst_release(dst_cache->dst);
+	if (dst)
+		dst_hold(dst);
+
+	dst_cache->cookie = cookie;
+	dst_cache->dst = dst;
+}
+
+struct dst_entry *dst_cache_per_cpu_get(struct dst_cache *dst_cache,
+					struct dst_cache_pcpu *idst)
+{
+	struct dst_entry *dst;
+
+	dst = idst->dst;
+	if (!dst)
+		goto fail;
+
+	/* the cache already hold a dst reference; it can't go away */
+	dst_hold(dst);
+
+	if (unlikely(!time_after(idst->refresh_ts, dst_cache->reset_ts) ||
+		     (dst->obsolete && !dst->ops->check(dst, idst->cookie)))) {
+		dst_cache_per_cpu_dst_set(idst, NULL, 0);
+		dst_release(dst);
+		goto fail;
+	}
+	return dst;
+
+fail:
+	idst->refresh_ts = jiffies;
+	return NULL;
+}
+
+struct dst_entry *dst_cache_get(struct dst_cache *dst_cache)
+{
+	if (!dst_cache->cache)
+		return NULL;
+
+	return dst_cache_per_cpu_get(dst_cache, this_cpu_ptr(dst_cache->cache));
+}
+EXPORT_SYMBOL_GPL(dst_cache_get);
+
+struct rtable *dst_cache_get_ip4(struct dst_cache *dst_cache, __be32 *saddr)
+{
+	struct dst_cache_pcpu *idst;
+	struct dst_entry *dst;
+
+	if (!dst_cache->cache)
+		return NULL;
+
+	idst = this_cpu_ptr(dst_cache->cache);
+	dst = dst_cache_per_cpu_get(dst_cache, idst);
+	if (!dst)
+		return NULL;
+
+	*saddr = idst->in_saddr.s_addr;
+	return container_of(dst, struct rtable, dst);
+}
+EXPORT_SYMBOL_GPL(dst_cache_get_ip4);
+
+void dst_cache_set_ip4(struct dst_cache *dst_cache, struct dst_entry *dst,
+		       __be32 saddr)
+{
+	struct dst_cache_pcpu *idst;
+
+	if (!dst_cache->cache)
+		return;
+
+	idst = this_cpu_ptr(dst_cache->cache);
+	dst_cache_per_cpu_dst_set(idst, dst, 0);
+	idst->in_saddr.s_addr = saddr;
+}
+EXPORT_SYMBOL_GPL(dst_cache_set_ip4);
+
+#if IS_ENABLED(CONFIG_IPV6)
+void dst_cache_set_ip6(struct dst_cache *dst_cache, struct dst_entry *dst,
+		       const struct in6_addr *addr)
+{
+	struct dst_cache_pcpu *idst;
+
+	if (!dst_cache->cache)
+		return;
+
+	idst = this_cpu_ptr(dst_cache->cache);
+	dst_cache_per_cpu_dst_set(this_cpu_ptr(dst_cache->cache), dst,
+				  rt6_get_cookie((struct rt6_info *)dst));
+	idst->in6_saddr = *addr;
+}
+EXPORT_SYMBOL_GPL(dst_cache_set_ip6);
+
+struct dst_entry *dst_cache_get_ip6(struct dst_cache *dst_cache,
+				    struct in6_addr *saddr)
+{
+	struct dst_cache_pcpu *idst;
+	struct dst_entry *dst;
+
+	if (!dst_cache->cache)
+		return NULL;
+
+	idst = this_cpu_ptr(dst_cache->cache);
+	dst = dst_cache_per_cpu_get(dst_cache, idst);
+	if (!dst)
+		return NULL;
+
+	*saddr = idst->in6_saddr;
+	return dst;
+}
+EXPORT_SYMBOL_GPL(dst_cache_get_ip6);
+#endif
+
+int dst_cache_init(struct dst_cache *dst_cache, gfp_t gfp)
+{
+	dst_cache->cache = alloc_percpu_gfp(struct dst_cache_pcpu,
+					    gfp | __GFP_ZERO);
+	if (!dst_cache->cache)
+		return -ENOMEM;
+
+	dst_cache_reset(dst_cache);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dst_cache_init);
+
+void dst_cache_destroy(struct dst_cache *dst_cache)
+{
+	int i;
+
+	if (!dst_cache->cache)
+		return;
+
+	for_each_possible_cpu(i)
+		dst_release(per_cpu_ptr(dst_cache->cache, i)->dst);
+
+	free_percpu(dst_cache->cache);
+}
+EXPORT_SYMBOL_GPL(dst_cache_destroy);
