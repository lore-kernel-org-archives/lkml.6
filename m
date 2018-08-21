Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C06C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3598621774
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3598621774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbeHUJmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:42:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54918 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbeHUJmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:42:39 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0CFE08A5;
        Tue, 21 Aug 2018 06:23:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
        Hailong Liu <liu.hailong6@zte.com.cn>,
        Jiang Biao <jiang.biao2@zte.com.cn>
Subject: [PATCH 4.18 24/35] uio: fix wrong return value from uio_mmap()
Date:   Tue, 21 Aug 2018 08:20:50 +0200
Message-Id: <20180821055021.038282947@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055019.954904905@linuxfoundation.org>
References: <20180821055019.954904905@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hailong Liu <liu.hailong6@zte.com.cn>

commit e7de2590f18a272e63732b9d519250d1b522b2c4 upstream.

uio_mmap has multiple fail paths to set return value to nonzero then
goto out. However, it always returns *0* from the *out* at end, and
this will mislead callers who check the return value of this function.

Fixes: 57c5f4df0a5a0ee ("uio: fix crash after the device is unregistered")
CC: Xiubo Li <xiubli@redhat.com>
Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/uio/uio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -814,7 +814,7 @@ static int uio_mmap(struct file *filep,
 
 out:
 	mutex_unlock(&idev->info_lock);
-	return 0;
+	return ret;
 }
 
 static const struct file_operations uio_fops = {


