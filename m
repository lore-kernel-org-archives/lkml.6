Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753206AbeFASBG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 14:01:06 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39719 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753104AbeFASA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 14:00:58 -0400
X-Google-Smtp-Source: ADUXVKKcWXYMYYm/qahD32uFg+/ZFNl+8mstd+Vi56lt4720lVUoynamlIu4rcmggfuJ1BRW1znZEw==
From: Ravi Chandra Sadineni <ravisadineni@chromium.org>
To: dmitry.torokhov@gmail.com, chenhong3@huawei.com,
        ravisadineni@chromium.org, ravisadineni@google.com, dtor@google.com
Cc: tbroch@google.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, rajatja@google.com, bleung@google.com
Subject: [PATCH] i8042: Increment wakeup_count for the respective port.
Date: Fri,  1 Jun 2018 11:00:53 -0700
Message-Id: <20180601180053.120202-1-ravisadineni@chromium.org>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call pm_wakeup_event on every irq. This should help us in identifying if
i8042 port was a potential wake reason for the last resume.

Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
---
 drivers/input/serio/i8042.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 824f4c1c1f310..96e27766d553d 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -573,6 +573,9 @@ static irqreturn_t i8042_interrupt(int irq, void *dev_id)
 	port = &i8042_ports[port_no];
 	serio = port->exists ? port->serio : NULL;
 
+	if (serio && device_may_wakeup(&serio->dev))
+		pm_wakeup_event(&serio->dev, 0);
+
 	filter_dbg(port->driver_bound, data, "<- i8042 (interrupt, %d, %d%s%s)\n",
 		   port_no, irq,
 		   dfl & SERIO_PARITY ? ", bad parity" : "",
-- 
2.17.0.921.gf22659ad46-goog
