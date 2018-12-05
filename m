Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52164C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C07320661
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pS7afGsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C07320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbeLELGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:06:21 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:43861 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbeLELGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:06:20 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181205110618euoutp0199a9df5fee179a23952fd688e14d33a4~taxN9Qwla1418914189euoutp01Y
        for <linux-kernel@vger.kernel.org>; Wed,  5 Dec 2018 11:06:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181205110618euoutp0199a9df5fee179a23952fd688e14d33a4~taxN9Qwla1418914189euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544007978;
        bh=5YbI0/sdABJonddxc7tqFUe+sKRZeu5VTL1AAqyvtrU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=pS7afGspQ2yP4ZSa7Or9RyiDeu4hsB6EUzLJjPkzB06A3go33QVbzCCHOMLIhKnQC
         HIbxPR0ERUJS6jn43IxtmV0xOoSpbcFvCpYIev0Kwj2Sua8Xuo0iyZhlW7bBIyifom
         wgXQy4D2zvLRkjTfBIBuuK2tZGOYtquLn025DdEw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181205110617eucas1p2303f3342cebba238c2b79dfe8a41d9c2~taxM1j9Y81015510155eucas1p22;
        Wed,  5 Dec 2018 11:06:17 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 6B.F0.04441.921B70C5; Wed,  5
        Dec 2018 11:06:17 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181205110616eucas1p1e0e17b0c6a96c3b6d77516d4b02de8b1~taxL-5N9q0443104431eucas1p1G;
        Wed,  5 Dec 2018 11:06:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181205110616eusmtrp2a40ea9b4bda1f199da13e76ba2ddd1f7~taxLv-K5m2749027490eusmtrp2Z;
        Wed,  5 Dec 2018 11:06:16 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-70-5c07b129fa47
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6D.62.04128.821B70C5; Wed,  5
        Dec 2018 11:06:16 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181205110615eusmtip10a184f8a03b45dd74c0519875c2aa70c~taxK3AI4W2561625616eusmtip1f;
        Wed,  5 Dec 2018 11:06:15 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com,
        rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, m.szyprowski@samsung.com,
        b.zolnierkie@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v3 0/5] devfreq: handle suspend/resume
Date:   Wed,  5 Dec 2018 12:05:51 +0100
Message-Id: <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSeUiTcRje77uVZp9L6u1AaCA0STsw+0F2QdFXUAT9E2XUqs8VuWn70rLL
        ZaRrWeo61LKMrJzzymVzrnXMVqvMm7KDIgnpskuzKKTya4v+e97neJ/3j5cjVe/ocdxmwzbR
        aNAmq5lQynnnR1uMpo5NnPrTNQJ7r2hwXVEtjRvqvtG4++trGpf6Wmm8v6yWwQ8O6XHeq/ck
        bmu7xOKWrD4WPzVNwCePXSOw49UjGne5Sxg8cNiHcFHbdQJX+56z+EJ3B4Gf7bMx+Pn928M7
        mjtpfOCaj8XZlZ9p3Nf+gpoHgvOqkxaqzlQh4ZSpgxLy8/qRUOZ5SwgO+0FGuHG6ihUun88U
        ft1hBe9HDyHUP8yhhCP1diTYKr+zwoAjcnnYqtCEjWLy5nTROGXOutBNWYN+ItUXvsO9r4Ix
        IVuYBYVwwMeBp2aIsKBQTsXbEFTe2M8Ghq8Iai19TGAYQFBd3EP+i7w94gwK5QiK+ov/R4Y+
        OCkL4jiGjwWXfasciODLEHS6NLKH5O+S4P5iJWTPKD4eOk0LZQ/FR0Hj435Cxkp+CXhy/ESg
        LBKetB4k5SzwBRz4u9qpgLAArnt62AAeBe/89UE8AX43lgbDErSY7UwA74ace66gZxbc8nfQ
        8g0kr4Fa95QAPR9qHGZSpoEPg8cfwmWaHIZWZ2GQVoI5WxVwT4L63PZg0WgorzoRXC7A+0/W
        v0eq+DVQavMy+Sjy5P+uswjZ0RgxTdLrRGmaQdweK2n1UppBF7shRe9Awx/Y/Mvf70KDneub
        EM8h9QglHGMSVbQ2XcrQNyHgSHWE0pbAJqqUG7UZO0VjylpjWrIoNaHxHKUeo9yleLlaxeu0
        28QtopgqGv+pBBcyzoTWKu+Z3S9aIrae61GkfXpabPBb7VmLBydHnlcvilOsCHum682dsTI1
        I/rE75jMvTNnr1mvfr3rVJKCq56eGS5FWc1eXdebRYocvufo0QZvfn68Jmm1ZfKyoaTtN+fG
        O1aUXJw4dmRhQcXUxgvZ3UtbNRU1lXtScpugNWZkelzv8QadmpI2aadFk0ZJ+wf/ncgTfQMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xu7oaG9ljDGZvFbQ4uFXTYuOM9awW
        2zd+Y7W4/uU5q8X8I+dYLZoXr2ezONOda9H/+DWzxfnzG9gtzja9Ybe41SBjMWvKXiaLTY+v
        sVpc3jWHzeJz7xFGixnn9zFZrD1yl91i6fWLTBa3G1ewWdw9dRRoxulLrBate4+wW7St/sBq
        8ebCPRYHCY9tu7exeqyZt4bRY3bDRRaPCf2fGD0W73nJ5LFpVSebx/65a9g9Ni+p9/h3jN3j
        4Ls9TB5brrazePRtWcXosWL1d3aPz5vkAvii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1
        DI3NY62MTJX07WxSUnMyy1KL9O0S9DKavh5nKjgiWLGrcSVbA+MKvi5GTg4JAROJl33b2EBs
        IYGljBKvD+VBxMUkJu3bzg5hC0v8udYFVMMFVPOJUaLp0WvGLkYODjYBPYkdqwpB4iICyxkl
        7v+czQ7iMAs8YJboeL6JFaRIWMBM4lKDK8ggFgFViZ03PjGB2LwCXhJ72o8zQSyQk7h5rpN5
        AiPPAkaGVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIHRt+3Yzy07GLveBR9iFOBgVOLhlZjC
        FiPEmlhWXJl7iFGCg1lJhHeFDXuMEG9KYmVValF+fFFpTmrxIUZToOUTmaVEk/OBiSGvJN7Q
        1NDcwtLQ3Njc2MxCSZz3vEFllJBAemJJanZqakFqEUwfEwenVAOjhUON+EfRDQLs5vOl41vk
        ti3iTH5yh+/Gf7k1ZheVX0xo4dio+uPz22sf/i7YP02c7xbzZYXiC94J80zauluuTXnn035j
        xd2EE1pMfkv139gr39c4/euqZn2Tdq4b2zWBBZ2bajKqE/RPiy0olu8LWGxk9t2+6mP1dH/v
        M1JyMb+F3s1f0N6nxFKckWioxVxUnAgAiOPxsdQCAAA=
