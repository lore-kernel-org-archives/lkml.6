Return-Path: <paul.kocialkowski@bootlin.com>
X-Google-Smtp-Source: AB8JxZqOGDhuon240YRaSlItmTXgGQBq8jhUnjBGGhhZDfA7T2gwmmpYWhEOWtMFBj5peA/KLsNJ
ARC-Seal: i=1; a=rsa-sha256; t=1525697251; cv=none;
        d=google.com; s=arc-20160816;
        b=SUTr5gpHlDZFnc2grLjgzBu6v9n8vW17DyaAzdJC1uCOck4amVkqvoBq6qJ3K6Dcgz
         ffQ1WkkZvuFSwt/xHr6pR1+32JIwa5yWPe8ihUB4B7F/5REudS/DxV4orA2q2dWGvaiA
         J04CwZFsTyq61c0dInvP3QYdovfocJuIZYmMiMnX+IkWwbF+oFw0Q9h/yNKXfSsT94wt
         HojGdRnk/2MlmtXppqu+mXqvO/jbXdiPZ9RiruURso8Yl0Ggpk4leVkW7OVUml6Wd4K7
         /v+EbK0/itJARtpg7Maz7AmBKy2KCQ5YiVKbbV5oRyJN/UWlX/8Jokzs19a0GWykdKbI
         oO4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=w5X/QWN3csceZwFMlqjuc4Ob8PMUjR0t1SerzeXviFY=;
        b=xHweyD+5sZCYY/CPbIazcvkeyc/SRdHgA+gz/m8f4Zk03oINxuopxGVyJZl2wScTvy
         RYzZqrsRbQ7NLcwmiuPFUakiloNQh2qunb1bjRIiDyVkd1QslabsBevn2N9eGCdWPQ8w
         MhLufULjSdrra0NEVPP3ztBxZzSJWTQJ1WQzBiG7zVFjMHJlXR+aDXr94yO2cW9Odklv
         R6YGYLOUD/LOLAMpOsmXhdhXxm4AonFnLAVOgusXkPTXFd1KRh4ghro4nMX3RAjEmQOa
         HHtU6KxNleUTe+9SYk1jOi4BDyirgFUuRwij/KUKXBsCIgzfCPopApFVQ3M1ix+9F+Uj
         jhig==
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
Subject: [PATCH v3 01/14] drivers: soc: sunxi: Add support for the C1 SRAM region
Date: Mon,  7 May 2018 14:44:47 +0200
Message-Id: <20180507124500.20434-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
References: <20180507124500.20434-1-paul.kocialkowski@bootlin.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599809520628646705?=
X-GMAIL-MSGID: =?utf-8?q?1599809520628646705?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Maxime Ripard <maxime.ripard@bootlin.com>

This introduces support for the SRAM C1 section, that is controlled by
the system controller. This SRAM area can be muxed either to the CPU
or the Video Engine, that needs this area to store various tables (e.g.
the Huffman VLD decoding tables).

This only supports devices with the same layout as the A10 (which also
includes the A13, A20, A33 and other SoCs).

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/soc/sunxi/sunxi_sram.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
index 882be5ed7e84..74cb81f37bd6 100644
--- a/drivers/soc/sunxi/sunxi_sram.c
+++ b/drivers/soc/sunxi/sunxi_sram.c
@@ -63,6 +63,12 @@ static struct sunxi_sram_desc sun4i_a10_sram_a3_a4 = {
 				  SUNXI_SRAM_MAP(1, 1, "emac")),
 };
 
+static struct sunxi_sram_desc sun4i_a10_sram_c1 = {
+	.data	= SUNXI_SRAM_DATA("C1", 0x0, 0x0, 31,
+				  SUNXI_SRAM_MAP(0, 0, "cpu"),
+				  SUNXI_SRAM_MAP(0x7fffffff, 1, "ve")),
+};
+
 static struct sunxi_sram_desc sun4i_a10_sram_d = {
 	.data	= SUNXI_SRAM_DATA("D", 0x4, 0x0, 1,
 				  SUNXI_SRAM_MAP(0, 0, "cpu"),
@@ -80,6 +86,10 @@ static const struct of_device_id sunxi_sram_dt_ids[] = {
 		.compatible	= "allwinner,sun4i-a10-sram-a3-a4",
 		.data		= &sun4i_a10_sram_a3_a4.data,
 	},
+	{
+		.compatible	= "allwinner,sun4i-a10-sram-c1",
+		.data		= &sun4i_a10_sram_c1.data,
+	},
 	{
 		.compatible	= "allwinner,sun4i-a10-sram-d",
 		.data		= &sun4i_a10_sram_d.data,
-- 
2.16.3
