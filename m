Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4A5C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33ABF21476
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9/spArl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33ABF21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbeJQBIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:08:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:53236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbeJQBIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:08:32 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4643520866;
        Tue, 16 Oct 2018 17:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710228;
        bh=1hCQq2V50XpBhAGJoiN4JzVJOkRivQT7AniLqv30HMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V9/spArlHTRRiKMl97PQ8j4/mOjOD9P95wXlesNY7JSmR2yPrFBXDAO+Yr6cjeWmY
         +E/7z0LkwbEQRR5hKnqgdRBkKYWc7g7EQjXFn4r+JxJnHQwS3Nmx7ZjYFT0Cml4m/e
         Mij938UjSSLrVD879GVLPPHCfeLxk85DKmeXrufo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Barnhill <0xeffeff@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 011/109] net/ipv6: Display all addresses in output of /proc/net/if_inet6
Date:   Tue, 16 Oct 2018 19:04:39 +0200
Message-Id: <20181016170525.529953682@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
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
@@ -4136,7 +4136,6 @@ static struct inet6_ifaddr *if6_get_firs
 				p++;
 				continue;
 			}
-			state->offset++;
 			return ifa;
 		}
 
@@ -4160,13 +4159,12 @@ static struct inet6_ifaddr *if6_get_next
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


