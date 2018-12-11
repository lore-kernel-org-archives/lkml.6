Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43421C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA6620870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543090;
	bh=uwwXRYwthtTbN4KdYGqmNXx4ycYmO3gN/Ot2LupCw3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OgbqImGmohNTjtk5UuovpMHKSP9RDTP7VQ4wk8Sqv7yB5pXZOPEU1nANjKpADJ1o/
	 iECnlKvjxB3Mb6TI6N8q/0GMiaDtzVh/G/hsjUmHSAe/AbtvOOtBXWl6CO3CvnMxV4
	 hYC0PQw97nDYe8oJh7WqXLi3rJL6Sj2nj3M2Rh7U=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AA6620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeLKPot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:44:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:33064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727394AbeLKPon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:44:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D165620855;
        Tue, 11 Dec 2018 15:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543082;
        bh=uwwXRYwthtTbN4KdYGqmNXx4ycYmO3gN/Ot2LupCw3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P+JrsxebRwMU92VRm7lGwt8b8UcI8A+PwUYdXqGfGKidEoVscWfsK6FUYiiTCrZcW
         GNO9iIeZrQVoy+zzWlwswwGK7W+oK5Jyp5kcauhWpePf/yAVCw+/FY+mVTGu3K0/tk
         OJ+OKQrBCFz6LCvMIRSKfQf4cEOdPMZCVIYb38Ig=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Greear <greearb@candelatech.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3.18 53/54] mac80211: Clear beacon_int in ieee80211_do_stop
Date:   Tue, 11 Dec 2018 16:41:41 +0100
Message-Id: <20181211151549.040520968@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151546.010073210@linuxfoundation.org>
References: <20181211151546.010073210@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -958,6 +958,8 @@ static void ieee80211_do_stop(struct iee
 	if (local->open_count == 0)
 		ieee80211_clear_tx_pending(local);
 
+	sdata->vif.bss_conf.beacon_int = 0;
+
 	/*
 	 * If the interface goes down while suspended, presumably because
 	 * the device was unplugged and that happens before our resume,


