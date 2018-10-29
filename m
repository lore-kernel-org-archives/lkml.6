Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15800C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D601020870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X6zq0rVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D601020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbeJ3C6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:58:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45904 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbeJ3C6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:58:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id u4-v6so2054881pfh.12
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 11:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A8kE1y74WrNbch+Pm8WYxUSy4VwhJ7sii0IByUd29HU=;
        b=X6zq0rVdI/U0imQlcGfm8h4cFAe6I2lYvt4lwirdpW+MWOXkY116yEeWIVc1nRupgm
         m1Z7i3kxRusG3ud5BCJrjaZG3wsN2LRMj1Wdndoz9LNyIl+NRpCRw0+pYdzSgvwRQwe5
         6i4Kjd5/0asACQc5efn38F0l9sOfVpIqWyK6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A8kE1y74WrNbch+Pm8WYxUSy4VwhJ7sii0IByUd29HU=;
        b=rH9BfKv2lJq/fZU2EsZM37mp2fkdWBxOue8cdAvaCOzaw1h6vEYVL5gEDvgu4gfWja
         QcJJ5HtysEdFFspfpl8hWPGvY1SPzpZL2b1OT8NpAg2EaLXmtCJGchTmtihNOs3FpvdY
         LUoN3VhAl/FwVDWNfQNQnn0Z/vJ72cjfJA+eWP+cmN71JwnBoEubrTUiyiwiTK1rXc+Q
         XxOvP42AO7mg9+yHK6w/XS21JtDenQR6iRlJpIIbHfVn7D9EazNSwvGaKYxuqZ3CtZ6x
         k6oRmIb0j6r7Vul9W1rYynJ8oLHl42u2IKcpoU4HdiC/B+PzU2kNCKNPfZm43xm+/N4+
         jFdA==
X-Gm-Message-State: AGRZ1gJa9vPNDu0JF7GmlyAHf0Q+QDnHofC+gfsvII3KELpW2Sm5MY6G
        /88uOK6IWeRfoLo5A/8ZQKDvGA==
X-Google-Smtp-Source: AJdET5dOO2QgKiW1XSTCXfDMTitiT8GoQgeir70QFFNlMVmIgQPI3QKqLolP7LGgA7qquTRRMUG2VA==
X-Received: by 2002:a63:82c6:: with SMTP id w189mr14960324pgd.344.1540836503875;
        Mon, 29 Oct 2018 11:08:23 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id u13-v6sm20537765pgp.18.2018.10.29.11.08.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 11:08:22 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        tglx@linutronix.de, mingo@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        jslaby@suse.com
Subject: [PATCH 1/7] serial: qcom_geni_serial: Finish supporting sysrq
Date:   Mon, 29 Oct 2018 11:07:01 -0700
Message-Id: <20181029180707.207546-2-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181029180707.207546-1-dianders@chromium.org>
References: <20181029180707.207546-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The geni serial driver already had some sysrq code in it, but since
SUPPORT_SYSRQ wasn't defined the code didn't do anything useful.
Let's make it useful by adding that define using the same formula
found in other serial drivers.

In order to prevent deadlock, we'll take a page from the
'msm_serial.c' where the spinlock is released around
uart_handle_sysrq_char().  This seemed better than copying from
'8250_port.c' where we skip locking in the console_write function
since the '8250_port.c' method can cause lockdep warnings when
dropping into kgdb.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/tty/serial/qcom_geni_serial.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index d3b5261ee80a..3c8e0202da8b 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1,6 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
 
+#if defined(CONFIG_SERIAL_QCOM_GENI_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+# define SUPPORT_SYSRQ
+#endif
+
 #include <linux/clk.h>
 #include <linux/console.h>
 #include <linux/io.h>
@@ -495,7 +499,10 @@ static int handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
 					continue;
 			}
 
+			spin_unlock(&uport->lock);
 			sysrq = uart_handle_sysrq_char(uport, buf[c]);
+			spin_lock(&uport->lock);
+
 			if (!sysrq)
 				tty_insert_flip_char(tport, buf[c], TTY_NORMAL);
 		}
-- 
2.19.1.568.g152ad8e336-goog

