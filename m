Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/JuHa+IafMNH5/XFkdDwh4ddN8Idq+7p49cDGml8h0eZmYZyRn/BIFVOjx0ITzFjJ5GarN
ARC-Seal: i=1; a=rsa-sha256; t=1523473003; cv=none;
        d=google.com; s=arc-20160816;
        b=pkUi0Q9xjBBRmGzJv8KbiJP9APuY76y9awMXXl2+BldUqgPx1xGQ3hGkRY6Zwsnnpe
         nrmkJ6hRKkG79xjhOipy26gtMi+b3HSplg5CC5XhEXpZ5jeQHx4S/C2TsJJqKYGYEphS
         zBbk9teDOIUs8hh8n5zcr0irBBr7m0a+H3rdCDma8IAAtLiwS8vuazYK/wyxRxjkMXTR
         DZ621pcg60FgQrKtjMHQmQrM8nA4x2p312AGf89NU9nwnSbB35QFdHJ+luRgIkmzMc1u
         L4BFvUupPybJ4jM0QLsrCuBGUpdaJsqG7qZ+1FJEhjm7pUzH676Scbl+uCq8pc5Ty00C
         hjbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=w+zSpbJSwnB9t2rnmZIQV9+ngilIikBFT2QZVu9xPnI=;
        b=D5d6NPDyTKUfmxO//g8wcwfWd7xR02G/ahlrsBzAAYqqa7CrlLRRSS/2i9lIkG8awP
         K2qB/JPQMXqPNnitYy8/e5Jwv0sOu3ONYyPJnOllvEYhlcVz5q44YNQVSd9dli3xgO3O
         ylBSLxU9rD1/pOcnRuPAIBGtP/nGY8un4qbESbiNCxWDUZS3p9O8n14tvACLJmd8qQjC
         cfccghZyjSS8gZzRN98/WuGmDugtJJ2lIF7TLMDi/3ZU+vuYj1IJUFL4StLvbkK86Vu3
         syH4rVDeJZoJW+A4oon73TYBz7oROGnBKRg/CYvXTac4SvSToUIJJpecf4FvkBO7N/0l
         l20w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 067/310] USB: ene_usb6250: fix first command execution
Date: Wed, 11 Apr 2018 20:33:26 +0200
Message-Id: <20180411183625.209846376@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476107842808585?=
X-GMAIL-MSGID: =?utf-8?q?1597477227678958483?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alan Stern <stern@rowland.harvard.edu>


[ Upstream commit 4b309f1c4972c8f09e03ac64fc63510dbf5591a4 ]

In the ene_usb6250 sub-driver for usb-storage, the ene_transport()
routine is supposed to initialize the driver before executing the
current command, if the initialization has not already been performed.
However, a bug in the routine causes it to skip the command after
doing the initialization.  Also, the routine does not return an
appropriate error code if either the initialization or the command
fails.

As a result of the first bug, the first command (a SCSI INQUIRY) is
not carried out.  The results can be seen in the system log, in the
form of a warning message and empty or garbage INQUIRY data:

Apr 18 22:40:08 notebook2 kernel: scsi host6: scsi scan: INQUIRY result too short (5), using 36
Apr 18 22:40:08 notebook2 kernel: scsi 6:0:0:0: Direct-Access                                    PQ: 0 ANSI: 0

This patch fixes both errors.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-and-tested-by: Andreas Hartmann <andihartmann@01019freenet.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/storage/ene_ub6250.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/usb/storage/ene_ub6250.c
+++ b/drivers/usb/storage/ene_ub6250.c
@@ -2295,21 +2295,22 @@ static int ms_scsi_irp(struct us_data *u
 
 static int ene_transport(struct scsi_cmnd *srb, struct us_data *us)
 {
-	int result = 0;
+	int result = USB_STOR_XFER_GOOD;
 	struct ene_ub6250_info *info = (struct ene_ub6250_info *)(us->extra);
 
 	/*US_DEBUG(usb_stor_show_command(us, srb)); */
 	scsi_set_resid(srb, 0);
-	if (unlikely(!(info->SD_Status.Ready || info->MS_Status.Ready))) {
+	if (unlikely(!(info->SD_Status.Ready || info->MS_Status.Ready)))
 		result = ene_init(us);
-	} else {
+	if (result == USB_STOR_XFER_GOOD) {
+		result = USB_STOR_TRANSPORT_ERROR;
 		if (info->SD_Status.Ready)
 			result = sd_scsi_irp(us, srb);
 
 		if (info->MS_Status.Ready)
 			result = ms_scsi_irp(us, srb);
 	}
-	return 0;
+	return result;
 }
 
 static struct scsi_host_template ene_ub6250_host_template;
