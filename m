Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34ADC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C52214C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uIqSa6kn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C52214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbeJIBxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:53:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbeJIBxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:53:37 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 638E92087D;
        Mon,  8 Oct 2018 18:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024032;
        bh=CpTJvQn4pbIsnSYCsRHJSJaLC2Wq5nl1WthIXZwin/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uIqSa6kn8LwxjtB3hPhsqkDRFciuY3Dw/RihwsPsBUcBCW4/2fE4moDaQhmIc6HVW
         SeRGBS/9XAxhzYRqqjIoi5yHdxpqxLxJ0k+PnmUqKLuc9mU8KFkd3UAkv92nsupWRq
         Ejrh/XiK7scppv9LKlHVizNnHhtAFg9kPH1eL7YU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Timur Tabi <timur@codeaurora.org>,
        Jan Lorenzen <jl@newtec.dk>, Jim Paris <jim@jtan.com>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.9 57/59] gpiolib: Free the last requested descriptor
Date:   Mon,  8 Oct 2018 20:32:04 +0200
Message-Id: <20181008175553.028491285@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175546.620836256@linuxfoundation.org>
References: <20181008175546.620836256@linuxfoundation.org>
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

From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

commit 19a4fbffc94e41abaa2a623a25ce2641d69eccf0 upstream.

The current code only frees N-1 gpios if an error occurs during
gpiod_set_transitory, gpiod_direction_output or gpiod_direction_input.
Leading to gpios that cannot be used by userspace nor other drivers.

Cc: Timur Tabi <timur@codeaurora.org>
Cc: stable@vger.kernel.org
Fixes: ab3dbcf78f60f46d ("gpioib: do not free unrequested descriptors)
Reported-by: Jan Lorenzen <jl@newtec.dk>
Reported-by: Jim Paris <jim@jtan.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpiolib.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -471,7 +471,7 @@ static int linehandle_create(struct gpio
 		if (ret)
 			goto out_free_descs;
 		lh->descs[i] = desc;
-		count = i;
+		count = i + 1;
 
 		if (lflags & GPIOHANDLE_REQUEST_ACTIVE_LOW)
 			set_bit(FLAG_ACTIVE_LOW, &desc->flags);


