Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93614C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F03220661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F03220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbeLIWJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:09:14 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37392 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727223AbeLIWJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:09:07 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73F-0002ik-Ly; Sun, 09 Dec 2018 21:55:49 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72c-0003Mk-PQ; Sun, 09 Dec 2018 21:55:10 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.507078927@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 119/328] media: rtl28xxu: be sure that it won't go
 past the array size
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

commit 845b978a871bff3707eee611b32e4be0b9a94dd2 upstream.

smatch warns that the RC query code could go past the array size:

	drivers/media/usb/dvb-usb-v2/rtl28xxu.c:1757 rtl2832u_rc_query() error: buffer overflow 'buf' 128 <= 130
	drivers/media/usb/dvb-usb-v2/rtl28xxu.c:1758 rtl2832u_rc_query() error: buffer overflow 'buf' 128 <= 130

The driver logic gets the length of the IR RX buffer with:

        ret = rtl28xxu_rd_reg(d, IR_RX_BC, &buf[0]);
	...
        len = buf[0];

In thesis, this could range between 0 and 255 [1].

While this should never happen in practice, due to hardware limits,
smatch is right when it complains about that, as there's nothing at
the logic that would prevent it. So, if for whatever reason, buf[0]
gets filled by rtl28xx read functions with a value bigger than 128,
it will go past the array.

So, add an explicit check.

[1] I've no idea why smatch thinks that the maximum value is 130.
I double-checked the code several times. Was unable to find any
reason for assuming 130. Perhaps smatch is not properly parsing
u8 here?

Fixes: b5cbaa43a676 ("[media] rtl28xx: initial support for rtl2832u")
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/usb/dvb-usb-v2/rtl28xxu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
+++ b/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
@@ -1379,7 +1379,7 @@ static int rtl2832u_rc_query(struct dvb_
 		goto exit;
 
 	ret = rtl28xx_rd_reg(d, IR_RX_BC, &buf[0]);
-	if (ret)
+	if (ret || buf[0] > sizeof(buf))
 		goto err;
 
 	len = buf[0];

