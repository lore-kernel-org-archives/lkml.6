Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC782C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BBBA20882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Gt46fp4C";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="cNGU8yxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbfA3LGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 06:06:04 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:51720 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727043AbfA3LGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 06:06:03 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0UAwpXD016598;
        Wed, 30 Jan 2019 03:05:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=qNoHtzm03ly6sFzocaZlymmGyZHkyd+ZByPj2mHIYqc=;
 b=Gt46fp4CPZ2y2xbBLd/kthcWrcszZ94d63clfU4NvzDMjLhyEqhmxAA2trFEQGGJa/yi
 YO+22L5LfkpNnrui02/SmHVLFci6iAtBtUfEc4GLWK3+gRfUkPmur0l8gGOXtEUv60D9
 1duExunx1rm4B2J8u0E7ue/KZPgsLv9AqZdmIVnt003z5wod1m1RHbsgLfraAeuga6RN
 7eIsr68KfvLK9vLFSWDoF/zax0TZwIQt85RNmpnp+/CyJhYFUArUozV2B/Wwk8RlqqyO
 3vZFI1vRW+WlpkXfMAYlJqyyeXUKu/R5etPsCX3ykRizonQFeHpaVPmCIVyQJpBsmri7 cw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=dkos@cadence.com
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2053.outbound.protection.outlook.com [104.47.32.53])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2qa8178dat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jan 2019 03:05:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNoHtzm03ly6sFzocaZlymmGyZHkyd+ZByPj2mHIYqc=;
 b=cNGU8yxaxRKaKvciOiFzzi4KMy6DrtMIOiU3MCfY4ZcwD2KtAfjS5E/aPqNXn7cw1ZidLPW5Id2J02Ux0CQ/41MgiGMHxzSGFz3QKO4f+CQ79Tf0jbg2COVGGUYxMbGcG9lH2R24vvcZI+r48Vh9AYf9p+vehAm8RvgBOTeoY1M=
Received: from BYAPR07CA0026.namprd07.prod.outlook.com (2603:10b6:a02:bc::39)
 by DM5PR07MB3098.namprd07.prod.outlook.com (2603:10b6:3:de::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Wed, 30 Jan 2019 11:04:57 +0000
Received: from CO1NAM05FT016.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::209) by BYAPR07CA0026.outlook.office365.com
 (2603:10b6:a02:bc::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1558.17 via Frontend
 Transport; Wed, 30 Jan 2019 11:04:57 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 CO1NAM05FT016.mail.protection.outlook.com (10.152.96.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.2 via Frontend Transport; Wed, 30 Jan 2019 11:04:56 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x0UB4pQI009156
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 30 Jan 2019 06:04:53 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 30 Jan 2019 12:04:50 +0100
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 30 Jan 2019 12:04:50 +0100
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id x0UB4o5S018550;
        Wed, 30 Jan 2019 11:04:50 GMT
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id x0UB4o9G018549;
        Wed, 30 Jan 2019 11:04:50 GMT
From:   Damian Kos <dkos@cadence.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Andrzej Hajda" <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <dkos@cadence.com>, <rafalc@cadence.com>, <piotrs@cadence.com>,
        <quentin.schulz@bootlin.com>, <jbergsagel@ti.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v7 4/4] drm: bridge: add support for Cadence MHDP DPI/DP bridge
Date:   Wed, 30 Jan 2019 11:03:21 +0000
Message-ID: <1548846209-16406-5-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1548846209-16406-1-git-send-email-dkos@cadence.com>
References: <1548846209-16406-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(39860400002)(2980300002)(3190300001)(36092001)(199004)(189003)(186003)(486006)(26005)(86362001)(2201001)(76176011)(51416003)(48376002)(426003)(30864003)(316002)(50466002)(336012)(8936002)(7416002)(50226002)(6666004)(105596002)(356004)(97736004)(106466001)(42186006)(446003)(11346002)(16586007)(476003)(305945005)(54906003)(126002)(478600001)(36756003)(110136005)(2616005)(26826003)(4326008)(68736007)(47776003)(53946003)(14444005)(5024004)(81166006)(81156014)(87636003)(69596002)(8676002)(2906002)(53936002)(921003)(1121003)(2101003)(83996005)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3098;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT016;1:H1FvIb4QUa4rPAYaHe1H/lErFJFCzwJLmkCAUC1fKVu3g1q4q+QHSTnNhuuG1gLV0wx31tfK33zP9v3O+EWRBlzlbds3tiyKBOYcvfIVird/MhLoJdxngGu9KDeKBwg0Ap3iZIuc2s5saqMBCBCdpbWx1F1Wlbzx3LxaGswuTho=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72563e59-24b3-423b-da3b-08d686a2c501
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060);SRVR:DM5PR07MB3098;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3098;3:TqRpRDL8rwj/6L/IAb3nxESUrl7Oykpysb8Z+1MvOhJxj2rvkEjgfrC315r6RvRVIow9wxzD4bkHMWxkJg6uAA4W1a3nm1OQGJsjw/FUJwnyGcGe3h46tbZmjM+megBPakeK9bg+m4XgNUnDHxzouODjxqq+69sEIAzkuFdEptO9JJHuaMmELFEAHZ70MySNONN6fz/6zojYCZJHsc53fX0CIvNrbbVu4XBfQVZTWAXvt+HS/cQPSIsKQKpb9fgEdaAJXmTf2BPkqAC4CEFSSEXn+TQemFg3ukRFuKttM4Ld5ma/KcOtH4TKFHJyN4bWxfCdpYkDnuZovEUh/rMhykPLfMwXlzT7XG/ZIO6URs2s1kEzPSDhZkLQ0t/jb9O2;25:MAsbVnuS11drEDUve4dZyNaB5ql63Dz/2p1KtFPwQ0FcBaPzr8W28pm3b+uUUts2mYlpmJIBMYAap8VHzz282ZrBOktj3rZpS7ZYUf4T8gPS40Z977Dtlt9J2ytqswwtdbfJnddeThvfTyNETDOYzhefWzfcg5yr1HC6Z8XtrIOSDP6fXn2SI4CEmXTX9WESgv5gKXAX1ObkinLfdHuC0iULU2SBCrE1q/61bwJ08JFRMItSRCdhFgFrBQTzdoa4ObXHpw3N9bMx5msVBlpCcz832bz+SY+Yifm6I3ui7FkAxhsaVD0ZeRt5lbO/xACVGm/79nKLEIroblnyvyiv8Q==
X-MS-TrafficTypeDiagnostic: DM5PR07MB3098:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3098;31:7ThqJghL33/xowjDLp6eBZVz57uS2AyRmbIx87F7nGupH7RxUSPy2ZDMYAREvcVoUNA0hx/jebmQBX7Kq+tQziOOKNJFFO9X1OVavIYIndJhj3iDR2iIUAa+gH2bT0YLwy6ossWx8E1mems6t2tAISPktzZkBHATZgiLu0kh7Y+SQB+YhB3Yv6c9PGUwUfzr5rl9mc5OzOkt9gT9Gypmy5n9ot+YzUcJLN4CRLmGeAc=;20:OpWNYAcTmzZaxfjqGOTclA08Vki8FtaUz9LW4eL4y3z5c8f3/CuHH0yTWG9Gkrbnr+RQsizFmup7MXF/j5a1zRntlBbJrfIOBz64oOZMPqFkFe5dtJqrvaE6w3rZpfnBxJU/xdq/eBemVRaF/wlc1PeBPORVggZT0Niopxs9z2l0yh2gmVI6+StxhhRs4pz2Mlb8PufMOHc9SAMsTzmpU3A9oIBLTvBCTRpHQYsFKJ5ypIvSDQDvkKwbib1p+cdbFCvQIiQ0Q7T9BJZx4CTWbT16nMxAYlpKFNNss/ZvX38oRjhPdXKOmkr3T4XWY8ilCyxJNtVxUcn2cNxhwdNADG6OAKW8u32eymVg7UgAVJEqF+e7uKuJrYUuvJyIMBFiGUYZ5uWyOaXBfk++P6sO9WEfGejF12/as27jq/X28jPOARLUGxurOo1HRmD99yepMjQZIC7fWGvaEpm+l0MnxGQ5q19qR0N2QC09KhPfe0iuKfJu2k0r5fAH8WzPk1jV
X-Microsoft-Antispam-PRVS: <DM5PR07MB30983010A0505A33B596C7EECD900@DM5PR07MB3098.namprd07.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3098;4:cJ2t7nJiNxmS+KvFHbttTwZBJiu5C9rwbLSdcK5ldtoGiPJZn4bSqrvq3JKBwmP/56C7OoZuKKWh+YRyQQdeUAdEws4EnYM4YFZ4pEcCuj/TOeU1DR2T66saGoDwDsF7vMWtjO2VkttSxru/+AklaTvgdUGAFrfHOw7LTfNVLH7sTH3AMxc1rn2BRF1PfHBZoWVyF1oq619jGSQ+wkNP5ub72aXIhRhrNeRnAkLMqoQTre8cBbmlUv0dk/8oDaLy88g4AGWjD+VW5+hJOYiHORAt4B03gqNokTz1wJRZA5E=
X-Forefront-PRVS: 0933E9FD8D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3098;23:bxw5dftcI48TvCXG12RNH1dYGsZ5rgJ/KuQlfcLtP?=
 =?us-ascii?Q?Oxrf9En1croVUhX1SuBEN3dDFs22NEnYo48MKrN8GrA1b0/2wxE7YKjm2kUW?=
 =?us-ascii?Q?gwegbdB8zfMeyYoGo26GlLzVCxDaLOYb42BLvKh1N+ZeLr+mqILl7fbcL53D?=
 =?us-ascii?Q?6B8Xsj4tkGuu8vDm0SQP1h51pQH3M2DtFUFQsEPOaNDuWI5hKIHfaIlSLSKV?=
 =?us-ascii?Q?kl1NZ1qfsUf0WUYxNI1k2dUogS7SjpIQyigdtWiXVf5Sn5R2U/Zkdae5dfb7?=
 =?us-ascii?Q?HbYLdsciMy9NzuNOqqtP2+mnXHigGxCBF1uId2U/SaGEF8PL2SzsCi2Sr90p?=
 =?us-ascii?Q?17I3BlrOTBmmwbR/CQ9xRN8k8J1GNdKa1pt9+WVyPHA5EkRS6VN7JEr60wz5?=
 =?us-ascii?Q?LM5ctQnJwOfU4PD0fD200x5PMA3qvraIVpKa+kr6Ex3joVvcWbyECXaBBPdv?=
 =?us-ascii?Q?c0P4iRFQecAY5qAeFDJxHE4H0b/z+JIEF9cqA1mKCW4AFPJ6vsFgHRIV0+p2?=
 =?us-ascii?Q?iJf96ulLfJgxZOG28w2JK0B9nB3SJ8AIp3iVtDW5YZF7tVLU7l/ksRFXj9zU?=
 =?us-ascii?Q?BleGTBZcfySWtqUo/7VYBS+VnpQi7v1cyeB6V89G3smA5/wxKViBmuxU/Pzx?=
 =?us-ascii?Q?jROXRbfIHR0pDcW2lsfE/xZbJ5SIVtbEcCk9XdR/9qOMqxDROBF+zzjy90R1?=
 =?us-ascii?Q?1kSQgi/doNQCwqnFACvkwsIuBYHN880n8JEZi1h5Rhm2XJsx4Xtw3z56Qmqb?=
 =?us-ascii?Q?qm0f2769aEZR4xZUfr5onWB1AMh9mygPm1nIqMBMAYWy1F09UNs9ST9wV875?=
 =?us-ascii?Q?Etkwzobr2G+bhbPGs0sT8q9y6ZAYYfG0jqXDeqGFZhRnNNHSnmnfpR9gvsKi?=
 =?us-ascii?Q?5Vpfg5nDznxFNGtAx4sTDeVaXHgbCKtHM5NZkdyAI3p7DHLmMa1w672fU+C/?=
 =?us-ascii?Q?FM96OSi3ytguyrzoGx5LgzB8P1erNEI8//enbsn5ujNmqebgMWHeazyxHUum?=
 =?us-ascii?Q?Mtd3Wg7PR1I3qK7iwkXl0Ym/UqEAM36FscVwCjLp7Zg4sFp1YTnzHo+HGDnZ?=
 =?us-ascii?Q?XjkK5hDdTgzv4GbQpvPFbsZGJ9SMa2scTz2GN+vQxW5HwJfTnAYKZHvxo7xE?=
 =?us-ascii?Q?6KuId/+35S/nQR6fWonIK76IH3TGZkRKrOsj7f3Z95+34Oy5R3oFYdvMWpCO?=
 =?us-ascii?Q?ijXPaYv4aq5EC7oxycoUsudE7BmrFj1S11fYWus24Kc6KzKx9BPvO3TCYoBS?=
 =?us-ascii?Q?lDeM46ZVq2Wvz11f24U0y6P3crWHoQlYolmyG29G7xgUte5Kx0U/zjBcsOXT?=
 =?us-ascii?Q?GfbHIjyh17zi9L35ciukbYQI2ZV4xmOMFVIlQMKGFVJIWm3GStQK7XkfGrre?=
 =?us-ascii?Q?Jpxig=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: wn7WhePOLzbaKVoJldQmZJJxHj86SK6XfnW1sBUpYc9VHtT1tqwErMdVJ0N31BzzZmfNRA7p6mGEW15p26Kdv0WQVnIVdxhv7kGvtqYI82T+blIPw6HZq5NezhrqQfVTnoPLcF3EvBrxPUsZ5LZcUqH+rBnwt1dMMKY1SBc/gzm1p7m815DXvDg64Rf5M1zI137/QF8n1h4T/srUJezb8EWpwr1JSswJcHxu1yY6FMS9Pc0JitGTvdQTB1IZaiVnSER1Ht7TT5RZJmTkvqfNXMBI3oMo+Nb4DgWNhqFaHJz1C7pT2xA2VOJl5hnuT25U0H2vcHBUEMI4C4QcB6pAcodrO7NU32rrDcttdiJ7Jz6tkzFjex07os/OIwmY3txfQfUOlH6AEdj0LpbucFn63jEFV8DdYVQ40be+A1V5XZo=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3098;6:z/NlgOl6XGSXQn2Cm2dQ7052arH5F+V8JoGBz2eT4m1usMiPen/1yyoLP7lbUkJBS4hBPkZTFjyNKOqqi8ER3Orv9AWcOZcOGKIGpCciD7weDVM3S+z0I2NkO1FnjRdSNj99dDPXaubW0FgnfMFgnWABZGmfla4a65asRvUvUDDoAsVPHYdjO7TC18A9E/jMQIPB3FDTiH2dPO0VOuOQpjppllthElFSF5q9cX6HASqGsir9glZ7Y8gaYbz+g6vi3HjRFrbVv8WwYDc/h7qtiDIyQwhhbISoXRXGBB82ntQDNWXV6jz/0D8qfiQqbejgjIFiPRGMfMWvO65q2nsjqNHin/c64+EcR/iGvsQMOyo5iKBP7qAm/RC7qDgAN65rIqpiYzFLaSm0cbhx5u7lX3ib+Ij6xQFs4pj4MHUhlXuLAJNPzKRG5Pq5vHUCjmKQEF2CKv9LDzNJL/3pHYZuiw==;5:hMS7c1sCPec8srIICm1xCOA726bR5PMbELLoIkIHF54dH4977TUWUYtgik+M4RQ+0nd+T4aO/XCH+jk04V+MJytTEGf/vUzHZOXgKSwrZOPhNAaKvEuceeVvztxQ6ZprPw4sL785jRM+vuPhSR2togxo0SjTXTewt7XbZeJMwGtViwXDGRrsCN1gQu89Yobkz7U6mpFhM2/6nl9f8hde6w==;7:Xpd24ANu/+we2tbTgrM2LeLFf5lyZo+OA+ycwraLhYKsnwfe0kEPfT0aohhRrinfy5jO0sq9ouHXqbNuxiXf+2e2iW1DOT/TdNLahpmvdok/sEraNDhR58Kp4YqesM64GjXUme76dMa4LrnMKw3bfQ==
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3098;20:X+p9IqGDr/GeR5Aq8mp05tr/RvYjzm7i2usKGz4g9RmwnRNWhW/hpbzXUMgKE09zV6b5rk/L7LvIoYhBwWIkdknXEWgD3yvneYSNxwoC1g2YQvSQuyJBz8+h+9ARbBhYSKa+iMyLweYELMmS5qE67Ez/ISctT/Cqylx/fxGRhlycrK6g/ZxE0sKlwC6jaKzWMRCy2wr3L1IHxrUEZZ4yTH7K7iKGJM72AnmhJgeT1TPLYLOOb/b7BRej+4jhzjBI
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2019 11:04:56.0064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72563e59-24b3-423b-da3b-08d686a2c501
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3098
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901300089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@free-electrons.com>

This adds support for Cadence MHDP DPI to DP bridge.

Basically, it takes a DPI stream as input and output it encoded in DP
format. It supports SST and MST modes.

Changes made in the low level driver (cdn-dp-reg.*):
- moved it to from drivers/gpu/drm/rockchip to
  drivers/gpu/drm/bridge/cdns-mhdp-common.c and
  include/drm/bridge/cdns-mhdp-common.h
- functions for sending/receiving commands are now public
- added functions for reading registers and link training
  adjustment

