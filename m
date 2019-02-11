Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4802CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D112921B26
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IN+cx6K1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389810AbfBKPag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:30:36 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38808 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731586AbfBKPae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:30:34 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190211153032euoutp010c0a90f2878f95ba8d59ebe55518e1d6~CWPVL60y20681406814euoutp01T
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 15:30:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190211153032euoutp010c0a90f2878f95ba8d59ebe55518e1d6~CWPVL60y20681406814euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549899032;
        bh=jE8oBG9YRSK/e1f+BordOYkS6oG8qTLwY6M8vFXrgOE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=IN+cx6K1XFji+vX7de+a8sPRCjJ8veTrJ5i60kLhKqOKi1CEtkEbG/79j5c270eYV
         i8SsLxCwj3A9hNdILk3KQ0cvRO/y4tpzOcergxNchL1JACdkHE3e/lfk5mFVfs9YD6
         0eT38kA6qm6raqHNT7444yoDM2nd/Cj+ajC+930I=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190211153031eucas1p2dfe6ac1a23937e27704dec973193491d~CWPUSnmu81635416354eucas1p2o;
        Mon, 11 Feb 2019 15:30:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 89.D8.04441.715916C5; Mon, 11
        Feb 2019 15:30:31 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190211153030eucas1p19bd9a7eca565ca066ab00dc2243cfb46~CWPTdsuDS2895128951eucas1p1o;
        Mon, 11 Feb 2019 15:30:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190211153030eusmtrp1a95f44951995807517f1915b58fca758~CWPTNymWu0170801708eusmtrp13;
        Mon, 11 Feb 2019 15:30:30 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-a9-5c6195176898
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7A.C1.04128.515916C5; Mon, 11
        Feb 2019 15:30:29 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190211153029eusmtip18e7783937aa59e8106415ac0751a4de5~CWPSap3W22441124411eusmtip1u;
        Mon, 11 Feb 2019 15:30:29 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com,
        joel@joelfernandes.org, chris.diamand@arm.com, mka@chromium.org,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v2 0/2] drivers: devfreq: fix and optimize workqueue
 mechanism
