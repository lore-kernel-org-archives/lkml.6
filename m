Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E035C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08648208D9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RfY+aTd3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08648208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbeHPWpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:45:46 -0400
Received: from mail-by2nam01on0078.outbound.protection.outlook.com ([104.47.34.78]:46928
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725835AbeHPWpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCI7KRuClDf2o9p8iWvcx0Ymn/p+IBlKOslbUssCMLM=;
 b=RfY+aTd3ECv45MZb8ic70tM7v/ZVn1EPyNiKuUztrHOAMnWgN9YTKlc62UuhQcKRNESP05pA03Fi4e/LRbtLmlm4ToNp/TxI1KjI9vWEfzP/ibmLznZphYBAStlHZoy7SnoR693JYCeRMLqasM9ub3VWnbJ+sx2fEET/VGKqnRw=
Received: from SN1PR12CA0053.namprd12.prod.outlook.com (2603:10b6:802:20::24)
 by MWHPR1201MB0128.namprd12.prod.outlook.com (2603:10b6:301:55::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.22; Thu, 16 Aug
 2018 19:45:16 +0000
Received: from CO1NAM03FT030.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::204) by SN1PR12CA0053.outlook.office365.com
 (2603:10b6:802:20::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.15 via Frontend
 Transport; Thu, 16 Aug 2018 19:45:15 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV02.amd.com (165.204.84.17) by
 CO1NAM03FT030.mail.protection.outlook.com (10.152.80.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1059.14 via Frontend Transport; Thu, 16 Aug 2018 19:45:15 +0000
Received: from SATLEXDAG01.amd.com (10.181.40.3) by SATLEXCHOV02.amd.com
 (10.181.40.72) with Microsoft SMTP Server (TLS) id 14.3.389.1; Thu, 16 Aug
 2018 14:45:14 -0500
Received: from leodev.amd.com (10.180.168.240) by SATLEXDAG01.amd.com
 (10.181.40.3) with Microsoft SMTP Server id 14.3.389.1; Thu, 16 Aug 2018
 15:45:13 -0400
From:   <sunpeng.li@amd.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <arnd@arndb.de>, <michel.daenzer@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <airlied@linux.ie>, <Jordan.Lazare@amd.com>,
        <harry.wentland@amd.com>, "Leo (Sunpeng) Li" <sunpeng.li@amd.com>
Subject: [PATCH 2/2] drm/amd/display: Don't build DCN1 when kcov is enabled
Date:   Thu, 16 Aug 2018 15:44:39 -0400
Message-ID: <1534448679-13823-2-git-send-email-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534448679-13823-1-git-send-email-sunpeng.li@amd.com>
References: <1534448679-13823-1-git-send-email-sunpeng.li@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(2980300002)(428003)(199004)(189003)(53936002)(426003)(7696005)(476003)(2616005)(126002)(446003)(336012)(11346002)(486006)(186003)(26005)(76176011)(53416004)(51416003)(50466002)(105586002)(16586007)(77096007)(8936002)(106466001)(14444005)(6306002)(110136005)(54906003)(86152003)(48376002)(316002)(50226002)(8676002)(36756003)(86362001)(72206003)(97736004)(81156014)(81166006)(305945005)(4326008)(2201001)(68736007)(2906002)(6636002)(966005)(2876002)(478600001)(6666003)(47776003)(5660300001)(356003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR1201MB0128;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT030;1:23aj5H23r1c4tIV4n5vKO9CnDc2vhKzJAwoYZ6YCoi4kjanGeI0JJQtu0fajIPN50sHqlBsSqj/H34KA0EoHmoFWBJK5n/yELaO9iOZOU0ucZ+OVclg5tszJrHIrIJQQ
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5092c8e-977d-4ae3-7f94-08d603b0c9da
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060);SRVR:MWHPR1201MB0128;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0128;3:/YArFlwC8BWaWWVzJXNYR877iATH0XBuC2nAI0K4uPRlXrw+FIa+u3X200gpmUebBKi2r9HBldtJQqkR8u6p8kd/GUYo2AqAymbmcbWsQ4K+6tK8HftUpfUwOcstkkOm2vaGz41e5v8qh92FS5QUE/SvAEqNiZYbBK4HTsanRBC0RlQuICb6EP+86VFbQ+gYX3H+2X3Ymnf9foWUlg496LQUwbYgib/wk44ia11zgLu1J/h17IecdFPQDsLye+eCU6UGO8n4biPxWsS9P9AQ3cVhqNe5OvZIZCnri7uZELh2aM38Z6KSlDhglYwxoxZ9Mr8KBukDTiz4HH0LR8GDwk4sD461BCgkrf7fTvcj/Es=;25:P4pyAZ+GitMa6ykjsdi0GS+P9lL6T/sX3CYGgPgwLPeCcutp/IN87dSRX7a69+rba8o/7XCN74+teomD4uoxetRWNGTK8x+VZGpKYCc79sn/gGWEtwJz4mbVe45rtfvRY48ngbLzuANq0ZXMHRmux+6spgVrDQ2TJzwIDNR5wrTBz1B2sf4hhqXjYz8xy0/XVWOmISfAzR9k15XFDos5Orea/lczJLqaVXDY7IqdE3UveP/ltC1IrGyAhph9P7lhSaa9U0j+dAa/XqdXHqZAd73bFOpk6/PMeH4nvxNOoy9kK+dlu9HqiyiueAXayYHHjYERYdG4OgJpUN8lt55DFA==
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0128:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0128;31:qFoh1aVvrgzUv2Jlvhj9RM7LLq0iC4/9EEAH4hZR7GIvR99Z9Sbu6wbloVzRfZ7nBqsKPtu9drhIqXw1kE5JehWCTFP5o7TiMieB9ORntDHLwbl+egI6xenCHbE1aPPC59MdJUh6vBNxPIUMVkIxraGh14CyRxRhMPGYbHCzSyb9RiDjqN5uSUgz5qJmLkK/IOkzv8UWw2EUW1MuAEQpai230Lm49O0FLlwlvCMmSH0=;20:N8JeOuCXZoCSHBe0u1MrFgADwyRACTpSLvIEt+KW0jjOg5Emfa+vzuzqEb0N5GLYbP328DV/weNroNfiEG12OVHjljf/ioizJysFYZYD4tI26kGO+Ueg5WpNgWz5Je82v6BDip9ZzqTN9RJQRJ4PF1M3RexMrf9rgNPtSM4W9PSYtQgFciJsvekUoIOfUVZNw307X1gjzkKHYKs9wpSzVUW+oXsWdR9/U/9zOwP4dE2dkuL9LyBASFLmeUntXuzcXTGwVju51oDv/jUPukpZ6TKg95M8YFHfc+JumkLGBGoduFgI2aj/lCf8pAJw4zBCa1l9D4X0JqbEsQJUexiekGYdcrB2EsLLqb4DlnHzzoycjInVCxNaeNIfal5jaydIuZJoTDXfGaq0cZPgZzWRtXNT10wG1t0S1+Y/ZYeNedQk702qvi/PpKn6kbkl/Vj53mMNZmCh9g3eehCsmBZm2dVix6c5Qx2xwo0Rt+DBfO+5AwPufF2dYUN+mnHlP86F
X-Microsoft-Antispam-PRVS: <MWHPR1201MB01286455D693E4949063C853823E0@MWHPR1201MB0128.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(217544274631240);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:MWHPR1201MB0128;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1201MB0128;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0128;4:16L9hASSofzTaNsa/CtxyB22ZhAF1V/taC3G3btlxilFXajdWWOXs+aWG0xQaoV8ABxCeuNYibN09VmbJlus9UexGin7PoIQjSV0/onVXs47ejshUIlYX2k84vOICx+X1UWRrwws0ZC6lunPvtbEegYnI6SR4qOh2HzxnqEhkhzEOIwa+WSYlL/mfDlaI4nV3shmXfDX4XTE6tAhlLb/oFz+CsdrG4UjDuJChzWoyFvpIAOi4EMYBRkQ55Hkj10k75Xi/D0D5EthT3cbR+nOHcZZ9Ze3S8eO+9qpyAXuNcaaXFhybx2qLptCU5TwPw9fZQn/vyrch9VJQP3kfabPRfIqUc+riLRX63QmRTkH2Ho=
X-Forefront-PRVS: 07665BE9D1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR1201MB0128;23:Wb/kIqqqvOkL0+YwSN8tRj/YXbr+xd8QQkpwW/E?=
 =?us-ascii?Q?xGenoc4fUd04Yr5mqdwgI/+l85ZQoVvh7YfgnX1laS45EdPv1FPiPlZdOKFl?=
 =?us-ascii?Q?b4iXpqZ6HM0IIlpfwu1CBI6Ke81kHQMxxU6tnOsYYdNTs+bY4unGZuRHWBlh?=
 =?us-ascii?Q?7hXmKjzrYldHKYEo4CrYOOAsUFZq7AJVQK5iOjENWk/nPnDQtHQcuZf9ovAT?=
 =?us-ascii?Q?QKriDc63+rLMQldnrcb3L/bTyyaTSWwlzbVFYNUiEE7yekRimJyd78vTRgRU?=
 =?us-ascii?Q?iNt4Bno1aP+r5Cjjl0hNnQX+Zw7mffLy3ya0zUY0aIMSA3GQMZJ2pbdC8AGU?=
 =?us-ascii?Q?S0bPxqMcY0Fu4AMGcQHItmMO1RuMcvyeEL8/0SlwbjDYnfp3AXCTSZucPhTi?=
 =?us-ascii?Q?YCP+2CXhB3ofF8Foaz3hAH2M/G2lvCpXnIBjBdnXhWe+MYNpoMirMw9KWBr3?=
 =?us-ascii?Q?zA/USq5oNIOe2Xato5HNEVt4/ftWa5LKwDNL0iTyCWjMcQLOzFQQ2eqCvE6s?=
 =?us-ascii?Q?JXtYR10Hw6DZX/re8QRXsMBuYRHNkM0bXIJPkkXIHWymnmyDnwk0dVgO5Fbk?=
 =?us-ascii?Q?d9xAm/xzYdViRjz0+Ntxvtcu+P0jBH5HPPL76knE3b4WTHxOn5xWrjwpMfaJ?=
 =?us-ascii?Q?hTz8XiRBjza5Qq6R2GdgM8ndFJRG1OK3OWbtFFlqj5VAxnVBbSm0hetmtfwN?=
 =?us-ascii?Q?1+x7souOrmj5wWzN/jqQ8fPkOV6yBEmAOVwSaCEfYQSMcTF/KSgzVvKsBTx5?=
 =?us-ascii?Q?mJEgtTBXX4+IMihxxtefcF/OaR+X3PDoRsYOfHIlioA5PA92186PI2DBKz9J?=
 =?us-ascii?Q?sa+1SwNo7l+V6/srFiD/IPHerrdzkt2BQ7wutq1EdP+FCQ7+fFRmgcth6Nai?=
 =?us-ascii?Q?fT/6H9z0vsY++hOupUVmII8ne7AXMRggcLKUiWidzIILDoAJ3pAzY0qNPV/Z?=
 =?us-ascii?Q?4oDg0jD4Oc9LXIvB+UW/Ba2tpUi3pYhoW6ApXqhYuhBeLTk7AfAEz3J2bOvN?=
 =?us-ascii?Q?4aZRMgTaUaWCftDiuGdM2GEOWwLaHKPYuG+4jq5q/B2HKYNSVCXNJYuvxJEs?=
 =?us-ascii?Q?BalSQZCS0eo9hQfZuihHU+AqwBVZW4LRAFjKMpxFk82R9+5zmUAJLFzm+DjE?=
 =?us-ascii?Q?ft6uo8mF62pW2pLgArB3Qhyp1zCx3XP+E8AgG2T5+JPXdQUGrEwpZa2dIb/Q?=
 =?us-ascii?Q?v4+FQcBvMwu7yV0DF3U85xRlSaYmKgvZvnq1IkNc+jtkXtp/6DRxSLr+BeQd?=
 =?us-ascii?Q?pOrgY8aN/6fsc80eGN7h0dAk4nZ9ELV5v3yytnBgn?=
X-Microsoft-Antispam-Message-Info: QmLV+tdd9ojtI+UuWQgu4VGssHQfeaYb/VPc0ASB3Y4I5V9kMosRHTZ8tzzQybjLq0QHsJh/L4v5penM3m1FHEYFXwqT1OYgCWXMpHk1KFM48EiLeWe0F6YsGvGKrdlme0LXxUVo7AZinJRIRCs7Qj90C8LfTbmx87kMzZLf83z1pgTu1aOAyQR3XzrTBQeNl/91JnDpeQzcsqHpubk7Ar5y98qBOXo92hkcmiG2G+Db1BwtYRMdW3d4iduSN23/Hnhmbx7H1lKvuce6EisaObAQWK4MfdkAkxziwe8nCwrzjVab7SwXyGf+O2m7QZrn483KPJqR0vDslIka6b9SnL+t4DBEbCgM0U+RSZ54Q4M=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0128;6:9C4NSa2zoXVqZC1R4+WwwVMmOt8bLPuEBJEngwp15sQzsJs4wOgYrREdqtxhJiNPQl+6//P7jges5XkQ/OtiO6zQ80U5uwLK1lEJimBcFSvu61nmLYeZ4boGuNNMJMalnLnpKkcPdu3o23K+2oLsdFp+iAFuEkXFsmIsHA3shJkraGO2S9rJ/5MQZtJSrnyjGh/YeyS2qXnOeWUVL0ejVp+W8mN6WiOh+tbbb4YDkTxEXYaqSBUtqMY3NvZfBJyG9gDpNaunzTUJnN5XFrfydN1NBlDSj1/o1bRdg7sLBccqNkufssXvCZ2R+7LNddeo1mj5Qubw/REuqlK3nWzf+/PmoMp+4KCFc7TPAy++GFEbOqAqF90cvj6e8hyzZBgCSoysz7IAbaNQvFAdgfOhWfV4WL//po/CauZSFzPps7ojNi6N8lD6s/IOSw3rIbY29mWkTb7hTczVPBHEezQw4w==;5:ZNRh7L/lRFuKqWFtT8WS5Kr5K6WZNUQNXJJrMs6ORgvce+Ab24SNmRWdHTBkapHnY/o/WzgDmDAbYedaIPf3aDtKqAQEdA3r0KS5bOhYFD+K4b6GE8NzfwjA9pFD83GEW5JJU6nO1z4a3fY3V/TDoQpXGHgrq3jOGbXxfPrfLDk=;7:JvJs3jqRU/ecsiGLDK+EtyX8EI0WngFeLTSBHx3DDbi2dcYPzp4HMCjW+k+Hovwy6O7jqIL2sOZdcEbTk4I0RUp9Ht6sFMP+fpzb8an/G846TrDe5VEUKJi1OvtM3p7Ohdq/WL3hAD0Ys0UsWcwuVnwN1I4xsdXpYI7YlFwNtP0EGCIkIX4prIIl3dstSllbz+AAqBvdVb1odJeHzm5ObpGDcMmWjaywWyB7XkJ+0VSOovrJNzxBfml9ZKN4pXwl
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0128;20:/h/IFqTmX8bkLaiRJUXfOXFN9OkGZMnIiStpEdb7guKIh0zBkexUnCjUO7095IQQSQkg3WePj2hhY5thRzY0xoJBpOV2mQJ5X8z657CI16jsJpMkRMwQLPezwj/nl6fR1iuStC4shX5U6BbHDO2lC/cwDvecyEgHOCanvX0R+Jjd9hxC/6nn0yuvXfGGdp3Qo6PHa8MdElsR1bG3i1zEXScthJgx0s+26juUWABFwn+NGaM8P1l0C0wVTKFJVDeW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 19:45:15.2983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5092c8e-977d-4ae3-7f94-08d603b0c9da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Leo (Sunpeng) Li" <sunpeng.li@amd.com>

DCN1 contains code that utilizes fp math. When
CONFIG_KCOV_INSTRUMENT_ALL and CONFIG_KCOV_ENABLE_COMPARISONS are
enabled, build errors are found. See this earlier patch for details:

https://lists.freedesktop.org/archives/dri-devel/2018-August/186131.html

As a short term solution, disable CONFIG_DRM_AMD_DC_DCN1_0 when
KCOV_INSTRUMENT_ALL and KCOV_ENABLE_COMPARISONS are enabled. In
addition, make it a fully derived config, taking into account
CONFIG_X86.

Signed-off-by: Leo (Sunpeng) Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/display/Kconfig | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 4c35625..ed654a7 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -4,18 +4,16 @@ menu "Display Engine Configuration"
 config DRM_AMD_DC
 	bool "AMD DC - Enable new display engine"
 	default y
+	select DRM_AMD_DC_DCN1_0 if X86 && !(KCOV_INSTRUMENT_ALL && KCOV_ENABLE_COMPARISONS)
 	help
 	  Choose this option if you want to use the new display engine
 	  support for AMDGPU. This adds required support for Vega and
 	  Raven ASICs.
 
 config DRM_AMD_DC_DCN1_0
-	bool "DCN 1.0 Raven family"
-	depends on DRM_AMD_DC && X86
-	default y
+	def_bool n
 	help
-	  Choose this option if you want to have
-	  RV family for display engine
+	  RV family support for display engine
 
 config DEBUG_KERNEL_DC
 	bool "Enable kgdb break in DC"
-- 
2.7.4

