Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1427278-1518184621-2-1386229316689394332
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518184620; b=gbv8tvnLIvfoE2H/eo82R986McJnkbj8c+RippEEie8ld89
    5Nb8El31xU1UGuN+A939zWumu9SqL74Rq78aruQ0sHJFBxyBcuxjxm0KcZMF1o5S
    WGEWHsVMc4sCbAud4VBlbFZKLUxyx8orMU5T0gR/KpZUFVjeutJqF23qfw3/ALXg
    StWVTa6T0FBE2nrUr3eUmNXk6o6mAoHynfmW/cd2ucaaecxyhuOu3woSJLCZRjrB
    BNU1xl+NEVZpfSBaFvsZ+ncMCVCDJXXcf5UgH66VD4koDMK0qo60Nv9G0A64Q/Yr
    lgBZYzJxe4XM0TqwmAQiY4AKaZmm8H72Sj3W4hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184620; bh=m6LNs2srpzOrVEG8OEW8kMSB1q
    HuYoG9Vcd1ggroqqk=; b=NDB5qTi4TYO5EzpvGMK/PFe8AAhc+S5jyOqIW0JHJD
    qP97CDjrukVylbMHDRIAHn2By1hkC3zeQ+wID5ZUPUl6NgOLfnPTwyxq+Z1o3e7o
    GO3lRuDeEyo/D4QgNyeoYqBFxISQOvqmw9NfsBIxRF4UpalnhCCPLGiQrp5i+doD
    yedAO3yl58TkNtbNe5aLDV+w449gY0U3gb9NNDmrf7zuZN4Yz69DQTa3KpJbauq5
    +F51d8JnF0SAFBGPWAtssTxCrzgBy5Awyt2ocXYy8tP7tQf37nEXnsb8sbV+zvYM
    Jgcsnrhf5L30t5QCndgPh2LBpQPlWQbUjGX3b28pTs/A==
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
        id S1753614AbeBIN4s (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:56:48 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51662 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753058AbeBINpB (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:45:01 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+eb17c6162478cc50632c@syzkaller.appspotmail.com,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 10/22] vhost_net: stop device during reset owner
Date: Fri,  9 Feb 2018 14:39:59 +0100
Message-Id: <20180209133934.805941111@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133934.024795822@linuxfoundation.org>
References: <20180209133934.024795822@linuxfoundation.org>
User-Agent: quilt/0.65
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


[ Upstream commit 4cd879515d686849eec5f718aeac62a70b067d82 ]

We don't stop device before reset owner, this means we could try to
serve any virtqueue kick before reset dev->worker. This will result a
warn since the work was pending at llist during owner resetting. Fix
this by stopping device during owner reset.

Reported-by: syzbot+eb17c6162478cc50632c@syzkaller.appspotmail.com
Fixes: 3a4d5c94e9593 ("vhost_net: a kernel-level virtio server")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vhost/net.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1212,6 +1212,7 @@ static long vhost_net_reset_owner(struct
 	}
 	vhost_net_stop(n, &tx_sock, &rx_sock);
 	vhost_net_flush(n);
+	vhost_dev_stop(&n->dev);
 	vhost_dev_reset_owner(&n->dev, umem);
 	vhost_net_vq_reset(n);
 done:
