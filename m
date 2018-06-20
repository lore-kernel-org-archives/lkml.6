Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2564C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C1B20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="I63B+sHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C1B20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754753AbeFTRlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:41:05 -0400
Received: from mail-eopbgr700081.outbound.protection.outlook.com ([40.107.70.81]:35840
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754288AbeFTRk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIkHm85z1WUVHuKMn8jcaQdPVsvWK1J86FnoIRstJGQ=;
 b=I63B+sHTS3ciAQZUFeFxS1zHAWH5agXQJtBbgph4ARa6mamy63n/A2y4qEPDVmUkHtDh7TI+yt1M+Cm+SamU58P6nSD3Ghou16Ded0va8mNyGmQyivW1D3ZJHLwTkkgWZTgAAxhan7TdOnG3pnkxv9I6LNuUCXolGmb1tQm5nkM=
Received: from SN6PR02CA0028.namprd02.prod.outlook.com (2603:10b6:805:a2::41)
 by CY4PR02MB2646.namprd02.prod.outlook.com (2603:10b6:903:72::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.16; Wed, 20 Jun
 2018 17:40:57 +0000
Received: from CY1NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by SN6PR02CA0028.outlook.office365.com
 (2603:10b6:805:a2::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.863.16 via Frontend
 Transport; Wed, 20 Jun 2018 17:40:57 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT044.mail.protection.outlook.com (10.152.75.137) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.884.17
 via Frontend Transport; Wed, 20 Jun 2018 17:40:56 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fVh6F-0002P3-Ms; Wed, 20 Jun 2018 10:40:55 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fVh6A-0004lu-JZ; Wed, 20 Jun 2018 10:40:50 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5KHefqm002472;
        Wed, 20 Jun 2018 10:40:42 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fVh61-0004hY-Pq; Wed, 20 Jun 2018 10:40:41 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v9 03/10] firmware: xilinx: Add zynqmp IOCTL API for device control
Date:   Wed, 20 Jun 2018 10:40:28 -0700
Message-ID: <1529516435-7315-4-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
References: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(39380400002)(2980300002)(438002)(189003)(199004)(81166006)(8676002)(356003)(16586007)(6666003)(316002)(7416002)(72206003)(110136005)(106466001)(54906003)(106002)(5660300001)(63266004)(4326008)(9786002)(36386004)(81156014)(305945005)(50466002)(48376002)(336012)(77096007)(8936002)(39060400002)(126002)(76176011)(486006)(7696005)(186003)(26005)(50226002)(2201001)(2906002)(44832011)(47776003)(446003)(36756003)(11346002)(2616005)(476003)(107886003)(426003)(51416003)(478600001)(107986001)(921003)(1121003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2646;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT044;1:iMsdP4h41KuHjcumYxJOu9Kt75Ohat8FbkZzDDxkcVn99l/5KUJ3eaqNoKxjTNh6T+piff5NO2IO17iLi3zZQSs1GPnC3v77FXjARx9A3oufVGO4Tmj/Xy1l+mdlEc92
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c63d4d56-489d-4c68-f48c-08d5d6d4fad2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:CY4PR02MB2646;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2646;3:PfP6EYvwzmEmGSsS2lINK6zez1ahxcGgCLJu3Xx2FYhJ+PspLBl6CvuBrcLi6BYrNH93VlwCJ5baYL/1XANrXVoiYLl6sBBVqRuZTMxqto/iZzZFsPbgGwrY9LOiomWaSIpJ8A0LBOIv5wDrdvwqAQxB7UU0YII5Sz5/qFHTYQIV7oZHUr1Aw5z+uLqOU2BXcAYBR2dK0qjj504uBQ01q77RxWtYT/lddcayGGwKgOVKv8Cy3rs4bScW/GyJJG7c8L4tt9yvVyv4dBIHE0SlusI1ww8Gm26NX4wKYLQidRoCueEHFlvdym6tj2uysCOAd73BpM+8wmWYEC/4w9FXBsBaNqQQDEuAfgoFptuQCeg=;25:p+uXKPx02LsGmhR/l2tgiihzoikrvhLQGbziMVNqVZaI2zMY8Uzh2hEW1jNHbQmfMzhy1cdijiZOLzVmTyUqVadz4QhuDhKg2NJL0H81u9wKh0UksPu3v8vAMLboo/GZBj3ZROTGGxeLp1XiU9YjsGWV01J4JPw4YPlfLQ0DEJAChYNRrqeRilnE7buFNvX7TzXNDxaUMB+hzhJAhGbuH9e2Hpm2yHbKu3Fv3OO7xl188Tam4em07wgXO5qR7PZVF3NV0L35nICfduVMvPuJEZ7Fwonr9hlwNFwFNk8962q5aLpeR4oMFAVrLGAno3ZMWuQs+0/UENt+kMqC08tsQg==
X-MS-TrafficTypeDiagnostic: CY4PR02MB2646:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2646;31:R19npHGiOOM+TUsVD0PQRuBCU/2EcywKMwCpfT9QiTEr6xUNNVM55ktKBOhi+oJPnAakiwz1G/XoFqs0A5zQWFpBRV5rovAzN4+VUxYFG2O8vwprs0YyrnI5oFq6g/fALQIvP2NNRNAxUTcQEKarhzwSCbXhOIOe6LnG12q9NC+UXu2wNBl1I0kBEVuOuSwbk9UeVSHitPjYY6X2HqHTZFs0qtXy3j6gCN/BjoxAhpA=;20:BhEKD9h4zVFO9SeFXdR+gLotGg7Bf8QJkOmCqWcwESTsZFFGxPwTEHBX3I0kJmA51RuS5Gq6EfeHO3wd+OqjCSIxayDfTZqbvJkCeOtnQsie8DE1bJcOF6PmELZm53KYhsxOWTn+wibk89VZGyxKI9P7KBzS/JZZpjPonwdkd7bZlL/Wb/UXDO+c6kr98OXSFUW74n3VmaXqobM8pvnD5aPoUp2D8z3Hv6OVDHIpDqgrBojixyvRWMvPlh4q9jWLFxVl6fQbEMYcUt5iI+hVE4P55LtGr8eBaFwg64WQpmSzw6L2skLvTwfFXfqorsbDWMYw2k2AsJ39Ns8HUodLA2LR7Xanf7J6USzD4Zmm6d7EtgmKdoZAQaNUJq7ba0f4jE9CwhYyYHtZyYX5ERNVZav3Fig4Hgi+BnmjLiZT471mU9LAR2YlbfVXICo/C5+fk+zUbhiRGsnCHkCsF10OstS0DQz34uZpBb8yT/p9cAzZD5TTVcCUtxYVWbMqSbma
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR02MB26463AFAB1DCCECAF8EE9C00B8770@CY4PR02MB2646.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY4PR02MB2646;BCL:0;PCL:0;RULEID:;SRVR:CY4PR02MB2646;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2646;4:WIOJtQKQgs97Q2JyYcFgx0/npfpxoFTAtAIUJppyUzddmSJ44x2lbb03EXTtYMULIk7awV1E9A+gOP3HxYEPXlOH2TEADmLdYcDp6/oK2aypeCTkKfxiMzl4SHKIk33/nC12b/Dw86YaCYZqHu0IYDCTcXULzANggxvzhb1zzSDuI3NxE68CX0ad3pBqCA2hpuDlxud2T3ON9mrrS0D7q+dgOAKQZXgSoS73OwmvhDnEQoGEasETXYSsouTmmOH6/elI5DhEpMM/psyeYg5uGgUQoEuPGJ1oV0XVhPLP61tJcQ0ROr+s1vDbIa5FUNv1
X-Forefront-PRVS: 070912876F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR02MB2646;23:bB58a/8AO/fiqeeGu5zlMYbcTM9tCx1FG2My3Bld8?=
 =?us-ascii?Q?nZEXHK86/VCiU9zTz/WqW7jRz5U41YD0zv3AH3J9fBin8K9mV8iXw7gZzSX7?=
 =?us-ascii?Q?lTcFvG7KXIAFFOTDwTdLCsXJA/8O09FJhJX1VbreW3BrB7jHzVJ6LiRRb6Nj?=
 =?us-ascii?Q?k3uSI69QLFciUt3LycPg6WI4yOI6lwlZ3eVieuHDg428at0CNqUBrEow4NFo?=
 =?us-ascii?Q?yF0MAzOloIluaMTun+sw0nwlqLlqs/M4vaexEek3rTOOCz02ZKCmxQTOh9rX?=
 =?us-ascii?Q?dTxXQEuUcth79yTN3lhLWR9AE+iO23v0Bf6MipHDs6LAUuDnUcU8MdOQMB4g?=
 =?us-ascii?Q?KYJ8kVqLDBvcNjmXe9MVhUTd7w50Wk3d+en/BU/1evWjEnvEodCEuSK5IQEG?=
 =?us-ascii?Q?hPu7aNuoMv/rJOona8z+YTuZTEVVqPK6iVU8JR5Uu6M2YHVuD073YtANn6Tu?=
 =?us-ascii?Q?3zkuJRDiEWgZHkfQm/ADYnyn+seDsbMciC82rejM6fp7UjzojjbVnqsXBSb3?=
 =?us-ascii?Q?VEJ82aGBH8Xwj6T9b3OXxtyeY4zWEzBn7Wn4PAgxTAjESPXFQQgae2K4pUc+?=
 =?us-ascii?Q?FlSgMUExfxypXwbTgVTBV2xJRFEQd6drWv220mTUJ9l25pddYZxup5ubqJH+?=
 =?us-ascii?Q?B538NrbEzLrXXg95eWtDCjqUlU/J6MuKkgdDAjpqm9GHbjxu6q/PKpWpGnz4?=
 =?us-ascii?Q?rd3uEIQ1vw5ugnzOablv3y9oBDdSwTQKwP1+Fm0LmCVO4bgacZ4WcmOqbM1E?=
 =?us-ascii?Q?ZKQ04k5V//VPQvVLLsw09GGSGPKF8oVLXaeJ58aesodSB/2rgWfaHJdZEVw7?=
 =?us-ascii?Q?o+/9jPhc8HUb6eBKlir55Y7rIOWojWjYHWrgM3e+OUD7yd+6OyHhHMtmm/XG?=
 =?us-ascii?Q?OyQmEdUHGST/aJXiRzJi/85DAAI7p4mG3ZwzivWfPsfCc1HmnYCqvnzmKOmR?=
 =?us-ascii?Q?Xe8kq7ST/n5rZNV22/wvB0ayXg/C5Yzbgj3smwcWp/o+5MMO/COEMdoIGdlm?=
 =?us-ascii?Q?vMllVGzBsm7QTRYVE/+pYg9imSODv5kWDJX6ZDgmB+GtNtnHdXrjlpkLAxB5?=
 =?us-ascii?Q?+/oFiMRanus4VzVB09r6JGAXGB/X3Bk+7a8XYpmy6kN8YxJxtGjo/8g6YNfC?=
 =?us-ascii?Q?nLJBLsLDjHKSTZwnKduC+qCc1JppQPt7TAU/9Qyq5W/dArohE+d+71ydcNtn?=
 =?us-ascii?Q?1QRVQj70Uc2TxxNhb7DxF4rO6umc4jQ5TB+0XqhrbHYQXQAGwdswwq0hZvVc?=
 =?us-ascii?Q?jD0EPtvYUDkI2b5sT4JdVDYdGnv2owyhdWzF0f0?=
X-Microsoft-Antispam-Message-Info: v6AmHEzItPXxvHctnJaZWBzzz8+g/u53gct1DHGd0TvgSMYJWHxWQwT8YZ5bRtjweFG/ZUEuEpOQ+iRkG7Gr15PWTgvQ6TKNUrCq0HhTg2zZ10nf/pQU45/Gc9Oa7lukn/4tQexJd0ReERbZqRUFzB7XikHeqaHouGHOUkw3btyYN5qz61S3j+BBv0ebnwr0UVWUSJtU9YO+ArHD5oOMewSKp8nfAWh5FGe75I8rD72nbGfSftKBeUnRR/7ITlWngLXiHpDNyAG1uK+1HNdDb4zMNNoDFYbDtBYZm/ZF1SdqPyaE1AcCPKfxh3ivgzmSvPiIetukMnBnqMKNWYWZyw==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2646;6:82Wzk/R7U0E8NeyTsMSuWKbSVfEeRBcRnPHRn8wWSW6h80tYD0RgwpIKzCbyF3GVc1S/+ke98emsqXbjtDlDUqZZjX5Dv8gi2nLKEZGiM/OkCFxvLIHkeoDAUHCwFFswW3r3UJOYJo5qgaBSVqBZJQs5gOjd9PcBL4tAm5lYwfVFgY9IKgT4Ed1VvKkPM3lzjr/yjWEqJN+gnXoXboSx8Wm5lIoJpan9j91B9nACdkhrko/EBx4FGXC19qvt+k56uzi8WCFbO/NghMRgiWJ9Gnnv/xZOssHGWXE4/7aVg07gSW4DTzk7YoC3u+U2O2KU1DpuJb24d3LjB4VSsjv1eEzq5oJbkQ6rXG3PvmqzRphBIjxOfcBG2QL9zMwPO06GK76VeGm2bSGS39DGy2SfG3VrgO52l29IsgEXGF3B50XG120KLA06itNI5wL6kgk1LFhQz8iwtbYAx5Qv5hzZRQ==;5:2Kwygo+7Wv8gdrtPNpfLlAM+eGvY57ChOuQB/7af/599e3TpcxoSa+hPYxDK6qrVFXjKDJ+SMN3aS3AWqlyr9OrfcBgSfjM7FDQa2nASauLD47fKq2Vd5gzORR8whaykcDXWd0BUdGIf3pdGM0W/UGwbuy3GQz2JIf1vIqqgu7I=;24:eW1GG3CzEx32r++3XhHdqfrjGG75XPkMUlFpbUD+5VcfiCcnBzmoDXUW9PqdackZMaxRXI9L9kP5VDqNJD7tVZlWTfpqS7orFxejuW5ynuQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2646;7:9qQ3W2qca0jG5ZQ6KazsujcqT0G1E4udz9hAUk5Fmlb+K6TT2jQf+Kz7Py6kZrXc2muiInqBI37/BFEBV928wcj6sYWfCgucIC/xZn2PyOhx+YnTPskAjFvfAbKMv8/IP7Prr718iHFeeZEAsP2QuOnfHU0ONRESzVcmx7XiHx393d7hKw1WgBHXt87VokXDZrydh9ewveOvS52inI9aUMqYFcDN6YWKulsuEdBca/r+gFPYFYfAhAEwAuSPB4Qv
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 17:40:56.3114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c63d4d56-489d-4c68-f48c-08d5d6d4fad2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2646
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add ZynqMP firmware IOCTL API to control and configure
devices like PLLs, SD, Gem, etc.

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 20 ++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 70e335a..34c5ad5 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -241,8 +241,28 @@ static int get_set_conduit_method(struct device_node *np)
 	return 0;
 }
 
+/**
+ * zynqmp_pm_ioctl() - PM IOCTL API for device control and configs
+ * @node_id:	Node ID of the device
+ * @ioctl_id:	ID of the requested IOCTL
+ * @arg1:	Argument 1 to requested IOCTL call
+ * @arg2:	Argument 2 to requested IOCTL call
+ * @out:	Returned output value
+ *
+ * This function calls IOCTL to firmware for device control and configuration.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+static int zynqmp_pm_ioctl(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2,
+			   u32 *out)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, ioctl_id,
+				   arg1, arg2, out);
+}
+
 static const struct zynqmp_eemi_ops eemi_ops = {
 	.get_api_version = zynqmp_pm_get_api_version,
+	.ioctl = zynqmp_pm_ioctl,
 };
 
 /**
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index cb63bed..2eec6e7 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -34,6 +34,7 @@
 
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
+	PM_IOCTL = 34,
 };
 
 /* PMU-FW return status codes */
@@ -49,6 +50,7 @@ enum pm_ret_status {
 
 struct zynqmp_eemi_ops {
 	int (*get_api_version)(u32 *version);
+	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
 };
 
 #if IS_REACHABLE(CONFIG_ARCH_ZYNQMP)
-- 
2.7.4

