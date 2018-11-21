Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE7EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01EC4214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="q8pKAgA8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01EC4214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732644AbeKVEhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:37:24 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38018 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732721AbeKVEhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:37:23 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181121180159euoutp01118b4eb26679ddad1be593c666f76a9d~pNaJvZupm0920709207euoutp013
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 18:01:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181121180159euoutp01118b4eb26679ddad1be593c666f76a9d~pNaJvZupm0920709207euoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542823319;
        bh=a/CowX5vKU13IthQezO6Fl9mgJO9SUIKP68QR1ULUKM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=q8pKAgA8Am6g73r1WOi7d5vOmjFDEHXE0BaLLZozofa5eKKkMmRsuZ06cjnC/q7Q5
         42uvjHEM+6K04GCTXuZnthh+b5N0RqaGbVjLuxktjGS+5sBe522F8yQ6GKimgFKZBx
         BJHQfXxPGpCXXboDnXX1qM6XKgkWekinR2H+yCrQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181121180157eucas1p155f740c6eda22d995a1dbbcab378a27d~pNaIoijWS3115831158eucas1p1L;
        Wed, 21 Nov 2018 18:01:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 94.D7.04441.59D95FB5; Wed, 21
        Nov 2018 18:01:57 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181121180156eucas1p225af7f4341a039264ff26f2a9ad9bb12~pNaHqXPXI0124201242eucas1p2y;
        Wed, 21 Nov 2018 18:01:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181121180156eusmtrp27affcc6b055773f999aea646a56d8e88~pNaHany5Z0880108801eusmtrp2G;
        Wed, 21 Nov 2018 18:01:56 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-8b-5bf59d95fc0e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A9.48.04284.49D95FB5; Wed, 21
        Nov 2018 18:01:56 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181121180155eusmtip2a471b790e20317cc3098d4630127bcb0~pNaGjpzSA1643316433eusmtip2N;
        Wed, 21 Nov 2018 18:01:55 +0000 (GMT)
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
Subject: [PATCH 0/6] devfreq: handle suspend/resume
Date:   Wed, 21 Nov 2018 19:01:35 +0100
Message-Id: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSeUiTYRz23bfvcDX5WodvZiajUqPshpeMSqj4OqAgCnJ2rPpQ01nt0y7D
        VpFX6soOhx2WVto2z6aZpaVOrVkei1qWZrAgygOPzQqktfmt+u/5Pcfv+b3wUpikF/ehomLj
        WGWsPEZKiISVTb9aF1y9aZctUj+Zi+oqglCZpgRHj8pGcWSxfcVRrrEVR+fySwj06oICqa29
        GGprKyXR67N9JPqg8kU5V2oEqNz6Dkdvqm8QaCTDCJCmrVaAiozdJLpn6RCgj2cKCdRtanTu
        aDHj6HyNkURJukEc9bV/Eq6BTOWTSpzR39ID5rqqQ8hcVA8DJv/pNwFTrk0lmGc39STz8O5p
        5ncTydQNPBUwhrfJQibToAVMoe4HyYyU+231ChOtPMDGRB1llQtX7RVF1ibrycM9E45fNptw
        FXjumQY8KUgvg13DL/A0IKIkdCGAnaV3MH6wAWhocgj5YQRAe54R/xsZTPpM8EIBgLl1nfi/
        yE+dwalQFEEHwyrtEVdgCp0PoLkqyOXB6BcYrB7KEriEyfRSOJZRAVxYSM+B979bxxvE9EZo
        +ml2t/nBztbU8ZsgfYmCmekqjBfWwlHDEMHjyfB7s4HksS90PM4V8JiDr1O0bs8pmPyyyu0J
        gQ3NHbjrUIwOgiXVC3k6FHbUfsBcNKS94Pv+SS4ac8Ksymw3LYYpSRLeHQgN6e3uommwQH/N
        vZyBmr5P46+S0LvgmK0Xvwj8cv533QZAC7zZeE4RwXKLY9ljwZxcwcXHRgTvP6QoB84v2PK7
        ebgK2M376gFNAelEceBOu0yCy49yJxT1AFKYdIo4JcxJiQ/IT5xklYf2KONjWK4ezKCEUm9x
        gsdnmYSOkMex0Sx7mFX+VQWUp48KVJyM6hpzqLd1iVf0ZIcNXmqcvt5nNGRD2lC4rw31+Ntk
        pebwdRn2gIR0q2pTrYfmS8uWgwGzUj4mbH8MGo/PnhlanFtiIiL9c5bM985aPbVYEtGvC3cU
        DETvyCMyGzSWIlGZOu+BV/T5cP/Ebe1BA8vDUle9Pde/e9hXvFlnSbRIhVykfPE8TMnJ/wDf
        dBp3fgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xe7pT5n6NNniwWcXi4FZNi40z1rNa
        bN/4jdXi+pfnrBbzj5xjtWhevJ7N4kx3rkX/49fMFufPb2C3ONv0ht3iVoOMxawpe5ksNj2+
        xmpxedccNovPvUcYLWac38dksfbIXXaLpdcvMlncblzBZnH31FGgGacvsVq07j3CbtG2+gOr
        xZsL91gcJDy27d7G6rFm3hpGj9kNF1k8JvR/YvRYvOclk8emVZ1sHvvnrmH32Lyk3uPfMXaP
        g+/2MHlsudrO4tG3ZRWjx4rV39k9Pm+SC+CL0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHU
        MzQ2j7UyMlXSt7NJSc3JLEst0rdL0MvY176GveA+d8XkS6dYGxgPcHYxcnJICJhIfGh7wNbF
        yMUhJLCUUeJC8wU2iISYxKR929khbGGJP9e6wOJCAp8YJbqv+nQxcnCwCehJ7FhVCNIrIrCc
        UeL+z9nsIA6zwANmiY7nm1hBGoQFjCX+9G5lBLFZBFQllr16DBbnFfCSOPXjEivEAjmJm+c6
        mScw8ixgZFjFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGH/bjv3cvIPx0sbgQ4wCHIxKPLwa
        kV+jhVgTy4orcw8xSnAwK4nwdkQBhXhTEiurUovy44tKc1KLDzGaAi2fyCwlmpwPTA15JfGG
        pobmFpaG5sbmxmYWSuK85w0qo4QE0hNLUrNTUwtSi2D6mDg4pRoYJXQaz1ubBq/mUn3OY7sx
        gKunxHWR4rdHorGBV6Oj3/7nMD55fKle6FyPxh/1du0vv85Wrfhf1Wl9xfKA/0Flh+DSs17L
        lJevyzaJc79ePnWZ7NzQx+unJ/2XVFY7y7vgnK/Oy5ZdN/vufOP3svnmadPBv0xg3uOX/iGb
        E3dJVpa091UcFopQYinOSDTUYi4qTgQA8pBaYtUCAAA=
