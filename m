Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EBCC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42DAB22B1E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="f323ZMpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DAB22B1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933990AbeGCKEM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:04:12 -0400
Received: from mail-bn3nam01on0057.outbound.protection.outlook.com ([104.47.33.57]:35116
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933954AbeGCKEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmC5nkpTPRAaupdOxGCkNt7SzvJtUcPwOZ2RzqyIZfI=;
 b=f323ZMpW88Af0bZeh4OVAXHk9RayXhgkKzSWgQSRd3JTADy3PTGHl+XnlyasK1do0rT4pp6zq5wP2sacRmjyEgUInn47pBl6p86GMRJQIoDl81DBdtIm2/6qEAbrN36viK8uParLzNjsHCCeHrmvRxxQ6iI95vCDBPHR018N/gw=
Received: from DM6PR07CA0018.namprd07.prod.outlook.com (2603:10b6:5:94::31) by
 SN1PR07MB2303.namprd07.prod.outlook.com (2a01:111:e400:7a45::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.26; Tue, 3 Jul
 2018 10:03:58 +0000
Received: from CO1NAM05FT031.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::209) by DM6PR07CA0018.outlook.office365.com
 (2603:10b6:5:94::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.20 via Frontend
 Transport; Tue, 3 Jul 2018 10:03:57 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; padovan.org; dkim=none (message not signed)
 header.d=none;padovan.org; dmarc=fail action=none header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT031.mail.protection.outlook.com (10.152.96.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.930.2 via Frontend Transport; Tue, 3 Jul 2018 10:03:56 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w63A3rBX023172
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 3 Jul 2018 03:03:54 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 3 Jul 2018 12:04:09 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Jul 2018 12:04:09 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w63A3qqh030472;
        Tue, 3 Jul 2018 11:03:52 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w63A3qqP030464;
        Tue, 3 Jul 2018 11:03:52 +0100
From:   Damian Kos <dkos@cadence.com>
To:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Damian Kos <dkos@cadence.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <ltyrala@cadence.com>, <pgaj@cadence.com>, <stelford@cadence.com>
Subject: [PATCH 11/12] drm/rockchip: added implementation for a few FW commands.
Date:   Tue, 3 Jul 2018 11:02:22 +0100
Message-ID: <1530612152-27555-12-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1530612152-27555-1-git-send-email-dkos@cadence.com>
References: <1530612152-27555-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(136003)(396003)(2980300002)(199004)(189003)(36092001)(316002)(16586007)(54906003)(110136005)(575784001)(86362001)(426003)(7416002)(106466001)(42186006)(14444005)(5660300001)(2906002)(26005)(2201001)(48376002)(11346002)(446003)(50466002)(126002)(476003)(336012)(486006)(186003)(26826003)(107886003)(36756003)(356003)(76176011)(51416003)(105596002)(246002)(2616005)(6666003)(8936002)(50226002)(305945005)(7636002)(4326008)(478600001)(8676002)(87636003)(47776003)(921003)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR07MB2303;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT031;1:B4Pg6UQ/eWUJwtxwC7NWauwQZvBOPrnBCkwqP4AYNMNGw1t5rxnhXfLys68rPllfXoQNCeqRk1MtGzepah0+3RLjzF8WeFSAriWd5Xx9y1XIoHudiEHl3kGa76zjwtry
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85871c8a-2b0d-4521-d0d5-08d5e0cc4a83
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:SN1PR07MB2303;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2303;3:BwfVjoW0XyrRyreafZ77ASBZF+o7MQotnBsu/X6Am5VYy4+kyqxosOyyoxmbm9Igy40KN7jILWXAR9vysB8QQ9Ix6U7b2L8ZugIqKS0Mo5N5LK26ySLe1o+rsbmOcXm5WNer+5D/3qvJ+olJI4PcCg1cqRp2lQ3ZV4TlaBO7qZX4gjNK4YPmBzZNeGL+ZPLILDjUBh1P4FsDfez49fVooXA1aG5Z65arVhXp3BwNfVXsXkcrtr6f6kcC1zfMNzUUrtydsxch2mfdrUwf7aEq9ldiwGci2jAqGbkmSDwDdhTfyGMrsON/QbmwhEH9SQ7IlxmoNXHThKN2dZHI8b1wmMFL7QRSsnCxazkcbs38ILc=;25:Knw282PymhDaj152xPXyzOOS7/RaDp6LMAmH0URpUZeZkKQTUFLtyjs25zggJ8JmHUGdFp5sKTYuUW51R7EkcXju6Aq8LUX9MC94blI1zVP0MBSW6qq+hWwwVAmC0VOBVAOIG1SLAxJw4PI/bTvpXwJy8gQ+/ubGxrxwbCTT735pg5l958DZBb1Aj6/PdhEuzoV74I6G3qEkxheO59Iz1UIk23ZLC7VU4xlPs+/4Lb+rqfJSY3lLJUFDhZeFw00nrZvt9p/lr7rQttt+iw5n9pM+PTLwaUZsmX2yFVNgZUN7bcKMtDYY57c+VM+QSo3RoTfSQ95z92Y7id2gPWv9hQ==
X-MS-TrafficTypeDiagnostic: SN1PR07MB2303:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2303;31:qHzVc9dF8tngLp0sM8/YeBamxOurFuNRaBCvkZidpSV8fR2IQ7FsIThou1GqA+mvpPjkSlnySV8VIVAmUECEKO4uaTVmHol2Q6IULUre3EFea4GsNz56k68xtIRQBkv2m7Tyxn/jcq3D0ta6XVFF8HOCs31Pet72sxNG/zN1RB/ZNMvd9Qs3IF4tlZwkC5dG0gt2VmL6lER1J+jna1CbEk3HX1CGP7PoWLcwe8IEn68=;20:KUuwiSgWIxlJyJ2++4dwyyTyNfsSIyGioAorIxsb5R/Xq0hlAXdDPoGZ5KTgzRxn0n3/VvGkE5QnVGa2fIdOL/LZ8NdhPNa/UTSRbGY92ebUKhydXZmTQlyYEtIQTg2RUS6Vag+1zW6PvMepeZn0AmUObI4Gsi8nN03bAe9/7OwJxZYERp9QdDspIYUsexeJTp8JXx0ed+BH3mk/5bdCqshNtkGpANBSca2bmQtd0hFMYXbAQyhdaFbCtEcDUUlv6Pgl5UA+ePR+4EHZLH5zlysmEI4gxNW4QRWTGcNFoanE6W49uV1u9oYbt6KjZvu2CTuEfdB4WpaPJ46/FW0UmBfadU8RBAuZ/qFbKb4p7czxtPK+n4hBDdCCAzHor9E34AJ1CF7C0eZripMJJo5+9ebhzsseLIobKsDUH4QziMDvt2hyhfNRTQp2FFK+PsPWoiC82vbxpCM8vQH7JHj2sgwGz11R2Jt6BiMq+xd9cS/EW95OiODPs7JQtaNRfbI0
X-Microsoft-Antispam-PRVS: <SN1PR07MB23037ED457DFA9F909B8446BCD420@SN1PR07MB2303.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93003095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR07MB2303;BCL:0;PCL:0;RULEID:;SRVR:SN1PR07MB2303;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2303;4:zAfz/EnF7Sa+7PjqWJ7oC5ku/KxLu2McWFMeU4PZTY5sg3nk1vx7ngV77S6x2Vu+Yw3Tkwpq5PAjq2zyncqLXi3WkadqMT2rQOo/21+/OLPUtYs6/Hgxq6RDZZzlslTpfRZszMZ5bQKNKVPNVLYF8OxcSUvI+uIQLEPDnVTas9CJEjo+JRfl1YBeMIEJ2AIMs4Bkl5CdckbEXy0cZI+XeLs77tLIsbmZhN6PLCEvl0fDtJBfgBH+JVsFxR3rEk4zWeI9DPWlYkPS5wlhn0icVu2SCg1mLw//hiy3VQ2Rk6NvqMOGNljsS8pxO6alQBUa
X-Forefront-PRVS: 0722981D2A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR07MB2303;23:DgF/cFflIG2sv/ISXw3XDa069OU8hjCQkqxkKpHnn?=
 =?us-ascii?Q?kqlHVvXqSYn/VupGktZ2SOVAyAgYm3Vk1DX+f9N4XqRO57tme8RTWlLDhXBS?=
 =?us-ascii?Q?Xwmco9X8Hg7E5gzjn1SKW4MYpXzCo9Yy3ObjU+QNaSrnrPNf0d+ImxXPG9ME?=
 =?us-ascii?Q?kzzFn3bMECLjpiWL8rFuwqGYmxFynhukXciXhpR2RJq1tN92r8La73g3fvWR?=
 =?us-ascii?Q?0UD7RfeOnhYqvdN6eWpdPor+BUUW9rFfzoFoXJx3Ek0P/kTvNpUV71MvrruP?=
 =?us-ascii?Q?aqYW+eViyPzR9zUDAgImn6zX6TJZlVBbfXEEjv6+zBv2KK+961C48hfR/M/a?=
 =?us-ascii?Q?JpqF4BkUjaJDaFaKTJUud4OifvGlGoO5HOMXTVAu5IDdcx4Ol3klxh2INH8g?=
 =?us-ascii?Q?B3UHpuSHwIoBmjUW1JaMhHcbzg6YC2fraNuVEuuUODYrGz2tUJ7pZmvTR7Ho?=
 =?us-ascii?Q?AavND3jPlX/sfIfu+1HXAyPh5a8tMqBP1kdN3eNyRJovKDHqdQkuFJcRuyZ2?=
 =?us-ascii?Q?0WHj8g5o8i64gwfpFShnPMEDAt6YUeLtyf39AdKNeGIpU7Ipv1Mif0uJrbKM?=
 =?us-ascii?Q?BZ0HshQx+GH1IPYY/rVkA8HKc665UU9cx7Lf79r7QtK5VSh/xh1ECIcR8sHv?=
 =?us-ascii?Q?zpRL0Jc5VgRBW2gNH3IhFWLhUnIhaHPaD6g+tI/i747rlX+QLxIp/e9DvuTf?=
 =?us-ascii?Q?8OmRF9e31vMl9i/6B/BKw8F8z2hOu6QlvvtHmYsGQsp0lz9/NYpZRS8KfnE9?=
 =?us-ascii?Q?bqPLGc+1EY4uTXnj2R4LaXZMbzw2cDDy4k775sCC3LjPRmzB1ZleandsGkwJ?=
 =?us-ascii?Q?EtYculJHII7n3NbtPJbBzh1R2/Sdyg987UMHfGkLnJnSQMUH4MbjqID54wJI?=
 =?us-ascii?Q?B2XG5nQHkViKNNxWf4uZVLZE+cDLtnx7WT5w5kSHttQ1TVBWCwlPEFM2gr36?=
 =?us-ascii?Q?qotkXESIQ6hHCHnt+PreOhsnuc3+5qYeUI9kH6VKbSm6xT5oWwB6f5c+NFP0?=
 =?us-ascii?Q?16DWL/eb25ykl2rCtuf2lhgJbmCBuQSQoKmlXsPs94FMnIBqHqYysGBGn+SS?=
 =?us-ascii?Q?6/NCv7wJeYhINMI6W5jGtfqjXCEvPOGf036FsI6Bb/u/YIwH+XlfS6COhDno?=
 =?us-ascii?Q?BP8KoQsOGocg3DJL6e5/AJfbWfLj3HDytPZRGITxWVx3T152feQPc96Xe2Up?=
 =?us-ascii?Q?6ELDpl202e7Vo10TDa/77tszAPAFik4R8aWuii2tueMfxYh5utQqGz0fA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: L720rWxtip8l2IHlHB+N89wBUEQkDe9eLVnZ4/Kig+YmT7gmQMFGmt3WiniO3g4FD/kKLDn+msTjRUiakUO4gzO/nZn6iSYmtmLjXRqp4UwA+UtJmoNmKsgjswtwGsieIRbTMbCOCUDFzPo4HTSNYGAy6XIv6lu/0uXhsJCXqIoZx7BmgBTVI3px4xIrpKRbIELThFHYvium+eOM1o1ELgB6v0X3BKcBD5Q9+rgVbSDbdsdFSnSQaK0AMPLrjXyim7AcVwVn6vuT2kEJSct/pOCrqegGMtdN+94442m0HI8KV/2tAsOpbgrsJyw07DTmWfDiM5Hm1UIWcohAXlRHoKc88VsYwRwV3DcMXZRofk7Xl5lVMNKIUWAT2zg0FwNPdoaJNpeSKnm1QpVxb3BEug==
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2303;6:Tm2skcG7iv5mcpYs+M17hm+WiFqdvUEvzbtrgj/6m21or46zWWCaeX5TiLBFD9MJ4Qouzx8RrnbvsXBMDg0MJgeKnHeBZSzxaX25QglSYjfT4vCXHYPAEN6hKGohCX8PavbNhao4KkENh/BtU4VCz3OsW8vx9t8PMLVMWWaCjjbVCYdWtWnmqBbzPqFHnPII+vyzD0c/X6c38uiNUs/nBfL6P2w4GAxrl93Ww+8NB4FpLLnqeTEu/CmMHvOcP3r4jcYZxY0EnbZ1z8J6cNcppviYEWjhCOZ4i7MW4qF6eUED/r+i3GOlQ6ue6zUUoXUXfGrO2SqkOZL7UvnfGAQuPYBABfAcXRMwju9DxpMaD6Ab3O/84D39Occ4lEotKtbCwjyRezIv/lUvcIjA8UfJvGrKTAR346iP2siZp7EZbEZo/avY8+tnes2aZj4VgD2fsmrv3eppZT1nhBhytPICmg==;5:swt+F3SFqn3J1R4fbvSRaHuidzemcpzrXrKAwhq+xKIQU9/8/Z7SemiiGl+ljFyyUWtPk8YgntzG/sOfIcQbHftWeDZQPtxZ5iqIwkM1Eqmo1A14ATtHfEEuvL5jyZA+tThLQuz1XtfMC4kPKrbIDJiUATBBbjaUbbBInzbB3wA=;24:bPFKo7IsL1SadhujDg0ZN4CB9iqbJSAulaXT4cSr85GbzKvVspMq+DyKaceLq58hqw6M6rZN6/2hHE3DpVqa3Zfae2CGe/eTr2k7mFR96+E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR07MB2303;7:H4fAHECtmXaooTqbL1F2HsgWNAj/iFRoQBClXS/G9Llza3wZ2duXaXBO3H+tH58fdHGmbpGfwaw9E2+z3Km/eITfEf9wnUbwLdOCAJ8Edsmx5u/EzeWsxH/M8GspMVFT93hkbwbG5GW6MJdCX4lM0hz5kxN4PZfBdL/IAaEmk+sXjWUjz1nmAYXtCsfi/XdZff8ejwX6tEDLp4QHkf7V3z8ZpgfFMmHURtjAWJ0XwhSoO2GZNkOwK+khn2SbUhNo;20:1egBlXKAj590OQZJe4kdHp16p6gilaPuqOX1h4D4ejsKkR5/Rg2RBzebergDUqJiPkVSqiJsUW0eE8f4dVO1qmVufRCP7gHM/g356g9/5tbnfx2ey8VhRLanTTGgGMFX2AA82+CbEYwfJn9eejJLEirgbO16dS+Wc3spwf5wDITEDvv1N/yKm6FT547RjynVmDLfm04p8MkVBRubt2vxwn1+OoQALy4zkXQpXZ8vxRegYFkeY6mY5F8TjULyTrj/
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 10:03:56.5461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85871c8a-2b0d-4521-d0d5-08d5e0cc4a83
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB2303
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added support for a register read, register write and register field write
commands.
Added support for adjust link training command.
Updated cdn_dp_get_event function, so it reads all SW event registers.
Added definitions mostly for Framer and Streamer.

Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/rockchip/cdn-dp-reg.c |  167 ++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/rockchip/cdn-dp-reg.h |  143 +++++++++++++++++++++++++++-
 2 files changed, 305 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
index eb3042c..b061cfc 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
@@ -410,7 +410,10 @@ int cdn_dp_event_config(struct cdn_dp_device *dp)
 
 u32 cdn_dp_get_event(struct cdn_dp_device *dp)
 {
-	return readl(dp->regs + SW_EVENTS0);
+	return readl(dp->regs + SW_EVENTS0)
+		| (readl(dp->regs + SW_EVENTS1) << 8)
+		| (readl(dp->regs + SW_EVENTS2) << 16)
+		| (readl(dp->regs + SW_EVENTS3) << 24);
 }
 
 int cdn_dp_get_hpd_status(struct cdn_dp_device *dp)
@@ -981,3 +984,165 @@ int cdn_dp_audio_config(struct cdn_dp_device *dp, struct audio_info *audio)
 		DRM_DEV_ERROR(dp->dev, "audio config failed: %d\n", ret);
 	return ret;
 }
+
+int cdn_dp_register_read(struct cdn_dp_device *dp, u32 addr, u32 *value)
+{
+	u8 msg[4], resp[8];
+	int ret;
+
+	if (addr == 0) {
+		ret = -EINVAL;
+		goto err_register_read;
+	}
+
+	msg[0] = (u8)(addr >> 24);
+	msg[1] = (u8)(addr >> 16);
+	msg[2] = (u8)(addr >> 8);
+	msg[3] = (u8)addr;
+
+	ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_GENERAL,
+				  GENERAL_REGISTER_READ,
+				  sizeof(msg), msg);
+	if (ret)
+		goto err_register_read;
+
+	ret = cdn_dp_mailbox_validate_receive(dp, MB_MODULE_ID_GENERAL,
+					      GENERAL_REGISTER_READ,
+					      sizeof(resp));
+	if (ret)
+		goto err_register_read;
+
+	ret = cdn_dp_mailbox_read_receive(dp, resp, sizeof(resp));
+	if (ret)
+		goto err_register_read;
+
+	/* Returned address value should be the same as requested */
+	if (memcmp(msg, resp, sizeof(msg))) {
+		ret = -EINVAL;
+		goto err_register_read;
+	}
+
+	*value = (resp[4] << 24) | (resp[5] << 16) | (resp[6] << 8) | resp[7];
+
+err_register_read:
+	if (ret) {
+		DRM_DEV_ERROR(dp->dev, "Failed to read register.\n");
+		*value = 0;
+	}
+
+	return ret;
+}
+
+int cdn_dp_register_write(struct cdn_dp_device *dp, u32 addr, u32 value)
+{
+	u8 msg[8];
+	int ret;
+
+	if (addr == 0)
+		return -EINVAL;
+
+	msg[0] = (u8)(addr >> 24);
+	msg[1] = (u8)(addr >> 16);
+	msg[2] = (u8)(addr >> 8);
+	msg[3] = (u8)addr;
+	msg[4] = (u8)(value >> 24);
+	msg[5] = (u8)(value >> 16);
+	msg[6] = (u8)(value >> 8);
+	msg[7] = (u8)value;
+
+	ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_GENERAL,
+				  GENERAL_REGISTER_WRITE,
+				  sizeof(msg), msg);
+	if (ret)
+		DRM_DEV_ERROR(dp->dev, "Failed to write register.\n");
+
+	return ret;
+}
+
+int cdn_dp_register_write_field(struct cdn_dp_device *dp, u32 addr,
+		u8 index, u8 nbits, u32 value)
+{
+	u8 msg[10];
+	int ret;
+
+	if (addr == 0)
+		return -EINVAL;
+
+	msg[0] = (u8)(addr >> 24);
+	msg[1] = (u8)(addr >> 16);
+	msg[2] = (u8)(addr >> 8);
+	msg[3] = (u8)addr;
+	msg[4] = index;
+	msg[5] = nbits;
+	msg[6] = (u8)(value >> 24);
+	msg[7] = (u8)(value >> 16);
+	msg[8] = (u8)(value >> 8);
+	msg[9] = (u8)value;
+
+	ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_GENERAL,
+				  GENERAL_REGISTER_WRITE_FIELD,
+				  sizeof(msg), msg);
+	if (ret)
+		DRM_DEV_ERROR(dp->dev, "Failed to write register field.\n");
+
+	return ret;
+}
+/* rep should be a pointer already allocated with .regs of size 6 */
+int cdn_dp_adjust_lt(struct cdn_dp_device *dp, u8 nlanes,
+		     u16 udelay, u8 *lanes_data,
+		     u8 *dpcd)
+{
+	u8 payload[10];
+	u8 hdr[5]; /* For DPCD read response header */
+	u32 addr;
+	u8 const nregs = 6; /* Registers 0x202-0x207 */
+	int ret;
+
+	if (nlanes != 4 && nlanes != 2 && nlanes != 1) {
+		DRM_DEV_ERROR(dp->dev, "invalid number of lanes: %d\n", nlanes);
+		ret = -EINVAL;
+		goto err_adjust_lt;
+	}
+
+	payload[0] = nlanes;
+	payload[1] = (u8)(udelay >> 8);
+	payload[2] = (u8)udelay;
+
+	payload[3] = lanes_data[0];
+	if (nlanes > 1)
+		payload[4] = lanes_data[1];
+	if (nlanes > 2) {
+		payload[5] = lanes_data[2];
+		payload[6] = lanes_data[3];
+	}
+
+	ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX,
+				  DPTX_ADJUST_LT,
+				  sizeof(payload), payload);
+	if (ret)
+		goto err_adjust_lt;
+
+	/* Yes, read the DPCD read command response */
+	ret = cdn_dp_mailbox_validate_receive(dp, MB_MODULE_ID_DP_TX,
+					      DPTX_READ_DPCD,
+					      sizeof(hdr) + nregs);
+	if (ret)
+		goto err_adjust_lt;
+
+	ret = cdn_dp_mailbox_read_receive(dp, hdr, sizeof(hdr));
+	if (ret)
+		goto err_adjust_lt;
+
+	addr = (hdr[2] << 24) | (hdr[3] << 8) | hdr[4];
+	if (addr != DP_LANE0_1_STATUS)
+		goto err_adjust_lt;
+
+	ret = cdn_dp_mailbox_read_receive(dp, dpcd, nregs);
+
+err_adjust_lt:
+	if (ret)
+		DRM_DEV_ERROR(dp->dev, "Failed to adjust Link Training.\n");
+
+	return ret;
+}
+
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.h b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
index c4bbb4a..b5472ad 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.h
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
@@ -156,6 +156,14 @@
 #define DP_FRONT_BACK_PORCH		0x2278
 #define DP_BYTE_COUNT			0x227c
 