Changes made in RK's driver (cdn-dp-core.*):
- Moved audio_info and audio_pdev fields from cdn_dp_device to
  cdns_mhdp_device structure.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Signed-off-by: Piotr Sroka <piotrs@cadence.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/bridge/Kconfig                |    9 +
 drivers/gpu/drm/bridge/Makefile               |    3 +
 .../cdns-mhdp-common.c}                       |  186 ++-
 drivers/gpu/drm/bridge/cdns-mhdp-mst.c        |  549 +++++++
 drivers/gpu/drm/bridge/cdns-mhdp.c            | 1349 +++++++++++++++++
 drivers/gpu/drm/bridge/cdns-mhdp.h            |  209 +++
 drivers/gpu/drm/rockchip/Kconfig              |    4 +-
 drivers/gpu/drm/rockchip/Makefile             |    2 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c        |   34 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.h        |    5 +-
 include/drm/bridge/cdns-mhdp-cbs.h            |   29 +
 .../drm/bridge/cdns-mhdp-common.h             |   68 +-
 12 files changed, 2384 insertions(+), 63 deletions(-)
 rename drivers/gpu/drm/{rockchip/cdn-dp-reg.c => bridge/cdns-mhdp-common.c} (85%)
 create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp-mst.c
 create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp.c
 create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp.h
 create mode 100644 include/drm/bridge/cdns-mhdp-cbs.h
 rename drivers/gpu/drm/rockchip/cdn-dp-reg.h => include/drm/bridge/cdns-mhdp-common.h (91%)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 2fee47b0d50b..2b7c568756fb 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -35,6 +35,15 @@ config DRM_CDNS_DSI
 	  Support Cadence DPI to DSI bridge. This is an internal
 	  bridge and is meant to be directly embedded in a SoC.
 
+config DRM_CDNS_MHDP
+	tristate "Cadence DPI/DP bridge"
+	select DRM_KMS_HELPER
+	select DRM_PANEL_BRIDGE
+	depends on OF
+	help
+	  Support Cadence DPI to DP bridge. This is an internal
+	  bridge and is meant to be directly embedded in a SoC.
+
 config DRM_DUMB_VGA_DAC
 	tristate "Dumb VGA DAC Bridge support"
 	depends on OF
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index 4934fcf5a6f8..b80f3d6ed2a6 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -16,4 +16,7 @@ obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix/
 obj-$(CONFIG_DRM_I2C_ADV7511) += adv7511/
 obj-$(CONFIG_DRM_TI_SN65DSI86) += ti-sn65dsi86.o
 obj-$(CONFIG_DRM_TI_TFP410) += ti-tfp410.o
+obj-$(CONFIG_DRM_CDNS_MHDP) += mhdp8546.o
 obj-y += synopsys/
+
+mhdp8546-objs := cdns-mhdp-common.o cdns-mhdp.o cdns-mhdp-mst.o
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c b/drivers/gpu/drm/bridge/cdns-mhdp-common.c
similarity index 85%
rename from drivers/gpu/drm/rockchip/cdn-dp-reg.c
rename to drivers/gpu/drm/bridge/cdns-mhdp-common.c
index a32ee26fd36b..f0160df52aed 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.c
+++ b/drivers/gpu/drm/bridge/cdns-mhdp-common.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
  * Author: Chris Zhong <zyw@rock-chips.com>
@@ -13,14 +14,17 @@
  */
 
 #include <linux/clk.h>
-#include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/reset.h>
 
-#include "cdn-dp-core.h"
-#include "cdn-dp-reg.h"
+#include <asm/unaligned.h>
+
+#include <drm/bridge/cdns-mhdp-common.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_print.h>
 
 #define CDNS_DP_SPDIF_CLK		200000000
 #define FW_ALIVE_TIMEOUT_US		1000000
@@ -29,10 +33,27 @@
 #define LINK_TRAINING_RETRY_MS		20
 #define LINK_TRAINING_TIMEOUT_MS	500
 
+static inline u32 get_unaligned_be24(const void *p)
+{
+	const u8 *_p = p;
+
+	return _p[0] << 16 | _p[1] << 8 | _p[2];
+}
+
+static inline void put_unaligned_be24(u32 val, void *p)
+{
+	u8 *_p = p;
+
+	_p[0] = val >> 16;
+	_p[1] = val >> 8;
+	_p[2] = val;
+}
+
 void cdns_mhdp_set_fw_clk(struct cdns_mhdp_device *mhdp, unsigned long clk)
 {
 	writel(clk / 1000000, mhdp->regs + SW_CLK_H);
 }
+EXPORT_SYMBOL(cdns_mhdp_set_fw_clk);
 
 void cdns_mhdp_clock_reset(struct cdns_mhdp_device *mhdp)
 {
@@ -82,6 +103,7 @@ void cdns_mhdp_clock_reset(struct cdns_mhdp_device *mhdp)
 	/* enable Mailbox and PIF interrupt */
 	writel(0, mhdp->regs + APB_INT_MASK);
 }
