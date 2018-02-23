Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519414704-2-15902395542763868055
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519414704; b=M731XGvC6+H6VMaykJus9p6zUUhWlpfA+Hmk3G/zil7Khu/
    Mzur1sC3sDW5xseglsI7EzQq1nrMj9xq87TKHqWUpuT8qyhKEn6DqSJkTe/NuglR
    zFYeEdEOmAT8LGqTeoNm6X2RsLQkXsgSJ8Ka/u0nA3N9bAB/FYdYvK8v1cF4bIE/
    ZSgDx9/wN8FOZaNS9GmJKEiyniRK7JUv9zibOO9CuLcsv276zB46y7SEUA7vzXme
    Gqxf/8o46xCRHEVbehlEDHDbWMVU1UcY4ncudTqc1UgnVnFB9WLeB0bc23vKC0pq
    7xNppLvh1whW3bGQG8QNKYsfqT3rBozK6BY04Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414704; bh=1EcMNvvYSypI0PqS9DDwWxyo6v
    h5asN3T3LF0quZI0I=; b=gHc625jtaZ6+nLV36rWS0MqCMAluqx3cq/eN9yEyPg
    f3wPu3M31A0APSwH/XAgIo9ybu2v3xlQnIVjkaIBCeBuS+myJxjxQMubVwfqAk9X
    V4IMft5jykqkHvf8jUCj40hW5smVD6XUGUV8K0vtTf2LYA/cyUo5KjvtyT5B5Qh5
    vXqG4ZASDlTQ146bPUaPNzlHtA5LFBPKfjsAW8dHtmOpUF0j3wdjKfdKAckajKKR
    90xLJnEvFqq1aGinMYlq2T0EQoTE4LCo1Db1IVVFzHrSxleXDICzr6wkbMOceW8e
    BC1T06xFbB7P47ONeUo3oVJ371OPFqP9EaWolWEvfkbQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934413AbeBWSuK (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:50:10 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45518 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934662AbeBWSuI (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:50:08 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+e4d4f9ddd4295539735d@syzkaller.appspotmail.com,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 024/159] ptr_ring: fail early if queue occupies more than KMALLOC_MAX_SIZE
Date: Fri, 23 Feb 2018 19:25:32 +0100
Message-Id: <20180223170746.103599233@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Wang <jasowang@redhat.com>

commit 6e6e41c3112276288ccaf80c70916779b84bb276 upstream.

To avoid slab to warn about exceeded size, fail early if queue
occupies more than KMALLOC_MAX_SIZE.

Reported-by: syzbot+e4d4f9ddd4295539735d@syzkaller.appspotmail.com
Fixes: 2e0ab8ca83c12 ("ptr_ring: array based FIFO for pointers")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/ptr_ring.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -447,6 +447,8 @@ static inline int ptr_ring_consume_batch
 
 static inline void **__ptr_ring_init_queue_alloc(unsigned int size, gfp_t gfp)
 {
+	if (size * sizeof(void *) > KMALLOC_MAX_SIZE)
+		return NULL;
 	return kcalloc(size, sizeof(void *), gfp);
 }
 
