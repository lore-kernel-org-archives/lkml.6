Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2066C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9747C20896
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 15:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GanTvwju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9747C20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387743AbeKNBhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:37:39 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47744 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbeKNBhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 20:37:39 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181113153900euoutp0182c35984e8cabb4c47aef6ed8c08bb3f~muTCHJzaR1163911639euoutp01D;
        Tue, 13 Nov 2018 15:39:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181113153900euoutp0182c35984e8cabb4c47aef6ed8c08bb3f~muTCHJzaR1163911639euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542123540;
        bh=TQ8VtZmvIHLdVstCwUNJPazAP1X+yjIsSYbTQCqoQ7A=;
        h=From:To:Cc:Subject:Date:References:From;
        b=GanTvwjuZZxUDorMUofvXHUOMUkgUiFlsq2hwmHoo3hBLODBuD0Xf9onh8f36g1Tr
         Qrx5QdvHUFkyt9ZzT9oR7uvrF1N7Rj08NzUmB7R3XJStYtTk3AS+Z83NCNGDuiOoN5
         Ete6oYbyxviTmEzGAfAwouBhDDATT0vdzMvfgH7g=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181113153900eucas1p2e44118562a5b3f8143389fbac1358914~muTBt5jJO1887018870eucas1p2X;
        Tue, 13 Nov 2018 15:39:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id BB.94.04294.310FAEB5; Tue, 13
        Nov 2018 15:38:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181113153859eucas1p1dfc17519a7e960096d2888e47ab18dd8~muTBAx8EI1617116171eucas1p1G;
        Tue, 13 Nov 2018 15:38:59 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-89-5beaf0136c66
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E7.DA.04128.210FAEB5; Tue, 13
        Nov 2018 15:38:58 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PI50040T24VKX20@eusync1.samsung.com>;
        Tue, 13 Nov 2018 15:38:58 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] extcon: max8997: Fix lack of path setting in USB device
 mode
Date:   Tue, 13 Nov 2018 16:38:47 +0100
Message-id: <20181113153847.14732-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7djP87rCH15FG1zer2exccZ6VovrX56z
        Wpw/v4Hd4vKuOWwWM87vY7JYe+Quu8XtxhVsDuwem1Z1snn0bVnF6PF5k1wAcxSXTUpqTmZZ
        apG+XQJXxrfOBUwFS7krLh/exdbAuIizi5GTQ0LAROLmmcuMXYxcHEICKxgl5jy6wArhfGaU
        +D55DTNM1ezHD6GqljFK3HnVxA6SEBJoYJK49tcaxGYTMJToetvFBmKLCDhL3P7wjQXEZhZ4
        yCix5aoCiC0s4C/x7loL2FAWAVWJDauWsILYvAK2EgvuXWWDWCYvsXrDAajFN1kljhzig7Bd
        JGb/XsQCYQtLvDq+hR3ClpG4PLmbBeQ4CYFmRon2GbPYIZweRomtc3ZATbWWOHz8IivERXwS
        k7ZNB9rAARTnlehoE4Io8ZDY2biHCeKxWImNRz8yTWCUWMDIsIpRPLW0ODc9tdgoL7Vcrzgx
        t7g0L10vOT93EyMwpk7/O/5lB+OuP0mHGAU4GJV4eB/ceBUtxJpYVlyZe4hRgoNZSYRX4RlQ
        iDclsbIqtSg/vqg0J7X4EKM0B4uSOG81w4NoIYH0xJLU7NTUgtQimCwTB6dUA2OFmseq4JhZ
        Irujaj56S248uu9DVDzf0wTZDpsHNtvXvWZdzhb2oDxCv+WMZGe4dtJRR9Psf9d7ZxYV/OS8
        07HkeZJmvnkZx+tc1/6mWp91jKUCx5X26FUWNLdGnzptc/Pwta0MbdEGwg5BC2pDu4ylA6+d
        kej/Jvzp55HpvvOT3mbuFo8OVWIpzkg01GIuKk4EAKLMt46lAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGJMWRmVeSWpSXmKPExsVy+t/xy7pCH15FG6xYZWOxccZ6VovrX56z
        Wpw/v4Hd4vKuOWwWM87vY7JYe+Quu8XtxhVsDuwem1Z1snn0bVnF6PF5k1wAcxSXTUpqTmZZ
        apG+XQJXxrfOBUwFS7krLh/exdbAuIizi5GTQ0LARGL244eMXYxcHEICSxgleh/+YoNwmpgk
        lr46zQZSxSZgKNH1tgvMFhFwlrj94RsLSBGzwENGiVdbjjCCJIQFfCW2rFgLZrMIqEpsWLWE
        FcTmFbCVWHDvKhvEOnmJ1RsOME9g5FrAyLCKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMj0Pfb
        jv3csoOx613wIUYBDkYlHt4HN15FC7EmlhVX5h5ilOBgVhLhVXgGFOJNSaysSi3Kjy8qzUkt
        PsQozcGiJM573qAySkggPbEkNTs1tSC1CCbLxMEp1cDIyPs6X3ZeXt3Kf9G7OjPEzbN0jSq1
        ynIv1qjknXBNz4ny4+q9k5wiEFnhUeL+IuSA07VFLwuvimkx9D8/b+f2KvPDLefIZVrqqe5f
        ze4/kxJkmSHG8mf1g3gPrh6WF523iydtFawKW/LgPo+T9fWsdUYvE589kTKfXP5+bv8ZrTOu
        80PKK5VYijMSDbWYi4oTAel4BOX5AQAA
X-CMS-MailID: 20181113153859eucas1p1dfc17519a7e960096d2888e47ab18dd8
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181113153859eucas1p1dfc17519a7e960096d2888e47ab18dd8
References: <CGME20181113153859eucas1p1dfc17519a7e960096d2888e47ab18dd8@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAX8997 driver disables automatic path selection from MicroUSB connector
and manually sets path to either UART or USB lines. However the code for
setting USB path worked only for USB host mode (when ID pin is set
to ground). When standard USB cable (USB device mode) is connected, path
registers are not touched. This means that once the non-USB accessory is
connected to MAX8997-operated micro USB port, the path is no longer set
to USB and USB device mode doesn't work. This patch fixes it by setting
USB path both for USB and USB host modes.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/extcon/extcon-max8997.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8997.c
index 632192d027bf..172e116ac1ce 100644
--- a/drivers/extcon/extcon-max8997.c
+++ b/drivers/extcon/extcon-max8997.c
@@ -311,12 +311,10 @@ static int max8997_muic_handle_usb(struct max8997_muic_info *info,
 {
 	int ret = 0;
 
-	if (usb_type == MAX8997_USB_HOST) {
-		ret = max8997_muic_set_path(info, info->path_usb, attached);
-		if (ret < 0) {
-			dev_err(info->dev, "failed to update muic register\n");
-			return ret;
-		}
+	ret = max8997_muic_set_path(info, info->path_usb, attached);
+	if (ret < 0) {
+		dev_err(info->dev, "failed to update muic register\n");
+		return ret;
 	}
 
 	switch (usb_type) {
-- 
2.17.1

