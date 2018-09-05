Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D23EC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C088120857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PR1O1agz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C088120857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeIETIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:08:48 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59125 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeIETIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:08:48 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180905143816euoutp01b2d4f9602ac072e8bf9c3df6b0459011~Rh9Tz9P_V2823328233euoutp01c;
        Wed,  5 Sep 2018 14:38:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180905143816euoutp01b2d4f9602ac072e8bf9c3df6b0459011~Rh9Tz9P_V2823328233euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1536158296;
        bh=2n0M+WdZDdg/Ko7hUoVeLLWsTz2nL5J4ThblJJwcFXY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=PR1O1agzP0mJlDgwF8fymu6bHRJGQaKMrRIuBVYxV307/Zgzs7hBeeFsJ/U2RSJva
         mWJllWCWqgnBaTMg9C88br4ga0tiGRFx2HFetf8/o84M3MAId6Q+vPGrKU3f1e5s3Q
         BQAlmmKUxcw7X1YpXfFux/MCNc2riibT9vFuZOmo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180905143816eucas1p11e4d4b3444392fb5f2911d90bba17194~Rh9TQQUt83236732367eucas1p1_;
        Wed,  5 Sep 2018 14:38:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F0.19.04294.75AEF8B5; Wed,  5
        Sep 2018 15:38:15 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180905143815eucas1p29cb4247cfef8180433d9b4627f5ff883~Rh9SlETO10837308373eucas1p2X;
        Wed,  5 Sep 2018 14:38:15 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-89-5b8fea572b91
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4E.A5.04284.75AEF8B5; Wed,  5
        Sep 2018 15:38:15 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PEL00JMB7BOZU30@eusync1.samsung.com>;
        Wed, 05 Sep 2018 15:38:15 +0100 (BST)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2] mfd: max8997: Disable interrupt handling for
 suspend/resume cycle
Date:   Wed, 05 Sep 2018 16:36:06 +0200
Message-id: <20180905143606.5916-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZduznOd3wV/3RBpc3aVtsnLGe1eL+16OM
        Fpd3zWGzmHF+H5PF2iN32S1uN65gc2DzuHNtD5tH35ZVjB6fN8kFMEdx2aSk5mSWpRbp2yVw
        ZbRNPs1SMJGzovnLL8YGxnPsXYycHBICJhKzLzQzdTFycQgJrGCUODf/DjuE85lR4tW9driq
        Oc0/mUFsIYFljBI/VyRAFDUwSWz8vQOsiE3AUKLrbRcbiC0i4Cxx+8M3FpAiZoEtjBLTrz5i
        AUkIC4RL7Dl7kwnEZhFQlWi+eBEszitgI/H42gw2iG3yEqs3HGCGsK+ySuxt44awXSQ+bL7D
        CmELS7w6vgXqOhmJzo6DYD9ICDQzSrTPmMUO4fQwSmydswNqqrXE4eMXwbqZBfgkJm2bDrSB
        AyjOK9HRJgRR4iHRt6GZHeLNWImfL38wTWCUWMDIsIpRPLW0ODc9tdgoL7Vcrzgxt7g0L10v
        OT93EyMwlk7/O/5lB+OuP0mHGAU4GJV4eBec648WYk0sK67MPcQowcGsJMJrdBIoxJuSWFmV
        WpQfX1Sak1p8iFGag0VJnJdPKy1aSCA9sSQ1OzW1ILUIJsvEwSnVwNieHMB/+5xuga0nl9O1
        OQfLNK7+ldnEHVZ/X2/z98PtBqsLcy1LTu574ShrlF49OUk15PNT32+btvu+OnSCpeDJsh2V
        D4+GiBvffxaruOTov/Mv42rlXJf33NW9fytfL7S35233sRuye36d79+14HDwv5sONY8mGZp0
        PfiyoaLin1vNp3+G0/WUWIozEg21mIuKEwE7/iedoQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAJMWRmVeSWpSXmKPExsVy+t/xy7rhr/qjDa5f5bPYOGM9q8X9r0cZ
        LS7vmsNmMeP8PiaLtUfuslvcblzB5sDmcefaHjaPvi2rGD0+b5ILYI7isklJzcksSy3St0vg
        ymibfJqlYCJnRfOXX4wNjOfYuxg5OSQETCTmNP9kBrGFBJYwSnTMKepi5AKym5gk5nyYxgaS
        YBMwlOh62wVmiwg4S9z+8I0FpIhZYAujxMsd+1lAEsIC4RIHdr5hBbFZBFQlmi9eBIvzCthI
        PL42gw1im7zE6g0HmCcwci1gZFjFKJJaWpybnltsqFecmFtcmpeul5yfu4kR6O9tx35u3sF4
        aWPwIUYBDkYlHt4F5/qjhVgTy4orcw8xSnAwK4nwGp0ECvGmJFZWpRblxxeV5qQWH2KU5mBR
        Euc9b1AZJSSQnliSmp2aWpBaBJNl4uCUamDsnlckofSBV3OT8tPz2k/SzhT2/jhvVpJ2++3W
        rb2mGT5rp6ya4LXQ6PW3rwFx8fOtWnQ+PLxtqKiwK3DCoR/t0xusrvse8OCXqub2rpNjXfZ+
        f8T8W89uigp5Xs1aaSy28Pp7P5/5Nfs33w17sCXx5DTjuioT5cWXz3ef1OMr7lFQ5PvEvGa2
        EktxRqKhFnNRcSIA99m1svMBAAA=
X-CMS-MailID: 20180905143815eucas1p29cb4247cfef8180433d9b4627f5ff883
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180905143815eucas1p29cb4247cfef8180433d9b4627f5ff883
References: <CGME20180905143815eucas1p29cb4247cfef8180433d9b4627f5ff883@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable IRQs during suspend/resume cycle to ensure handling of wakeup
interrupts (i.e. RTC wake alarm) after max8997_resume(). This way it can
be properly handled when I2C bus is finally available. This pattern is
also used in other MAX PMIC MFD drivers.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
changelog:
v2:
- reordered the sequence of operation as suggested by Krzysztof Kozlowski
---
 drivers/mfd/max8997.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/max8997.c b/drivers/mfd/max8997.c
index 3f554c447521..b17eff50ad52 100644
--- a/drivers/mfd/max8997.c
+++ b/drivers/mfd/max8997.c
@@ -468,6 +468,7 @@ static int max8997_suspend(struct device *dev)
 	struct i2c_client *i2c = to_i2c_client(dev);
 	struct max8997_dev *max8997 = i2c_get_clientdata(i2c);
 
+	disable_irq(max8997->irq);
 	if (device_may_wakeup(dev))
 		irq_set_irq_wake(max8997->irq, 1);
 	return 0;
@@ -480,6 +481,7 @@ static int max8997_resume(struct device *dev)
 
 	if (device_may_wakeup(dev))
 		irq_set_irq_wake(max8997->irq, 0);
+	enable_irq(max8997->irq);
 	return max8997_irq_resume(max8997);
 }
 
-- 
2.17.1

