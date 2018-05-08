Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZopbRb2ri0WVg2zTRC5qkmdL4bAwbbUqMicbg5AHJWRe43x3Pvdge8mJvh2FLzjCRa2R05/
ARC-Seal: i=1; a=rsa-sha256; t=1525767199; cv=none;
        d=google.com; s=arc-20160816;
        b=cbdfHBaV8vjc8uoYSQ3Au7lhosZoaIWKhZsmVcJmeeau5MyOyul9uMyU06J23oSe+j
         42jd9YFgxw1K2AIy+O7Fh4RSgIQ/Qgq8T7smry30BVLoUjNNq4EiQWWTEJFc1SFptd5d
         Ok6rjmSB58SDaQJMO+Biwir5SJJ3OxlKjSecwvMFYEFcOhBTLu5Og4oD9k/6W/o2Jnof
         7ErtyctypsO5Q9gSAkmcq6HfNQBul6zSC6c1fEv8bwDJRWbW2KPz/WxSM5Wx5ACB35iq
         ha0th6TfBTU7IoQUb2bZ2miAaiJGdkJ5v2AOHGI+eE/5xQUWLZpdXw8flF+4zCRoHgmu
         wChA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=IOkU0cXI1cjYzQ0wRNFr433Gb1XRG86j5ZPMwqhTkBg=;
        b=YlsLyfHx5w/mN9p3SkEsh4ZpaQHyq9lrIUAxCVAzEXG1reSjcmLHBF47SG3Y1XrPZd
         CJHLMcOL/SnncbpTmlJKZNRjBfET7cARJwrnkt74etdPlpUwSVIeJ+np34fw4Uf/i2Hl
         nucRDSs4rE5ex9L4KOT5mK1a5MU0HLlYGPIxURe8hgsk+NWHZ3ICe8iyq2r8ivalnenc
         cvgHYaytDbIdJ+3SOOjTRLEYB56CFrEMUfix9i/VWI9rboOBqWZTE/zkuX3Xuqq9bQ/y
         c3zFUbA9t6wwN2q8fGzVfRQ8iUoYpa1oEsWiwiwB4K3soMi9ORGqhKRsGTDKhYoZTNZG
         fdSw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Bhz4wFrG;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Bhz4wFrG;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.16 35/52] xhci: Fix use-after-free in xhci_free_virt_device
Date: Tue,  8 May 2018 10:10:33 +0200
Message-Id: <20180508073933.026701928@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882866914229413?=
X-GMAIL-MSGID: =?utf-8?q?1599882866914229413?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit 44a182b9d17765514fa2b1cc911e4e65134eef93 upstream.

KASAN found a use-after-free in xhci_free_virt_device+0x33b/0x38e
where xhci_free_virt_device() sets slot id to 0 if udev exists:
if (dev->udev && dev->udev->slot_id)
	dev->udev->slot_id = 0;

dev->udev will be true even if udev is freed because dev->udev is
not set to NULL.

set dev->udev pointer to NULL in xhci_free_dev()

The original patch went to stable so this fix needs to be applied
there as well.

Fixes: a400efe455f7 ("xhci: zero usb device slot_id member when disabling and freeing a xhci slot")
Cc: <stable@vger.kernel.org>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3548,6 +3548,7 @@ static void xhci_free_dev(struct usb_hcd
 		del_timer_sync(&virt_dev->eps[i].stop_cmd_timer);
 	}
 	xhci_debugfs_remove_slot(xhci, udev->slot_id);
+	virt_dev->udev = NULL;
 	ret = xhci_disable_slot(xhci, udev->slot_id);
 	if (ret)
 		xhci_free_virt_device(xhci, udev->slot_id);
