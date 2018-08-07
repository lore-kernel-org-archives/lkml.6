Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDD2C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D91621524
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="lra+2jED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D91621524
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389749AbeHGRIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:08:34 -0400
Received: from mail-bn3nam01on0076.outbound.protection.outlook.com ([104.47.33.76]:60384
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388540AbeHGRIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUB4TGGtyxGP2eHXvVlEJrEC6Bo+4rX5SCFFIEa1jGM=;
 b=lra+2jEDwVhTsIXIQsxkZ5MwEEu1lyIdLiRDTfZJAv1CHQxed+Do3nwyxT5xMo7nzu+LkLqvqjf6iVUeYPB4CkGp0WAXxnriwiypHGPMalp/czNkvBA7k9Cq+f+nrIdO/c9QduY+wPmUnN7JDTqL6b12c3ThCKRQNsU89pkaqwk=
Received: from DM5PR03CA0028.namprd03.prod.outlook.com (2603:10b6:4:3b::17) by
 DM5PR03MB3130.namprd03.prod.outlook.com (2603:10b6:4:3c::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Tue, 7 Aug 2018 14:53:48 +0000
Received: from BL2FFO11FD007.protection.gbl (2a01:111:f400:7c09::121) by
 DM5PR03CA0028.outlook.office365.com (2603:10b6:4:3b::17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1038.19 via Frontend Transport; Tue, 7 Aug 2018 14:53:47 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BL2FFO11FD007.mail.protection.outlook.com (10.173.161.3) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.13
 via Frontend Transport; Tue, 7 Aug 2018 14:53:47 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w77Erlqo017527
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Tue, 7 Aug 2018 07:53:47 -0700
Received: from linux.analog.com (10.50.1.110) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Tue, 7 Aug 2018
 10:53:46 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <broonie@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Crestez Dan Leonard" <leonard.crestez@intel.com>
Subject: [PATCH v5 3/6] regmap: Add regmap_noinc_read API
Date:   Tue, 7 Aug 2018 17:52:17 +0300
Message-ID: <1533653540-24796-4-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533653540-24796-1-git-send-email-stefan.popa@analog.com>
References: <1533653540-24796-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(346002)(396003)(2980300002)(438002)(199004)(189003)(7696005)(47776003)(76176011)(4326008)(51416003)(7416002)(305945005)(26005)(186003)(53416004)(106466001)(5660300001)(77096007)(6666003)(50226002)(2616005)(126002)(8676002)(356003)(336012)(72206003)(316002)(50466002)(476003)(44832011)(486006)(478600001)(246002)(7636002)(446003)(11346002)(426003)(36756003)(106002)(110136005)(54906003)(16586007)(14444005)(8936002)(2906002)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3130;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD007;1:G1lvF4filJUz79EHvUSJbE2RlfGt/0kKXFQ1K9/rt4wp0dbeVHaoUltE6LHV7v8pCKzmDdQ9zUWKub0DYLM4MSAd8wi1jKJU+Vik63VAifHWt3wSy/L7xwETgni8SVhP
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a848ba35-7447-4d10-d85c-08d5fc75948c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM5PR03MB3130;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3130;3:dSwbxrQZz0lStcCirQIn1gwcaHtLw/eC0WBDw3W2/eiPzODht17zodZjmyt7wBD5g9pFhV5gFvh46vxx36ZcFXEz+S6tZaA29/PEdkcNLIs2q4xoUBU5ZC55be2KD2XMBlY1Xvlqlrm7R0zPsKxCv1mxWOo/70KZf02xDl10BQzKU9oBvPzF6+vDJSUOV0xnpQhj9r/3+32k55wOTyfc5lVdSIr+bGTqQ7dI1sYc4xzvT5Fpe4Db2sSkpRiBsoIfkzuDBi3TRLzoVvnHr+GYF4TEym6Vjc+vieHdTHTpYaodNYvQ48NCy2Alv2KCuNs9Sdkizv8EQDE9RqEevXJCBdt1gwjx/t6iP05lBxfh/lk=;25:4AHOvPAMREMnqgnfveliZEVWnLGf+5Uh721jJwRgaijZVUToZ5QpvWjRh2ooFx9MCnAaafh2DoeJB1I+dnvsolINSJLqI4lYi9Q6P/JS8aAo6nkZqYqtlTWotn9h7/HJXG/rY9QYe7DTvrgPBXJbcCUSP0qe+DkY6imc6P/8DkKoH8+imTWt+UJHR4MoXcvO7FVjuKrqleXf3NhoTgCbFvQXCbIlyEA4E5BDJB15TEHyEnMBJXHvJy7N5qVFU6/uBiSJpsVIfbWmxCg53MjWrA9azMaaIDwWzRgTOsy3DRec5A+tGD58K7MEBkXcXd094ECiaKmouMJr6w88l2i5rg==
X-MS-TrafficTypeDiagnostic: DM5PR03MB3130:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3130;31:svujvucsq9SyL4XqxHxp3AHS++HSNCksEdhNMBmZAPJQcXpi4nVDGy/25Hh0gGqizyYyyT+LymVrB3+dV/o9OKW4TwpPzpD1dZnSMpLIeUEYec4P2j7krcnWJa8esTF9XPHif1+ig6SQ49Zkb0y/d8IHkPVhUUosvAt6vdjRYZcdss4SCfKYagF9U5uNi77mMayCCYx9iR7rMnwFQDWJCYG/gWSDO4t2DovLjk8kAkU=;20:qQeHi6UZ9xT/gpUWUkF2xo1C4+/83xicBMl4/iQMSWqP2hdQUJcQQWb4zETwb1Ba26/H8qD8va5rXX3gX2fbOWE0SvjggNwrtpAhj6J2LXe0kZRFd1ikyC8V9sCPwnbW0nDY9ZtTTN2qppVYJYzGaOMloW02GbMR3xJ/zXSepy2rMJSMWn1YjNDHEiJo92DBV0GXQZhglAt24Q3nbsvDkVs0Gh9MIfdDY/ZMvoBA3KKffTU7CAeVSxBOIxv9iv1BTNuBrumWKXn18cN+D0LqSWut/GnwwJBLThCi0EWK1xOOC8Lm8Ri++NgpMnxmBMG0y7Y+8E/CyGUjcWnw794h7RSOmaRVB/tjgOoNg9Cs1qPPQ3RHy47bic/zUGrzkMHSdW5BiJ5tsZhrNy1okg8XkDLe6bavSVWvJg2k06k24NlbNga1B1okUivasR/Zy2IceS2kdhnkqhq35zR+GLC8T8eUo8+zR6xOc7dW0N4+KWlRzzMoqIfgcAomb2tQ3LkJ
X-Microsoft-Antispam-PRVS: <DM5PR03MB31307FF0BA326A0FC798C5319D270@DM5PR03MB3130.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(131327999870524)(232431446821674)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR03MB3130;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB3130;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3130;4:WDPwKQnr3WGA9c+TfoHqnDVvn5gio+xy9tDabLQ3H1wnIV1zlxbIGar14EEWN8YMouuH575kZrZ/OKxR3ZDsjPkCAG9MQ87a7L/mqNPaJTbwxZAeSHmwSBg6sx5IXiAVK0WGoxmE57gcZCplMXt8k8F3GMwNT50pyTinWUTdUXm5xqLJQrevtEtz04cSvw9vIeY6DfKfSaBaNQRRK4VILyndjHDLgPnF2dnY8w+N4uounSKR2yXSGZTaS/85AqXHlyAfnQjFN41p4qVjrx/Q/1wFJfCD9jKUAMBqNzMYLvWuGaAAaapu8owjLD1JcpAsyrO5yEMwI7pI568uztNC8i1n75X6/uStIg1ZAF7e6i25K6OUqRn8e0LsaXld64D9
X-Forefront-PRVS: 0757EEBDCA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB3130;23:6940pCEVPaJfz2MKUewADj4jqX7kRFb5YaQJpatfb?=
 =?us-ascii?Q?9PzahCBW5s3HYhxtRCCftJP0sVNvN5t6UfoDxU9QE9vRBWo7JmhRVciIRs8/?=
 =?us-ascii?Q?2USMVjd4kqL+fTuRn1hyTMflybIXRKosqnDYXBAqPb0ZkInlyTN/zHBTEdSq?=
 =?us-ascii?Q?kotLi5QiYPklwQboSk5zaamj6LHnc9h0U4yxStatmziapY+OUx4a6npZ2kmx?=
 =?us-ascii?Q?gWwck3ptrwurFccyxjRRHWkpVkQYFgDDspuARsusteDM4s98/lsM6uF0gOmW?=
 =?us-ascii?Q?u1+JsxUx9xtR32/KxJvjMxmbO8qmyfT/zaw6jJQUabSYAuiWTk2v6QdEjfDj?=
 =?us-ascii?Q?MwycdNlhH5p/6WhOT9TtOyyiZjSSGCB9NWroCqhNrBDrTIbhSOY5WG8KJsUo?=
 =?us-ascii?Q?DKG0I3UofaTSjoAXylwUX5T4dlDTlZZJ34rnDYTZiVKZbnWSGIgCpWJF42Pg?=
 =?us-ascii?Q?9H8fYB02QZSqpufEDbvRiLCPG7SKktlfAFN2geXDywdNVKXvzWML8kE9laLr?=
 =?us-ascii?Q?oyciEei9apDt0NAqso9Vpx2sh+UhbKCKdlEwUwLjglaUriuRZbjYi/qVY8aC?=
 =?us-ascii?Q?Zpz2ZQyVdpJAMDslQcg8NOX5KjLKIiRMCC/ySPOq6+DNht6IWwG0KGSDp60f?=
 =?us-ascii?Q?6zLdM4nXZrnVaJyc7H9+jnuZMeSz+rAkHDl9hTADcZ2nJQ120JffKQDY9Bad?=
 =?us-ascii?Q?UGfp+eSKyE8MTJMXBFyIM+I6ZMAyU6iBrh0j75lp5YQfHIx8+B4XB9C+tQgS?=
 =?us-ascii?Q?QHbH8JtRzhT/xiVwSKgwrp1oHjxEff28jIZi/DuQiIqSv5BTProNwXgZwyIy?=
 =?us-ascii?Q?P+CbNyD0C5evHN64WAc7ykR8TI4zCCbiF9qx3hke8zLTPNyGKO7IhvcYb9u4?=
 =?us-ascii?Q?KS9LOqJiZaiciTFIJj8P0HtIUJ5X0MCI3RKIVNb7fN/wsYiasRu5cFuKerlK?=
 =?us-ascii?Q?Y4OiJl5QiGTttziWE7luRNt/bqY1/DCf/DkJzztKuXsnu2ph3Py9Jeb3Ee6O?=
 =?us-ascii?Q?hAoaVQQ5ofSKKQJgFJPDszRZp7g7ymFqRAQ4qGXY0Lx0TfgPKCqSmbxKVa6l?=
 =?us-ascii?Q?vDzijYRz+9lfu49GNepZvV1u8LbcM7+X1h2uKxbSnG6rirkSw=3D=3D?=
X-Microsoft-Antispam-Message-Info: sZ+Vg3eeutw6ZhsDidnoYdFWlmuieBAJsV7CCZ7trLBRPD79YnrFA54QGt/2+w09GaIS+lGhaNpiI3V5JEWuxPwgJYOaWigQUcIWB8yWimRsXZiyA6YkV4wlKqmNStp2W4EhDEk1PkYyhgPk49w4Optw2PukFSUI07x2eIdveapKvLJFXI61Z7rEvzbfz9VAhFDTbMMiTMz4MjfnAoYn2Nl9mR83pI5EnGHhsW4syK7Nxp8HZihpCDak5oOYC21PNMGFF7ZC/+qeDMfDkeGvfHHW7fpBR3pU1PFH5lq16mDwXQlD6HxoewAC7XlNdx7wXhnlvIv9v/GCJ6bmKkx6+vycprTkD7Uopwv43Liefj0=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB3130;6:e6RoN8TA129wIXMHMgmQVDipd4ZS0YFs8xqwYdPEBB8kT+DH401spBdyGYFZhMrWyP7sdRGaWzRA0U7KOMhf/e1C3fT080kT4Jc1xbY9mzeNhs8lfgBvSXJv/nVjMaEbehHcvMxVyC5Og8JUrmSxcrQsu/jTQk74/lUWHEdcFjBZYUiYX0uJVkPWAsrP0D1pllj1B0JTeeqOMuuJ8sJLakeItS1iXs0ojQrHDIcj9Km5J0HoEghvERQ2/tJctceQyBb8Eyc7jFtrV2tant8kxkyjswC6+bbHqfjlaZ3QqEYdkPATkONryWugGT6rnwQxC01AruBg/ZtyDEVKrwF2vf9jbwwu8eT2EjJuVpZdL2UMD/Fczgwd7f80suq4plaWuiBcTWWnNlMG6dapFTbzhny4zjfmNqnPx7UO5dywlmO6/Eezg3QYYoMBHRsfCeGwmo4nixOPHBOuSm/D3VgDaw==;5:Y7g0PXxgnDiF/a2gJgH+kZ72Jaz4qBRVQCILgVTmEjRj2v3q8LPZV6fJ3S5tWi/ms1S/dyNs4W5d/Zdu7Pocw5BVJRX134vWHK3p1kEQMV8DtIsrFEO8vO2XAzASJlYoZ+c1CzX5zA+jFMM50Mdghoi14dasXu8xV07DTX1aA+o=;7:cx0VoKT+N+nDErAqWF6fW0q3JztUUrKdXNbUiBwDUs1cogn4XIFt9me8xH1OmJuxc2TO/6f+SlEpus1x9d+Bz9QDaCPkS8QWxCQl34Z173yUn3ExshOF3w3M+lk++U9+wyDcre6zUAIs2oPu9rfTwra0Qpte7+iU7zpT5P3eqlnx4kDJ8To+x9fEe0fL8+j3XCgRpDV64cOfqWooMybsux4K483t0ApmEOA5YmfEU2QduoWMM3+0oVz+3E5IYPow
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2018 14:53:47.4705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a848ba35-7447-4d10-d85c-08d5fc75948c
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Crestez Dan Leonard <leonard.crestez@intel.com>

The regmap API usually assumes that bulk read operations will read a
range of registers but some I2C/SPI devices have certain registers for
which a such a read operation will return data from an internal FIFO
instead. Add an explicit API to support bulk read without range semantics.

Some linux drivers use regmap_bulk_read or regmap_raw_read for such
registers, for example mpu6050 or bmi150 from IIO. This only happens to
work because when caching is disabled a single regmap read op will map
to a single bus read op (as desired). This breaks if caching is enabled and
reg+1 happens to be a cacheable register.

Without regmap support refactoring a driver to enable regmap caching
requires separate I2C and SPI paths. This is exactly what regmap is
supposed to help avoid.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/base/regmap/internal.h |  3 ++
 drivers/base/regmap/regmap.c   | 79 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/regmap.h         | 19 ++++++++++
 3 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index 53785e0..a6bf34d63 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -94,10 +94,12 @@ struct regmap {
 	bool (*readable_reg)(struct device *dev, unsigned int reg);
 	bool (*volatile_reg)(struct device *dev, unsigned int reg);
 	bool (*precious_reg)(struct device *dev, unsigned int reg);
+	bool (*readable_noinc_reg)(struct device *dev, unsigned int reg);
 	const struct regmap_access_table *wr_table;
 	const struct regmap_access_table *rd_table;
 	const struct regmap_access_table *volatile_table;
 	const struct regmap_access_table *precious_table;
+	const struct regmap_access_table *rd_noinc_table;
 
 	int (*reg_read)(void *context, unsigned int reg, unsigned int *val);
 	int (*reg_write)(void *context, unsigned int reg, unsigned int val);
@@ -181,6 +183,7 @@ bool regmap_writeable(struct regmap *map, unsigned int reg);
 bool regmap_readable(struct regmap *map, unsigned int reg);
 bool regmap_volatile(struct regmap *map, unsigned int reg);
 bool regmap_precious(struct regmap *map, unsigned int reg);
+bool regmap_readable_noinc(struct regmap *map, unsigned int reg);
 
 int _regmap_write(struct regmap *map, unsigned int reg,
 		  unsigned int val);
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 3bc8488..0360a90 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -168,6 +168,17 @@ bool regmap_precious(struct regmap *map, unsigned int reg)
 	return false;
 }
 
+bool regmap_readable_noinc(struct regmap *map, unsigned int reg)
+{
+	if (map->readable_noinc_reg)
+		return map->readable_noinc_reg(map->dev, reg);
+
+	if (map->rd_noinc_table)
+		return regmap_check_range_table(map, reg, map->rd_noinc_table);
+
+	return true;
+}
+
 static bool regmap_volatile_range(struct regmap *map, unsigned int reg,
 	size_t num)
 {
@@ -766,10 +777,12 @@ struct regmap *__regmap_init(struct device *dev,
 	map->rd_table = config->rd_table;
 	map->volatile_table = config->volatile_table;
 	map->precious_table = config->precious_table;
+	map->rd_noinc_table = config->rd_noinc_table;
 	map->writeable_reg = config->writeable_reg;
 	map->readable_reg = config->readable_reg;
 	map->volatile_reg = config->volatile_reg;
 	map->precious_reg = config->precious_reg;
+	map->readable_noinc_reg = config->readable_noinc_reg;
 	map->cache_type = config->cache_type;
 
 	spin_lock_init(&map->async_lock);
@@ -1285,6 +1298,7 @@ int regmap_reinit_cache(struct regmap *map, const struct regmap_config *config)
 	map->readable_reg = config->readable_reg;
 	map->volatile_reg = config->volatile_reg;
 	map->precious_reg = config->precious_reg;
+	map->readable_noinc_reg = config->readable_noinc_reg;
 	map->cache_type = config->cache_type;
 
 	regmap_debugfs_init(map, config->name);
@@ -2564,7 +2578,70 @@ int regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
 EXPORT_SYMBOL_GPL(regmap_raw_read);
 
 /**
- * regmap_field_read() - Read a value to a single register field
+ * regmap_noinc_read(): Read data from a register without incrementing the
+ *			register number
+ *
+ * @map: Register map to read from
+ * @reg: Register to read from
+ * @val: Pointer to data buffer
+ * @val_len: Length of output buffer in bytes.
+ *
+ * The regmap API usually assumes that bulk bus read operations will read a
+ * range of registers. Some devices have certain registers for which a read
+ * operation read will read from an internal FIFO.
+ *
+ * The target register must be volatile but registers after it can be
+ * completely unrelated cacheable registers.
+ *
+ * This will attempt multiple reads as required to read val_len bytes.
+ *
+ * A value of zero will be returned on success, a negative errno will be
+ * returned in error cases.
+ */
+int regmap_noinc_read(struct regmap *map, unsigned int reg,
+		      void *val, size_t val_len)
+{
+	size_t read_len;
+	int ret;
+
+	if (!map->bus)
+		return -EINVAL;
+	if (!map->bus->read)
+		return -ENOTSUPP;
+	if (val_len % map->format.val_bytes)
+		return -EINVAL;
+	if (!IS_ALIGNED(reg, map->reg_stride))
+		return -EINVAL;
+	if (val_len == 0)
+		return -EINVAL;
+
+	map->lock(map->lock_arg);
+
+	if (!regmap_volatile(map, reg) || !regmap_readable_noinc(map, reg)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	while (val_len) {
+		if (map->max_raw_read && map->max_raw_read < val_len)
+			read_len = map->max_raw_read;
+		else
+			read_len = val_len;
+		ret = _regmap_raw_read(map, reg, val, read_len);
+		if (ret)
+			goto out_unlock;
+		val = ((u8 *)val) + read_len;
+		val_len -= read_len;
+	}
+
+out_unlock:
+	map->unlock(map->lock_arg);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(regmap_noinc_read);
+
+/**
+ * regmap_field_read(): Read a value to a single register field
  *
  * @field: Register field to read from
  * @val: Pointer to store read value
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 4f38068..19df946 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -268,6 +268,13 @@ typedef void (*regmap_unlock)(void *);
  *                field is NULL but precious_table (see below) is not, the
  *                check is performed on such table (a register is precious if
  *                it belongs to one of the ranges specified by precious_table).
+ * @readable_noinc_reg: Optional callback returning true if the register
+ *			supports multiple read operations without incrementing
+ *			the register number. If this field is NULL but
+ *			rd_noinc_table (see below) is not, the check is
+ *			performed on such table (a register is no increment
+ *			readable if it belongs to one of the ranges specified
+ *			by rd_noinc_table).
  * @disable_locking: This regmap is either protected by external means or
  *                   is guaranteed not be be accessed from multiple threads.
  *                   Don't use any locking mechanisms.
@@ -295,6 +302,7 @@ typedef void (*regmap_unlock)(void *);
  * @rd_table:     As above, for read access.
  * @volatile_table: As above, for volatile registers.
  * @precious_table: As above, for precious registers.
+ * @rd_noinc_table: As above, for no increment readable registers.
  * @reg_defaults: Power on reset values for registers (for use with
  *                register cache support).
  * @num_reg_defaults: Number of elements in reg_defaults.
@@ -344,6 +352,7 @@ struct regmap_config {
 	bool (*readable_reg)(struct device *dev, unsigned int reg);
 	bool (*volatile_reg)(struct device *dev, unsigned int reg);
 	bool (*precious_reg)(struct device *dev, unsigned int reg);
+	bool (*readable_noinc_reg)(struct device *dev, unsigned int reg);
 
 	bool disable_locking;
 	regmap_lock lock;
@@ -360,6 +369,7 @@ struct regmap_config {
 	const struct regmap_access_table *rd_table;
 	const struct regmap_access_table *volatile_table;
 	const struct regmap_access_table *precious_table;
+	const struct regmap_access_table *rd_noinc_table;
 	const struct reg_default *reg_defaults;
 	unsigned int num_reg_defaults;
 	enum regcache_type cache_type;
@@ -946,6 +956,8 @@ int regmap_raw_write_async(struct regmap *map, unsigned int reg,
 int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val);
 int regmap_raw_read(struct regmap *map, unsigned int reg,
 		    void *val, size_t val_len);
+int regmap_noinc_read(struct regmap *map, unsigned int reg,
+		      void *val, size_t val_len);
 int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 		     size_t val_count);
 int regmap_update_bits_base(struct regmap *map, unsigned int reg,
@@ -1196,6 +1208,13 @@ static inline int regmap_raw_read(struct regmap *map, unsigned int reg,
 	return -EINVAL;
 }
 
+static inline int regmap_noinc_read(struct regmap *map, unsigned int reg,
+				    void *val, size_t val_len)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
 static inline int regmap_bulk_read(struct regmap *map, unsigned int reg,
 				   void *val, size_t val_count)
 {
-- 
2.7.4

