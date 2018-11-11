Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E26C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67AE82080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67AE82080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731630AbeKLF5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:57:42 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52260 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730868AbeKLF5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:57:41 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt0-0000l8-Nm; Sun, 11 Nov 2018 19:59:10 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsS-0001YK-C4; Sun, 11 Nov 2018 19:58:36 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, b.a.t.m.a.n@lists.open-mesh.org,
        "Sven Eckelmann" <sven@narfation.org>,
        "Marcel Schmidt" <ff.z-casparistrasse@mailbox.org>,
        "Johannes Berg" <johannes@sipsolutions.net>,
        "Thomas Lauer" <holminateur@gmail.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.539889814@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 142/366] cfg80211: initialize sinfo in
 cfg80211_get_station
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

commit 3c12d0486856b9eb89c2a9ac336713cba90813e3 upstream.

Most of the implementations behind cfg80211_get_station will not initialize
sinfo to zero before manipulating it. For example, the member "filled",
which indicates the filled in parts of this struct, is often only modified
by enabling certain bits in the bitfield while keeping the remaining bits
in their original state. A caller without a preinitialized sinfo.filled can
then no longer decide which parts of sinfo were filled in by
cfg80211_get_station (or actually the underlying implementations).

cfg80211_get_station must therefore take care that sinfo is initialized to
zero. Otherwise, the caller may tries to read information which was not
filled in and which must therefore also be considered uninitialized. In
batadv_v_elp_get_throughput's case, an invalid "random" expected throughput
may be stored for this neighbor and thus the B.A.T.M.A.N V algorithm may
switch to non-optimal neighbors for certain destinations.

Fixes: 7406353d43c8 ("cfg80211: implement cfg80211_get_station cfg80211 API")
Reported-by: Thomas Lauer <holminateur@gmail.com>
Reported-by: Marcel Schmidt <ff.z-casparistrasse@mailbox.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/wireless/util.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1566,6 +1566,8 @@ int cfg80211_get_station(struct net_devi
 	if (!rdev->ops->get_station)
 		return -EOPNOTSUPP;
 
+	memset(sinfo, 0, sizeof(*sinfo));
+
 	return rdev_get_station(rdev, dev, mac_addr, sinfo);
 }
 EXPORT_SYMBOL(cfg80211_get_station);

