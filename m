Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELvjMfqG6zNe8eUQgGU5O4h6tX2eilOVsRw9ndAbMUHT4JK3t38WZWTuIqhapF5WwwcNHEX/
ARC-Seal: i=1; a=rsa-sha256; t=1519831335; cv=none;
        d=google.com; s=arc-20160816;
        b=iNI6qSfEqHiNACK/Qy2pMkF1kjV9SiI6HN09m4vME7FpObCkLlmycOowDnnLFEKnWW
         R8TqeAX861fqu+KeeDN+jMiW9UFp8zXu+zSqwajJiAgiM+Qa8HlYoV9fdeN1Z4VJnLOz
         sxJNerskNSa4plh2lwb6dPceNehfkrkzyzlb21UEyaIko1Hit+IyeVUz1z0fKBeeo+ff
         6R/dT01F554JohOtYaWdJvOukxO2zeBksr7dT8wr9iGxq5cIsmppKQ9gZMg+GPsyyNG3
         er/y0uZE72VfjpsknhSRBay+lItIh0HkK1KFD9m2v6MPdsGrhtpGNH4VAme9+zErZ8bk
         aGFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=H6yjl/x0zmp9+9GQaqhjEYsI1mp6W+akXsdSl2uYOLY=;
        b=qAnzxrpwd9T/H73QFPGQG1HDLNfOYw+QGS79Z7ueBw0y2qHWEZ8YVc77RlVQY233c3
         6vz8tWtFp4fZZj0a1SEAPMSd5y2qevTGSYT1AlwEr2YINcUF+4BpVPVUfIslsXuO0Jeb
         EdPzhFYMJ3kXsze0yUa0Wv4HUNgRU3RuuvxyHtVXzVWG+jGRY2PPiYesYSVCjZXdtx6z
         d3iyKL/v6VO1kj0FHq/84A5L8P/1vPDjJklh0ghTH9NxxpOcGKngyzxVpKMH3TR1d9ba
         kt9cS+wkieAeP/m+Xbdni7FsLaiJUvJIbQSlxbXx0eLpumw4CWZlycTUwSd5SGmICW22
         etbw==
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
 "Shuah Khan" <shuahkh@osg.samsung.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.763585244@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 081/140] usbip: remove kernel addresses from usb
 device and urb debug msgs
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593658662870212572?=
X-GMAIL-MSGID: =?utf-8?q?1593658662870212572?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>

commit e1346fd87c71a1f61de1fe476ec8df1425ac931c upstream.

usbip_dump_usb_device() and usbip_dump_urb() print kernel addresses.
Remove kernel addresses from usb device and urb debug msgs and improve
the message content.

Instead of printing parent device and bus addresses, print parent device
and bus names.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.2: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/staging/usbip/usbip_common.c
+++ b/drivers/staging/usbip/usbip_common.c
@@ -115,7 +115,7 @@ static void usbip_dump_usb_device(struct
 		break;
 	}
 
-	pr_debug("tt %p, ttport %d\n", udev->tt, udev->ttport);
+	pr_debug("tt hub ttport %d\n", udev->ttport);
 
 	dev_dbg(dev, "                    ");
 	for (i = 0; i < 16; i++)
@@ -148,11 +148,8 @@ static void usbip_dump_usb_device(struct
 	}
 	pr_debug("\n");
 
-	dev_dbg(dev, "parent %p, bus %p\n", udev->parent, udev->bus);
-
-	dev_dbg(dev, "descriptor %p, config %p, actconfig %p, "
-		"rawdescriptors %p\n", &udev->descriptor, udev->config,
-		udev->actconfig, udev->rawdescriptors);
+	dev_dbg(dev, "parent %s, bus %s\n", dev_name(&udev->parent->dev),
+		udev->bus->bus_name);
 
 	dev_dbg(dev, "have_langid %d, string_langid %d\n",
 		udev->have_langid, udev->string_langid);
@@ -261,9 +258,6 @@ void usbip_dump_urb(struct urb *urb)
 
 	dev = &urb->dev->dev;
 
-	dev_dbg(dev, "   urb                   :%p\n", urb);
-	dev_dbg(dev, "   dev                   :%p\n", urb->dev);
-
 	usbip_dump_usb_device(urb->dev);
 
 	dev_dbg(dev, "   pipe                  :%08x ", urb->pipe);
@@ -272,11 +266,9 @@ void usbip_dump_urb(struct urb *urb)
 
 	dev_dbg(dev, "   status                :%d\n", urb->status);
 	dev_dbg(dev, "   transfer_flags        :%08X\n", urb->transfer_flags);
-	dev_dbg(dev, "   transfer_buffer       :%p\n", urb->transfer_buffer);
 	dev_dbg(dev, "   transfer_buffer_length:%d\n",
 						urb->transfer_buffer_length);
 	dev_dbg(dev, "   actual_length         :%d\n", urb->actual_length);
-	dev_dbg(dev, "   setup_packet          :%p\n", urb->setup_packet);
 
 	if (urb->setup_packet && usb_pipetype(urb->pipe) == PIPE_CONTROL)
 		usbip_dump_usb_ctrlrequest(
@@ -286,8 +278,6 @@ void usbip_dump_urb(struct urb *urb)
 	dev_dbg(dev, "   number_of_packets     :%d\n", urb->number_of_packets);
 	dev_dbg(dev, "   interval              :%d\n", urb->interval);
 	dev_dbg(dev, "   error_count           :%d\n", urb->error_count);
-	dev_dbg(dev, "   context               :%p\n", urb->context);
-	dev_dbg(dev, "   complete              :%p\n", urb->complete);
 }
 EXPORT_SYMBOL_GPL(usbip_dump_urb);
 
