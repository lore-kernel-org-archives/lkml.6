Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3C5C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F92D20893
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="h3o8OVjR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F92D20893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbeGZI2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:28:21 -0400
Received: from mail-sn1nam02on0070.outbound.protection.outlook.com ([104.47.36.70]:39541
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726326AbeGZI2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EWOMrdTDbe4cRpWZDbzRTm7CRntqQXOyUE8yJ16jKg=;
 b=h3o8OVjReyB9249hgURhr+Gk8y3/m82yjcChyVDIGiGvGgyzR73zRKXK0DqKzCHM3n5Kl/lL4dwrMtD8f89SzCyDY8RPnwUFCsb518HI4koHsaZ3MBPaZypCrMmLR8M7ypD8LAanQ5mHaZIRmc7g4om1wFMZ4meA3MRsKemwInQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BY2PR0301MB1576.namprd03.prod.outlook.com (2a01:111:e400:526e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Thu, 26 Jul
 2018 07:12:48 +0000
Date:   Thu, 26 Jul 2018 15:10:17 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH mmc-next v2 0/3] solve SDHCI DWC MSHC 128MB DMA boundary
 limitation
Message-ID: <20180726151017.4da1e336@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0164.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::32) To BY2PR0301MB1576.namprd03.prod.outlook.com
 (2a01:111:e400:526e::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15777732-ab34-4f78-77a1-08d5f2c732a9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR0301MB1576;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1576;3:OVB5oH7NRY1kIFOv3dY4SLkGaVfvfp+O0hMf7hul1IwM49VuyJVMp5CiDJr51M/ZOyqNx7KBXI1H3NBUgMc6H9qmnMflbbRCpDJIDIxnp0JroLGYtuF4Y3nHncoWPo4qEpzmnniKaLVYWnSGrMm7Bed1xvOwu6ok71BIlfpfUA2eUfEhKlIyJN6ctG7bmnPhwQa+CoFXQEbgGu/0vbjV7IP2MzutYgpZpey++Wo/FJqGYbXHk7oUzim1cNHdVmkD;25:9ZzcAIKa+7kbakdmp88ugRsFndMkOBP7NEWUY+xiMQlFtkVK9+OuyV1FcrnD4B/L+W/nuWfik1lWIRSfs2RrqBBBqtLDWHGiPdjxHYcYt0BcO1G/bUtYpiG91cNyULxEz4GmfCnqlcCHnP2l8dR8+ugeo6EWynoKnTfUCcmjtJNMgJMxbgwxlrau210h8oKRG+99GSXwF6HO0m1Pw1w0KnvyA/Kz487IiCSClw9RH81W980OnvPYmPp6LkS3Rebmebd4T7VhcJgX8p6MgDZZyMc/diS5O457reYim1I/jBwqur0yMBglR6RVSAqS4LAymGOjudlRm/hGBICc0NxwQw==;31:QRSUBOMf4MSFXqJQu1UfnFzosKsVmJlJLtDBBouR3zkcM1T76iKR6m8PH9K3gdNO7c3veNccMxUw0Gxk1IbTXqUKt3tJDXV5FP2BzFY1RtI4Mo8PO8IdT+PNVweisvB7pKss8H6+XF2MW2940S9Faj0lIO1HF0eyfi4PCr1hVUEepA6KLwcradM0sZpsXOOBp4urfAxsI68IqKwJnMG+nUOiUVjERhZJNH6B6X8v83Q=
X-MS-TrafficTypeDiagnostic: BY2PR0301MB1576:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1576;20:o6+4GkYqqe8cP56nGwD+E/81PL33s3bxSyQc22VjCNSTHaR2oykzFHvOJhjHcZq63+w01EFS+Gn5wwnxAKFc8cDGwzeibJrUKTjEcr5szREYk58o6yADi28+C2wXGmJ1gJ8+xa4J0suYKFM2hJSNjWbK+JojVcmtzRORF3D25KwAHSkGFgOPGdDQpHXZiqKbJLOCWVe8RwaHgXAa3isA/AQZjMapr42iOhmsA2VANOrxolwxWWHitAB0wN9mjbwbLn66ASbuKOrzQbuI3K9v+V3qV1tCSrd1dAP0t4lXyAvW1yrke/FTnWubFsinWVixF/Mzu0Ot2RqrlTl0iHUemO7dEd2Lnr4O+PiYh8wqjVlLUs/QbnkxU9/Wd4+UOWVX3UE0Bxb/0s5g7IThvwld1v8RAfps80qjSMHz/gSB+nfH6qXhD+zp1wO5JBLxLcZHIvR4WZD7Oh5M+HrQBJ5wtFHiPT5zjtwIdMcQ+u990WrC9ww/YveAxPGayChJwXwU;4:jN2JB7oTbwTVkQ/aGteVQJ7HoAod03lFc5dICAIQnKrpp+ehdvVKtR6QxdE4WNpe9Yw3DqrZB6DuZQuYgpFf+5wePM985/wGwc25nTybOAvEncXzc7/2eokz32imuJTSttGKvwQrN+7CUgWqIQAKXfINCxa36+couokiU4ut1TewhcY8i6Uzv7iRlcO1HL6ZhsUlmkt2BySygyiID4P5W3A6P3b3eiITXqDEW12jNs7ReRkEfBIBKb89gfazWrMdDUGzEiwZdsaZW0QXuzOUmQ==
X-Microsoft-Antispam-PRVS: <BY2PR0301MB15769606507EAAA7E1B2604AED2B0@BY2PR0301MB1576.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR0301MB1576;BCL:0;PCL:0;RULEID:;SRVR:BY2PR0301MB1576;
X-Forefront-PRVS: 07459438AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(346002)(136003)(376002)(199004)(189003)(2906002)(217873002)(8936002)(97736004)(50466002)(105586002)(53936002)(106356001)(86362001)(110136005)(81156014)(47776003)(305945005)(956004)(8676002)(6666003)(81166006)(7736002)(5660300001)(66066001)(1076002)(68736007)(55016002)(3846002)(25786009)(50226002)(230700001)(23726003)(4326008)(9686003)(33896004)(72206003)(26005)(6116002)(6506007)(386003)(14444005)(478600001)(476003)(316002)(486006)(16526019)(7696005)(186003)(52116002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0301MB1576;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR0301MB1576;23:A4SuhaLlb4svuTiszatFF9oEz3Iu3lv9BbvEg9O?=
 =?us-ascii?Q?pp+JBWJZX8nbTiCOEW6XJnDbg772t/7p5ojRK2mwGJEMBUSLIW8IigbtNc7c?=
 =?us-ascii?Q?d4tEDI2B6WGDf1PGxo/kafh+HAekE47GyhWzWVonDuu0TPG5OCASsaszzp95?=
 =?us-ascii?Q?ZMSNrTXHcd0lMmIhyVIPEqvVpbOacvNGSMNjiBcv4ugnDi4l/YswUQ1N6V0t?=
 =?us-ascii?Q?Owk58FT21e9n8uXCkzzFPmg2OcGqYm8/NnaAa2chc9nFFU/GHYE8ZcejFthy?=
 =?us-ascii?Q?UK387ztkSzUnMcSauOZd0EdUBjBu/1IFtXW+zXlcvh6vo75Gv7uvgsWwx+qg?=
 =?us-ascii?Q?KoMiyhDDakaWBXtVaJPy1IbHLMO5KdOUWUjvg4+c2nGIhHCS35e7h+tGsF9s?=
 =?us-ascii?Q?scwUOMh0BeV1dxTHV2DyaGG2O1d8XNTqL705A+ugYA0TXb4kquqAFYgVprak?=
 =?us-ascii?Q?/MbzNNA1yXnkFWqW3K+sigcnQgbSKcH/BJRcSjX5841i6uNwxciOzt1aolJG?=
 =?us-ascii?Q?euXSjXmvVHEQollYKBlI+94l1TmMsZJMwhYjwDm+tXna8ojTN9Z6RnH6Bo3B?=
 =?us-ascii?Q?cIKxxQJ9SWnjaa/rC1WnJ9CzIcuEbDVmp60yiOUc0Y1aLmvY7Gg/gQI8z616?=
 =?us-ascii?Q?ihWna7nBSPTTlfOTgCKPf5IlTC789WM3Hpe/6+xeQkcvV1x24wAweGFJFpUZ?=
 =?us-ascii?Q?m4bKRnAf80h37/0LvyWkvyrfrU9Wsh58IbaXKWRVNfSHmDLANN1BgR+ky8yL?=
 =?us-ascii?Q?Tp3THdapPQSbjjJRRJuH2zzPDRA3GjNhLKwTtdz6d+dBA2EThQI9Ss8I80Tl?=
 =?us-ascii?Q?plDnsjy2srrL0F0J9fU/1Y6Tcdj6/Iil978dRQL1BqoWaGyrsS2KBsXvZAW+?=
 =?us-ascii?Q?TJUmnJNrR7MSUp1zs0iQih5GO5kMf/ZPfLLKIJrQlJwBi9JRnY77xqsrF7Y0?=
 =?us-ascii?Q?56KfISU54n7v8lZ+DzJdk4G5jBwMz8Gylkou9B5YvpF/zVEkn27rYzV9tJx5?=
 =?us-ascii?Q?mPrwtxjR02dsHip6CTTLEGEHsMrmTTMoQH2Z3ZcRcOV6G3Bo4iB+cypcAKmU?=
 =?us-ascii?Q?4MTpw6KOq5F49WOhJPyxV63oktMi3ZlGGswZJfXDPoVw4rQIP+7jjvZeNiAX?=
 =?us-ascii?Q?EtZE2/4JMxBDhJoGxVoGDbFcu66F94CGsXYNQkiND1vgMIzDJnHx7LOXQSpm?=
 =?us-ascii?Q?3X3YyCDorWHnHfEyV+y3sVQIU9zlM5VpZDSLa?=
X-Microsoft-Antispam-Message-Info: 3GJxZaf15U0//+UTHks0hTkuLB+Xco4OaSkXIA9Njpl9L8yliUQW+PwT7sOc0sP6MHlA5/02gI9/00AR+qvogHdUEQWKucd24MHTcCWRSI/5ctg5J13khEQVzSNxxeOtT5Nq1XjNejNMOnEB5+ETUAKq8fNe8kRwWQzp00yIP3rcqrKg+5oknmlUjCKwXEJC4GsZ01UugV7Wf0HTN1eFmNwtqNVPCQw3k92AINUCtNk8I98iWSMxbutR27Eg0tj83iiqPdA9FMmhcHo83w5WdFDVwzU/Smilvyhvzt8lnt2tKhH8+MiE9JtVuXXjat0qTwpY/ImnA/XIJJPwZDp8pi43N/Oph8pp+FHl9xC0NtM=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR0301MB1576;6:9szkyVgh6OctM4G+Du8rANZoJGc+tB6z5CRZHX3CjnF5nlCDgFL76CAk2CdBLA2uuSeEDYEoHjiYWs+aDUGrdt5WL5lVUmwFrzA440z1EwQo2dSvU/2UY6jYYLDOmAvGz2mzR3BJWC0TIeYghy6ZckKUmEYY3NyiayIv0/Qvuf6/Kes9EATkOlAMxwYbqrt7pUu09Mm3qPUSRvVTOt6lOf8FQ70mHEdygOPAzHhvHHiHaqZtslS2o/UsH+NjZUkeYyXoD5shqkYb4ZLz6HsFhf/1lJXv8kYbeCWwZu2hdx7ppBge2Jy3X7bS5ngVpEbTnFjk0KxIPi7wsyw/q9/XuFh1foZiux7rmXq7oOb+b8BnotnCdTOek/OTF+J/+48LBUS6fzyUXml0PSFEpKgGOTrxta3254AfSsTGJBlgjc9mT2nblhhArd6x5bxbr4vJXIxecnRHvg1umPZ9u0Vbfg==;5:HQB+XewNaBzhTyOTqmQZObWh1f0Rscn6TxuBh6UG+lsqzWS1YxOuBoVCQM23a5eCzfD86PFEeMBd/vsLf250HdFFwQ94sDfMWao2M3NgnPFOHIO4KXO0wACFsxCpwRK1s6ZQfnD9hUrJlyNcrL+dMYfcVz8PHXYenUy53RSzJ14=;7:NCOqXuh2T4YrBZxqZlVxX8nU1lSR+mZKWHt8maRnmZjycF6iA3cYj1HwM8Q/BztHFen8ADY/BrDgKX2CgEBSrdWncgAdcTGR19r8/7PSZ0QQQnWWOkWy9kA4FZRfkAbHXah6rVfXKisfo8LjNvs6c1s8eZMX5HR+SlPLGziHPZJVkQuavxPrWbiq8fRl0YI/kp8UE29UyLcMSfBSV6nJX7+fHAruhLvUSa4OFZ8vgaKZjtsrBGzlwLF74hz52oa9
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2018 07:12:48.9860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15777732-ab34-4f78-77a1-08d5f2c732a9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0301MB1576
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using DMA, if the DMA addr spans 128MB boundary, we have to split
the DMA transfer into two so that each one doesn't exceed the boundary.

patch1 adds adma_table_num to struct sdhci_host so that driver can
control the ADMA table number.
patch2 introduces adma_write_desc() hook to struct sdhci_ops so that
driver can override it.
patch3 finally solves the 128MB boundary limitation.

since v1:
  - fix BOUNDARY_OK macro if addr+len is aligned to 128MB
  - use DIV_ROUND_UP to cal extra desc num
  - fix !len for dwcmshc_adma_write_desc()

Jisheng Zhang (3):
  mmc: sdhci: add adma_table_num member to struct sdhci_host
  mmc: sdhci: introduce adma_write_desc() hook to struct sdhci_ops
  mmc: sdhci-of-dwcmshc: solve 128MB DMA boundary limitation

 drivers/mmc/host/sdhci-of-dwcmshc.c | 42 +++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c            | 48 +++++++++++++++++++----------
 drivers/mmc/host/sdhci.h            |  8 +++++
 3 files changed, 82 insertions(+), 16 deletions(-)

-- 
2.18.0