+EXPORT_SYMBOL(cdns_mhdp_clock_reset);
 
 static int cdns_mhdp_mailbox_read(struct cdns_mhdp_device *mhdp)
 {
@@ -128,7 +150,7 @@ static int cdns_mhdp_mailbox_validate_receive(struct cdns_mhdp_device *mhdp,
 		header[i] = ret;
 	}
 
-	mbox_size = (header[2] << 8) | header[3];
+	mbox_size = get_unaligned_be16(header + 2);
 
 	if (opcode != header[0] || module_id != header[1] ||
 	    req_size != mbox_size) {
@@ -171,8 +193,7 @@ static int cdns_mhdp_mailbox_send(struct cdns_mhdp_device *mhdp, u8 module_id,
 
 	header[0] = opcode;
 	header[1] = module_id;
-	header[2] = (size >> 8) & 0xff;
-	header[3] = size & 0xff;
+	put_unaligned_be16(size, header + 2);
 
 	for (i = 0; i < 4; i++) {
 		ret = cdp_dp_mailbox_write(mhdp, header[i]);
@@ -189,37 +210,78 @@ static int cdns_mhdp_mailbox_send(struct cdns_mhdp_device *mhdp, u8 module_id,
 	return 0;
 }
 
-static int cdns_mhdp_reg_write(struct cdns_mhdp_device *mhdp, u16 addr, u32 val)
+int cdns_mhdp_reg_read(struct cdns_mhdp_device *mhdp, u32 addr, u32 *value)
+{
+	u8 msg[4], resp[8];
+	int ret;
+
+	if (addr == 0) {
+		ret = -EINVAL;
+		goto err_reg_read;
+	}
+
+	put_unaligned_be32(addr, msg);
+
+	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_GENERAL,
+				     GENERAL_REGISTER_READ,
+				     sizeof(msg), msg);
+	if (ret)
+		goto err_reg_read;
+
+	ret = cdns_mhdp_mailbox_validate_receive(mhdp, MB_MODULE_ID_GENERAL,
+						 GENERAL_REGISTER_READ,
+						 sizeof(resp));
+	if (ret)
+		goto err_reg_read;
+
+	ret = cdns_mhdp_mailbox_read_receive(mhdp, resp, sizeof(resp));
+	if (ret)
+		goto err_reg_read;
+
+	/* Returned address value should be the same as requested */
+	if (memcmp(msg, resp, sizeof(msg))) {
+		ret = -EINVAL;
+		goto err_reg_read;
+	}
+
+	*value = get_unaligned_be32(resp + 4);
+
+err_reg_read:
+	if (ret) {
+		DRM_DEV_ERROR(mhdp->dev, "Failed to read register.\n");
+		*value = 0;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(cdns_mhdp_reg_read);
+
+int cdns_mhdp_reg_write(struct cdns_mhdp_device *mhdp, u16 addr, u32 val)
 {
 	u8 msg[6];
 
-	msg[0] = (addr >> 8) & 0xff;
-	msg[1] = addr & 0xff;
-	msg[2] = (val >> 24) & 0xff;
-	msg[3] = (val >> 16) & 0xff;
-	msg[4] = (val >> 8) & 0xff;
-	msg[5] = val & 0xff;
+	put_unaligned_be16(addr, msg);
+	put_unaligned_be32(val, msg + 2);
+
 	return cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
 				      DPTX_WRITE_REGISTER, sizeof(msg), msg);
 }
+EXPORT_SYMBOL(cdns_mhdp_reg_write);
 
-static int cdns_mhdp_reg_write_bit(struct cdns_mhdp_device *mhdp, u16 addr,
+int cdns_mhdp_reg_write_bit(struct cdns_mhdp_device *mhdp, u16 addr,
 				   u8 start_bit, u8 bits_no, u32 val)
 {
 	u8 field[8];
 
-	field[0] = (addr >> 8) & 0xff;
-	field[1] = addr & 0xff;
+	put_unaligned_be16(addr, field);
 	field[2] = start_bit;
 	field[3] = bits_no;
-	field[4] = (val >> 24) & 0xff;
-	field[5] = (val >> 16) & 0xff;
-	field[6] = (val >> 8) & 0xff;
-	field[7] = val & 0xff;
+	put_unaligned_be32(val, field + 4);
 
 	return cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
 				      DPTX_WRITE_FIELD, sizeof(field), field);
 }
+EXPORT_SYMBOL(cdns_mhdp_reg_write_bit);
 
 int cdns_mhdp_dpcd_read(struct cdns_mhdp_device *mhdp,
 			u32 addr, u8 *data, u16 len)
@@ -227,11 +289,9 @@ int cdns_mhdp_dpcd_read(struct cdns_mhdp_device *mhdp,
 	u8 msg[5], reg[5];
 	int ret;
 
-	msg[0] = (len >> 8) & 0xff;
-	msg[1] = len & 0xff;
-	msg[2] = (addr >> 16) & 0xff;
-	msg[3] = (addr >> 8) & 0xff;
-	msg[4] = addr & 0xff;
+	put_unaligned_be16(len, msg);
+	put_unaligned_be24(addr, msg + 2);
+
 	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
 				     DPTX_READ_DPCD, sizeof(msg), msg);
 	if (ret)
@@ -252,18 +312,17 @@ int cdns_mhdp_dpcd_read(struct cdns_mhdp_device *mhdp,
 err_dpcd_read:
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_dpcd_read);
 
 int cdns_mhdp_dpcd_write(struct cdns_mhdp_device *mhdp, u32 addr, u8 value)
 {
 	u8 msg[6], reg[5];
 	int ret;
 
-	msg[0] = 0;
-	msg[1] = 1;
-	msg[2] = (addr >> 16) & 0xff;
-	msg[3] = (addr >> 8) & 0xff;
-	msg[4] = addr & 0xff;
+	put_unaligned_be16(1, msg);
+	put_unaligned_be24(addr, msg + 2);
 	msg[5] = value;
+
 	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
 				     DPTX_WRITE_DPCD, sizeof(msg), msg);
 	if (ret)
@@ -278,7 +337,7 @@ int cdns_mhdp_dpcd_write(struct cdns_mhdp_device *mhdp, u32 addr, u8 value)
 	if (ret)
 		goto err_dpcd_write;
 
-	if (addr != (reg[2] << 16 | reg[3] << 8 | reg[4]))
+	if (addr != get_unaligned_be24(reg + 2))
 		ret = -EINVAL;
 
 err_dpcd_write:
@@ -286,6 +345,7 @@ int cdns_mhdp_dpcd_write(struct cdns_mhdp_device *mhdp, u32 addr, u8 value)
 		DRM_DEV_ERROR(mhdp->dev, "dpcd write failed: %d\n", ret);
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_dpcd_write);
 
 int cdns_mhdp_load_firmware(struct cdns_mhdp_device *mhdp, const u32 *i_mem,
 			    u32 i_size, const u32 *d_mem, u32 d_size)
@@ -328,6 +388,7 @@ int cdns_mhdp_load_firmware(struct cdns_mhdp_device *mhdp, const u32 *i_mem,
 
 	return 0;
 }
+EXPORT_SYMBOL(cdns_mhdp_load_firmware);
 
 int cdns_mhdp_set_firmware_active(struct cdns_mhdp_device *mhdp, bool enable)
 {
@@ -362,6 +423,7 @@ int cdns_mhdp_set_firmware_active(struct cdns_mhdp_device *mhdp, bool enable)
 		DRM_DEV_ERROR(mhdp->dev, "set firmware active failed\n");
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_set_firmware_active);
 
 int cdns_mhdp_set_host_cap(struct cdns_mhdp_device *mhdp, u8 lanes, bool flip)
 {
@@ -391,6 +453,7 @@ int cdns_mhdp_set_host_cap(struct cdns_mhdp_device *mhdp, u8 lanes, bool flip)
 		DRM_DEV_ERROR(mhdp->dev, "set host cap failed: %d\n", ret);
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_set_host_cap);
 
 int cdns_mhdp_event_config(struct cdns_mhdp_device *mhdp)
 {
@@ -408,11 +471,13 @@ int cdns_mhdp_event_config(struct cdns_mhdp_device *mhdp)
 
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_event_config);
 
 u32 cdns_mhdp_get_event(struct cdns_mhdp_device *mhdp)
 {
 	return readl(mhdp->regs + SW_EVENTS0);
 }
+EXPORT_SYMBOL(cdns_mhdp_get_event);
 
 int cdns_mhdp_get_hpd_status(struct cdns_mhdp_device *mhdp)
 {
@@ -440,6 +505,7 @@ int cdns_mhdp_get_hpd_status(struct cdns_mhdp_device *mhdp)
 	DRM_DEV_ERROR(mhdp->dev, "get hpd status failed: %d\n", ret);
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_get_hpd_status);
 
 int cdns_mhdp_get_edid_block(void *data, u8 *edid,
 			  unsigned int block, size_t length)
@@ -482,6 +548,7 @@ int cdns_mhdp_get_edid_block(void *data, u8 *edid,
 
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_get_edid_block);
 
 static int cdns_mhdp_training_start(struct cdns_mhdp_device *mhdp)
 {
@@ -580,6 +647,7 @@ int cdns_mhdp_train_link(struct cdns_mhdp_device *mhdp)
 			  mhdp->link.num_lanes);
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_train_link);
 
 int cdns_mhdp_set_video_status(struct cdns_mhdp_device *mhdp, int active)
 {
@@ -595,6 +663,7 @@ int cdns_mhdp_set_video_status(struct cdns_mhdp_device *mhdp, int active)
 
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_set_video_status);
 
 static int cdns_mhdp_get_msa_misc(struct video_info *video,
 				  struct drm_display_mode *mode)
@@ -797,6 +866,7 @@ int cdns_mhdp_config_video(struct cdns_mhdp_device *mhdp)
 		DRM_DEV_ERROR(mhdp->dev, "config video failed: %d\n", ret);
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_config_video);
 
 int cdns_mhdp_audio_stop(struct cdns_mhdp_device *mhdp,
 			 struct audio_info *audio)
@@ -831,6 +901,7 @@ int cdns_mhdp_audio_stop(struct cdns_mhdp_device *mhdp,
 
 	return 0;
 }
+EXPORT_SYMBOL(cdns_mhdp_audio_stop);
 
 int cdns_mhdp_audio_mute(struct cdns_mhdp_device *mhdp, bool enable)
 {
@@ -842,6 +913,7 @@ int cdns_mhdp_audio_mute(struct cdns_mhdp_device *mhdp, bool enable)
 
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_audio_mute);
 
 static void cdns_mhdp_audio_config_i2s(struct cdns_mhdp_device *mhdp,
 				       struct audio_info *audio)
@@ -977,3 +1049,55 @@ int cdns_mhdp_audio_config(struct cdns_mhdp_device *mhdp,
 		DRM_DEV_ERROR(mhdp->dev, "audio config failed: %d\n", ret);
 	return ret;
 }
+EXPORT_SYMBOL(cdns_mhdp_audio_config);
+
+int cdns_mhdp_adjust_lt(struct cdns_mhdp_device *mhdp,
+			u8 nlanes, u16 udelay, u8 *lanes_data, u8 *dpcd)
+{
+	u8 payload[7];
+	u8 hdr[5]; /* For DPCD read response header */
+	u32 addr;
+	u8 const nregs = 6; /* Registers 0x202-0x207 */
+	int ret;
+
+	if (nlanes != 4 && nlanes != 2 && nlanes != 1) {
+		DRM_DEV_ERROR(mhdp->dev, "invalid number of lanes: %d\n",
+			      nlanes);
+		ret = -EINVAL;
+		goto err_adjust_lt;
+	}
+
+	payload[0] = nlanes;
+	put_unaligned_be16(udelay, payload + 1);
+	memcpy(payload + 3, lanes_data, nlanes);
+
+	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
+				     DPTX_ADJUST_LT,
+				     sizeof(payload), payload);
+	if (ret)
+		goto err_adjust_lt;
+
+	/* Yes, read the DPCD read command response */
+	ret = cdns_mhdp_mailbox_validate_receive(mhdp, MB_MODULE_ID_DP_TX,
+						 DPTX_READ_DPCD,
+						 sizeof(hdr) + nregs);
+	if (ret)
+		goto err_adjust_lt;
+
+	ret = cdns_mhdp_mailbox_read_receive(mhdp, hdr, sizeof(hdr));
+	if (ret)
+		goto err_adjust_lt;
+
+	addr = get_unaligned_be24(hdr + 2);
+	if (addr != DP_LANE0_1_STATUS)
+		goto err_adjust_lt;
+
+	ret = cdns_mhdp_mailbox_read_receive(mhdp, dpcd, nregs);
+
+err_adjust_lt:
+	if (ret)
+		DRM_DEV_ERROR(mhdp->dev, "Failed to adjust Link Training.\n");
+
+	return ret;
+}
+EXPORT_SYMBOL(cdns_mhdp_adjust_lt);
diff --git a/drivers/gpu/drm/bridge/cdns-mhdp-mst.c b/drivers/gpu/drm/bridge/cdns-mhdp-mst.c
new file mode 100644
index 000000000000..628e26cb561f
--- /dev/null
+++ b/drivers/gpu/drm/bridge/cdns-mhdp-mst.c
@@ -0,0 +1,549 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence MHDP DP MST bridge driver.
+ *
+ * Copyright: 2018 Cadence Design Systems, Inc.
+ *
+ * Author: Piotr Sroka <piotrs@cadence.com>
+ */
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_fixed.h>
+#include <drm/drm_print.h>
+#include <drm/drm_probe_helper.h>
+#include <linux/iopoll.h>
+
+#include <drm/bridge/cdns-mhdp-common.h>
+#include "cdns-mhdp.h"
+
+
+static void cdns_mhdp_mst_stream_enable(struct cdns_mhdp_bridge *mhdp_bridge,
+					const bool enable)
+{
+	u32 reg;
+	struct cdns_mhdp_device *mhdp = mhdp_bridge->mhdp;
+	const u8 stream_id = mhdp_bridge->stream_id;
+
+	cdns_mhdp_reg_read(mhdp, CDNS_DP_MST_STREAM_CONFIG(stream_id), &reg);
+
+	if (enable) {
+		reg |= CDNS_DP_MST_STRM_CFG_STREAM_EN;
+		reg &= ~CDNS_DP_MST_STRM_CFG_NO_VIDEO;
+	} else {
+		reg &= ~CDNS_DP_MST_STRM_CFG_STREAM_EN;
+		reg |= CDNS_DP_MST_STRM_CFG_NO_VIDEO;
+	}
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_MST_STREAM_CONFIG(stream_id), reg);
+}
+
+static inline s64 calc_fixed_avg_slots(const u32 pbn, const u32 pbn_div)
+{
+	s64 fixed_pbn, fixed_pbn_div, fixed_targ_avg_slots;
+
+	fixed_pbn = drm_int2fixp(pbn);
+	fixed_pbn_div = drm_int2fixp(pbn_div);
+	fixed_targ_avg_slots = drm_fixp_div(fixed_pbn, fixed_pbn_div);
+
+	return fixed_targ_avg_slots;
+}
+
+static void cdns_mhdp_set_rate_governing(struct cdns_mhdp_bridge *bridge,
+					 const bool enable)
+{
+	struct cdns_mhdp_device *mhdp = bridge->mhdp;
+	const u8 stream_id = bridge->stream_id;
+	s64 fixed_targ_avg_slots, fixed_y;
+	u32 x, y;
+
+	if (!enable) {
+		cdns_mhdp_reg_write(mhdp, CDNS_DP_RATE_GOVERNING(stream_id), 0);
+		return;
+	}
+
+	fixed_targ_avg_slots = calc_fixed_avg_slots(bridge->pbn,
+						    mhdp->mst_mgr.pbn_div);
+	x = bridge->pbn / mhdp->mst_mgr.pbn_div;
+
+	fixed_y = fixed_targ_avg_slots - drm_int2fixp(x);
+	fixed_y *= 16;
+
+	y = drm_fixp2int_ceil(fixed_y);
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_RATE_GOVERNING(stream_id),
+			    CDNS_DP_RG_TARG_AV_SLOTS_Y(y) |
+			    CDNS_DP_RG_TARG_AV_SLOTS_X(x) |
+			    CDNS_DP_RG_ENABLE);
+}
+
+
+static struct drm_dp_payload *
+cdns_mhdp_get_payload(struct cdns_mhdp_bridge *bridge)
+{
+	const int vcpi = bridge->connector->port->vcpi.vcpi;
+	struct cdns_mhdp_device *mhdp = bridge->mhdp;
+	int i;
+
+	for (i = 0; i < mhdp->mst_mgr.max_payloads; i++) {
+		struct drm_dp_payload *payload = &mhdp->mst_mgr.payloads[i];
+
+		if (payload->vcpi == vcpi)
+			return payload;
+	}
+
+	return NULL;
+}
+
+
+static int
+cdns_mhdp_set_act_enable(struct cdns_mhdp_device *mhdp)
+{
+	u32 reg;
+	int ret;
+
+	cdns_mhdp_reg_read(mhdp, CDNS_DP_MTPH_CONTROL, &reg);
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_MTPH_CONTROL,
+			    reg | CDNS_DP_MTPH_ACT_EN);
+
+	ret = readl_poll_timeout(mhdp->regs + CDNS_DP_MTPH_STATUS, reg,
+				 ((reg & CDNS_DP_MTPH_ACT_STATUS) == 0), 0,
+				 30);
+	if (ret) {
+		dev_err(mhdp->dev,
+			"ACT sequence cannot complete in 30us\n");
+		return -EIO;
+	}
+
+	return drm_dp_check_act_status(&mhdp->mst_mgr);
+}
+
+
+static int
+cdns_mhdp_apply_slot_allocation(struct cdns_mhdp_bridge *mhdp_bridge)
+{
+	struct drm_dp_payload *payload;
+	struct cdns_mhdp_device *mhdp = mhdp_bridge->mhdp;
+	u8 stream_id = mhdp_bridge->stream_id;
+
+	payload = cdns_mhdp_get_payload(mhdp_bridge);
+
+	if (!payload) {
+		DRM_ERROR("payload is not found\n");
+		return -EIO;
+	}
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_MST_SLOT_ALLOCATE(stream_id),
+			    CDNS_DP_S_ALLOC_START_SLOT(payload->start_slot) |
+			    CDNS_DP_S_ALLOC_END_SLOT(payload->start_slot +
+						     payload->num_slots - 1));
+
+	return 0;
+}
+
+static void
+cdns_mhdp_update_slot_allocation(struct cdns_mhdp_bridge *mhdp_bridge)
+{
+	struct drm_device *dev = mhdp_bridge->base.dev;
+	struct drm_connector *connector;
+
+	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
+		struct cdns_mhdp_connector *mhdp_connector;
+
+		if (!connector->encoder)
+			continue;
+
+		mhdp_connector = to_mhdp_connector(connector);
+		if (!mhdp_connector->is_mst_connector)
+			continue;
+
+		if (mhdp_connector->bridge->stream_id != -1)
+			cdns_mhdp_apply_slot_allocation(mhdp_connector->bridge);
+	}
+}
+
+static enum drm_connector_status
+cdns_dp_mst_detect(struct drm_connector *connector, bool force)
+{
+	enum drm_connector_status stat;
+	struct cdns_mhdp_connector *mhdp_connector;
+	struct cdns_mhdp_device *mhdp;
+
+	mhdp_connector = to_mhdp_connector(connector);
+	mhdp =  mhdp_connector->bridge->mhdp;
+
+	stat = drm_dp_mst_detect_port(connector, &mhdp->mst_mgr,
+				      mhdp_connector->port);
+	return stat;
+}
+
+static void cdns_dp_mst_connector_destroy(struct drm_connector *connector)
+{
+	struct cdns_mhdp_connector *mhdp_connector;
+	struct cdns_mhdp_bridge *mhdp_bridge;
+
+	mhdp_connector = to_mhdp_connector(connector);
+	mhdp_bridge = mhdp_connector->bridge;
+
+	drm_connector_cleanup(&mhdp_connector->base);
+	drm_bridge_remove(&mhdp_bridge->base);
+	kfree(mhdp_connector);
+	kfree(mhdp_bridge);
+}
+
+static const struct drm_connector_funcs cdns_mhdp_mst_connector_funcs = {
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+	.reset = drm_atomic_helper_connector_reset,
+	.dpms = drm_helper_connector_dpms,
+	.detect = cdns_dp_mst_detect,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = cdns_dp_mst_connector_destroy,
+};
+
+static int cdns_mhdp_mst_get_ddc_modes(struct drm_connector *connector)
+{
+	struct cdns_mhdp_connector *mhdp_connector;
+	struct cdns_mhdp_device *mhdp;
+	struct edid *edid;
+	int num_modes = 0;
+
+	mhdp_connector = to_mhdp_connector(connector);
+	mhdp =  mhdp_connector->bridge->mhdp;
+
+	edid = drm_dp_mst_get_edid(connector, &mhdp->mst_mgr,
+				   mhdp_connector->port);
+	if (edid) {
+		DRM_DEBUG_KMS("edid retrieved %p\n", edid);
+		drm_connector_update_edid_property(connector, edid);
+		num_modes = drm_add_edid_modes(connector, edid);
+		kfree(edid);
+	} else
+		drm_connector_update_edid_property(connector, NULL);
+
+	return num_modes;
+}
+
+static int cdns_mhdp_mst_get_modes(struct drm_connector *connector)
+{
+	return cdns_mhdp_mst_get_ddc_modes(connector);
+}
+
+static struct
+drm_encoder *cdns_mhdp_mst_best_encoder(struct drm_connector *connector)
+{
+	struct cdns_mhdp_connector *mhdp_connector;
+
+	mhdp_connector = to_mhdp_connector(connector);
+
+	return mhdp_connector->bridge->base.encoder;
+}
+
+static const struct drm_connector_helper_funcs cdns_mhdp_mst_conn_helper_fun = {
+	.get_modes = cdns_mhdp_mst_get_modes,
+	.best_encoder = cdns_mhdp_mst_best_encoder,
+};
+
+void cdns_mhdp_mst_enable(struct drm_bridge *bridge)
+{
+	struct cdns_mhdp_bridge *mhdp_bridge = to_mhdp_bridge(bridge);
+	struct cdns_mhdp_device *mhdp = mhdp_bridge->mhdp;
+	struct drm_display_info *disp_info;
+	struct drm_display_mode *mode;
+	struct cdns_mhdp_connector *mhdp_connector;
+	u32 bpp;
+	enum pixel_format pxlfmt;
+	int ret, slots, stream_id;
+
+	disp_info = &mhdp_bridge->connector->base.display_info;
+
+	pxlfmt = cdns_mhdp_get_pxlfmt(disp_info->color_formats);
+	bpp = cdns_mhdp_get_bpp(disp_info->bpc, pxlfmt);
+
+	mhdp_connector = mhdp_bridge->connector;
+	if (mhdp_bridge->stream_id > -1) {
+		DRM_ERROR("stream id is attached before bridge is enabled\n");
+		return;
+	}
+
+	stream_id = bridge->encoder->crtc->index;
+
+	mode = &bridge->encoder->crtc->state->adjusted_mode;
+	mhdp_bridge->pbn = drm_dp_calc_pbn_mode(mode->clock, bpp);
+
+	slots = drm_dp_find_vcpi_slots(&mhdp->mst_mgr, mhdp_bridge->pbn);
+	ret = drm_dp_mst_allocate_vcpi(&mhdp->mst_mgr,
+				       mhdp_connector->port,
+				       mhdp_bridge->pbn, slots);
+	if (ret == false) {
+		DRM_ERROR("failed to allocate vcpi\n");
+		return;
+	}
+	ret = drm_dp_update_payload_part1(&mhdp->mst_mgr);
+	if (ret < 0)
+		DRM_ERROR("failed update_payload_part1\n");
+
+	mhdp_bridge->stream_id = stream_id;
+	mhdp_bridge->is_active = true;
+
+	cdns_mhdp_mst_stream_enable(mhdp_bridge, true);
+	cdns_mhdp_configure_video(bridge);
+
+	ret = cdns_mhdp_apply_slot_allocation(mhdp_bridge);
+	if (ret < 0) {
+		cdns_mhdp_mst_stream_enable(mhdp_bridge, false);
+		mhdp_bridge->stream_id = -1;
+		mhdp_bridge->is_active = false;
+		return;
+	}
+
+	ret = cdns_mhdp_set_act_enable(mhdp);
+	if (ret)
+		DRM_ERROR("failed ACT sequence\n");
+
+	cdns_mhdp_set_rate_governing(mhdp_bridge, true);
+
+	drm_dp_update_payload_part2(&mhdp->mst_mgr);
+}
+
+void cdns_mhdp_mst_disable(struct drm_bridge *bridge)
+{
+	struct cdns_mhdp_bridge *mhdp_bridge = to_mhdp_bridge(bridge);
+	struct cdns_mhdp_device *mhdp = mhdp_bridge->mhdp;
+	struct cdns_mhdp_connector *connector = mhdp_bridge->connector;
+
+	drm_dp_mst_reset_vcpi_slots(&mhdp->mst_mgr, connector->port);
+	drm_dp_update_payload_part1(&mhdp->mst_mgr);
+
+	cdns_mhdp_update_slot_allocation(mhdp_bridge);
+
+	drm_dp_check_act_status(&mhdp->mst_mgr);
+
+	drm_dp_update_payload_part2(&mhdp->mst_mgr);
+
+	drm_dp_mst_deallocate_vcpi(&mhdp->mst_mgr, connector->port);
+
+	cdns_mhdp_set_rate_governing(mhdp_bridge, false);
+	cdns_mhdp_mst_stream_enable(mhdp_bridge, false);
+	mhdp_bridge->stream_id = -1;
+	mhdp_bridge->is_active = false;
+}
+
+static const struct drm_bridge_funcs cdns_mhdp_mst_bridge_funcs = {
+	.enable = cdns_mhdp_enable,
+	.disable = cdns_mhdp_mst_disable,
+};
+
+
+static struct cdns_mhdp_bridge*
+cdns_mhpd_create_fake_mst_bridge(struct cdns_mhdp_device *mhdp,
+				struct cdns_mhdp_connector *mhdp_connector)
+{
+	struct cdns_mhdp_bridge *mhdp_bridge;
+	struct drm_encoder *encoder = NULL;
+	struct cdns_mhdp_mst_cbs *cbs = &mhdp->cbs;
+
+	mhdp_bridge = kzalloc(sizeof(*mhdp_bridge), GFP_KERNEL);
+	if (!mhdp_bridge)
+		return NULL;
+
+	mhdp_bridge->mhdp = mhdp;
+	mhdp_bridge->stream_id = -1;
+	mhdp_bridge->connector = mhdp_connector;
+	mhdp_bridge->is_active = false;
+
+	mhdp_bridge->base.funcs = &cdns_mhdp_mst_bridge_funcs;
+
+	drm_bridge_add(&mhdp_bridge->base);
+
+	if (cbs->funcs.create_mst_encoder)
+		encoder = cbs->funcs.create_mst_encoder(cbs->priv_data,
+							&mhdp_bridge->base);
+	if (encoder) {
+		int ret;
+		/* use the same drm device as is in the first encoder */
+		encoder->dev = mhdp->bridge.base.encoder->dev;
+		encoder->possible_crtcs &= ((1 << CDNS_MHDP_MAX_STREAMS) - 1);
+		ret = drm_bridge_attach(encoder, &mhdp_bridge->base, NULL);
+		if (ret) {
+			dev_err(mhdp->dev, "bridge attaching error %d\n", ret);
+			return NULL;
+		}
+
+		ret = drm_connector_attach_encoder(&mhdp_connector->base,
+							encoder);
+		if (ret) {
+			dev_err(mhdp->dev, "failed to attach connector to encoder\n");
+			return NULL;
+		}
+	}
+
+	return mhdp_bridge;
+}
+
+static struct drm_connector *
+cdns_mhdp_mst_cbs_add_connector(struct drm_dp_mst_topology_mgr *mgr,
+				struct drm_dp_mst_port *port,
+				const char *pathprop)
+{
+	struct cdns_mhdp_device *mhdp = mgr_to_mhdp(mgr);
+	struct drm_device *dev = mhdp->bridge.base.dev;
+	struct cdns_mhdp_connector *mhdp_connector;
+	struct drm_connector *connector;
+	struct drm_connector_state  *conn_state;
+	int ret;
+
+	mhdp_connector = kzalloc(sizeof(struct cdns_mhdp_connector),
+				 GFP_KERNEL);
+	if (!mhdp_connector)
+		return NULL;
+
+	mhdp_connector->is_mst_connector = true;
+	connector = &mhdp_connector->base;
+	mhdp_connector->port = port;
+	DRM_DEBUG_KMS("\n");
+
+	conn_state = kzalloc(sizeof(*conn_state), GFP_KERNEL);
+	if (!conn_state)
+		return NULL;
+
+	__drm_atomic_helper_connector_reset(connector,
+					    conn_state);
+
+	drm_connector_init(dev, connector, &cdns_mhdp_mst_connector_funcs,
+			   DRM_MODE_CONNECTOR_DisplayPort);
+	drm_connector_helper_add(connector, &cdns_mhdp_mst_conn_helper_fun);
+	mhdp_connector->bridge =
+		cdns_mhpd_create_fake_mst_bridge(mhdp, mhdp_connector);
+
+	drm_object_attach_property(&connector->base,
+				   dev->mode_config.path_property, 0);
+	drm_object_attach_property(&connector->base,
+				   dev->mode_config.tile_property, 0);
+	ret = drm_connector_set_path_property(connector, pathprop);
+
+	if (ret)
+		DRM_ERROR("set path propertty failed\n");
+
+	return connector;
+}
+
+static void
+cdns_mhdp_mst_cbs_destroy_connector(struct drm_dp_mst_topology_mgr *mgr,
+				    struct drm_connector *connector)
+{
+	struct cdns_mhdp_connector *mhdp_connector;
+	struct cdns_mhdp_device *mhdp;
+	struct cdns_mhdp_bridge *mhdp_bridge;
+
+	mhdp_connector = to_mhdp_connector(connector);
+	mhdp_bridge = mhdp_connector->bridge;
+	mhdp = mhdp_bridge->mhdp;
+
+	drm_connector_unregister(&mhdp_connector->base);
+
+	if (mhdp->cbs.funcs.create_mst_encoder)
+		mhdp->cbs.funcs.destroy_mst_encoder(mhdp->cbs.priv_data,
+						    &mhdp_bridge->base);
+	drm_connector_put(&mhdp_connector->base);
+}
+
+static void
+cdns_mhdp_mst_cbs_register_connector(struct drm_connector *connector)
+{
+	int ret;
+
+	ret = drm_connector_register(connector);
+	if (ret)
+		DRM_ERROR("Register connector failed\n");
+
+}
+
+static const struct drm_dp_mst_topology_cbs mst_cbs = {
+	.add_connector = cdns_mhdp_mst_cbs_add_connector,
+	.register_connector = cdns_mhdp_mst_cbs_register_connector,
+	.destroy_connector = cdns_mhdp_mst_cbs_destroy_connector,
+};
+
+static void cdns_mhdp_set_mst_enable(struct cdns_mhdp_device *mhdp, bool enable)
+{
+	u32 reg_val;
+
+	cdns_mhdp_reg_read(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG, &reg_val);
+
+	if (enable)
+		reg_val |= CDNS_DP_MST_EN;
+	else
+		reg_val &= ~CDNS_DP_MST_EN;
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG, reg_val);
+}
+
+bool cdns_mhdp_mst_probe(struct cdns_mhdp_device *mhdp)
+{
+	u8 mstm_cap;
+	u8 dpcd_cap[DP_RECEIVER_CAP_SIZE];
+
+	bool is_mst;
+
+	if (!mhdp->can_mst)
+		return false;
+
+	drm_dp_dpcd_read(&mhdp->aux, DP_DPCD_REV, dpcd_cap,
+			 DP_RECEIVER_CAP_SIZE);
+
+	if (dpcd_cap[DP_DPCD_REV] < 0x12)
+		return false;
+
+	if (drm_dp_dpcd_readb(&mhdp->aux, DP_MSTM_CAP, &mstm_cap) != 1)
+		return false;
+
+	if (mstm_cap & DP_MST_CAP) {
+		DRM_DEBUG_KMS("Sink is MST capable\n");
+		is_mst = true;
+	} else {
+		DRM_DEBUG_KMS("Sink is not MST capable\n");
+		is_mst = false;
+	}
+
+	if (is_mst != mhdp->is_mst) {
+		mhdp->is_mst = is_mst;
+		cdns_mhdp_set_mst_enable(mhdp, mhdp->is_mst);
+
+		drm_dp_mst_topology_mgr_set_mst(&mhdp->mst_mgr,
+						mhdp->is_mst);
+	}
+
+	return mhdp->is_mst;
+}
+
+int cdns_mhdp_mst_init(struct cdns_mhdp_device *mhdp)
+{
+	struct cdns_mhdp_bridge *bridge = &mhdp->bridge;
+	struct drm_device *dev = bridge->base.dev;
+	struct cdns_mhdp_connector *connector = bridge->connector;
+	int ret;
+
+	mhdp->mst_mgr.cbs = &mst_cbs;
+	ret = drm_dp_mst_topology_mgr_init(&mhdp->mst_mgr, dev,
+					   &mhdp->aux, 16,
+					   CDNS_MHDP_MAX_STREAMS,
+					   connector->base.base.id);
+	mhdp->can_mst = ret ? false : true;
+	mhdp->is_mst = false;
+	bridge->stream_id = -1;
+
+	return ret;
+}
+
+void cdns_mhdp_mst_deinit(struct cdns_mhdp_device *mhdp)
+{
+	if (mhdp->is_mst) {
+		mhdp->is_mst = false;
+		drm_dp_mst_topology_mgr_set_mst(&mhdp->mst_mgr,
+						mhdp->is_mst);
+	}
+
+	if (mhdp->can_mst)
+		drm_dp_mst_topology_mgr_destroy(&mhdp->mst_mgr);
+}
diff --git a/drivers/gpu/drm/bridge/cdns-mhdp.c b/drivers/gpu/drm/bridge/cdns-mhdp.c
new file mode 100644
index 000000000000..5fe1d7fcc596
--- /dev/null
+++ b/drivers/gpu/drm/bridge/cdns-mhdp.c
@@ -0,0 +1,1349 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence MHDP DP bridge driver.
+ *
+ * Copyright: 2018 Cadence Design Systems, Inc.
+ *
+ * Author: Quentin Schulz <quentin.schulz@free-electrons.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/firmware.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/phy/phy.h>
+
+#include <drm/bridge/cdns-mhdp-common.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_dp_helper.h>
+#include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_probe_helper.h>
+
+#include <sound/hdmi-codec.h>
+#include <linux/irq.h>
+#include <linux/of_irq.h>
+
+#include "cdns-mhdp.h"
+
+#define FW_NAME					"cadence/mhdp8546.bin"
+#define CDNS_MHDP_IMEM				0x10000
+
+#define CDNS_DP_TRAINING_PATTERN_4		0x7
+
+#define CDNS_KEEP_ALIVE_TIMEOUT			2000
+
+static const struct of_device_id mhdp_ids[] = {
+	{ .compatible = "cdns,mhdp8546", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mhdp_ids);
+
+#define CDNS_LANE_1				BIT(0)
+#define CDNS_LANE_2				BIT(1)
+#define CDNS_LANE_4				BIT(2)
+#define CDNS_SSC				BIT(3)
+#define CDNS_SCRAMBLER				BIT(4)
+
+#define CDNS_VOLT_SWING(x)			((x) & GENMASK(1, 0))
+#define CDNS_FORCE_VOLT_SWING			BIT(2)
+
+#define CDNS_PRE_EMPHASIS(x)			((x) & GENMASK(1, 0))
+#define CDNS_FORCE_PRE_EMPHASIS			BIT(2)
+
+#define CDNS_SUPPORT_TPS(x)			BIT((x) - 1)
+
+#define CDNS_FAST_LINK_TRAINING			BIT(0)
+
+#define CDNS_LANE_MAPPING_TYPE_C_LANE_0(x)	((x) & GENMASK(1, 0))
+#define CDNS_LANE_MAPPING_TYPE_C_LANE_1(x)	((x) & GENMASK(3, 2))
+#define CDNS_LANE_MAPPING_TYPE_C_LANE_2(x)	((x) & GENMASK(5, 4))
+#define CDNS_LANE_MAPPING_TYPE_C_LANE_3(x)	((x) & GENMASK(7, 6))
+#define CDNS_LANE_MAPPING_NORMAL		0xe4
+#define CDNS_LANE_MAPPING_FLIPPED		0x1b
+
+#define CDNS_DP_MAX_NUM_LANES			4
+#define CDNS_DP_TEST_VSC_SDP			(1 << 6) /* 1.3+ */
+#define CDNS_DP_TEST_COLOR_FORMAT_RAW_Y_ONLY	(1 << 7)
+
+static inline struct cdns_mhdp_device *connector_to_mhdp(
+	struct drm_connector *conn)
+{
+	struct cdns_mhdp_connector *mhdp_connector = to_mhdp_connector(conn);
+
+	return mhdp_connector->bridge->mhdp;
+}
+
+static inline struct cdns_mhdp_device *bridge_to_mhdp(
+	struct drm_bridge *bridge)
+{
+	struct cdns_mhdp_bridge *mhdp_bridge = to_mhdp_bridge(bridge);
+
+	return mhdp_bridge->mhdp;
+}
+
+static unsigned int max_link_rate(struct cdns_mhdp_host host,
+				  struct cdns_mhdp_sink sink)
+{
+	return min(host.link_rate, sink.link_rate);
+}
+
+static u8 eq_training_pattern_supported(struct cdns_mhdp_host host,
+					struct cdns_mhdp_sink sink)
+{
+	return fls(host.pattern_supp & sink.pattern_supp);
+}
+
+static void mhdp_hotplug_work_func(struct work_struct *work)
+{
+	struct cdns_mhdp_device *mhdp;
+	int dret, retry;
+	u8 esi[16] = { 0 };
+	bool new_irq_handled;
+	struct drm_connector *connector;
+	bool old_plugged;
+
+	mhdp = container_of(work, struct cdns_mhdp_device,
+			    hotplug_work.work);
+	connector = &mhdp->connector.base;
+
+	old_plugged = mhdp->plugged;
+	connector->status = connector->funcs->detect(connector, false);
+
+	if (old_plugged != mhdp->plugged) {
+		drm_kms_helper_hotplug_event(mhdp->bridge.base.dev);
+		return;
+	}
+
+	if (!mhdp->plugged)
+		return;
+
+	dret = drm_dp_dpcd_read(&mhdp->aux,
+				DP_SINK_COUNT_ESI, esi, 8);
+	if (dret == 8) {
+		drm_dp_mst_hpd_irq(&mhdp->mst_mgr,
+				   esi,
+				   &new_irq_handled);
+	}
+
+	if (!new_irq_handled)
+		return;
+
+	for (retry = 0; retry < 3; retry++) {
+		int wret;
+
+		wret = drm_dp_dpcd_write(&mhdp->aux,
+					 DP_SINK_COUNT_ESI+1,
+					 &esi[1], 3);
+		if (wret == 3)
+			break;
+	}
+}
+
+static irqreturn_t mhdp_irq_handler(int irq, void *data)
+{
+	struct cdns_mhdp_device *mhdp = (struct cdns_mhdp_device *)data;
+
+	if (readl(mhdp->regs + CDNS_SW_EVENT0) & CDNS_DPTX_HPD)
+		schedule_delayed_work(&mhdp->hotplug_work, 0);
+
+	return IRQ_HANDLED;
+}
+
+static ssize_t mhdp_transfer(struct drm_dp_aux *aux,
+			     struct drm_dp_aux_msg *msg)
+{
+	struct cdns_mhdp_device *mhdp = dev_get_drvdata(aux->dev);
+	int ret;
+
+	if (msg->request != DP_AUX_NATIVE_WRITE &&
+	    msg->request != DP_AUX_NATIVE_READ)
+		return -ENOTSUPP;
+
+	if (msg->request == DP_AUX_NATIVE_WRITE) {
+		const u8 *buf = msg->buffer;
+		int i;
+
+		for (i = 0; i < msg->size; ++i) {
+			ret = cdns_mhdp_dpcd_write(mhdp,
+						   msg->address + i, buf[i]);
+			if (!ret)
+				continue;
+
+			DRM_DEV_ERROR(mhdp->dev, "Failed to write DPCD\n");
+
+			return ret;
+		}
+	} else {
+		ret = cdns_mhdp_dpcd_read(mhdp, msg->address,
+					  msg->buffer, msg->size);
+		if (ret) {
+			DRM_DEV_ERROR(mhdp->dev, "Failed to read DPCD\n");
+
+			return ret;
+		}
+	}
+
+	return msg->size;
+}
+
+static int cdns_mhdp_get_modes(struct drm_connector *connector)
+{
+	struct cdns_mhdp_device *mhdp = connector_to_mhdp(connector);
+	struct edid *edid;
+	int num_modes;
+
+	edid = drm_do_get_edid(connector, cdns_mhdp_get_edid_block, mhdp);
+	if (!edid) {
+		DRM_DEV_ERROR(mhdp->dev, "Failed to read EDID\n");
+
+		return 0;
+	}
+
+	drm_connector_update_edid_property(connector, edid);
+	num_modes = drm_add_edid_modes(connector, edid);
+	kfree(edid);
+
+	return num_modes;
+}
+
+static const struct drm_connector_helper_funcs cdns_mhdp_conn_helper_funcs = {
+	.get_modes = cdns_mhdp_get_modes,
+};
+
+static enum drm_connector_status cdns_mhdp_detect(struct drm_connector *conn,
+						  bool force)
+{
+	struct cdns_mhdp_device *mhdp = connector_to_mhdp(conn);
+	int ret;
+
+	ret = cdns_mhdp_get_hpd_status(mhdp);
+	if (ret > 0) {
+		mhdp->plugged = true;
+		cdns_mhdp_mst_probe(mhdp);
+		// for MST mode this connector will be always disconnected
+		if (!mhdp->is_mst)
+			return connector_status_connected;
+	}
+	if (ret < 0)
+		dev_err(mhdp->dev, "Failed to obtain HPD state\n");
+
+	mhdp->plugged = false;
+
+	return connector_status_disconnected;
+}
+
+static const struct drm_connector_funcs cdns_mhdp_conn_funcs = {
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+	.reset = drm_atomic_helper_connector_reset,
+	.destroy = drm_connector_cleanup,
+	.dpms = drm_helper_connector_dpms,
+	.detect = cdns_mhdp_detect,
+};
+
+static int cdns_mhdp_attach(struct drm_bridge *bridge)
+{
+	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
+	struct drm_connector *conn = &mhdp->connector.base;
+	int ret;
+
+	if (&mhdp->bridge.base != bridge)
+		return -ENODEV;
+
+	cdns_mhdp_mst_init(mhdp);
+
+	conn->polled = DRM_CONNECTOR_POLL_HPD;
+
+	ret = drm_connector_init(bridge->dev, conn, &cdns_mhdp_conn_funcs,
+				 DRM_MODE_CONNECTOR_DisplayPort);
+	if (ret) {
+		dev_err(mhdp->dev, "failed to init connector\n");
+		return ret;
+	}
+
+	drm_connector_helper_add(conn, &cdns_mhdp_conn_helper_funcs);
+
+	ret = drm_connector_attach_encoder(conn, bridge->encoder);
+	if (ret) {
+		dev_err(mhdp->dev, "failed to attach connector to encoder\n");
+		return ret;
+	}
+
+	/* enable interrupts */
+	writel(~CDNS_APB_INT_MASK_SW_EVENT_INT, mhdp->regs + CDNS_APB_INT_MASK);
+
+	return 0;
+}
+
+static void mhdp_link_training_init(struct cdns_mhdp_device *mhdp)
+{
+	u32 reg32;
+
+	drm_dp_dpcd_writeb(&mhdp->aux, DP_TRAINING_PATTERN_SET,
+			   DP_TRAINING_PATTERN_DISABLE);
+
+	/* Reset PHY configuration */
+	reg32 = CDNS_PHY_COMMON_CONFIG | CDNS_PHY_TRAINING_TYPE(1);
+	if (!(mhdp->host.lanes_cnt & CDNS_SCRAMBLER))
+		reg32 |= CDNS_PHY_SCRAMBLER_BYPASS;
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_PHY_CONFIG, reg32);
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_ENHNCD,
+			    mhdp->sink.enhanced & mhdp->host.enhanced);
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_LANE_EN,
+			    CDNS_DP_LANE_EN_LANES(mhdp->link.num_lanes));
+
+	drm_dp_link_configure(&mhdp->aux, &mhdp->link);
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_PHY_CONFIG,
+			    CDNS_PHY_COMMON_CONFIG |
+			    CDNS_PHY_TRAINING_EN |
+			    CDNS_PHY_TRAINING_TYPE(1) |
+			    CDNS_PHY_SCRAMBLER_BYPASS);
+
+	drm_dp_dpcd_writeb(&mhdp->aux, DP_TRAINING_PATTERN_SET,
+			   DP_TRAINING_PATTERN_1 | DP_LINK_SCRAMBLING_DISABLE);
+}
+
+static void mhdp_get_adjust_train(struct cdns_mhdp_device *mhdp,
+				  u8 link_status[DP_LINK_STATUS_SIZE],
+				  u8 lanes_data[CDNS_DP_MAX_NUM_LANES])
+{
+	unsigned int i;
+	u8 adjust, max_pre_emphasis, max_volt_swing;
+
+	max_pre_emphasis = CDNS_PRE_EMPHASIS(mhdp->host.pre_emphasis)
+		<< DP_TRAIN_PRE_EMPHASIS_SHIFT;
+	max_volt_swing = CDNS_VOLT_SWING(mhdp->host.volt_swing);
+
+	for (i = 0; i < mhdp->link.num_lanes; i++) {
+		adjust = drm_dp_get_adjust_request_voltage(link_status, i);
+		lanes_data[i] = min_t(u8, adjust, max_volt_swing);
+		if (lanes_data[i] != adjust)
+			lanes_data[i] |= DP_TRAIN_MAX_SWING_REACHED;
+
+		adjust = drm_dp_get_adjust_request_pre_emphasis(link_status, i);
+		lanes_data[i] |= min_t(u8, adjust, max_pre_emphasis);
+		if ((lanes_data[i] >> DP_TRAIN_PRE_EMPHASIS_SHIFT) != adjust)
+			lanes_data[i] |= DP_TRAIN_MAX_PRE_EMPHASIS_REACHED;
+	}
+}
+
+static void mhdp_set_adjust_request_voltage(
+	u8 link_status[DP_LINK_STATUS_SIZE], int lane, u8 volt)
+{
+	int i = DP_ADJUST_REQUEST_LANE0_1 + (lane >> 1);
+	int s = ((lane & 1) ?
+		 DP_ADJUST_VOLTAGE_SWING_LANE1_SHIFT :
+		 DP_ADJUST_VOLTAGE_SWING_LANE0_SHIFT);
+	int idx = i - DP_LANE0_1_STATUS;
+
+	link_status[idx] &= ~(DP_ADJUST_VOLTAGE_SWING_LANE0_MASK << s);
+	link_status[idx] |= volt << s;
+}
+
+static void mhdp_set_adjust_request_pre_emphasis(
+	u8 link_status[DP_LINK_STATUS_SIZE], int lane, u8 pre_emphasis)
+{
+	int i = DP_ADJUST_REQUEST_LANE0_1 + (lane >> 1);
+	int s = ((lane & 1) ?
+		 DP_ADJUST_PRE_EMPHASIS_LANE1_SHIFT :
+		 DP_ADJUST_PRE_EMPHASIS_LANE0_SHIFT);
+	int idx = i - DP_LANE0_1_STATUS;
+
+	link_status[idx] &= ~(DP_ADJUST_PRE_EMPHASIS_LANE0_MASK << s);
+	link_status[idx] |= pre_emphasis << s;
+}
+
+static void mhdp_adjust_requested_eq(struct cdns_mhdp_device *mhdp,
+				     u8 link_status[DP_LINK_STATUS_SIZE])
+{
+	unsigned int i;
+	u8 pre, volt, max_pre = CDNS_VOLT_SWING(mhdp->host.volt_swing),
+	   max_volt = CDNS_PRE_EMPHASIS(mhdp->host.pre_emphasis);
+
+	for (i = 0; i < mhdp->link.num_lanes; i++) {
+		volt = drm_dp_get_adjust_request_voltage(link_status, i);
+		pre = drm_dp_get_adjust_request_pre_emphasis(link_status, i);
+		if (volt + pre > 3)
+			mhdp_set_adjust_request_voltage(link_status, i,
+							3 - pre);
+		if (mhdp->host.volt_swing & CDNS_FORCE_VOLT_SWING)
+			mhdp_set_adjust_request_voltage(link_status, i,
+							max_volt);
+		if (mhdp->host.pre_emphasis & CDNS_FORCE_PRE_EMPHASIS)
+			mhdp_set_adjust_request_pre_emphasis(link_status, i,
+							     max_pre);
+	}
+}
+
+static bool mhdp_link_training_channel_eq(struct cdns_mhdp_device *mhdp,
+					  u8 eq_tps,
+					  unsigned int training_interval)
+{
+	u8 lanes_data[CDNS_DP_MAX_NUM_LANES], fail_counter_short = 0;
+	u8 dpcd[DP_LINK_STATUS_SIZE];
+	u32 reg32;
+
+	dev_dbg(mhdp->dev, "Link training - Starting EQ phase\n");
+
+	/* Enable link training TPS[eq_tps] in PHY */
+	reg32 = CDNS_PHY_COMMON_CONFIG | CDNS_PHY_TRAINING_EN |
+		CDNS_PHY_TRAINING_TYPE(eq_tps);
+	if (eq_tps != 4)
+		reg32 |= CDNS_PHY_SCRAMBLER_BYPASS;
+	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_PHY_CONFIG, reg32);
+
+	drm_dp_dpcd_writeb(&mhdp->aux, DP_TRAINING_PATTERN_SET,
+			   (eq_tps != 4) ? eq_tps | DP_LINK_SCRAMBLING_DISABLE :
+			   CDNS_DP_TRAINING_PATTERN_4);
+
+	drm_dp_dpcd_read_link_status(&mhdp->aux, dpcd);
+
+	do {
+		mhdp_get_adjust_train(mhdp, dpcd, lanes_data);
+
+		cdns_mhdp_adjust_lt(mhdp, mhdp->link.num_lanes,
+				    training_interval, lanes_data, dpcd);
+
+		if (!drm_dp_clock_recovery_ok(dpcd, mhdp->link.num_lanes))
+			goto err;
+
+		if (drm_dp_channel_eq_ok(dpcd, mhdp->link.num_lanes)) {
+			dev_dbg(mhdp->dev,
+				"Link training: EQ phase succeeded\n");
+			return true;
+		}
+
+		fail_counter_short++;
+
+		mhdp_adjust_requested_eq(mhdp, dpcd);
+	} while (fail_counter_short < 5);
+
+err:
+	dev_dbg(mhdp->dev,
+		"Link training - EQ phase failed for %d lanes and %d rate\n",
+		mhdp->link.num_lanes, mhdp->link.rate);
+
+	return false;
+}
+
+static void mhdp_adjust_requested_cr(struct cdns_mhdp_device *mhdp,
+				     u8 link_status[DP_LINK_STATUS_SIZE],
+				     u8 *req_volt, u8 *req_pre)
+{
+	const u32 max_volt = CDNS_VOLT_SWING(mhdp->host.volt_swing),
+		  max_pre = CDNS_PRE_EMPHASIS(mhdp->host.pre_emphasis);
+	unsigned int i;
+
+	for (i = 0; i < mhdp->link.num_lanes; i++) {
+		unsigned int val;
+
+		val = mhdp->host.volt_swing & CDNS_FORCE_VOLT_SWING ?
+		      max_volt : req_volt[i];
+		mhdp_set_adjust_request_voltage(link_status, i, val);
+
+		val = mhdp->host.pre_emphasis & CDNS_FORCE_PRE_EMPHASIS ?
+		      max_pre : req_pre[i];
+		mhdp_set_adjust_request_pre_emphasis(link_status, i, val);
+	}
+}
+
+static void mhdp_validate_cr(struct cdns_mhdp_device *mhdp, bool *cr_done,
+			     bool *same_before_adjust, bool *max_swing_reached,
+			     u8 before_cr[DP_LINK_STATUS_SIZE],
+			     u8 after_cr[DP_LINK_STATUS_SIZE], u8 *req_volt,
+			     u8 *req_pre)
+{
+	const u8 max_volt = CDNS_VOLT_SWING(mhdp->host.volt_swing),
+		 max_pre = CDNS_PRE_EMPHASIS(mhdp->host.pre_emphasis);
+	bool same_pre, same_volt;
+	unsigned int i;
+
+	*same_before_adjust = false;
+	*max_swing_reached = false;
+	*cr_done = drm_dp_clock_recovery_ok(after_cr, mhdp->link.num_lanes);
+
+	for (i = 0; i < mhdp->link.num_lanes; i++) {
+		u8 tmp;
+
+		tmp = drm_dp_get_adjust_request_voltage(after_cr, i);
+		req_volt[i] = min_t(u8, tmp, max_volt);
+
+		tmp = drm_dp_get_adjust_request_pre_emphasis(after_cr, i) >>
+		      DP_TRAIN_PRE_EMPHASIS_SHIFT;
+		req_pre[i] = min_t(u8, tmp, max_pre);
+
+		same_pre = (before_cr[i] & DP_TRAIN_PRE_EMPHASIS_MASK) ==
+			   req_pre[i] << DP_TRAIN_PRE_EMPHASIS_SHIFT;
+		same_volt = (before_cr[i] & DP_TRAIN_VOLTAGE_SWING_MASK) ==
+			    req_volt[i];
+		if (same_pre && same_volt)
+			*same_before_adjust = true;
+
+		/* 3.1.5.2 in DP Standard v1.4. Table 3-1 */
+		if (!*cr_done && req_volt[i] + req_pre[i] >= 3) {
+			*max_swing_reached = true;
+			return;
+		}
+	}
+}
+
+static bool mhdp_link_training_clock_recovery(struct cdns_mhdp_device *mhdp)
+{
+	u8 lanes_data[CDNS_DP_MAX_NUM_LANES],
+	   fail_counter_short = 0, fail_counter_cr_long = 0;
+	u8 dpcd[DP_LINK_STATUS_SIZE];
+	bool cr_done;
+
+	dev_dbg(mhdp->dev, "Link training starting CR phase\n");
+
+	mhdp_link_training_init(mhdp);
+
+	drm_dp_dpcd_read_link_status(&mhdp->aux, dpcd);
+
+	do {
+		u8 requested_adjust_volt_swing[CDNS_DP_MAX_NUM_LANES] = {},
+		   requested_adjust_pre_emphasis[CDNS_DP_MAX_NUM_LANES] = {};
+		bool same_before_adjust, max_swing_reached;
+
+		mhdp_get_adjust_train(mhdp, dpcd, lanes_data);
+
+		cdns_mhdp_adjust_lt(mhdp, mhdp->link.num_lanes, 100,
+				    lanes_data, dpcd);
+
+		mhdp_validate_cr(mhdp, &cr_done, &same_before_adjust,
+				 &max_swing_reached, lanes_data, dpcd,
+				 requested_adjust_volt_swing,
+				 requested_adjust_pre_emphasis);
+
+		if (max_swing_reached)
+			goto err;
+
+		if (cr_done) {
+			dev_dbg(mhdp->dev,
+				"Link training: CR phase succeeded\n");
+			return true;
+		}
+
+		/* Not all CR_DONE bits set */
+		fail_counter_cr_long++;
+
+		if (same_before_adjust) {
+			fail_counter_short++;
+			continue;
+		}
+
+		fail_counter_short = 0;
+		/*
+		 * Voltage swing/pre-emphasis adjust requested
+		 * during CR phase
+		 */
+		mhdp_adjust_requested_cr(mhdp, dpcd,
+					 requested_adjust_volt_swing,
+					 requested_adjust_pre_emphasis);
+	} while (fail_counter_short < 5 && fail_counter_cr_long < 10);
+
+err:
+	dev_dbg(mhdp->dev,
+		"Link training: CR phase failed for %d lanes and %d rate\n",
+		mhdp->link.num_lanes, mhdp->link.rate);
+
+	return false;
+}
+
+static void lower_link_rate(struct drm_dp_link *link)
+{
+	switch (drm_dp_link_rate_to_bw_code(link->rate)) {
+	case DP_LINK_BW_2_7:
+		link->rate = drm_dp_bw_code_to_link_rate(DP_LINK_BW_1_62);
+		break;
+	case DP_LINK_BW_5_4:
+		link->rate = drm_dp_bw_code_to_link_rate(DP_LINK_BW_2_7);
+		break;
+	case DP_LINK_BW_8_1:
+		link->rate = drm_dp_bw_code_to_link_rate(DP_LINK_BW_5_4);
+		break;
+	}
+}
+
+static int mhdp_link_training(struct cdns_mhdp_device *mhdp,
+			      unsigned int video_mode,
+			      unsigned int training_interval)
+{
+	u32 reg32;
+	const u8 eq_tps = eq_training_pattern_supported(mhdp->host, mhdp->sink);
+
+	while (1) {
+		if (!mhdp_link_training_clock_recovery(mhdp)) {
+			if (drm_dp_link_rate_to_bw_code(mhdp->link.rate) !=
+			    DP_LINK_BW_1_62) {
+				dev_dbg(mhdp->dev,
+					"Reducing link rate during CR phase\n");
+				lower_link_rate(&mhdp->link);
+				drm_dp_link_configure(&mhdp->aux, &mhdp->link);
+
+				continue;
+			} else if (mhdp->link.num_lanes > 1) {
+				dev_dbg(mhdp->dev,
+					"Reducing lanes number during CR phase\n");
+				mhdp->link.num_lanes >>= 1;
+				mhdp->link.rate = max_link_rate(mhdp->host,
+								mhdp->sink);
+				drm_dp_link_configure(&mhdp->aux, &mhdp->link);
+
+				continue;
+			}
+
+			dev_dbg(mhdp->dev,
+				"Link training failed during CR phase\n");
+			goto err;
+		}
+
+		if (mhdp_link_training_channel_eq(mhdp, eq_tps,
+						  training_interval))
+			break;
+
+		if (mhdp->link.num_lanes > 1) {
+			dev_dbg(mhdp->dev,
+				"Reducing lanes number during EQ phase\n");
+			mhdp->link.num_lanes >>= 1;
+			drm_dp_link_configure(&mhdp->aux, &mhdp->link);
+
+			continue;
+		} else if (drm_dp_link_rate_to_bw_code(mhdp->link.rate) !=
+			   DP_LINK_BW_1_62) {
+			dev_dbg(mhdp->dev,
+				"Reducing link rate during EQ phase\n");
+			lower_link_rate(&mhdp->link);
+			drm_dp_link_configure(&mhdp->aux, &mhdp->link);
+
+			continue;
+		}
+
+		dev_dbg(mhdp->dev, "Link training failed during EQ phase\n");
+		goto err;
+	}
+
+	dev_dbg(mhdp->dev, "Link training successful\n");
+
+	drm_dp_dpcd_writeb(&mhdp->aux, DP_TRAINING_PATTERN_SET,
+			   (mhdp->host.lanes_cnt & CDNS_SCRAMBLER) ? 0 :
+			   DP_LINK_SCRAMBLING_DISABLE);
+
+	/* SW reset DPTX framer */
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_SW_RESET, 1);
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_SW_RESET, 0);
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG,
+			    CDNS_DP_NUM_LANES(mhdp->link.num_lanes) |
+			    CDNS_DP_DISABLE_PHY_RST |
+			    CDNS_DP_WR_FAILING_EDGE_VSYNC |
+			    (mhdp->is_mst ? CDNS_DP_MST_EN : 0) |
+			    (!video_mode ? CDNS_DP_NO_VIDEO_MODE : 0));
+
+	/* Reset PHY config */
+	reg32 = CDNS_PHY_COMMON_CONFIG | CDNS_PHY_TRAINING_TYPE(1);
+	if (!(mhdp->host.lanes_cnt & CDNS_SCRAMBLER))
+		reg32 |= CDNS_PHY_SCRAMBLER_BYPASS;
+	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_PHY_CONFIG, reg32);
+
+	return 0;
+err:
+	/* Reset PHY config */
+	reg32 = CDNS_PHY_COMMON_CONFIG | CDNS_PHY_TRAINING_TYPE(1);
+	if (!(mhdp->host.lanes_cnt & CDNS_SCRAMBLER))
+		reg32 |= CDNS_PHY_SCRAMBLER_BYPASS;
+	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_PHY_CONFIG, reg32);
+
+	drm_dp_dpcd_writeb(&mhdp->aux, DP_TRAINING_PATTERN_SET,
+			   DP_TRAINING_PATTERN_DISABLE);
+
+	return -EIO;
+}
+
+static void cdns_mhdp_disable(struct drm_bridge *bridge)
+{
+	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
+
+	cdns_mhdp_set_video_status(mhdp, 0);
+
+	mhdp->link_up = false;
+
+	drm_dp_link_power_down(&mhdp->aux, &mhdp->link);
+	if (mhdp->is_mst)
+		cdns_mhdp_mst_disable(bridge);
+}
+
+static u32 get_training_interval_us(struct cdns_mhdp_device *mhdp,
+				    u32 interval)
+{
+	if (interval == 0)
+		return 400;
+	if (interval < 5)
+		return 4000 << (interval - 1);
+	dev_err(mhdp->dev,
+		"wrong training interval returned by DPCD: %d\n", interval);
+	return 0;
+}
+
+static int cdns_mhdp_link_up(struct cdns_mhdp_device *mhdp)
+{
+	u32 resp, dp_framer_global_config, video_mode;
+	u8 reg0[DP_RECEIVER_CAP_SIZE], amp[2];
+
+	/*
+	 * Upon power-on reset/device disconnection: [2:0] bits should be 0b001
+	 * and [7:5] bits 0b000.
+	 */
+	drm_dp_dpcd_writeb(&mhdp->aux, DP_SET_POWER, 1);
+
+	drm_dp_link_probe(&mhdp->aux, &mhdp->link);
+
+	dev_dbg(mhdp->dev, "Set sink device power state via DPCD\n");
+	drm_dp_link_power_up(&mhdp->aux, &mhdp->link);
+	/* FIXME (CDNS): do we have to wait for 100ms before going on? */
+	mdelay(100);
+
+	mhdp->sink.link_rate = mhdp->link.rate;
+	mhdp->sink.lanes_cnt = mhdp->link.num_lanes;
+	mhdp->sink.enhanced = !!(mhdp->link.capabilities &
+				 DP_LINK_CAP_ENHANCED_FRAMING);
+
+	drm_dp_dpcd_read(&mhdp->aux, DP_DPCD_REV, reg0, DP_RECEIVER_CAP_SIZE);
+
+	mhdp->sink.pattern_supp = CDNS_SUPPORT_TPS(1) | CDNS_SUPPORT_TPS(2);
+	if (drm_dp_tps3_supported(reg0))
+		mhdp->sink.pattern_supp |= CDNS_SUPPORT_TPS(3);
+	if (drm_dp_tps4_supported(reg0))
+		mhdp->sink.pattern_supp |= CDNS_SUPPORT_TPS(4);
+
+	mhdp->sink.fast_link = !!(reg0[DP_MAX_DOWNSPREAD] &
+				  DP_NO_AUX_HANDSHAKE_LINK_TRAINING);
+
+	mhdp->link.rate = max_link_rate(mhdp->host, mhdp->sink);
+	mhdp->link.num_lanes = min_t(u8, mhdp->sink.lanes_cnt,
+				     mhdp->host.lanes_cnt & GENMASK(2, 0));
+	cdns_mhdp_reg_read(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG, &resp);
+
+	dp_framer_global_config = be32_to_cpu(resp);
+
+	cdns_mhdp_mst_probe(mhdp);
+	if (mhdp->is_mst)
+		dp_framer_global_config |= CDNS_DP_MST_EN;
+
+	video_mode = !(dp_framer_global_config & CDNS_DP_NO_VIDEO_MODE);
+
+	if (dp_framer_global_config & CDNS_DP_FRAMER_EN)
+		cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG,
+				    dp_framer_global_config &
+				    ~CDNS_DP_FRAMER_EN);
+
+	/* Spread AMP if required, enable 8b/10b coding */
+	amp[0] = (mhdp->host.lanes_cnt & CDNS_SSC) ? DP_SPREAD_AMP_0_5 : 0;
+	amp[1] = DP_SET_ANSI_8B10B;
+	drm_dp_dpcd_write(&mhdp->aux, DP_DOWNSPREAD_CTRL, amp, 2);
+
+	if (mhdp->host.fast_link & mhdp->sink.fast_link) {
+		/* FIXME: implement fastlink */
+		dev_dbg(mhdp->dev, "fastlink\n");
+	} else {
+		const u32 interval = reg0[DP_TRAINING_AUX_RD_INTERVAL] &
+				     DP_TRAINING_AUX_RD_MASK;
+		const u32 interval_us = get_training_interval_us(mhdp,
+								 interval);
+		if (!interval_us ||
+		    mhdp_link_training(mhdp, video_mode, interval_us)) {
+			dev_err(mhdp->dev, "Link training failed. Exiting.\n");
+			return -EIO;
+		}
+	}
+
+	mhdp->link_up = true;
+
+	return 0;
+}
+
+u32 cdns_mhdp_get_bpp(u32 bpc, enum pixel_format pxlfmt)
+{
+	u32 bpp;
+
+	switch (pxlfmt) {
+	case PIXEL_FORMAT_RGB:
+	case PIXEL_FORMAT_YCBCR_444:
+		bpp = bpc * 3;
+		break;
+	case PIXEL_FORMAT_YCBCR_422:
+		bpp = bpc * 2;
+		break;
+	case PIXEL_FORMAT_YCBCR_420:
+		bpp = bpc * 3 / 2;
+		break;
+	default:
+		bpp = bpc;
+	}
+	return bpp;
+}
+
+static int cdns_mhdp_sst_enable(struct drm_bridge *bridge)
+{
+	struct cdns_mhdp_bridge *mhdp_bridge = to_mhdp_bridge(bridge);
+	struct cdns_mhdp_device *mhdp = mhdp_bridge->mhdp;
+	u32 rate, vs, vs_f, required_bandwidth, available_bandwidth;
+	u32 bpp, tu_size = 30, line_thresh1, line_thresh2, line_thresh = 0;
+	struct drm_display_mode *mode;
+	int pxlclock;
+	enum pixel_format pxlfmt;
+	struct drm_display_info *disp_info = &mhdp->connector.base.display_info;
+
+	mode = &bridge->encoder->crtc->state->adjusted_mode;
+	pxlclock = mode->crtc_clock;
+
+	mhdp_bridge->stream_id = 0;
+
+	rate = mhdp->link.rate / 1000;
+
+	pxlfmt = cdns_mhdp_get_pxlfmt(disp_info->color_formats);
+	bpp = cdns_mhdp_get_bpp(disp_info->bpc, pxlfmt);
+
+	/* find optimal tu_size */
+	required_bandwidth = pxlclock * bpp / 8;
+	available_bandwidth = mhdp->link.num_lanes * rate;
+	do {
+		tu_size += 2;
+
+		vs_f = tu_size * required_bandwidth / available_bandwidth;
+		vs = vs_f / 1000;
+		vs_f = vs_f % 1000;
+		/*
+		 * FIXME (CDNS): downspreading?
+		 * It's unused is what I've been told.
+		 */
+	} while ((vs == 1 || ((vs_f > 850 || vs_f < 100) && vs_f != 0) ||
+		  tu_size - vs < 2) && tu_size < 64);
+
+	if (vs > 64)
+		return -EINVAL;
+
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_TU,
+			    CDNS_DP_FRAMER_TU_VS(vs) |
+			    CDNS_DP_FRAMER_TU_SIZE(tu_size) |
+			    CDNS_DP_FRAMER_TU_CNT_RST_EN);
+
+	line_thresh1 = ((vs + 1) << 5) * 8 / bpp;
+	line_thresh2 = (pxlclock << 5) / 1000 / rate * (vs + 1) - (1 << 5);
+	line_thresh = line_thresh1 - line_thresh2 / mhdp->link.num_lanes;
+	line_thresh = (line_thresh >> 5) + 2;
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_LINE_THRESH(0),
+			    line_thresh & GENMASK(5, 0));
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_STREAM_CONFIG_2(0),
+			    CDNS_DP_SC2_TU_VS_DIFF((tu_size - vs > 3) ?
+						       0 : tu_size - vs));
+
+	cdns_mhdp_configure_video(bridge);
+
+	cdns_mhdp_set_video_status(mhdp, 1);
+
+	return 0;
+}
+
+enum pixel_format cdns_mhdp_get_pxlfmt(u32 color_formats)
+{
+	/* FIXME: what about Y_ONLY? how is it handled in the kernel? */
+	if (color_formats & DRM_COLOR_FORMAT_YCRCB444)
+		return PIXEL_FORMAT_YCBCR_444;
+	if (color_formats & DRM_COLOR_FORMAT_YCRCB422)
+		return PIXEL_FORMAT_YCBCR_422;
+	if (color_formats & DRM_COLOR_FORMAT_YCRCB420)
+		return PIXEL_FORMAT_YCBCR_420;
+	return PIXEL_FORMAT_RGB;
+}
+
+void cdns_mhdp_configure_video(struct drm_bridge *bridge)
+{
+	struct cdns_mhdp_bridge *mhdp_bridge = to_mhdp_bridge(bridge);
+	struct cdns_mhdp_device *mhdp = mhdp_bridge->mhdp;
+	struct drm_display_info *disp_info;
+	unsigned int bpp,  dp_framer_sp = 0, msa_horizontal_1,
+		     msa_vertical_1, bnd_hsync2vsync, hsync2vsync_pol_ctrl,
+		     misc0 = 0, misc1 = 0, pxl_repr,
+		     front_porch, back_porch, msa_h0, msa_v0, hsync, vsync,
+		     dp_vertical_1;
+	struct drm_display_mode *mode;
+	enum pixel_format pxlfmt;
+	int pxlclock;
+	u32 tmp;
+	u8 stream_id = mhdp_bridge->stream_id;
+
+	mode = &bridge->encoder->crtc->state->adjusted_mode;
+	pxlclock = mode->crtc_clock;
+
+	disp_info = &mhdp_bridge->connector->base.display_info;
+	pxlfmt = cdns_mhdp_get_pxlfmt(disp_info->color_formats);
+
+	/* if YCBCR supported and stream not SD, use ITU709 */
+	/* FIXME: handle ITU version with YCBCR420 when supported */
+	if ((pxlfmt == PIXEL_FORMAT_YCBCR_444 ||
+	     pxlfmt == PIXEL_FORMAT_YCBCR_422) && mode->crtc_vdisplay >= 720)
+		misc0 = DP_YCBCR_COEFFICIENTS_ITU709;
+
+	bpp = cdns_mhdp_get_bpp(disp_info->bpc, pxlfmt);
+
+	switch (pxlfmt) {
+	case PIXEL_FORMAT_RGB:
+		pxl_repr = CDNS_DP_FRAMER_RGB << CDNS_DP_FRAMER_PXL_FORMAT;
+		misc0 |= DP_COLOR_FORMAT_RGB;
+		break;
+	case PIXEL_FORMAT_YCBCR_444:
+		pxl_repr = CDNS_DP_FRAMER_YCBCR444 << CDNS_DP_FRAMER_PXL_FORMAT;
+		misc0 |= DP_COLOR_FORMAT_YCbCr444 | DP_TEST_DYNAMIC_RANGE_CEA;
+		break;
+	case PIXEL_FORMAT_YCBCR_422:
+		pxl_repr = CDNS_DP_FRAMER_YCBCR422 << CDNS_DP_FRAMER_PXL_FORMAT;
+		misc0 |= DP_COLOR_FORMAT_YCbCr422 | DP_TEST_DYNAMIC_RANGE_CEA;
+		break;
+	case PIXEL_FORMAT_YCBCR_420:
+		pxl_repr = CDNS_DP_FRAMER_YCBCR420 << CDNS_DP_FRAMER_PXL_FORMAT;
+		break;
+	default:
+		pxl_repr = CDNS_DP_FRAMER_Y_ONLY << CDNS_DP_FRAMER_PXL_FORMAT;
+	}
+
+	switch (disp_info->bpc) {
+	case 6:
+		misc0 |= DP_TEST_BIT_DEPTH_6;
+		pxl_repr |= CDNS_DP_FRAMER_6_BPC;
+		break;
+	case 8:
+		misc0 |= DP_TEST_BIT_DEPTH_8;
+		pxl_repr |= CDNS_DP_FRAMER_8_BPC;
+		break;
+	case 10:
+		misc0 |= DP_TEST_BIT_DEPTH_10;
+		pxl_repr |= CDNS_DP_FRAMER_10_BPC;
+		break;
+	case 12:
+		misc0 |= DP_TEST_BIT_DEPTH_12;
+		pxl_repr |= CDNS_DP_FRAMER_12_BPC;
+		break;
+	case 16:
+		misc0 |= DP_TEST_BIT_DEPTH_16;
+		pxl_repr |= CDNS_DP_FRAMER_16_BPC;
+		break;
+	}
+
+	bnd_hsync2vsync = CDNS_IP_BYPASS_V_INTERFACE;
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+		bnd_hsync2vsync |= CDNS_IP_DET_INTERLACE_FORMAT;
+
+	cdns_mhdp_reg_write(mhdp, CDNS_BND_HSYNC2VSYNC(stream_id),
+			    bnd_hsync2vsync);
+
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE &&
+	    mode->flags & DRM_MODE_FLAG_PHSYNC)
+		hsync2vsync_pol_ctrl = CDNS_H2V_HSYNC_POL_ACTIVE_LOW |
+			CDNS_H2V_VSYNC_POL_ACTIVE_LOW;
+	else
+		hsync2vsync_pol_ctrl = 0;
+
+	cdns_mhdp_reg_write(mhdp, CDNS_HSYNC2VSYNC_POL_CTRL(stream_id),
+			    hsync2vsync_pol_ctrl);
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_PXL_REPR(stream_id), pxl_repr);
+
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+		dp_framer_sp |= CDNS_DP_FRAMER_INTERLACE;
+	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
+		dp_framer_sp |= CDNS_DP_FRAMER_HSYNC_POL_LOW;
+	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
+		dp_framer_sp |= CDNS_DP_FRAMER_VSYNC_POL_LOW;
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_SP(stream_id), dp_framer_sp);
+
+	front_porch = mode->crtc_hsync_start - mode->crtc_hdisplay;
+	back_porch = mode->crtc_htotal - mode->crtc_hsync_end;
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRONT_BACK_PORCH(stream_id),
+			    CDNS_DP_FRONT_PORCH(front_porch) |
+			    CDNS_DP_BACK_PORCH(back_porch));
+
+		cdns_mhdp_reg_write(mhdp, CDNS_DP_BYTE_COUNT(stream_id),
+			    mode->crtc_hdisplay * bpp / 8);
+
+	msa_h0 = mode->crtc_htotal - mode->crtc_hsync_start;
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_HORIZONTAL_0(stream_id),
+			    CDNS_DP_MSAH0_H_TOTAL(mode->crtc_htotal) |
+			    CDNS_DP_MSAH0_HSYNC_START(msa_h0));
+
+	hsync = mode->crtc_hsync_end - mode->crtc_hsync_start;
+	msa_horizontal_1 = CDNS_DP_MSAH1_HSYNC_WIDTH(hsync) |
+		CDNS_DP_MSAH1_HDISP_WIDTH(mode->crtc_hdisplay);
+	if (mode->flags & DRM_MODE_FLAG_NHSYNC)
+		msa_horizontal_1 |= CDNS_DP_MSAH1_HSYNC_POL_LOW;
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_HORIZONTAL_1(stream_id),
+			    msa_horizontal_1);
+
+	msa_v0 = mode->crtc_vtotal - mode->crtc_vsync_start;
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_VERTICAL_0(stream_id),
+			    CDNS_DP_MSAV0_V_TOTAL(mode->crtc_vtotal) |
+			    CDNS_DP_MSAV0_VSYNC_START(msa_v0));
+
+	vsync = mode->crtc_vsync_end - mode->crtc_vsync_start;
+	msa_vertical_1 = CDNS_DP_MSAV1_VSYNC_WIDTH(vsync) |
+		CDNS_DP_MSAV1_VDISP_WIDTH(mode->crtc_vdisplay);
+	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
+		msa_vertical_1 |= CDNS_DP_MSAV1_VSYNC_POL_LOW;
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_VERTICAL_1(stream_id),
+			    msa_vertical_1);
+
+	if ((mode->flags & DRM_MODE_FLAG_INTERLACE) &&
+	    mode->crtc_vtotal % 2 == 0)
+		misc1 = DP_TEST_INTERLACED;
+	if (pxlfmt == PIXEL_FORMAT_Y_ONLY)
+		misc1 |= CDNS_DP_TEST_COLOR_FORMAT_RAW_Y_ONLY;
+	/* FIXME: use VSC SDP for Y420 */
+	/* FIXME: (CDNS) no code for Y420 in bare metal test */
+	if (pxlfmt == PIXEL_FORMAT_YCBCR_420)
+		misc1 = CDNS_DP_TEST_VSC_SDP;
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_MSA_MISC(stream_id),
+			    misc0 | (misc1 << 8));
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_HORIZONTAL(stream_id),
+			    CDNS_DP_H_HSYNC_WIDTH(hsync) |
+			    CDNS_DP_H_H_TOTAL(mode->crtc_hdisplay));
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_VERTICAL_0(stream_id),
+			    CDNS_DP_V0_VHEIGHT(mode->crtc_vdisplay) |
+			    CDNS_DP_V0_VSTART(msa_v0));
+
+	dp_vertical_1 = CDNS_DP_V1_VTOTAL(mode->crtc_vtotal);
+	if ((mode->flags & DRM_MODE_FLAG_INTERLACE) &&
+	    mode->crtc_vtotal % 2 == 0)
+		dp_vertical_1 |= CDNS_DP_V1_VTOTAL_EVEN;
+
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_VERTICAL_1(stream_id), dp_vertical_1);
+
+	cdns_mhdp_reg_write_bit(mhdp, CDNS_DP_VB_ID(stream_id), 2, 1,
+				(mode->flags & DRM_MODE_FLAG_INTERLACE) ?
+				CDNS_DP_VB_ID_INTERLACED : 0);
+
+
+	cdns_mhdp_reg_read(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG, &tmp);
+	tmp |= CDNS_DP_FRAMER_EN;
+	cdns_mhdp_reg_write(mhdp, CDNS_DP_FRAMER_GLOBAL_CONFIG, tmp);
+}
+
+void cdns_mhdp_enable(struct drm_bridge *bridge)
+{
+	struct cdns_mhdp_bridge *mhdp_bridge = to_mhdp_bridge(bridge);
+	struct cdns_mhdp_device *mhdp = mhdp_bridge->mhdp;
+
+	if (!mhdp->link_up)
+		cdns_mhdp_link_up(mhdp);
+
+	if (mhdp->is_mst)
+		cdns_mhdp_mst_enable(bridge);
+	else
+		cdns_mhdp_sst_enable(bridge);
+}
+
+static void cdns_mhdp_detach(struct drm_bridge *bridge)
+{
+	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
+	struct cdns_mhdp_mst_cbs cbs_null = { 0 };
+
+	cdns_mhdp_mst_deinit(mhdp);
+	mhdp->cbs = cbs_null;
+}
+
+static const struct drm_bridge_funcs cdns_mhdp_bridge_funcs = {
+	.enable = cdns_mhdp_enable,
+	.disable = cdns_mhdp_disable,
+	.attach = cdns_mhdp_attach,
+	.detach = cdns_mhdp_detach,
+};
+
+static int load_firmware(struct cdns_mhdp_device *mhdp, const char *name,
+			 unsigned int addr)
+{
+	const struct firmware *fw;
+	int ret;
+
+	ret = request_firmware(&fw, name, mhdp->dev);
+	if (ret) {
+		dev_err(mhdp->dev, "failed to load firmware (%s), ret: %d\n",
+			name, ret);
+		return ret;
+	}
+
+	memcpy_toio(mhdp->regs + addr, fw->data, fw->size);
+
+	release_firmware(fw);
+
+	return 0;
+}
+
+static int cdns_mhdp_audio_hw_params(struct device *dev, void *data,
+				     struct hdmi_codec_daifmt *daifmt,
+				     struct hdmi_codec_params *params)
+{
+	struct cdns_mhdp_device *mhdp = dev_get_drvdata(dev);
+	struct audio_info audio = {
+		.sample_width = params->sample_width,
+		.sample_rate = params->sample_rate,
+		.channels = params->channels,
+	};
+	int ret;
+
+	if (daifmt->fmt != HDMI_I2S) {
+		DRM_DEV_ERROR(dev, "Invalid format %d\n", daifmt->fmt);
+		return -EINVAL;
+	}
+
+	audio.format = AFMT_I2S;
+
+	ret = cdns_mhdp_audio_config(mhdp, &audio);
+	if (!ret)
+		mhdp->audio_info = audio;
+
+	return 0;
+}
+
+static void cdns_mhdp_audio_shutdown(struct device *dev, void *data)
+{
+	struct cdns_mhdp_device *mhdp = dev_get_drvdata(dev);
+	int ret;
+
+	ret = cdns_mhdp_audio_stop(mhdp, &mhdp->audio_info);
+	if (!ret)
+		mhdp->audio_info.format = AFMT_UNUSED;
+}
+
+static int cdns_mhdp_audio_digital_mute(struct device *dev, void *data,
+					bool enable)
+{
+	struct cdns_mhdp_device *mhdp = dev_get_drvdata(dev);
+
+	return cdns_mhdp_audio_mute(mhdp, enable);
+}
+
+static int cdns_mhdp_audio_get_eld(struct device *dev, void *data,
+				   u8 *buf, size_t len)
+{
+	struct cdns_mhdp_device *mhdp = dev_get_drvdata(dev);
+
+	memcpy(buf, mhdp->connector.base.eld,
+	       min(sizeof(mhdp->connector.base.eld), len));
+
+	return 0;
+}
+
+static const struct hdmi_codec_ops audio_codec_ops = {
+	.hw_params = cdns_mhdp_audio_hw_params,
+	.audio_shutdown = cdns_mhdp_audio_shutdown,
+	.digital_mute = cdns_mhdp_audio_digital_mute,
+	.get_eld = cdns_mhdp_audio_get_eld,
+};
+
+static int mhdp_probe(struct platform_device *pdev)
+{
+	struct resource *regs;
+	struct cdns_mhdp_device *mhdp;
+	struct clk *clk;
+	int ret;
+	unsigned int reg;
+	unsigned long rate;
+	u32 resp;
+	int irq;
+
+	struct hdmi_codec_pdata codec_data = {
+		.i2s = 1,
+		.max_i2s_channels = 8,
+		.ops = &audio_codec_ops,
+	};
+
+	mhdp = devm_kzalloc(&pdev->dev, sizeof(struct cdns_mhdp_device),
+			    GFP_KERNEL);
+	if (!mhdp)
+		return -ENOMEM;
+
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "couldn't get clk: %ld\n", PTR_ERR(clk));
+		return PTR_ERR(clk);
+	}
+
+	mhdp->dev = &pdev->dev;
+	dev_set_drvdata(&pdev->dev, mhdp);
+
+	drm_dp_aux_init(&mhdp->aux);
+	mhdp->aux.dev = &pdev->dev;
+	mhdp->aux.transfer = mhdp_transfer;
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mhdp->regs = devm_ioremap_resource(&pdev->dev, regs);
+	if (IS_ERR(mhdp->regs))
+		return PTR_ERR(mhdp->regs);
+
+	mhdp->phy = devm_phy_get(&pdev->dev, "dpphy");
+	if (IS_ERR(mhdp->phy)) {
+		dev_err(&pdev->dev, "no PHY configured\n");
+		return PTR_ERR(mhdp->phy);
+	}
+
+	platform_set_drvdata(pdev, mhdp);
+
+	ret = load_firmware(mhdp, FW_NAME, CDNS_MHDP_IMEM);
+	if (ret)
+		return ret;
+
+	rate = clk_get_rate(clk);
+	writel(rate % 1000000, mhdp->regs + CDNS_SW_CLK_L);
+	writel(rate / 1000000, mhdp->regs + CDNS_SW_CLK_H);
+
+	/* Leave debug mode */
+	writel(0, mhdp->regs + CDNS_APB_CTRL);
+
+	irq = platform_get_irq(pdev, 0);
+	ret = devm_request_irq(mhdp->dev, irq, mhdp_irq_handler, 0,
+			       "mhdp8546", mhdp);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"cannot install IRQ %d\n", irq);
+		return -EIO;
+	}
+
+	/*
+	 * Wait for the KEEP_ALIVE "message" on the first 8 bits.
+	 * Updated each sched "tick" (~2ms)
+	 */
+	ret = readl_poll_timeout(mhdp->regs + CDNS_KEEP_ALIVE, reg,
+				 reg & CDNS_KEEP_ALIVE_MASK, 500,
+				 CDNS_KEEP_ALIVE_TIMEOUT);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"device didn't give any life sign: reg %d\n", reg);
+		return -EIO;
+	}
+
+	/*
+	 * FIXME (CDNS): how are the characteristics/features of the host
+	 * defined? Will they be always hardcoded?
+	 */
+	/* FIXME: link rate 2.7; num_lanes = 2,	 */
+	/* FIXME: read capabilities from PHY */
+	mhdp->host.link_rate = drm_dp_bw_code_to_link_rate(DP_LINK_BW_5_4);
+	mhdp->host.lanes_cnt = CDNS_LANE_4 | CDNS_SCRAMBLER;
+	mhdp->host.volt_swing = CDNS_VOLT_SWING(3);
+	mhdp->host.pre_emphasis = CDNS_PRE_EMPHASIS(2);
+	mhdp->host.pattern_supp = CDNS_SUPPORT_TPS(1) |
+		CDNS_SUPPORT_TPS(2) | CDNS_SUPPORT_TPS(3) |
+		CDNS_SUPPORT_TPS(4);
+	mhdp->host.fast_link = 0;
+	mhdp->host.lane_mapping = CDNS_LANE_MAPPING_FLIPPED;
+	mhdp->host.enhanced = true;
+
+	mhdp->bridge.base.of_node = pdev->dev.of_node;
+	mhdp->bridge.base.funcs = &cdns_mhdp_bridge_funcs;
+
+	/* Init events to 0 as it's not cleared by FW at boot but on read */
+	readl(mhdp->regs + CDNS_SW_EVENT0);
+	readl(mhdp->regs + CDNS_SW_EVENT1);
+	readl(mhdp->regs + CDNS_SW_EVENT2);
+	readl(mhdp->regs + CDNS_SW_EVENT3);
+
+	/* Activate uCPU */
+	ret = cdns_mhdp_set_firmware_active(mhdp, true);
+	if (ret) {
+		dev_err(mhdp->dev, "Failed to activate DP\n");
+		return ret;
+	}
+
+	mhdp->audio_pdev = platform_device_register_data(
+			   mhdp->dev, HDMI_CODEC_DRV_NAME, PLATFORM_DEVID_AUTO,
+			   &codec_data, sizeof(codec_data));
+
+	phy_init(mhdp->phy);
+
+	/* Enable VIF clock for stream 0 */
+	cdns_mhdp_reg_read(mhdp, CDNS_DPTX_CAR, &resp);
+	cdns_mhdp_reg_write(mhdp, CDNS_DPTX_CAR,
+			    resp | CDNS_VIF_CLK_EN | CDNS_VIF_CLK_RSTN);
+
+	INIT_DELAYED_WORK(&mhdp->hotplug_work, mhdp_hotplug_work_func);
+
+	mhdp->bridge.connector = &mhdp->connector;
+	mhdp->connector.bridge = &mhdp->bridge;
+	mhdp->bridge.mhdp = mhdp;
+	mhdp->bridge.is_active = false;
+
+	drm_bridge_add(&mhdp->bridge.base);
+
+	return 0;
+}
+
+MODULE_FIRMWARE(FW_NAME);
+
+static int mhdp_remove(struct platform_device *pdev)
+{
+	struct cdns_mhdp_device *mhdp = dev_get_drvdata(&pdev->dev);
+	int ret;
+
+	flush_delayed_work(&mhdp->hotplug_work);
+	platform_device_unregister(mhdp->audio_pdev);
+
+	cdns_mhdp_mst_deinit(mhdp);
+	drm_bridge_remove(&mhdp->bridge.base);
+
+	ret = cdns_mhdp_set_firmware_active(mhdp, false);
+	if (ret) {
+		dev_err(mhdp->dev, "Failed to de-activate DP\n");
+		return ret;
+	}
+
+	/* FIXME: check for missing functions */
+
+	return 0;
+}
+
+int mhdp_bridge_attach_mst_cbs(struct drm_bridge *bridge,
+			       struct cdns_mhdp_mst_cbs *cbs)
+{
+	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
+
+	mhdp->cbs = *cbs;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mhdp_bridge_attach_mst_cbs);
+
+static struct platform_driver mhdp_driver = {
+	.driver	= {
+		.name		= "cdns-mhdp",
+		.of_match_table	= of_match_ptr(mhdp_ids),
+	},
+	.probe	= mhdp_probe,
+	.remove	= mhdp_remove,
+};
+module_platform_driver(mhdp_driver);
+
+MODULE_AUTHOR("Quentin Schulz <quentin.schulz@free-electrons.com>");
+MODULE_AUTHOR("Przemyslaw Gaj <pgaj@cadence.com>");
+MODULE_AUTHOR("Damian Kos <dkos@cadence.com>");
+MODULE_AUTHOR("Piotr Sroka <piotrs@cadence.com>");
+MODULE_DESCRIPTION("Cadence MHDP DP bridge driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:cdns-mhdp");
diff --git a/drivers/gpu/drm/bridge/cdns-mhdp.h b/drivers/gpu/drm/bridge/cdns-mhdp.h
new file mode 100644
index 000000000000..399c3f6f86ad
--- /dev/null
+++ b/drivers/gpu/drm/bridge/cdns-mhdp.h
@@ -0,0 +1,209 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Cadence MHDP DP MST bridge driver.
+ *
+ * Copyright: 2018 Cadence Design Systems, Inc.
+ *
+ * Author: Quentin Schulz <quentin.schulz@free-electrons.com>
+ */
+
+
+#ifndef CDNS_MHDP_H
+#define CDNS_MHDP_H
+
+#include <drm/drm_dp_mst_helper.h>
+
+#define CDNS_APB_CFG				0x00000
+#define CDNS_APB_CTRL				(CDNS_APB_CFG + 0x00)
+#define CDNS_MAILBOX_FULL			(CDNS_APB_CFG + 0x08)
+#define CDNS_MAILBOX_EMPTY			(CDNS_APB_CFG + 0x0c)
+#define CDNS_MAILBOX_TX_DATA			(CDNS_APB_CFG + 0x10)
+#define CDNS_MAILBOX_RX_DATA			(CDNS_APB_CFG + 0x14)
+#define CDNS_KEEP_ALIVE				(CDNS_APB_CFG + 0x18)
+#define CDNS_KEEP_ALIVE_MASK			GENMASK(7, 0)
+
+#define CDNS_MB_INT_MASK			(CDNS_APB_CFG + 0x34)
+
+#define CDNS_SW_CLK_L				(CDNS_APB_CFG + 0x3c)
+#define CDNS_SW_CLK_H				(CDNS_APB_CFG + 0x40)
+#define CDNS_SW_EVENT0				(CDNS_APB_CFG + 0x44)
+#define CDNS_DPTX_HPD				BIT(0)
+
+#define CDNS_SW_EVENT1				(CDNS_APB_CFG + 0x48)
+#define CDNS_SW_EVENT2				(CDNS_APB_CFG + 0x4c)
+#define CDNS_SW_EVENT3				(CDNS_APB_CFG + 0x50)
+
+#define CDNS_APB_INT_MASK			(CDNS_APB_CFG + 0x6C)
+#define CDNS_APB_INT_MASK_MAILBOX_INT		BIT(0)
+#define CDNS_APB_INT_MASK_SW_EVENT_INT		BIT(1)
+
+#define CDNS_DPTX_CAR				(CDNS_APB_CFG + 0x904)
+#define CDNS_VIF_CLK_EN				BIT(0)
+#define CDNS_VIF_CLK_RSTN			BIT(1)
+
+#define CDNS_SOURCE_VIDEO_IF(s)			(0x00b00 + (s * 0x20))
+#define CDNS_BND_HSYNC2VSYNC(s)			(CDNS_SOURCE_VIDEO_IF(s) + \
+						 0x00)
+#define CDNS_IP_DTCT_WIN			GENMASK(11, 0)
+#define CDNS_IP_DET_INTERLACE_FORMAT		BIT(12)
+#define CDNS_IP_BYPASS_V_INTERFACE		BIT(13)
+
+#define CDNS_HSYNC2VSYNC_POL_CTRL(s)		(CDNS_SOURCE_VIDEO_IF(s) + \
+						 0x10)
+#define CDNS_H2V_HSYNC_POL_ACTIVE_LOW		BIT(1)
+#define CDNS_H2V_VSYNC_POL_ACTIVE_LOW		BIT(2)
+
+#define CDNS_DPTX_PHY_CONFIG			0x02000
+#define CDNS_PHY_TRAINING_EN			BIT(0)
+#define CDNS_PHY_TRAINING_TYPE(x)		(((x) & GENMASK(3, 0)) << 1)
+#define CDNS_PHY_SCRAMBLER_BYPASS		BIT(5)
+#define CDNS_PHY_ENCODER_BYPASS			BIT(6)
+#define CDNS_PHY_SKEW_BYPASS			BIT(7)
+#define CDNS_PHY_TRAINING_AUTO			BIT(8)
+#define CDNS_PHY_LANE0_SKEW(x)			(((x) & GENMASK(2, 0)) << 9)
+#define CDNS_PHY_LANE1_SKEW(x)			(((x) & GENMASK(2, 0)) << 12)
+#define CDNS_PHY_LANE2_SKEW(x)			(((x) & GENMASK(2, 0)) << 15)
+#define CDNS_PHY_LANE3_SKEW(x)			(((x) & GENMASK(2, 0)) << 18)
+#define CDNS_PHY_COMMON_CONFIG			(CDNS_PHY_LANE1_SKEW(1) | \
+						CDNS_PHY_LANE2_SKEW(2) |  \
+						CDNS_PHY_LANE3_SKEW(3))
+#define CDNS_PHY_10BIT_EN			BIT(21)
+
+#define CDNS_DPTX_FRAMER			0x02200
+#define CDNS_DP_FRAMER_GLOBAL_CONFIG		(CDNS_DPTX_FRAMER + 0x00)
+#define CDNS_DP_NUM_LANES(x)			(x - 1)
+#define CDNS_DP_MST_EN				BIT(2)
+#define CDNS_DP_FRAMER_EN			BIT(3)
+#define CDNS_DP_RATE_GOVERNOR_EN		BIT(4)
+#define CDNS_DP_NO_VIDEO_MODE			BIT(5)
+#define CDNS_DP_DISABLE_PHY_RST			BIT(6)
+#define CDNS_DP_WR_FAILING_EDGE_VSYNC		BIT(7)
+
+#define CDNS_DP_SW_RESET			(CDNS_DPTX_FRAMER + 0x04)
+#define CDNS_DP_FRAMER_TU			(CDNS_DPTX_FRAMER + 0x08)
+#define CDNS_DP_FRAMER_TU_SIZE(x)		(((x) & GENMASK(6, 0)) << 8)
+#define CDNS_DP_FRAMER_TU_VS(x)			((x) & GENMASK(5, 0))
+#define CDNS_DP_FRAMER_TU_CNT_RST_EN		BIT(15)
+
+#define CDNS_DPTX_STREAM(s)			(0x03000 + s * 0x80)
+#define CDNS_DP_MSA_HORIZONTAL_0(s)		(CDNS_DPTX_STREAM(s) + 0x00)
+#define CDNS_DP_MSAH0_H_TOTAL(x)		(x)
+#define CDNS_DP_MSAH0_HSYNC_START(x)		((x) << 16)
+
+#define CDNS_DP_MSA_HORIZONTAL_1(s)		(CDNS_DPTX_STREAM(s) + 0x04)
+#define CDNS_DP_MSAH1_HSYNC_WIDTH(x)		(x)
+#define CDNS_DP_MSAH1_HSYNC_POL_LOW		BIT(15)
+#define CDNS_DP_MSAH1_HDISP_WIDTH(x)		((x) << 16)
+
+#define CDNS_DP_MSA_VERTICAL_0(s)		(CDNS_DPTX_STREAM(s) + 0x08)
+#define CDNS_DP_MSAV0_V_TOTAL(x)		(x)
+#define CDNS_DP_MSAV0_VSYNC_START(x)		((x) << 16)
+
+#define CDNS_DP_MSA_VERTICAL_1(s)		(CDNS_DPTX_STREAM(s) + 0x0c)
+#define CDNS_DP_MSAV1_VSYNC_WIDTH(x)		(x)
+#define CDNS_DP_MSAV1_VSYNC_POL_LOW		BIT(15)
+#define CDNS_DP_MSAV1_VDISP_WIDTH(x)		((x) << 16)
+
+#define CDNS_DP_MSA_MISC(s)			(CDNS_DPTX_STREAM(s) + 0x10)
+#define CDNS_DP_STREAM_CONFIGs(s)		(CDNS_DPTX_STREAM(s) + 0x14)
+#define CDNS_DP_STREAM_CONFIG_2(s)		(CDNS_DPTX_STREAM(s) + 0x2c)
+#define CDNS_DP_SC2_TU_VS_DIFF(x)		((x) << 8)
+
+#define CDNS_DP_HORIZONTAL(s)			(CDNS_DPTX_STREAM(s) + 0x30)
+#define CDNS_DP_H_HSYNC_WIDTH(x)		(x)
+#define CDNS_DP_H_H_TOTAL(x)			((x) << 16)
+
+#define CDNS_DP_VERTICAL_0(s)			(CDNS_DPTX_STREAM(s) + 0x34)
+#define CDNS_DP_V0_VHEIGHT(x)			(x)
+#define CDNS_DP_V0_VSTART(x)			((x) << 16)
+
+#define CDNS_DP_VERTICAL_1(s)			(CDNS_DPTX_STREAM(s) + 0x38)
+#define CDNS_DP_V1_VTOTAL(x)			(x)
+#define CDNS_DP_V1_VTOTAL_EVEN			BIT(16)
+
+#define CDNS_DP_FRAMER_PXL_REPR(s)		(CDNS_DPTX_STREAM(s) + 0x4c)
+#define CDNS_DP_FRAMER_6_BPC			BIT(0)
+#define CDNS_DP_FRAMER_8_BPC			BIT(1)
+#define CDNS_DP_FRAMER_10_BPC			BIT(2)
+#define CDNS_DP_FRAMER_12_BPC			BIT(3)
+#define CDNS_DP_FRAMER_16_BPC			BIT(4)
+#define CDNS_DP_FRAMER_PXL_FORMAT		0x8
+#define CDNS_DP_FRAMER_RGB			BIT(0)
+#define CDNS_DP_FRAMER_YCBCR444			BIT(1)
+#define CDNS_DP_FRAMER_YCBCR422			BIT(2)
+#define CDNS_DP_FRAMER_YCBCR420			BIT(3)
+#define CDNS_DP_FRAMER_Y_ONLY			BIT(4)
+
+#define CDNS_DP_FRAMER_SP(s)			(CDNS_DPTX_STREAM(s) + 0x10)
+#define CDNS_DP_FRAMER_VSYNC_POL_LOW		BIT(0)
+#define CDNS_DP_FRAMER_HSYNC_POL_LOW		BIT(1)
+#define CDNS_DP_FRAMER_INTERLACE		BIT(2)
+
+#define CDNS_DP_LINE_THRESH(s)			(CDNS_DPTX_STREAM(s) + 0x64)
+#define CDNS_DP_ACTIVE_LINE_THRESH(x)		(x)
+
+#define CDNS_DP_VB_ID(s)			(CDNS_DPTX_STREAM(s) + 0x68)
+#define CDNS_DP_VB_ID_INTERLACED		BIT(2)
+#define CDNS_DP_VB_ID_COMPRESSED		BIT(6)
+
+#define CDNS_DP_FRONT_BACK_PORCH(s)		(CDNS_DPTX_STREAM(s) + 0x78)
+#define CDNS_DP_BACK_PORCH(x)			(x)
+#define CDNS_DP_FRONT_PORCH(x)			((x) << 16)
+
+#define CDNS_DP_BYTE_COUNT(s)			(CDNS_DPTX_STREAM(s) + 0x7c)
+#define CDNS_DP_BYTE_COUNT_BYTES_IN_CHUNK_SHIFT	16
+
+#define CDNS_DP_MST_STREAM_CONFIG(s)		(CDNS_DPTX_STREAM(s) + 0x14)
+#define CDNS_DP_MST_STRM_CFG_STREAM_EN		BIT(0)
+#define CDNS_DP_MST_STRM_CFG_NO_VIDEO		BIT(1)
+
+#define CDNS_DP_MST_SLOT_ALLOCATE(s)		(CDNS_DPTX_STREAM(s) + 0x44)
+#define CDNS_DP_S_ALLOC_START_SLOT(x)		(x)
+#define CDNS_DP_S_ALLOC_END_SLOT(x)		((x) << 8)
+
+#define CDNS_DP_RATE_GOVERNING(s)		(CDNS_DPTX_STREAM(s) + 0x48)
+#define CDNS_DP_RG_TARG_AV_SLOTS_Y(x)		(x)
+#define CDNS_DP_RG_TARG_AV_SLOTS_X(x)		(x << 4)
+#define CDNS_DP_RG_ENABLE			BIT(10)
+
+#define CDNS_DP_MTPH_CONTROL			0x2264
+#define CDNS_DP_MTPH_ECF_EN			BIT(0)
+#define CDNS_DP_MTPH_ACT_EN			BIT(1)
+#define CDNS_DP_MTPH_LVP_EN			BIT(2)
+
+#define CDNS_DP_MTPH_STATUS			0x226C
+#define CDNS_DP_MTPH_ACT_STATUS			BIT(0)
+
+
+#define CDNS_DPTX_GLOBAL			0x02300
+#define CDNS_DP_LANE_EN				(CDNS_DPTX_GLOBAL + 0x00)
+#define CDNS_DP_LANE_EN_LANES(x)		GENMASK(x - 1, 0)
+#define CDNS_DP_ENHNCD				(CDNS_DPTX_GLOBAL + 0x04)
+
+
+#define to_mhdp_connector(x) container_of(x, struct cdns_mhdp_connector, base)
+#define to_mhdp_bridge(x) container_of(x, struct cdns_mhdp_bridge, base)
+#define mgr_to_mhdp(x) container_of(x, struct cdns_mhdp_device, mst_mgr)
+
+#define CDNS_MHDP_MAX_STREAMS   4
+
+enum pixel_format {
+	PIXEL_FORMAT_RGB = 1,
+	PIXEL_FORMAT_YCBCR_444 = 2,
+	PIXEL_FORMAT_YCBCR_422 = 4,
+	PIXEL_FORMAT_YCBCR_420 = 8,
+	PIXEL_FORMAT_Y_ONLY = 16,
+};
+
+
+int cdns_mhdp_mst_init(struct cdns_mhdp_device *mhdp);
+void cdns_mhdp_mst_deinit(struct cdns_mhdp_device *mhdp);
+bool cdns_mhdp_mst_probe(struct cdns_mhdp_device *mhdp);
+enum pixel_format cdns_mhdp_get_pxlfmt(u32 color_formats);
+u32 cdns_mhdp_get_bpp(u32 bpc, u32 color_formats);
+void cdns_mhdp_configure_video(struct drm_bridge *bridge);
+void cdns_mhdp_mst_enable(struct drm_bridge *bridge);
+void cdns_mhdp_mst_disable(struct drm_bridge *bridge);
+void cdns_mhdp_enable(struct drm_bridge *bridge);
+
+#endif
diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 1e75196f9659..069fb8725927 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -28,7 +28,9 @@ config ROCKCHIP_ANALOGIX_DP
 
 config ROCKCHIP_CDN_DP
         bool "Rockchip cdn DP"
