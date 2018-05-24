Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965333AbeEXIdu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:33:50 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46518 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964864AbeEXIdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:33:47 -0400
X-Google-Smtp-Source: AB8JxZpwmu0zB7dZwEZhRK7YAEM7jbVfmifj+Q0m8MpJDd25aN+yGcXWk8WTfnJa7l/ZNigJ3c1VCw==
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Jon Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PM / runtime: Drop usage count for suppliers at device link removal
Date: Thu, 24 May 2018 10:33:36 +0200
Message-Id: <1527150816-8459-1-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case consumer device is runtime resumed, while the link to the
supplier is removed, the earlier call to pm_runtime_get_sync() made from
rpm_get_suppliers() does not get properly balanced with a corresponding
call to pm_runtime_put(). This leads to that suppliers remains to be
runtime resumed forever, while they don't need to.

Let's fix the behaviour by calling rpm_put_suppliers() when dropping a
device link. Not that, since rpm_put_suppliers() checks the
link->rpm_active flag, we can correctly avoid to call pm_runtime_put() in
cases when we shouldn't.

Reported-by: Todor Tomov <todor.tomov@linaro.org>
Fixes: 21d5c57b3726 ("PM / runtime: Use device links")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Rafael, I am not sure if this is safe from locking point of view. The device
link write lock has been taken when pm_runtime_drop_link() is called, hence I
assume calling rpm_put_suppliers() should be fine!? If not, can you please
advise how to change?

Kind regards
Uffe

---
 drivers/base/power/runtime.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 8bef3cb..beb85c3 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1607,6 +1607,8 @@ void pm_runtime_new_link(struct device *dev)
 
 void pm_runtime_drop_link(struct device *dev)
 {
+	rpm_put_suppliers(dev);
+
 	spin_lock_irq(&dev->power.lock);
 	WARN_ON(dev->power.links_count == 0);
 	dev->power.links_count--;
-- 
2.7.4
