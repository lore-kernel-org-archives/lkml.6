Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED635C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB8B23E65
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="LSif+jMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB8B23E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933673AbeGCKDA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:03:00 -0400
Received: from mail-bn3nam01on0060.outbound.protection.outlook.com ([104.47.33.60]:39528
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754469AbeGCKC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqdHBXhkmCjJ3PwfyIaDMiK0z9pCQtNDY/oeaaOXd84=;
 b=LSif+jMDzvQTsIH7iKlGF1NvdxvAs5rp6v9ZoD5ix6STAK+zbb7ZX4C0KOOimURaXzfeI1Zvwy1VQSUMRxgxbSQZDXyFVffgUuwe8T1M7RXXYX7ZSFfJfi3CRznFoOf/ZPG+vcZ7t71xFEu0aP7ci8zSEmGrS6+f0NOTzJ/kiIk=
Received: from CY1PR07CA0021.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::31) by CY1PR0701MB1340.namprd07.prod.outlook.com
 (2a01:111:e400:4c1b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.24; Tue, 3 Jul
 2018 10:02:54 +0000
Received: from DM3NAM05FT055.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::206) by CY1PR07CA0021.outlook.office365.com
 (2a01:111:e400:c60a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.930.18 via Frontend
 Transport; Tue, 3 Jul 2018 10:02:54 +0000
Authentication-Results: spf=softfail (sender IP is 199.43.4.28)
 smtp.mailfrom=cadence.com; padovan.org; dkim=none (message not signed)
 header.d=none;padovan.org; dmarc=fail action=none header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM3NAM05FT055.mail.protection.outlook.com (10.152.98.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.930.2 via Frontend Transport; Tue, 3 Jul 2018 10:02:53 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w63A2mT6018897
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 3 Jul 2018 06:02:50 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 3 Jul 2018 12:03:04 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Jul 2018 12:03:04 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w63A2lXc028172;
        Tue, 3 Jul 2018 11:02:47 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w63A2eGw028041;
        Tue, 3 Jul 2018 11:02:40 +0100
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
Subject: [PATCH 00/12] drm: add support for Cadence MHDP DPI/DP bridge.
Date:   Tue, 3 Jul 2018 11:02:11 +0100
Message-ID: <1530612152-27555-1-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(136003)(2980300002)(199004)(189003)(36092001)(26005)(5660300001)(126002)(2616005)(86362001)(356003)(47776003)(486006)(81166006)(42186006)(16586007)(110136005)(54906003)(51416003)(305945005)(8936002)(81156014)(97736004)(476003)(2201001)(426003)(8676002)(105596002)(48376002)(336012)(6666003)(316002)(69596002)(106466001)(50466002)(478600001)(36756003)(68736007)(50226002)(107886003)(186003)(14444005)(7416002)(53936002)(4326008)(2906002)(87636003)(26826003)(921003)(2101003)(1121003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1340;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT055;1:PLHmzGYsmAJE04xr6Nu26mAAfWx3KWSdzisbwF7R/bXo5x0VMDYrPnSCBazR9WGjfvzxMpEGA4bTAW6loH4iITvhGI+45vfQTFuU2THsGEQoSd9sfC7Y2RvUySN1ax0W
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59478bb2-8007-4679-58a3-08d5e0cc2526
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:CY1PR0701MB1340;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1340;3:lJy3dmMHjcbOwAIhPoj2hyyFI2c5fhhFi4NhTrvdaOfk8ttAgndxpZLKY+xY9sCgowW0zt1ft1ujkmFLRct9QBMFhJIEdHiM+4wdA4hu1Tdu9cBOC3SNnk8uB8wJ0bRXSj1xxvqozAAk0tTi/TttUFJci4BxQswX2RiYlEbkr/2xBiGTElo5kJrmkP7/9QnE8JRqzqypSmTck8xJjgb9CxKtzeMfDlqzXRqvouRSDxwzQrG4HHkXsPSo8FXPpqneA7fe9qYZnGJxlksH9uTdSuaD48J8vxlgHQoszKqIWgnrOvmfEbqJ+9M4hHwN9CV7EDoOBVZvLdq5RMlrWOs6Iw==;25:R4zgg8zIP2hOdib3ATHhk2jazEvW3gswZAclksjpDWCc4pMuGJ376cJKx0BgQyzukCBrgTCYtgunWVSvVQrVNWgEx0/jWgQDo9z20ohpQ1wlu4DaLYF5ei4FS8CqMd0AxruV0DtBQVC8GwlEvYLngRcrQkN08yicDk+eMIIGT5+qtCQ0e//Mg5MODYmQvm+xhJnMJkz3dGNRheSRtACIs7PQ4HA4GEIPF1RtpzCRpmKb6kRO8nwflMMBG46b8VbljwSEqSNSB9yGfDQr1lwt+KoGzkN19cQpIy5m1jy8Y9ZGwOCvlqasyrmzeVJpa/7m3IE1bRfefpfWFkGapX6eOw==;31:efStKC5ibJIWNECK5YTJJsfz8QikDTbd6kKRy0ByUpJJUZ01uqEQOyth5/Tpd0qbq5RHpwCd6skOuMHV/pb+vD3sSD+RnoAi47hvq/l53xCnZ9JUzmpoJYZD/lv6osmN8yUHFFBw2ga3jh66FfCFlvYAkKFz1iOF3itnaf07p8LPRJmnsuV2wAZxd88f07PMK/St+qbhZ9fD735VTtB7w62B+ntdDneXNPjlQY4rIqE=
X-MS-TrafficTypeDiagnostic: CY1PR0701MB1340:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1340;20:BTXyDLM1vZ5sVqpsI/jc4n2wk9eedUYdpJaMMk+Unh/fVJ1rsW6qPcojTN4V9hePENzOoCE/pZoyKg5tKkDz4t0Itkd2hHQAIZMYhf6PVd36kX+wicfulBtDED3CbblmEhpFqFkcdYJ3ofIaZnpF93Wjv2E+X/coxufJJvKR+MAQcwKcSxCGLkYL660HvncxyKcn5EebkGpwf4p3z/f76aUQhM1LfOkFD7Ft0BdBsltnH/NLa6jkFT5qDAL8S6gMt/W64i2k1tJsN6E4Zqo5q7oeyLEzVkZ/a+Tu2EvCzVDB8oov66Mqm4GJ39Ek9lmp2+rn184V3AJzm8WEUwr1x+aCLFBMLlAfVnD6JG+aZBaUFqN6LthWfU3lumwY08XxpgKtlvoTVMc47659uPmvF3IxzYP4+KGyyoT8VTNQNQhRXIBo6uVfHRZmyso18wGZ+8ql7O6Bax8FeqRfDDdL7ruf3q29gpqKbb7fnCtwxndZ+xNEN67SBMf0uYz5+2eV;4:pYcFXjI+bl6mAPWaRZX7WM1Opb0KbBBoSPAq0aZkpKLVSrSAE5SpRd6+vWehp7k1kncGl/hPJo7lIU5T+7fh5H+v37CBH7Fx687w1ahFVAqMWxHfekkfaGuSCXEXItZCGPYFuiLaPKiMMdeJB470PprIPph72mksqi7210hkLsHcNgnXghgbIsO4CgeVb3rCWDC15eNll4ZFOIw+UIAcILgxGRlR/NOgq/abAIFmF7St50KPVlRFTBgzuIwFrUcJcJ4E6/xlvxNLhEDy6PtBkg==
X-Microsoft-Antispam-PRVS: <CY1PR0701MB1340A2DB636DC47B47F35E16CD420@CY1PR0701MB1340.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY1PR0701MB1340;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1340;
X-Forefront-PRVS: 0722981D2A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0701MB1340;23:6cwhw0I8frP3cF2Q5y/g4s0Bx/amJrFWckcJFc+?=
 =?us-ascii?Q?ryq2LuGiLCYGazWw4CdXNbFU+bxxSbjoShY89q8mksIPbi7G6jf2avFO7KO7?=
 =?us-ascii?Q?gGqT84BMRp73llv4JyTABifrZ+qUHqI7gwUwqAfo1xCsVU8EEmp+qoPE1vcH?=
 =?us-ascii?Q?+hbN2GhpZPNIzifDxOy//LO38lSUVEnCtMNaAJavLnxcu691q0Amzl8yR68Z?=
 =?us-ascii?Q?m8skP8WhYts9ZM9tZcjeZQi858/mK14+ayEJFIWA4spudJKUoD52dVoav7b0?=
 =?us-ascii?Q?evdn2ixIy4+FuL8rOErpoV6usSAnCHsfGhbnP+WsdZtVLJr78Zjce7ALZi9N?=
 =?us-ascii?Q?DSFFxrdC6KtBdefBVWUCCd88bv/BNzWYauKLZmYTXSm4jwL3ksvi6d9TAe4u?=
 =?us-ascii?Q?TUcg9Hab7gsR5pEg4mJKkMTzckj2ukTnSpgW6paA23+vDuuW6xj8sVkt/ISq?=
 =?us-ascii?Q?gSUY+kML67e71DQ2aUv4hbWVEn5zSkKU/uQJb5UTyXUvlq3HZ/99QyGFnHzF?=
 =?us-ascii?Q?BTGjJN2Ob4jiKu6UL4UTHWVRyVtEhH+W76wrLCUg44VhVviOugsTwznTI4p3?=
 =?us-ascii?Q?05zKCscVeRQIZWQITXPl1fJfzY0LQr/eidivR3AZkLqjakraZKFl/WyJdtOB?=
 =?us-ascii?Q?CWj0L2dQZpfH2c60/Jj7EgmXmFPMKviaOiIJGMlYMYZomOtskP16rvAT8fTh?=
 =?us-ascii?Q?AhRkTsSzv+76230/HLwUpBwaLNGt5WgUzItdMEdvMrf1izAmPsE53rwRCr7z?=
 =?us-ascii?Q?P9ZG6fHKCyRiDXLHTRYQa2zNz/x4vVbGtAHF1xaD8wFI+VxKBBdDgLKjYt3E?=
 =?us-ascii?Q?kvRtRVoo0zEW5Nkg/9h6mEEVPFa53eyQgpx2+4noxVo+mkdMA94QwCRRn9Jk?=
 =?us-ascii?Q?DzWvILijwDQIw9xXd1ppVZ9jt55YuwMMCZu1xscUuQgn8l2UQgbU47iCz4Bt?=
 =?us-ascii?Q?+t9e7/gMmF1og/QiUcs8uqDiO68ofUFBZVV8l2ZB+g/linUrToWjFbf1w3Xf?=
 =?us-ascii?Q?pW9UWTMg6BOJ5ta6kfVixiXKLc3F5X2K65joOGCl68l9D9cUk/g53WCEYmSE?=
 =?us-ascii?Q?Wlj7tJkF5W5F1w4G/DFMB4lC+Jz3h5hcFeG7h+UOAw6u4Lq8HNG0gKqJmCpJ?=
 =?us-ascii?Q?eSewSwjE47nyzO/+f16Kl8jY4Plqzyk8Uxt8UKfdI6x/odwCKpTs92lSa2I/?=
 =?us-ascii?Q?tdK0DvKkyBTaQsEL9UXIxnopm+zOkZW4lYZj8WOmnAm2moBGR9Oa2Rr4Evm6?=
 =?us-ascii?Q?KyvXYF2PohmIWkSrckW0=3D?=
X-Microsoft-Antispam-Message-Info: zg7k0bRURN8i8GS+jBTfEDDXe1cG+H3tZM6cQnElHBZk3V5HDwlPm7HJnZ5pLs9Kcsvx0aXPKBOlqjOj3o7CXq9CT4Qs3D1HhoQ4FdiWAPyBmWhLhsIlPD4BKE0AjJwnbHI21ScxWs4daUmdn3q55PpAAdk5iWDFnCJm0r9UMOrXjOXPAM6NehO+95NEZ2vvra22XQnVRQKlqI9QQJvGJAfx8VuCD5ILXDsIZDfBw5NYNf5eYBbh3iRvKjPurt5cmXwT8ECevx5WYYHHD6a99x0RtlpzAeisMaB4/27a4TKNQotfITNDZOBQ8JNsiLN8/eB1A1W3s/pBV1eKEFM5UtVJdrantpjwXswSRempP7OqtZG70wdRaGfRTgrzdXqyueO4SV6VYgDIMq02gpcWhA==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1340;6:0ETUoCsI0+y1tr6rrHNiGX7+dIb1BuTTNAkjmzFFMehLvbxmWsSJdzqdATa4YUmi0DUhWQe9OkTACTBGu/Da2fQFdmKMc+b/9KsQng+9tE8/yStcOm8AVmJcH0IIYvuY97R8rTtthrCLQMSxMAmNLWmHsT0g3qyFc5jwLYOj7T1uyva72oADxYhW3BDzgpmtN09VFzky5QNiexyVg2EcXho+rvQ8d1pqnp8VHxwKSuL0uHWbnXKPLkffn/w4cvO6/cruXAQIEIk16EigRNN53sExXBKNVhjVCcBh2e1qdKS1KLx6QOsc4kW/Yebfy8VmugXfra09ieuaqKRmZ01bq/HdPyKyGLkAhpjstm/8wva8fdjeTJBRRY64o32Qq1oygOnc0sYbLu+bhzR+YKyTMkdYMuA3Lp/lpW1UgsjfqxpY33s8GYA9mpq9eNJzxm2yiU6eqdcxjKsuyRv0HZcAaQ==;5:qh/J58OOfpobQzS3NEcqacVdB4SZry2i9BeZJRwrja7eYc0V20Tf53KEek1NSjKKz83JDrftEOcBgC+IaVyVzVyYAgQAt6QPdQ6+4O4TyPT0ZiIEUN6r/GYmk5AJe/VqZ9qxvWTgef+bbhjJb1xX8ZbmiV44wvZCcpFm7MsVK6A=;24:0pNwiQn8IaX/VGvlA++LoL143wqS0SHSaPqTuqNVn8aTOfsAtVJ+UTS5ZwFMjv7J4KVzjcelJJoYJ0ATKvblRjmWOElwPkPHmuT58iiz+Os=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1340;7:qw6nSi51yXDhe2wxZEWZs33u2J8I9p32zN6INUW1fFwFQ/yY+6HnvlKPoRtS3HLiUy6Cf0WRjUcYhJ663q5lujkp4qBCE07CAd4boAoWL58vUslZqX4UzZyU/QpseEo80offyLIv/omCw+OAqfSngLF0JZ0UUr2KiVho11/70kZifoiEmT2CJcuaMILliz/Sz4EPqs8Jc91KexwqlrDlnAbG2ncZyHc3ZgyDxaeiKZk71Fv5P5Ijw3IambDDX3u5;20:4IETbC+S+GbaCVQ9RFnUGmos0t6jaiHi+MKVI/cwYIYWPmkyVeBjH8xgZ4f3/ghM4S5E/SjwF0OXIE0ytFYfPUScb6UNBLlXlZpLXZ4cNAJngFmlupWCk8DiOMR5SkGDbByg/jhNCloLrPw3KvetUrdMdPASgeJGAJghB971MdV0GyGJCwgCXFCeV7EoCG7IK2F3h1Wgim5SPIqOyEhPovk6XA9JvNXoqanmRm2uvZzPpJK/T9bnoNX7ezL+CXBY
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 10:02:53.7398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59478bb2-8007-4679-58a3-08d5e0cc2526
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1340
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Damian Kos (3):
  dt-bindings: drm/bridge: Document Cadence MHDP bridge bindings
  drm/rockchip: added implementation for a few FW commands.
  drm/rockchip: add support for CDNS MHDP IP controller.

Quentin Schulz (9):
  HACK: increase timeout for drm_atomic_helper_wait_for_vblanks
  drm/dp: make dp_link_status and dp_get_lane_status usable from
    outside of the core
  drm/dp: add helpers for drm_dp_set_adjust_request_pre_emphasis and
    drm_dp_set_adjust_request_voltage
  drm/dp: fix training interval formula for DP 1.3+
  drm/dp: fix link probing for devices supporting DP 1.4+
  drm/dp: fix drm_dp_link_power_* for DP 1.2+
  drm/dp: fix drm_dp_link_train_clock_recovery_delay for DP 1.4
  drm/dp: add max number of lanes supported
  drm/dp: add pixel encoding and colorimetry format indicator field in
    MISC1

 .../bindings/display/bridge/cdns,mhdp.txt          |   39 +
 drivers/gpu/drm/drm_atomic_helper.c                |    2 +-
 drivers/gpu/drm/drm_dp_helper.c                    |   97 ++-
 drivers/gpu/drm/rockchip/cdn-dp-core.c             |  953 +++++++++++++++++++-
 drivers/gpu/drm/rockchip/cdn-dp-core.h             |   25 +
 drivers/gpu/drm/rockchip/cdn-dp-reg.c              |  167 ++++-
 drivers/gpu/drm/rockchip/cdn-dp-reg.h              |  147 +++-
 include/drm/drm_dp_helper.h                        |   14 +-
 8 files changed, 1400 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt

