Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D336BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96FA721B68
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="lLyQfNGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfBKQt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:49:29 -0500
Received: from mail-eopbgr70072.outbound.protection.outlook.com ([40.107.7.72]:43883
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726105AbfBKQt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8w0FgWyOo8zasXEP8oCiuuLfEOoM8Q/Mm0reH2GZMo=;
 b=lLyQfNGkJMFdD7bWBZ6FR/ZoLtHsogDoTWR/XU7FzO22ZMLeMJOVtNLA71kGGy6FdLYrhzva/I7PjUYUNp1DjUZ0xMWr1+5bifDMhF5JbTIWhtAr34J16iesqkoEM1H44dhX1e4vcyQ/OtA9ZKwGfua36+LzhDmlXXKsiONpCw0=
Received: from DB6PR06CA0002.eurprd06.prod.outlook.com (2603:10a6:6:1::15) by
 AM4PR0601MB2147.eurprd06.prod.outlook.com (2603:10a6:200:47::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.22; Mon, 11 Feb
 2019 16:49:24 +0000
Received: from AM5EUR02FT042.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e1e::204) by DB6PR06CA0002.outlook.office365.com
 (2603:10a6:6:1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1601.17 via Frontend
 Transport; Mon, 11 Feb 2019 16:49:24 +0000
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.46; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.46) by
 AM5EUR02FT042.mail.protection.outlook.com (10.152.9.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Mon, 11 Feb 2019 16:49:23 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.46) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 17:49:23 +0100
Received: from cwe-513-vol689.cern.ch (188.185.69.206) by smtp.cern.ch
 (188.184.36.52) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 11 Feb
 2019 17:49:22 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Peter Korsgaard <peter@korsgaard.com>, Andrew Lunn <andrew@lunn.ch>
CC:     Peter Rosin <peda@axentia.se>, <linux-i2c@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 0/5] i2c: ocores: improvements
Date:   Mon, 11 Feb 2019 17:49:08 +0100
Message-ID: <20190211164913.5988-1-federico.vaga@cern.ch>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [188.185.69.206]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.46;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10001)(10009020)(459900002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0601MB2147;H:cernmxgwlb4.cern.ch;FPR:;SPF:None;LANG:en;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b756c095-0e77-45bc-cf5b-08d69040e08d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4608076)(4709027)(5565046)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM4PR0601MB2147;
X-MS-TrafficTypeDiagnostic: AM4PR0601MB2147:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0601MB2147;20:9hh8ju++E7gDAaVvpRwTjjQt65Bhb0xbCWSqaVsZqRFeTlvXRMZE5d2BQ9ne6FzodlKIMzfiCW0L146Uw6i20VU9vykxhDHEAs3q61n1IeJFw61JZfSzI0HrPuNGPN9DqKa2bKhZTYGSzNgfdtxBnRH8OLCHFEhFpUJ/6mad42OgnxpJjN2RIVOgVfT6vgYuJahUAl9Ot/pw/Eu0X75rqRPYmmwRo7Mw3p5W4sjCs5r6JVuDCutoDgwEKiAKPmdbIJAFsrhqt01QNGLEhYHagTSPMWK4Rv6S+t8GDLyUI4xIf5+GT1mICpP0Y+lttwp0S8wjkQQRxUOe+CBlN6o2r9UT4zazr1fgiMoGrv+ZW8qXtrPaEw6RCpS2yoMzGCe00OdyMR2RUoz/4qVgqd7GlmTkt3wdTgHr8+olPuQmUmtLsQk+ORhgB7DWFGNu88G0e9uCJGw6H/UBMBgJuGvEcNZRpF0feFyNKEKLSL8DzEC54IhCUUtYLBF0FUkfRDYM;4:El8TdltPGRpi4kVxqmJCXw2zddVH8U7oNJvdSmF2v2rSsZBvXa6TxhR7uUCuJWN39R3Ai6vmU/uBwRAR3Zw7jT2ou83+R7p6w6xL28lhvxOvSnNtTP/Ovh9wfSbcs7+sAcWqyNjR6PjlNXwsqZpAghN/eB+sBnTYU57ula5T30SjQG2hMYQr7HQ/+0u1U9B4334FhkW2N2SmW4DgHX2RvlX9CSWazrdrzuTFPpHvAEf3yUs7Q0GE8T5wKYvFYwL8wrFAdcfS/+zo8T/2GQwnB+Bex2DYHCLCalUp/uwwWiQ=
X-Microsoft-Antispam-PRVS: <AM4PR0601MB2147AFAC87904231439920C4EF640@AM4PR0601MB2147.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0945B0CC72
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0601MB2147;23:53ZynES/+qg+LHGY2NThwzw2ADX/a70HpAq1GyEcoOOm+I20sBIFKhK3qFVWhLsAR6cB5dLUsA72QrS/MtYburOv0OIZIKAQysIjwE2LHSU94a0ThTVVN/Urc7iY+HQoICMclx2rznrLA/GnkJd7ajf6v0dvnS17yArzIW7OHPvZvO0Mxw3OcYgG6+0PgtUK;6:oSakpgfdO7fLCDh9pcef5VVzkGFIM0QCpNUVeYqFBbHwsFJ7TtCxV3ghhhlr/itOWmKOGQWNPEy65uWAHL9zmEcD0ngbXdB8uGLEaccA9SpE/JYHRjfTxPZRE9qmcZvziHoXIOdGwj/OI1aKe/8RZ7nKRGXSN+6IgigW8KzJNFUOSIPS8jUGqMm0laUZC8ksY1PAXV3zXIytoiJyAQZ8KM0zE9mZWihFuP/gth0Oz8a1AdPtAjRWZ+g9SqQq233UQkn8F2rlG8mTrLHVyd6Kjg6ya9bgcN/jvSTby2bGuE9AJgoCYPXspov+xhw3ApdsXywHge+I0e7n9F6+meJwrwMHsFzKN+WPnjhguk/5YIDhBCDtJAHJhGSPLPwzYVhBdM8MV1IY7WJl+v16BPySuEXbGkpPs+4B6fmX2PNPteyTZYk2yjIGPSuRDU5ZtvFPeanM1CpBOEdtfQUcL/IWfQ==;5:YMd/s1I0gjChA9MBD+DvyXF2l69SSMrU3KZg3S8Axf0i3Swv7h3QMfpkTaCKoxC7wG38me5kO8xEiUjl11BgPyZ2pAVxyyuqrDZz95kUUqmIpWL78JGtjrQ0ZnFIpBHcMW4j2ZLRwB/HFP/xMcj5UXf4IM1+TmVg/1Hmqz7wqDDGvDdVoCGyVGzWJ18wiLq9hHgUDGYIIroLgrL+Dld0OA==
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: jGISJiYs4/tuR20IJfxGFvWZr0Z/WLb9ZZiAmVSC0Xatu3L5jy3p8WJcUeKbw+GxEP1lcScCPGR5FwEQi4peFJgow4WfWrm0yQg4GbK2YZ0XkkV7FUqGbpqjqj5tARg20NG2cTdbefTiKBW5Clhai2aoNJ9Omy6i5UOhVKD+qWj+235hJlO9rRfht+Z7tfDPemsrEXhp/R5SKwQZ8i77jWIMQWdAXt5YkFsgtqJDGUoNOzGUol4gWMiSc4/bSd1pzt0Er2/Iw5x3bBUutmfOmAIFzcj26t00UZHMvl1zN2QMpvT1Mo7WyDB75ecX1A3BBo7gZ+nT8Qo0fjq8VSWCHkIft+e7RxaoePnKrsYsW0f1oneozoJfhbkIE0gcEcGKlr8LVZbpFxC8jkFSKF8ZyjE0xVf2oLLdLw31SzfapXaFo/NWKHaIhhk0EKXH4CC2y2idKy0bRLchz7vDZvkMnmibx5CB3jOZqo/5g7ziinUU0J2xV230lvtSo0RRyZ2gzw2VsjVS5hGEDz3iGZmBkP2AAmt9SW0OaOCcpKn8Ijg=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0601MB2147;7:7kKghRGqcoxKUzssnDJE/paswMQqpHVs9NQ9qFur1mt9I5236NKDflwvBtjQrQ6gux1e5xyjLE8jc/hIlOZf7tCoKx0OVcsJXsCgf164Bas9iJrzeaYeAAMelViEXMAZlnCcmvibQZ2n3GQUQ3Mybw==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2019 16:49:23.6768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b756c095-0e77-45bc-cf5b-08d69040e08d
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.46];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0601MB2147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set provides improvements to the i2c-ocore driver.

[V5 -> V6]
- remove redundant code introduced in V5 (double read control register)

[V4 -> V5]
- deterministic status of IEN bit in register "CONTROL" at the end of
  ocores_init()
- more style fixes

[V3 -> V4]
- add reviews-by/tested-by
- add comment to justify the formula in
    udelay((8 * 1000) / i2c->bus_clock_khz);

[V2 -> V3]
- fix particular error condition on platform_get_irq(). Copied from
  https://patchwork.ozlabs.org/patch/1038409/

[V1 -> V2]
- replaced usleep_range() with udelay() so that the polling version can be
  used in atomic context.
- added dedicated patch for minor style issues
- fixed delay computation
- use spin_lock_irqsave(), instead of spin_trylock_irqsave(). IACK is always
  necessary and a trylock would generate an extra interrupt for nothing
- make the driver ready for an eventual master_xfer_irqless()

