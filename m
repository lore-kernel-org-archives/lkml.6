Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC27CECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 05:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1452147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 05:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="He2IMNPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1452147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbeIQLAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 07:00:07 -0400
Received: from mail-sn1nam01on0058.outbound.protection.outlook.com ([104.47.32.58]:1472
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727874AbeIQLAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 07:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UxpyRyy+ygjK9kSEx0ttCabd1NkwW2+oEbmjxdWMUo=;
 b=He2IMNPFL/14FjpZfilqM9fcUm4yNno4MVoWcIJ4p/fE1V/ucvmz05gRAcd0x9eKMYUzqR69JWmEH9gaXmDMWNG9Ki0OUWojglwt7kOhxWB1UX/h2L/6CVn2dI5vJ5YXPjlS1w6JCwS2Sz+eq6EkMtHM6OW2eSLUZzALFVQR5k0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BLUPR0301MB1571.namprd03.prod.outlook.com (2a01:111:e400:52a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Mon, 17 Sep
 2018 05:34:14 +0000
Date:   Mon, 17 Sep 2018 13:30:41 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH mmc-next] mmc: sdhci: fix __sdhci_adma_write_desc
Message-ID: <20180917133041.66100101@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: OSBPR01CA0005.jpnprd01.prod.outlook.com (2603:1096:603::17)
 To BLUPR0301MB1571.namprd03.prod.outlook.com (2a01:111:e400:52a9::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e589456f-b7f1-4a5c-10b3-08d61c5f357d
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BLUPR0301MB1571;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1571;3:3OwQa+QoJnigHoHGyXMfNpaX8fqhomADOh2CJ2YViT2CVP/oUgNbvSs3ZSFnfcWt3Wn5Baf4LoSnXwwWfuKUIz2OEnfqp6YOkGq/qptO78Md2NnWDXTUJNS/6Z6JYUjzFatjIkvaSlG1GNDyOiltlLb4pvpdrTNqR3lcnaKMe7PDVziIMFaiR5W2e7axwPO7JqnZyPadvIYIix0uf+3AlWFYlyYlnWh3HFCF0usOIpGOPMm8x0EuWtvQdldTpYUN;25:D8gG8Wt3dDUwND6HXT41bseS0yHsLioDWzHo2Ywa/BqgYUPQpk2GMO36O0+QjM908puOljTs9ddApl2b/B6GQljST1c70/Z4oQEcmtHpDKyQ32cEua9suL4FamOY29VZzI0OUXIzuz5KrO9YiRQGa5AJY8HORcBqZHJKGR/WwDLzdrCm8u7vUm/oMNHhxxEpD240BsqUxrzDXnAlt0ErPzkAAMAaf2uO+pDT0IL650vRxvf5yli7xm6gLtC3QUxETziYskhJ7REXb+txZ0MtG39EIRo9rSlfuJK4qqwOY+/p6Pw4tWPUDVEDYQTgoVYwsCTdOa2TdUU6VakuKMYk6Q==;31:uAktickShyA6BLP11ueX/Z+9RgVblkVhGgtkbJJFJDX8Zestzrr0+pIOmQ11TVHwubXSLEAdRYyMmgisfjap2stAFHbaEJ3pBZBLBpD0hqs0lDmx5sw8zMNrl5bSnGF6jU+s19W2JwTVOd5Ha4SYKNmUG9S9esSByjiSZjoKV6S3ZYrcguhWn1zOV9rsO5Q/Vwn3cHDnNNewb9yUdvAf1jWXd1EunZ02HEn+YSoCVnU=
X-MS-TrafficTypeDiagnostic: BLUPR0301MB1571:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1571;20:Z3n0Ap/WlQco44QsVJmOLh7Q6bTa31VFDqdBXB8JxCPUtYGZ5kaksqwSYfM3VBMNe1R72p1sEVLC46+dhYPJrnKthKWg2N9vPZK/Lbv72ZDEkRrBRsSTHYcGeAtwIYjJuQNaY40soMj4FbwfIJKeL7+Xaq9gVYBSYvZ2lzQjvaRM4FW9jJ5eNq3MlBeKgIyAXPdnm35rnmvWZqGM/fK5K+oAje7ZQb1nXl7IQWjvxs2AMsYQovVS7uwDWtg7fhKLVGynRg1e3az5tuGghxEyV67MnED5eb1Vdd9YKzdoIRn8+uCU3K+imQ418tKSFbY1KABhTuDbVC/nRpcrRzIBXNFHWUJ09TbcJrywGbRlLe/Qm2TXVLWunIq4aU6p96eoteBqyGbfyx3XUGXTDu6/HGfgixIPz3rPxRH/Ptjypjr2KnsliqDflrgQ1FXMdZhSWkoO3a6ZzNAzWpvwGKHoDGPjTli7uFq8tKAec2/1hrY3nhkLlGkr2+nEKrPNUlm0;4:fmijVdiy3QgJROf4+3AObSRDYg+3M1SXcLDTTAAdxrAsC0TzyY+Z1rdR2nyKZpf4dBmHfpZBGKLtAiND0FF5GfohSFydF4jRnw0qSsnDcfzqb/VnjNYtMY0ONRaFo8Q1l0fAClZE/ALUtmMj9dXjfDW8KdJRzSMMNwTc8lgqVCnXrB2tGKxceCXPjGfMNYF+jt6yEfwv0NF7hgKbb7jRyYjjIHibQMhvxqShhwgyfFi88ojL4WxZ2EtNF1/BINNIHXNcji/KtpUSkQH++kUOWQ==
X-Microsoft-Antispam-PRVS: <BLUPR0301MB15711ECB43159346EC17536BED1E0@BLUPR0301MB1571.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050);SRVR:BLUPR0301MB1571;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0301MB1571;
X-Forefront-PRVS: 0798146F16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39850400004)(346002)(396003)(136003)(366004)(199004)(189003)(53936002)(55016002)(1970100002)(26005)(186003)(16526019)(33896004)(106356001)(7696005)(8266002)(52116002)(97736004)(68736007)(97876018)(86362001)(2906002)(6506007)(386003)(105586002)(486006)(25786009)(476003)(956004)(50226002)(8676002)(4326008)(8936002)(81166006)(81156014)(9686003)(5660300001)(7736002)(478600001)(305945005)(117636001)(72206003)(66066001)(23726003)(1076002)(6116002)(3846002)(50466002)(230700001)(6666003)(110136005)(70486001)(47776003)(316002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0301MB1571;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR0301MB1571;23:WsHLk84sv7k4m1RUVXHAhIRIUC5FFYqSLEZJGO9?=
 =?us-ascii?Q?8bF5QBWoPvNsY0hY5L6fQ1uEhaJsFlHBLe9L1u9/UmRx7AcHV7dpvtOakldf?=
 =?us-ascii?Q?tLc01QuR9YNN/pdCmwZXw1EcVHUkB/FIZpvUMyZ0TO8PR+H07qeVdD6pEPO/?=
 =?us-ascii?Q?CzIQotf/raRwgp2+LjO6vKd7Dd1AQ+67ZUx75KZhUQMcitaXWDf17oVqn3Mv?=
 =?us-ascii?Q?l92Y2XR3U6WTfBwc7yo8ibP2aCaEl1M//NIl7hsQV+Vc0OERJ0Eg6E3pcK1Y?=
 =?us-ascii?Q?Ko9v+BNtkRVyQ5T2tPx9pJjynrUqIYddAM/wARPNFE4HD60yOovHYjR2ORJs?=
 =?us-ascii?Q?fhqcXpvNPQrn1HG+IZ9rOR9USAobOPa8M5Nm8Jtz9x0syEsiDJOX3SSEh+eZ?=
 =?us-ascii?Q?vKQtKKi1Elu54SbLey9GVJz18ShPizNfaJ7TOY5p9tIGI86YIJnhiKSA4TfY?=
 =?us-ascii?Q?SSjUSNOD/eKaLsqThhVECphZCNZ2gS2y7wlRliq5t17N42QgXtwlTmxQ2jxI?=
 =?us-ascii?Q?DAKeozmZ65tWcXZz0Nk3sAs8cmh+zOAIn612HTuPGQvjF5ncbk6Jm60ZRYjw?=
 =?us-ascii?Q?NRsUap/HZYyKwI0laJFdcJ5cOG3+U6xLcs9s/lHRYWKLbRDgiOu0Fs3CrqTX?=
 =?us-ascii?Q?QK0JGEFWmS2u3pb4HfZZ1du2AZ//IhSm5PvePwdVUGYWv57XV4juLeJjPOts?=
 =?us-ascii?Q?D1tdQj2Pd2wsIv5ibzCs6K7JLTO6KMR6sHcKDYOaneniXVE02mt73CY+8wlY?=
 =?us-ascii?Q?pLtLlHwNu2/oOU2yvnf+pIWrgjngSGU7KLYAUefJzXxAxIv6FQR7IYQeQ9MI?=
 =?us-ascii?Q?ESX3Znzar38DTYI5t5uS/UERKueyFSvlnHhpSLCsmKZvu5PdrAPrvtw3tPlN?=
 =?us-ascii?Q?48U0MwWLAi2d5Vv+vKdSWRbYlJ7KgrdVwemCRZSUdcWFfrAChPeOTYN4qin0?=
 =?us-ascii?Q?lKwh/j3z03sJiHRehvmbmN009zgTx/p67N3LEAJ/A2+0CxB8pPin5EELT5CY?=
 =?us-ascii?Q?UzmJMmO6S5GDeQFY6YpPBc6+8kbION0LaO19apKj7vMIEkv3BIuRQ5ha5i2G?=
 =?us-ascii?Q?9kXhIiDjnZm2+Ci9i/gwXqMr9HBiVfM03+cntKMb+woJMBAOY1bUwCt+taCD?=
 =?us-ascii?Q?soX8yf6zmcFrLWqQ9QkeisCeT93Q83NPMpEeF2eTzARbE0n3pXpQP2GM9ps/?=
 =?us-ascii?Q?KbUv2RCWN6xtFD/YuHNdaw6lF2t6y5um0EF/DtfO+RDAmYlqFJhrcuJfmZEk?=
 =?us-ascii?Q?SDDvc5w/ppsIr9/WavDEZbnhUCSENQwQMeGs0m4UQ?=
X-Microsoft-Antispam-Message-Info: vbgoAvZ+J+EMHES4gLaSkS3pvAR4Yc8bZKILivQpQkrRVXQdKpVBYxi1t55f1y4DR0/kKzIIeo7NF8HX/qae/EegVtlRW2KVyMcT9AKDeu5xWNGohjTo+KJbPUiQhuwE1xRlrDmlSSmfGJx0Bw1vUx42sygKvKNsvgWIn8bDFceoC7hXhKkhax1TpnzaxkZtUa9DpdpHkFawsz09dXERAjtoDnb7e/AyN+DtWHHW4lmerDcajHj1dA/yf+Mt1pSxpPkRMv3ZGbVf64S53fL1jzs8Z4orSjh/iWc56M1EyAQf3ec+5o3kxOyu1cOFxrLKhjemoTfNwh7fdsZhTglkrNAmt+w6tg+pc1lbTgebsgA=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR0301MB1571;6:mdHfudhYAJq9DA4EI4//9Wm+GcQ9ZAGD7Pl6HUsFlWnyxe7t2Q7TIp1z2IodzHeYzff/GLPZrjL8kz7xgBi2toE0Ndh08FclE1A791amiX2ckdoE9IlwAfwb6ip06/9Q49Ga+ymRDhPyogc66LDEYoMQQq87JXE5vPwRKo/C5Gw7VPwvOFc8aQntwwV8dpu595fFnV/qU31tfcXItj3CW3rHk6uMdwrkomlJkshwrC80CXRgQjACrjvWE9nuvgVS66SJE5EKYnIH6vNUT2bfPGTUd8la9r+dNUIiEGbGtZV2QbNu581AttSFelX3jzPWpqJzjzrihEm1L2OTkGafXXn5a8KSrIYgb0IuAjEd21kSU787IquUSitrCsnIvMT46hcJfQjYlxz0vqv7cvZqFWdaXG/BHSyF6K87PK9w++HE/5osNfp+XkDulsFOEE74SGH1hdpvGTFixk6xO5nwmg==;5:PPQqNiSBj4GJwjJWDMuMDlbgKgVqlkSwr4zj/+BAZD6slKNenk6nmBRwA2dprJDZNTZeY32ZBkuBAEGoTcMGaomuQDvAf/UX22n1vBv5NkuqB6gPmIdbYNKlAle7YsNph6NVWam7BkuIJlgtjUYk3A9449tKYywfUesIC/rWd4A=;7:dUaEMgbwZs9xCUWHx5OiCfilnYQLIlFYeCVbulBdRgg2Ka4/QGf+GzGVTdAbpb25inSi2YGwxeYMOa8aBoTJmoFApWdF4Vwc8+pB+2wLE5Lfbj4EhdWERBraxNtz8qeBqFteDr4D0E07YtkALE4VCTVsC3v2yBuPSlbsFThjVeLcM9DdynpmpoK3gBwGz0pIut5jrI24/8iA9iMk0pPGPmb4UIK/PHjUVPrc7covGOzgyrZ25d3A7TkytFXr3G1e
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 05:34:14.6977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e589456f-b7f1-4a5c-10b3-08d61c5f357d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0301MB1571
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If hosts provides ops->adma_write_desc, we should not fall back to the
general sdhci_adma_write_desc().

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---

Hi Ulf, Adrian,

When I introduced .adma_write_desc, I made a mistake since v4 -- if the host
provide ops->adma_write_desc, we should just call it and don't fall back
to the general sdhci_adma_write_desc(). Before v4, the adma_write_desc return
int, since v4 there's no return value, so when I prepared the v4, I just
removed return, this is where the mistake is from. I dunno how to handle
this case, fold the patch into previous commit or apply it as a separate patch?

I'm very sorry for this. In fact, Adrian caught another similar bug during
review.

Sorry about the inconvenience,
Jisheng

 drivers/mmc/host/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0dda6f4b6a24..99bdae53fa2e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -649,8 +649,8 @@ static inline void __sdhci_adma_write_desc(struct sdhci_host *host,
 {
 	if (host->ops->adma_write_desc)
 		host->ops->adma_write_desc(host, desc, addr, len, cmd);
-
-	sdhci_adma_write_desc(host, desc, addr, len, cmd);
+	else
+		sdhci_adma_write_desc(host, desc, addr, len, cmd);
 }
 
 static void sdhci_adma_mark_end(void *desc)
-- 
2.19.0

