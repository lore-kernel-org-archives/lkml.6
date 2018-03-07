Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4098462-1520452025-2-2539604669921827276
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endafr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520452025; b=tiNtUuAFvTZ/s/PLU9v3LO1qsPRH9hZDT6yCryPy2WV3TCC
    1FZGDAopS0osN393l+livHJPoVVEsxQbuIwq7WnAkPDH23jFyIxeVCP9G8XZla81
    P8tdZyQbMayVnvVCyL/uaQLLRCCq+jxgUbrGx0RV6uqCumR7LxBfi6yoEK5Ee/UD
    1MgLcTOumI/MGM6ZmTrMHIHMhae9hBXoi7g/CE1N8OmL/2ozZ53/LM2W+ATwRjLB
    2Y8qu7OH2xJPlWII82ms4RJnfHgs5UvUcgKBDQU95X7hjfi5cqQ0EzNWmfw4PTcu
    QfUAK4tYj9drX3c7YAXX3XJwLo6eaULjx4UeGsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520452025; bh=hbf4e03Snw1joiP9+JkX2+O8Vj
    5F3tK18B6MRR7rnv0=; b=J/Z5PaGnkiMsVCw9hrjTqvwFFFLZX59UZj6S+OvlI5
    YaLzKN3I5e/edqEnVFVi31TIT1Bzzl33P1DSPBoXTKe/NRCNtKOqAF4KFmfUBRpW
    pYQFfmL8VylNCIuT7Cad5Huv7T9E9UUxZBw9WMHjy6auAZJKCH+rcUavg5yvihFm
    ++8Qv1pVTGb2GgEuxbFi1JkzVR3KAdOurBwP9SsPFyhEqEwL5WjV/061nQPbOKwY
    NThG1BS3efDn8+D5/9/0La5IrQNl+Uduxd8fgSQjlNywPcdFTdISE5zU0umIGKKd
    8+CcvB8Q/9G4P6TErZ2VEaveo+rtT8it1XQO8NpsQ4Og==
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
        id S965628AbeCGTq6 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:46:58 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44832 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754916AbeCGTq5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:46:57 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 074/110] virtio-net: disable NAPI only when enabled during XDP set
Date: Wed,  7 Mar 2018 11:38:57 -0800
Message-Id: <20180307191049.130846330@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
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


[ Upstream commit 4e09ff5362843dff3accfa84c805c7f3a99de9cd ]

We try to disable NAPI to prevent a single XDP TX queue being used by
multiple cpus. But we don't check if device is up (NAPI is enabled),
this could result stall because of infinite wait in
napi_disable(). Fixing this by checking device state through
netif_running() before.

Fixes: 4941d472bf95b ("virtio-net: do not reset during XDP set")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1995,8 +1995,9 @@ static int virtnet_xdp_set(struct net_de
 	}
 
 	/* Make sure NAPI is not using any XDP TX queues for RX. */
-	for (i = 0; i < vi->max_queue_pairs; i++)
-		napi_disable(&vi->rq[i].napi);
+	if (netif_running(dev))
+		for (i = 0; i < vi->max_queue_pairs; i++)
+			napi_disable(&vi->rq[i].napi);
 
 	netif_set_real_num_rx_queues(dev, curr_qp + xdp_qp);
 	err = _virtnet_set_queues(vi, curr_qp + xdp_qp);
@@ -2015,7 +2016,8 @@ static int virtnet_xdp_set(struct net_de
 		}
 		if (old_prog)
 			bpf_prog_put(old_prog);
-		virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
+		if (netif_running(dev))
+			virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
 	}
 
 	return 0;
