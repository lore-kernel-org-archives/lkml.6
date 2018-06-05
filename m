Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbeFETBa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:01:30 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44333 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbeFETB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:01:29 -0400
X-Google-Smtp-Source: ADUXVKLbnm9NYaeZbOnCmvkwpKt6Eq+OombUbqn1W7uf40tQIqO+Ln6PwfbcBVehhQ4AgQkz4Ux3fQ==
From: Ravi Chandra Sadineni <ravisadineni@chromium.org>
To: dmitry.torokhov@gmail.com, rafael@kernel.org, chenhong3@huawei.com,
        ravisadineni@google.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        rajatja@google.com, bleung@google.com, furquan@chromium.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject: [PATCH V3] i8042: Increment wakeup_count for the respective port.
Date: Tue,  5 Jun 2018 12:01:24 -0700
Message-Id: <20180605190124.191827-1-ravisadineni@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
In-Reply-To: <CAJZ5v0iu23LqdKUJA5OQGF3Yqq3=k+nfNUVn-LFpYgkDrgokCg@mail.gmail.com>
References: <CAJZ5v0iu23LqdKUJA5OQGF3Yqq3=k+nfNUVn-LFpYgkDrgokCg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call pm_wakeup_event on every irq. This should help us in identifying if
keyboard was a potential wake reason for the last resume.

Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
---
V3: Remove the unnecessary device_may_wakeup check.
V2: Increment the wakeup count only when there is a irq and not when the
method is called internally.

 drivers/input/serio/i8042.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 824f4c1c1f310..b8bc71569349d 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -573,6 +573,9 @@ static irqreturn_t i8042_interrupt(int irq, void *dev_id)
 	port = &i8042_ports[port_no];
 	serio = port->exists ? port->serio : NULL;
 
+	if (irq && serio)
+		pm_wakeup_event(&serio->dev, 0);
+
 	filter_dbg(port->driver_bound, data, "<- i8042 (interrupt, %d, %d%s%s)\n",
 		   port_no, irq,
 		   dfl & SERIO_PARITY ? ", bad parity" : "",
-- 
2.17.1.1185.g55be947832-goog
