Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723B6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B41320870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrqPPwd9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B41320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbeKTC4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:56:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:54266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729979AbeKTC4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:56:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2124C2086A;
        Mon, 19 Nov 2018 16:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645124;
        bh=SxKVI6Gv+7ecNYT2ESNwjkFA6oqqa7Nafv4E6lnt848=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nrqPPwd9zwAphtNxTUoyY2djpLnZ2olXIH3+/J3RNgVCmH9+Oq/77EQTb15FeSSWM
         6v28//yLoMbPIHT8fC+ZAgMHmScvDyiGCCZ5346ncKJfDErKK0kbLT8tTWBRXnXl+u
         fxyZPh8cWVehqbotsL0tcflSHDU+taVzi9YcfERo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Young_X <YangX92@hotmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.19 045/205] cdrom: fix improper type cast, which can leat to information leak.
Date:   Mon, 19 Nov 2018 17:25:52 +0100
Message-Id: <20181119162625.475338949@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Young_X <YangX92@hotmail.com>

commit e4f3aa2e1e67bb48dfbaaf1cad59013d5a5bc276 upstream.

There is another cast from unsigned long to int which causes
a bounds check to fail with specially crafted input. The value is
then used as an index in the slot array in cdrom_slot_status().

This issue is similar to CVE-2018-16658 and CVE-2018-10940.

Signed-off-by: Young_X <YangX92@hotmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cdrom/cdrom.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2445,7 +2445,7 @@ static int cdrom_ioctl_select_disc(struc
 		return -ENOSYS;
 
 	if (arg != CDSL_CURRENT && arg != CDSL_NONE) {
-		if ((int)arg >= cdi->capacity)
+		if (arg >= cdi->capacity)
 			return -EINVAL;
 	}
 