+/* dptx framer global config fields */
+#define DP_FRAMER_NUM_LANES(x)		(x - 1)
+#define DP_FRAMER_EN			BIT(3)
+#define DP_FRAMER_RATE_GOVERNOR_EN	BIT(4)
+#define DP_FRAMER_NO_VIDEO_MODE		BIT(5)
+#define DP_FRAMER_DISABLE_PHY_RST	BIT(6)
+#define DP_FRAMER_WR_FAILING_EDGE_VSYNC	BIT(7)
+
 /* dptx stream addr */
 #define MSA_HORIZONTAL_0		0x2280
 #define MSA_HORIZONTAL_1		0x2284
@@ -323,10 +331,13 @@
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
+#define GENERAL_REGISTER_WRITE		0x05
+#define GENERAL_REGISTER_WRITE_FIELD	0x06
+#define GENERAL_REGISTER_READ		0x07
 
 #define DPTX_SET_POWER_MNG			0x00
 #define DPTX_SET_HOST_CAPABILITIES		0x01
@@ -346,6 +357,7 @@
 #define DPTX_SET_LINK_BREAK_POINT		0x0f
 #define DPTX_FORCE_LANES			0x10
 #define DPTX_HPD_STATE				0x11
+#define DPTX_ADJUST_LT				0x12
 
 #define FW_STANDBY				0
 #define FW_ACTIVE				1
