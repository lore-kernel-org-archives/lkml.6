Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq2KNSJCmRGZT+9GY+Evjbg8a+WA5h77B6R3WP91WOSWkilHJZR6SAH7kfjnd9v6bGDrLi2
ARC-Seal: i=1; a=rsa-sha256; t=1525767340; cv=none;
        d=google.com; s=arc-20160816;
        b=ipzXEeBDtx5UFbJ/OxiT5chvRq/0icP1KzrBFY6rOvWLTUXxXLW5BV0j0eSQd/M83X
         rWOZd51TPb+p666Q+fN75znh6sU2Fp/xg1Av/7+FQ19cNmFxZ7o12L68wibeT6S0aSXV
         QQThtN2kg3EeK1a0fmvT7i31sqYGA5+yVsIXJyH5zmVtMXpDf7Vn1rpWgA8O0AIfwAnG
         soDP7fF7l5VFuh34gi34DZfAxNKkSDxL96JPSHHQsiWpYrOlXpFU6Rd+zEm4trgyalN3
         SYTD7qTO5GsAZj+wRCbQyZUvyBWXwgNoB33D3KM7lBjNIad+iNZPWdH1jiaj0D1ihSUk
         ZxoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=SoTTAAFq756LtDnV1QVdD+e4e7pTFl1IaYWo9eMPxsk=;
        b=MKSS5g6DWfWHRCfZs4F3jyJa63ldHxk3ZHveVVGs8W66qOk60KvwYgEdx+3yoDI0qu
         dePSoD4xV1O4pArpTawVBRHifRKD2IioQvA993cdRV1fuinVv33/WMI/0YD7iZEZAVWD
         F2ErVN19bBonEbNGkm3gz5d3AjtnsyPt3iT0L5kmkgTPmdYQe+aUoVo1K9OqU8jc/iJn
         8voFEc0/SBV2VwvzeoshLcKo6k1owVCx5FYywPa2dmjlG8DgZzkeMi6dxwkS+Rht99/R
         ElA9CjGr4KGXwyE4PP4VFNTs4BkkoRbHjskkE9KMwWBMmSFm086sAG91wNuH5NRIKEt6
         Ix7g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=0sk13WIr;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=0sk13WIr;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Elvinas <elvinas@veikia.lt>
Subject: [PATCH 4.14 36/43] USB: Accept bulk endpoints with 1024-byte maxpacket
Date: Tue,  8 May 2018 10:10:55 +0200
Message-Id: <20180508074009.622170242@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882900535348958?=
X-GMAIL-MSGID: =?utf-8?q?1599883014902422587?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alan Stern <stern@rowland.harvard.edu>

commit fb5ee84ea72c5f1b6cabdd1c9d6e8648995ca7c6 upstream.

Some non-compliant high-speed USB devices have bulk endpoints with a
1024-byte maxpacket size.  Although such endpoints don't work with
xHCI host controllers, they do work with EHCI controllers.  We used to
accept these invalid sizes (with a warning), but we no longer do
because of an unintentional change introduced by commit aed9d65ac327
("USB: validate wMaxPacketValue entries in endpoint descriptors").

This patch restores the old behavior, so that people with these
peculiar devices can use them without patching their kernels by hand.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Suggested-by: Elvinas <elvinas@veikia.lt>
Fixes: aed9d65ac327 ("USB: validate wMaxPacketValue entries in endpoint descriptors")
CC: <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/config.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -191,7 +191,9 @@ static const unsigned short full_speed_m
 static const unsigned short high_speed_maxpacket_maxes[4] = {
 	[USB_ENDPOINT_XFER_CONTROL] = 64,
 	[USB_ENDPOINT_XFER_ISOC] = 1024,
-	[USB_ENDPOINT_XFER_BULK] = 512,
+
+	/* Bulk should be 512, but some devices use 1024: we will warn below */
+	[USB_ENDPOINT_XFER_BULK] = 1024,
 	[USB_ENDPOINT_XFER_INT] = 1024,
 };
 static const unsigned short super_speed_maxpacket_maxes[4] = {
