Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932313AbeBSXVI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 18:21:08 -0500
Received: from vern.gendns.com ([206.190.152.46]:36106 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932196AbeBSXVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 18:21:06 -0500
From: David Lechner <david@lechnology.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, David Lechner <david@lechnology.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH] drm/tinydrm: Allocate dummy SPI RX buffer if needed
Date: Mon, 19 Feb 2018 17:21:01 -0600
Message-Id: <1519082461-32405-1-git-send-email-david@lechnology.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new feature to allocate a dummy RX buffer for SPI controllers
that require an RX buffer even when not receiving. If an RX buffer is not
supplied, the SPI controller will reallocate a new buffer on each
transfer.

On systems with limited memory (e.g. 64MB and CONFIG_SWAP=n), this
reallocation will occasionally fail, which causes the display to stop
working. By allocating this buffer once and reusing it, we can prevent
this problem.

This patch also introduces some helper functions for calculating the
size of this buffer, so these functions are re-used where possible
(e.g. in mipi_dbi_init()).

Cc: Noralf Trønnes <noralf@tronnes.org>
Suggested-by: Noralf Trønnes <noralf@tronnes.org>
Signed-off-by: David Lechner <david@lechnology.com>
---

This is a follow up from the mail thread "tinydrm: page allocation failure" [1].
I actually got an allocation failure a few times even when I had swap enabled,
so I think this change is needed.

[1]: https://www.mail-archive.com/dri-devel@lists.freedesktop.org/msg203657.html

 drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c |  9 ++++++++-
 drivers/gpu/drm/tinydrm/ili9225.c              |  8 +++++---
 drivers/gpu/drm/tinydrm/mi0283qt.c             |  3 ++-
 drivers/gpu/drm/tinydrm/mipi-dbi.c             | 20 ++++++++++++++++----
 drivers/gpu/drm/tinydrm/st7586.c               | 13 +++++++++++--
 drivers/gpu/drm/tinydrm/st7735r.c              |  3 ++-
 include/drm/tinydrm/mipi-dbi.h                 | 16 +++++++++++++++-
 include/drm/tinydrm/tinydrm-helpers.h          |  2 +-
 8 files changed, 60 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c b/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c
index bf96072..f5c175e 100644
--- a/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c
+++ b/drivers/gpu/drm/tinydrm/core/tinydrm-helpers.c
@@ -434,6 +434,7 @@ EXPORT_SYMBOL(_tinydrm_dbg_spi_message);
  * @header: Optional header transfer
  * @bpw: Bits per word
  * @buf: Buffer to transfer
+ * @rx_buf: Optional dummy buffer
  * @len: Buffer length
  *
  * This SPI transfer helper breaks up the transfer of @buf into chunks which
@@ -442,16 +443,22 @@ EXPORT_SYMBOL(_tinydrm_dbg_spi_message);
  * does a 8-bit transfer.
  * If @header is set, it is prepended to each SPI message.
  *
