Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794FEC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18AEF20684
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="ckU59wm3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18AEF20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=prevas.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbeH2NwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 09:52:13 -0400
Received: from mail-eopbgr10109.outbound.protection.outlook.com ([40.107.1.109]:53824
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727172AbeH2NwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 09:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1O8pxm5ZXxArnYeeOLn/s2A3/XNzbIU79RXBtz+N+g=;
 b=ckU59wm3ykiN+WiqCDo+xqqcp+if0P20aBWFJf2BLnKiJkeEhZ80XkBHlBd1W/O7iluXjxQiP+UweM2TptzTjZd7ZGRbs21ISDYj0OTQ8VQeWn9TDoa0l2xetDj+C4sbLRmoFPHpJ+0qaYlwGlt6M1mwglyMXi+gAwt4qlFwaC4=
Received: from [172.16.11.40] (81.216.59.226) by
 DB6PR1001MB1334.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:b4::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.14; Wed, 29 Aug 2018 09:55:18 +0000
To:     stable@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <Sean.Nyekjaer@prevas.dk>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: reboot on wandboard fails with v4.14.67 (bisected to 2059e527a6)
Message-ID: <b2ea002f-4fe8-0738-b346-69ed138cecd0@prevas.dk>
Date:   Wed, 29 Aug 2018 11:55:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [81.216.59.226]
X-ClientProxiedBy: AM4PR0701CA0039.eurprd07.prod.outlook.com
 (2603:10a6:200:42::49) To DB6PR1001MB1334.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:4:b4::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcc01db5-c5e8-4828-d3aa-08d60d958788
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR1001MB1334;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR1001MB1334;3:R7H6CiQmRNAzN3gzrAzlNdjzBKVJUXWcVgfcvfNK+wuhIWXot0yrnNTHa36VCgB/dRuQdThpG+H6IUZ+VXia7gW3m5iPuRSOB0xCfkGSNGqpjSqHIrqrdquVouWXbOb+/2uVZZNJEwLT4IU/ngKYLSJzO9guWJL2jUv2sn5yYY0h1FwXp+C4DjyHNNxMcMa2Rii0PseKClBz+X9974eAA2MsTztjUMyabMSZxNCCatK+qjdV3++C62kZumBz7zvD;25:baIz+Rb9VTHQnrsuv2SVr9eKrHN8AJomeRylN0jJYIqtpeEDUzKMOIpvkn6QuAJPS6FL70pyRiIZG3PeGxrRBHuarHPGy1OGZxPoF1RpAWU0ctVu1ud60l57Ml29BgbtqrLE4YVBW/Bd1W3DPuW8FJPuINwfZO0SuDTh6mUrRXfCYHoAh5bdpvC8HizGqJbg5FX5G+LCyqu+jpLsYi/RVP8+8hn3SgGKbXlDEYOAX8XxfFXZ8NT1h1bBVaV72VSWo9A1DJhs/mveEQBRAy6jYlNoOmkz4CTOLH1xOL+TYlh7okKDkxCo+DwvCI4Lhd/jvcQWgrdGAPUR90Z+GeunWg==;31:wk6Pk7MjF3rD614uOd43fISVctISR5jnMUJErTFoYsCfTzCTk4tc3wCrfz63N+welAO35Pry4PxmqQvp7C//CS8MEC+5YWeseP+tG+/o5IGPpgP32i614TfUeUXEnnisIxuzBt556Mp3ECM32012DiYW/pTXi/T1KWE+VpjnLDPVGOjzdlA+yt0CLk35mzajZ3BZBXS/Q5byvKPpaEvvciD10S75zLsLapDwPkngRoQ=
X-MS-TrafficTypeDiagnostic: DB6PR1001MB1334:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
X-Microsoft-Antispam-PRVS: <DB6PR1001MB1334DD305707F5AE4029F3748A090@DB6PR1001MB1334.EURPRD10.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(93006095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DB6PR1001MB1334;BCL:0;PCL:0;RULEID:;SRVR:DB6PR1001MB1334;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR1001MB1334;4:W1xaffJHOO3Eu1yv6lu7p4Z9R3mpIVSyywBmr3c+FDEUcIw38Snzq+SdnWjeu5FCeYWZEBMWt2jPFPI2c6tHLs5CfDqSthpRkb7WzMp5uL/y7XenyMxbKJL2SXJlU7Japq8BFgDT1bnK7lVzZJY/ASanasMyAF9B7QYX4556SJw0N4zlyAyP03/j3aU+r+CVRwymQF+PBI8Z3niPVq7PHHFQqY5dOrWxR/hW+GlKP5S7ULDIo6oXtrQBvEdNPGbgAQmc8dA6FsBfS6XumN6YvA==
X-Forefront-PRVS: 077929D941
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(346002)(136003)(396003)(39850400004)(376002)(189003)(199004)(8676002)(72206003)(4326008)(26005)(8976002)(230700001)(53936002)(386003)(42882007)(478600001)(52116002)(8936002)(74482002)(2906002)(77096007)(316002)(2486003)(16526019)(23676004)(6116002)(3846002)(186003)(52146003)(14444005)(305945005)(31696002)(105586002)(36756003)(106356001)(25786009)(39060400002)(6486002)(7736002)(65956001)(47776003)(50466002)(66066001)(16576012)(81166006)(58126008)(81156014)(44832011)(64126003)(956004)(31686004)(476003)(5660300001)(97736004)(6916009)(65826007)(486006)(2616005)(65806001)(54906003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR1001MB1334;H:[172.16.11.40];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjEwMDFNQjEzMzQ7MjM6ZFBMYW0yWEtlTk1GY1BrVGFNZlJpK0hu?=
 =?utf-8?B?RTJMcXkrVjkrY1VwODhEdnFYaHRDeHVXVmZFUmdQUHZrMlIvbGJhQ01mbkhW?=
 =?utf-8?B?aEhGS201cmR5RDlqL3M3ZkxGbitLblJqQ1psaGwzZllWa0c0aWdnUUxHUC9X?=
 =?utf-8?B?NUdLcnNCTitJenNvbHArUjg3OWlCZ3VocG1xelR3YzJKSTE4SDZEa2F3aGRU?=
 =?utf-8?B?MEF3TktXcWJBZGRaRGJ1NjdraS8xOE5oR3pTREdxeFpJT0Y4bG5ZOGk3dTVU?=
 =?utf-8?B?dHBadUZ1S09ES2l6WWV4eTZIWGVVcExVbE8vRmNnRVFOTDRMbEpHTGlsREZT?=
 =?utf-8?B?U1U4SnUrSjkrZFBaU0xZUTR2dnJrRklpOVBJMjBaNXpsam8rNHNPckx6bnFW?=
 =?utf-8?B?bW0yR1FjOGxqcGpyMkV2Z3prYUk5QjdMeS9jRTlyM0pOMWhXblNham96MTAv?=
 =?utf-8?B?WnB4RENvUk9xQ3QvdktRSlhiRDFBUXh1ZmJlM0o2aERlTWM1cFZFSnNqUzI5?=
 =?utf-8?B?OTlqUGZnT0lsaUFTZE1IOTFrN1RWbnpUVC9vMlpJbDNLYm9iQVBFYnE3amhX?=
 =?utf-8?B?K3U4M293UFlINTJtMzV6MjZwczZ4Y0N5NDl5S1VwR3ZiOUd4TEVuTXBKSFZW?=
 =?utf-8?B?b3Mxd0ZMUi9Pako2K1lsQzdmelhYSU50aS9MeDNTbU9NR3ZBQWhSdmYrWmtj?=
 =?utf-8?B?TldGQmxId3lxRks5eXRkM1gvbVpLQ2YyMXZSUDJXdWI1UjlMbTBLUEk4S2sr?=
 =?utf-8?B?K1BnYjBCYzFGaWEwODVzQ3p1ajkwNmZaaCsrRE03RHNCUDVyRnc2T2ROZWlG?=
 =?utf-8?B?ZGFjaUJCeEFMU1pmajhjeVlmTUtOeFVGRmFEc0diSG12dCtMdUU1Tlpnenpz?=
 =?utf-8?B?MGV2bDJNRm9temxHQUJKMzJQcTVyZlB2SCtzdTZjTjNlRjJzOXh5SGM3dk52?=
 =?utf-8?B?NklBMkFJc3N4V0FuSGE0bWVGcnNlWk54SjcybGhzeGtIdkk5bE92anEvN0Ji?=
 =?utf-8?B?a1ZYdHcvM1JoY0xuV1gwajluZ0pBc0M5UDY2Y1hKbmdtSEZZai81YlJNNHUr?=
 =?utf-8?B?VzJ5YTlMeVRxNnJiYnNobDlIbmQ0SHdUdGlaWHdackViZGlUTWVhckhGS3Bu?=
 =?utf-8?B?OGY5K3lFWkhoZGNjc2V5NWwyL2pSQi95L3Q5eHptUVFhQTlXVUZPVWpYZE0w?=
 =?utf-8?B?TWFTRWhOeFZ4bHluQ1lNTWhJdTI0R2JtQnZuMEY1WjJsMFhrbUhLcjNnR201?=
 =?utf-8?B?R2hBTEVoNHhWVStDNHUrRHMwU0Fna084ZnFWTm5IMHRZRVYxZWNpdHQ5SkVk?=
 =?utf-8?B?bERFdnBoUUVCc2FrYkV1dk9Ha2pyK1B5ZGs2RXVaMkZWUXZXMXdXVXQ2MzNN?=
 =?utf-8?B?YURRaXVpUlFVREtjZ3g5ZWpmVUIvNVZwWUF0QmwzcmpFemx5SWo4MjUvNUVn?=
 =?utf-8?B?dlQwc3JLaDYreGYrb09zL09QckxXNFRRR1ZVSnV2NUJaeEc1UXh5UnFkUHNL?=
 =?utf-8?B?eXNFVU9KVzk0WWFtQStoTS81L3NKRmNLeW5IVWQ5WVRteUlramhDbGxDS1Nt?=
 =?utf-8?B?bkxDQXM4QzVJUGxaN0JrTTY3a2hOa2JuRFdNVER4Nm52b0o2TXBCUHJKMlRN?=
 =?utf-8?B?b1ByVmI1aGZ5MGdBUXlMV0dJNDhrdk1rbGdKcUJMTVhmREo3dE0rME1XWmxL?=
 =?utf-8?B?bGJxUWgrak5VdWxFQmkvWUFnM043Zmp6dUhUbEdSUWFYUUU0T1k3RndtRTBL?=
 =?utf-8?B?TWpMUjE0NDVqVFZ3MHpRTWpEc05GVFl3cDBlc1daUHo1dmNLaCtDU2dLQURC?=
 =?utf-8?B?MUh6OFFjeTdpTG8wQ283eEdsakJhazNob3g2QTljanhDNXY5d3lMM3NDWllx?=
 =?utf-8?B?YjdaL0piNHF2bVV6RVhqaVpCRS9xd3NJUXlubE53THVUTFRHOTlUYldWSklV?=
 =?utf-8?B?T0xiQWllVU03aGc9PQ==?=
X-Microsoft-Antispam-Message-Info: nmlFTzyEgetFNkGR4kOFKORZhq0fl+jtJ+9xD/q9dy/MM/jddRF5CtC0/BljjjTXCT4W3Ps5NkINZ5pAZ2wMsDYIAtIxyiqGVT1Y3WvWS/JFeSfGckA887l4Y0KTiRlU24ZwZik+lkhu4+/UgbgRQnCjQp0OTcxicHi2+/xiaReMuGSn0WHtNeRBiUY69TB+18YUX8ZOXbasQmGVF5l6dZGHF7H2PYNRBbV5GX+Sc6Gm3I4k3M8ZA9qPzu8cEUMdzUxmSs0mliUGvdnXD2ayD5TQlGA3F1CDADJGd75A8Jcx9d3JncIrX31aENeRAj21Odao4Srtdq84qF/u0GpsUMjyCJ4Xk0hpg/7uLYFlLeU=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR1001MB1334;6:7fHobFPkSSPjQYetXIEIMeSSLmj4aYaPvnJDKFTot9ExJZ93cmvCc/+S6u47TL9HCD3wKr8E5fDGiyDdPC4lJddSatyPvEv+XAyFV9c5zSkAJQp7xoU3lkyhQkGIr0nXzK1X9BC29QcU/0y1atateGAsZo9OYKhQIUuyDpUkAubpPYCMVrylzzhH3/ib4TdpHB6h0p7cnWxnCcR7koFjENrHxQsH2j26w3p33fJIy6jKQ39DNwhW5GN8g74v7SsPuNyWKTXfbMeo5OZykR7ZFThqahi6VHmDhl9mzmN1sUEXZr1H9JG6xqoX1sLt1Yg4mpjsSiVh+rDQG40rooK8AWq75TKRPsNsXAuR4c7GPeEQZrfaca85n1nA7ZQ/2clUjeJJiJjWtzcSC0jTIzNdaAuUHg48EarNFBf0ExdZ/u1WQsMDIUB/hfvT5xHCV8OEKRv+bDEgZA0z2/RkW7hZrQ==;5:KPuuSrpD7DwwYtn8M6NDXcrTSabslG4aetbW0LW2XOUti1Q4AvIrdgLWzgBXzKaW4tcerht4YOpMYU4hmrBFNKa4KFow0Pz9FhSBqHU6m/CZS3QenG9hgM17mBtF0vIRRjFfmpNSuvf2VOSpVUh1Um/U2bslStPOEySxMk4mH1M=;7:vzj/nb0McGmheNrpKN5EiexpjA8bEbFNCKASMhQ/7RlWLz9lCQYh3TNj7+VIdegovvkNOU8ERyMQwmM/uN00BwmCssAJ4vQrha5LBRVw2jef/xCUFReRfaYLMn1GbStSDDcHz9XXF/RLfmvUTLA3PD84bJIWkgB9Sf9ndlbScoBjAqVHakN+CAJyi/vUmYQOPFczs9r84aOj195fG5NWzDK/zQ85Gt+bFSIWXBf1hztyXx2w2Eo/AZpNq+HM/K2u
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2018 09:55:18.8738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc01db5-c5e8-4828-d3aa-08d60d958788
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1334
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're using imx_v6_v7_defconfig on our Wandboards. After upgrading to
v4.14.67, reboot no longer works (or, well, takes a very long time when
the watchdog is configured).

v4.14.66 works fine, the breakage bisects to
2059e527a659cf16d6bb709f1c8509f7a7623fc4 (ARM: imx_v6_v7_defconfig:
Select ULPI support), and reverting that on top of v4.14.67 again works.

Rasmus
