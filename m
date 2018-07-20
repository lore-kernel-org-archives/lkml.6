Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D37ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B1F206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B1F206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389455AbeGTN0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:26:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47072 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388584AbeGTN0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:26:38 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 517CEC9F;
        Fri, 20 Jul 2018 12:34:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+7b9ed9872dab8c32305d@syzkaller.appspotmail.com,
        Willem de Bruijn <willemb@google.com>,
        Jiri Benc <jbenc@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 65/92] nsh: set mac len based on inner packet
Date:   Fri, 20 Jul 2018 14:14:09 +0200
Message-Id: <20180720121421.552861706@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121417.206337808@linuxfoundation.org>
References: <20180720121417.206337808@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willem de Bruijn <willemb@google.com>

commit bab2c80e5a6c855657482eac9e97f5f3eedb509a upstream.

When pulling the NSH header in nsh_gso_segment, set the mac length
based on the encapsulated packet type.

skb_reset_mac_len computes an offset to the network header, which
here still points to the outer packet:

  >     skb_reset_network_header(skb);
  >     [...]
  >     __skb_pull(skb, nsh_len);
  >     skb_reset_mac_header(skb);    // now mac hdr starts nsh_len == 8B after net hdr
  >     skb_reset_mac_len(skb);       // mac len = net hdr - mac hdr == (u16) -8 == 65528
  >     [..]
  >     skb_mac_gso_segment(skb, ..)

Link: http://lkml.kernel.org/r/CAF=yD-KeAcTSOn4AxirAxL8m7QAS8GBBe1w09eziYwvPbbUeYA@mail.gmail.com
Reported-by: syzbot+7b9ed9872dab8c32305d@syzkaller.appspotmail.com
Fixes: c411ed854584 ("nsh: add GSO support")
Signed-off-by: Willem de Bruijn <willemb@google.com>
Acked-by: Jiri Benc <jbenc@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/nsh/nsh.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/nsh/nsh.c
+++ b/net/nsh/nsh.c
@@ -42,7 +42,7 @@ static struct sk_buff *nsh_gso_segment(s
 	__skb_pull(skb, nsh_len);
 
 	skb_reset_mac_header(skb);
-	skb_reset_mac_len(skb);
+	skb->mac_len = proto == htons(ETH_P_TEB) ? ETH_HLEN : 0;
 	skb->protocol = proto;
 
 	features &= NETIF_F_SG;


