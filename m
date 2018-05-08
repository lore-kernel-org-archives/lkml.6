Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp9YeRgTfovJfpVl8NxqCH6OCcDWEfCslRSxWoC/Qe5+AB1369ZA82S4DfiEqlAv9vMKrHN
ARC-Seal: i=1; a=rsa-sha256; t=1525767231; cv=none;
        d=google.com; s=arc-20160816;
        b=RhUkYAbNej5jYR8e2Rwmrd3utdkf7Jtx5PI82jH45B+MR7Naze6mvEqHGHuCfXSqhZ
         a6BlsnStAoGNxkqYGPGAziBtRYZFuNhPbAdD9qzwDhLAM4htIhda93qRphDIKAk2TmrY
         /kx+XkUTgMKXoxSj6V4sP+jW6Ttu2KJWUnxI2IncqTqD1NAT35DscvkQW7XclDEy91pC
         m9rlDd5OCG1RddOQgKS3rzl1+3BIYcKDVLzyDXcNNSzJnMR4hP9rQeep/bTPM7g49rN6
         DeeqIKwdlrHk8pWHKcjuF56rRxCVE/6L9bkZ0MjycbnL/JKq6NxVFyc2QMSxXlFj49wn
         c2pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=SfcTa2anmPgTJ2yaNDW8vZKeXkmZWV/yrhh7bH2JjZc=;
        b=wjOSuVYrJuWGhV01owVEkfsVW0Rx9bd6nPVlIJJhkmYnSTSsW3bo/9bW56EexM8M85
         xtdRNbuTpsQivyUJX+NjH33Y2dFnqcdHZ7B2UsYUmafPWX7HJtH5OtM2kavaIj9o1IkS
         gGdePiP+71Y+FOqygmz8OXw8zdt6VkrHKEcA0MMWp+gLBq8RAjYuvD8fhEfV0SktCTPH
         cjnD6cuX65qbgmyr6Vobi9Zd2vnRYQ1IbmrfGMI/Tq2E3HwvzMOIQaLX0N+jWmlNVz8l
         j+EFgD18EFTauE5NbyrJCs9vnrsejfTQKc0VhxAWYcFvxt3UP/pEzVo4uLbQJkcXiaY2
         ni/w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=rilhS0Wr;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=rilhS0Wr;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Elvinas <elvinas@veikia.lt>
Subject: [PATCH 4.16 38/52] USB: Accept bulk endpoints with 1024-byte maxpacket
Date: Tue,  8 May 2018 10:10:36 +0200
Message-Id: <20180508073933.453794183@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882900535348958?=
X-GMAIL-MSGID: =?utf-8?q?1599882900535348958?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
