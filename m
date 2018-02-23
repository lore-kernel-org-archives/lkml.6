Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224pqWpJWe8r6TxA31ME96z0QbwodrPJkK32KyPGk0QH5rUiLbkpeXxU4Nxya8gVlAleyP2A
ARC-Seal: i=1; a=rsa-sha256; t=1519412273; cv=none;
        d=google.com; s=arc-20160816;
        b=VbAZK3RjY6Ii8g9qSbIhGCFY6+QjjkmrvOxPPWQeEitWnTpKx68B5P+Hkll12ILduy
         5TzZuNUuxsdop7CM//CzMT3NbzWvAR/M4QFN8lQKZfyyw/wn1WIwkBkACCO3rZLi/Rcv
         jPgbpuiOZJ+SUKLhwqeYS+KY9nNmi5FsulXCCofHcc/codbQpDIHG2C/GeqRW0VXtThN
         jmATa0RD0E3OhPHDI4BBu1HbYbPX4tBrqyXAym//sOuKb/ASoLgdskHEDnNAGc9VA7v6
         yO23YDmr4DX8esJmGoxdRUySX4sCwBFEnQ8KEwaZzwPF0iQlXnGG2QVpgHcAou6I45vz
         RCdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=toCXj+rF+X0RZdW5hDXRNiCqiMJssosKh+NIrdzUtwM=;
        b=L7eUbD9LWvKOphchDdNglZiWaJaGRZh5i3MaoLAgXceANNLbmbv7Ud8a12GnkgY23a
         mhDyliRCTj+qdxY7spA46ueLNopn8sZYw5KXQdgugwbOAt9jz4DbRLensm4epn44qnQ/
         1LJHGIy3kfqj3EFrekUiy26ncH+nOkDDMdgXK3Q+xFjl2f1EO9NBXPDR4p2aunCKIKve
         9+iiZ98NAVrtksDDW4lwPii+/uE1QZlFZy97pP5IP2YuzrU9yCIdge9FJ3+7wtIFYHbX
         rDhPRjo/ckdxDF0+l1VjUoRcs6GuX3xse0Ul0nKqPFoK86lxjPjOmjjT1Wh+RhEmdmmS
         T9SQ==
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
Subject: [PATCH 4.15 03/45] ptr_ring: try vmalloc() when kmalloc() fails
Date: Fri, 23 Feb 2018 19:28:42 +0100
Message-Id: <20180223170715.783010673@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170715.197760019@linuxfoundation.org>
References: <20180223170715.197760019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218760596859413?=
X-GMAIL-MSGID: =?utf-8?q?1593219243880175550?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -451,11 +451,14 @@ static inline int ptr_ring_consume_batch
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
@@ -588,7 +591,7 @@ static inline int ptr_ring_resize(struct
 	spin_unlock(&(r)->producer_lock);
 	spin_unlock_irqrestore(&(r)->consumer_lock, flags);
 
-	kfree(old);
+	kvfree(old);
 
 	return 0;
 }
@@ -628,7 +631,7 @@ static inline int ptr_ring_resize_multip
 	}
 
 	for (i = 0; i < nrings; ++i)
-		kfree(queues[i]);
+		kvfree(queues[i]);
 
 	kfree(queues);
 
@@ -636,7 +639,7 @@ static inline int ptr_ring_resize_multip
 
 nomem:
 	while (--i >= 0)
-		kfree(queues[i]);
+		kvfree(queues[i]);
 
 	kfree(queues);
 
@@ -651,7 +654,7 @@ static inline void ptr_ring_cleanup(stru
 	if (destroy)
 		while ((ptr = ptr_ring_consume(r)))
 			destroy(ptr);
-	kfree(r->queue);
+	kvfree(r->queue);
 }
 
 #endif /* _LINUX_PTR_RING_H  */
