Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8714C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB5620818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+NMOOry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB5620818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390619AbeKLIz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:55:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:51200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390410AbeKLIWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:14 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1F7F224B3;
        Sun, 11 Nov 2018 22:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975537;
        bh=MR3DE5l92liLMqe7JRgxMkNx69/XLjyCay1bw6ySx4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q+NMOOryDXnqr7k/P1qK+btz1mTzPwELSExshkjAvlupQT2qFS4AdAfgIW7xhons7
         BsYPd6rA4LetW8QPplTvHbE1GHNWjagf/yVx9LXxH51yzFhx58lsmtkgTkaU/oiUfl
         Caw/APWMuQ99/HqnyuggxxpR+xmvNLAzNpwMPO9k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dou Liyang <douly.fnst@cn.fujitsu.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 056/222] ACPI / processor: Fix the return value of acpi_processor_ids_walk()
Date:   Sun, 11 Nov 2018 14:22:33 -0800
Message-Id: <20181111221653.057260326@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dou Liyang <douly.fnst@cn.fujitsu.com>

[ Upstream commit d0381bf4f80c571dde1244fe5b85dc35e8b3f546 ]

ACPI driver should make sure all the processor IDs in their ACPI Namespace
are unique. the driver performs a depth-first walk of the namespace tree
and calls the acpi_processor_ids_walk() to check the duplicate IDs.

But, the acpi_processor_ids_walk() mistakes the return value. If a
processor is checked, it returns true which causes the walk break
immediately, and other processors will never be checked.

Repace the value with AE_OK which is the standard acpi_status value.
And don't abort the namespace walk even on error.

Fixes: 8c8cb30f49b8 (acpi/processor: Implement DEVICE operator for processor enumeration)
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/acpi_processor.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -642,7 +642,7 @@ static acpi_status __init acpi_processor
 
 	status = acpi_get_type(handle, &acpi_type);
 	if (ACPI_FAILURE(status))
-		return false;
+		return status;
 
 	switch (acpi_type) {
 	case ACPI_TYPE_PROCESSOR:
@@ -662,11 +662,12 @@ static acpi_status __init acpi_processor
 	}
 
 	processor_validated_ids_update(uid);
-	return true;
+	return AE_OK;
 
 err:
+	/* Exit on error, but don't abort the namespace walk */
 	acpi_handle_info(handle, "Invalid processor object\n");
-	return false;
+	return AE_OK;
 
 }
 


