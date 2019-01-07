Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D34C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD77217D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866263;
	bh=qrB9d1A5BJM3ODAFMbhwwY16VwaWE7X2gN2cYRikbTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eonBsuSFXaeZP14qvN1q+p55DG5ZjAHrGAMMoYPw2radJPwfhqH+Imu0SKTgzLwXn
	 LXvsd2FW5brTZ/cYTEb+Pm0LF0M/4vGJKIyjUN+vt59JmT9oZmQMcWRAIW730KcWlF
	 bGzeKpVDxiuPNChwChbB+FoAuJ3g5xGwyFBHJA8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbfAGNEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:04:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:51774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731264AbfAGNEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:04:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6678206BB;
        Mon,  7 Jan 2019 13:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866251;
        bh=qrB9d1A5BJM3ODAFMbhwwY16VwaWE7X2gN2cYRikbTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2I3ihExaBKQldWBwfM2SRJW6bFZzVhmjUVBxYzItsCh/crAEulWlizkhN0GJKPdUh
         Qt/EFcWq/OhvWS2QbllAgH0SYNlmXh0MI1b+qRZJVa8/0uJQOaFRgAsX4jSsDeMt07
         xWCHTwmUp0ss4SV2k6816pjSTEOc2SAYTVin7e28=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@linux-mips.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4.14 098/101] rtc: m41t80: Correct alarm month range with RTC reads
Date:   Mon,  7 Jan 2019 13:33:26 +0100
Message-Id: <20190107105338.116473089@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@linux-mips.org>

commit 3cc9ffbb1f51eb4320575a48e4805a8f52e0e26b upstream.

Add the missing adjustment of the month range on alarm reads from the
RTC, correcting an issue coming from commit 9c6dfed92c3e ("rtc: m41t80:
add alarm functionality").  The range is 1-12 for hardware and 0-11 for
`struct rtc_time', and is already correctly handled on alarm writes to
the RTC.

It was correct up until commit 48e9766726eb ("drivers/rtc/rtc-m41t80.c:
remove disabled alarm functionality") too, which removed the previous
implementation of alarm support.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
Fixes: 9c6dfed92c3e ("rtc: m41t80: add alarm functionality")
References: 48e9766726eb ("drivers/rtc/rtc-m41t80.c: remove disabled alarm functionality")
Cc: stable@vger.kernel.org # 4.7+
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/rtc/rtc-m41t80.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -404,7 +404,7 @@ static int m41t80_read_alarm(struct devi
 	alrm->time.tm_min  = bcd2bin(alarmvals[3] & 0x7f);
 	alrm->time.tm_hour = bcd2bin(alarmvals[2] & 0x3f);
 	alrm->time.tm_mday = bcd2bin(alarmvals[1] & 0x3f);
-	alrm->time.tm_mon  = bcd2bin(alarmvals[0] & 0x3f);
+	alrm->time.tm_mon  = bcd2bin(alarmvals[0] & 0x3f) - 1;
 
 	alrm->enabled = !!(alarmvals[0] & M41T80_ALMON_AFE);
 	alrm->pending = (flags & M41T80_FLAGS_AF) && alrm->enabled;


