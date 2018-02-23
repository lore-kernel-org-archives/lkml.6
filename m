Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3775223-1519416583-2-14576838098945664141
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
    t=1519416583; b=jt8Q/HcRGXfFZjhV5rSiCyrRyKwZ2FQ5IOXmP8jJaJhrewf
    cU2r/AUPaOBKtP+C3TFt+yMnevUsQsB8UegyFRapfeCbxcD+b7359bHJgKYLtR9a
    Vxtwx0mme4/5IUliolsvamgJL4+WYxGypPkU8GQ+U+aKcy/tSumUOqq+w+KAsmEC
    btzxvjlGiuWMIWuQwLXxpdXmeTZ5rcIVQkqbEL68airsmgzdxtay3Vac2qQu6q1F
    tYcrmVXpjRLH8PBVVzP+Q+n9ggVXW4dgBTerAlCbBseffA0sevtE0oDUa97f8r08
    mpiokuaCMV9WL16A9bdGa85p59nV+INehW6lylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519416583; bh=p387Tl2DusS+jDDv4ikG1xuIVG
    f1VvXFcYOFZdBT5wg=; b=OlaVHXfq+ea+iEsWGy1BXCtDWniHKCtuLNrxzWrYKc
    p9etDN9k/g5YZyg/ZRz90uN00UXewr9lNuBZPmGxuTG8bwZsNlmXDeMH1dGb2+Dd
    HYAzBIZDO21i/CiHKKWK6mh1mJboE+9Z8ZInwn/DCrilsbZ8kh6Qu1oQxdjLFJL+
    SuYBP1nSfa1TKbl2HKhWTheMHIeBJvNpmSCj/szNgLUwBCIAGE7WG7gOaUOKNe68
    aI/Tol6Ki3kRW7uNAB2j0DG0J4kLtAU3CZwCYIxXr37gyGgd+V5Ynr3hSGM/0hSy
    y7xVENyU7oXj3e32WnlUaEXISjuI+otdM4zglWM09J5g==
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
        id S932614AbeBWSmS (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:42:18 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41442 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932515AbeBWSmQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:42:16 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+dbb7c1161485e61b0241@syzkaller.appspotmail.com,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 001/145] vhost: use mutex_lock_nested() in vhost_dev_lock_vqs()
Date: Fri, 23 Feb 2018 19:25:07 +0100
Message-Id: <20180223170724.846027079@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
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
@@ -849,7 +849,7 @@ static void vhost_dev_lock_vqs(struct vh
 {
 	int i = 0;
 	for (i = 0; i < d->nvqs; ++i)
-		mutex_lock(&d->vqs[i]->mutex);
+		mutex_lock_nested(&d->vqs[i]->mutex, i);
 }
 
 static void vhost_dev_unlock_vqs(struct vhost_dev *d)
