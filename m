Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E94C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321BD218FC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbfBCOUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:20:14 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55304 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729489AbfBCOUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:08 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIcw-0006B3-Hb; Sun, 03 Feb 2019 14:20:06 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9V-0006qv-5A; Sun, 03 Feb 2019 14:49:41 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "linux-edac" <linux-edac@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Borislav Petkov" <bp@suse.de>,
        "Aristeu Rozanski" <aris@redhat.com>,
        "Qiuxu Zhuo" <qiuxu.zhuo@intel.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.708051508@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 047/305] EDAC, {i7core,sb,skx}_edac: Fix uncorrected
 error counting
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Luck <tony.luck@intel.com>

commit 432de7fd7630c84ad24f1c2acd1e3bb4ce3741ca upstream.

The count of errors is picked up from bits 52:38 of the machine check
bank status register. But this is the count of *corrected* errors. If an
uncorrected error is being logged, the h/w sets this field to 0. Which
means that when edac_mc_handle_error() is called, the EDAC core will
carefully add zero to the appropriate uncorrected error counts.

Signed-off-by: Tony Luck <tony.luck@intel.com>
[ Massage commit message. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Aristeu Rozanski <aris@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/20180928213934.19890-1-tony.luck@intel.com
[bwh: Backported to 3.16: Drop change in skx_edac.c]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -1729,6 +1729,7 @@ static void i7core_mce_output_error(stru
 	u32 errnum = find_first_bit(&error, 32);
 
 	if (uncorrected_error) {
+		core_err_cnt = 1;
 		if (ripv)
 			tp_event = HW_EVENT_ERR_FATAL;
 		else
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -1659,6 +1659,7 @@ static void sbridge_mce_output_error(str
 		recoverable = GET_BITFIELD(m->status, 56, 56);
 
 	if (uncorrected_error) {
+		core_err_cnt = 1;
 		if (ripv) {
 			type = "FATAL";
 			tp_event = HW_EVENT_ERR_FATAL;

