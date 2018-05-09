Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934226AbeEIJog (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 05:44:36 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42573 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933824AbeEIJod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 05:44:33 -0400
X-Google-Smtp-Source: AB8JxZomEnsKr3Czxl2t6GeXz5SPLEnA82Xl6NqFkKq+iNnP0mXauMuOL/PXNlGh4OSPaFErvzJ8/A==
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-pm@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH EXAMPLE 2/2] dbg: gnss: sirf: allow aggressive controller runtime PM
Date: Wed,  9 May 2018 11:44:19 +0200
Message-Id: <20180509094419.13470-2-johan@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509094419.13470-1-johan@kernel.org>
References: <20180509094419.13470-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just an example of how a serdev driver could go about to allow
aggressive controller runtime PM by dropping the RPM reference taken by
serdev core in serdev_device_open().

Note that for most GNSS devices this does not make any sense, as
allowing the controller to suspend this way would cause the
first message of every report burst to be corrupted (and discarded).

This one applies on top of the GNSS series available here:

https://lkml.kernel.org/r/20180424163458.11947-1-johan@kernel.org

Not-Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gnss/sirf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gnss/sirf.c b/drivers/gnss/sirf.c
index 497f8eb8467f..31b2cbccd194 100644
--- a/drivers/gnss/sirf.c
+++ b/drivers/gnss/sirf.c
@@ -57,6 +57,9 @@ static int sirf_open(struct gnss_device *gdev)
 		goto err_close;
 	}
 
+	/* Allow aggresive controller runtime PM. */
+	pm_runtime_put(&serdev->ctrl->dev);
+
 	return 0;
 
 err_close:
@@ -70,6 +73,9 @@ static void sirf_close(struct gnss_device *gdev)
 	struct sirf_data *data = gnss_get_drvdata(gdev);
 	struct serdev_device *serdev = data->serdev;
 
+	/* Balance the put in open() */
+	pm_runtime_get(&serdev->ctrl->dev);
+
 	serdev_device_close(serdev);
 
 	pm_runtime_put(&serdev->dev);
-- 
2.17.0
