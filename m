Return-Path: <lyude@redhat.com>
X-Google-Smtp-Source: AH8x225iinkqFzQ+G75XfbCxVZll2h183+HDQyVD58g1AVekQwTefWqDkUOdp+rsxCTBH0KhZS4v
ARC-Seal: i=1; a=rsa-sha256; t=1517508925; cv=none;
        d=google.com; s=arc-20160816;
        b=RL8E6MDvDhXsvkBHNniOQYGcVUwa9xLEABlZebF1EOenq09T4u6m6FBHFQh44+fV55
         AhTYGke3vZk6VmAp6Izi9tWKrDdwS6rWKYgiutdT8mjmcJnKYqlRTPlnbsnrCsW77wLM
         UgnHcpEHLUmaoJzv8Q9gn+coTwpqWwiEJizL6h9pDrTFQmSIY74Rw+wrhkG/qVFDOqSH
         XLdijeQ9y8NeRPC5UlCQ/0uKkOLctflt2N4jqByMSK+QNBlhAnOfZacEzuEez/X2xNdp
         70n6hEwoDY6u2Y2jSrDoce8BSevK7xJNFKroTs0kCinIp9cfst3cwbvi5Ir3XrjpjLT7
         CKTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=n/16dyqeK5uSwLv6IazDlXspss7/AH3IOl0e0DBEt/A=;
        b=ijBAztVhph3YaYgfqp8+A4ZL3o0ueQWNRcqW+6ubR9pverz1NVMe1vAmUX+n8nWDLD
         09D8nHJEzBndV+6uC0+jW6yfyOYRNTZuohTAlJN43GcEH4eLEYbvBZP4J0USs7p4G2y3
         LffkiA1O14OKLw4u/6MN7OHyKh+uK6Doj/cw/tt/LOh0e3Pubnfv+kZDs19CwnJXbiz8
         SyZ8+mLqnyEeYKi4WSciDNUnRUkufraQJ+K6v8gkBocHqKz65VQXP0KR1bWyqM9kmplD
         A6Y+j/Z3jy0shl5mdlaUwqX1MBPQd4E+sZkQMn1xcR53fPOl+QpeIAwVODUNmEAfBr+I
         gVYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lyude@redhat.com designates 209.132.183.28 as permitted sender) smtp.mailfrom=lyude@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lyude@redhat.com designates 209.132.183.28 as permitted sender) smtp.mailfrom=lyude@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: Lyude Paul <lyude@redhat.com>
To: nouveau@lists.freedesktop.org
Cc: "Alexandre Courbot" <acourbot@nvidia.com>,
	"David Airlie" <airlied@linux.ie>,
	"Rhys Kidd" <rhyskidd@gmail.com>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	"Karol Herbst" <karolherbst@gmail.com>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Ben Skeggs" <bskeggs@redhat.com>,
	"Ilia Mirkin" <imirkin@alum.mit.edu>,
	"Kate Stewart" <kstewart@linuxfoundation.org>,
	"Martin Peres" <martin.peres@free.fr>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	"Lyude Paul" <lyude@redhat.com>,
	"Philippe Ombredanne" <pombredanne@nexb.com>
Subject: [RFC v6 0/5] Implement full clockgating for Kepler1 and 2
Date: Thu,  1 Feb 2018 13:13:54 -0500
Message-Id: <20180201181458.25776-1-lyude@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591223438928626228?=
X-GMAIL-MSGID: =?utf-8?q?1591223438928626228?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Next version of my patchseries for adding clockgating support for
kepler1 and 2 on nouveau. The first version of this series can be found
here:

https://patchwork.freedesktop.org/series/36504/

Some small changes (shouldn't change anything functionally):
 - Made gf100_therm_new, gk104_clkgate_pack, and
   gk110_fb_clkgate_blcg_init_unk_0 static (re: kbuild test bot)
 - Making all three of these things static made it apparent that we
   create gf100_therm_new() and gf100_therm_func in
   nvkm/subdev/therm/gf100.c, but never actually use them anywhere. So,
   get rid of these two things entirely and also since we no longer need
   to, stop exporting gt215_therm_init

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Martin Peres <martin.peres@free.fr>

Lyude Paul (5):
  drm/nouveau: Add support for basic clockgating on Kepler1
  drm/nouveau: Add support for BLCG on Kepler1
  drm/nouveau: Add support for BLCG on Kepler2
  drm/nouveau: Add support for SLCG for Kepler2
  drm/nouveau: Introduce NvPmEnableGating option

 drivers/gpu/drm/nouveau/include/nvkm/subdev/fb.h   |   1 +
 .../gpu/drm/nouveau/include/nvkm/subdev/therm.h    |  17 ++
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  |  25 +--
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.h     |   1 +
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gk104.c     | 207 +++++++++++++++++++++
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gk104.h     |  55 ++++++
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gk110.c     | 155 +++++++++++++++
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/Kbuild      |   1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gf100.c     |   6 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.c     |  47 +++++
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.h     |  35 ++++
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk110.c     |  71 +++++++
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/priv.h      |   2 +
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/Kbuild   |   2 +
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c   |  70 ++++++-
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf100.c  |  58 ++++++
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf100.h  |  35 ++++
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf119.c  |   8 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gk104.c  | 136 ++++++++++++++
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gk104.h  |  48 +++++
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gt215.c  |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/priv.h   |  21 ++-
 22 files changed, 977 insertions(+), 26 deletions(-)
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/gr/gk104.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk110.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf100.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf100.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gk104.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gk104.h

-- 
2.14.3
