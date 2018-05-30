Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932566AbeE3VcO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:32:14 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:56855 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932222AbeE3VcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:32:09 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Abhishek Sahu <absahu@codeaurora.org>,
        Austin Christ <austinwc@codeaurora.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Bhumika Goyal <bhumirks@gmail.com>, Peter Rosin <peda@axentia.se>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: qup: fix building without CONFIG_ACPI
Date: Wed, 30 May 2018 23:31:49 +0200
Message-Id: <20180530213201.550467-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:RW96WaseYu6XKt5P3gGe1ACuRLJuN4SD16A+MITk4+lEKS0q/zg
 smyBRbiu+YR4rEOYvClTRRGQTqwB35sdVHl29s2IUSAw2vhnifyWEPZwlEh85PJ8qJL4tOE
 aAvjtYsMHYOvufX4WTjcnsyPvfcmb0AoEtqTwGpZdhr5NXTO0mHzEk3FatmWoWQOZchIhng
 uKcgOnnUZPXzELBY4jB6Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rUIwTPR81oc=:sCgo+rQLDoJ76tN79+MUGf
 cE3Gjzbyz9K5LO4W1Pl6qEEVEg7n1fY56upwvC9aJy+nN9wOgEoZCQeVm6h12avzTpeLXSNoX
 HwZB4xEJoIf3EWMGxAJCow9hkiqwPEyYh3dkkie5tYlndBsSt/+snlUJsdWsiJ8hELhydbVTm
 y2ZW2b7uR0Ov5DCAHrZSsphP71UG5CL8bccZrPn0IZvawCzkmKnWFAAzpRnxeXUvHac/wcc/H
 Svqbns2yIhbRyVkHVrYijiUonEFGwz8THsg//e1QfuPvpD5k2HDXLrBDkuBuym6QQDRlmnNNo
 LHz1HW3h0yEENwkmZNOmwcMvDJFnrqHouIH6hufnDshWOR39BX+2L0tMYY4d8sfxUgTMlh+Qw
 ALuYlNe/yxa5Dnfg/Iv66PRV7sQhQZZx9yg9S+StXS+BwJg3AqroiJOcRjANnO+LevK1UhprS
 061djTQfFF2vM0EPsg48phWL7dkITqoyfuaTS/SMQJP1wQfcfuzyttfMtY889uZ0ewwFlXpxe
 2LddtWLIGzOtkSA4nv+BaexLERdG+s6/XG4dUv28kW+mYj+hLq4+iikyEld0ed9P2mklblNqI
 LHg7ZI/rgpRCzM6SNUfhHi2axnZWOlItUo8XbdIS2nhv7LEwkjY0NETaCpjzjWx6Sb0AWTuzt
 bWLzcM87Bmg+kMWY5TSwAsx7RFHqMUU1oTQfmB4cZoATRZe6aRoLD9t70YxU5WaaOZXA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The added Centriq support broke compilation with CONFIG_ACPI disabled:

drivers/i2c/busses/i2c-qup.c: In function 'qup_i2c_probe':
drivers/i2c/busses/i2c-qup.c:1707:25: error: 'qup_i2c_acpi_match' undeclared (first use in this function); did you mean 'qup_i2c_recv_data'?

This fixes it by removing the extraneous #ifdef. All ACPI specific
code will be dropped implicitly when that option is disabled, but
the compiler first needs to see it.

Fixes: 902a91a02bdf ("i2c: qup: add probe path for Centriq ACPI devices")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/i2c/busses/i2c-qup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 4f793b5d0c3b..9cfcc0473227 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -1657,13 +1657,11 @@ static void qup_i2c_disable_clocks(struct qup_i2c_dev *qup)
 	clk_disable_unprepare(qup->pclk);
 }
 
-#if IS_ENABLED(CONFIG_ACPI)
 static const struct acpi_device_id qup_i2c_acpi_match[] = {
 	{ "QCOM8010"},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, qup_i2c_acpi_match);
-#endif
 
 static int qup_i2c_probe(struct platform_device *pdev)
 {
-- 
2.9.0
