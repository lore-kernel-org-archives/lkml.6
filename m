Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3641323-1519411362-2-13796905592169927056
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519411362; b=mQ11/8/3YWfCJB7OOE0wdFpSfxXSJZ2RHQa37mrWsDpI/bF
    gdIdquWwrpLv07VFQN7bstyK43JndLgpCr1qMcbM37LC5HAGSJyTIiAq4tclJhIK
    Jy5DsA+UmpKbagpeL+BzeY788kxl7lD+J483gCRF98fMpSMKk2Ym/m5XQ1ggAB5Q
    EUU8O4c31g5/6ZJygFoOEnnaZySFn0Mqo0ssr1av5wlP/TM3P37oRsRLSYvBVSQd
    /+QEtpGBTOycjyaJqyy3+rwxxyhkqPUNbMVFxzC22wqmycCPEYMsLL6rmszxspdI
    1HVAIKkmzMv52MVrm8xmSQM6u0HLVxi1+4gPqRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519411362; bh=l/6tm4U/mfV/GwdY9onGqcSLfI
    DJcrEhr4GKSkqedvQ=; b=q8M7vOEwUgmYZoaDzM0MZwejWeeKoBisIIhpRJ3kpR
    rzYXg4CMnekKP7uDLlJN3VT8wR10iDmakt+rC5J2bD6ztjnfcmZxW1XKjz9Ua5mh
    HwOThAbCkQLOsR/ixcPpSUiaY4+eV9dGgwb5Myko4/KryGWew93TQVzQeluWzmDB
    ibCy+NsGCi+5uRu4ZCCgAe1qCTEj5TlGzNh3wlq857nJt+5AMtty3jEN0HQyTpWq
    nyyRIR5dTvIFHikIE7ObF9aqTR5hGwpHQQvuKemj9CPcwxIlLbSxLbKF5UKzUJbl
    VNqY04f1ql80ZvWIJ13D9QWM/IedOmij2N2kVfeEqgmg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933049AbeBWSm2 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:42:28 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41518 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932515AbeBWSm0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:42:26 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+e4d4f9ddd4295539735d@syzkaller.appspotmail.com,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 012/145] ptr_ring: fail early if queue occupies more than KMALLOC_MAX_SIZE
Date: Fri, 23 Feb 2018 19:25:18 +0100
Message-Id: <20180223170726.257211330@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -351,6 +351,8 @@ static inline void *ptr_ring_consume_bh(
 
 static inline void **__ptr_ring_init_queue_alloc(unsigned int size, gfp_t gfp)
 {
+	if (size * sizeof(void *) > KMALLOC_MAX_SIZE)
+		return NULL;
 	return kcalloc(size, sizeof(void *), gfp);
 }
 