-	depends on EXTCON=y || (EXTCON=m && DRM_ROCKCHIP=m)
+	depends on DRM_ROCKCHIP
+	select EXTCON
+	select DRM_CDNS_MHDP
         help
 	  This selects support for Rockchip SoC specific extensions
 	  for the cdn DP driver. If you want to enable Dp on
diff --git a/drivers/gpu/drm/rockchip/Makefile b/drivers/gpu/drm/rockchip/Makefile
index f6fc9d5dd0ad..0f4de0681bc0 100644
--- a/drivers/gpu/drm/rockchip/Makefile
+++ b/drivers/gpu/drm/rockchip/Makefile
@@ -9,7 +9,7 @@ rockchipdrm-y := rockchip_drm_drv.o rockchip_drm_fb.o \
 rockchipdrm-$(CONFIG_DRM_FBDEV_EMULATION) += rockchip_drm_fbdev.o
 
 rockchipdrm-$(CONFIG_ROCKCHIP_ANALOGIX_DP) += analogix_dp-rockchip.o
-rockchipdrm-$(CONFIG_ROCKCHIP_CDN_DP) += cdn-dp-core.o cdn-dp-reg.o
+rockchipdrm-$(CONFIG_ROCKCHIP_CDN_DP) += cdn-dp-core.o
 rockchipdrm-$(CONFIG_ROCKCHIP_DW_HDMI) += dw_hdmi-rockchip.o
 rockchipdrm-$(CONFIG_ROCKCHIP_DW_MIPI_DSI) += dw-mipi-dsi-rockchip.o
 rockchipdrm-$(CONFIG_ROCKCHIP_INNO_HDMI) += inno_hdmi.o
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 2026bc7ffcce..54989f1479af 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -34,7 +34,7 @@
 #include "rockchip_drm_vop.h"
 
 #define connector_to_dp(c) \
