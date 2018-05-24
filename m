Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpHJhY52P6gHIg9dayDmz8HwFwLX/q9KnS6YqWg/Vufav+6MbBemTYWy9/O2WYgG70SOIdr
ARC-Seal: i=1; a=rsa-sha256; t=1527156319; cv=none;
        d=google.com; s=arc-20160816;
        b=hzMZ0ZPlY0JoLmLRjZfJA0KHsMT0LSgtLGvwqCVFX43HjnTOe4qkH/rLISGx8nCAVJ
         XU0P8KeLi78AixOGQXWy/xWDQWe44yPB4ZiIGQjuE2Dz/dWe1CAY2aCVzSQsBK2uO/Mo
         5YDNRN0mJQeFgxxgLfeqp4KTB1T8NT7hKXJMcbScC5U8xwXxyn7Dwq5omQfszUMXLo2r
         sjBJfiF8X2+y0NRd671mTGAg5b1xzbSwK28bWHQCGUeXUpeLnDcgXvzFQ1tz5Z5JdtZU
         cvgDzQ9/Abb1St7/0+gHJPABsAH9maj13m2buhUNJNC1kLVp5+FHdy+PBCrjSE1wlNrr
         zIzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=mjDpBQhHQ+Uaa08PTn8Ul14j1LCoNtuU6NRPzhfImgg=;
        b=B4ItY2X2ADfqaJYZqwTjrPhKF6ue5nBTajaxIv+KwiKPZjvDyt/a9fLHcatnYJbfdp
         /BfzQhEJXXCx2hNfYqFdmxS6/ThFM5GXn/C0rQ5yaEJCqqyWkBnf5sUHKgqxd6bjjKba
         bdgIZzZc50SiM/FH/gNvxD1xZ2WC0P/gvlbMM+fWFCE/zNUV/4MNFjTWotzQw9L178qK
         hdJ0iupXLKjlnb4CeqqANA+3Gtne5oNKmYNzOcNLJ47XDqaNGs6Zdr1YCBfp6MSrpG7t
         4e2J6v8kjLtFVg0SzsNQXTQVi9dSDsOCZLQ6he5g4HKeDj+PchZ0XBXiebewF1Ll7XEF
         ZO6w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=xb+B5jjt;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=xb+B5jjt;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Colin Ian King <colin.king@canonical.com>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 144/161] media: cx25821: prevent out-of-bounds read on array card
Date: Thu, 24 May 2018 11:39:29 +0200
Message-Id: <20180524093035.621866005@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338543376891609?=
X-GMAIL-MSGID: =?utf-8?q?1601339464820436517?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 67300abdbe9f1717532aaf4e037222762716d0f6 ]

Currently an out of range dev->nr is detected by just reporting the
issue and later on an out-of-bounds read on array card occurs because
of this. Fix this by checking the upper range of dev->nr with the size
of array card (removes the hard coded size), move this check earlier
and also exit with the error -ENOSYS to avoid the later out-of-bounds
array read.

Detected by CoverityScan, CID#711191 ("Out-of-bounds-read")

Fixes: commit 02b20b0b4cde ("V4L/DVB (12730): Add conexant cx25821 driver")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
[hans.verkuil@cisco.com: %ld -> %zd]
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/pci/cx25821/cx25821-core.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/media/pci/cx25821/cx25821-core.c
+++ b/drivers/media/pci/cx25821/cx25821-core.c
@@ -867,6 +867,10 @@ static int cx25821_dev_setup(struct cx25
 	dev->nr = ++cx25821_devcount;
 	sprintf(dev->name, "cx25821[%d]", dev->nr);
 
+	if (dev->nr >= ARRAY_SIZE(card)) {
+		CX25821_INFO("dev->nr >= %zd", ARRAY_SIZE(card));
+		return -ENODEV;
+	}
 	if (dev->pci->device != 0x8210) {
 		pr_info("%s(): Exiting. Incorrect Hardware device = 0x%02x\n",
 			__func__, dev->pci->device);
@@ -882,9 +886,6 @@ static int cx25821_dev_setup(struct cx25
 		dev->channels[i].sram_channels = &cx25821_sram_channels[i];
 	}
 
-	if (dev->nr > 1)
-		CX25821_INFO("dev->nr > 1!");
-
 	/* board config */
 	dev->board = 1;		/* card[dev->nr]; */
 	dev->_max_num_decoders = MAX_DECODERS;
