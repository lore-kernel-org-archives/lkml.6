Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523917484; cv=none;
        d=google.com; s=arc-20160816;
        b=F3KlCmi6gyzNQ5Hj4M74/jtlxIxiyF/l4vP+SZtSllcRluIhSIk1etZ/z2OIcP/3YI
         9xGfsQsFCgdnoN1cmDIo0W4D7PbjlzPfBjBgHt/+OGEvCyaE2cJh4qr5hZp8ZELKgpcf
         J7JLcudE0zesIlLI+5sFz/CrLE7wEO4HTGGL77MHJjXc0gFjXLazc8myjxx0AJk83uRV
         6eSd9/RLrrS0azKP+a2yx0AAsd+g795ERjAA5SeUXq+EMYmKaS53RqXjScg+8wVQ+wKE
         gumG9y7HzO5uvYaaV3A+aM9wCrsU5KYXZFmGLDXm6cYinLUTDDSsCinpM9zmTrdmvwIz
         33uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=CXVHzMi+biu7NS96HlT1xg+EdmqGxY7fm+0mDw5NmxI=;
        b=DYSeDUSv5SM9mk0nmEuByP5nKSwr4iIgG7eF5YjpmLSBBAkuzKlEVh493DAjjaQtDs
         odudUAEZZ8q774ZhkTZUa4m97KF7rJdR+BvljmcWWu4Pkp5QoiyXHlkPNlsD96TQLlb/
         wdhuyx1SW9RsleHhkVekx+wzsShFkNvSbnTCvdPoqGKMmk6EqU3hWUkVMLSBNEJGvPI4
         M60PGBswtBJ1NJmprXb7gPLij5NqJSFuB4VtQAwdr54d2lIWk2RZgvCOp/Ad8uRi8t2g
         BxuFhZzo8GaOFN2W9drdSwJqu/QjLBSUjXETrfrmNPMvLyWe8DU2b63+bB5admsv9jnN
         wtlg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WlkOsVvN;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WlkOsVvN;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+RCs2Qt7oOvzIriJ9w2oI4L++zStZM1+sBMVEdzD701blXhP2uZCsnx7r+yb2XKfa1ugsrfg==
From: Andres Rodriguez <andresx7@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andresx7@gmail.com,
	gregkh@linuxfoundation.org,
	mcgrof@kernel.org,
	alexdeucher@gmail.com,
	ckoenig.leichtzumerken@gmail.com,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com
Subject: [PATCH 0/8] Loading optional firmware v2
Date: Mon, 16 Apr 2018 18:24:19 -0400
Message-Id: <20180416222427.29683-1-andresx7@gmail.com>
X-Mailer: git-send-email 2.14.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597943300148502618?=
X-GMAIL-MSGID: =?utf-8?q?1597943300148502618?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hey Everyone,

Thanks everyone for the feedback on the RFC:
https://lkml.org/lkml/2018/3/9/903

Seems like there is a general interest in this feature, so here
is a V2 of the proposal with the comments I received.

Please provide comments on the _nowait2() API. It is not my favorite,
but it seems like the ship on exposing fw_opts directly to the caller
has sailed. If anyone has a better suggestion let me know.

Also, if anyone has better suggestions for the fw_opt enum documentation
please let me know. I may have botched some of the details since I'm not
super familiar with them.

I've also included patches for the following consumer drivers:
   - amdgpu
   - ath10k
   - brcmfmac

Thanks again for your feedback.

Regards,
Andres


Andres Rodriguez (8):
  firmware: some documentation fixes
  firmware: wrap FW_OPT_* into an enum
  firmware: add kernel-doc for enum fw_opt
  firmware: add functions to load firmware without warnings v3
  firmware: print firmware name on fallback path
  drm/amdgpu: use firmware_request_nowarn to load firmware
  ath10k: use request_firmware_nowarn to load firmware
  brcmfmac: use request_firmware_nowait2 to load firmware without
    warnings

 .../driver-api/firmware/request_firmware.rst       | 29 ++++++-----
 drivers/base/firmware_loader/fallback.c            | 18 +++----
 drivers/base/firmware_loader/fallback.h            |  8 +--
 drivers/base/firmware_loader/firmware.h            | 28 ++++++++---
 drivers/base/firmware_loader/main.c                | 58 +++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h          |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/ci_dpm.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c              |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c              |  8 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              | 12 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              | 32 ++++++------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              | 12 ++---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |  2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c              |  4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/si_dpm.c                |  2 +-
 drivers/net/wireless/ath/ath10k/core.c             |  2 +-
 .../broadcom/brcm80211/brcmfmac/firmware.c         |  7 +--
 include/linux/firmware.h                           |  6 +++
 29 files changed, 164 insertions(+), 94 deletions(-)

-- 
2.14.1
