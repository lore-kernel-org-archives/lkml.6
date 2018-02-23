Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3684173-1519413487-2-3318251754817505623
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
    t=1519413486; b=qPwYkrKTQuw5JDrSZUjs567jLwSTimvMvBJ3+G4fmTgn5Tr
    77m/e2kgAwaIFXsKTWtDCrc/PUCVg0NVdsychsLu68akAiaQRh/Q4oUYwQC1ymd5
    4sAB5fa5LiHH/nsZHGAgHuZx8rXEVqwdYE4DK3Jv1EEiuWZ5zBx5oguEtGr2Nzvx
    tXX6p72dWgee7J08pt+Z9K2lyEtyz8A/+rhdfeRX2pZPGHYjhUwe8+ZTzxeLYyH0
    FVb20LTQazIQf+aXmOW4b42dPDgJ69IxV31LEi1ZDRFER28zOTsoAQjYfnZU+Ld1
    vgVCCwB2ip9+z+Z8QUvOzIcl6DkcWqT7B3f2E9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413486; bh=zCXED9DAsFvSnveyj1i4/cHPwe
    9t9NGPNCM2iCHO/3U=; b=PBY/1rbgUzG8aMT3KhODrdV3I5cvSbvxT9vCQSek+/
    t6xDkt3zB6FW1dMV+wyanB7vswTbCeEo4JRyj/znWerBcQE/E7PhzUUqXw2sk6WG
    Ezs8GqX+DpxggiASFPz/x2CTX0mtOVswo4/9+UHCNfjNbDg5t2J5mBRwYxo79u56
    dvxsd6yTyZM+0v+RN280obzFRFcA0oICTqzxi/4hCVSzMhOFQ66GVA7BaxDaR3yo
    j3EAugme0Jf2hnBYBiBygZYaS0kHozqscn3jwmXMAzJlM4Ox5088dAsof9BCB8ut
    t/Ug+hYAadIzk1bitN80ZAq+HQWL650vRKY85lNxUoGQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965011AbeBWSyu (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:54:50 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47938 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965010AbeBWSyt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:54:49 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunjian Wang <wangyunjian@huawei.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 122/159] virtio_net: fix return value check in receive_mergeable()
Date: Fri, 23 Feb 2018 19:27:10 +0100
Message-Id: <20180223170758.030455053@linuxfoundation.org>
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

From: Yunjian Wang <wangyunjian@huawei.com>


[ Upstream commit 03e9f8a05bce7330bcd9c5cc54c8e42d0fcbf993 ]

The function virtqueue_get_buf_ctx() could return NULL, the return
value 'buf' need to be checked with NULL, not value 'ctx'.

Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -714,7 +714,7 @@ static struct sk_buff *receive_mergeable
 		int num_skb_frags;
 
 		buf = virtqueue_get_buf_ctx(rq->vq, &len, &ctx);
-		if (unlikely(!ctx)) {
+		if (unlikely(!buf)) {
 			pr_debug("%s: rx error: %d buffers out of %d missing\n",
 				 dev->name, num_buf,
 				 virtio16_to_cpu(vi->vdev,
