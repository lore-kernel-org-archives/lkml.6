Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5517C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC4D2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjb8kaR3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC4D2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbeJSCHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:07:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbeJSCHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:07:45 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD9782145D;
        Thu, 18 Oct 2018 18:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885938;
        bh=IGuAMwOeYc98osP9nk//l6Ww9IEMo7+tl3FbUFwMoxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kjb8kaR3gTpiXInu/QKekZpDDKsCTgpB9tEBlNExYDbGZ/1YxdNBPj/39GgoL+1nA
         SoqUdQpr3MEh3FYNtlsCGgOO9vqVz7FWQ/xxf6UsKmKNwuU3RwfgldJRAtpobMyWsQ
         txvOMMPn7IEKV611ytIaYtOSIwnw2brFTYEr6sxY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Barnhill <0xeffeff@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 23/48] net/ipv6: Display all addresses in output of /proc/net/if_inet6
Date:   Thu, 18 Oct 2018 19:54:58 +0200
Message-Id: <20181018175429.251031680@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175427.133690306@linuxfoundation.org>
References: <20181018175427.133690306@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeff Barnhill <0xeffeff@gmail.com>

[ Upstream commit 86f9bd1ff61c413a2a251fa736463295e4e24733 ]

The backend handling for /proc/net/if_inet6 in addrconf.c doesn't properly
handle starting/stopping the iteration.  The problem is that at some point
during the iteration, an overflow is detected and the process is
subsequently stopped.  The item being shown via seq_printf() when the
overflow occurs is not actually shown, though.  When start() is
subsequently called to resume iterating, it returns the next item, and
thus the item that was being processed when the overflow occurred never
gets printed.

Alter the meaning of the private data member "offset".  Currently, when it
is not 0 (which only happens at the very beginning), "offset" represents
the next hlist item to be printed.  After this change, "offset" always
represents the current item.

This is also consistent with the private data member "bucket", which
represents the current bucket, and also the use of "pos" as defined in
seq_file.txt:
    The pos passed to start() will always be either zero, or the most
    recent pos used in the previous session.

Signed-off-by: Jeff Barnhill <0xeffeff@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/addrconf.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3786,7 +3786,6 @@ static struct inet6_ifaddr *if6_get_firs
 				p++;
 				continue;
 			}
-			state->offset++;
 			return ifa;
 		}
 
@@ -3810,13 +3809,12 @@ static struct inet6_ifaddr *if6_get_next
 		return ifa;
 	}
 
+	state->offset = 0;
 	while (++state->bucket < IN6_ADDR_HSIZE) {
-		state->offset = 0;
 		hlist_for_each_entry_rcu_bh(ifa,
 				     &inet6_addr_lst[state->bucket], addr_lst) {
 			if (!net_eq(dev_net(ifa->idev->dev), net))
 				continue;
-			state->offset++;
 			return ifa;
 		}
 	}


