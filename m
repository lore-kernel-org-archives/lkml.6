Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FB6C677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004DA2064A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rc90iIFJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 004DA2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbeJIB7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:59:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbeJIB7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:59:13 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE7722064A;
        Mon,  8 Oct 2018 18:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024367;
        bh=CNQqPVLaAzNc/y6r86HbUERgvUq8uQm94vmTnjZhs2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rc90iIFJbj+dtGwKnH+gbpjKeVvZGB7gKrJWuQowz+pFOiBcY0zYnNHcuemk9xGMP
         +VbMU6Ee5WvIwZfhoZN0OaXU+9B38i+ZPBxl9baTfGCSUL0yoOLEe7iSQMnnquDSXV
         RCiDSfeTA0i/hmiqYrkpiwLMcvmUrtzC5GiattCg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jinbum Park <jinb.park7@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 018/168] mac80211_hwsim: Fix possible Spectre-v1 for hwsim_world_regdom_custom
Date:   Mon,  8 Oct 2018 20:29:58 +0200
Message-Id: <20181008175620.744522583@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
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

From: Jinbum Park <jinb.park7@gmail.com>

[ Upstream commit 3a2af7cccbbaf2362db9053a946a6084e12bfa73 ]

User controls @idx which to be used as index of hwsim_world_regdom_custom.
So, It can be exploited via Spectre-like attack. (speculative execution)

This kind of attack leaks address of hwsim_world_regdom_custom,
It leads an attacker to bypass security mechanism such as KASLR.

So sanitize @idx before using it to prevent attack.

I leveraged strategy [1] to find and exploit this gadget.

[1] https://github.com/jinb-park/linux-exploit/tree/master/exploit-remaining-spectre-gadget/

Signed-off-by: Jinbum Park <jinb.park7@gmail.com>
[johannes: unwrap URL]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mac80211_hwsim.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -33,6 +33,7 @@
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
 #include <linux/rhashtable.h>
+#include <linux/nospec.h>
 #include "mac80211_hwsim.h"
 
 #define WARN_QUEUE 100
@@ -3229,6 +3230,9 @@ static int hwsim_new_radio_nl(struct sk_
 			kfree(hwname);
 			return -EINVAL;
 		}
+
+		idx = array_index_nospec(idx,
+					 ARRAY_SIZE(hwsim_world_regdom_custom));
 		param.regd = hwsim_world_regdom_custom[idx];
 	}
 


