Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18430C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1090223C6
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTtyWWg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1090223C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403840AbeKLIWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:22:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:54072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387600AbeKLIWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:41 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AAE421780;
        Sun, 11 Nov 2018 22:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975564;
        bh=ouGXA8r0Oby7w6rKy1HT4nZE80wU7c3VB/t7uke+WN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZTtyWWg8iIrpLY0mpYrPbcRHUFTWUFko9TdmOuC0j8VE7/nwLwSSm6xJTsuOBkAi3
         i56Tl3Wf6++G9m06/YV3JaanyMvwMxaxwaqfaIrTFPpbEOBHAINomXiAafvUA3u7XH
         y/mMZU3hi355+G+E5bcuZpvTFkoUamJjEJXTbMUQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.14 131/222] libnvdimm: Hold reference on parent while scheduling async init
Date:   Sun, 11 Nov 2018 14:23:48 -0800
Message-Id: <20181111221659.315096671@linuxfoundation.org>
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

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

commit b6eae0f61db27748606cc00dafcfd1e2c032f0a5 upstream.

Unlike asynchronous initialization in the core we have not yet associated
the device with the parent, and as such the device doesn't hold a reference
to the parent.

In order to resolve that we should be holding a reference on the parent
until the asynchronous initialization has completed.

Cc: <stable@vger.kernel.org>
Fixes: 4d88a97aa9e8 ("libnvdimm: ...base ... infrastructure")
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvdimm/bus.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -484,6 +484,8 @@ static void nd_async_device_register(voi
 		put_device(dev);
 	}
 	put_device(dev);
+	if (dev->parent)
+		put_device(dev->parent);
 }
 
 static void nd_async_device_unregister(void *d, async_cookie_t cookie)
@@ -503,6 +505,8 @@ void __nd_device_register(struct device
 	if (!dev)
 		return;
 	dev->bus = &nvdimm_bus_type;
+	if (dev->parent)
+		get_device(dev->parent);
 	get_device(dev);
 	async_schedule_domain(nd_async_device_register, dev,
 			&nd_async_domain);


