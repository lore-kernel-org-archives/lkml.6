Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB66C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F9D20867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UlLxNXbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F9D20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbeIDNDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 09:03:10 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36698 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbeIDNDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 09:03:10 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180904083902euoutp02f1edcb52144193e334e7f00959fcd413~RJaYLS3-m3198031980euoutp02j
        for <linux-kernel@vger.kernel.org>; Tue,  4 Sep 2018 08:39:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180904083902euoutp02f1edcb52144193e334e7f00959fcd413~RJaYLS3-m3198031980euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1536050343;
        bh=oXogvLbhtC+qyHZtoJUbN2r0RPsRvM2WCUFdA7HHbdM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=UlLxNXbALYxrUCpMBiG9Bc4GSUmqCD953BQi3yZ/SWy+p4Bq3UEHdGHFQ6n0E2qXH
         kjeL7GF+uPDpCn/63xjDQCYI77J0sQwBeHCwdwzEycWbNFuK6sTWM4dbTvBvosvqTa
         U+jhhjX7noyw4AKDPcLheEaXAD4Rk5GIC/TrBui0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180904083902eucas1p2bbd058f51aeab776a7201bfcb251ac53~RJaXpF3PD3096730967eucas1p2b;
        Tue,  4 Sep 2018 08:39:02 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A9.50.04441.6A44E8B5; Tue,  4
        Sep 2018 09:39:02 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180904083901eucas1p17c35261c6dcfd51381dafb3b9b0dfaf7~RJaWxxuug2416824168eucas1p10;
        Tue,  4 Sep 2018 08:39:01 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180904083901eusmtrp272c62190cb3b19cce8b56bea9df83717~RJaWfZ3da0256302563eusmtrp2n;
        Tue,  4 Sep 2018 08:39:01 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-45-5b8e44a6776f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 19.42.04128.5A44E8B5; Tue,  4
        Sep 2018 09:39:01 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180904083900eusmtip2209fc164f5882ee33568a3ef18c757f9~RJaWLwLAP0129101291eusmtip27;
        Tue,  4 Sep 2018 08:39:00 +0000 (GMT)