X-CMS-MailID: 20181205110616eucas1p1e0e17b0c6a96c3b6d77516d4b02de8b1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181205110616eucas1p1e0e17b0c6a96c3b6d77516d4b02de8b1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181205110616eucas1p1e0e17b0c6a96c3b6d77516d4b02de8b1
References: <CGME20181205110616eucas1p1e0e17b0c6a96c3b6d77516d4b02de8b1@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This v3 patch set aims to address the issue with devfreq devices' frequency
during suspend/resume. It extends suspend/resume by calls to Devfreq
framework. In the devfreq framework there is a small refactoring to avoid
code duplication in changging frequency (patch 1) and there are extensions
for suspending devices. The suspending device has now chance to set proper
state when the system is going for suspend. This phase is the right place
to set needed frequences for the next resume process.

It has been tested on Odroid u3 with Exynos 4412.

The patch set draws on Tobias Jakobi's work posted ~2 years ago, who tried
to solve issue with devfreq device's frequency during suspend/resume.
During the discussion on LKML some corner cases and comments appeared
related to the design. This patch set address them keeping in mind
suggestions from Chanwoo Choi.
Tobias's paches:
https://www.spinics.net/lists/linux-samsung-soc/msg56602.html 

Changes:
v3:
- cleaned commit messages according to Chanwoo's comments
- moved atomic operation to beggining of function in
  devfreq_{suspend|resume}_device()
- changed dev_warn() to dev_err() with also new error message,
  when devfreq_{suspend|resume}() failed
v2:
- refactored patchset and merget patch 1 and 3 as suggested by Chanwoo Choi,
- changed devfreq_{susped|resume}_device functions,
- added doxygen information for new entres in 'struct devfreq',
- devfreq_set_target skipped one argument, now resume_freq is set inside,
- minor changes addresing comments from maintainers regarding the style,

Regards,
Lukasz Luba

Lukasz Luba (5):
  devfreq: refactor set_target frequency function
  devfreq: add support for suspend/resume of a devfreq device
  devfreq: add devfreq_suspend/resume() functions
  drivers: power: suspend: call devfreq suspend/resume
  arm: dts: exynos4: opp-suspend in DMC and leftbus

 arch/arm/boot/dts/exynos4210.dtsi |   2 +
 arch/arm/boot/dts/exynos4412.dtsi |   2 +
 drivers/base/power/main.c         |   3 +
 drivers/devfreq/devfreq.c         | 153 ++++++++++++++++++++++++++++++--------
 include/linux/devfreq.h           |  13 ++++
 5 files changed, 141 insertions(+), 32 deletions(-)

-- 
2.7.4

