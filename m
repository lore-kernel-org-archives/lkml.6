Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C05BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 341C3208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WI7TAymI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 341C3208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391264AbeKLIYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:24:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:60340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731232AbeKLIYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:24:44 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D61B208A3;
        Sun, 11 Nov 2018 22:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975686;
        bh=E0NTk6Y8IRz00wyVoZz5dDzGvgRhaYE5Z8U2Dzg/pgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WI7TAymI6IlHgNqvUuLIa0nZyr4VUgIGoHTifmcNfI4yArywDsJmpszUWijEFirYX
         rVJoekJaQxXE7KcRY6tbwzpStN5OHVGQyIlWA5/e0aUVe2yGQrZltjweYfQIBzT6Gk
         Qoe6qSiTifP8xMq0YRsyt6WUvNF5XmgvLrBfcT8s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: [PATCH 4.9 092/141] EDAC, {i7core,sb,skx}_edac: Fix uncorrected error counting
Date:   Sun, 11 Nov 2018 14:25:51 -0800
Message-Id: <20181111221640.885894319@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
References: <20181111221627.853046496@linuxfoundation.org>
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
Cc: stable@vger.kernel.org
Cc: Aristeu Rozanski <aris@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/20180928213934.19890-1-tony.luck@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/edac/i7core_edac.c |    1 +
 drivers/edac/sb_edac.c     |    1 +
 drivers/edac/skx_edac.c    |    1 +
 3 files changed, 3 insertions(+)

--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -1711,6 +1711,7 @@ static void i7core_mce_output_error(stru
 	u32 errnum = find_first_bit(&error, 32);
 
 	if (uncorrected_error) {
+		core_err_cnt = 1;
 		if (ripv)
 			tp_event = HW_EVENT_ERR_FATAL;
 		else
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -2934,6 +2934,7 @@ static void sbridge_mce_output_error(str
 		recoverable = GET_BITFIELD(m->status, 56, 56);
 
 	if (uncorrected_error) {
+		core_err_cnt = 1;
 		if (ripv) {
 			type = "FATAL";
 			tp_event = HW_EVENT_ERR_FATAL;
--- a/drivers/edac/skx_edac.c
+++ b/drivers/edac/skx_edac.c
@@ -897,6 +897,7 @@ static void skx_mce_output_error(struct
 	recoverable = GET_BITFIELD(m->status, 56, 56);
 
 	if (uncorrected_error) {
+		core_err_cnt = 1;
 		if (ripv) {
 			type = "FATAL";
 			tp_event = HW_EVENT_ERR_FATAL;


