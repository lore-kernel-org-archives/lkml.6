Return-Path: <kernel-hardening-return-12936-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49N0VHYIQpMU4QeCa+P7WaY5KczzBkQvk/XBfhlJOL/AeisbV1l2LoQccW/1cYR4N7k/05s
ARC-Seal: i=1; a=rsa-sha256; t=1523308012; cv=none;
        d=google.com; s=arc-20160816;
        b=WJLI4YIKB2dRCIzscz4aws8kJUOcqjbooDfA6q0x/ffF+pCi4Xm04U4EVHqMNumABH
         hvAfDoQ4Q3FtUaQVnjZSs7NfQoeVtmbgpLc/AjwEFK5YM8mGwMUMVqU9VtN4FC4qYvz7
         HJl+1o/AO8ws6uxHgegNb6/HLGZf7VhNsnc1AmD4rCeQbXjmtPbA8vXEh/06R7G4PD4t
         HA1ZBEBm6m4IWyzJqChEUaucVYW3iABZzuH6j6cXA2RIcmLNKbC7xXl+QbJZ3vn8daEP
         r3OY5nC+xkSjNFpoZuUK2i8uBHaunGRyZlxMZ4U2Jzdj5rp4tmkkLAdvwV2vr/9dN6LD
         6dJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=txvQFbkVbneeHk7xGEu3Dvk+9Bxlu6Nrd6YkyLh2pW8=;
        b=QuwigD0fp/fmvpH90qvZJjFrJ+G7MnhTwz3k9fCjmt+gDCTnaEAZaiyK/Z2mTKIfym
         NyoihoJbOfjKkoHymprbRN90M8spcZGCSve643alc4/LMi0iDKm7R1UR3fpIqDQOZ58W
         bCA8DA0TG7LtNjze06EBMPcspxxnpIYiIsgpTEPz32zwv+D23xVhPcwt66fYXbd+l0So
         P3LfoEm+72uPg1qN7vv+MY3yRCi15Q6iuTZvzAXI5SGkC1Px84zUymipUTAaDGbi0hpY
         Ztic8sqNy1pY1gqb//ZFY/d+7xBDXrs1rxTtpNrUgNbPbNA9wIynubDI2t6dYnXRWwm+
         0Pzw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12936-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12936-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12936-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12936-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Laura Abbott <labbott@redhat.com>
To: Oded Gabbay <oded.gabbay@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc: Laura Abbott <labbott@redhat.com>,
	David Airlie <airlied@linux.ie>,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH] drm/amdkfd: Remove vla
Date: Mon,  9 Apr 2018 14:06:20 -0700
Message-Id: <20180409210620.3647-1-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597304222291643357?=
X-GMAIL-MSGID: =?utf-8?q?1597304222291643357?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There's an ongoing effort to remove VLAs[1] from the kernel to eventually
turn on -Wvla. The single VLA usage in the amdkfd driver is actually
constant across all current platforms. Switch to a constant size array
instead.

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
index 035c351f47c5..c9863858f343 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
@@ -139,10 +139,12 @@ static void interrupt_wq(struct work_struct *work)
 {
 	struct kfd_dev *dev = container_of(work, struct kfd_dev,
 						interrupt_work);
+	uint32_t ih_ring_entry[4];
 
-	uint32_t ih_ring_entry[DIV_ROUND_UP(
-				dev->device_info->ih_ring_entry_size,
-				sizeof(uint32_t))];
+	if (dev->device_info->ih_ring_entry_size > (4 * sizeof(uint32_t))) {
+		dev_err(kfd_chardev(), "Ring entry too small\n");
+		return;
+	}
 
 	while (dequeue_ih_ring_entry(dev, ih_ring_entry))
 		dev->device_info->event_interrupt_class->interrupt_wq(dev,
-- 
2.14.3