@@ -424,6 +436,122 @@
 /* Reference cycles when using lane clock as reference */
 #define LANE_REF_CYC				0x8000
 
+#define CDN_DPTX_FRAMER				0x02200
+#define CDN_DP_FRAMER_GLOBAL_CONFIG		(CDN_DPTX_FRAMER + 0x00)
+#define CDN_DP_NUM_LANES(x)			(x - 1)
+#define CDN_DP_FRAMER_EN			BIT(3)
+#define CDN_DP_RATE_GOVERNOR_EN			BIT(4)
+#define CDN_DP_NO_VIDEO_MODE			BIT(5)
+#define CDN_DP_DISABLE_PHY_RST			BIT(6)
+#define CDN_DP_WR_FAILING_EDGE_VSYNC		BIT(7)
+
+#define CDN_DP_SW_RESET				(CDN_DPTX_FRAMER + 0x04)
+#define CDN_DP_FRAMER_TU			(CDN_DPTX_FRAMER + 0x08)
+#define CDN_DP_FRAMER_TU_SIZE(x)		(((x) & GENMASK(6, 0)) << 8)
+#define CDN_DP_FRAMER_TU_VS(x)			((x) & GENMASK(5, 0))
+#define CDN_DP_FRAMER_TU_CNT_RST_EN		BIT(15)
+
+#define CDN_DPTX_STREAM				0x03000
+#define CDN_DP_MSA_HORIZONTAL_0			(CDN_DPTX_STREAM + 0x00)
+#define CDN_DP_MSAH0_H_TOTAL(x)			(x)
+#define CDN_DP_MSAH0_HSYNC_START(x)		((x) << 16)
+
+#define CDN_DP_MSA_HORIZONTAL_1			(CDN_DPTX_STREAM + 0x04)
+#define CDN_DP_MSAH1_HSYNC_WIDTH(x)		(x)
+#define CDN_DP_MSAH1_HSYNC_POL_LOW		BIT(15)
+#define CDN_DP_MSAH1_HDISP_WIDTH(x)		((x) << 16)
+
+#define CDN_DP_MSA_VERTICAL_0			(CDN_DPTX_STREAM + 0x08)
+#define CDN_DP_MSAV0_V_TOTAL(x)			(x)
+#define CDN_DP_MSAV0_VSYNC_START(x)		((x) << 16)
+
+#define CDN_DP_MSA_VERTICAL_1			(CDN_DPTX_STREAM + 0x0c)
+#define CDN_DP_MSAV1_VSYNC_WIDTH(x)		(x)
+#define CDN_DP_MSAV1_VSYNC_POL_LOW		BIT(15)
+#define CDN_DP_MSAV1_VDISP_WIDTH(x)		((x) << 16)
+
+#define CDN_DP_MSA_MISC				(CDN_DPTX_STREAM + 0x10)
+#define CDN_DP_STREAM_CONFIG			(CDN_DPTX_STREAM + 0x14)
+#define CDN_DP_RATE_GOVERNOR_STATUS		(CDN_DPTX_STREAM + 0x2c)
+#define CDN_DP_RG_TU_VS_DIFF(x)			((x) << 8)
+
+#define CDN_DP_HORIZONTAL			(CDN_DPTX_STREAM + 0x30)
+#define CDN_DP_H_HSYNC_WIDTH(x)			(x)
+#define CDN_DP_H_H_TOTAL(x)			((x) << 16)
+
+#define CDN_DP_VERTICAL_0			(CDN_DPTX_STREAM + 0x34)
+#define CDN_DP_V0_VHEIGHT(x)			(x)
+#define CDN_DP_V0_VSTART(x)			((x) << 16)
+
+#define CDN_DP_VERTICAL_1			(CDN_DPTX_STREAM + 0x38)
+#define CDN_DP_V1_VTOTAL(x)			(x)
+#define CDN_DP_V1_VTOTAL_EVEN			BIT(16)
+
+#define CDN_DP_FRAMER_PXL_REPR			(CDN_DPTX_STREAM + 0x4c)
+#define CDN_DP_FRAMER_6_BPC			BIT(0)
+#define CDN_DP_FRAMER_8_BPC			BIT(1)
+#define CDN_DP_FRAMER_10_BPC			BIT(2)
+#define CDN_DP_FRAMER_12_BPC			BIT(3)
+#define CDN_DP_FRAMER_16_BPC			BIT(4)
+#define CDN_DP_FRAMER_PXL_FORMAT		0x8
+#define CDN_DP_FRAMER_RGB			BIT(0)
+#define CDN_DP_FRAMER_YCBCR444			BIT(1)
+#define CDN_DP_FRAMER_YCBCR422			BIT(2)
+#define CDN_DP_FRAMER_YCBCR420			BIT(3)
+#define CDN_DP_FRAMER_Y_ONLY			BIT(4)
+
+#define CDN_DP_FRAMER_SP			(CDN_DPTX_STREAM + 0x10)
+#define CDN_DP_FRAMER_VSYNC_POL_LOW		BIT(0)
+#define CDN_DP_FRAMER_HSYNC_POL_LOW		BIT(1)
+#define CDN_DP_FRAMER_INTERLACE			BIT(2)
+
+#define CDN_DP_LINE_THRESH			(CDN_DPTX_STREAM + 0x64)
+#define CDN_DP_VB_ID				(CDN_DPTX_STREAM + 0x68)
+#define CDN_DP_VB_ID_INTERLACED			BIT(2)
+
+#define CDN_DP_FRONT_BACK_PORCH			(CDN_DPTX_STREAM + 0x78)
+#define CDN_DP_BACK_PORCH(x)			(x)
+#define CDN_DP_FRONT_PORCH(x)			((x) << 16)
+
+#define CDN_DP_BYTE_COUNT			(CDN_DPTX_STREAM + 0x7c)
+
+#define CDN_DPTX_GLOBAL				0x02300
+#define CDN_DP_LANE_EN				(CDN_DPTX_GLOBAL + 0x00)
+#define CDN_DP_LANE_EN_LANES(x)			GENMASK(x - 1, 0)
+#define CDN_DP_ENHNCD				(CDN_DPTX_GLOBAL + 0x04)
+
+#define CDN_SOURCE_VIDEO_INTERFACE		0x00b00
+#define CDN_BND_HSYNC2VSYNC			(CDN_SOURCE_VIDEO_INTERFACE + 0x00)
+#define CDN_IP_DTCT_WIN				GENMASK(11, 0)
+#define CDN_IP_DET_INTERLACE_FORMAT		BIT(12)
+#define CDN_IP_BYPASS_V_INTERFACE		BIT(13)
+
+#define CDN_HSYNC2VSYNC_POL_CTRL		(CDN_SOURCE_VIDEO_INTERFACE + 0x10)
+#define CDN_H2V_HSYNC_POL_ACTIVE_LOW		BIT(1)
+#define CDN_H2V_VSYNC_POL_ACTIVE_LOW		BIT(2)
+
+#define CDN_DPTX_PHY_CONFIG			0x02000
+#define CDN_PHY_TRAINING_EN			BIT(0)
+#define CDN_PHY_TRAINING_TYPE(x)		(((x) & GENMASK(3, 0)) << 1)
+#define CDN_PHY_SCRAMBLER_BYPASS		BIT(5)
+#define CDN_PHY_ENCODER_BYPASS			BIT(6)
+#define CDN_PHY_SKEW_BYPASS			BIT(7)
+#define CDN_PHY_TRAINING_AUTO			BIT(8)
+#define CDN_PHY_LANE0_SKEW(x)			(((x) & GENMASK(2, 0)) << 9)
+#define CDN_PHY_LANE1_SKEW(x)			(((x) & GENMASK(2, 0)) << 12)
+#define CDN_PHY_LANE2_SKEW(x)			(((x) & GENMASK(2, 0)) << 15)
+#define CDN_PHY_LANE3_SKEW(x)			(((x) & GENMASK(2, 0)) << 18)
+#define CDN_PHY_COMMON_CONFIG			(CDN_PHY_LANE1_SKEW(1) | CDN_PHY_LANE2_SKEW(2) | CDN_PHY_LANE3_SKEW(3))
+#define CDN_PHY_10BIT_EN			BIT(21)
+
+#define CDN_PRE_EMPHASIS(x)			((x) & GENMASK(1, 0))
+#define CDN_FORCE_PRE_EMPHASIS			BIT(2)
+
+#define CDN_VOLT_SWING(x)			((x) & GENMASK(1, 0))
+#define CDN_FORCE_VOLT_SWING			BIT(2)
+
+#define CDN_DP_TRAINING_PATTERN_4		0x7
+
 enum voltage_swing_level {
 	VOLTAGE_LEVEL_0,
 	VOLTAGE_LEVEL_1,
@@ -479,4 +607,11 @@ int cdn_dp_get_edid_block(void *dp, u8 *edid,
 int cdn_dp_audio_stop(struct cdn_dp_device *dp, struct audio_info *audio);
 int cdn_dp_audio_mute(struct cdn_dp_device *dp, bool enable);
 int cdn_dp_audio_config(struct cdn_dp_device *dp, struct audio_info *audio);
+int cdn_dp_register_read(struct cdn_dp_device *dp, u32 addr, u32 *value);
+int cdn_dp_register_write(struct cdn_dp_device *dp, u32 addr, u32 value);
+int cdn_dp_register_write_field(struct cdn_dp_device *dp, u32 addr,
+				u8 index, u8 nbits, u32 value);
+int cdn_dp_adjust_lt(struct cdn_dp_device *dp, u8 nlanes,
+		     u16 udelay, u8 *lanes_data,
+		     u8 *dpcd);
 #endif /* _CDN_DP_REG_H */
-- 
1.7.1

