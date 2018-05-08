Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoV6Ob8/Vfs9PukfU7njS2wm/k4G3s7ESSBL6kjCSITc+An4jXDclHFOa4sqWncOH7mbVQH
ARC-Seal: i=1; a=rsa-sha256; t=1525767464; cv=none;
        d=google.com; s=arc-20160816;
        b=ffqimNV8uHnFdCXDGuTaDgrJpBvuvBDi4q7IyHigCjmk4hLNXNJvB/ShvQxkRcfCA6
         j5Iz3Ddkg9/VTTwAxwmprQ6IHZ2cZaSKAfAHx+eZoK1qZ2HGcA9NRYAWb19/Kv/cdUFK
         L46sQ6U4pArRG+yAtDcni3j+RTAHT/4PSaR6tYGdtSMG3jcSu7OQsWfsMA4ANMVomp6M
         yoKrsHwJ7cQ3vlcBZSGiQURZ1bs/fvTIyDXtoZ7wrheqmvJKTGQbxjwR8kIIXtu47zAn
         GqM+83ACN2e/VmzwLagZjd0HcEHve3pxy5Azh5d6JIbhdkIrqhn8ULumWgIxtch0TaCb
         68hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=IacX2BzvetAa1EfsHtmEW4NCd/osMzi/BmMgVdbvMao=;
        b=hdaNrZNHwa8kP6dDkpZMVMiDv+ctqbYzHWCLyE22AmO8sh8O8upw36VNErD0mfRAY1
         q02mRbS93cRqW20ChvKH9/uz76WlatuBeY7aKLFncPf9h63V8y7iBzvzaaoc4maabDKo
         DjsfVoAfbE6hx0haPHQivNvwOBTcx+wAE2/ouCxQLzNkB+9v3ynKHf8xXQA57simvWKL
         8NTXE9Ud1/zTv6554d3L4Coqlg1MftfHQef639gYvU4M2DrSE9jEtR6D5kHKXflNEN/K
         +cnvHqdVuS9rwb5tOGJLfGidTwTZukH0jaIjEP2VtQldaNTM3DEc1uZWZErfdse3YN8h
         lCsA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=l935z0vk;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=l935z0vk;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Elvinas <elvinas@veikia.lt>
Subject: [PATCH 4.9 26/32] USB: Accept bulk endpoints with 1024-byte maxpacket
Date: Tue,  8 May 2018 10:11:06 +0200
Message-Id: <20180508074012.987088720@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074008.800421598@linuxfoundation.org>
References: <20180508074008.800421598@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882900535348958?=
X-GMAIL-MSGID: =?utf-8?q?1599883145240046537?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -186,7 +186,9 @@ static const unsigned short full_speed_m
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
