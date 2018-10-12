Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8178EC28CF8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 03:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA242098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 03:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olh1cYjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA242098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeJLKoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 06:44:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41538 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeJLKoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 06:44:18 -0400
Received: by mail-pl1-f195.google.com with SMTP id q17-v6so5190658plr.8;
        Thu, 11 Oct 2018 20:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Gq10Tja0XUvcUg2vLUMziAQf2K5i6ue/uwCqC6xStw0=;
        b=olh1cYjWV69NFStSdMTCIWGDgwpc+/L+EhV86OzUtlqc3PF4wAva4rUxrgUT/Csuxl
         7FXRnqGBpSlIJBEKOsNMUiiX7KdH2Zy5/8xMlEi8tspMAQAsyWlhKFSebRpzNcfadytu
         7JRB1mwou+0/WrK//cJeSCBRRy2C24rgs2YZMLNqgNMaY0ThZhbg+XUi1Xoci7GYf5F7
         VDG9x4aoMvl8ZForO6k09+JKGfyweupdwz/Nl0NBE0Dyu9hsp+nb+ypJ3aBjS9dymGzs
         tsEDy00TG3/96vf/SEkme8geWueOAjuPW+pq66aZili9LI1znOYTeTaIL26cAkiOO5xf
         Wncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Gq10Tja0XUvcUg2vLUMziAQf2K5i6ue/uwCqC6xStw0=;
        b=XLDUV4AYppVHgUaBgp0XXmBa/8xHAIhCk5VOeMBWOk3Bgtn+IxP639OYN63VzIz0mV
         h7usFVC6enx5I45xuKFI/wmXfFlv0hFVrN0eEt/iZuy8AXI/oQ9cz1I8CV6ZugBCUby0
         aziVenYzjNDxk7Gy2cTNV+GucOaR1yeuhLWgxmWCKl7tMSS/nPiDzT5EQlfISV/U00QD
         YBneQ0J91+hGUm+RZfGzKg7l7DIqWn/MjvLHGlvGEItKLBaconBVoCmoRfmoszOdNS84
         V7DR0++B8zthBJwylIgPrfALtFsQChkjKEpw63MXxOmpjsuDEc5WHI1j8T8MqwRgWT8c
         6eNg==
X-Gm-Message-State: ABuFfog4Gga61H0Da4t7YYiMqriCHiCYw9lc/wnB19wDiFnXArXipMXR
        Cg8oJQeaFKTMNx0ujAMs/rO8De6n6/Hn0IX21fs=
X-Google-Smtp-Source: ACcGV62JgPilMztl+BXHPQPlbaIJvjIcwM8OmdLX/+KeDCQ1NHHnd43JUsFSa/3/4+SJ/zoM6qqE23Xodl2kqh2v1qg=
X-Received: by 2002:a17:902:758f:: with SMTP id j15-v6mr4210495pll.160.1539314043464;
 Thu, 11 Oct 2018 20:14:03 -0700 (PDT)
MIME-Version: 1.0
From:   Feng Li <lifeng1519@gmail.com>
Date:   Fri, 12 Oct 2018 11:13:36 +0800
Message-ID: <CAEK8JBAgRwHZDBrNDNmmRXC3WgX9tVqeoFk5edLHfJL9OWQ-zg@mail.gmail.com>
Subject: [PATCH] smartpqi: Fix timeout of smartpqi probe stage
To:     Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        esc.storagedev@microsemi.com,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I use 'HPE Smart Array E208i-a SR Gen10 Controller', and pass through
the SAS controller from ESXi 6.0U1 to VM, which is installed CentOS 7.4/7.5.
The disk is not found.

The error log is "controller not ready after 30 seconds."

Add some logs, and could check the probe stage needs nearly 36s to match the
status.

Signed-off-by: Li Feng <fengli@smartx.com>
---
 drivers/scsi/smartpqi/smartpqi_sis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/smartpqi/smartpqi_sis.c
b/drivers/scsi/smartpqi/smartpqi_sis.c
index 5141bd4c9..bc7efdacb 100644
--- a/drivers/scsi/smartpqi/smartpqi_sis.c
+++ b/drivers/scsi/smartpqi/smartpqi_sis.c
@@ -59,7 +59,7 @@

 #define SIS_CTRL_KERNEL_UP 0x80
 #define SIS_CTRL_KERNEL_PANIC 0x100
-#define SIS_CTRL_READY_TIMEOUT_SECS 30
+#define SIS_CTRL_READY_TIMEOUT_SECS 90
 #define SIS_CTRL_READY_RESUME_TIMEOUT_SECS 90
 #define SIS_CTRL_READY_POLL_INTERVAL_MSECS 10

--
2.11.0
