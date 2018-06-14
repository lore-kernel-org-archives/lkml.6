Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 47836C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 04:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2FA20864
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 04:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sZXwdrTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2FA20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751868AbeFNEO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 00:14:59 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:38475 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeFNEO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 00:14:56 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20180614041454epoutp04b1a9f98667754325951ce803de339c1a~366WSfGGk2587325873epoutp04Z;
        Thu, 14 Jun 2018 04:14:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180614041454epoutp04b1a9f98667754325951ce803de339c1a~366WSfGGk2587325873epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1528949694;
        bh=qODHG7THtt8VsCkKr3lpRZq4IXGEyDMn+LeWJfuXLiQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=sZXwdrTQ+uUSlbDF2y196gKbxcsftm93scZ2N3/V19mEz166w3nUHt8nL5ZlRSP1t
         ZaXfspaxiO+qvwq2t0odMsaulhAW/HQ1ovD2+B7UnrwTFxwnxVMRpIvxoE0BoS+E04
         aNe7a+7j2+NNAe/GqmRcA8AcnYAKrAQUzN6XUBxg=
Received: from epsmges2p1.samsung.com (unknown [182.195.40.155]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20180614041449epcas1p4d2dab007e7f7f56dff9c6cfd7640e30f~366RC69zk0892908929epcas1p4d;
        Thu, 14 Jun 2018 04:14:49 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.7D.04217.9BBE12B5; Thu, 14 Jun 2018 13:14:49 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20180614041448epcas2p400dad902581dc6875461d4c3dd3a231d~366QyaRnJ1887218872epcas2p4G;
        Thu, 14 Jun 2018 04:14:48 +0000 (GMT)
X-AuditID: b6c32a45-429ff70000001079-a4-5b21ebb9db36
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5D.69.04192.8BBE12B5; Thu, 14 Jun 2018 13:14:48 +0900 (KST)
Received: from localhost.localdomain ([10.113.63.77]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PAA004YVP4O9Y80@mmp1.samsung.com>; Thu, 14 Jun 2018
        13:14:48 +0900 (KST)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, stable@vger.kernel.org,
        Roger Quadros <rogerq@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH] extcon: Release locking when sending the notification of
 connector state
Date:   Thu, 14 Jun 2018 13:14:47 +0900
Message-id: <1528949687-32002-1-git-send-email-cw00.choi@samsung.com>
X-Mailer: git-send-email 1.8.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42LZdljTVHfna8Vog8cTuSwm3rjCYnH9y3NW
        iwtPe9gsLu+aw2Zxu3EFm0XPIy2LBRsfMTqwe2xa1cnm0bdlFaPH8RvbmTw+b5ILYIlKtclI
        TUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBOkBJoSwxpxQo
        FJBYXKykb2dTlF9akqqQkV9cYqsUbWhopGdoYK5nZASkjWOtjEyBShJSMy6/n81c8IKnYsvc
        HywNjBe4uhg5OSQETCR2PTvI3sXIxSEksINRYvPdwywQzndGif5JJ4EyHGBVbRsDQBqEBHYz
        Siw/ywpX07f4PxNIgk1AS2L/ixtsILaIgILE5t5nYEXMAqsYJXY3TmcESQgLREu8+zWFGcRm
        EVCVuPmynQlkAa+Aq8ShlxEQF8lJfNjzCOwiCYG3rBIXJ7QzQiRcJL6tecgKYQtLvDq+hR3C
        lpZ4tmojI0RDO6PElxfNrBDOBEaJD6c2M0FUGUs8W9gFZjML8El0HP4L9RqvREebEESJh8TH
        GTdZQMJCArESHzttgQYsYGRYxSiWWlCcm55abFRgqFecmFtcmpeul5yfu4kRnAy0XHcwzjjn
        c4hRgINRiYd3g5xitBBrYllxZe4hRgkOZiURXr8XCtFCvCmJlVWpRfnxRaU5qcWHGE2BQTCR
        WUo0OR+YqPJK4g1NjYyNjS1MzS2NDSyVxHkZbwpECwmkJ5akZqemFqQWwfQxcXBKNTA63Iz1
        l5+1OOUQi++awB2P2afPv76M8chL6br5j467e6+3bLxxaZL9oYI1b/7p62gmf9my6pev1DsD
        wzb3ezemJamHi+pdeLT1Zvoen9J2vwzt5upw/7kH+V9WJ+n+0Zh3T9Jk7/7lJwvm3gn4u8vg
        TEilyp+0b/MvWevcO3zEZb609r5JFRZ+SizFGYmGWsxFxYkAsIDdJBwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLJMWRmVeSWpSXmKPExsVy+t9jAd0drxWjDe7usbSYeOMKi8X1L89Z
        LS487WGzuLxrDpvF7cYVbBY9j7QsFmx8xOjA7rFpVSebR9+WVYwex29sZ/L4vEkugCWKyyYl
        NSezLLVI3y6BK+Py+9nMBS94KrbM/cHSwHiBq4uRg0NCwESibWNAFyMXh5DATkaJG9OWsUA4
        3xkl7sybxtzFyMnBJqAlsf/FDTYQW0RAQWJz7zNWkCJmgVWMEvPffAZLCAtES7z7NQWsgUVA
        VeLmy3YmkA28Aq4Sh15GgIQlBOQkPux5xD6BkWsBI8MqRsnUguLc9NxiowKjvNRyveLE3OLS
        vHS95PzcTYzAQNh2WKt/B+PjJfGHGAU4GJV4eBOUFaOFWBPLiitzDzFKcDArifD6vVCIFuJN
        SaysSi3Kjy8qzUktPsQozcGiJM7Ln38sUkggPbEkNTs1tSC1CCbLxMEp1cB4kie9zuybC9PX
        KSccVJ4cnLVyfXtLLJuSqsnzPVFlGlaPYubJLj569LJdI4O4pOiOzXMlw/tPHFK+I9n3VfDm
        tnPSl5b+/MVQdpnVYcq0vb0su+bZLJ+2jEt2pd33fc/ub3N3MVZtmOvabyH0hP+kXFOswyz9
        vMN7q45rXL39/tn2x992nlUQVmIpzkg01GIuKk4EAKq9WT0AAgAA
X-CMS-MailID: 20180614041448epcas2p400dad902581dc6875461d4c3dd3a231d
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180614041448epcas2p400dad902581dc6875461d4c3dd3a231d
References: <CGME20180614041448epcas2p400dad902581dc6875461d4c3dd3a231d@epcas2p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, extcon used the spinlock before calling the notifier_call_chain
to prevent the scheduled out of task and to prevent the notification delay.
When spinlock is locked for sending the notification, deadlock issue
occured on the side of extcon consumer device. To fix this issue,
extcon consumer device should always use the work. it is always not
reasonable to use work.

To fix this issue on extcon consumer device, release locking when sending
the notification of connector state.

Fixes: ab11af049f88 ("extcon: Add the synchronization extcon APIs to support the notification")
Cc: stable@vger.kernel.org
Cc: Roger Quadros <rogerq@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/extcon/extcon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 8bff5fd18185..f75b08a45d4e 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -433,8 +433,8 @@ int extcon_sync(struct extcon_dev *edev, unsigned int id)
 		return index;
 
 	spin_lock_irqsave(&edev->lock, flags);
-
 	state = !!(edev->state & BIT(index));
+	spin_unlock_irqrestore(&edev->lock, flags);
 
 	/*
 	 * Call functions in a raw notifier chain for the specific one
@@ -448,6 +448,7 @@ int extcon_sync(struct extcon_dev *edev, unsigned int id)
 	 */
 	raw_notifier_call_chain(&edev->nh_all, state, edev);
 
+	spin_lock_irqsave(&edev->lock, flags);
 	/* This could be in interrupt handler */
 	prop_buf = (char *)get_zeroed_page(GFP_ATOMIC);
 	if (!prop_buf) {
-- 
1.9.1

