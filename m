Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227dYhbOTf8rV+bWEd/W0igmdmOrReT0MVLALa7HC6qt0gA0fmvzieRgs+6HPHcFRXDOv3PH
ARC-Seal: i=1; a=rsa-sha256; t=1518708505; cv=none;
        d=google.com; s=arc-20160816;
        b=AsdaxG5gmPWkdgy70X3u0krr/ExQ29XnMYBV6H6rHKCIhY4Ha0uyZe5JWPKaYo4KNX
         FyznjNWu8Z+up4sD9X34rh8CGyKYlQkSdeq11vrFJ/Tqjq8D16SpxgXm2yheGa664axQ
         L6onirEiJ0ltdKCCeZ7hnNr9tgzyJWRL18L8cAsvvf+BjC0f+x/wskTzgmNatujuH0Sq
         CN5o0zlPWCORF6qlp+6oADSss0MtVtizI76rt4JhaEI8JR70Aogiy4rP9kD5kZGj8bwY
         AxDLQAFV1uQnLaoZIERXasUB6799YJ/evGMbFOjkwVuGnnoDs2kw8Ujg/op4F0qkLhMq
         //rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dadWLiw4i4DkeMMk4oDknlCorhhZPsxaXxVNCez0ozc=;
        b=JLBhLnWa8wkrfyC2C6C6IbJKrK75X9JZvymPQkyTzorSEubBmHRUSsSLvN5jJdQPsq
         kdVdSvMF7qqSCiXki0Il5n5dKB716bnrsBHoxpxzqi4S7coe4rsM60tLVGJELxELG5rr
         PvL0RPCfrKD3qlLPKCS1pQ9nWfgvc+/NOkAMLIac1vrbrypIoC8lDrRZjhvRtT1Ave+J
         ++QKBWnjooj/YanMd85TzHYF8VVtUGfUYxlt7+konW2MF0Xvai/CiyfdvEJhubR97O+1
         0SFHD0iSGFmohDNjn/1xNimtYTsZltIBP9581mi1OI7ocyhWDeUZoniwZY7y+MJa8PpU
         +8Wg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.9 67/88] Bluetooth: btsdio: Do not bind to non-removable BCM43341
Date: Thu, 15 Feb 2018 16:17:34 +0100
Message-Id: <20180215151231.825248956@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481102414655693?=
X-GMAIL-MSGID: =?utf-8?q?1592481289447316741?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit b4cdaba274247c9c841c6a682c08fa91fb3aa549 upstream.

BCM43341 devices soldered onto the PCB (non-removable) always (AFAICT)
use an UART connection for bluetooth. But they also advertise btsdio
support on their 3th sdio function, this causes 2 problems:

1) A non functioning BT HCI getting registered

2) Since the btsdio driver does not have suspend/resume callbacks,
mmc_sdio_pre_suspend will return -ENOSYS, causing mmc_pm_notify()
to react as if the SDIO-card is removed and since the slot is
marked as non-removable it will never get detected as inserted again.
Which results in wifi no longer working after a suspend/resume.

This commit fixes both by making btsdio ignore BCM43341 devices
when connected to a slot which is marked non-removable.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/btsdio.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -31,6 +31,7 @@
 #include <linux/errno.h>
 #include <linux/skbuff.h>
 
+#include <linux/mmc/host.h>
 #include <linux/mmc/sdio_ids.h>
 #include <linux/mmc/sdio_func.h>
 
@@ -291,6 +292,14 @@ static int btsdio_probe(struct sdio_func
 		tuple = tuple->next;
 	}
 
+	/* BCM43341 devices soldered onto the PCB (non-removable) use an
+	 * uart connection for bluetooth, ignore the BT SDIO interface.
+	 */
+	if (func->vendor == SDIO_VENDOR_ID_BROADCOM &&
+	    func->device == SDIO_DEVICE_ID_BROADCOM_43341 &&
+	    !mmc_card_is_removable(func->card->host))
+		return -ENODEV;
+
 	data = devm_kzalloc(&func->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
