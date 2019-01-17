Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F024C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF2E205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QS5riun5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BRbIno95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbfAQG1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:27:03 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:32768 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729514AbfAQG1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 01:27:02 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 547F1608FB; Thu, 17 Jan 2019 06:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547706421;
        bh=FyUHP3fDWokjIe3y+UIDwQefiT1yCtiYh6dqDGm6Enw=;
        h=From:To:Cc:Subject:Date:From;
        b=QS5riun5rUZc47dHzfwYzFRJ3eDrwKS0hrygUQ/pxma7OBjhQ7EN2lWjpOxtfMYF8
         JALyeUEw+xjJek8DoYIHs7Z35AarD8+Qy/iypi1teiOVDNvjexIbyxozrJv7x8skug
         wGMTvUxYjSaHLXsg60xaQaCLADVX1UAzzqfHh6LI=
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A8B3C608FB;
        Thu, 17 Jan 2019 06:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547706413;
        bh=FyUHP3fDWokjIe3y+UIDwQefiT1yCtiYh6dqDGm6Enw=;
        h=From:To:Cc:Subject:Date:From;
        b=BRbIno95eW/Kv+hQG4tB6lSfSXDujH8bdIGdIPlYHp0i2dRpukGNwdb23pNL3AxrD
         MqVyrhbvXylOM0jhCHuyFAeUYmEh6gzHqH759Xny7LQyoNHlJVu+zFPd5rmz7rS8Sj
         cQtI1QNLc9019JWCP7AonRnFaRVK8NjTO2kQaEE8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A8B3C608FB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH] pstore/ram: Fix console ramoops to show the previous boot logs
Date:   Thu, 17 Jan 2019 11:56:20 +0530
Message-Id: <20190117062620.23908-1-saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit b05c950698fe ("pstore/ram: Simplify ramoops_get_next_prz()
arguments") changed update assignment in getting next persistent
ram zone by adding a check for record type. But the check always
returns true since the record type is assigned 0. And this breaks
console ramoops by showing current console log instead of previous
log on warm reset and hard reset (actually hard reset should not
be showing any logs).

Fix this by having persistent ram zone type check instead of record
type check. Tested this on SDM845 MTP and dragonboard 410c.

Reproducing this issue is simple as below:

1. Trigger hard reset and mount pstore. Will see console-ramoops
   record in the mounted location which is the current log.

2. Trigger warm reset and mount pstore. Will see the current
   console-ramoops record instead of previous record.

Fixes: b05c950698fe ("pstore/ram: Simplify ramoops_get_next_prz() arguments")
Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

---

I guess commit msg can be improved.
---
 fs/pstore/ram.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 96f7d32cd184..441a44215456 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -128,7 +128,7 @@ ramoops_get_next_prz(struct persistent_ram_zone *przs[], int id,
 		     struct pstore_record *record)
 {
 	struct persistent_ram_zone *prz;
-	bool update = (record->type == PSTORE_TYPE_DMESG);
+	bool update;
 
 	/* Give up if we never existed or have hit the end. */
 	if (!przs)
@@ -138,6 +138,8 @@ ramoops_get_next_prz(struct persistent_ram_zone *przs[], int id,
 	if (!prz)
 		return NULL;
 
+	update = (prz->type == PSTORE_TYPE_DMESG);
+
 	/* Update old/shadowed buffer. */
 	if (update)
 		persistent_ram_save_old(prz);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

