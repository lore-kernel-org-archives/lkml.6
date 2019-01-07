Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02F3C43612
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73BC21736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546867285;
	bh=bfoDEjtzPcHWhySdtTd2Bf9m2ckXOE3fGZI8ilioTOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k6S17Z553VmWJ+0/ipKBi+TQavyxigJR5OTeePSs9I7S1WYOin9AjtmlU3qzaU64J
	 33P7Zku1+ocHmzIOG7mReThMEYaPVTfpEUdSZiPV0ZVK68ECY8Z4/ltkMxG/kWNzLy
	 QZOgpe4U2peGp2p8L7+TWvxmNr+FFtEXjD2vDeGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfAGMpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:45:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:33854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728774AbfAGMo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:44:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D61C21873;
        Mon,  7 Jan 2019 12:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865096;
        bh=bfoDEjtzPcHWhySdtTd2Bf9m2ckXOE3fGZI8ilioTOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q90+9ex/14sF4IguHzAx3z+defa+v6B7VIKDXtS2FOdKUdfeJqG50FIQmHbteW+iA
         p0R2Ps/30qZHlgK8fj7Z0W0qlOQHCKNsehUg0xz43F/tgkEtgJhqp5KeS/bIkF0JPw
         b3zm0udaWGC28j0TQXRwfR3tIAqAEf4oi9rRcg+c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@linux-mips.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4.20 134/145] rtc: m41t80: Correct alarm month range with RTC reads
Date:   Mon,  7 Jan 2019 13:32:51 +0100
Message-Id: <20190107104454.738611224@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
@@ -393,7 +393,7 @@ static int m41t80_read_alarm(struct devi
 	alrm->time.tm_min  = bcd2bin(alarmvals[3] & 0x7f);
 	alrm->time.tm_hour = bcd2bin(alarmvals[2] & 0x3f);
 	alrm->time.tm_mday = bcd2bin(alarmvals[1] & 0x3f);
-	alrm->time.tm_mon  = bcd2bin(alarmvals[0] & 0x3f);
+	alrm->time.tm_mon  = bcd2bin(alarmvals[0] & 0x3f) - 1;
 
 	alrm->enabled = !!(alarmvals[0] & M41T80_ALMON_AFE);
 	alrm->pending = (flags & M41T80_FLAGS_AF) && alrm->enabled;


