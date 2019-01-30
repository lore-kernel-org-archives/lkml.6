Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C67C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E74620882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="tZZm6C9u";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="GVTxq/+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbfA3LGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 06:06:49 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:52120 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725768AbfA3LGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 06:06:49 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0UAwpXB016598;
        Wed, 30 Jan 2019 03:04:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=qEI/BFkTCMtqeT9Qk3x/WZs2veNVmdjZv8UpDzLDjfA=;
 b=tZZm6C9utbvAsuj4S/OEFrKeApgOZ0W1NkHOUaCvb0safwMhLW6keMl+xGIgo1Q+ExPZ
 cY0KQbZUAkU4zJd9cy6/CMl5wdxhqSNNDTUz9BQV+rPb3mdtwhBsaY3oYCqHlLx429B1
 bW/2LHHJqTpLAUkcDzCAnldP/5p7k7ATPhIM4ebZg4S63FoP0gd70XPFD1ApxzZFKdIS
 YSsFA9mC2rMPMjPzu2dJE4IrDMhcaEyl/QVzHQyW0Jor8kfSeSBp7TcXAzdzrWOSNzI1
 AeG+lyiRr9rIi/Db7KKpVSEEyoDfUs6lq0mIBx8n2fuJwRR9PALLWLRs2DBcYVmaG7J3 xA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=dkos@cadence.com
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2059.outbound.protection.outlook.com [104.47.42.59])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2qa8178d8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 30 Jan 2019 03:04:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEI/BFkTCMtqeT9Qk3x/WZs2veNVmdjZv8UpDzLDjfA=;
 b=GVTxq/+KvGjsBU+OX1wd5PiUivPPh+HkC/WJ2PqYBK2gk5v5kC1x4jrX/0KBks2cOwlrRSb0n7bqfWvK2TyUS7C9fQ+0xe1asEEle2+Vhos3xzBjgXhv56VXPsiJyCDbKaGvhHo/KJ7NJ9of6DMR6Hy3+UV15gm6k38TV0QSDrk=
