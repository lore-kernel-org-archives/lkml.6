Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7588C677FE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC40213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvHUV5zg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EC40213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbeJKXHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:07:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbeJKXHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:07:13 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96A4E2087A;
        Thu, 11 Oct 2018 15:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272370;
        bh=xIUatBRA6yFBZxZ2IUGApBHjiMhIkzZjVFjeBomwdTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fvHUV5zgiTUFRYjV8Cn6aybV/N9LZs/Nc+vgopy2w3wRM2irUHRzdxLBftM7o9AOT
         p/1ZYCE169EPMKFhAp6sx/DpBO3TEtbG2TXdV1tMkLarNEMrTvkm0ijFcKgM8jHJ76
         wzihC94R6671OA+FmvmPIOUNm7aonIRe7pYTfiXA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 085/120] USB: yurex: Check for truncation in yurex_read()
Date:   Thu, 11 Oct 2018 17:34:26 +0200
Message-Id: <20181011152553.322998154@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
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
@@ -430,6 +430,9 @@ static ssize_t yurex_read(struct file *f
 	spin_unlock_irqrestore(&dev->lock, flags);
 	mutex_unlock(&dev->io_mutex);
 
+	if (WARN_ON_ONCE(len >= sizeof(in_buffer)))
+		return -EIO;
+
 	return simple_read_from_buffer(buffer, count, ppos, in_buffer, len);
 }
 


