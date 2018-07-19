Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85481ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A2B20856
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="GoduRwuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A2B20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387964AbeGSSn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:43:59 -0400
Received: from mail-eopbgr710054.outbound.protection.outlook.com ([40.107.71.54]:57161
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732159AbeGSSn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:43:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOeZDwtxdeSTLtm+/2kwdpyzc1BFlZl+mTOp1APZS3A=;
 b=GoduRwuwrvzD8Mq0wRJ62Ezj4Jtk1lOT8ffiMnYD45uU32pAjRNTk5IJrLD7zLLHHYpYV6cpQr03r9rkj9XZLnpjUDcVjxqfi0AqTQ+5I10ygiylOPwwtkG+mC8MnMXi6lQpFfPvYqJs4T9yPwPUnaA2mHYW45M3Pg3cQ2y/Ngk=
Received: from DM5PR07CA0028.namprd07.prod.outlook.com (2603:10b6:3:16::14) by
 BYAPR07MB4710.namprd07.prod.outlook.com (2603:10b6:a02:f1::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Thu, 19 Jul 2018 17:59:29 +0000
Received: from DM3NAM05FT004.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::207) by DM5PR07CA0028.outlook.office365.com
 (2603:10b6:3:16::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 17:59:29 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 DM3NAM05FT004.mail.protection.outlook.com (10.152.98.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.995.0 via Frontend Transport; Thu, 19 Jul 2018 17:59:29 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxNgG025447
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Jul 2018 10:59:28 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Jul 2018 19:59:32 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 19 Jul 2018 19:59:31 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxGrZ006049;
        Thu, 19 Jul 2018 18:59:16 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6JHxG7L006039;
        Thu, 19 Jul 2018 18:59:16 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 26/31] usb: usbssp: added endpoint configuration functionality.
Date:   Thu, 19 Jul 2018 18:57:59 +0100
Message-ID: <1532023084-28083-27-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(2980300002)(36092001)(189003)(199004)(48376002)(14444005)(186003)(87636003)(478600001)(107886003)(50466002)(4326008)(109986005)(26826003)(36756003)(5660300001)(1671002)(2906002)(305945005)(426003)(105596002)(106466001)(47776003)(6666003)(7636002)(4720700003)(126002)(50226002)(76176011)(476003)(446003)(486006)(11346002)(356003)(2616005)(42186006)(51416003)(316002)(246002)(86362001)(54906003)(16586007)(8936002)(8676002)(336012)(26005)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4710;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT004;1:zUkGC05L4fCGepGLQLuWKDqtr3DtwRGxMBLYQsqRQTMlX8GWGjxWmktDqZUF4I55cAHi/kmET2TKNN4NnDmo1cJYbvXrQuBWx7dBGkiUMEoANKwbKTqHkhjkO1R84BLS
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f6945f6-df06-4393-e3ae-08d5eda15ffc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BYAPR07MB4710;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4710;3:eOFSSLJk/S+/3BmJpsVVJT7X/TPFyS0avm/1VzOuVPaRI0MYqJ925Vuo58wb4jOeQrheUkOC6OMpBytmYa2nobX24p7A8CwTEGJoJuTKvCZskhf8bEQRzhz1ZgIptPl+ONFPmrky29XP0IuGSuo2G+JyTiNFA1oHV2u7iIRvk7paMaFn6NIc5KAfvT1KKVOwX3PBCQM2zyibK7RBLdCcGu3s3wD03rvnfGtFloXwF8Wb9QJgRSQQfDB94fN0eBQaNkjPTu38Mrj+OpwWYN48ZrgNGOs4Qh75YdV46ij+LWX+wYE2UvcowJm2hwi3lJ806OZzELOCh/HTGxx4SQKGJQ2tcXTsJsw37jN94eZN03g=;25:hvQTWaSB8hcTEkSPkQ7hRDMZTxqrGU2PuokV4NcvGw8BiuPib6RddNg9Gla8RO/8S86tBbQd+P7hivWufES9MC/2RAopVVOsO37ZZhX16mn15kQcbH1/gUHjz+VFl5/+VZDv+zfx3wrbgv9iu5lCGyzaLYGMRKFzvwAc+nNgmu4I9i4W1ahf1WQJscCVGTvWGqNn55geTT6L13lHjfUzBfdrllPRv+w7W4CNlXVtNK1nRc6wUCYkxYwrmki22PPvwUYNzHacVxdcwbi9Yb0mhbvQCwCpSECOeRXmYOCj1x4TXYR6DieLi8b1Dl6vieZQC4iGbm4/rniEiv4oW0DE0g==
X-MS-TrafficTypeDiagnostic: BYAPR07MB4710:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4710;31:XBInSFkEKikzJYSLGTzlLJZK30Re36Y5NDAjynZP6JafCqn4KsBT5eFF5Zq5GvJVlszRdp9Nd4ESYxt9FHy++2ZZCRp7cOrxM1iRQcweHmJqjHXvbN2a9fpAKaCvUQsLJ+ynKq6++dIb5kzrdP5/5JSvbFJDV/YU/poFmLJS4kzqaXQZtrH1J5EzzLl5kmp32IMtaYMMdh/UK3r+Wbu38FYvS0a4joTN01Sw7i7p8u4=;20:duhUnnLd4f3gL6KytQlEaZNiJypfHAeJQZj8xu3mzORs6a5FnPYk19JuRQ0o+H0iiv3Ou9+11ZctFZj32z+YgWfJoGdqTRxfV0lYBeQjbbeuSKD+zbC4lFBD2n+fByb/yeAy2x33izqDJ3YcqaZG5nqwfLvrqpkZPQMU3MqeeywsBBxP5i66mKnUKN/C93U+W57obDZzgfQzolo16gaVEooOX0q7uB4JWRg7uJHq0Bla2al3grpQ5s8dvQggpjmYof20ZNa5041r4fWpUjTQ1aj03TNayrQ8WBGRhYcvVScbwWQqIPHFJJ26IiQBhV03O4V70quEcXmxdesX7a8Uize0T/ym0/M5HJr+cafun9jFmQiK/JR+jLLdGM/5J5VvHJF7zYRX3StZeSBfry9tg24mVAl00nOqnjzzNFrbwU415wntA67+0v+RMp4GRj6dwlY7gsDpKO/+Z2sutZ/3SGJCZ+XKBZTM5j1PoAb7QJQQmSh/JSlLYOs9KtNVkjFJ
X-Microsoft-Antispam-PRVS: <BYAPR07MB47109B44CE4C17A2EE941026DD520@BYAPR07MB4710.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93003095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB4710;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4710;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4710;4:pitL8IZZGjqvTjS9SuDK2dC34tRQ8X6izpKiBH2VPGv2a43/uJUHj6rwFsq05aYE2/p0mJs5oqOlE54wnVMfd1TDiK1+YoH7Rf3ZXANwnz3LGtjx82t2RzcBMel3wyWctn0YThP0SPPaFeWH+/PXl1gZU43n3oe4WCH9EbADV68oIERq0E7T5HGRj7QKU4u5iT+glF8VEXmmXXr5k8B4jr6QZpnlK7HQNMWSwRgR6vJKWbQ6xIiMzLf3EfddyCUxrQeknDhCEKlp6JqkUMXcUXdJbL4AwAUOOUIoZ9/C6t6X8ZX3aJBUTGoZq5i3+GjN
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4710;23:LDaWbWVa5xRZ432WKYYin3VSZpkI85HYO2E8idvPX?=
 =?us-ascii?Q?MwrD2nSARq0OErn/Qxp+mHaQzFYZJBc/AuDBwZgEsVMgHt5doJRkuJFzPZNS?=
 =?us-ascii?Q?Ub9OEU/kV6cfeJkK7pDjzyYrzYTKxcqdU6DZcQxolAaxYVbMgXDt91c81hM9?=
 =?us-ascii?Q?7pBp5ptNOpZvsoz0s1DUcf+XWsOGF2QQgUcRvBoMk6bnyoYv1duotvaL1sUe?=
 =?us-ascii?Q?Jz+Kh22BvO8GtJXHLrx9gJuiMxEiD6DHp9+SASyB8h4Xx1Whr6ybl33sQwH6?=
 =?us-ascii?Q?Dahi6uVJzGHJ/1NYYMRIJXzRkYtxoJcqEdc7Ag48/BHUqPaNDZ86WJwLpGZ+?=
 =?us-ascii?Q?20ulMofnWE73E8o9RG/2hYXQZ2yL8haVVe4BF0rugiNTZLYrd2n159VJduou?=
 =?us-ascii?Q?GkwM5aEBz4a8W0/v803zBe3IK+E3LdxmKYWSHKE1iIiEyDBLMpeWvvpdwV20?=
 =?us-ascii?Q?480e2Zb6mL3sEZ38lrFY+pY+zlSfNDQhejrRfax91aERzuVrWbnfxyHCqmgP?=
 =?us-ascii?Q?arcPdSpECJDDtI4/yUVtZLZJkdpMfvN0RJdfw51d/W0gY54fN+UQxS2DCNT7?=
 =?us-ascii?Q?5g2SU1MzPZtaTV6Pn4YPJBM3NgKZe01CtCdhp2Cenak8zVz5My8L1uAabDOc?=
 =?us-ascii?Q?6xmy6hfvId4l6HXHKJNwYpfQjoEFiM/ZIYN2PNtP7UbZop4QYLkePK62ITTW?=
 =?us-ascii?Q?IL1Ijbjz/D23Fi2mH9vSPXzSNskB/EZezgSp0a9k2zhaYI8trAgtJTVUn3qS?=
 =?us-ascii?Q?gMGZ3K6RbhI7TkrfzmvtYThxvA4UN4PRBmqofiKEwy8KReIoh70mngMP16NA?=
 =?us-ascii?Q?Whs9FZOCTencDNEalVInzZ6vjWrswuBtltt6MHUy87yu7SXqIzubk7c0rx0L?=
 =?us-ascii?Q?1FAMtmBYZ/wy14GeJoTKMZ/QpYxmEB7V+b55SyIAZ8qNcupcV23Qq1IjO29Y?=
 =?us-ascii?Q?ba6XABNx2at2pdW2nDpmfyNYfKYa7Iw/jzU4vlz2S2qzjfz9uCErVGH1/vnI?=
 =?us-ascii?Q?bk9NpZY2RVVONoGFt+QCStUCT9JkjGlQG6cRfpDyLWdEcxKFlrYE19Mx8d3V?=
 =?us-ascii?Q?p9jZ9jBXfZELPrtmDlv6ttYybsxy33RXeVESPM65V3g/MOgYJWo1UVc59Tlw?=
 =?us-ascii?Q?17y9zZhJO6Gry/zSvf9uZlPJFlyMJE7BBbTY/7uKw0nnWB3iq9smA=3D=3D?=
X-Microsoft-Antispam-Message-Info: EIgmt5DYgBATkaGsmSFJuII6VTo7OBuaTJRTZfYAbnAzxnPAY0u6srPEgW3rB3jO7WEs2ZR1aqHjsOh8sn6eaSVHC3+VpnrDf6vN4pGEa/Kz38BxAbIF91Qo9tVd4OfUUTu5fSxELPXeh2thG+vLxSVc/Vf3bVMGXcO2ZJ6t/S4hszgjD2YqtyJbicRNyfxSvM83RWZ4kPLnt64NhqWRXAaHbu/LYqwhru7UdsNMWsYyOkNQ0/MmD3sYExtKrqLOGEM7UR+ZzthsORJ5C+FDILIj4CLEjr7O4gcaNSntjd9BWH/24BYdnFRL3d+/BHq5J4tdfa+gRaCh3XlUXFOIpWwg0GRFc6nUye0Kndwg1kMwzaQV3oAE1xFmnreetOvQ0GQbZhGMgq9/GRPMiLvqPQ==
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4710;6:TApp4CqO8BCsKto2tkCvVdBh29LD9xmI+y26IoPurYsHe4AmuP/Q7cd8bFpdUsebesG9ns4EA0C2kW+NZ9EDeJV/u5a7uyp+fkdLTCCUSrFA3tkpOOJ0mmIRygjOZftl32iTzlYJS5CE+1+qNcvEDYOyQ2GwXxTO2wjS9TAlj2XBDkba7Fk0qj0VnPYxBC9gB+Me/Lt+lip6zt7YajvRr8sAqLkhyg9KF30Z2HfzoXSglAw8XlqL6OuXxmT25zN/NNiXjSpdhs1jKKGuTHYMkvLGvMKRhifGbAKPjUidCEl0NOQnloKJZYlzi4Ea7VuPsCHMuYDlUTnAEoL3NHA2NAp05dWI5SI8k5zfwIrkhbBfX6p/VVaWZ4wOE7DTNAunqsdJS7sls1mBND8Th5QrjHdxxW4ivg7KkTr+/LsM/9dwHkrn4iUc6eLErUbRjU4duDxP1BMKJ7tYjP+0cjtmNw==;5:WWi47F/gO6d9UxBDuzrANhc/wZyHxSpxVz9jTPo/8fwvvBPNndSNCF2N8kIdyAqZPQq5zhxIZzXRuj+JLfJcX7I2+c4CdwlGRwTr9EvLZ7CvzYvBZJpF6vC48qIMkpUSQitc1WMeUmSGTYEQJpvR1aH3VK/+PaZQ4eon3hgz/pw=;7:WYZv09ApmtL9s3BmCoYv6lCAZn0+399LPM0+uDXGjhPqJ7s387k9SRroevSq3ts7t5cGAvoSGuXy7tUBwZKb6Ai5e4afNnUwR65RryZJ3dhBBC/4khRO8bypL8UNtT9npAUwZXKcvcJHHg0OvF6bIJCnSL2oGC4Dt4gEcnAHeYCtxSQh5WLXj2RrV4+NPM8X7A2pATJaxC1aVMmWaj4+fTqb/BaJj9zxgF8ypTv40dy1+Gpqcz7HGUPTcrNn8Zf7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4710;20:ynGbzLExi0RNbG1vhRSD0019IDrWNQdgXWOTrC+3LpSvJ4OXpl1G9GWm9cvCEA0vFg9wHRavg2MRxHwa1/PzyaLF1dTM+R3uBC5s1s8RpyeYBrjsR/kyPOJDiJoYFfrXj0VAAHh5guNSJI0mGxuE2BtjzWiMhjRTVsVqyv4Q4XPEjuUzD1FwE5j4krVy3FxDixr6TZp7P0UPcFC8W9gqfLWK5KKxyUXp80c5QJsjhQjzDWqwi673co8t7O45SXkl
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:59:29.5750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6945f6-df06-4393-e3ae-08d5eda15ffc
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4710
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch implements usbssp_configure_endpoint function.
Function is responsible for configure usbssp controller endpoints.
To configure endpoints driver must send Configure Endpoint command
to controller. To change some parameters of endpoint driver must
send Evaluate Context command.
Function usbssp_configure_endpoint is blocking function. It means that
after issuing command to controller driver is waiting for completion.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget.c | 162 ++++++++++++++++++++++++++++++++++++
 drivers/usb/usbssp/gadget.h |  18 ++++
 2 files changed, 180 insertions(+)

diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index 0180ecfdaf9c..d5ed2c48e3fa 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -692,6 +692,168 @@ int usbssp_dequeue(struct usbssp_ep *ep_priv, struct usbssp_request *req_priv)
 	return ret;
 }
 
+static int usbssp_configure_endpoint_result(struct usbssp_udc *usbssp_data,
+					    struct usb_gadget *g,
+					    u32 *cmd_status)
+{
+	int ret;
+
+	switch (*cmd_status) {
+	case COMP_COMMAND_ABORTED:
+	case COMP_COMMAND_RING_STOPPED:
+		dev_warn(usbssp_data->dev,
+			"Timeout while waiting for configure endpoint command\n");
+		ret = -ETIME;
+		break;
+	case COMP_RESOURCE_ERROR:
+		dev_warn(&g->dev,
+			"Not enough device controller resources for new device state.\n");
+		ret = -ENOMEM;
+		break;
+	case COMP_TRB_ERROR:
+		/* the gadget driver set up something wrong */
+		dev_warn(&g->dev, "ERROR: Endpoint drop flag = 0, "
+			"add flag = 1, and endpoint is not disabled.\n");
+		ret = -EINVAL;
+		break;
+	case COMP_INCOMPATIBLE_DEVICE_ERROR:
+		dev_warn(&g->dev,
+			"ERROR: Incompatible device for endpoint configure command.\n");
+		ret = -ENODEV;
+		break;
+	case COMP_SUCCESS:
+		usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_context_change,
+			"Successful Endpoint Configure command");
+		ret = 0;
+		break;
+	default:
+		dev_err(usbssp_data->dev,
+			"ERROR: unexpected command completion code 0x%x.\n",
+			*cmd_status);
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static int usbssp_evaluate_context_result(struct usbssp_udc *usbssp_data,
+					   struct usb_gadget *g, u32 *cmd_status)
+{
+	int ret;
+
+	switch (*cmd_status) {
+	case COMP_COMMAND_ABORTED:
+	case COMP_COMMAND_RING_STOPPED:
+		dev_warn(usbssp_data->dev,
+			"Timeout while waiting for evaluate context command\n");
+		ret = -ETIME;
+		break;
+	case COMP_PARAMETER_ERROR:
+		dev_warn(&g->dev,
+			"WARN: USBSSP driver setup invalid evaluate context command.\n");
+		ret = -EINVAL;
+		break;
+	case COMP_SLOT_NOT_ENABLED_ERROR:
+		dev_warn(&g->dev,
+			"WARN: slot not enabled for evaluate context command.\n");
+		ret = -EINVAL;
+		break;
+	case COMP_CONTEXT_STATE_ERROR:
+		dev_warn(&g->dev,
+			"WARN: invalid context state for evaluate context command.\n");
+		ret = -EINVAL;
+		break;
+	case COMP_INCOMPATIBLE_DEVICE_ERROR:
+		dev_warn(&g->dev,
+			"ERROR: Incompatible device for evaluate context command.\n");
+		ret = -ENODEV;
+		break;
+	case COMP_MAX_EXIT_LATENCY_TOO_LARGE_ERROR:
+		/* Max Exit Latency too large error */
+		dev_warn(&g->dev, "WARN: Max Exit Latency too large\n");
+		ret = -EINVAL;
+		break;
+	case COMP_SUCCESS:
+		usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_context_change,
+			"Successful evaluate context command");
+		ret = 0;
+		break;
+	default:
+		dev_err(usbssp_data->dev,
+			"ERROR: unexpected command completion code 0x%x.\n",
+			*cmd_status);
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+/* Issue a configure endpoint command or evaluate context command
+ * and wait for it to finish.
+ */
+static int usbssp_configure_endpoint(struct usbssp_udc *usbssp_data,
+				     struct usb_gadget *g,
+				     struct usbssp_command *command,
+				     bool ctx_change, bool must_succeed)
+{
+	int ret;
+	struct usbssp_input_control_ctx *ctrl_ctx;
+	struct usbssp_device *dev_priv;
+	struct usbssp_slot_ctx *slot_ctx;
+
+	if (!command)
+		return -EINVAL;
+
+	if (usbssp_data->usbssp_state & USBSSP_STATE_DYING)
+		return -ESHUTDOWN;
+
+	dev_priv = &usbssp_data->devs;
+	ctrl_ctx = usbssp_get_input_control_ctx(command->in_ctx);
+	if (!ctrl_ctx) {
+		dev_warn(usbssp_data->dev,
+			"%s: Could not get input context, bad type.\n",
+			__func__);
+		return -ENOMEM;
+	}
+
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, command->in_ctx);
+	trace_usbssp_configure_endpoint(slot_ctx);
+
+	if (!ctx_change) {
+		ret = usbssp_queue_configure_endpoint(usbssp_data, command,
+						command->in_ctx->dma, must_succeed);
+	} else {
+		ret = usbssp_queue_evaluate_context(usbssp_data, command,
+						command->in_ctx->dma, must_succeed);
+	}
+
+	if (ret < 0) {
+		usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_context_change,
+			"FIXME allocate a new ring segment");
+		return -ENOMEM;
+	}
+
+	usbssp_ring_cmd_db(usbssp_data);
+
+	spin_unlock_irqrestore(&usbssp_data->irq_thread_lock,
+			usbssp_data->irq_thread_flag);
+
+	/*Waiting for handling Endpoint Configure command */
+	while (!command->status)
+		udelay(100);
+
+	spin_lock_irqsave(&usbssp_data->irq_thread_lock,
+			usbssp_data->irq_thread_flag);
+
+	if (!ctx_change)
+		ret = usbssp_configure_endpoint_result(usbssp_data, g,
+						&command->status);
+	else
+		ret = usbssp_evaluate_context_result(usbssp_data, g,
+						&command->status);
+	return ret;
+}
+
 int usbssp_halt_endpoint(struct usbssp_udc *usbssp_data, struct usbssp_ep *dep,
 			 int value)
 {
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index 6737cb05cd27..81d7fe44519a 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1692,6 +1692,7 @@ int usbssp_alloc_priv_device(struct usbssp_udc *usbssp_data, gfp_t flags);
 int usbssp_setup_addressable_priv_dev(struct usbssp_udc *usbssp_data);
 void usbssp_copy_ep0_dequeue_into_input_ctx(struct usbssp_udc *usbssp_data);
 unsigned int usbssp_get_endpoint_index(const struct usb_endpoint_descriptor *desc);
+unsigned int usbssp_get_endpoint_address(unsigned int ep_index);
 unsigned int usbssp_last_valid_endpoint(u32 added_ctxs);
 int usbssp_ring_expansion(struct usbssp_udc *usbssp_data,
 			struct usbssp_ring *ring,
@@ -1704,6 +1705,15 @@ struct usbssp_ring *usbssp_dma_to_transfer_ring(struct usbssp_ep *ep,
 struct usbssp_ring *usbssp_stream_id_to_ring(struct usbssp_device *dev,
 					unsigned int ep_index,
 					unsigned int stream_id);
+void usbssp_free_stream_info(struct usbssp_udc *usbssp_data,
+			struct usbssp_stream_info *stream_info);
+struct usbssp_ring *usbssp_dma_to_transfer_ring(
+					struct usbssp_ep *ep,
+					u64 address);
+struct usbssp_ring *usbssp_stream_id_to_ring(
+					struct usbssp_device *dev,
+					unsigned int ep_index,
+					unsigned int stream_id);
 
 struct usbssp_command *usbssp_alloc_command(struct usbssp_udc *usbssp_data,
 					bool allocate_completion,
@@ -1771,6 +1781,14 @@ int usbssp_queue_isoc_tx_prepare(
 			struct usbssp_udc *usbssp_data, gfp_t mem_flags,
 			struct usbssp_request *req_priv,
 			unsigned int ep_index);
+int usbssp_queue_configure_endpoint(struct usbssp_udc *usbssp_data,
+				struct usbssp_command *cmd,
+				dma_addr_t in_ctx_ptr,
+				bool command_must_succeed);
+int usbssp_queue_evaluate_context(struct usbssp_udc *usbssp_data,
+				struct usbssp_command *cmd,
+				dma_addr_t in_ctx_ptr,
+				bool command_must_succeed);
 int usbssp_queue_reset_ep(struct usbssp_udc *usbssp_data,
 			struct usbssp_command *cmd,
 			unsigned int ep_index,
-- 
2.17.1

