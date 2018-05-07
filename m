Return-Path: <paul.kocialkowski@bootlin.com>
X-Google-Smtp-Source: AB8JxZqDnvIZY0S66bfILIOMTrlDjw1ZEBrAUJVRj8U8ks5PsaPw4eVabWXJRlpJ05uXxwSUaeIN
ARC-Seal: i=1; a=rsa-sha256; t=1525697255; cv=none;
        d=google.com; s=arc-20160816;
        b=LrgJr/VCML2+VNw0paBH8r3xtTVaIzav+NmBu9OIG46S/OiJI/ZgZ/m8ZgeFRQaec5
         YQLDkZvba7i5ig8eNuUUsqxTZGaZVudVmSQJAP/J9tsPKwIZHhdiQPlOC0s4AyTTNlkC
         AAe6cxdVIh6DXSft6+eCG13DaUUxrWDEopmB93Ns3MqpYmuAarP3DVJa0MKD+p1zYHC/
         Ri9zb1ac26UrNGJISu1wehrLxFutN6LoZeCbS/sScRyu+b1clzupIGi99OwSpUvb4vDM
         Uf2t6RUYfGFDYV/s2vXI1ZN2qA4QWG7LgFVFPIu77velmiti/FcXclxfHUA5nI1JUGtz
         hThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=dmhDXzzU7uqJwjxydiM3Kao27aQHfKKVDHAwdJr4Vok=;
        b=jHPk3HM9fvH6q0mCfRlJnnZ6I4WoCs1c7WYsXcJf8Bfv+RaKvwlLZYEd+q4WegKckh
         2YZh3VHpPPbMzWjdznBYu9mtEqP2RhsWpB2DDhP44cddSELVdBqwQHesTOXX7lbqApaH
         FBTrd4DiLRUjj3u8wIUnVxLJPlCTWWswJP09uEfcMoIQL2kr8zJh7T++17jxi1x56vl/
         dlN9jMvm0hWH+/jkVbV2rkhlY3ZZHL+UDF6TXbufxV5+BbJJm/x/UjqKW3swDdKYIWs1
         AB4hiAerO/VShM/PReggqkJ5uXJlzDh2DVCx1Cf659ZOyXVyfy1MTdb1t0MJbVvLnvDH
         1cjw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of paul.kocialkowski@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=paul.kocialkowski@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of paul.kocialkowski@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=paul.kocialkowski@bootlin.com
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David S . Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
	Yannick Fertre <yannick.fertre@st.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Hugues Fruchet <hugues.fruchet@st.com>,
	Alexandre Courbot <gnurou@gmail.com>,
	Florent Revest <florent.revest@free-electrons.com>,
	Tomasz Figa <tfiga@chromium.org>,
	Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
	Smitha T Murthy <smitha.t@samsung.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Randy Li <ayaka@soulik.info>
Subject: [PATCH v3 09/14] media: v4l: Add definition for Allwinner's MB32-tiled NV12 format
Date: Mon,  7 May 2018 14:44:55 +0200
Message-Id: <20180507124500.20434-10-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
References: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599809525524337659?=
X-GMAIL-MSGID: =?utf-8?q?1599809525524337659?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This introduces support for Allwinner's MB32-tiled NV12 format, where
each plane is divided into macroblocks of 32x32 pixels. Hence, the size
of each plane has to be aligned to 32 bytes. The pixels inside each
macroblock are coded as they would be if the macroblock was a single
plane, line after line.

The MB32-tiled NV12 format is used by the video engine on Allwinner
platforms: it is the default format for decoded frames (and the only one
available in the oldest supported platforms).

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 include/uapi/linux/videodev2.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index d8f9b59d90d7..242a6bfa1440 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -670,6 +670,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_Z16      v4l2_fourcc('Z', '1', '6', ' ') /* Depth data 16-bit */
 #define V4L2_PIX_FMT_MT21C    v4l2_fourcc('M', 'T', '2', '1') /* Mediatek compressed block mode  */
 #define V4L2_PIX_FMT_INZI     v4l2_fourcc('I', 'N', 'Z', 'I') /* Intel Planar Greyscale 10-bit and Depth 16-bit */
+#define V4L2_PIX_FMT_MB32_NV12 v4l2_fourcc('M', 'N', '1', '2') /* Allwinner NV12 in 32x32 macroblocks */
 
 /* 10bit raw bayer packed, 32 bytes for every 25 pixels, last LSB 6 bits unused */
 #define V4L2_PIX_FMT_IPU3_SBGGR10	v4l2_fourcc('i', 'p', '3', 'b') /* IPU3 packed 10-bit BGGR bayer */
-- 
2.16.3
