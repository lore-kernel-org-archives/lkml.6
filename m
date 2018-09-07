Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB9CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412E820861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412E820861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbeIHB7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:59:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42808 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbeIHB7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:59:53 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3B967F07;
        Fri,  7 Sep 2018 21:17:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.18 064/145] iio: sca3000: Fix missing return in switch
Date:   Fri,  7 Sep 2018 23:08:50 +0200
Message-Id: <20180907210909.852426807@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
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

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit c5b974bee9d2ceae4c441ae5a01e498c2674e100 upstream.

The IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY case is missing a
return and will fall through to the default case and errorenously
return -EINVAL.

Fix this by adding in missing *return ret*.

Fixes: 626f971b5b07 ("staging:iio:accel:sca3000 Add write support to the low pass filter control")
Reported-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/accel/sca3000.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -797,6 +797,7 @@ static int sca3000_write_raw(struct iio_
 		mutex_lock(&st->lock);
 		ret = sca3000_write_3db_freq(st, val);
 		mutex_unlock(&st->lock);
+		return ret;
 	default:
 		return -EINVAL;
 	}


