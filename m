Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoDz7gkBf1W8eBEU72AxumMrhmhd1g2RDxH4aCJuEmuhqHeEYHXKxPqJTC8uxcDJmkw55QJ
ARC-Seal: i=1; a=rsa-sha256; t=1527155669; cv=none;
        d=google.com; s=arc-20160816;
        b=Ldo3ircvYAro7Dmb395qTkGi69bgtDrjsACAgI/oachMemb62ui+ZAwSeiJ+8YLvAE
         blu55HT/prqs9QsABYqIXsad08DLJOzXFtsQWk7oEGraOswEDR658MnapQFZ7yw5MYPZ
         GLHBHXS82hV0Zp3q1S6Hs6mPI+5A3V1DG0Gwg1cVQC5p2m5WXLbyMHgJ8Jxv4qovd/F8
         95MfOuU18LR1mhUZj8C1c1nyipEJbuPUBb5VXF3rgGEGjfQJYPFnztO1TAEX4sk5nHFQ
         vO+d+Eth/sjicmgL19uZ17h8fggb2xFAsQyOZTANOX7OsRPnYG65b6g3R142frrabBu7
         9jhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=SwagI60bBaOYS5HuRpVRYlpFHM69nctTLkP2bFY+cvY=;
        b=bdVZCNw6nF7DyB8Ir+yByHOEMub7DBmEMuDXJyyn7j0/YFkM+PNesX+MVRX2/+c3HL
         nkTnTd7a3+Mk7T32PM3PcxxYIZE5cIqPEt4L55N9Wb9YPCCT8VL7D4DkOFGeqz88Mriq
         MbF0N6M8yI9nn9n9IWoVLiBhQn9fMGW+YA4u2415KTpX7/dBYn5pHIV7ylM7T3FxNVZB
         C7ACq1ge6YjEU17I0WpLvoPlXKqgP7lrsXRdbnIqIVI5EzRP4CDN7u9Hhk1dN97WG8zZ
         5CiYWl4NSUF7KeKjANQvaf1OHZ5KXz0RqtHyCfHoNmD8A+7DDgo8pZLKLfqOQHcKwLAI
         xp1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=1lXgV2Gb;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=1lXgV2Gb;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 072/165] xhci: zero usb device slot_id member when disabling and freeing a xhci slot
Date: Thu, 24 May 2018 11:37:58 +0200
Message-Id: <20180524093624.931719410@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338400215040463?=
X-GMAIL-MSGID: =?utf-8?q?1601338782970950386?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit a400efe455f7b61ac9a801ac8d0d01f8c8d82dd5 ]

set udev->slot_id to zero when disabling and freeing the xhci slot.
Prevents usb core from calling xhci with a stale slot id.

xHC controller may be reset during resume to recover from some error.
All slots are unusable as they are disabled and freed.
xhci driver starts slot enumeration again from 1 in the order they are
enabled. In the worst case a stale udev->slot_id for one device matches
a newly enabled slot_id for a different device, causing us to
perform a action on the wrong device.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-mem.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -926,6 +926,8 @@ void xhci_free_virt_device(struct xhci_h
 	if (dev->out_ctx)
 		xhci_free_container_ctx(xhci, dev->out_ctx);
 
+	if (dev->udev && dev->udev->slot_id)
+		dev->udev->slot_id = 0;
 	kfree(xhci->devs[slot_id]);
 	xhci->devs[slot_id] = NULL;
 }