X-CMS-MailID: 20181121180156eucas1p225af7f4341a039264ff26f2a9ad9bb12
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181121180156eucas1p225af7f4341a039264ff26f2a9ad9bb12
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181121180156eucas1p225af7f4341a039264ff26f2a9ad9bb12
References: <CGME20181121180156eucas1p225af7f4341a039264ff26f2a9ad9bb12@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch set aims to address the issue with devfreq devices' frequency
during suspend/resume. It extends suspend/resume by calls to Devfreq
framework. In the devfreq framework there is a small refactoring to avoid
code duplication in changging frequency (patch 2) and there are extensions
for suspending devices.

It has been tested on Odroid u3 with Exynos 4412.

The patch set draws on Tobias Jakobi's work posted ~2 years ago, who tried
to solve issue with devfreq device's frequency during suspend/resume.
During the discussion on LKML some corner cases and comments appeared
related to the design. This patch set address them keeping in mind
suggestions from Chanwoo Choi.
Tobias's paches:
https://www.spinics.net/lists/linux-samsung-soc/msg56602.html 

Regards,
Lukasz Luba

Lukasz Luba (6):
  devfreq: add basic fileds supporting suspend functionality
  devfreq: refactor set_target frequency function
  devfreq: add support for suspend/resume of a devfreq device
  devfreq: add devfreq_suspend/resume() functions
  drivers: power: suspend: call devfreq suspend/resume
  arm: dts: exynos4: set opp-suspend for DMC and leftbus

 arch/arm/boot/dts/exynos4210.dtsi |   2 +
 arch/arm/boot/dts/exynos4412.dtsi |   2 +
 drivers/base/power/main.c         |   3 +
 drivers/devfreq/devfreq.c         | 159 ++++++++++++++++++++++++++++++--------
 include/linux/devfreq.h           |  11 +++
 5 files changed, 146 insertions(+), 31 deletions(-)

-- 
2.7.4

