Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968D6C6786F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE652084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePyDwjk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE652084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731372AbeKCEDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:03:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729676AbeKCEDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:03:32 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A36AB2084D;
        Fri,  2 Nov 2018 18:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184916;
        bh=OqIObK9wXhw3ukL2393uL02E++7nY1LIXdTcs6bQm+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ePyDwjk3MsdHuA9UASLP38DS9evsE3DKAUWxGCwVskDEKrME86e8qjtt7cGL7/K77
         PTPRXge4MwinKS4ANPWnJvh6fbEgDUByaY29Mv9Ji7ed6mvMqPNdFl4YMve5nTmhKE
         evT28gz/344KtraNZ4uE28jrqc5veP2/ffq5riv8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 128/143] udp6: fix encap return code for resubmitting
Date:   Fri,  2 Nov 2018 19:35:13 +0100
Message-Id: <20181102182908.089590591@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 84dad55951b0d009372ec21760b650634246e144 ]

The commit eb63f2964dbe ("udp6: add missing checks on edumux packet
processing") used the same return code convention of the ipv4 counterpart,
but ipv6 uses the opposite one: positive values means resubmit.

This change addresses the issue, using positive return value for
resubmitting. Also update the related comment, which was broken, too.

Fixes: eb63f2964dbe ("udp6: add missing checks on edumux packet processing")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/udp.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -794,11 +794,9 @@ static int udp6_unicast_rcv_skb(struct s
 
 	ret = udpv6_queue_rcv_skb(sk, skb);
 
-	/* a return value > 0 means to resubmit the input, but
-	 * it wants the return to be -protocol, or 0
-	 */
+	/* a return value > 0 means to resubmit the input */
 	if (ret > 0)
-		return -ret;
+		return ret;
 	return 0;
 }
 


