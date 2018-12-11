Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236CEC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC5420989
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543322;
	bh=1IMkMgZYv2AqH6GoVzHtDqUENGOMIzzaaSqpJOWqzZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hsVYrUogy9QlNE2SSZwUHcRe+7ThNJlGwcNg0oiHKixXVGGUkgRqeqUbE0T3iD1Iz
	 qXHVOPinEmB2Ygq8V4+qwvrV+ucTnLgfecuK18wLo3xBfvp91VBqBiiD1WOqIhiZXR
	 De1bOJV+c+9OWH0w4xNX478OxSScigfw+DgQMOKs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC5420989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbeLKPsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:48:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:36964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728842AbeLKPsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:48:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFC1220870;
        Tue, 11 Dec 2018 15:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543316;
        bh=1IMkMgZYv2AqH6GoVzHtDqUENGOMIzzaaSqpJOWqzZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HEW6+YHm0W6N+V8nVpsSCLPRQfRiieBkMjLzJQ19MTs13SNa4O5Yy0fIRIcK7uB+l
         Oxte9Q1rtSWyn5SoddDe9p2oumLnrR2Dsedqh58idy0plis9+aDANmd5qabLiWvnVV
         UvxZPrp9ay3OcsaJz+FdfkV0HixSl96gEuRy5TGo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Greear <greearb@candelatech.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.4 88/91] mac80211: Clear beacon_int in ieee80211_do_stop
Date:   Tue, 11 Dec 2018 16:41:47 +0100
Message-Id: <20181211151614.100064574@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Greear <greearb@candelatech.com>

commit 5c21e8100dfd57c806e833ae905e26efbb87840f upstream.

This fixes stale beacon-int values that would keep a netdev
from going up.

To reproduce:

Create two VAP on one radio.
vap1 has beacon-int 100, start it.
vap2 has beacon-int 240, start it (and it will fail
  because beacon-int mismatch).
reconfigure vap2 to have beacon-int 100 and start it.
  It will fail because the stale beacon-int 240 will be used
  in the ifup path and hostapd never gets a chance to set the
  new beacon interval.

Cc: stable@vger.kernel.org
Signed-off-by: Ben Greear <greearb@candelatech.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mac80211/iface.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -987,6 +987,8 @@ static void ieee80211_do_stop(struct iee
 	if (local->open_count == 0)
 		ieee80211_clear_tx_pending(local);
 
+	sdata->vif.bss_conf.beacon_int = 0;
+
 	/*
 	 * If the interface goes down while suspended, presumably because
 	 * the device was unplugged and that happens before our resume,


