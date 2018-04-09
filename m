Return-Path: <kernel-hardening-return-12938-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49eu8jm8AsAHAhrg5OqpMCDpeeVZ/W6/tUCWMHVvwiQ0ICa7C7yTsPiFgD+hlOIMbMxLY/6
ARC-Seal: i=1; a=rsa-sha256; t=1523308052; cv=none;
        d=google.com; s=arc-20160816;
        b=HGYjMsPxz4ed1Y7VNo3F6mZ8GykNYmceZRxzawulf9ekZ0BPzxPT+gc53Iu/DFfngD
         4/tMKsdAJdltVT1is9WmeaR52lfuXft4MXSJoWM75uw5QjK6XKkNq31Fh1RONuOU1VpJ
         h+5vR0cLc4jnj16hRB4bfH2Zp4adRNF5UEhPAIcfUUDhTWhsmyEPDPBMzYH83Bpvbm+6
         WO3app+TxZ5ImVj6fc5n6QYRaNR0BkE151mvyyUea+jno3YUttnV40dvWVl07D/R4yHp
         yd2ED0jb3YT0X6BeSdCXn7g/pf0wq86v1XLxnrGdXDsKLhG7IA5NLeMF7FubV5qyZd26
         6Mjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=ft8euLnYqYFE3+0oIj+O4FrUx+5GzgMA2wcdWZG5Gds=;
        b=s9mL1mrw/zXkrCRJbklUPisBGWqS7xWDMKXGfoK32asaLD1VfnXNuRxLmZA5lNp4DD
         Ib5Dc/tpyKzOYZsrTC9BskeJoSNHeabrkMUz9ft3N9gMy5m+IwKCxGFLDYC3B49soU3W
         Zod7qKtlYwS3kXy8XANdhzzHnsNCoIXf7RO7Ujf4JHLn0dH/Zy+NW9TpeYfxJ/UvUeew
         Pd18aiPLOozMwT8pJGdt8v+42oOsGP9yZQ8feO+r5zcbBg70eSbLkLUz1vouM4bfYxl5
         PaBMDFSoRyhC8IpUmEAHhZmzKiS7ryAhkft5tv+Ozg6/kKnBQ+BIca+RFK0OF7VWiHxa
         Gw1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12938-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12938-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12938-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12938-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Laura Abbott <labbott@redhat.com>
To: Russell King <linux@armlinux.org.uk>,
	David Airlie <airlied@linux.ie>
Cc: Laura Abbott <labbott@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH] drm/i2c: tda998x: Remove VLA usage
Date: Mon,  9 Apr 2018 14:07:03 -0700
Message-Id: <20180409210703.3787-1-labbott@redhat.com>
X-Mailer: git-send-email 2.14.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597304263905140111?=
X-GMAIL-MSGID: =?utf-8?q?1597304263905140111?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There's an ongoing effort to remove VLAs[1] from the kernel to eventually
turn on -Wvla. The vla in reg_write_range is based on the length of data
passed. The one use of a non-constant size for this range is bounded by
the size buffer passed to hdmi_infoframe_pack which is a fixed size.
Switch to this upper bound.

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
This one really feels like it should be a #define but I wasn't sure
where the 32 came from. It looks like most other uses use one of the
#defines in include/linux/hdmi?
---
 drivers/gpu/drm/i2c/tda998x_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 9e67a7b4e3a4..29e2f49601c7 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -470,7 +470,8 @@ static void
 reg_write_range(struct tda998x_priv *priv, u16 reg, u8 *p, int cnt)
 {
 	struct i2c_client *client = priv->hdmi;
-	u8 buf[cnt+1];
+	/* This is the maximum size of the buffer passed in */
+	u8 buf[33];
 	int ret;
 
 	buf[0] = REG2ADDR(reg);
-- 
2.14.3
