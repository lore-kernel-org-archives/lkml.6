Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BF8ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC542089A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfXXOuxe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC542089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbeKIHdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:33:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:48830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbeKIHdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:15 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B1C121104;
        Thu,  8 Nov 2018 21:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714148;
        bh=0YV48LmgzJ5lMn0yQbtSzPzeVBiKbx7GHnMpJEUkA9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mfXXOuxe8p3Z/EWSmtRvk4qYeGi8SDJoOclNQ9Entlx4sAnWDGc5qQIOgfV63jNVZ
         BrkytBibg7mmz3v/OxkqgXTYJmDQNCpWPjTMhIJfS2IOq4ZaXdZmJLqYaBDMJJS5Sw
         I4ce++Jkzaw1ldLXNHYObospSBuLLA9KEOLj5ZNw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 060/144] USB: EHCI: adjust error return code
Date:   Thu,  8 Nov 2018 13:50:31 -0800
Message-Id: <20181108215059.197145951@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c401e7b4a808d50ab53ef45cb8d0b99b238bf2c9 ]

The USB stack uses error code -ENOSPC to indicate that the periodic
schedule is too full, with insufficient bandwidth to accommodate a new
allocation.  It uses -EFBIG to indicate that an isochronous transfer
could not be linked into the schedule because it would exceed the
number of isochronous packets the host controller driver can handle
(generally because the new transfer would extend too far into the
future).

ehci-hcd uses the wrong error code at one point.  This patch fixes it,
along with a misleading comment and debugging message.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/ehci-sched.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
index c399606f154e..f9a332775c47 100644
--- a/drivers/usb/host/ehci-sched.c
+++ b/drivers/usb/host/ehci-sched.c
@@ -1604,11 +1604,11 @@ iso_stream_schedule (
 	 */
 	now2 = (now - base) & (mod - 1);
 
-	/* Is the schedule already full? */
+	/* Is the schedule about to wrap around? */
 	if (unlikely(!empty && start < period)) {
-		ehci_dbg(ehci, "iso sched full %p (%u-%u < %u mod %u)\n",
+		ehci_dbg(ehci, "request %p would overflow (%u-%u < %u mod %u)\n",
 				urb, stream->next_uframe, base, period, mod);
-		status = -ENOSPC;
+		status = -EFBIG;
 		goto fail;
 	}
 
-- 
2.17.1