+ * Some SPI controllers need an RX buffer even though we are not receiving
+ * anything useful. @rx_buf can be provided so that the SPI controller does not
+ * have to reallocate this buffer on each transfer. This is useful for large
+ * transfers, e.g. when updating the GRAM.
+ *
  * Returns:
  * Zero on success, negative error code on failure.
  */
 int tinydrm_spi_transfer(struct spi_device *spi, u32 speed_hz,
 			 struct spi_transfer *header, u8 bpw, const void *buf,
-			 size_t len)
+			 void *rx_buf, size_t len)
 {
 	struct spi_transfer tr = {
 		.bits_per_word = bpw,
 		.speed_hz = speed_hz,
+		.rx_buf = rx_buf,
 	};
 	struct spi_message m;
 	u16 *swap_buf = NULL;
diff --git a/drivers/gpu/drm/tinydrm/ili9225.c b/drivers/gpu/drm/tinydrm/ili9225.c
index a075950..c15f49a 100644
--- a/drivers/gpu/drm/tinydrm/ili9225.c
+++ b/drivers/gpu/drm/tinydrm/ili9225.c
@@ -300,7 +300,7 @@ static int ili9225_dbi_command(struct mipi_dbi *mipi, u8 cmd, u8 *par,
 
 	gpiod_set_value_cansleep(mipi->dc, 0);
 	speed_hz = mipi_dbi_spi_cmd_max_speed(spi, 1);
-	ret = tinydrm_spi_transfer(spi, speed_hz, NULL, 8, &cmd, 1);
+	ret = tinydrm_spi_transfer(spi, speed_hz, NULL, 8, &cmd, NULL, 1);
 	if (ret || !num)
 		return ret;
 
@@ -310,7 +310,8 @@ static int ili9225_dbi_command(struct mipi_dbi *mipi, u8 cmd, u8 *par,
 	gpiod_set_value_cansleep(mipi->dc, 1);
 	speed_hz = mipi_dbi_spi_cmd_max_speed(spi, num);
 
-	return tinydrm_spi_transfer(spi, speed_hz, NULL, bpw, par, num);
+	return tinydrm_spi_transfer(spi, speed_hz, NULL, bpw, par, mipi->rx_buf,
+				    num);
 }
 
 static const u32 ili9225_formats[] = {
@@ -400,6 +401,7 @@ MODULE_DEVICE_TABLE(spi, ili9225_id);
 
 static int ili9225_probe(struct spi_device *spi)
 {
+	size_t bufsize = mipi_dbi_max_buf_size(&ili9225_mode);
 	struct device *dev = &spi->dev;
 	struct mipi_dbi *mipi;
 	struct gpio_desc *rs;
@@ -424,7 +426,7 @@ static int ili9225_probe(struct spi_device *spi)
 
 	device_property_read_u32(dev, "rotation", &rotation);
 
-	ret = mipi_dbi_spi_init(spi, mipi, rs);
+	ret = mipi_dbi_spi_init(spi, mipi, rs, bufsize);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/tinydrm/mi0283qt.c b/drivers/gpu/drm/tinydrm/mi0283qt.c
index 79cb5af..c3fa682 100644
--- a/drivers/gpu/drm/tinydrm/mi0283qt.c
+++ b/drivers/gpu/drm/tinydrm/mi0283qt.c
@@ -169,6 +169,7 @@ MODULE_DEVICE_TABLE(spi, mi0283qt_id);
 
 static int mi0283qt_probe(struct spi_device *spi)
 {
+	size_t bufsize = mipi_dbi_max_buf_size(&mi0283qt_mode);
 	struct device *dev = &spi->dev;
 	struct mipi_dbi *mipi;
 	struct gpio_desc *dc;
@@ -201,7 +202,7 @@ static int mi0283qt_probe(struct spi_device *spi)
 
 	device_property_read_u32(dev, "rotation", &rotation);
 
-	ret = mipi_dbi_spi_init(spi, mipi, dc);
+	ret = mipi_dbi_spi_init(spi, mipi, dc, bufsize);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/tinydrm/mipi-dbi.c b/drivers/gpu/drm/tinydrm/mipi-dbi.c
index 75dd65c..16bee06 100644
--- a/drivers/gpu/drm/tinydrm/mipi-dbi.c
+++ b/drivers/gpu/drm/tinydrm/mipi-dbi.c
@@ -364,7 +364,7 @@ int mipi_dbi_init(struct device *dev, struct mipi_dbi *mipi,
 		  struct drm_driver *driver,
 		  const struct drm_display_mode *mode, unsigned int rotation)
 {
-	size_t bufsize = mode->vdisplay * mode->hdisplay * sizeof(u16);
+	size_t bufsize = mipi_dbi_max_buf_size(mode);
 	struct tinydrm_device *tdev = &mipi->tinydrm;
 	int ret;
 
@@ -848,7 +848,7 @@ static int mipi_dbi_typec3_command(struct mipi_dbi *mipi, u8 cmd,
 
 	gpiod_set_value_cansleep(mipi->dc, 0);
 	speed_hz = mipi_dbi_spi_cmd_max_speed(spi, 1);
-	ret = tinydrm_spi_transfer(spi, speed_hz, NULL, 8, &cmd, 1);
+	ret = tinydrm_spi_transfer(spi, speed_hz, NULL, 8, &cmd, NULL, 1);
 	if (ret || !num)
 		return ret;
 
@@ -858,7 +858,8 @@ static int mipi_dbi_typec3_command(struct mipi_dbi *mipi, u8 cmd,
 	gpiod_set_value_cansleep(mipi->dc, 1);
 	speed_hz = mipi_dbi_spi_cmd_max_speed(spi, num);
 
-	return tinydrm_spi_transfer(spi, speed_hz, NULL, bpw, par, num);
+	return tinydrm_spi_transfer(spi, speed_hz, NULL, bpw, par, mipi->rx_buf,
+				    num);
 }
 
 /**
@@ -866,6 +867,7 @@ static int mipi_dbi_typec3_command(struct mipi_dbi *mipi, u8 cmd,
  * @spi: SPI device
  * @mipi: &mipi_dbi structure to initialize
  * @dc: D/C gpio (optional)
+ * @max_size: Maximum TX buffer size needed by the caller
  *
  * This function sets &mipi_dbi->command, enables &mipi->read_commands for the
  * usual read commands. It should be followed by a call to mipi_dbi_init() or
@@ -884,7 +886,7 @@ static int mipi_dbi_typec3_command(struct mipi_dbi *mipi, u8 cmd,
  * Zero on success, negative error code on failure.
  */
 int mipi_dbi_spi_init(struct spi_device *spi, struct mipi_dbi *mipi,
-		      struct gpio_desc *dc)
+		      struct gpio_desc *dc, size_t max_size)
 {
 	size_t tx_size = tinydrm_spi_max_transfer_size(spi, 0);
 	struct device *dev = &spi->dev;
@@ -930,6 +932,16 @@ int mipi_dbi_spi_init(struct spi_device *spi, struct mipi_dbi *mipi,
 			return -ENOMEM;
 	}
 
+	/*
+	 * Allocate a dummy RX buffer if needed, otherwise the SPI controller
+	 * will have to reallocate a new buffer on each transfer.
+	 */
+	if (spi->controller->flags & SPI_CONTROLLER_MUST_RX) {
+		mipi->rx_buf = devm_kmalloc(dev, max_size, GFP_KERNEL);
+		if (!mipi->rx_buf)
+			return -ENOMEM;
+	}
+
 	DRM_DEBUG_DRIVER("SPI speed: %uMHz\n", spi->max_speed_hz / 1000000);
 
 	return 0;
diff --git a/drivers/gpu/drm/tinydrm/st7586.c b/drivers/gpu/drm/tinydrm/st7586.c
index a6396ef..bb0d55d 100644
--- a/drivers/gpu/drm/tinydrm/st7586.c
+++ b/drivers/gpu/drm/tinydrm/st7586.c
@@ -42,6 +42,14 @@
 #define ST7586_DISP_CTRL_MX	BIT(6)
 #define ST7586_DISP_CTRL_MY	BIT(7)
 
+static inline size_t st7586_buf_max_size(const struct drm_display_mode *mode)
+{
+	size_t width = (mode->hdisplay + 2) / 3; /* 3 pixels per byte */
+	size_t height = mode->vdisplay;
+
+	return width * height;
+}
+
 /*
  * The ST7586 controller has an unusual pixel format where 2bpp grayscale is
  * packed 3 pixels per byte with the first two pixels using 3 bits and the 3rd
@@ -263,7 +271,7 @@ static int st7586_init(struct device *dev, struct mipi_dbi *mipi,
 		struct drm_driver *driver, const struct drm_display_mode *mode,
 		unsigned int rotation)
 {
-	size_t bufsize = (mode->vdisplay + 2) / 3 * mode->hdisplay;
+	size_t bufsize = st7586_buf_max_size(mode);
 	struct tinydrm_device *tdev = &mipi->tinydrm;
 	int ret;
 
@@ -337,6 +345,7 @@ MODULE_DEVICE_TABLE(spi, st7586_id);
 
 static int st7586_probe(struct spi_device *spi)
 {
+	size_t bufsize = st7586_buf_max_size(&st7586_mode);
 	struct device *dev = &spi->dev;
 	struct mipi_dbi *mipi;
 	struct gpio_desc *a0;
@@ -361,7 +370,7 @@ static int st7586_probe(struct spi_device *spi)
 
 	device_property_read_u32(dev, "rotation", &rotation);
 
-	ret = mipi_dbi_spi_init(spi, mipi, a0);
+	ret = mipi_dbi_spi_init(spi, mipi, a0, bufsize);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/tinydrm/st7735r.c b/drivers/gpu/drm/tinydrm/st7735r.c
index 08b4fb1..c047bac 100644
--- a/drivers/gpu/drm/tinydrm/st7735r.c
+++ b/drivers/gpu/drm/tinydrm/st7735r.c
@@ -141,6 +141,7 @@ MODULE_DEVICE_TABLE(spi, st7735r_id);
 
 static int st7735r_probe(struct spi_device *spi)
 {
+	size_t bufsize = mipi_dbi_max_buf_size(&jd_t18003_t01_mode);
 	struct device *dev = &spi->dev;
 	struct mipi_dbi *mipi;
 	struct gpio_desc *dc;
@@ -169,7 +170,7 @@ static int st7735r_probe(struct spi_device *spi)
 
 	device_property_read_u32(dev, "rotation", &rotation);
 
-	ret = mipi_dbi_spi_init(spi, mipi, dc);
+	ret = mipi_dbi_spi_init(spi, mipi, dc, bufsize);
 	if (ret)
 		return ret;
 
diff --git a/include/drm/tinydrm/mipi-dbi.h b/include/drm/tinydrm/mipi-dbi.h
index 44e824a..deee862 100644
--- a/include/drm/tinydrm/mipi-dbi.h
+++ b/include/drm/tinydrm/mipi-dbi.h
@@ -31,6 +31,7 @@ struct regulator;
  * @tx_buf: Buffer used for transfer (copy clip rect area)
  * @tx_buf9: Buffer used for Option 1 9-bit conversion
  * @tx_buf9_len: Size of tx_buf9.
+ * @rx_buf: Optional dummy RX buffer.
  * @swap_bytes: Swap bytes in buffer before transfer
  * @reset: Optional reset gpio
  * @rotation: initial rotation in degrees Counter Clock Wise
@@ -48,6 +49,7 @@ struct mipi_dbi {
 	u16 *tx_buf;
 	void *tx_buf9;
 	size_t tx_buf9_len;
+	void *rx_buf;
 	bool swap_bytes;
 	struct gpio_desc *reset;
 	unsigned int rotation;
@@ -62,7 +64,7 @@ mipi_dbi_from_tinydrm(struct tinydrm_device *tdev)
 }
 
 int mipi_dbi_spi_init(struct spi_device *spi, struct mipi_dbi *mipi,
-		      struct gpio_desc *dc);
+		      struct gpio_desc *dc, size_t max_size);
 int mipi_dbi_init(struct device *dev, struct mipi_dbi *mipi,
 		  const struct drm_simple_display_pipe_funcs *pipe_funcs,
 		  struct drm_driver *driver,
@@ -79,6 +81,18 @@ int mipi_dbi_command_read(struct mipi_dbi *mipi, u8 cmd, u8 *val);
 int mipi_dbi_command_buf(struct mipi_dbi *mipi, u8 cmd, u8 *data, size_t len);
 int mipi_dbi_buf_copy(void *dst, struct drm_framebuffer *fb,
 		      struct drm_clip_rect *clip, bool swap);
+
+/**
+ * mipi_dbi_max_buf_size - Get the maximum required framebuffer memory size
+ * @mode: The display mode data
+ *
+ * Computes the maximum buffer size needed for a 2 byte per pixel display.
+ */
+static inline size_t mipi_dbi_max_buf_size(const struct drm_display_mode *mode)
+{
+	return mode->hdisplay * mode->vdisplay * sizeof(u16);
+}
+
 /**
  * mipi_dbi_command - MIPI DCS command with optional parameter(s)
  * @mipi: MIPI structure
diff --git a/include/drm/tinydrm/tinydrm-helpers.h b/include/drm/tinydrm/tinydrm-helpers.h
index d554ded..e5e8f59 100644
--- a/include/drm/tinydrm/tinydrm-helpers.h
+++ b/include/drm/tinydrm/tinydrm-helpers.h
@@ -54,7 +54,7 @@ size_t tinydrm_spi_max_transfer_size(struct spi_device *spi, size_t max_len);
 bool tinydrm_spi_bpw_supported(struct spi_device *spi, u8 bpw);
 int tinydrm_spi_transfer(struct spi_device *spi, u32 speed_hz,
 			 struct spi_transfer *header, u8 bpw, const void *buf,
-			 size_t len);
+			 void *rx_buf, size_t len);
 void _tinydrm_dbg_spi_message(struct spi_device *spi, struct spi_message *m);
 
 #ifdef DEBUG
-- 
2.7.4
