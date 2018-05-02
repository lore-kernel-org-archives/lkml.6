Return-Path: <william.wu@rock-chips.com>
X-Google-Smtp-Source: AB8JxZqHYLb58OnhSAzhUDCTrKjo2we9yACkx+RUHEK/k7idZO5JIOSOCOtHcBcpOQt9TdjVafaM
ARC-Seal: i=1; a=rsa-sha256; t=1525230377; cv=none;
        d=google.com; s=arc-20160816;
        b=Omk3eDCxHMGCLTn36mx0MrwbtvEWjwRSxK9D+2Vtvi2tka7SZzL/ZoIMroePYIstQH
         hrLF5I3xZDMF9m8SsVVRp+fjfj76m2mRjKNk2Zm8T4ipKJkOVBlE5fzQbXa+9vhZ5mHI
         o4H8IawfNCRs8KgB3yedk44vlZDo8AuWMny4AyqOSXpk2dgGoyOiS9NQoWfB/6iKcyTa
         7bqJAywoE2WPah7Snwo1IdTt9uv/EfT79awwlBE7q5bAb/I80+94huvGNcOKQXHVgWWV
         3UUPUhTXh3PlrnK+o5Mux7thkrdIbtD6ReWV4Y7ggjqZ2DC7SNaPgUDYHoevmBVKfMSZ
         uQOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=KR83TIRg/VsHCV5jDW4oLe+yFcSdWofGMWtGWvUgR3w=;
        b=CVhjkgP9BfshDSBMu0j6+KLe+OjU3h3KVPf1Eo8NjjIIBtKAC5jTXvUtj/dYM53PkR
         PM8QcA9LptgjVa8yt6CRo0VinKSLS80fF4wqJYmFiDPxUr7gQluCtDyLjbcm8aPe17pV
         LDXgxVduMIxv6WLvxHb2X4syAFlOFk9ztykSBzM69P3v6cJ5EptCUfR5XKbeUCsBDTM6
         75hSW7S2s0z0C6Q3Cd0si1wSrChqIo2ONNxuPoCAxtgE3tuQ9oqeyNhyepaUJtueU0rV
         XJfoEGK9VSozomnXizxBgjgmydL5HjSW9keGyVnMNjbHOj7vGjgVTyKgWY2uBNTWJO6X
         gIWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of william.wu@rock-chips.com designates 211.150.80.25 as permitted sender) smtp.mailfrom=william.wu@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of william.wu@rock-chips.com designates 211.150.80.25 as permitted sender) smtp.mailfrom=william.wu@rock-chips.com
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: william.wu@rock-chips.com
X-FST-TO: hminas@synopsys.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: william.wu@rock-chips.com
X-UNIQUE-TAG: <0ab5a81fc69eae5e6e8b7de0b86d6e25>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: William Wu <william.wu@rock-chips.com>
To: hminas@synopsys.com,
	felipe.balbi@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: sergei.shtylyov@cogentembedded.com,
	heiko@sntech.de,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	frank.wang@rock-chips.com,
	huangtao@rock-chips.com,
	dianders@google.com,
	daniel.meng@rock-chips.com,
	John.Youn@synopsys.com,
	william.wu@rock-chips.com,
	wzz@rock-chips.com,
	zsq@rock-chips.com,
	Allen.Hsu@quantatw.com,
	StanTsui@AOPEN.com
Subject: [PATCH v2 2/2] usb: dwc2: fix isoc split in transfer with no data
Date: Wed,  2 May 2018 11:04:48 +0800
Message-Id: <1525230288-6014-3-git-send-email-william.wu@rock-chips.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1525230288-6014-1-git-send-email-william.wu@rock-chips.com>
References: <1525230288-6014-1-git-send-email-william.wu@rock-chips.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599319968312360522?=
X-GMAIL-MSGID: =?utf-8?q?1599319968312360522?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If isoc split in transfer with no data (the length of DATA0
packet is zero), we can't simply return immediately. Because
the DATA0 can be the first transaction or the second transaction
for the isoc split in transaction. If the DATA0 packet with no
data is in the first transaction, we can return immediately.
But if the DATA0 packet with no data is in the second transaction
of isoc split in transaction sequence, we need to increase the
qtd->isoc_frame_index and giveback urb to device driver if needed,
otherwise, the MDATA packet will be lost.

A typical test case is that connect the dwc2 controller with an
usb hs Hub (GL852G-12), and plug an usb fs audio device (Plantronics
headset) into the downstream port of Hub. Then use the usb mic
to record, we can find noise when playback.

In the case, the isoc split in transaction sequence like this:

- SSPLIT IN transaction
- CSPLIT IN transaction
  - MDATA packet (176 bytes)
- CSPLIT IN transaction
  - DATA0 packet (0 byte)

This patch use both the length of DATA0 and qtd->isoc_split_offset
to check if the DATA0 is in the second transaction.

Signed-off-by: William Wu <william.wu@rock-chips.com>
---
Changes in v2:
- Modify the commit message

 drivers/usb/dwc2/hcd_intr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/hcd_intr.c b/drivers/usb/dwc2/hcd_intr.c
index 5e2378f..479f628 100644
--- a/drivers/usb/dwc2/hcd_intr.c
+++ b/drivers/usb/dwc2/hcd_intr.c
@@ -930,7 +930,7 @@ static int dwc2_xfercomp_isoc_split_in(struct dwc2_hsotg *hsotg,
 	frame_desc = &qtd->urb->iso_descs[qtd->isoc_frame_index];
 	len = dwc2_get_actual_xfer_length(hsotg, chan, chnum, qtd,
 					  DWC2_HC_XFER_COMPLETE, NULL);
-	if (!len) {
+	if (!len && !qtd->isoc_split_offset) {
 		qtd->complete_split = 0;
 		qtd->isoc_split_offset = 0;
 		return 0;
-- 
2.0.0
