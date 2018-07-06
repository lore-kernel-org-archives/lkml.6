Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BA5C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC9724095
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="n1bkmRvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC9724095
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753667AbeGFG7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:59:25 -0400
Received: from mail-eopbgr50102.outbound.protection.outlook.com ([40.107.5.102]:33596
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753647AbeGFG5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 02:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+mcEeCeLAsBmOciHN/F9TuTscSkX2znlLTi8o5YHqY=;
 b=n1bkmRvJFot42x2lL6/ey7W00G4AIGBRVBkJQl6LcFwGi/qMt+FGjltF+PWfnyrXQSt3FfUPQYmuaSBitvONJb47v2D51bbBQcvwdPn6pudmFR4MtlTR8SpRq+JrqaQNzFvCfgiLEG+Apm1bBM9D2gB3vFSd3Z4o237jJZ9UMV8=
Received: from AM4PR07CA0008.eurprd07.prod.outlook.com (2603:10a6:205:1::21)
 by DB5PR07MB1272.eurprd07.prod.outlook.com (2a01:111:e400:599a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.7; Fri, 6 Jul 2018
 06:57:46 +0000
Received: from VE1EUR03FT046.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::209) by AM4PR07CA0008.outlook.office365.com
 (2603:10a6:205:1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.7 via Frontend
 Transport; Fri, 6 Jul 2018 06:57:46 +0000
Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia.com; nokia.com; dkim=none (message not signed)
 header.d=none;nokia.com; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.241 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.241; helo=mailrelay.int.nokia.com;
Received: from mailrelay.int.nokia.com (131.228.2.241) by
 VE1EUR03FT046.mail.protection.outlook.com (10.152.19.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.906.15 via Frontend Transport; Fri, 6 Jul 2018 06:57:45 +0000
Received: from fihe3nok0735.emea.nsn-net.net (localhost [127.0.0.1])
        by fihe3nok0735.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id w666uwn5013858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Jul 2018 09:56:58 +0300
Received: from my-server.emea.nsn-net.net ([10.21.14.139])
        by fihe3nok0735.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id w666uwW0013854;
        Fri, 6 Jul 2018 09:56:58 +0300
X-HPESVCS-Source-Ip: 10.21.14.139
From:   Janne Huttunen <janne.huttunen@nokia.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        =?UTF-8?q?Jaroslav=20=C5=A0karvada?= <jskarvad@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Janne Huttunen <janne.huttunen@nokia.com>
Subject: [PATCH] perf script python: Fix dict reference counting
Date:   Fri, 6 Jul 2018 09:53:44 +0300
Message-ID: <1530860024-12653-1-git-send-email-janne.huttunen@nokia.com>
X-Mailer: git-send-email 2.5.5
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.241;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(376002)(346002)(2980300002)(438002)(189003)(199004)(53936002)(26005)(22756006)(305945005)(356003)(51416003)(4326008)(2351001)(476003)(1857600001)(2616005)(5024004)(316002)(486006)(54906003)(106002)(16586007)(126002)(107886003)(5660300001)(81166006)(26826003)(2906002)(6916009)(106466001)(8676002)(50226002)(8936002)(81156014)(478600001)(47776003)(36756003)(77096007)(6666003)(44832011)(68736007)(336012)(86362001)(97736004)(50466002)(48376002)(21356005);DIR:OUT;SFP:1102;SCL:1;SRVR:DB5PR07MB1272;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;VE1EUR03FT046;1:mKJ/0sQ4o4zzzpV6x2kYr5LI5XoXjo9ZQ/ctBdZJJdTGthBpbbXrVK+2UaZgcNaWKBfh7WbGHxsDQJpNwL9uo+SneKisQXccqIlXTxJCV18M81VjVQ2v+VfV/AAHehTr
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e852f354-92e6-4d69-728d-08d5e30dc745
X-Microsoft-Antispam: UriScan:(109105607167333);BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(2017052603328);SRVR:DB5PR07MB1272;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1272;3:mpWS5kkA9vaDrv8niDxl2ODaEpTTRlRFrDiOSR3cg2SFceXyS/BAxgG76GoACuYhlkMtBbJ14TFvxcCyOLNl9O10oedgz3rWY5AcjeXgbPZDTehG/VCmwO+AYSkIZBn3fLF+gylAq98TWnwdBnp8P8zRJGGo9AtEOZgnYZk2F1sZLqu761RVloMGQxmtukktZF/i0IAEWCMjk+sP86qjBzSQGNx1lnUKOKtaBOUaEbh8POwtQYLu2iDvRHr10SnkD04r+yj9zUP0ouyg/SwYiVcMblzT5qOe9NCr+2w6zst2m6xXTBZFQt0qgMnH27vMURWQGiTS3Md0Lvd6oh/LHOouJYw6I0R+GS4HElgQIk+mi2pLZFrRI/LtQI7eLF6SUipzaZD3o3yq8/6znNYBBQ==;25:UubRmwQy/0dpoX+4wuihAP/KTc6JnpktoYqkifW2ZjfSDCDqBIJJTZm+Ub1k9xceN4IiCZCPAcmh5PL4dHl+Gq6OhIKeSfLkCKYONDra/up7Qpuy/AadNOZVZs6JlmXZKa1iv5+JFMDPmOMjDeZJggnQLR6gVAtB9ibDHLNFDAe0LxamEvw72rXb6fRPLp+tfk5gjyVDBfeNOcfYaJ5X190u9QHtEWFDE8QG193faAZUm3+fTrnKAHXMv7rLSqzzXZthcct0QJQfchUpzPHfjTqyCobFFrGGyAPvnFKwpVYWHIDl5NarqhS/iWFChoEZEc+QFcO2mzXq/xkdIHtEUw==
X-MS-TrafficTypeDiagnostic: DB5PR07MB1272:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1272;31:jbb5GXLbA6Q7pczzoqkZ1o4gex8aDA7+GZIZSNAYyq1AoEuOJhDaQbJmEED6AqqQW7jPcrepP7BE51FfRQpIKUOzm54V0ixn6J08l6fL2IK3fQRDiJUYGeXuEUXKsHNx3vy69vGO15JNjb7Owj1gAIWp6tXSd+4eymR80OXFciix3fupB6Qx0yvBT/71cqD9Cdes7rcJYsda6X0cbxW0kGBJxC2wGhXWg/4zUqy9BSk=;20:Rtgpx1WFOd/oiwWhJv27cT+Rq5jdTt0vPVZM0/QX2dTUHOV1//Mdjc7jccZK6ZfpnxshtFouJJ7b+OgPCU6lHhKglVIIitI7lcLW30tE6qNgMqgD3Q4/oyDdAeW8vIdjAAnhHtFEZkhwie8AgKLJxdNfLf5LGQcRJRThxBaPf//bnYrA1I5s/OyE/2r/RMqChpVCf0WIeBlig0Q3t0aE9Ofw1BxvTUZvPBSnftzOYR21mN7QhYk21cO5PdInRBKgCcyjRZpottYTYB8GMJ6SiXQHH/u5e83YWs9JUe3orVN8YUhng0XLXsSkTdXISsKIMeEhwtlDt+Q3VDbjRg0GcDwRsy66PP5I2w92oVY57Zh34yhOhtA1hLRbbx+3fY9j8mgsVjJApInpDid7v+acSS2rbCP8AbEEUlrUThKr2T0sSc62dsYd8qFTLVcw5SNIVJRM1q0St4QJNxYhOX4FxjZqYLQlrEXu/wO+AT+q99emGbyLw6OehUDvFDvrtG18BkiNNiK56YTMuU5Y4kBf04M61jTGvw+ipiIoGZKEC2g1IKQl+EIRyD47f+YPng5d8UT37LU11POn9SzD9BVvTZFiU0X3iQsGpouO++4g0nU=
X-Microsoft-Antispam-PRVS: <DB5PR07MB1272AE3766A374C800FCD0669A470@DB5PR07MB1272.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597)(109105607167333);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(11241501184)(806099)(944501410)(52105095)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB5PR07MB1272;BCL:0;PCL:0;RULEID:;SRVR:DB5PR07MB1272;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1272;4:pZd5RgouIl6opeKq2rxg2PQNLYiK0F5R1XD0lyd9GxJZa6Jmt1YdjxEt/IviYsBwb2dvyCdIt5bpX0lF4GOaofjBuUHdQJx6mcAIKznh4YuLoPEVW9hss+4Sbo6RDc/hmZSYWwYRZiFyl0UquZElGarj33pbFAth9w3X3sRSfTeqScl66aq6Ya9fx4cEmxclZTCRkqSiHV2pStDpt+urBM20QxvZ6ci1o7hlsR/3RatG5LYLNgaVpDPFtPKm5OTFOUUZsI+Nw37RHUNRDYVy3rPJQzmGEqH6Dcr6zPxaonr5mqo0uUzE9VXzIoq/UvBhefxLiz0He++gK5YIxIKpnHsiD5ecSBX7cOZUTmc3kx4=
X-Forefront-PRVS: 0725D9E8D0
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR07MB1272;23:fmjlwd42PFLyW0ZdxNmc+CYYPYnL2SHf0dKZW1aPt?=
 =?us-ascii?Q?i4ORr69i2TqKJdxyLGc8jHNu3aBoAIGR387QFl95PzOiXYOsYEqtfqVL5HL9?=
 =?us-ascii?Q?TBnGP1SKJBmqUxmwdhiLTsW/XxvPG2qehBXy02PhU6Aua4FWX9Y/U1LDoqdt?=
 =?us-ascii?Q?xgF8nKsG5t54bkBnAvNDtpKmfnTaGQhmYDkikIR4wM7H+WetgndXaqiWzBwl?=
 =?us-ascii?Q?0wCctK8MrBEn9pf0edqt8iFOBNTGqZJ1f8MUufhmxf1S4qs4y/q30CzCzrw6?=
 =?us-ascii?Q?yAVDnt2gkrJpJ6c5GwApk5YbGelJiBsvdkVDP/r3MKFPcdTzmjWx24WIDNxI?=
 =?us-ascii?Q?+XFUOAUP+4gFP9C3ghQJxJTDsHZJ0jUvPjBPmfRLeK9Ft9nPx7X+vKx1hvYg?=
 =?us-ascii?Q?2QFFhg/bouJgENzSjdBQIwNE+MhzgTTQXQujkrVE+bVUqemzV6VCA9oa+3gM?=
 =?us-ascii?Q?f1BgwT70uXM8zBs+YF752llORufe1iCRhunQMXTV1j1f67lddVLP9afPrEES?=
 =?us-ascii?Q?YYGkpQ/0gk0LK1tsiaVSYFiuKjWtCol/XuW0Zq49nccJFKwjtyjC5FOQphDU?=
 =?us-ascii?Q?rrpuf0zPzfFXfT96VlS7C17xWlj5O2XE6YYExCAimpIRPZ9A/JWIfq9OSvnm?=
 =?us-ascii?Q?S6B4JyQnh4idz+BLdIBxo2lg3J0LR7iL0+/oUsMiojBFqi+WGdeN9w10Xvno?=
 =?us-ascii?Q?Vb37V4kw5tvRT+0M1gbZgFR+PgvbgO4cNU/PNakMmtv6LW3I0cXzDQiznmN/?=
 =?us-ascii?Q?00a6OYlyNY14jTDzzbs8k8fEst03pUzJz3ssi0WQ/1GRkIcdj5P4bZGL+sWv?=
 =?us-ascii?Q?uu+FImprl6S1PoDb3qGTSPHtBk11mO4N0zTep53bMW6tHLoncMYLDgnOi+q/?=
 =?us-ascii?Q?CJXqX1+c8S+/xv6TyXDcjyNE+KAr1rLSMusTsklZLpWjo+m2bcP8eKi5LOh8?=
 =?us-ascii?Q?kSZyLzEHADXlu/siUeVD0ddb+06nO0A7nys8GaiR1OlL5RH6sdJWxrMQVYqA?=
 =?us-ascii?Q?GfsMqhJEgArVOeUlILUgwMIgNaOGywZnVWt77AtASUBYvG+144ZsJWfxDRud?=
 =?us-ascii?Q?I0eZqrdMaX6hJjuUa8bKrNVH6kusKFHgEVRchhpNGibM5+gIPnjac7TjAj/i?=
 =?us-ascii?Q?qY4AoIyBL+ApW5v8/O0evt27pdQtFsn?=
X-Microsoft-Antispam-Message-Info: D5ajy+rtkK68XtQHr3zf6FLO7z6Dp/ElvXd/RGWhteBzr0Lq/vK78PuO5zqjabOWgpTBXNVlfyi3WX8LxEEob4ZNYlpReRWesnWtf8z57N2J2MB9Be2MhFx0221e0kQ0FW4zzTNR/Rn6zTTXyN9k+E/dTpQweVgfHPtROn1Ciif0qRk0YOu1icfeKo6kV5AQM3/wdUiV22cWcjKCcOOnTw8nClDTcbHlJP23Hp0MvPOvT39HQ0isC4yQGoRXkMwdFV7k+mFGQDCNlvTagIgYEpOVTqYyhiVjnaIKLgX1PiIyhabDLHixNOQVcA9ooR5F/mSo7+sJc4R8Y6+n7jyzPG9hHU6T1lUtZgJNa5wEjAsmdgg6eGvzeXH3mgUtY/XTHGSoETkYv3wjpAhYYHk8NRg/XgeqpYwnjdMZsEj7BTwOSPfccbGHfm4d44cJhsY9
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1272;6:YrjdFM4TR4IxVyMzawZx33gmXNUIVe3D2bSOZIPYqC8/aNmTDu78bS9nyTUu0YuK++4u7QUbmuXvblvQaH+f0cN8Mx/Z7yLHDoEao+/dcrRrxY0JlpBAIHzOnlWLQSkfFAdo+5K5/K873skuep0yuMwiCRtJreONAlb6zec2X0TdraS1VZP+0NlgK3SwYqmmPdGbRniyUO+jiCAbXf2fEd7HVIXSy0Q3GwdfTc7Sthsnc6cLr7m+wxPr0XBa5BKLsinqzf/PnxnMFDf8lYfwUs2z4QcbFrxdvFusy5t+MDBmLBw6CAUDdYGIUXsrMbsuB1KG8jR7n2ZxkiS6Njsx/1doI3ACREYjC491cwR5WVdtj4Vd11Lxq323H+sud30Dm6cm6wgG0rX/3nNXeC01m9OFclJvIwQGk7/rQ/YAjHKVLfwInVmHiBTL+Z72uUR1xLrGR/LkKm+HABxwN0XD3A==;5:+SZh321x1hSTk0Ysbq0yw3Evxa9RIejkdatnAxB1FjclkCxyN8lFUU5hP8zSrHBUCRDqU29yPA4xQiYwgXQvnVqx2ONsAuQmYPjaX8eXoPKItrSYbNXZg/Vja1mLEIOnmX7RNfDseah8e+xB23vOtEkb1gzUuRM7nSAMs8+DmRQ=;24:14YDNftxh26FT4UPwn0cnCAeGLTy/WdvGTqBV0+POHy2+4RdzqWSl/Bag0kMsVJ52zHO/AYrfgnwgcimSGFxio2of8J/KFapupJ/9CUith0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1272;7:ytuVYtKE3D2B+lOniPuyT5L2uBOJdhtuiIBYKHB1D4tud5ZIj0e8aMEC/Ttopt2CLS8IyO4/5Bjhnk5I5dSUGCVEj5nyIQg2XBXcZxZqxn3K3+ZVK8lTUYD0Sc6JTtWYDk5lyK2PFhVvnm+QfED/WrCOGSZQw06wUWlIspfCy2176poAr7hrw+AlRAXisembGgjHpfTtVmfiM1YobRmUY+MDCblzHzRi3Fe5ZjZ4TmMkzR9kngJ1E2CcDSY2B9Fd
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2018 06:57:45.7121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e852f354-92e6-4d69-728d-08d5e30dc745
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB1272
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dictionaries are attached to the parameter tuple that steals the
references. The code should not decrement the reference counters
explicitly. Otherwise the objects might be released while they are
still in use which may cause perf crashes, assertions or just plain
weird behavior like unexpected data changes in stored objects.

Signed-off-by: Janne Huttunen <janne.huttunen@nokia.com>
---
 tools/perf/util/scripting-engines/trace-event-python.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 46e9e19..60fce44 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -908,14 +908,11 @@ static void python_process_tracepoint(struct perf_sample *sample,
 	if (_PyTuple_Resize(&t, n) == -1)
 		Py_FatalError("error resizing Python tuple");
 
-	if (!dict) {
+	if (!dict)
 		call_object(handler, t, handler_name);
-	} else {
+	else
 		call_object(handler, t, default_handler_name);
-		Py_DECREF(dict);
-	}
 
-	Py_XDECREF(all_entries_dict);
 	Py_DECREF(t);
 }
 
@@ -1235,7 +1232,6 @@ static void python_process_general_event(struct perf_sample *sample,
 
 	call_object(handler, t, handler_name);
 
-	Py_DECREF(dict);
 	Py_DECREF(t);
 }
 
-- 
2.5.5

