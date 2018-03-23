Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtJ5Ez+iHArbfDCLLeRu/fVS3zy0D/bHAgZldMqs2NbDpkSBC3BAJ5rzv5Ggly2fM7WxFB4
ARC-Seal: i=1; a=rsa-sha256; t=1521800409; cv=none;
        d=google.com; s=arc-20160816;
        b=VdIouEKrH6AYkkHnjJQgl3rfovVBaixLlYyc3nr7+jOnbForJjETcIQnR0KEL8QG1j
         N+jPEqlImOa2ZwyZBNRhi2eS1P8DcQ9VmUqFM5BJt+5M2Er/YBEJoBMroU6HByuMhW2k
         lmE+dd/+PmMQc2u3y4weIPqGCkC3R0LyhCp4wNt+g6nrBME7PCzhfDc12CSy1KZ35ffT
         e5+fMJXwb4D2kp2GkhaMlNOOyjC/00Tx3HDpYoKof4Yy8UN5p6R7224Yf86AweM6fyiG
         Si+zhxVUs/QB5trqKRl6oKuEUcaxCoGiCIywEvWuL4dBfORiu6rqb6uXoB8F3PZR2Alq
         Yxbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=B+zBOQhCCXZwhEQw7iuNnpH5QUpoo8cJ0Xkk6YrV9sk=;
        b=PTKl+DVuU8Lrw6apyD7stZ+akeN+0L8RS5/oUdEu/ItXHYizO5gDzkZCDVRHXzKy5n
         zaHH/OIEXT1tD7QQoUYa4M0uVJIqAWh0Ln3J9e8Vvxc5vXzYYc8+aG8++hRIuAEQRJHF
         cpcu875QtLm69hSFKj4VXl1PkkpAmAyAyJ/ZmgfjQLRoKlgWbo7y2SzKHKETOIZcE/Me
         SL1oh9RNqoOCaw2e3NB2YysaMLkrQwN2/CbzwKXe10FM2cl8VZT0aH8k7eKevKkjp2Q0
         qi0T+2tHo8OgWaa7OVBgxAQ0xtZdqDY9+hEUwPtMjk5W3YV+0ELlVSv+OMUl48DKs1mh
         NmGA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 43/47] vgacon: Set VGA struct resource types
Date: Fri, 23 Mar 2018 10:55:34 +0100
Message-Id: <20180323094249.952842099@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595721978952936095?=
X-GMAIL-MSGID: =?utf-8?q?1595723386653922928?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Helgaas <bhelgaas@google.com>


[ Upstream commit c82084117f79bcae085e40da526253736a247120 ]

Set the resource type when we reserve VGA-related I/O port resources.

The resource code doesn't actually look at the type, so it inserts
resources without a type in the tree correctly even without this change.
But if we ever print a resource without a type, it looks like this:

  vga+ [??? 0x000003c0-0x000003df flags 0x0]

Setting the type means it will be printed correctly as:

  vga+ [io  0x000003c0-0x000003df]

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/alpha/kernel/console.c    |    1 +
 drivers/video/console/vgacon.c |   34 ++++++++++++++++++++++++++--------
 2 files changed, 27 insertions(+), 8 deletions(-)

--- a/arch/alpha/kernel/console.c
+++ b/arch/alpha/kernel/console.c
@@ -20,6 +20,7 @@
 struct pci_controller *pci_vga_hose;
 static struct resource alpha_vga = {
 	.name	= "alpha-vga+",
+	.flags	= IORESOURCE_IO,
 	.start	= 0x3C0,
 	.end	= 0x3DF
 };
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -409,7 +409,10 @@ static const char *vgacon_startup(void)
 		vga_video_port_val = VGA_CRT_DM;
 		if ((screen_info.orig_video_ega_bx & 0xff) != 0x10) {
 			static struct resource ega_console_resource =
-			    { .name = "ega", .start = 0x3B0, .end = 0x3BF };
+			    { .name	= "ega",
+			      .flags	= IORESOURCE_IO,
+			      .start	= 0x3B0,
+			      .end	= 0x3BF };
 			vga_video_type = VIDEO_TYPE_EGAM;
 			vga_vram_size = 0x8000;
 			display_desc = "EGA+";
@@ -417,9 +420,15 @@ static const char *vgacon_startup(void)
 					 &ega_console_resource);
 		} else {
 			static struct resource mda1_console_resource =
-			    { .name = "mda", .start = 0x3B0, .end = 0x3BB };
+			    { .name	= "mda",
+			      .flags	= IORESOURCE_IO,
+			      .start	= 0x3B0,
+			      .end	= 0x3BB };
 			static struct resource mda2_console_resource =
-			    { .name = "mda", .start = 0x3BF, .end = 0x3BF };
+			    { .name	= "mda",
+			      .flags	= IORESOURCE_IO,
+			      .start	= 0x3BF,
+			      .end	= 0x3BF };
 			vga_video_type = VIDEO_TYPE_MDA;
 			vga_vram_size = 0x2000;
 			display_desc = "*MDA";
@@ -441,15 +450,21 @@ static const char *vgacon_startup(void)
 			vga_vram_size = 0x8000;
 
 			if (!screen_info.orig_video_isVGA) {
-				static struct resource ega_console_resource
-				    = { .name = "ega", .start = 0x3C0, .end = 0x3DF };
+				static struct resource ega_console_resource =
+				    { .name	= "ega",
+				      .flags	= IORESOURCE_IO,
+				      .start	= 0x3C0,
+				      .end	= 0x3DF };
 				vga_video_type = VIDEO_TYPE_EGAC;
 				display_desc = "EGA";
 				request_resource(&ioport_resource,
 						 &ega_console_resource);
 			} else {
-				static struct resource vga_console_resource
-				    = { .name = "vga+", .start = 0x3C0, .end = 0x3DF };
+				static struct resource vga_console_resource =
+				    { .name	= "vga+",
+				      .flags	= IORESOURCE_IO,
+				      .start	= 0x3C0,
+				      .end	= 0x3DF };
 				vga_video_type = VIDEO_TYPE_VGAC;
 				display_desc = "VGA+";
 				request_resource(&ioport_resource,
@@ -493,7 +508,10 @@ static const char *vgacon_startup(void)
 			}
 		} else {
 			static struct resource cga_console_resource =
-			    { .name = "cga", .start = 0x3D4, .end = 0x3D5 };
+			    { .name	= "cga",
+			      .flags	= IORESOURCE_IO,
+			      .start	= 0x3D4,
+			      .end	= 0x3D5 };
 			vga_video_type = VIDEO_TYPE_CGA;
 			vga_vram_size = 0x2000;
 			display_desc = "*CGA";
