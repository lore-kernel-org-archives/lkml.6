Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3328118-1521215593-2-10414561465381425393
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521215592; b=H1ApLbnh1pBWYvUAm/UjaQ82Ni/3lgvasf9i+KAOLdnqZ2I
    Kqd4Y9+aido1TYo9b3YZ+ZGEnOM6+EwzfGEEa6z+RF/rzTdIG7VMSYvtNc5MOYJp
    ZgDoWAZZOr+mwP9yYhfr3GTP5LxR3tnBFonzMqYV68M7rlhmTZ/lq/kp2F/fAHTg
    2uPGkNRT8iHnqbnfN498LaW/QYJ81SSTKUo/rbPiVfj+d9y3AxwBDEK8G9Cxm2VV
    SICNa7hrBaV+6HOc5JMQ/RZ3eM865njne7BV9aBMFOx937EURl1EppHqSxmLa+xC
    QHJqkIL9bY1DCkdqRSUYrjLe1HTUhaeuecUroAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521215592; bh=ydPwZC476Y9xlbVr5OAQTH5qdy
    5nf2lwnBCpydZWm10=; b=fg8mHQoCmXfLXq9KIcc2clqlXTxLL2z2ZZH5MuJjQ4
    2k2cdWJ+Pa/lr+RwTht8h+N8QmO74rHnHpyx8ow1rXycPExb5MyGrmS3NEYkXSCM
    TtYAS3xaVOhQ3o52QpaT//x9Xw0zgy/r4NxLsWH28F/wPCnfiABfOSi6jJ17wzv8
    qzEX1Ly4HDp+W0fiAN6qe5/NIIj7+JCGB2zE7+3mWsyGCadEXLWz4g/xLe1e0tmP
    I4UjcfdfLqoDc6xr1y+sadhWn9lixlOsuGlPxI3YF9z94IJlP7Hnh6oB/XsPZ41o
    NSasoGV/098+WNHp96yqO6W+fwOwZBD3ARVYqSBgp75Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965369AbeCPPoL (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:44:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45852 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965364AbeCPPoI (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:44:08 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 108/128] virtio_net: Disable interrupts if napi_complete_done rescheduled napi
Date: Fri, 16 Mar 2018 16:24:09 +0100
Message-Id: <20180316152341.923418133@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>


[ Upstream commit fdaa767aefc1685f9a41e91f447c9aea94103df6 ]

Since commit 39e6c8208d7b ("net: solve a NAPI race") napi has been able
to be rescheduled within napi_complete_done() even in non-busypoll case,
but virtnet_poll() always enabled interrupts before complete, and when
napi was rescheduled within napi_complete_done() it did not disable
interrupts.
This caused more interrupts when event idx is disabled.

According to commit cbdadbbf0c79 ("virtio_net: fix race in RX VQ
processing") we cannot place virtqueue_enable_cb_prepare() after
NAPI_STATE_SCHED is cleared, so disable interrupts again if
napi_complete_done() returned false.

Tested with vhost-user of OVS 2.7 on host, which does not have the event
idx feature.

* Before patch:

$ netperf -t UDP_STREAM -H 192.168.150.253 -l 60 -- -m 1472
MIGRATED UDP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 192.168.150.253 () port 0 AF_INET
Socket  Message  Elapsed      Messages
Size    Size     Time         Okay Errors   Throughput
bytes   bytes    secs            #      #   10^6bits/sec

212992    1472   60.00     32763206      0    6430.32
212992           60.00     23384299           4589.56

Interrupts on guest: 9872369
Packets/interrupt:   2.37

* After patch

$ netperf -t UDP_STREAM -H 192.168.150.253 -l 60 -- -m 1472
MIGRATED UDP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 192.168.150.253 () port 0 AF_INET
Socket  Message  Elapsed      Messages
Size    Size     Time         Okay Errors   Throughput
bytes   bytes    secs            #      #   10^6bits/sec

212992    1472   60.00     32794646      0    6436.49
212992           60.00     32793501           6436.27

Interrupts on guest: 4941299
Packets/interrupt:   6.64

Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -261,9 +261,12 @@ static void virtqueue_napi_complete(stru
 	int opaque;
 
 	opaque = virtqueue_enable_cb_prepare(vq);
-	if (napi_complete_done(napi, processed) &&
-	    unlikely(virtqueue_poll(vq, opaque)))
-		virtqueue_napi_schedule(napi, vq);
+	if (napi_complete_done(napi, processed)) {
+		if (unlikely(virtqueue_poll(vq, opaque)))
+			virtqueue_napi_schedule(napi, vq);
+	} else {
+		virtqueue_disable_cb(vq);
+	}
 }
 
 static void skb_xmit_done(struct virtqueue *vq)
