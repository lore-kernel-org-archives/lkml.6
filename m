Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CF5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39C82243E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QQxO8/SV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C39C82243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388460AbeKPBU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:20:27 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:35632 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387839AbeKPBU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:20:27 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20181115151209epoutp01953f46a9136a35830216eb53aa42ae89~nVOKRmrqQ0617906179epoutp01J;
        Thu, 15 Nov 2018 15:12:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20181115151209epoutp01953f46a9136a35830216eb53aa42ae89~nVOKRmrqQ0617906179epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542294729;
        bh=sdcBdklfj9pvomBPmTMp0SEphMakkVV863pYWtw29aQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=QQxO8/SVSNOw1k4LtaXLtwFLLotIRFjq247VZ+ky7tSRttY25m4vFMfLHXULuEOgB
         yIuK3yttSb0aj0UnB/XkXCxaZaaM6RmQfbl0CryjyVhsYcW7k4oZbcc+blj220QfZn
         OGQ8rF8N0Z4n5su8VMJo+dU9zFF8NBp+wjkV19jM=
Received: from epsmges1p2.samsung.com (unknown [182.195.42.54]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20181115151207epcas1p31e126f8cb8a92cc9b576bb6f1164031c~nVOIoD2483141131411epcas1p3j;
        Thu, 15 Nov 2018 15:12:07 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C0.56.04069.7CC8DEB5; Fri, 16 Nov 2018 00:12:07 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20181115151207epcas1p45adfa96d5b52e10fbb5ace76ebae5e3e~nVOIOLR4j0538805388epcas1p40;
        Thu, 15 Nov 2018 15:12:07 +0000 (GMT)
X-AuditID: b6c32a36-f2bff70000000fe5-be-5bed8cc744e1
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 63.B9.03701.7CC8DEB5; Fri, 16 Nov
        2018 00:12:07 +0900 (KST)
Received: from AMDC3058.DIGITAL.local ([106.120.53.102]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PI8006WJQ7YQ380@mmp2.samsung.com>; Fri, 16 Nov 2018
        00:12:07 +0900 (KST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 0/9] ARM: SAMSUNG: add Exynos chipid driver
Date:   Thu, 15 Nov 2018 16:11:29 +0100
Message-id: <1542294698-17470-1-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWy7bCmnu7xnrfRBr9vqFvcWneO1eLvpGPs
        FhtnrGe1uP7lOavFwmnLGS36H79mtjh/fgO7xabH11gtLu+aw2Yx4/w+JouXR34wWqw9cpfd
        YtHWL+wOvB6/f01i9Lh1p95j06pONo/NS+o93u+7yubRt2UVo8fnTXIB7FFcNimpOZllqUX6
        dglcGcc7LjEVzBKuaPqylb2B8SFfFyMnh4SAicScW5vZuxi5OIQEdjBKzFj/khHC+c4osWDh
        UlaYqvbZ21ggEhsYJX6190C1/GKUWHqrF6yKTcBKYmL7KkYQW0RAU+L63+9gcWaBo8wSS65I
        gNjCAtYSU7vfM4HYLAKqEk0Hr4PV8Ap4SMz9sRdqm5zEyWOTWUEWSAisYZM4fGsqC0TCRWJe
        RydUkbDEq+NbgK7gALKlJS4dtYWon84o8ebXUhYIZz2jxJozx5ggGqwlDh+/CHURn8S7rz2s
        EM28Eh1tQhAlHhIb7zxjAQkLCcRKXH9qOAEYCIwMqxjFUguKc9NTiw0LjPSKE3OLS/PS9ZLz
        czcxgiNWy2wH46JzPocYBTgYlXh4DcrfRguxJpYVV+YeYpTgYFYS4XWrAwrxpiRWVqUW5ccX
        leakFh9ilOZgURLnfSI1N1pIID2xJDU7NbUgtQgmy8TBKdXAqO+69t3OP5X7vXcJf3z6pv+m
        +fvwwA7zDrOZJ2+cnf9hJo9T5DXRu54H3z498Dmu9PI/cRE5npO3tnPN45js0Hvz7ZRSHfNd
        W7PEHhpNKijIs021Ldsnn7Gt/VRJR9Qmpcg3sy9OCMswOePMnHtgwdr1LOL1DjGztndNv23P
        eGnKhejA1ddVjymxFGckGmoxFxUnAgAtG5UN1AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFLMWRmVeSWpSXmKPExsVy+t9jQd3jPW+jDX6t4LS4te4cq8XfScfY
        LTbOWM9qcf3Lc1aLhdOWM1r0P37NbHH+/AZ2i02Pr7FaXN41h81ixvl9TBYvj/xgtFh75C67
        xaKtX9gdeD1+/5rE6HHrTr3HplWdbB6bl9R7vN93lc2jb8sqRo/Pm+QC2KO4bFJSczLLUov0
        7RK4Mo53XGIqmCVc0fRlK3sD40O+LkZODgkBE4n22dtYQGwhgXWMEjPOZXYxcgHZvxglpl3a
        xwSSYBOwkpjYvooRxBYR0JS4/vc7K0gRs8BRZonPE7YzgySEBawlpna/B2tgEVCVaDp4nRXE
        5hXwkJj7Yy8rxDY5iZPHJrNOYORawMiwilEytaA4Nz232KjAMC+1XK84Mbe4NC9dLzk/dxMj
        MMS2Hdbq28F4f0n8IUYBDkYlHl6D8rfRQqyJZcWVuYcYJTiYlUR43eqAQrwpiZVVqUX58UWl
        OanFhxilOViUxHlv5x2LFBJITyxJzU5NLUgtgskycXBKNTBq3ZkVdUzx2kY7/7XM/Lf8H59t
        63Toqzt1gO3B/63/hauPComI2E8UWrTm1PFK9qKjmw0uRL2am6WSWhQ3pfxwL9tl41c5ErcV
        a5ndTC/tNLc55pR9xaLY+1uw+583WxYmaZlwqq3NiU7Pi9nROPPVVrMjS4pefV2/XdEraq9s
        r+/VFp7cK95KLMUZiYZazEXFiQDKNlXkLQIAAA==
X-CMS-MailID: 20181115151207epcas1p45adfa96d5b52e10fbb5ace76ebae5e3e
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20181115151207epcas1p45adfa96d5b52e10fbb5ace76ebae5e3e
References: <CGME20181115151207epcas1p45adfa96d5b52e10fbb5ace76ebae5e3e@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset adds Exynos chipid driver and converts Exynos platform
code to use it. It is heavily based on "[PATCH v9 00/12] Introducing
Exynos ChipId driver" patchset [1] so most credits go to Pankaj Dubey.
The main difference in the current patchset is in taking simpler
approach to converting existing Exynos platform code to use the new
chipid driver. This results in much less code duplication.

The diffstat for "[PATCH v9 00/12] Introducing Exynos ChipId driver":

 14 files changed, 587 insertions(+), 255 deletions(-)

for the current patchset it is:

 14 files changed, 193 insertions(+), 195 deletions(-)

This patchset has been tested on Exynos4210 (including rev0),
Exynos3250, Exynos4412 & Exynos5422 SoCs.

[1] https://marc.info/?l=linux-arm-kernel&m=149087972213359&w=2

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (5):
  ARM: EXYNOS: use chipid driver
  ARM: EXYNOS: remove soc_is_exynos*() macros
  ARM: SAMSUNG: remove samsung_rev()
  ARM: SAMSUNG: remove s5p_init_cpu()
  ARM: EXYNOS: remove <mach/map.h> include

Pankaj Dubey (4):
  ARM: EXYNOS: remove secondary startup initialization from
    smp_prepare_cpus
  soc: samsung: add exynos chipid driver support
  ARM: EXYNOS: enable exynos_chipid for ARCH_EXYNOS
  ARM64: EXYNOS: enable exynos_chipid for ARCH_EXYNOS

 arch/arm/mach-exynos/Kconfig                 |   1 +
 arch/arm/mach-exynos/common.h                |  81 ++-----------------
 arch/arm/mach-exynos/exynos.c                |  75 ++++++++++--------
 arch/arm/mach-exynos/firmware.c              |   8 +-
 arch/arm/mach-exynos/include/mach/map.h      |  18 -----
 arch/arm/mach-exynos/platsmp.c               |  40 ++--------
 arch/arm/mach-exynos/pm.c                    |  25 +++---
 arch/arm/plat-samsung/cpu.c                  |  17 ----
 arch/arm/plat-samsung/include/plat/cpu.h     |   3 -
 arch/arm/plat-samsung/include/plat/map-s5p.h |   2 -
 arch/arm64/Kconfig.platforms                 |   1 +
 drivers/soc/samsung/Kconfig                  |   5 ++
 drivers/soc/samsung/Makefile                 |   1 +
 drivers/soc/samsung/exynos-chipid.c          | 111 +++++++++++++++++++++++++++
 14 files changed, 193 insertions(+), 195 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/include/mach/map.h
 create mode 100644 drivers/soc/samsung/exynos-chipid.c

-- 
1.9.1

