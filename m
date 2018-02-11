Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x225uA8nwJECM3oZbdCChkdLLiI1x1m3z6Yr2P2+QQOh99eLTs4G/9FRC05lT88KsI3b4Qf2n
ARC-Seal: i=1; a=rsa-sha256; t=1518323622; cv=none;
        d=google.com; s=arc-20160816;
        b=vHojktc//TAfN238AI+wXsx+ZxgsIECETquY2SHnNQ4FPr5IU6Xu7jeF8oPsJZN7vf
         KX8r6R09xNgnSuBAaxxxVMkYVnkD8mZD3YkFrK1svEbS+hDDejv2lqtf3hfxPbbfVLIe
         7izN5R/w6cEB7FPStqf7I+M9BZNXAH4l5Qy4kemqooQp2P/Fir9UOayRfG3CdHtoNGP+
         fzwVOCDOiLawTkq42S5m3nkWwXC058v1Mq1IZbaaNBFz3RycLnr6p7DaXpF4vpUM6Ssn
         +4x42X5TAv4bSmZ6kLfHmvFh1VZi06YIUE3Z0pzdgvLKgv4BoyP90k8GapPfY2XeoLdg
         1w8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=/aGKCGAuCxUAiYB/qzwHW+aGTBZ0Y9vqhiufqTjuORU=;
        b=ABqk/ZAZdQl+sTFDmGw0GOWXNxGFwpQ1k0VTOaQyky49EheoS5VOQflEGDa0EZ7fAm
         ezWhdM1UpCA0zrvM4V7DaeTT3ldkIcGgVL8xu4vbHQFS/LlWZYjI0LX55YsEqZv9z2Jd
         0g+g8OCC47P+aYilQeYFZwkpCBvajIw+FydvhG8nyRbqT5k6dcnDp2lDjeCyJXyBHVNI
         pAjCazj6M94cerpmamczA0c4/KHzHSXEvt+UZygMS4fXuVGPS58MDIrsihB4QsuxB34m
         Yq/LJsQgb01x5puSeVyHU3DRCXUBsU7S2nsBNNATlzzeMYksOmij+8GD3+/6FbkTQ0nV
         FN8w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Alan" <gnomes@lxorguk.ukuu.org.uk>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Alan Cox" <alan@linux.intel.com>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.418920876@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 71/79] usbip: Fix sscanf handling
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592077710672305006?=
X-GMAIL-MSGID: =?utf-8?q?1592077710672305006?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Alan <gnomes@lxorguk.ukuu.org.uk>

commit 2d32927127f44d755780aa5fa88c8c34e72558f8 upstream.

Scan only to the length permitted by the buffer

One of a set of sscanf problems noted by Jackie Chang

Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/usbip/userspace/libsrc/usbip_common.c | 2 +-
 drivers/staging/usbip/userspace/libsrc/vhci_driver.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/staging/usbip/userspace/libsrc/usbip_common.c
+++ b/drivers/staging/usbip/userspace/libsrc/usbip_common.c
@@ -164,7 +164,7 @@ int read_attr_speed(struct sysfs_device
 		goto err;
 	}
 
-	ret = sscanf(attr->value, "%s\n", speed);
+	ret = sscanf(attr->value, "%99s\n", speed);
 	if (ret < 1) {
 		dbg("sscanf failed");
 		goto err;
--- a/drivers/staging/usbip/userspace/libsrc/vhci_driver.c
+++ b/drivers/staging/usbip/userspace/libsrc/vhci_driver.c
@@ -66,7 +66,7 @@ static int parse_status(char *value)
 		unsigned long socket;
 		char lbusid[SYSFS_BUS_ID_SIZE];
 
-		ret = sscanf(c, "%d %d %d %x %lx %s\n",
+		ret = sscanf(c, "%d %d %d %x %lx %31s\n",
 				&port, &status, &speed,
 				&devid, &socket, lbusid);
 