-		container_of(c, struct cdn_dp_device, mhdp.connector)
+		container_of(c, struct cdn_dp_device, mhdp.connector.base)
 
 #define encoder_to_dp(c) \
 		container_of(c, struct cdn_dp_device, encoder)
@@ -291,7 +291,7 @@ static int cdn_dp_connector_mode_valid(struct drm_connector *connector,
 {
 	struct cdn_dp_device *dp = connector_to_dp(connector);
 	struct drm_display_info *display_info =
-		&dp->mhdp.connector.display_info;
+		&dp->mhdp.connector.base.display_info;
 	u32 requested, actual, rate, sink_max, source_max = 0;
 	u8 lanes, bpc;
 
@@ -387,7 +387,7 @@ static int cdn_dp_get_sink_capability(struct cdn_dp_device *dp)
 	}
 
 	kfree(dp->edid);
-	dp->edid = drm_do_get_edid(&dp->mhdp.connector,
+	dp->edid = drm_do_get_edid(&dp->mhdp.connector.base,
 				   cdns_mhdp_get_edid_block, &dp->mhdp);
 	return 0;
 }
@@ -559,7 +559,7 @@ static void cdn_dp_encoder_mode_set(struct drm_encoder *encoder,
 {
 	struct cdn_dp_device *dp = encoder_to_dp(encoder);
 	struct drm_display_info *display_info =
-		&dp->mhdp.connector.display_info;
+		&dp->mhdp.connector.base.display_info;
 	struct video_info *video = &dp->mhdp.video_info;
 
 	switch (display_info->bpc) {
@@ -816,7 +816,7 @@ static int cdn_dp_audio_hw_params(struct device *dev,  void *data,
 
 	ret = cdns_mhdp_audio_config(&dp->mhdp, &audio);
 	if (!ret)
-		dp->audio_info = audio;
+		dp->mhdp.audio_info = audio;
 
 out:
 	mutex_unlock(&dp->lock);
@@ -832,9 +832,9 @@ static void cdn_dp_audio_shutdown(struct device *dev, void *data)
 	if (!dp->active)
 		goto out;
 
-	ret = cdns_mhdp_audio_stop(&dp->mhdp, &dp->audio_info);
+	ret = cdns_mhdp_audio_stop(&dp->mhdp, &dp->mhdp.audio_info);
 	if (!ret)
-		dp->audio_info.format = AFMT_UNUSED;
+		dp->mhdp.audio_info.format = AFMT_UNUSED;
 out:
 	mutex_unlock(&dp->lock);
 }
@@ -863,8 +863,8 @@ static int cdn_dp_audio_get_eld(struct device *dev, void *data,
 {
 	struct cdn_dp_device *dp = dev_get_drvdata(dev);
 
-	memcpy(buf, dp->mhdp.connector.eld,
-	       min(sizeof(dp->mhdp.connector.eld), len));
+	memcpy(buf, dp->mhdp.connector.base.eld,
+	       min(sizeof(dp->mhdp.connector.base.eld), len));
 
 	return 0;
 }
@@ -886,11 +886,11 @@ static int cdn_dp_audio_codec_init(struct cdn_dp_device *dp,
 		.max_i2s_channels = 8,
 	};
 
-	dp->audio_pdev = platform_device_register_data(
-			 dev, HDMI_CODEC_DRV_NAME, PLATFORM_DEVID_AUTO,
-			 &codec_data, sizeof(codec_data));
+	dp->mhdp.audio_pdev = platform_device_register_data(
+			      dev, HDMI_CODEC_DRV_NAME, PLATFORM_DEVID_AUTO,
+			      &codec_data, sizeof(codec_data));
 
-	return PTR_ERR_OR_ZERO(dp->audio_pdev);
+	return PTR_ERR_OR_ZERO(dp->mhdp.audio_pdev);
 }
 
 static int cdn_dp_request_firmware(struct cdn_dp_device *dp)
@@ -936,7 +936,7 @@ static void cdn_dp_pd_event_work(struct work_struct *work)
 {
 	struct cdn_dp_device *dp = container_of(work, struct cdn_dp_device,
 						event_work);
-	struct drm_connector *connector = &dp->mhdp.connector;
+	struct drm_connector *connector = &dp->mhdp.connector.base;
 	enum drm_connector_status old_status;
 	struct device *dev = dp->mhdp.dev;
 
@@ -1062,7 +1062,7 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
 
 	drm_encoder_helper_add(encoder, &cdn_dp_encoder_helper_funcs);
 
-	connector = &dp->mhdp.connector;
+	connector = &dp->mhdp.connector.base;
 	connector->polled = DRM_CONNECTOR_POLL_HPD;
 	connector->dpms = DRM_MODE_DPMS_OFF;
 
@@ -1113,7 +1113,7 @@ static void cdn_dp_unbind(struct device *dev, struct device *master, void *data)
 {
 	struct cdn_dp_device *dp = dev_get_drvdata(dev);
 	struct drm_encoder *encoder = &dp->encoder;
-	struct drm_connector *connector = &dp->mhdp.connector;
+	struct drm_connector *connector = &dp->mhdp.connector.base;
 
 	cancel_work_sync(&dp->event_work);
 	cdn_dp_encoder_disable(encoder);
@@ -1217,7 +1217,7 @@ static int cdn_dp_remove(struct platform_device *pdev)
 {
 	struct cdn_dp_device *dp = platform_get_drvdata(pdev);
 
-	platform_device_unregister(dp->audio_pdev);
+	platform_device_unregister(dp->mhdp.audio_pdev);
 	cdn_dp_suspend(dp->mhdp.dev);
 	component_del(&pdev->dev, &cdn_dp_component_ops);
 
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.h b/drivers/gpu/drm/rockchip/cdn-dp-core.h
index 5573a6277621..3e1279d255ea 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.h
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.h
@@ -15,12 +15,13 @@
 #ifndef _CDN_DP_CORE_H
 #define _CDN_DP_CORE_H
 
+#include <drm/bridge/cdns-mhdp-common.h>
 #include <drm/drmP.h>
 #include <drm/drm_dp_helper.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
+
 #include "rockchip_drm_drv.h"
-#include "cdn-dp-reg.h"
 
 #define MAX_PHY		2
 
@@ -45,7 +46,6 @@ struct cdn_dp_device {
 	struct cdns_mhdp_device mhdp;
 	struct drm_device *drm_dev;
 	struct drm_encoder encoder;
-	struct platform_device *audio_pdev;
 	struct work_struct event_work;
 	struct edid *edid;
 
@@ -64,7 +64,6 @@ struct cdn_dp_device {
 	struct reset_control *dptx_rst;
 	struct reset_control *apb_rst;
 	struct reset_control *core_rst;
-	struct audio_info audio_info;
 	struct cdn_dp_port *port[MAX_PHY];
 	u8 ports;
 	u8 lanes;
diff --git a/include/drm/bridge/cdns-mhdp-cbs.h b/include/drm/bridge/cdns-mhdp-cbs.h
new file mode 100644
index 000000000000..ed67e184d3ed
--- /dev/null
+++ b/include/drm/bridge/cdns-mhdp-cbs.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Cadence MHDP DP bridge callbacks.
+ *
+ * Copyright: 2018 Cadence Design Systems, Inc.
+ *
+ * Author: Piotr Sroka <piotrs@cadence.com>
+ */
+
+#ifndef CDNS_MHDP_CBS_H
+#define CDNS_MHDP_CBS_H
+
+#include <drm/drm_bridge.h>
+
+struct cdns_mhdp_mst_cbs_funcs {
+	struct drm_encoder *(*create_mst_encoder)(void *priv_data,
+						  struct drm_bridge *bridge);
+	void (*destroy_mst_encoder)(void *priv_data, struct drm_bridge *bridge);
+};
+
+struct cdns_mhdp_mst_cbs {
+	struct cdns_mhdp_mst_cbs_funcs funcs;
+	void *priv_data;
+};
+
+int mhdp_bridge_attach_mst_cbs(struct drm_bridge *bridge,
+			       struct cdns_mhdp_mst_cbs *cbs);
+
+#endif
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.h b/include/drm/bridge/cdns-mhdp-common.h
similarity index 91%
rename from drivers/gpu/drm/rockchip/cdn-dp-reg.h
rename to include/drm/bridge/cdns-mhdp-common.h
index 3cb40d719515..4ad9d88b0bec 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.h
+++ b/include/drm/bridge/cdns-mhdp-common.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
  * Author: Chris Zhong <zyw@rock-chips.com>
@@ -12,8 +13,14 @@
  * GNU General Public License for more details.
  */
 
-#ifndef _CDN_DP_REG_H
-#define _CDN_DP_REG_H
+#ifndef CDNS_MHDP_COMMON_H_
+#define CDNS_MHDP_COMMON_H_
+
+#include <drm/bridge/cdns-mhdp-cbs.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_dp_helper.h>
+#include <drm/drm_dp_mst_helper.h>
 
 #include <linux/bitops.h>
 
@@ -323,10 +330,11 @@
 #define MB_MODULE_ID_GENERAL		0x0a
 
 /* general opcode */
-#define GENERAL_MAIN_CONTROL            0x01
-#define GENERAL_TEST_ECHO               0x02
-#define GENERAL_BUS_SETTINGS            0x03
-#define GENERAL_TEST_ACCESS             0x04
+#define GENERAL_MAIN_CONTROL		0x01
+#define GENERAL_TEST_ECHO		0x02
+#define GENERAL_BUS_SETTINGS		0x03
+#define GENERAL_TEST_ACCESS		0x04
+#define GENERAL_REGISTER_READ		0x07
 
 #define DPTX_SET_POWER_MNG			0x00
 #define DPTX_SET_HOST_CAPABILITIES		0x01
@@ -346,6 +354,7 @@
 #define DPTX_SET_LINK_BREAK_POINT		0x0f
 #define DPTX_FORCE_LANES			0x10
 #define DPTX_HPD_STATE				0x11
+#define DPTX_ADJUST_LT				0x12
 
 #define FW_STANDBY				0
 #define FW_ACTIVE				1
@@ -507,26 +516,58 @@ struct cdns_mhdp_sink {
 	u8	enhanced;
 };
 
+struct cdns_mhdp_bridge;
+struct cdns_mhdp_connector;
+
+struct cdns_mhdp_bridge {
+	struct cdns_mhdp_device *mhdp;
+	struct drm_bridge base;
+	int pbn;
+	int8_t stream_id;
+	struct cdns_mhdp_connector *connector;
+	bool is_active;
+};
+
+
+struct cdns_mhdp_connector {
+	struct drm_connector base;
+	bool is_mst_connector;
+	struct drm_dp_mst_port *port;
+	struct cdns_mhdp_bridge *bridge;
+};
+
+
 struct cdns_mhdp_device {
 	void __iomem		*regs;
 
 	struct device		*dev;
 
 	struct drm_dp_link	link;
-	struct drm_connector	connector;
+	struct cdns_mhdp_connector  connector;
 	struct clk		*spdif_clk;
 	struct reset_control	*spdif_rst;
 
+	struct platform_device	*audio_pdev;
+	struct audio_info	audio_info;
+
 	struct drm_dp_aux	aux;
 	struct cdns_mhdp_host	host;
 	struct cdns_mhdp_sink	sink;
-	struct drm_bridge	bridge;
+	struct cdns_mhdp_bridge	bridge;
 	struct phy		*phy;
-	void __iomem		*dbg_regs;
 
 	struct video_info	video_info;
 	struct drm_display_mode	mode;
 	unsigned int		fw_version;
+
+	struct drm_dp_mst_topology_mgr mst_mgr;
+	struct delayed_work hotplug_work;
+
+	struct cdns_mhdp_mst_cbs cbs;
+	bool is_mst;
+	bool can_mst;
+	bool link_up;
+	bool plugged;
 };
 
 void cdns_mhdp_clock_reset(struct cdns_mhdp_device *mhdp);
@@ -551,4 +592,11 @@ int cdns_mhdp_audio_stop(struct cdns_mhdp_device *mhdp,
 int cdns_mhdp_audio_mute(struct cdns_mhdp_device *mhdp, bool enable);
 int cdns_mhdp_audio_config(struct cdns_mhdp_device *mhdp,
 			   struct audio_info *audio);
-#endif /* _CDN_DP_REG_H */
+int cdns_mhdp_reg_read(struct cdns_mhdp_device *mhdp, u32 addr, u32 *value);
+int cdns_mhdp_reg_write(struct cdns_mhdp_device *mhdp, u16 addr, u32 val);
+int cdns_mhdp_reg_write_bit(struct cdns_mhdp_device *mhdp, u16 addr,
+			    u8 start_bit, u8 bits_no, u32 val);
+int cdns_mhdp_adjust_lt(struct cdns_mhdp_device *mhdp, u8 nlanes,
+			u16 udelay, u8 *lanes_data,
+			u8 *dpcd);
+#endif /* CDNS_MHDP_COMMON_H_ */
-- 
2.17.1

