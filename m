Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DDEC0044B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DE9222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394648AbfBMU5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:57:47 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:34003 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388727AbfBMU5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 15:57:46 -0500
Received: from orion.localdomain ([77.7.10.70]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MjgfT-1hNM9C2WoV-00lGWO; Wed, 13 Feb 2019 21:57:37 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org, andy@infradead.org,
        dvhart@infradead.org, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org
Subject: APUv2/v3 board support V2
Date:   Wed, 13 Feb 2019 21:57:26 +0100
Message-Id: <1550091448-28578-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:RSuJDMbSfTVA1nfdg2/FhIgiXdYjyLY75Rlhp7/hyzPAikoRQ1I
 TgpHKxxbJTWQ5LlvoegdaxL5NQEw489yqEAom7wkogDQH74bR81Helzp8ja9kNFP/ypQPaM
 wTa765t78toQUoYIIoRG0+Fr4LHW5Agm+f25/r8o4uxQEeLwCWtdqjnnhY8SC9cvHSxy8is
 djCUS/5WyOdggPz/pb5+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G/tOEyjjFFs=:U3UyNtVpg7T3bmyJ/WxBqP
 WybCQQuDNUBynwarwWuU91ueKwiwSvYX9HAeYt3Gg97mrh71QYgbd1j/RIPY0YR9gjwSo70Dw
 fD887OnBQuezB2kn7lAPE+6lvqYAe+K+At8tnADGG7jkDrOisPd5BgxcvQComk3dzES4pO1jh
 sikronNXMj5dGkKw5KRT/Tmvy6gkx3KjqO80NMXVJ80xn3qFzJUUf5CTNWfKs9pRBtNjaFiDZ
 tZnzyJFM7iswcBU/6gEpsz5Tgkob4F44O2VLeTBgGaQwaO6O3yIK4rYC6TC80FtLFyYN5RJ+b
 wQFlfhVHqJSaElUiIrbM2SnyU2H4obiMVRiW7HZUcAK1aK5Xe1aSfRuNgRn329rxGFiIYbVba
 UpgQWxWNFSSK0TtptB6WJVMa67WTcqQDjnr9E7Da8Igusb84HOCqh23nhfChedAo77AEUT65h
 vZwdWCPHrPrX9iXt/npl+DmSrqsL1Q92m7HsoQyA5uFWOjQv5Z99p/asguhaZoGnRw98l016o
 fMgODXL/51bX+EY9VgmSeNRet+v7Jz6LJ0lfuW0i2T0T5/AJ2d5aQfXpgWvVvabRKn+RNkoJq
 LMX21WRyMZQQG3t0QVPoWG4chfBU1OJN86+MLub1EIhOFMd6qvchSgQG3erGNVG3cmVWD6X15
 b+4aBFZ3x51qohVmVdkAQjwboZAVTC0dJqkV0egw6XjjQvZbmPjt1loeUOLOo2Gv2D8/DwX7w
 FIiwvbM0EFkLT5VAwDplo96fq9HIuLbU6YUSgQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,


this is version 2 of my APUv2/APUv3 series. Heavily reworked,
hope I've now addressed all issues of the last one.


Major changes are:
 * using gpiod_lookup_table instead of hardcoded gpio numbers
 * moved the PCHs gpio register definitions to the gpio drivers'
   header (but keeping the actual assignments in the board driver,
   as they're board speficic)
 * moved IO resource definition from board to gpio driver
   (the FCHs mmio base address could be changed, but nobody
   seems to ever do it)
 * added gpio line names
 * moved the gpio driver's pdata definitions to::
   include/linux/platform_data/gpio/gpio-amd-fch.h
 * reduced some code redundancies and various cleanups

Possibly debatable:
 * does is the assigned key code fit well ? (KEY_SETUP seemed the
   best candidate to me, but I'm open to suggestions)
 * should the pch gpio become a sub-device of some toplevel PCH
   device ? (which then could also maintain the base address, etc)

Note: the keyboard device needs separate patch for gpiod_lookup_table
support in gpio-keys-polled driver. I'll sent it separately.


--mtx


-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
