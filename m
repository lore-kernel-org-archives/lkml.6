Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B627C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B26822ACA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 10:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="LQ35TJ4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B26822ACA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934034AbeGCKFO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 06:05:14 -0400
Received: from mail-eopbgr720055.outbound.protection.outlook.com ([40.107.72.55]:61248
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933593AbeGCKDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 06:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UqnjR7H9M3GHWdBVhtm3gAnbBdFmT9+9WyUSAPmn6g=;
 b=LQ35TJ4enC0vDGwdWlJ/R09kxPBzi03Y92qmtlwjx36Xf8542PFS5OM23V6g5stRu3EYwfrVxS6O3ekVqCA8/kaG7eHl3m+Subc4EYkPf9aK2T/xc7oviCYME1GT8hhO+LPrPLFoeLO6p+YI11ezBzEmO+XCxFHWkZkqmmUnJGA=
Received: from BYAPR07CA0036.namprd07.prod.outlook.com (2603:10b6:a02:bc::49)
 by BYAPR07MB4712.namprd07.prod.outlook.com (2603:10b6:a02:f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.25; Tue, 3 Jul
 2018 10:03:41 +0000
Received: from BY2NAM05FT058.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::203) by BYAPR07CA0036.outlook.office365.com
 (2603:10b6:a02:bc::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.24 via Frontend
 Transport; Tue, 3 Jul 2018 10:03:40 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 BY2NAM05FT058.mail.protection.outlook.com (10.152.100.195) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.930.2 via
 Frontend Transport; Tue, 3 Jul 2018 10:03:40 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w63A3bmf023150
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 3 Jul 2018 03:03:38 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 3 Jul 2018 12:03:53 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Jul 2018 12:03:53 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w63A3aB2029955;
        Tue, 3 Jul 2018 11:03:36 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w63A3aXg029954;
        Tue, 3 Jul 2018 11:03:36 +0100
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
CC:     <ltyrala@cadence.com>, <pgaj@cadence.com>, <stelford@cadence.com>,
        "Quentin Schulz" <quentin.schulz@free-electrons.com>
Subject: [PATCH 08/12] drm/dp: add max number of lanes supported
Date:   Tue, 3 Jul 2018 11:02:19 +0100
Message-ID: <1530612152-27555-9-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1530612152-27555-1-git-send-email-dkos@cadence.com>
References: <1530612152-27555-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(39860400002)(396003)(2980300002)(3190300001)(199004)(189003)(36092001)(16586007)(42186006)(26826003)(54906003)(110136005)(6666003)(316002)(486006)(48376002)(87636003)(478600001)(50466002)(426003)(50226002)(47776003)(305945005)(8676002)(11346002)(7636002)(2201001)(2906002)(5660300001)(4326008)(246002)(76176011)(8936002)(26005)(356003)(186003)(446003)(106466001)(36756003)(476003)(336012)(126002)(105596002)(2616005)(51416003)(7416002)(86362001)(921003)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4712;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT058;1:mgD2KY7hEMtaR974ck4V4yjfENeFc3k+I5o0JNfpESmrhyd31FjtylCOSCnXMODl94cuF7GKcKTYJq0EBKskycvcUn65HxBLQuiUqBL6u3gEWRpBVLppnmrTpBsqcLTU
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07823dde-1d83-4ce4-a3ee-08d5e0cc40b6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BYAPR07MB4712;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;3:ayuDtYq8UV2XLi7lTe2HEDHHvF0dXX/IUMDsGQb6zqCN4hzceDDXS/iI+CnpNrVy9g241vZ/wXsltiW7Cf8rwL0HGmof3rUhx8zLPUDOLox1v0XPCOdOzbB9AOI0m9Fy8OFnMXQAhD656k79htC8q+dgGOdp5bNq09G8FT/R7VW7VTM56XMiFzFf56hX965Jh2+sMFrnWocf5wXzk1qmYVUWiMNgCVCAfZuNiaMDmyffcguWlU0H0ul6CQXhTwhk7m64RkMCsJ57mUNiz5idFSp6GtFTxqw7e8h9nGRybAE3u8VJwxasD2RlukGZqtIhQCJiUe2kgmWceClX9Hipp1Ax/cP0+RL9RTtds6CqOiA=;25:3xyHmDE+VwjZKq8reuq9/OWktYBpfg1Q0V4kHWFrVEsXLIoenzFrjVDzXKVGBhE86WDpWBCb8qGrhxDtHLbOCZfgBQNPYQFGVaQvQs/TUpHlrHdn+BGVCiPvVerq/afr1IPcq2RgxT4dqGAQHdId+WEdVmdCc3Z3xg1BOMKHwtWrmnzK5v8m+14KAL6Ul05V80yP+Ny1ptPIM8TLYbKmXohE9e5ENtPnWJE5jlbJ5YO2vMi/3NJn1lJw26iXDrHlYPF78PijEJrUCCLsK9iSMFBZ3+hQcdEziWBzLLDCCjuKkIadjhxhxH3Pja70lyqwX/DBQzPAKdjQuawWx/3/kA==
X-MS-TrafficTypeDiagnostic: BYAPR07MB4712:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;31:SOBqPcZfmehpOji+YrBfEgN3q0Zj0yK0JOMKERCAXsRzwvqBGoWeA+aYVZhm3bbkzghYm8A8xqM3N/FRv2AfEd7G9wlm3LjzOE23u2raUEFkDdg0/U5Ua2W3i4ibUTbbK51TuZW8PmGz51q1IWRi0ZM3dityVGtWqbKwJey4opEIuTUSXDePwHY4qqlyzOY/em8XIR21/VOU0MG05RWFMpYJXbyafeZwyyhoHftaHi8=;20:+JG7nCxpUaiG8FO5tsoTv0axyCldguRD2KiPWwG8MkubYDcfDDWVlb5yGsyEmq6Nc1ll0siWizdyxX/q9Gh4YkX32R6xGqvWcbYT9lGVvvVSW5PKv1ZfrvFQ5SOY/+k6dWfoGKnB61ActNzVjrm1qKjxYJWUZJ2A2uewyFYfMv4gkYjqDY1GD6b5S/Urd2CoSJqxPwHnJn9Ag058uHmlYxRvCaU8/fMq19uAa+fUtli3mmbCpurlPrBOGULj1DE3LryhGfJLPOmsJqDmGXOyWjNm69HZHIjfRdVnTBnERY8+NGdkJxTGucq2IIj49vT/uDcO2D1uNsWfU9KiLzO19FmCk31eL87j076Y+6XaQIfT0/7Ha/dAoUF9zQUboNAJj5LtIMJFb86wxOlZQJcEUR7qOg+fMzPsCXH4j2oQLMMzPwJRbo1GQw1M/GARUFNWcRPEbasyUWJZ158icuBCNuoKRpo6fU22zNJwDyWpCmrmySwzbT9CUUNwwr0D/hm3
X-Microsoft-Antispam-PRVS: <BYAPR07MB471237046BA4CEC1FA8E9402CD420@BYAPR07MB4712.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(58145275503218)(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93003095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB4712;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4712;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;4:o1p2ntcgbjXiPWrMxLdYp3MSH4Tq8h0NRdaf6CTA4L+UK2cUkeJ5/nUD5G6T/mUghnZoGMrrQNxapaUEzobsTSRrsY/fpe2hnhoV1T/yFiHUQ/34k/XGOqrLUn1wx3USgRLFzLEzY2lp3hkZAJO5Zg5oAxHGYatbLXrlFjmJfPQ8JaaeFpX1d5pQhbnvJA/gmYMHkc3f/SFZWMYqS96oPngkqmBAbYfb98aPb12As/IrnXeEg+mHFw4QsXTLquCBG3ObxTfbNQT4/+P6egJGemruTyQJh6eXMUcB7aqpzfJUqVjtMd9KNt/pR0jLzWT+NWjNipiuBpD04Eyq/3Ombw==
X-Forefront-PRVS: 0722981D2A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4712;23:m/YhR2er9reRAUbs+iERRKpuj/nC5Fua8o14GO3VS?=
 =?us-ascii?Q?Rp85FESC5LQLhgOGKBCmQyRtb5yNw3LkwDLI2V3xEkwytW0vKDB80JUHZzcU?=
 =?us-ascii?Q?KXCQygTE7UFpHRDaHlIhqnHlldaCHGGBdS7oZQfZGw479zogrpKYxZNHQuwm?=
 =?us-ascii?Q?8GBjXP9fsMZANv2f4o+OfzHNxPuqAX9rAFnEzfnfszsxH4G6MeWS/YyyFnae?=
 =?us-ascii?Q?PvH3xOq/UOkdWuhWzY0hwpAAgo2bLBG8R4C5szpA6kWveYA/LQqmAGr/UtZp?=
 =?us-ascii?Q?mbZmq+TqWpZWTu+1Nbnzd4XpbAxwtv//gbJNC6weDf+ihEztlREap8KqlYP0?=
 =?us-ascii?Q?qGrNqVqqAo6ZAtekPqwtHvYba5lEwjM8AZ9ITWd+VNVsEEzJlplB1KRaKMn9?=
 =?us-ascii?Q?RkcxK9Vx9pqW6tlHh97X+k75+T40VFO383mhpAzC3BOoAsGWLvS6CWGWoPld?=
 =?us-ascii?Q?o8wnuI89NJcDZvEnOA6e/88rimbiARna0MJYmUW9OThzI77b0eEDKevBjfWV?=
 =?us-ascii?Q?dc56He60Liyhbioxp7nfPBcp4SgCwb2MW0eywUp62CD7r9VFlXLMAi8Diamj?=
 =?us-ascii?Q?bz4qPEaLXwUtfLkQwSkBPBsdtK+2TEzlqAnnY6EEZ+LXn0hmt5VZ8tjeo7ib?=
 =?us-ascii?Q?CtJ0/i+VW+tECPQbGbL2YFOyViTD8NxUdnk/XYiz2GwJQpJ+ycmjm2R3i4B+?=
 =?us-ascii?Q?EjCprpCGbeIerkRR32VC61dp2KXnsyJomz3puyeY15tDjK2Z7lPoYbjgQcUr?=
 =?us-ascii?Q?wg9fT59SXWHiuL07woIk7OgmB5LpObHBL7wM/msaDmftff11IOi52dvPe4nY?=
 =?us-ascii?Q?2baDlFFIzUXR88q9MpOI7l1D8jnHmgqrv5tXPTlUFzdjnjWUGF/3zW6x+VHd?=
 =?us-ascii?Q?Sw6jZd/B+/62G70ssJHymLDdVN0jr9Nto3e1LJ0EM1q/Pq/Rcqmcb5Q79JWi?=
 =?us-ascii?Q?L3w3VwQMWyuLKjsI14AGeOBPqUkIxBoEIX6dIAW8vE7gbcZ0nbjHDOxCUDCo?=
 =?us-ascii?Q?MoVwhfkHranlcxyDNDcTupSNwIkccA3jtICsbFr4OnQnVGUAeO3rx9qUB3M7?=
 =?us-ascii?Q?paBgvGQL0nRxfLr03tBAG2Q7LJTmeHlDyVqc+DkXjZu/fQ2SjQD+z4YAc/OR?=
 =?us-ascii?Q?CmPFRKwl03/xEDQhHDzAJ4As9iw1Hlgogi766q9IAiidgQmn2HAAXGyS7rWU?=
 =?us-ascii?Q?rau5O3sXDBanUE=3D?=
X-Microsoft-Antispam-Message-Info: smVtFDbZwELFLFT/KBwZt21xQRrD3O3s+9j8epHUplxfhkU+OFoZDjZ00CZUHahw9OMUnkaDs/42HnCd7+QKkv/TPLNMebll286KOrM+C68ns0IzuvDoOoW1gzi3uS4m0hwWoi0f6+aj3tB5yS6MRFD+O4DQIz002q7HPye+ngxngYyNj6irnTNWwtDevxknfyV2BDA3gYyf4yLCbBzXshT2RIuKFKRdzsdZca3wBzY5L9PIMjt1dzY3iOWr4p83X+4DWq/CK8JwEevI/TWnSBdAnvYQ/VbLzLzJYtNZxs5ZpuKwMzfwPOKufO//GxQwogKtirsi96vMr6Wf7Z0tdsPoHwj1QUJukYaFUOAcFAbGS1oCEy6yibuXeVQUBry47TUYRacJ4OucgD/TkOmccw==
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;6:4D+HTPtn0TKITaPxl7ub0BRgU5OsTrtK1XmMBB6J9sbkEQaY5OnF5zyc360qhmtA5kpQENqu46yVFHchvv3CPbgYDBoYxxxAIsP1WryPeycXBi26UjfPCAMFaXrz/cF2osamryYMyNXNV8D+UjO1XRR+Ae5QmN5RBQwXI9vX8HJd2bzdNwZOdE7M5jPxrxf7SlmCjRmTlDnQqI69Nwi4BbxEuEFrfjyb3K41Ngi4RHTJJC8Mi40ekqpMixAkiPelpEHL4bkBLoSJUdJk9ltcPGRsnBhc8Mwg8G4cB/HPQn8ji7qrmkN/Hmah3wD9OVTTF8N8zwPt2HQpZVDxv5oBUDloXhHUpOR00oDQVVxpxghm+F3nXKisqrYdWsyWOEB4WglUABgG9jg55Ym9OfuZG63VGIJPVCyt2dwlst/DzDsClb1xmigig149YunxsuAIP9T0PHjUgHeYIk83aTrryg==;5:aiKBJGIfD3P4+HLVl5MPX89MTBwed+o/Iz2UiN8pLDlL8TFFqohYSEWPlSjW4tuqzBK7yRMAdV26pPXWmorltFmi7cLDOwqq96hJplU8esoUeflii47RpaqpSO4oJsXXgJNJqP9vpIKWaoPss73an4Tx+QYBmVr7gM9w+EeCjc8=;24:aghFmRYBjDERAWKMthGZ8+5swb8vl8KkOROYkuVCHTHI1iU6A85wsIAjiqg5i/1m3oAhq+0sC9bwdlKLQh9ohQRbi5yRxu1LQMbOIWgLSy8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4712;7:gZvYNroVfJtWKq1v7XySUGJsWm5VaxcvW8JhQ7ARlvSadmp1IsnYkkAKOrt3NE7K6OX+YeRc5+d5ZR4LcZ+3wOlGefxXTmNJj9XJlICYVs8sD/SpyHr4jERd3eDc5yuVrItVspa7oGgsvOrg9YcCJo6KnG6i4/YQ48JUY+9kbFXVcRcpLlyFD5OcY1hp0P8Dxba9NmE9f5biquzHBICHbse/EuKDwKIM9mC4iLBE7vZME68ish3LF+f5SaRNxO7B;20:s1n//TLR1k0BCF7bVQq2wj6eRCFOY1sdK/sPkfyuX+vuIdk6CYyanu0eJoQEE1pfqpEM3hNC51FPfCpCc26uW/RBkvRhdOEDSLBTimtDGtP7Ng4I0QGmBI7xJaRRp3NNyPuseYBCvYt11fN6l4yZvgmbMoOOCtDHSU1bEnav17b4rfRYtm0s72VcG7/mWj4THILvNPOSbOmoq8QFUpZ6Dzkdml0h1CDUevIvImEzDxbazhFWHAAiBId0MdD2ftOS
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 10:03:40.5360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07823dde-1d83-4ce4-a3ee-08d5e0cc40b6
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4712
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@free-electrons.com>

Currently, a maximum of 4 lanes is supported in DP.

It can be useful to add this maximum so that we can e.g. create arrays
in drivers that can store data for several lanes (e.g.
DP_TRAINING_LANEx_SET).

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
---
 include/drm/drm_dp_helper.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index a63a548..accefbb 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -69,6 +69,7 @@
 
 #define DP_MAX_LANE_COUNT                   0x002
 # define DP_MAX_LANE_COUNT_MASK		    0x1f
+# define DP_MAX_NUM_LANES		    4
 # define DP_TPS3_SUPPORTED		    (1 << 6) /* 1.2 */
 # define DP_ENHANCED_FRAME_CAP		    (1 << 7)
 
-- 
1.7.1

