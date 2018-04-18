Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbeDRW1A (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 18:27:00 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:37595 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbeDRW07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 18:26:59 -0400
Date: Thu, 19 Apr 2018 00:26:07 +0200 (CEST)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Markus Mayer <mmayer@broadcom.com>, linux-pm@vger.kernel.org,
        Eric Anholt <eric@anholt.net>, Keerthy <j-keerthy@ti.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        Jun Nie <jun.nie@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
        Baoyou Xie <baoyou.xie@linaro.org>
Message-ID: <1578244948.69815.1524090367636@email.1und1.de>
In-Reply-To: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
References: <CGME20180410124240epcas2p25c8979583c41f147ac34c49faf30aa14@epcas2p2.samsung.com>
 <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
Subject: Re: [PATCH 00/17] thermal: enable/check sensor after its setup is
 finished
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev22
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:GyvqqGil6hUWciKxG9e2c4t5czLV+VYos298nrMiYEEg4NsAj2I
 gnqXE4qYq8fG57T5dx16rIJH4Bqq+9yVfNDyrgQBwakrp6ABBe/nzZXXK+M133yT6s5S56c
 hwiK15T+gKREQ/TJg5cIIIdKtUi+44fZi1d4QpEgmKE3VoBVfQhYijz5DVHfRSVl8mf9bSm
 KAlxM4ZlI/kkNHp6FvVGA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yJK7bwNmuSk=:0YyCgF1aEj4AxvaXs81Yx/
 44vHA40mgkg6fEE0Mj9y73KGWeZdXRu/d7SOfiLDKipJ+p1bRZS2ovQMwMOpZLIwhSiVFIPUs
 CU4hUu8xXbDQMBUMRieAC+/cph0zFOXJVbVh3F8XGhh2incOrpTGBjmnfJ9qAw/GyJRmlcf+u
 i07RZLU/1bq6GigtwOOxygUw6k6RgbwMSg87md940+kzmPxXgDRKYeDcCR9sKq6UlzHRJlLkq
 ITxsLKTsR1AYiGyD1GJ7tBw4VYhz4NAj8DD+eNWlaXWF5NmHScO1f8j2kDw2CjhzWv9ubBmsQ
 KSg3xzZr1F/aFnWlPYiwMdrdsqoSvd2xVZEzN6nLTfdMpP5xWrXfn3u/RM+O8sQfvLcTOWgX0
 D6cotNQaLLO22ebioN/cTukANeFf1qy9L06dGqLZ0ybtlNEnrlZolShjV1V5QzTpycuwihmCe
 5JcA9xnvQivGLzzEgLT5d3rDktmtnSzjnQ7vC5kB7v2ksClq94OADeKsMPoqL52um2mZU/nrB
 o2lsm0u9WNuJu30LUVad5PQ3phA3vQIeBGCYGj+aMEOX8tIhutsx5c3pXWisRf0xk5S7MUL9s
 Tgm4g0cvfmgjQNlyh8C1J6gkF2XxxE6iuniQDwQijXhEKwtbv4pm758qBfai4V5IbkT9AB1lm
 iTQ5Xc+AnI62a5ou/t2Th4C+3brAfPPuVMyTne6zTntJnShJ5wV3x1tyFTvylO+2B4OnI5ZYh
 w2kVdD+bJ8FaJAEEJKhyuKp5QBqtgG712MmaAS6tZUo+cyRi4Q7frXoU+qE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartlomiej,

> Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com> hat am 10. April 2018 um 14:41 geschrieben:
> 
> 
> Hi,
> 
> [devm]_thermal_zone_of_sensor_register() is used to register
> thermal sensor by thermal drivers using DeviceTree. Besides
> registering sensor this function also immediately enables it
> (using ->set_mode method) and then checks it with a update call
> to the thermal core (which ends up using ->get_temp method).
> For many DT thermal drivers this causes a problem because
> [devm]_thermal_zone_of_sensor_register() need to be called in
> order to obtain data about thermal trips which are then used to
> finish hardware sensor setup (only after which ->get_temp can
> be used). The issue has been observed when using Samsung Exynos
> thermal driver and fixed internally in the driver in commit
> d8efad71e5b6 ("thermal: exynos: Reading temperature makes sense
> only when TMU is turned on"). However after this commit there
> are now following warnings from the thermal core visible:
> 
> [    3.453602] thermal thermal_zone0: failed to read out thermal zone (-22)
> [    3.483468] thermal thermal_zone1: failed to read out thermal zone (-22)
> [    3.505965] thermal thermal_zone2: failed to read out thermal zone (-22)
> [    3.528455] thermal thermal_zone3: failed to read out thermal zone (-22)
> [    3.550939] thermal thermal_zone4: failed to read out thermal zone (-22)
> 
> This patchset attempts to directly address the thermal core
> problem with [devm]_thermal_zone_of_sensor_register() and
> affected DT thermal drivers. In order to achieve this sensor
> registration, enable and check operations are separated and
> corresponding drivers are modified to use the new helpers to
> enable and check sensor explicitly.

i've tested patch 1-5 + 17 on a Raspberry Pi 1 B and didn't see any regressions.

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