Date:   Mon, 11 Feb 2019 16:30:03 +0100
Message-Id: <1549899005-7760-1-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsWy7djP87riUxNjDK59YLXYOGM9q8W0T5dZ
        LK5/ec5qsaxB1eJs0xt2i1sNMhaXd81hs/jce4TRYu2Ru+wWnzc8ZrS43biCzeLwm3ZWi/eT
        ix14PdbMW8PoMbvhIovHgk2lHgs/fWX1OPhuD5NH35ZVjB6fN8kFsEdx2aSk5mSWpRbp2yVw
        ZSztmsZccIizYsfRK2wNjA/Yuxg5OSQETCQ6u9tZuxi5OIQEVjBKLNv+mwkkISTwhVHiyvJo
        iMRnRol5U7cwwXRMP3CUESKxnFHi4qoLzBAOUMeZd3fZuhg5ONgE9CR2rCoEaRARsJJ40f6K
        HaSGWWA+k8SZrnWsIDXCAgES7VtiQWpYBFQlpjR8YQOxeQU8JV729TBDLJOTuHmuE2y+hEA/
        u8SlkxOhEi4Sz5b/Z4OwhSVeHd8C9Y+MxOnJPSwQdrHE2Y5VUDU1Eu0nd0DVWEscPn4R7AZm
        AU2J9bv0IcKOEu97vjOBhCUE+CRuvBUECTMDmZO2TWeGCPNKdLQJQVRrSGzpuQANEjGJ5Wum
        QQ33kHhxdD0rJAxjJVY3z2GfwCg3C2HXAkbGVYziqaXFuempxYZ5qeV6xYm5xaV56XrJ+bmb
        GIHp5PS/4592MH69lHSIUYCDUYmHtyI/MUaINbGsuDL3EKMEB7OSCG/SFKAQb0piZVVqUX58
        UWlOavEhRmkOFiVx3mqGB9FCAumJJanZqakFqUUwWSYOTqkGRpXXJ5v3ep63zxd1L1wzhb3n
        SXG65vS5Lf2hjGz745423Vg5PfHpsYtxXyfVb7U+PPV0iav3rsydCbYJm7uOinEdKMwV0I/R
        2HXs07fpu9SMuX6yN/UrHNoVbLDoSdSCuvSTdTdSb8bPz+Sq0+hdK7TqxsFJ5tN8j9YwHODz
        2Zj1Q3V9dMFnKyWW4oxEQy3mouJEANSebyMjAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsVy+t/xu7qiUxNjDFb/sLLYOGM9q8W0T5dZ
        LK5/ec5qsaxB1eJs0xt2i1sNMhaXd81hs/jce4TRYu2Ru+wWnzc8ZrS43biCzeLwm3ZWi/eT
        ix14PdbMW8PoMbvhIovHgk2lHgs/fWX1OPhuD5NH35ZVjB6fN8kFsEfp2RTll5akKmTkF5fY
        KkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZSztmsZccIizYsfRK2wNjA/Y
        uxg5OSQETCSmHzjK2MXIxSEksJRRom9jMwtEQkxi0r7tUEXCEn+udbFBFH1ilOg6tZm1i5GD
        g01AT2LHqkKQGhEBG4n3c8+wgNQwC6xmkvh5vJcNJCEs4CdxtHsGE4jNIqAqMaXhC1icV8BT
        4mVfDzPEAjmJm+c6mScw8ixgZFjFKJJaWpybnltspFecmFtcmpeul5yfu4kRGMzbjv3csoOx
        613wIUYBDkYlHl6F3MQYIdbEsuLK3EOMEhzMSiK8SVOAQrwpiZVVqUX58UWlOanFhxhNgZZP
        ZJYSTc4HRlpeSbyhqaG5haWhubG5sZmFkjjveYPKKCGB9MSS1OzU1ILUIpg+Jg5OqQbG6Qpl
        chrzNmloz8y/Kzn1a9ynTbI5XxL+v9n72vPMjP7Cg3v3TfzyeJHhyseNJ7tl1i9na6v64/6U
        6f2E42qPdU/V3Vk6b8YZQVPDI5MXbfQvCec9b7RNbdt3m2OX/BXn5LKEXjrZI7G41mJXbM6c
        xeKiMu9nXRYwXPRmzr1yw7JPqVdefUw61K7EUpyRaKjFXFScCAAh4ck9fAIAAA==
X-CMS-MailID: 20190211153030eucas1p19bd9a7eca565ca066ab00dc2243cfb46
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190211153030eucas1p19bd9a7eca565ca066ab00dc2243cfb46
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190211153030eucas1p19bd9a7eca565ca066ab00dc2243cfb46
References: <CGME20190211153030eucas1p19bd9a7eca565ca066ab00dc2243cfb46@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set changes workqueue related features in devfreq framework.
First patch switches to delayed work instead of deferred.
The second switches to regular system work and deletes custom 'devfreq'.

Using deferred work in this context might harm the system performance.
When the CPU enters idle, deferred work is not fired. The devfreq device's
utilization does not have to be connected with a particular CPU.
The drivers for GPUs, Network on Chip, cache L3 rely on devfreq governor.
They all are missing opportunity to check the HW state and react when
the deferred work is not fired.
A corner test case, when Dynamic Memory Controller is utilized by CPUs running
on full speed, might show x5 worse performance if the crucial CPU is in idle.

Changes:
v2:
- single patch split into two
- added cover letter

link for the previous version and discussion:
https://marc.info/?l=linux-pm&m=154904631226997&w=2

Regards,
Lukasz Luba

Lukasz Luba (2):
  drivers: devfreq: change devfreq workqueue mechanism
  drivers: devfreq: change deferred work into delayed

 drivers/devfreq/devfreq.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

-- 
2.7.4

