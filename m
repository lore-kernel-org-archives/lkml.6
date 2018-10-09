Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA7EC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30DF214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="oUDip3cv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F30DF214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbeJIUcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:32:48 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:35298 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbeJIUcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:32:46 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 6348510A1
        for <linux-kernel@vger.kernel.org>; Tue,  9 Oct 2018 13:15:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9Mph6G_qD-ir for <linux-kernel@vger.kernel.org>;
        Tue,  9 Oct 2018 08:15:51 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 3AC22F19
        for <linux-kernel@vger.kernel.org>; Tue,  9 Oct 2018 08:15:51 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id s15-v6so1297450iob.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 06:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=G6GdFpGDi92tAkLEZ9SDpsTjy0DPhqdhrYIdQ0RWPlc=;
        b=oUDip3cvTxxRgOwiSdvtUp7gX4hcBQ4VIdeBhCMHleoEQI4K45rUHMUNaWxSm2WZUF
         G2Ig0rEQQPex9sh4zTo4vC5Ha+VMTrBALRX7AUsMU2tADHZDRVnyjoagcDoWFn2I5afa
         uMeciT+tHQ91ln/0FY5fvLcrvLhTq5wy9z7eBl8u4T31v044D0wI7iFvGZd/sLeAMk9L
         hWSOt4eziXcRmVcTOsox17KveQkYLLzuobl1D0C3GpsNUFxRxXf7LAcGJuGwzNYC/Y5C
         P70v5mbuI/PhQwW6O7rnueOezywwXRYoCcbrYq9HbQB6tNZRkYytNFsPnsLOnYUX+mTb
         oEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G6GdFpGDi92tAkLEZ9SDpsTjy0DPhqdhrYIdQ0RWPlc=;
        b=RjRMhNjwEteQtyS/J0NhwmdEDDkE3co4sL4mkQys7JqDEnjuGU+Q9eMohj0fyRCIiy
         64s3lyhdPqE0WpYZqPdenO0sGhSKMZHQw0VHKmzwNXQwEcT4DImAjpTwSVRoq9jJsptl
         Lov8h38e6gTpBgEMjO+CzWoQWgPwxCU+O5qaCtE4DrwuEKLAUCbvTI/FeRT09WkzACQ/
         rnaNNg0fNcRN+Td0fIyohfXutBCSUaPyHWmNHbSID4ovzA9nxoo5Iq0qR4SSEYLmBFPB
         Dzg/XdsWyBDGMdFQ2qxURNyOfJOYVAe++X+NJo+YNoVJlaHaBon1tQ4rHakFwcMa6y8V
         lYzg==
X-Gm-Message-State: ABuFfoiukeYiDvyHitLkUBBNy9x9pODHPl28dT58PPBTnerQyHeledlm
        tE8S2/U98S7IwTjEEzKKJxCv3Z+8JvAjwChbRIZCrBl+lRqhQtO7rlWko4U1dxuvutvvuQTIhv7
        AUzqKdwtwC/QV8xIrabl2oUzu4M8q
X-Received: by 2002:a02:1e07:: with SMTP id m7-v6mr22157317jad.128.1539090950653;
        Tue, 09 Oct 2018 06:15:50 -0700 (PDT)
X-Google-Smtp-Source: ACcGV62/HvB2NX2I8ESbKMgTYFHM+4lq7NWIYBRHpmJxDTYZwQu5wcGcDCHmY9G8OYUcCEKNfaPQ2A==
X-Received: by 2002:a02:1e07:: with SMTP id m7-v6mr22157290jad.128.1539090950417;
        Tue, 09 Oct 2018 06:15:50 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id j19-v6sm7156782itb.25.2018.10.09.06.15.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 06:15:49 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>, "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Edward Cree <ecree@solarflare.com>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Alan Brady <alan.brady@intel.com>,
        Eugenia Emantayev <eugenia@mellanox.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ethtool: fix a missing-check bug
Date:   Tue,  9 Oct 2018 08:15:38 -0500
Message-Id: <1539090940-5323-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ethtool_get_rxnfc(), the eth command 'cmd' is compared against
'ETHTOOL_GRXFH' to see whether it is necessary to adjust the variable
'info_size'. Then the whole structure of 'info' is copied from the
user-space buffer 'useraddr' with 'info_size' bytes. In the following
execution, 'info' may be copied again from the buffer 'useraddr' depending
on the 'cmd' and the 'info.flow_type'. However, after these two copies,
there is no check between 'cmd' and 'info.cmd'. In fact, 'cmd' is also
copied from the buffer 'useraddr' in dev_ethtool(), which is the caller
function of ethtool_get_rxnfc(). Given that 'useraddr' is in the user
space, a malicious user can race to change the eth command in the buffer
between these copies. By doing so, the attacker can supply inconsistent
data and cause undefined behavior because in the following execution 'info'
will be passed to ops->get_rxnfc().

This patch adds a necessary check on 'info.cmd' and 'cmd' to confirm that
they are still same after the two copies in ethtool_get_rxnfc(). Otherwise,
an error code EINVAL will be returned.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 net/core/ethtool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/ethtool.c b/net/core/ethtool.c
index c9993c6..0136625 100644
--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -1015,6 +1015,9 @@ static noinline_for_stack int ethtool_get_rxnfc(struct net_device *dev,
 			return -EINVAL;
 	}
 
+	if (info.cmd != cmd)
+		return -EINVAL;
+
 	if (info.cmd == ETHTOOL_GRXCLSRLALL) {
 		if (info.rule_cnt > 0) {
 			if (info.rule_cnt <= KMALLOC_MAX_SIZE / sizeof(u32))
-- 
2.7.4

