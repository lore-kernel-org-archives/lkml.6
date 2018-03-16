Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuDp6K4CGW6IjOS+kGjc4V5/+Ekpk39A6kBP6Ijlrjp64Y/0FZJDLyWdoBBwYn84JYkCGHw
ARC-Seal: i=1; a=rsa-sha256; t=1521214614; cv=none;
        d=google.com; s=arc-20160816;
        b=oDkdSxvT7lOeTU80dMKNkk/7eQdtIVAEq1kTxPX2pVU/zoqrFOeVeRgWhcVR/u8Tms
         U5UiDV2CSr9kBzkS0WMs/UECfqLFQYkBb2sbwcSWJCE/VsDLZy9/iQDlkgv3RpT2ytyK
         SpkfH6qbeI8i8bZCP//K0iefahgNCS9F3znNce3MnF1WXQhbKJcvm+jO+5lbO/Gl2SUr
         wn6VTSKif5S4+ZJPaRNNWrH8MzQ0jJWop3Nq0APyj1ghzWko3pV6ZATjT80pKmrQibfr
         Q6gv8agSVQP9pQ9T/MbadhZIxcH4FPyxij7z8T6TliU3KT2RvgfyH0ar63sWuYJAMseR
         W2Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=r+5foTHKAcg9ApSpAEyesywIfRaCRYAjqKQC2QSxdUE=;
        b=Y9ojdk8mbl794bOH7OS7p+MQjVjRCoAxk/gDmy8wx5gq6SXhGSBLbvsJlKApjpNHYG
         Z/t0sVzXEQhoGlRyfoJM7XuVJ5BLqumfUT//tluqjsDgnO/s+K++LiJEk71dhd/oDaLw
         lkjtJAKJ83lOq4K3Aa+ibO/8IuUKMoWSgy9IrV1OHBkS9wct5km1vLCZU7Ro7joL5bMj
         dh+gppfGvMzoRGCrySeXm6L9wGzUjFaRtVjI0LkBtDN0Scets9jM9DUh46kYSfUV0io/
         0XaDBOlaxwsH1TZWfvi9fi+ii67YzutB8KbjiCc7AXx4g/P75kc/b09m4+a4TcGRcF2z
         8cdw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xingyu Chen <xingyu.chen@amlogic.com>,
	Yixun Lan <yixun.lan@amlogic.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 034/109] clk: meson: gxbb: fix wrong clock for SARADC/SANA
Date: Fri, 16 Mar 2018 16:23:03 +0100
Message-Id: <20180316152331.813912773@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109135350374663?=
X-GMAIL-MSGID: =?utf-8?q?1595109135350374663?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yixun Lan <yixun.lan@amlogic.com>


[ Upstream commit 75eccf5ed83250c0aeaeeb76f7288254ac0a87b4 ]

According to the datasheet, in Meson-GXBB/GXL series,
The clock gate bit for SARADC is HHI_GCLK_MPEG2 bit[22],
while clock gate bit for SANA is HHI_GCLK_MPEG0 bit[10].

Test passed at gxl-s905x-p212 board.

The following published datasheets are wrong and should be updated
[1] GXBB v1.1.4
[2] GXL v0.3_20170314

Fixes: 738f66d3211d ("clk: gxbb: add AmLogic GXBB clk controller driver")
Tested-by: Xingyu Chen <xingyu.chen@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/meson/gxbb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -1139,7 +1139,7 @@ static MESON_GATE(gxbb_pl301, HHI_GCLK_M
 static MESON_GATE(gxbb_periphs, HHI_GCLK_MPEG0, 7);
 static MESON_GATE(gxbb_spicc, HHI_GCLK_MPEG0, 8);
 static MESON_GATE(gxbb_i2c, HHI_GCLK_MPEG0, 9);
-static MESON_GATE(gxbb_sar_adc, HHI_GCLK_MPEG0, 10);
+static MESON_GATE(gxbb_sana, HHI_GCLK_MPEG0, 10);
 static MESON_GATE(gxbb_smart_card, HHI_GCLK_MPEG0, 11);
 static MESON_GATE(gxbb_rng0, HHI_GCLK_MPEG0, 12);
 static MESON_GATE(gxbb_uart0, HHI_GCLK_MPEG0, 13);
@@ -1190,7 +1190,7 @@ static MESON_GATE(gxbb_usb0_ddr_bridge,
 static MESON_GATE(gxbb_mmc_pclk, HHI_GCLK_MPEG2, 11);
 static MESON_GATE(gxbb_dvin, HHI_GCLK_MPEG2, 12);
 static MESON_GATE(gxbb_uart2, HHI_GCLK_MPEG2, 15);
-static MESON_GATE(gxbb_sana, HHI_GCLK_MPEG2, 22);
+static MESON_GATE(gxbb_sar_adc, HHI_GCLK_MPEG2, 22);
 static MESON_GATE(gxbb_vpu_intr, HHI_GCLK_MPEG2, 25);
 static MESON_GATE(gxbb_sec_ahb_ahb3_bridge, HHI_GCLK_MPEG2, 26);
 static MESON_GATE(gxbb_clk81_a53, HHI_GCLK_MPEG2, 29);
