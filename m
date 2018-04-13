Return-Path: <kernel-hardening-return-12993-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49P6kDCXYAmp/cvNdX7tnADE/zSrFxVcr9OyFuCd2qkeQv9a4I63umvGHWlMENVgjopHdT6
ARC-Seal: i=1; a=rsa-sha256; t=1523654678; cv=none;
        d=google.com; s=arc-20160816;
        b=RN84SDwfltnpLKlLdotHZbuaVj9hXMx4idDMKveH7xmvb/PztDTcEPlldWfc7ouCck
         +PWleGzUnKWuiFufC4bf3giTQFS3dB/9mtHGiYHoCaAMd2FwwrCpYP/8Pai2jMWWKWZN
         0lF2tjjtX0uMr7q4QoV06MShXSvrXIzJLU94aC4CobzJDx0SSPX9rADI4sEx47IAOdEM
         2oZTtct8XPl5bU0Q3zz+DrjE+H139oYUS+qYh7iHncz2dq2BK/A3ieI8Fr9nAYLTRlVp
         i7+TklsxrTjAwixXUhj03amMDVsWjknE5c41d5YmOkxsvBSR/TCpIphZvN9EfG73Qmwj
         QVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=t+NMc3wTSPqTRlc4wymVw8yLH7odihMta2WDEKBjms8=;
        b=Zx3p9GHXN0fNtO0Lj7yvgJuzOymYJqzR353TYjYOj/qglsZ+E8mSEHAQ7/FLQ7ogcp
         mGc2283vnKgH8Uk0+/TjbpYK+1LqfD7CV7WoM3UoOzwjFZdB+/Hr96aOiTHqx93jue4j
         dQUrgIkfjZ3NAxu8Oq+S9U57E6gYUQQhkuZTBjiYYVpZFrAXHuEKliwKAwZk90epFCU4
         WvQDQaQq4KkeRJJ3aebKBMAYPCRf4E6OF7Zf8gi8L9f2VISs8puKHH0c84Lc7NqKW9RD
         E7JXIY1amZ1jSzkLs9mOHrZ7Zgof+yYTmQDtxT/zSmiqddpcTSwbjhBZRddBPQ4t3k/R
         j39Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12993-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12993-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12993-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12993-gregkh=linuxfoundation.org@lists.openwall.com;
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
	"David (ChunMing) Zhou" <David1.Zhou@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>
Cc: Laura Abbott <labbott@redhat.com>,
	David Airlie <airlied@linux.ie>,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Kees Cook <keescook@chromium.org>
Subject: [PATCHv3] drm/amdkfd: Remove vla
Date: Fri, 13 Apr 2018 14:24:12 -0700
Message-Id: <20180413212412.18205-1-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597667728285073548?=
X-GMAIL-MSGID: =?utf-8?q?1597667728285073548?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


There's an ongoing effort to remove VLAs[1] from the kernel to eventually
turn on -Wvla. Switch to a constant value that covers all hardware.

[1] https://lkml.org/lkml/2018/3/7/621

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: Introduced a #define for the max value, switched to pr_err_once to
avoid log flood, switched to sizeof(array) per private suggestion.
---
 drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c | 8 +++++---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      | 2 ++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
index 035c351f47c5..db6d9336b80d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
@@ -139,10 +139,12 @@ static void interrupt_wq(struct work_struct *work)
 {
 	struct kfd_dev *dev = container_of(work, struct kfd_dev,
 						interrupt_work);
+	uint32_t ih_ring_entry[KFD_MAX_RING_ENTRY_SIZE];
 
-	uint32_t ih_ring_entry[DIV_ROUND_UP(
-				dev->device_info->ih_ring_entry_size,
-				sizeof(uint32_t))];
+	if (dev->device_info->ih_ring_entry_size > sizeof(ih_ring_entry)) {
+		dev_err_once(kfd_chardev(), "Ring entry too small\n");
+		return;
+	}
 
 	while (dequeue_ih_ring_entry(dev, ih_ring_entry))
 		dev->device_info->event_interrupt_class->interrupt_wq(dev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 96a9cc0f02c9..a90db05dfe61 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -39,6 +39,8 @@
 
 #include "amd_shared.h"
 
+#define KFD_MAX_RING_ENTRY_SIZE	8
+
 #define KFD_SYSFS_FILE_MODE 0444
 
 #define KFD_MMAP_DOORBELL_MASK 0x8000000000000ull
-- 
2.14.3
