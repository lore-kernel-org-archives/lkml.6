Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01764C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD05521104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3aZBq38"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD05521104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387861AbeKTDHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:07:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:41278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732866AbeKTDHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:07:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1280E2145D;
        Mon, 19 Nov 2018 16:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645783;
        bh=/ANQPiThJ1R8A7Q3oHWYHN1GYQDGsoK53owWsS5PeGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k3aZBq38nL5FG58P9jhPKgqIUUEx6T17QYcd27cpu1YJMCB/y5qoXtspMe2xemGDU
         vdxCK5EClRPecE3OopwM+JhjU642hCA2awdpki+sxfhMfgxLrU+Bbv/gsImItsJKms
         fMfqLn1RqH2hfzt9fM8H70oqCTfMzeUjq5DC9cK8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mahesh Bandewar <maheshb@google.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Jarod Wilson <jarod@redhat.com>
Subject: [PATCH 4.18 088/171] bonding/802.3ad: fix link_failure_count tracking
Date:   Mon, 19 Nov 2018 17:28:04 +0100
Message-Id: <20181119162633.379114103@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jarod Wilson <jarod@redhat.com>

commit ea53abfab960909d622ca37bcfb8e1c5378d21cc upstream.

Commit 4d2c0cda07448ea6980f00102dc3964eb25e241c set slave->link to
BOND_LINK_DOWN for 802.3ad bonds whenever invalid speed/duplex values
were read, to fix a problem with slaves getting into weird states, but
in the process, broke tracking of link failures, as going straight to
BOND_LINK_DOWN when a link is indeed down (cable pulled, switch rebooted)
means we broke out of bond_miimon_inspect()'s BOND_LINK_DOWN case because
!link_state was already true, we never incremented commit, and never got
a chance to call bond_miimon_commit(), where slave->link_failure_count
would be incremented. I believe the simple fix here is to mark the slave
as BOND_LINK_FAIL, and let bond_miimon_inspect() transition the link from
_FAIL to either _UP or _DOWN, and in the latter case, we now get proper
incrementing of link_failure_count again.

Fixes: 4d2c0cda0744 ("bonding: speed/duplex update at NETDEV_UP event")
CC: Mahesh Bandewar <maheshb@google.com>
CC: David S. Miller <davem@davemloft.net>
CC: netdev@vger.kernel.org
CC: stable@vger.kernel.org
Signed-off-by: Jarod Wilson <jarod@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/bonding/bond_main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3118,13 +3118,13 @@ static int bond_slave_netdev_event(unsig
 	case NETDEV_CHANGE:
 		/* For 802.3ad mode only:
 		 * Getting invalid Speed/Duplex values here will put slave
-		 * in weird state. So mark it as link-down for the time
+		 * in weird state. So mark it as link-fail for the time
 		 * being and let link-monitoring (miimon) set it right when
 		 * correct speeds/duplex are available.
 		 */
 		if (bond_update_speed_duplex(slave) &&
 		    BOND_MODE(bond) == BOND_MODE_8023AD)
-			slave->link = BOND_LINK_DOWN;
+			slave->link = BOND_LINK_FAIL;
 
 		if (BOND_MODE(bond) == BOND_MODE_8023AD)
 			bond_3ad_adapter_speed_duplex_changed(slave);


