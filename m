Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtAdMrEA9cLm6BaVo45Sg72PWwHGu+85axmuhJmvJ7pFCeZRjqCj00xoU0tBha5zhRUoFIH
ARC-Seal: i=1; a=rsa-sha256; t=1520955498; cv=none;
        d=google.com; s=arc-20160816;
        b=HZEpnV+Ofn5g42TluslmMn+JdzpxEbwfmecDXllgsiWEZ7Kzi67dUoGKQDAzQ4NpSC
         2d3HeA1N9BIaYXu8pOsWKn3GYj6xmu+NFbk/we/XdJxWXiBhSORN0C42/7GxWuIPx6rZ
         4PaL081/Yugnj301zftbIAq6k1jAw5BOu3exspzPKAFveeWe9c+b+YeCUYsNFCuo/f8t
         lOIE3TcNxIKVuLnFScdEoOhigD50A/zoOimB+YDKWtuoFiOFfPbo+Ln3uzPakOskE/DV
         ree1Vp1Nvsc4hVgfZCGaYl2eUxewsH2fTuzm0wPUHkLNDpkPOVYQSbXT+ZHob7yC4Q5u
         D/Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mcb2nOOny7RvkwJm4q9TUlCC7TpVORcSVNizWd9SN38=;
        b=zR45HYnZoYKeNkpRgZPcSXpKioGd0Empa70fBpA/cLjiG9ibyc9B6wGgpIY6O3APWT
         lxbwVWPZoFBb/FZfNpmJ5uCLe1sqawmZYzl6LFKEbCyiwaZpy7Qpu8AQ8ptXwhTRt1uq
         gvLY0hAY6PyfGzGGtpsRGI8XLvJziFDUMbPf2hEpPxZF3MQi6U5fTPj6mjEL9aa8moN7
         VkZvEiUGYoktpegult73QyvJgyls3utPanO0lkD7rcI8lCWa4uJGDiTHhCvfRj8duHwO
         axBEAPM6SudKDDHNO9dKi25pvPKB4HXcXyYBsauRYtw4DsmWwDjBMrUOZNcJ/3O4qZpL
         HJ6Q==
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
Subject: [PATCH 4.14 070/140] drm/radeon: insist on 32-bit DMA for Cedar on PPC64/PPC64LE
Date: Tue, 13 Mar 2018 16:24:33 +0100
Message-Id: <20180313152502.894564942@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836831659709602?=
X-GMAIL-MSGID: =?utf-8?q?1594837432264320517?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
