Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELubQSjZHkhslSvAeXqI6JvvKFwr4EdO88m2xGI69LXuDk9hhL/b5TOskgMfzmF/sB0HstB9
ARC-Seal: i=1; a=rsa-sha256; t=1521214815; cv=none;
        d=google.com; s=arc-20160816;
        b=h90ydaMSGrNNOhSX1ktcZUodsOBBZPSQl9ukzPZjJqrYDBN0gdKqLe/mcHUq8BJQYt
         ZYEP87ke9pxGjCRJqBrB8oK9l5YYoC86r0J7iPhC9JcLvrGDDUcAz6bP+hcP6ct3XS8F
         AbQ7KJklwNPd6Gc085pYdRgbJwdd6A5yv4kfZZc0nwy3M6SDia6ZfFIriFqRSvW4egJ7
         l/S5TTFFAEo+gnh3VieLl9rP3NWc1Mkg/K23RS2fdloqUp1mvbd9mOqH9LUU2c1r6QDq
         go3ZjHzf2izYS09WbQuuOuCbTmPfsOY3gkBulT5EkzNqwoAKg9Tjd2rROkaOW1t/N6aw
         nfkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=P/Inr3tSyVyYKxdeOojdAOvrgRgZbJGc1gqfSn8QS/E=;
        b=Naaaflq5Wuj26iy+mhMgwwGef1Pi97ZlZX5gnX8dCjBJR8hTDrOSJ8Jj0WZS2owJV/
         2oU/h6jNtxbNTd9TEuO93Ya/l2iDmHcmmAIFMHPDqoY7PSNIhEJTRSLweGtjKAEKLeD1
         Ipl8kReuGWXq0n4jkFz6Z1xmOkdRLu1RjRfI7y1em635+bSwXJQZrWG1eZrBRFLkLVSB
         Yz8iA8JfCXfnUuTu/sc86qTgMJ12W6it2h/nmQmqn2BwnAAYGfa0VWSw2GfBW/GWbQiQ
         XbQYRzpZp0jHxfNhTJTyRPhENK+vMhcr+NH4EBqonKcE3Y6plkoNDmzHR7Gr/zmWTnn/
         z6+g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Eric Anholt <eric@anholt.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 028/128] drm/panel: rpi-touchscreen: propagate errors in rpi_touchscreen_i2c_read()
Date: Fri, 16 Mar 2018 16:22:49 +0100
Message-Id: <20180316152337.931529587@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109346639404410?=
X-GMAIL-MSGID: =?utf-8?q?1595109346639404410?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit 85b4587f8e94143bafb8b6a4003a5187b9a8753d ]

There is one caller which checks whether rpi_touchscreen_i2c_read()
returns negative error codes.  Currently it can't because negative
error codes are truncated to u8, but that's easy to fix if we change the
type to int.

Fixes: 2f733d6194bd ("drm/panel: Add support for the Raspberry Pi 7" Touchscreen.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Eric Anholt <eric@anholt.net>
Link: https://patchwork.freedesktop.org/patch/msgid/20171020002845.kar2wg7gqxg7tzqi@mwanda
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
index 890fd6ff397c..d964d454e4ae 100644
--- a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
+++ b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
@@ -221,7 +221,7 @@ static struct rpi_touchscreen *panel_to_ts(struct drm_panel *panel)
 	return container_of(panel, struct rpi_touchscreen, base);
 }
 
-static u8 rpi_touchscreen_i2c_read(struct rpi_touchscreen *ts, u8 reg)
+static int rpi_touchscreen_i2c_read(struct rpi_touchscreen *ts, u8 reg)
 {
 	return i2c_smbus_read_byte_data(ts->i2c, reg);
 }
-- 
2.16.2
