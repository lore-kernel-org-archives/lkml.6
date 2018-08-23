Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053AEC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD23E208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD23E208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388664AbeHWMbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:31:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55946 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728887AbeHWMbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:31:53 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3411BC83;
        Thu, 23 Aug 2018 09:03:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Allen <jallen@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 272/324] ibmvnic: Fix error recovery on login failure
Date:   Thu, 23 Aug 2018 09:55:38 +0200
Message-Id: <20180823075009.563324727@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Allen <jallen@linux.ibm.com>

[ Upstream commit 3578a7ecb69920efc3885dbd610e98c00dbdf5db ]

Testing has uncovered a failure case that is not handled properly. In the
event that a login fails and we are not able to recover on the spot, we
return 0 from do_reset, preventing any error recovery code from being
triggered.  Additionally, the state is set to "probed" meaning that when we
are able to trigger the error recovery, the driver always comes up in the
probed state. To handle the case properly, we need to return a failure code
here and set the adapter state to the state that we entered the reset in
indicating the state that we would like to come out of the recovery reset
in.

Signed-off-by: John Allen <jallen@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1801,8 +1801,8 @@ static int do_reset(struct ibmvnic_adapt
 
 		rc = ibmvnic_login(netdev);
 		if (rc) {
-			adapter->state = VNIC_PROBED;
-			return 0;
+			adapter->state = reset_state;
+			return rc;
 		}
 
 		if (adapter->reset_reason == VNIC_RESET_CHANGE_PARAM ||


