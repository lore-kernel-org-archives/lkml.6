Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D27ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0872088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:53:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0872088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbeIREXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:23:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45548 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbeIREXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:23:07 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 48D0FCA0;
        Mon, 17 Sep 2018 22:53:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@163.com>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.9 08/70] staging: rt5208: Fix a sleep-in-atomic bug in xd_copy_page
Date:   Tue, 18 Sep 2018 00:41:41 +0200
Message-Id: <20180917211649.877327834@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211649.099135838@linuxfoundation.org>
References: <20180917211649.099135838@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jia-Ju Bai <baijiaju1990@163.com>

commit 498c4b4e9c23855d17ecc2a108d949bb68020481 upstream.

The driver may sleep under a spin lock, and the function call path is:
rtsx_exclusive_enter_ss (acquire the lock by spin_lock)
  rtsx_enter_ss
    rtsx_power_off_card
      xd_cleanup_work
        xd_delay_write
          xd_finish_write
            xd_copy_page
              wait_timeout
                schedule_timeout --> may sleep

To fix it, "wait_timeout" is replaced with mdelay in xd_copy_page.

Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/rts5208/xd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/rts5208/xd.c
+++ b/drivers/staging/rts5208/xd.c
@@ -1247,7 +1247,7 @@ static int xd_copy_page(struct rtsx_chip
 			reg = 0;
 			rtsx_read_register(chip, XD_CTL, &reg);
 			if (reg & (XD_ECC1_ERROR | XD_ECC2_ERROR)) {
-				wait_timeout(100);
+				mdelay(100);
 
 				if (detect_card_cd(chip,
 					XD_CARD) != STATUS_SUCCESS) {


