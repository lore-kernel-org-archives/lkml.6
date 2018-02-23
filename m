Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226rUOxdzkOL0W24fDPExqwab+fnTznyowc+/dIpwaTmPp/qmnm1dx5J5ijBapXTeHIiR5UM
ARC-Seal: i=1; a=rsa-sha256; t=1519411812; cv=none;
        d=google.com; s=arc-20160816;
        b=H+iBuGqC8KzV3WP0YVrFlliQZghjdKDlpGKaLlJ+91hD/26XQvxej8geuzU6XW8ai7
         OUNpS77RUjZiIvEPK33Exk8GuumQbO7z7g26hqN18oqZg4P1A6VXZaQM4UM3Ge1xjyVm
         9Gkh89H+PtjSlk9hUKdvYZkgFEkvQ0lNmcc5nscG4AinQGS5L8mR/9O+sUr0FYKdj5yv
         8xO4GcHn574FhxHN85ZSze9DJZPaPlKuGiYtdI85H4CACtA/uUr8gRg6tYSTZSdoGCef
         S8KT9VkMaOEG/0zF8O4k0Exm+lB543WIsR3Z3zc+urH7GeQ9J5Hc4d3zU4D+a2P9mDQN
         8ruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kyj5shQQ+f2M7VIlaJ/SpZ2jZ4JVpgaBPd958F8e5cE=;
        b=BbGE5fM2Cl7sN5i1l8JcD0dIQfM8/ZfkOYyGjgcfrV+6lzPXXrP3sB8bi7CyvsSCqD
         g1z4RRAgHK2zt4Bi3M54qKty8JQQYAcQOLfOxeDAG63x75PONQn2f3OFI5IGx2DVSvH3
         pYcGscVW1ttCPaSoEg6WlqeVRRnNPXpVq2k1s0rmgvL0AYVm9TuAB+KMartmlA6RS294
         4hEPLNHcuznbhKqxJcrs7Ezo2s0M7cHK02gXC56ASV9EhiIQ370WUQMNEQi5oAElYVCq
         VAy++Nhz2T/hlmPWJD0g2WURfL8nDUWihXlq5qt1y0X62dTOWw4nSEgs8ur9TiT4Kz5b
         SLrQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+e4d4f9ddd4295539735d@syzkaller.appspotmail.com,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 025/159] ptr_ring: try vmalloc() when kmalloc() fails
Date: Fri, 23 Feb 2018 19:25:33 +0100
Message-Id: <20180223170746.211788598@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218760596859413?=
X-GMAIL-MSGID: =?utf-8?q?1593218760596859413?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Wang <jasowang@redhat.com>

commit 0bf7800f1799b5b1fd7d4f024e9ece53ac489011 upstream.

This patch switch to use kvmalloc_array() for using a vmalloc()
fallback to help in case kmalloc() fails.

Reported-by: syzbot+e4d4f9ddd4295539735d@syzkaller.appspotmail.com
Fixes: 2e0ab8ca83c12 ("ptr_ring: array based FIFO for pointers")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/ptr_ring.h |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -445,11 +445,14 @@ static inline int ptr_ring_consume_batch
 	__PTR_RING_PEEK_CALL_v; \
 })
 
+/* Not all gfp_t flags (besides GFP_KERNEL) are allowed. See
+ * documentation for vmalloc for which of them are legal.
+ */
 static inline void **__ptr_ring_init_queue_alloc(unsigned int size, gfp_t gfp)
 {
 	if (size * sizeof(void *) > KMALLOC_MAX_SIZE)
 		return NULL;
-	return kcalloc(size, sizeof(void *), gfp);
+	return kvmalloc_array(size, sizeof(void *), gfp | __GFP_ZERO);
 }
 
 static inline void __ptr_ring_set_size(struct ptr_ring *r, int size)
@@ -582,7 +585,7 @@ static inline int ptr_ring_resize(struct
 	spin_unlock(&(r)->producer_lock);
 	spin_unlock_irqrestore(&(r)->consumer_lock, flags);
 
-	kfree(old);
+	kvfree(old);
 
 	return 0;
 }
@@ -622,7 +625,7 @@ static inline int ptr_ring_resize_multip
 	}
 
 	for (i = 0; i < nrings; ++i)
-		kfree(queues[i]);
+		kvfree(queues[i]);
 
 	kfree(queues);
 
@@ -630,7 +633,7 @@ static inline int ptr_ring_resize_multip
 
 nomem:
 	while (--i >= 0)
-		kfree(queues[i]);
+		kvfree(queues[i]);
 
 	kfree(queues);
 
@@ -645,7 +648,7 @@ static inline void ptr_ring_cleanup(stru
 	if (destroy)
 		while ((ptr = ptr_ring_consume(r)))
 			destroy(ptr);
-	kfree(r->queue);
+	kvfree(r->queue);
 }
 
 #endif /* _LINUX_PTR_RING_H  */
