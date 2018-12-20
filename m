Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D701EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A45021741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 10:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="E4RlMnHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbeLTKXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 05:23:02 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44083 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbeLTKXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 05:23:02 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181220102300euoutp0217903aa2bbf60436ff0a66f72d3ccb83~yA2ry7d1m2904229042euoutp02o;
        Thu, 20 Dec 2018 10:23:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181220102300euoutp0217903aa2bbf60436ff0a66f72d3ccb83~yA2ry7d1m2904229042euoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545301380;
        bh=gXXPWLyIIksGpJBpdP9wgUBqHTK9VHca9DO7KeBZFdA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=E4RlMnHMZHT3MHbORlOojrC9LWHcm5YwPZKRJ41JlhHVat2R0YKsQ7DquSnJ52b3k
         wfe3oAuoQCd22TL5LYzzFnOsSPJs6fczCOoQP0vIyvcEiVnrYTEzKDBO5PPshW3zqG
         C+4T4WLFJ1KncSjtdiwmgoqqEy3J04kypq+NbN4E=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181220102259eucas1p2ff36a1116e23abb31680baf332651443~yA2rUN4nM0445704457eucas1p26;
        Thu, 20 Dec 2018 10:22:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 92.BC.04441.38D6B1C5; Thu, 20
        Dec 2018 10:22:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181220102258eucas1p1ca5abb0b48d1f13d9234a4a7702a13da~yA2qnsYRf1719217192eucas1p1H;
        Thu, 20 Dec 2018 10:22:58 +0000 (GMT)
X-AuditID: cbfec7f2-a1ae89c000001159-be-5c1b6d836c8d
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 17.6E.04128.28D6B1C5; Thu, 20
        Dec 2018 10:22:58 +0000 (GMT)
Received: from AMDC3748.DIGITAL.local ([106.120.43.17]) by
        eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PK100480669SP10@eusync3.samsung.com>;
        Thu, 20 Dec 2018 10:22:58 +0000 (GMT)
