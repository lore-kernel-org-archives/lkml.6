Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178AFC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BD6214C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vObnM0OP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4BD6214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730789AbeJIB5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:57:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730397AbeJIB5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:57:40 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 785DC2064A;
        Mon,  8 Oct 2018 18:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024275;
        bh=gtTtCTv4uFyX1wMEohy9GtYwHZmAMaqWhkgqiqpIOnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vObnM0OPzppaqA+LkyLYCBm1Rn4NR9guRHJcYASSwBYnPEAMCq1G7f360qkAOYv8y
         wZgKaaAot0vsRGENvgKR0tlU9LF0RkoLOInDG5y9YeaQLkHf7q/wZBhLmYeCrfVUlm
         cYJa7iK5tkFRnbhNqjg5TMshZyqK6vN527dSoMxU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 56/94] USB: yurex: Check for truncation in yurex_read()
Date:   Mon,  8 Oct 2018 20:31:37 +0200
Message-Id: <20181008175608.435025039@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175605.067676667@linuxfoundation.org>
References: <20181008175605.067676667@linuxfoundation.org>
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

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

[ Upstream commit 14427b86837a4baf1c121934c6599bdb67dfa9fc ]

snprintf() always returns the full length of the string it could have
printed, even if it was truncated because the buffer was too small.
So in case the counter value is truncated, we will over-read from
in_buffer and over-write to the caller's buffer.

I don't think it's actually possible for this to happen, but in case
truncation occurs, WARN and return -EIO.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/misc/yurex.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -417,6 +417,9 @@ static ssize_t yurex_read(struct file *f
 	spin_unlock_irqrestore(&dev->lock, flags);
 	mutex_unlock(&dev->io_mutex);
 
+	if (WARN_ON_ONCE(len >= sizeof(in_buffer)))
+		return -EIO;
+
 	return simple_read_from_buffer(buffer, count, ppos, in_buffer, len);
 }
 


