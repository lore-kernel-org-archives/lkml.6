Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519414730-2-5132349427969292177
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
    t=1519414730; b=uhtHIykD15TH2QhXxzTPNRyKjGWZgNhyuTcUUmuTfBKBSDo
    JaAp8Z+F2nCErE7VTBfwElUBQJrCrK7VDOcHVgCgC45Cq6C+1BlOVgZd7OQangt9
    pENi4wN1HRjiWXCqiLLkg3uGuHDwhAob6HXRYCeDS1jg7HuS0w3Vifp3gk2rOvE0
    wcpUzpKMN2xCxruXx6wFh6qTvg3LP73BTFkicxd2L25hLv9URZByMZN4padKrgUe
    UcsSJ30QDkjKb/yu+WgzkQKMgdlLNsYTUBVapIKbb6rYXCsq//ZMj1Dc+5sRz037
    WZNJn64RqHgMTFYonvAF/7xKXms8dAwtm+CgAwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414730; bh=VuR6tsAyx+jq211cOfpDOM8aGr
    TaNn6Sw1tFqiUyDFQ=; b=mGxxzJ7Ypix8nXcBCuyTUQkTapTY2Df5y1dShG6jrj
    Dmx79DV1LfFL9RaSPjdhyFW8S2QXCIhG7oOV+rdTihFs5LkDD0FGNSjWZPV7fSme
    3+3L0oMyCx52qcQbpxTeb+0ctK2Z/B2VHIhtD1yCJEY6qsjf1HJ/V28PGjJel7Yi
    GV2S23/9HB1DxK9leq8KhqkrF2DQZbScahjdMoSeF6G7HG8XyQ1IY8BeVOrcoH2t
    jSnx6JGw40qjeMh8mgxZPALBcKGxjVhLZz8g5IfjecxVvbJmvHtJ+hADTQchlMry
    izIRLdQHWD6v4kT/nZDCI0z/SQ4cqyRPPzIvIzn9i1Xw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934322AbeBWSt5 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:49:57 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45450 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934602AbeBWStw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:49:52 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+dbb7c1161485e61b0241@syzkaller.appspotmail.com,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 002/159] vhost: use mutex_lock_nested() in vhost_dev_lock_vqs()
Date: Fri, 23 Feb 2018 19:25:10 +0100
Message-Id: <20180223170743.355506815@linuxfoundation.org>
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

commit e9cb4239134c860e5f92c75bf5321bd377bb505b upstream.

We used to call mutex_lock() in vhost_dev_lock_vqs() which tries to
hold mutexes of all virtqueues. This may confuse lockdep to report a
possible deadlock because of trying to hold locks belong to same
class. Switch to use mutex_lock_nested() to avoid false positive.

Fixes: 6b1e6cc7855b0 ("vhost: new device IOTLB API")
Reported-by: syzbot+dbb7c1161485e61b0241@syzkaller.appspotmail.com
Signed-off-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/vhost/vhost.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -904,7 +904,7 @@ static void vhost_dev_lock_vqs(struct vh
 {
 	int i = 0;
 	for (i = 0; i < d->nvqs; ++i)
-		mutex_lock(&d->vqs[i]->mutex);
+		mutex_lock_nested(&d->vqs[i]->mutex, i);
 }
 
 static void vhost_dev_unlock_vqs(struct vhost_dev *d)