From:   Andrzej Hajda <a.hajda@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-arm-kernel@lists.infradead.org, andy.shevchenko@gmail.com,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: [PATCH v4 0/3] driver core: add probe error check helper
Date:   Thu, 20 Dec 2018 11:22:44 +0100
Message-id: <20181220102247.4911-1-a.hajda@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsWy7djP87rNudIxBrv/c1ncWneO1eLlhMOM
        FhtnrGe1mPrwCZtF8+L1bBYLpy1ntNj0+BqrxeVdc9gsDk3dy2ix9shddou5X6YyO3B7XL52
        kdlj56y77B6bVnWyeeyfu4bdY/OSeo/3+66yefRtWcXo8XmTXABHFJdNSmpOZllqkb5dAlfG
        4YWbWQr28FYcXJHYwPiaq4uRg0NCwERi2qOULkYuDiGBFYwSkyZ2M0M4nxklvh5aztLFyAlW
        dKpxNRNEYhmjxNar16Cq/jNKLDy1kwmkik1AU+Lv5ptsILaIgLFE/9lZ7CBFzALzmCVevroD
        ViQs4Chx7dAtZhCbRUBVYuqGpawgNq+AucSJ+S1Q6+QlVm84ALZBQmABm8TXxufMEAkXiaMr
        J0EVCUu8Or6FHcKWkbg8uRsqXi/RNPMKVHMHo8SJxcvZIBLWEoePXwTbxizAJzFp23RmSAjw
        SnS0CUGUeEhc3HQHrERIIFbi+6rVLBMYJRYwMqxiFE8tLc5NTy02zEst1ytOzC0uzUvXS87P
        3cQIjNXT/45/2sH49VLSIUYBDkYlHt4ZUVIxQqyJZcWVuYcYJTiYlUR4H2dJxwjxpiRWVqUW
        5ccXleakFh9ilOZgURLnrWZ4EC0kkJ5YkpqdmlqQWgSTZeLglGpgbN21SfM2ry1PLvdJpg9V
        qRPym1bdudB9zUP1o97VuyvEyj73vdP9Xi67V+fAYtuzi/98qjorH/T26r/nz+encc9fXp2j
        8r5P8eDdmasld1i8/Mg+R/Hl6YSwB9N3eofv6OxceMXB9fycf071Mxd/7Xmt9OjDX7u7sgu/
        HJp0NXal7KqcQ8f/1yxXYinOSDTUYi4qTgQAndPLoNECAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprILMWRmVeSWpSXmKPExsVy+t/xq7pNudIxBjsnqVvcWneO1eLlhMOM
        FhtnrGe1mPrwCZtF8+L1bBYLpy1ntNj0+BqrxeVdc9gsDk3dy2ix9shddou5X6YyO3B7XL52
        kdlj56y77B6bVnWyeeyfu4bdY/OSeo/3+66yefRtWcXo8XmTXABHFJdNSmpOZllqkb5dAlfG
        4YWbWQr28FYcXJHYwPiaq4uRk0NCwETiVONqpi5GLg4hgSWMEgfvPGGEcBqZJM5uesMCUsUm
        oCnxd/NNNhBbRMBYov/sLHaQImaBRcwSe9ftYwVJCAs4Slw7dIsZxGYRUJWYumEpWJxXwFzi
        xPwWFoh18hKrNxxgnsDItYCRYRWjSGppcW56brGRXnFibnFpXrpecn7uJkZgQG079nPLDsau
        d8GHGAU4GJV4eGdEScUIsSaWFVfmHmKU4GBWEuF9nCUdI8SbklhZlVqUH19UmpNafIhRmoNF
        SZz3vEFllJBAemJJanZqakFqEUyWiYNTqoGxLVrw0OcnFkuWWl56+oBh3vdVM63tfh16+Hhi
        VVpOqArHRMbkOLf1u6XqH5z5IJV897mekd8/vbePChaV/dxjt3BRZePJK+2XHz31aQnZyPN3
        y/nmW9dWvc79dedGz7dlNcfd1W9rXG/J3XnV/4el6wc7hpI3706oNyj56bGyLnkvu/SgcpSz
        ghJLcUaioRZzUXEiAE/OtsMkAgAA
X-CMS-MailID: 20181220102258eucas1p1ca5abb0b48d1f13d9234a4a7702a13da
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181220102258eucas1p1ca5abb0b48d1f13d9234a4a7702a13da
References: <CGME20181220102258eucas1p1ca5abb0b48d1f13d9234a4a7702a13da@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, Rafael,

This patchset proposes probe helper function which should simplify little bit
resource acquisition error handling, it also extend it with adding defer probe
reason to devices_deferred property:

This patchset is actually resend of the most important 1st and 2nd patch.

I have also attached patch adding probe_err_ptr - it will allow to replace
quite frequent calls:
    probe_err(dev, PTR_ERR(ptr), ...)
with
    probe_err_ptr(dev, ptr, ...)

I have dropped the last patch showing usage of probe_err(_ptr)? as it is
very big, should be split per subsystem, and should be applied after merge
of patches introducing probe_err(_ptr) helpers.

Just for the record - my dirty cocci script generates patch which replaces
code with probe_err* helpers with following stats (on linux_next branch):
   1585 probe_err
   1194 probe_err_ptr
   1638 files changed, 6487 insertions(+), 9163 deletions(-).
Of course there are much more places where probe_err* can be applied, the script
tries to catch the most obvious ones.
More importantly probe_err should handle probe errors more correctly
and uniformly than it is done now.

If this patchset will be accepted I will try to send patches introducing probe_err*
per subsystem.

Regards
Andrzej


Andrzej Hajda (3):
  driver core: add probe_err log helper
  driver core: add deferring probe reason to devices_deferred property
  driver core: add probe_err_ptr helper

 drivers/base/base.h    |  3 +++
 drivers/base/core.c    | 40 ++++++++++++++++++++++++++++++++++++++++
 drivers/base/dd.c      | 21 ++++++++++++++++++++-
 include/linux/device.h |  5 +++++
 4 files changed, 68 insertions(+), 1 deletion(-)

-- 
2.17.1

