Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+7u4qaXg0G6kYc1pOrmhKH31X69m5mTeeYS/LXtjHO2E/K30OnnZZEYyKxHe5jnVAxBYNn
ARC-Seal: i=1; a=rsa-sha256; t=1523399591; cv=none;
        d=google.com; s=arc-20160816;
        b=0IxtIRXhABL3j5P68dxz5IOFvxwq2s/UXuJKP6jqpoKwCQmJpAwqvTacoYbx8zIdfP
         Ro0BEmVXUtBYAHi0KcAvrjs3HMRy5K6MRuRH7eK3hw/STf/xI9FpyYCS/rjW6qEzcfXN
         Ev/3pjVZrmxHWJNPgH/AUCFcNxHoLF4e2emOgD1tl2I1L4zhhhFa8vFO46dM34AD/Tb0
         g0tGkgjRJxBBM4SHS9EwL6BeSMNkIHYDm8WFFCmhRWvMjT5DI7Vy3Tn5355DAa2KxnkO
         QdJfkPhGTR0legGcZUMeUj/baHewIqT88J9wehhPTTKG4VvmjUB3nUL5P7+qVtiWcEIq
         yPzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/0ojZ56ezC7SYymsXbPQiOsnOmNswqG++diV3e7kd9U=;
        b=bzyHBnc3JwTRfvdCs8bV2Wa31PSCXboUs2ci59jWScAsbO/nnkMuZrZRqYMftrB/M7
         zkl4PZUFIPCyx//meYfeSxvjRigobl7JJO2brHWo+a10gQ23UQyOPIFP/anliaZIqK4U
         4CwmLJcDJnI+hPiZM9kKuTM66DbcMxNY5AoLuUHInSKNTavTzp76zvHcnrc7Rt2bB2yg
         j93j23ONaNENd2Bn0NZMCjTqg+xyZZpYO47GxTGg0oXkghhkw5qa4SKQJIa8KoBpLB27
         Ai6n8sOeM80+AUFvNq5kMvWiNY3aETIh/CaMDkBjibMRvDtghz4PhDqaQdOa7jZ719V+
         8izg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+6304bf97ef436580fede@syzkaller.appspotmail.com,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 164/168] vhost: validate log when IOTLB is enabled
Date: Wed, 11 Apr 2018 00:25:06 +0200
Message-Id: <20180410212808.207271433@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400249558780387?=
X-GMAIL-MSGID: =?utf-8?q?1597400249558780387?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Wang <jasowang@redhat.com>


[ Upstream commit d65026c6c62e7d9616c8ceb5a53b68bcdc050525 ]

Vq log_base is the userspace address of bitmap which has nothing to do
with IOTLB. So it needs to be validated unconditionally otherwise we
may try use 0 as log_base which may lead to pin pages that will lead
unexpected result (e.g trigger BUG_ON() in set_bit_to_user()).

Fixes: 6b1e6cc7855b0 ("vhost: new device IOTLB API")
Reported-by: syzbot+6304bf97ef436580fede@syzkaller.appspotmail.com
Signed-off-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vhost/vhost.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1256,14 +1256,12 @@ static int vq_log_access_ok(struct vhost
 /* Caller should have vq mutex and device mutex */
 int vhost_vq_access_ok(struct vhost_virtqueue *vq)
 {
-	if (vq->iotlb) {
-		/* When device IOTLB was used, the access validation
-		 * will be validated during prefetching.
-		 */
-		return 1;
-	}
-	return vq_access_ok(vq, vq->num, vq->desc, vq->avail, vq->used) &&
-		vq_log_access_ok(vq, vq->log_base);
+	int ret = vq_log_access_ok(vq, vq->log_base);
+
+	if (ret || vq->iotlb)
+		return ret;
+
+	return vq_access_ok(vq, vq->num, vq->desc, vq->avail, vq->used);
 }
 EXPORT_SYMBOL_GPL(vhost_vq_access_ok);
 