Subject: Re: [PATCH 1/2] regulator: Fix useless O^2 complexity in
 suspend/resume
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Tue, 4 Sep 2018 10:39:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180903150911.GO10302@sirena.org.uk>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djP87rLXPqiDea0s1lsnLGe1WLqwyds
        Ft+udDBZXN41h81ixvl9TBaTFx1kdWDz2DnrLrvHplWdbB53ru1h8+jbsorR4/MmuQDWKC6b
        lNSczLLUIn27BK6MCw87mQumsFe8fnyApYHxGWsXIyeHhICJxOy9V9m6GLk4hARWMEp8/drP
        BpIQEvjCKHHunxFE4jOjxMHZj+A6uqa9YYJILGeUODNjATOE855R4tnfXUwgVcICQRL9C/vZ
        QWwRAWWJq9/3soAUMQucYZRY9HctC0iCTcBQouttF9g+FgEViS8zjwDZHByiAjESv3dZg4R5
        BQQlTs58AlbOKWAssfjMETCbWUBeYvvbOcwQtrjErSfzwS6SEFjGLvFkwjUWiOYyib5XHcwg
        MyUEXCQunVKA+EBY4tXxLewQtozE/50wvc2MEu0zZrFDOD2MElvn7GCDqLKWOHz8IivIIGYB
        TYn1u/Qhwo4S11a9ZIOYzydx460gxD18EpO2TYdayyvR0SYEUa0mMev4Ori1By9cYp7AqDQL
        yZezkHw2C8lnsxD2LmBkWcUonlpanJueWmyYl1quV5yYW1yal66XnJ+7iRGYeE7/O/5pB+PX
        S0mHGAU4GJV4eAMMeqOFWBPLiitzDzFKcDArifD68fdFC/GmJFZWpRblxxeV5qQWH2KU5mBR
        Eufl00qLFhJITyxJzU5NLUgtgskycXBKNTCyLDx7tOllxXJWvg/W4Y1ayyYy/wm5zuwmIbhJ
        4ZxnupzSrmSP9Jfex7PdD1lLPwpe90z+ydy98zVmVt47Htb+mHX7HoeOtRPab5YdMnm9jWvD
        xpXO02bPCNjtVXNYPFvxYnZ34X7ttL+FguxvNUM71v0ICnZ4LOcR8pB/C2+dKnvqohWRV58r
        sRRnJBpqMRcVJwIAChoveTgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xe7pLXfqiDV53cVhsnLGe1WLqwyds
        Ft+udDBZXN41h81ixvl9TBaTFx1kdWDz2DnrLrvHplWdbB53ru1h8+jbsorR4/MmuQDWKD2b
        ovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MCw87mQum
        sFe8fnyApYHxGWsXIyeHhICJRNe0N0xdjFwcQgJLGSV+rzvBDpGQkTg5rQGqSFjiz7UuNoii
        t4wSO07eZQFJCAsESfQv7AdrEBFQlrj6fS9YnFngHKPEunu6EA3vGCUaPk9lBkmwCRhKdL0F
        mcTJwStgJ/H25D6wDSwCKhJfZh4Bi4sKxEgcndwCVSMocXLmE7ChnALGEovPHIFaYCYxb/ND
        ZghbXmL72zlQtrjErSfzmSYwCs1C0j4LScssJC2zkLQsYGRZxSiSWlqcm55bbKRXnJhbXJqX
        rpecn7uJERht24793LKDsetd8CFGAQ5GJR7eH7q90UKsiWXFlbmHGCU4mJVEeP34+6KFeFMS
        K6tSi/Lji0pzUosPMZoCPTeRWUo0OR+YCPJK4g1NDc0tLA3Njc2NzSyUxHnPG1RGCQmkJ5ak
        ZqemFqQWwfQxcXBKNTDqrWu7ffpjCPcrZf7re9dN1lj2evGrg9O/Sq5iY3hR5lD9W8x6Tv7F
        I5tEFXlcsz+5ZLzf37NH9n27zr8Vj/c1nf8sc0zzkIRQ/PwTn7LMV/xzMTxp9ebromWlrLVH
        Y1+sYm/fcyWD8/PiRR2JjuYs+92j97IffvboxfZ5LObff13cGKy4+fEOSyWW4oxEQy3mouJE
        ABhErd/MAgAA
Message-Id: <20180904083901eucas1p17c35261c6dcfd51381dafb3b9b0dfaf7~RJaWxxuug2416824168eucas1p10@eucas1p1.samsung.com>
X-CMS-MailID: 20180904083901eucas1p17c35261c6dcfd51381dafb3b9b0dfaf7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180903144947eucas1p26391f4de6bd46d18cf51f075e6f22e2a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180903144947eucas1p26391f4de6bd46d18cf51f075e6f22e2a
References: <20180903144937.16507-1-m.szyprowski@samsung.com>
        <CGME20180903144947eucas1p26391f4de6bd46d18cf51f075e6f22e2a@eucas1p2.samsung.com>
        <20180903144937.16507-2-m.szyprowski@samsung.com>
        <20180903150911.GO10302@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 2018-09-03 17:09, Mark Brown wrote:
> On Mon, Sep 03, 2018 at 04:49:36PM +0200, Marek Szyprowski wrote:
>> regulator_pm_ops with regulator_suspend and regulator_resume functions are
>> assigned to every regulator device registered in the system, so there is no
>> need to iterate over all again in them. Replace class_for_each_device()
>> construction with direct operation on the rdev embedded in the given
>> regulator device. This saves a lots of useless operations in suspend and
>> resume paths.
> This would've been better as the second patch since it's an optimization
> and not so urgent for stable.

Frankly, the slow down caused by this O^2 in case of 40 regulators in the
system (not that unusual in nowadays mobiles) is noticeable and quite
annoying. IMHO this is still a good candidate for stable.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

