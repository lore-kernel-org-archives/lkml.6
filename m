Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06D0C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F6721479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuC1vr1X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F6721479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732789AbeJICGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:06:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732457AbeJICGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:06:42 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6AB92087D;
        Mon,  8 Oct 2018 18:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024814;
        bh=upZJhyvuQR7i0+eTSgS+8Tj4GN+Vi4ZXvKQI3gk3h/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LuC1vr1XHB5huWxmu6Xd/JM2LICD7Tyxh+6zEuPuYyKf4BWe6/BgmiyQ/ZI82YHp7
         NXjG0qc3QCR8HqKUygykaQ8LIdZF4IMTHeLwgGVcgQvRt7nD5j11Erx+38HBTJSttS
         SnUJRk3j/flcBUbwfgOtboAMBt3CBn14eyXqMqB8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Timur Tabi <timur@codeaurora.org>,
        Jan Lorenzen <jl@newtec.dk>, Jim Paris <jim@jtan.com>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.18 162/168] gpiolib: Free the last requested descriptor
Date:   Mon,  8 Oct 2018 20:32:22 +0200
Message-Id: <20181008175626.216039559@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -565,7 +565,7 @@ static int linehandle_create(struct gpio
 		if (ret)
 			goto out_free_descs;
 		lh->descs[i] = desc;
-		count = i;
+		count = i + 1;
 
 		if (lflags & GPIOHANDLE_REQUEST_ACTIVE_LOW)
 			set_bit(FLAG_ACTIVE_LOW, &desc->flags);


