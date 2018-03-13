Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsausWLB9SDUxA7nmhQSPdNem8+niaphH3ktyGNGH26WGMKoUA+f+OrIFWTw193Ai+LJYq0
ARC-Seal: i=1; a=rsa-sha256; t=1520954925; cv=none;
        d=google.com; s=arc-20160816;
        b=W5xRT7UJL7L3Ji05goOAAYXmb98s86/ifVM/uT0000Noc2uN9T07/h+YSw25VuPJdZ
         i2UlW2ZDkbmaIHgWA1l+WAB69xq08rBUN2xItc8DvHpug946EmWxYuJEFgZJohpd2qEa
         j2+Wn8HYi1jBh9zTNb/r+OdTfrQhHbXQeBHJChlj+AtD1oEvPLPekQ9TdqTWAq3sSolY
         GWj5m1IXnwKlV53nd2e+I9LIRzoNS8KKOWaIDQLKZC07rG5WCPHskRHb5GnMuFv6gZuM
         fhbsQHEFSbgOuIqtC2hkh718p/pAs7G+lX6PzosFmHfDl574VqAbdq1Yh0PkKzrdtqkc
         QYnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=V3qQXPiWVFASPxZ0hyLcX8p370Jpz8hYXEo1JjFSnNY=;
        b=T0a8oGN4hYYsggrFt2aPCE6rmdAqGyGrj3kRGxgOxo0JbVsxvdD6KUZJi4oX5bjnDI
         4qk0QUhFI3QTb9ihb6yhQGH0GV5kSJeTvo1fAXrDZnF1U/xnfEDz2PhaYIREZxBadbd+
         rHeBe+F9AEfyqhd4FWCf06jmv2EbPP/rH1qEs0CSLGed1LgR+2kYtuFgOjwZH7pU47I6
         3Hd1QsJ+mZIxjQ7Bu+i9HLjN0Kc4pRdo+Wan2Nh9czS0ggrO2gV24wDwVkKoAztnU8px
         H4hEGGHewoFBnbjcqr66D3ZjlTAJtV3wFFrAe+hPU3s0cx78B1/2CS4XNsSy7P3Z8smF
         PwSg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ben Crocker <bcrocker@redhat.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.15 030/146] drm/radeon: insist on 32-bit DMA for Cedar on PPC64/PPC64LE
Date: Tue, 13 Mar 2018 16:23:17 +0100
Message-Id: <20180313152322.864927717@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836831659709602?=
X-GMAIL-MSGID: =?utf-8?q?1594836831659709602?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Crocker <bcrocker@redhat.com>

commit 2c83029cda55a5e7665c7c6326909427d6a01350 upstream.

In radeon_device_init, set the need_dma32 flag for Cedar chips
(e.g. FirePro 2270).  This fixes, or at least works around, a bug
on PowerPC exposed by last year's commits

8e3f1b1d8255105f31556aacf8aeb6071b00d469 (Russell Currey)

and

253fd51e2f533552ae35a0c661705da6c4842c1b (Alistair Popple)

which enabled the 64-bit DMA iommu bypass.

This caused the device to freeze, in some cases unrecoverably, and is
the subject of several bug reports internal to Red Hat.

Signed-off-by: Ben Crocker <bcrocker@redhat.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/radeon/radeon_device.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -1397,6 +1397,10 @@ int radeon_device_init(struct radeon_dev
 	if ((rdev->flags & RADEON_IS_PCI) &&
 	    (rdev->family <= CHIP_RS740))
 		rdev->need_dma32 = true;
+#ifdef CONFIG_PPC64
+	if (rdev->family == CHIP_CEDAR)
+		rdev->need_dma32 = true;
+#endif
 
 	dma_bits = rdev->need_dma32 ? 32 : 40;
 	r = pci_set_dma_mask(rdev->pdev, DMA_BIT_MASK(dma_bits));
