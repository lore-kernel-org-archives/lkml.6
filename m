Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76955C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5152B21473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731533AbfA3PIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:08:09 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:50665 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731068AbfA3PII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:08:08 -0500
Received: from stefan-Vostro-260.fritz.box ([109.104.32.180]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N8onQ-1hCO342xCo-015nGv; Wed, 30 Jan 2019 16:07:36 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC 0/3] hwmon: pwm-fan: Add RPM support
Date:   Wed, 30 Jan 2019 16:07:04 +0100
Message-Id: <1548860827-29796-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:O0KPWkz9HK3nyFfKF7NtmuQHgVbuEd8rQEu7RyoO9NHBPe+ROfX
 zquxLjc3HV3gf88Qt2GJDRa4fUvv19HGBGiWBEBIYzfoxzsTB1yRJhFj43ojPp8rp54YVqY
 m0yymK/rSranFw1Z581eRurLVVGClPi8YqFip6unDDa5hlvyCCV8KE84FlmydQcXEr39xMe
 mCuLKzM9Ja0mFNOvPxWFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VZvABbrO+0U=:7+AvEAHGKk28uOXXsP57Xs
 0iVWz7+beVmTrqZ8abBj8m75lY3KbhJ6STngBBW0iTTAsSJK/QW4a2Wv8utT8kX0MEE052o9a
 Y7cGGd9T0erTzpwNQrMr5e3CQuWJiktkNG6VaKi5Oe5/4cFwPXEQJE97T2c8a9b182vyv8n9H
 sV63eF3aNga7O/nyZ/GfigxR0NBjKJBxp7XiJAe0C2czesB//9eY3oGRzD2L5YXPXgoXp1YI/
 4JZ3R3PibKxSs+muNZ+D4sREfEM4p0AzJpywuqmGr1gs96A23IgxW6g8siH4n7JV7RJxvc4j8
 kMoXzjm8ePANkpJ+yhln+S38qM/hYoEBX8oZZTHA/h4ozKihOa1WBBSR1t6USUN1SV+rywzSb
 2pwJzCX87JqEibnOiIw4LzeRVheIVHMqvyQCuZftX2N9W2DJFtZ3NArsDocxMN5Ayy3YN57XZ
 1PAEuxb6W3dKdS8Eugb8JU5/Llk74rHolmLFRP39YhwqfSDu7GUZKvHSaFNrDnJmtclR6pBzZ
 2GZVkJ4yfriRuer+sftPsgYKDCcZN3ERJ67jzAob89vn+02bI/hTQu+oaUd0XLWREHkJlJ9ZY
 LX8Rk8W8R/pQrkwwsB2c2t0jwugCeYwE07CWaQs+r5vFsjEJM7G13d7vj/dXBV45Pp1arCEao
 j3HQmv6+51ImZk0tRRXCt7UuOZgZXyCjI806kRM4ypBGU3zKLUnRVnH31kECBt1SKaEEuaEtL
 D0gsH7J8vSFZ2R8PHiuoadkd5EHoKn+k1qGgxFpcq8ZrfWq1ZrQeU4uJc7M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Contrary to the gpio-fan the pwm-fan driver isn't easy to setup
with pwmconfig/fancontrol because of the missing hwmon sysfs entry
for actual revolutions per minute. This series adds this feature.

This series based on the recently submitted regulator support.

Stefan Wahren (3):
  dt-bindings: hwmon: Add tachometer interrupt to pwm-fan
  Documentation: pwm-fan: Add description for RPM support
  hwmon: pwm-fan: Add RPM support via external interrupt

 .../devicetree/bindings/hwmon/pwm-fan.txt          |  3 ++
 Documentation/hwmon/pwm-fan                        |  4 ++
 drivers/hwmon/pwm-fan.c                            | 55 ++++++++++++++++++++++
 3 files changed, 62 insertions(+)

-- 
2.7.4

