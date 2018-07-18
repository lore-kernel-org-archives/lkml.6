Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26614ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE7A20693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OzW4KCOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE7A20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbeGRBiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 21:38:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60165 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730652AbeGRBiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 21:38:03 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E16F6EDF44;
        Tue, 17 Jul 2018 21:02:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=9hsx
        isrz4BLrEl8XObgHlrjSsws=; b=OzW4KCOdmo8spVgkr75GOZKgdUx6eIiYKmH3
        zTfQOCQjHPvlrAynzpeqMU76Bj31mXV6xXZQ8dx6CvlVBTZnfsQX57WH6dFlZLKA
        Z9lBv9FuVIQwhWDTes27bk8dcG0wbYnZnDIFb01+OfLSWBQGMUpZymdYl7fC8/fG
        XBp/uds=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CAD06EDF40;
        Tue, 17 Jul 2018 21:02:45 -0400 (EDT)
Received: from yoda.home (unknown [70.82.104.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3ACD4EDF3B;
        Tue, 17 Jul 2018 21:02:45 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTP id 629022DA0492;
        Tue, 17 Jul 2018 21:02:44 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org, linux-console@vger.kernel.org
Subject: [PATCH 1/3] vt: avoid a VLA in the unicode screen scroll function
Date:   Tue, 17 Jul 2018 21:02:40 -0400
Message-Id: <20180718010242.5254-2-nicolas.pitre@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718010242.5254-1-nicolas.pitre@linaro.org>
References: <20180718010242.5254-1-nicolas.pitre@linaro.org>
X-Pobox-Relay-ID: 47C947BC-8A26-11E8-A67C-063AD72159A7-78420484!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nr argument is typically small: most often nr == 1. However this
could be abused with a very large explicit scroll in a resized screen.
Make the code scroll lines one at a time in all cases to avoid the VLA.
Anything smarter is most likely not warranted here.

Requested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 drivers/tty/vt/vt.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 2d14bb195d..03e79f7787 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -433,20 +433,22 @@ static void vc_uniscr_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 
 	if (uniscr) {
 		unsigned int s, d, rescue, clear;
-		char32_t *save[nr];
 
 		s = clear = t;
-		d = t + nr;
-		rescue = b - nr;
+		d = t + 1;
+		rescue = b - 1;
 		if (dir == SM_UP) {
 			swap(s, d);
 			swap(clear, rescue);
 		}
-		memcpy(save, uniscr->lines + rescue, nr * sizeof(*save));
-		memmove(uniscr->lines + d, uniscr->lines + s,
-			(b - t - nr) * sizeof(*uniscr->lines));
-		memcpy(uniscr->lines + clear, save, nr * sizeof(*save));
-		vc_uniscr_clear_lines(vc, clear, nr);
+		while (nr--) {
+			char32_t *tmp;
+			tmp = uniscr->lines[rescue];
+			memmove(uniscr->lines + d, uniscr->lines + s,
+				(b - t - 1) * sizeof(*uniscr->lines));
+			uniscr->lines[clear] = tmp;
+			vc_uniscr_clear_lines(vc, clear, 1);
+		}
 	}
 }
 
-- 
2.17.1