Received: from SN4PR0701CA0001.namprd07.prod.outlook.com
 (2603:10b6:803:28::11) by MW2PR07MB3977.namprd07.prod.outlook.com
 (2603:10b6:907:5::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.21; Wed, 30 Jan
 2019 11:04:45 +0000
Received: from BY2NAM05FT061.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::201) by SN4PR0701CA0001.outlook.office365.com
 (2603:10b6:803:28::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1558.16 via Frontend
 Transport; Wed, 30 Jan 2019 11:04:45 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 BY2NAM05FT061.mail.protection.outlook.com (10.152.100.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.2 via Frontend Transport; Wed, 30 Jan 2019 11:04:45 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x0UB4fKx028075
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 30 Jan 2019 03:04:43 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 30 Jan 2019 12:04:40 +0100
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 30 Jan 2019 12:04:40 +0100
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id x0UB4fkJ018333;
        Wed, 30 Jan 2019 11:04:41 GMT
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id x0UB4ekq018323;
        Wed, 30 Jan 2019 11:04:40 GMT
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
Subject: [PATCH v7 3/4] dt-bindings: drm/bridge: Document Cadence MHDP bridge bindings
Date:   Wed, 30 Jan 2019 11:03:20 +0000
Message-ID: <1548846209-16406-4-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1548846209-16406-1-git-send-email-dkos@cadence.com>
References: <1548846209-16406-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(346002)(396003)(2980300002)(3190300001)(199004)(189003)(36092001)(7636002)(4326008)(305945005)(86362001)(8936002)(2201001)(8676002)(246002)(50226002)(76176011)(51416003)(36756003)(110136005)(2906002)(26005)(16586007)(54906003)(42186006)(316002)(106466001)(105596002)(126002)(476003)(486006)(446003)(11346002)(2616005)(356004)(6666004)(7416002)(186003)(426003)(336012)(26826003)(478600001)(87636003)(50466002)(48376002)(47776003)(21314003)(921003)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR07MB3977;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT061;1:Q1rYRepY1diztmyzEXhO/3qNfQLqp2sHPDFoN/LxhBMVsrFEXxHnkzZPec5yaiba5/8DaO/cjxzQs9FW54dz0EJI2Sv/zNNsMbM6yEGTUqCUdi1HIkqVNjutl8lXVsUDSI/W7rKSGQ2XaNB73i/7paK4C6HIvZIRj2bxyVd+QaM=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8885fb66-4385-4c94-546a-08d686a2be46
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060);SRVR:MW2PR07MB3977;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR07MB3977;3:iysivw1c2VQW4yUjD+TziLjOwOX/j4KnWz920gW1Y2Hn9CGHsEAQFkTCwAOhhsFocRGU93mxf/VS4pnvdIULIPK6+/BR9hhAtuyIWuYl1WtxyucVZ/adLQak+f/1eE2ua5D8iPLtBSWNbLz68jf6mVOWausoIm8h0gSBVh0yl4FNyYXU7CohVp779/BcUscJoHFYs44d5CS4PTgB5ukwhQ9Jl+/oPD9yvdKaoXK897j0yuZpeUrbWByrcINgR0b+jPwgQ9UOWb3JpNcTACWgh2DNoZogusnS1V7hmUL3GW5vrKdf1AwEKc3uFpvNcyBr8zU6DB2VZlqoRw7xfVPn+9stucvRjQNJP2jTvgdPsMpAcuwb6/3a1LAZtxybxj6x;25:sdyI6lkeGpTvlA0W3Yn+ez+cigoUZMZlJoC/UsP2pTnBghXmANUPkdCzG7rHlzuNTYHbFYJkhDwzx9GdAuZ1bEsmv6Nv1QJeTnPjWsP8OScjpUv8GPU7EZvkEP4AlaxW98phF+2tMYuuVidcQrt/nx+IDk7aVh+rcD9Mk9kY0RyIhuIxlngd1zgjJavsMB382euIwMWXihtudvGceZNt98jgkEV8+lq9rJbZ34kbmT97l3vlBlZ7IKxKwlJkq+GH61ykRA2uj9MSFRImbUcBewnrWfpKg8edLUezdZwnmvb7yIGG2mCd8WZGeRimL5YkJcbUdyjHf9hBVvx24nqkXw==
X-MS-TrafficTypeDiagnostic: MW2PR07MB3977:
X-Microsoft-Exchange-Diagnostics: 1;MW2PR07MB3977;31:apnc1QqhiZM6+kxYq9H+7OEKhg8Z7IuOjLUkuBWnI7bEvKOY2X/BrP8B0MD5yoFbJogJxOhqIPh9A5Bk60Gz61ZTZ+vSz9RT1e60egRBsixCYgDv5ZV0GzfjjJGKJp8auBQjaL2q7ls6XMn5+kWpQ6gGwMcDEq81ia2DW+ijAO60T262tExHHvVKH2boIFC9groTjEt/8k9+w2xeqcd8tExWLMVfJZa1Zf06v+zmL6A=;20:4khgHHsy1f1GgSpl2zi3t02EPNoJB8TBrRmftNl73INweZMxGC50kMsoXw3USrvuAv4s1rOHkR9HWNwTgAymvO8/YMklVoMb4JTAIMgWQ0jAfvUa9RAHxZhgaH8d1BiALxFxU0XFJ9pGUBdDGD/6KOeFggrL07bYFF5amatsJeP2w+woh08FMhdS7a8YfcqmmLS8/jRvQjnJB6ZJ2lutGeBl0ipSW/aXIA6f8KZt7J5WP12n9pNeRvOush754XyGTkYv/G2DiVUhS5ReBmvXQcYMEJirgrlf+IXTYkpCUdyDljkcevhFcDYA7Yy9zzQXl4EK4RiuOh8TlYJCbBmKzrS4pNuhJV7r5/dVjzPKsIefwyhKQjeccsPL/v1IrjEj56bFggSHKwjw61gKYVzCq/OyXrq1hggZJr0qvHQsyKB8nWvSimvIHkRlyEIjRFnliMpOmzHBfylfJejSMxk7aXWLpw5EHNa0EqiDnSEUsShunESnoasw4wlJKLKBp2n+
X-Microsoft-Antispam-PRVS: <MW2PR07MB3977FC025E736BF135840C35CD900@MW2PR07MB3977.namprd07.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;MW2PR07MB3977;4:hdNX0mHw6fUzBwuiHj+JquRBhHc/rJQeYXW+5NapD4yHPHX8q2qQN0wfquRjhTJVK7Z9MfjQXLvA22E//wVma9QWU5fQBA5BaLAkgrn+n0KHrK7rdrKFbm6eF3aROf+d+vTdFNpyM7MVMD97SH26nID+N98WnaCVLrVg2EThmH5zJypPyp6NSs2yrlYvc3hbp8IkvF5yADmo2JYm7s6pzCpOU97LXCupRmSlNgAKzDuc3JDiiGQEMifs7Aef3JJPaeGyI3Yrs4e2H5CxlPPWbwaNDnZbIhvbo5lUplJRySs=
X-Forefront-PRVS: 0933E9FD8D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MW2PR07MB3977;23:oIhbP3K5EeGCec0pU9EtsZxhNgAEx+VCUbXwQRtyi?=
 =?us-ascii?Q?Z8V88b4aMj4bx1YA36NONePJn/qBYLiBOcK1huKNf16i7mycH9oNR9H1+LtV?=
 =?us-ascii?Q?hixXjfuig/WbCWyGl8kUiWmh3jFzSFz6vMLy5jwalsoIJc3X35Ckz8+OS6T+?=
 =?us-ascii?Q?2vN8YTakqy/yo9KAK2dQ+vJoTMZdi18kiVOReKARsdXX5Mp8+MOooTn+vCnu?=
 =?us-ascii?Q?2Nmxhk22CN0cuVGPKvIgEgGraB00pNSN2d8caZF4G3ODL+ZUc2Wv7DTW/W8o?=
 =?us-ascii?Q?MWzEPm/HJsusX2c0rsaVmnuKFZySWt+Yuvin0ldv9xPcBhBzhM9YQf+BK2fj?=
 =?us-ascii?Q?jlwrhaWDCPzt+DFg04s3LsB52N05G2ob4hWsVap0PXmlcyMSs4swhcNYtrHa?=
 =?us-ascii?Q?xqBuVfFE2+xm/wo/P7m4F8ztW30ZQK+XNELyPCWxA4rIQK4CX0/++1mW6OJg?=
 =?us-ascii?Q?ReB2ODkV6OCF9gJVlLzMFZp44jZYNavoGgdh665g2ylh96Hhx19WvvE8p2Uk?=
 =?us-ascii?Q?1mfoQg18E0jkSJ8OU6DH5HTjF3JVfnEGk/qINmiH8ef/fGna/MlvmLfsHDe9?=
 =?us-ascii?Q?ulSLtufRv3ULptHINH9SNmBUWTYtAUU6razz8M2K6rjtHgqX6l89DZcJt2s8?=
 =?us-ascii?Q?4PJpJg56K2GzGjiwd2K84Qyj6ggQv5qBjV+rablMsA3GRpw0JWjxabEAtave?=
 =?us-ascii?Q?iByZ0mpbxHa7ikQg+C3Fw16xPFWveGUiHSYT3Kckglq3tXp8bXNjuJbuqIsA?=
 =?us-ascii?Q?pdwGwMNf2x+89iwFNyTHy0PTmQj7z7Un0v3vkipuGfGwLy6vJ3fyWXdC4OSS?=
 =?us-ascii?Q?X6N3DMXJqvGsAwh0viYeujfPnT5rr4I98cKG9a4+yubqDi2N2t9tvADSkaYp?=
 =?us-ascii?Q?XpcBkoRjFhi8Hh58rRCVI87hyswmVzCUTGaCxV7voqhubj5CtJykKd5Xu29A?=
 =?us-ascii?Q?qNepeBEJPeuso4Bq3qylV9DJkHuHQWP5Onq2QQtrIq6bFYKD6tne/cwYGS9S?=
 =?us-ascii?Q?kxKc4H0Xhcyc4d67xlJVv3SuFfC1egmcYK3YPZeI9F1XR8KWSGkiNToBNEAb?=
 =?us-ascii?Q?9aP9yBj0LMXBDaIHTKVx+LU7uR53HpNNwXh8uUieZX0wseznPWHeVtpvs1Ir?=
 =?us-ascii?Q?eh3+PdDvojmqt52U6PQ8t0+7YkhUvwPCO2etCzd8wNE+SVKoP8rCis/skubQ?=
 =?us-ascii?Q?hAOPIB3Sw+xpPU=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: DeUCnmOIANJh86ZhDq/Kr1tMdefJdhgxH3i7KLiVuytzyRDE4XoUElDgwz9OgYgLV+j/MNI1vMW19IQmz1mz0BWm80wusWhIBG54SbBwDpN1Vk5HWrdNFeD3LeLYDuepV4HiR6G8lE/YmStHW0g6CBexu7UNZ7b6O27FeIrkU1HD3CoDywtVZ9kjDB61sfXJwa3n1AlvrnolmXs0SsOP1yBX7iklx9f8qFxaVCmNB0APQo3I8kQcCCyV2NIRSkkPrjsXdA5Prq7sEufBfgPcgp6sNqnNDjtB92fzRGWTSpBc9+w3sbL0gybXeODTgTiZTFiRXf2MQhtgU1DEBAn6asNkYXTpnpPxvISAJ9lL9f57XPHwzyhsTKFpDZcRQPAkfq49ywIuBRmcFqmxICGtEcjIwG+kaw/rxqSmGwJKN/4=
X-Microsoft-Exchange-Diagnostics: 1;MW2PR07MB3977;6:Ey5UQMGiOJ0QX7jPebmYBd/bIZfibBOqkGmJqqnt2Rx7owjr8NACEHC8bUOKRx76+fxZXN6ra26m0AL+0ILewuF48G2XSz806pZtIAFxcym9d9SyrnJXWUvrma48AKr8tOGfcIQ8FVJordiMPOBmt0mLDfFnbcZhTKqA908624gDY33G5WEkfy3Mj1Xfm+aiiPuz/BPDnmRiy3arlhiZKIZX4j2K4XE3SFDu7mlbwilCHswPuWmyFB7tScjVncty4yC24DTD9PhYXq26k1tzHAQFtr8sLG/vnOeUryIgaGGuGf8sqmdQmIms9PP3qDjZAj3sMzMHvFaH4gkavcX8YjmfhiQ91h6J88rP9m/Klfn7gAHBgP5wz7uTnamk+NzUYhtpflgXcOpnC/D2lu1ycaQWYTDmGLNjVD/MnatVTiCxk2pbsFu62XDxQyFDVQQNMyGFA5n6tK55Dp0V310R5Q==;5:ru6E0LGalDT0H3ShNhBsMJXCyssiZjbbBqh1k38D6/dmAqbmlZqu99LJB06YiyMf328bdadru8Kpa49C/7mCEKxG5/1Mc8CA+V9UdaShawiTxhDfdgozoobntY5zqCkY6BzR76IDLIugtYtFv9ZHbFfygaZ+nvVV/wPlpm/D3K+ZLXeObzaGC045DGbwbgILE7YJzg0PdjuwpwnkKME+jA==;7:YkUKqn+1KfPRxfdaxJPfO4QKXGicnZcayY3WN2OIfkIg8qa9NEDehyiisahDJY6vry8IYp4eJy4ps5PQ8j91E7xtFuY8WAGttD8zNzcMa3oBpjwYCun1DPjE6NrWPeJYjmWhWTbMNu7XTCSnHlu1Yg==
X-Microsoft-Exchange-Diagnostics: 1;MW2PR07MB3977;20:9at0oXAVbX3llxov6VjZvylQ5bOwFMp0+9l5DMPgDfo0BC6Ey19jJT72/JxPNKLMpI+CJC1Nk7IHjAzInJivCLNr+SPCmD8Xs3UYvObmnwIY0UBK74ArHvErz30eVQLwclCuF4Q6La9x/MIOJUgzY3tWA4DEOgC5/S+gblWdvcYzacwrfFa4A5Um2h9ZBUx9XhT/4ywvsntURCJaY2P3QK7tsBIaw9pJPZyVu6u4FUCIP4BIUnUzf9PphzDY9cuB
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2019 11:04:45.3527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8885fb66-4385-4c94-546a-08d686a2be46
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR07MB3977
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=1 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901300089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@free-electrons.com>

Document the bindings used for the Cadence MHDP DPI/DP bridge.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/display/bridge/cdns,mhdp.txt     | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
new file mode 100644
index 000000000000..df2a00163ccf
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
@@ -0,0 +1,47 @@
+Cadence MHDP bridge
+==========================
+
+The Cadence MHDP bridge is a DPI to DP bridge.
+
+Required properties:
+- compatible: should be "cdns,mhdp8546",
+- reg: physical base address and length of the controller's registers,
+- clocks: DP bridge clock, it's used by the IP to know how to translate
+	a number of clock cycles into a time (which is used to comply
+	with DP standard timings and delays),
+- phys: see the Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
+- phy-names: must be "dpphy"
+
+Required subnodes:
+- ports: Ports as described in Documentation/devictree/bindings/graph.txt
+	Port 0 - input port representing the DP bridge input
+	Port 1 - output port representing the DP bridge output
+
+Example:
+
+	mhdp: dp-bridge@f0fb000000 {
+		compatible = "cdns,mhdp8546";
+		reg = <0xf0 0xfb000000 0x0 0x1000000>;
+		clocks = <&mhdp_clock>;
+		phys = <&dp_phy>;
+		phy-names = "dpphy";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				dp_bridge_input: endpoint {
+					remote-endpoint = <&xxx_dpi_output>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				dp_bridge_output: endpoint {
+					remote-endpoint = <&xxx_dp_connector_input>;
+				};
+			};
+		};
+	};
-- 
2.17.1

