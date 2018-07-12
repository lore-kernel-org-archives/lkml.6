Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174F9C476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D5C21471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="ppgZnJTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D5C21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732417AbeGLQLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:11:25 -0400
Received: from mail-eopbgr680097.outbound.protection.outlook.com ([40.107.68.97]:17680
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726725AbeGLQLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KUAIRDUmTJfNRb2wj50jKInWVSVxKlz7PjndAPZ/+o=;
 b=ppgZnJTCrY6LHvrhk+bWWmTd4nlgrQzYXjPHsoIKnNVSWkAuayN0c4m6CY/gpM+HfrV41eyHT5L1eLej5VXxMwFubQ94rlW/nYa7qbr3jMJJv9aZitrFR+v0VBIBa/Rr72oDZKRsvKC+UkoH+CEf3D4Lxy6miPeiGt2bfdHmxaI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 SN6PR08MB4941.namprd08.prod.outlook.com (2603:10b6:805:69::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Thu, 12 Jul 2018 16:01:12 +0000
Date:   Thu, 12 Jul 2018 09:01:10 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips/jazz: provide missing dma_mask/coherent_dma_mask
Message-ID: <20180712160110.yqbpoas32o7o5oct@pburton-laptop>
References: <20180712134255.30748-1-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712134255.30748-1-tbogendoerfer@suse.de>
User-Agent: NeoMutt/20180622
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: SN6PR0102CA0024.prod.exchangelabs.com (2603:10b6:805:1::37)
 To SN6PR08MB4941.namprd08.prod.outlook.com (2603:10b6:805:69::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86ecdec8-0510-4a7c-4ba0-08d5e810b0cb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4941;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;3:w9H7tEXt/ByN3AiifMqZp0PUWAkW4bffvDKFSHu6xYoVBbO7QZe4V2w2IWuCVqv9hLuInlMdCej4Y9FkwK9/wkfGfoj/s/IaNmpdusCgmQKEdpvtlA0020uqV4mGLMqKHJ1sWDLFdi74rujxLRjVvrinzvrPw2c0iBxQlBpH8zadfBYHkh3fzY1zdiqvC9WTW1UdJXchTd8QGzMbOxy3Wh9p0GkIFZvJVm2WbFeFAaUTp6LEzFTk+zbdKZI45dF+;25:VfKQE7QWdFjMBcgLXrfpvANS3+iEwV3aP5bACpwP9SXNO/NmEgdESVWc1HsTapALuTtRV+++bonYQzlio0OMTKVzSFrh6E8fFJ3G8UuA6N5pQ4Zxenjeh5JMxpLMBtsagHlT+bH9sdS1WynOT9MQdelghajqQHY4cdUWALsP/7xlSa5R+HmdkLk5kQGnv7PVQPf3jxW/SGW5+JyD3PI7kF/Vv3lO1Eq2+x347IxE5pH8gHOCEsATsQZtqcbFh4TAgj1kttMF7KksLBLUzFGeCvJwE/LHo8gQB2JLbMZEaxn+PAa6QI9R/ZLU1oHRNk+MxprRQ/e0AM0jr3ES3ATmDQ==;31:/BN3cLzOdGNUy+6RhS8us7zfAqgETG8e4foW9boyOhm10ejtjU7+BXJCVXnkI0F1E8DbT7QH3ptPTdWigaIPVgTnGryc11QQp4C6sZgDHQ9HrEGDI2uzUeuFO0Dms0PIfxOTe8GnJG1Xvgud67L7cZJ//eKJmG9tmpxyDFAwZ4bu7bgVFJoRvIC61s/XCkiotPsxGlzVrNgUGivEgoqG4z7WC4WAOZEq09BJ6pgrBVM=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4941:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;20:fxaXqffOyP976wZwLzjoW76iuEIIX2mbq1JMZXecw2gGDZiLENbH+9zGTOVht8++aZZpPupdM0JYqjtKP7SrawLqqFpXb3tc57R5BhsuIUYoRaEbzgOfiyIPQBulQcmtiJueSLHOxD/7GeKgupizjwrp4+aRzrO573xck6CdcLFbZwyH9wm9c6rRjvZ92ESyxH2/OcccPeIkY6d5vckNC4KfRqdRWBUwEp2BpPVYwx0XGKm17ZIiy0aE8W3H8wXx;4:XSdujSbchaJpJCbb5KMta3zDTbpYJVs7EIkt6lX8YQAhuBCyOpEa2ypS4+ZS9nWpkDxfJjVGih5VJX88vU1e/2P1O0AQmcjkmaGaUcMtfQslqiiBcZ1x7cNi5wWpGKSGxKjdDU+SuhmOLTXEkY2PjfRK4w9fUKOSEzaDLpUbr1f3Wp8CdhgbDlBt4TWvaiGxPcw/vxpfuzDgrYTwAMFjT3Iqd6OX6yhzQxaKpcYlNF5FiCSOOPugq8l2EwiI43gmTtVIZwdHpa4TTFrMRCv5MQ==
X-Microsoft-Antispam-PRVS: <SN6PR08MB494102B0909CB8A4581EC858C1590@SN6PR08MB4941.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(10201501046)(149027)(150027)(6041310)(20161123558120)(2016111802025)(20161123560045)(20161123562045)(20161123564045)(6072148)(6043046)(201708071742011)(7699016);SRVR:SN6PR08MB4941;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4941;
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(136003)(366004)(39840400004)(376002)(396003)(346002)(199004)(189003)(6916009)(186003)(16526019)(26005)(6496006)(9686003)(76176011)(33896004)(52116002)(5660300001)(16586007)(50466002)(58126008)(316002)(386003)(68736007)(33716001)(2906002)(76506005)(54906003)(6246003)(44832011)(305945005)(25786009)(97736004)(106356001)(105586002)(53936002)(23726003)(8936002)(8676002)(81156014)(81166006)(4326008)(11346002)(446003)(478600001)(956004)(1076002)(476003)(6116002)(3846002)(42882007)(229853002)(66066001)(47776003)(6486002)(486006)(14444005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4941;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4941;23:1iMU/nqOI48w6aLodPL8qZT2TDfLWXXNdio12B/t5?=
 =?us-ascii?Q?IalsZ9L139w8ZjjAu2PfHOVeq2lW1xDS8Yg4XhXre1mJ6jWIZcK/ZVx3jMGc?=
 =?us-ascii?Q?c8Eh0QDg6KWe1B5DyctH/Ek4bGiBALXoZXpAsYYssKEyviliOLvHB44yowpa?=
 =?us-ascii?Q?eJLF9l0Dh5QOWByOm22xJ3JUlDqFhFl9HDcw7+G8gm2CN47I8mQJZxtXufw4?=
 =?us-ascii?Q?paWYW98slm7f+XbTMv+tZ9ggaOTTFTwZXrqRWRYjCBKimus2ip/+jkR6gU5D?=
 =?us-ascii?Q?nWmtrY7mVoRzKWawyVycfz6qoDQ5F40Hn2GskxuSjmUmVqEZDl2gOnBelI+Y?=
 =?us-ascii?Q?WNE9LUc5A0fpOplVR0XSTP2Dxt9rYE7TucxUfLwK+wG4Kl5bXLsONyXWgze+?=
 =?us-ascii?Q?e6OZ99Qv+kqJDF5sIkRYZ/7n/bhTT/RZPcor47DTNgruD/qXlrPKiol0slHm?=
 =?us-ascii?Q?uV7+K0f/EZq4j32leErH2f+FkP06jdQ7XD0+i0NW9uVqp/fNmqjRsLJu434J?=
 =?us-ascii?Q?3AwBbW9Ve5xXyOzJUHNBNP/pjQh4RcS8EzvpMnqw6PVeeX4RiwWC2/aABCwa?=
 =?us-ascii?Q?kwJQtQ1rNe8cB/wU2kCXvAupke2SV5KrCP+l2lsy+WdXXKVW6UPzxXDXN9QY?=
 =?us-ascii?Q?oGYE+vrswLDMga8h4vmtV+GzSMMqaiWW6ZjKw4SWNL051tU3Mbr5OzrHvEmF?=
 =?us-ascii?Q?qql0bvAoEeYZ1xCRS8At+O/9jrVQ5GioqMyFyczvwOjYJUYVef+SM9Rd3Ush?=
 =?us-ascii?Q?qmW2idyoTVxh7xvjVumoQ9su5iG4UohZUY+4ZjDaz9Q+/i5IanUGIhyIG+xq?=
 =?us-ascii?Q?8wPdbBGMYGt+AiUxkteR2nFg1sbalix7ODCaXw3cDbiASlwqpZT0HB55w9+k?=
 =?us-ascii?Q?EuOgqGmzGBeAHiDHep5YR+WDTNfDm9Uwa1/AG/yqf3uOivUUlT/Jqine3qcW?=
 =?us-ascii?Q?F0bBFx2EjGQFu9PS968V8MfaQtMMDiENbPfmMP/ncNX9jMMLcuD1Y9S+6LX6?=
 =?us-ascii?Q?fZQZ+L1Dw7X36QGqhSDPPgdXm6DrAcd6YJ44s+KimKwEaN0d7vRnV42h90aS?=
 =?us-ascii?Q?mfeV83m3jJO/FyAp4NAgW13gDfamFuFCV5hO/B9tD6hnRImBJT0rHGj5LplT?=
 =?us-ascii?Q?1ewym3pI8qF6BNmTRHtdqAJCG7o7gpI3+hj+sP3xkk6WtCs8nb0z/TTO3QSI?=
 =?us-ascii?Q?eTjBYILib9p6MHK39uubqBe37qtW2EyrDQNaqQBPvhfj8+5qTW5JuHE1/jhx?=
 =?us-ascii?Q?1iD9cptJUidxwN4y62QcjHvHy/7KHwPefwBAXWkImSMF2x3kcIC3hGxgjZvY?=
 =?us-ascii?Q?Gb0XUMZr37OjumhJfqiVuI=3D?=
X-Microsoft-Antispam-Message-Info: RzJ7B2gC42DThJK+fnGK1f7p20LGeTvyPS52gyrITzvAlvBNpX/apZT6ABoNT+JBs4azRIaLywyhJvkzVH7alXbfKzdy8x+7RWpa6gFCErVaagEF4C76NKH/ukMZCTfXMGLwY3y+UCZUf3Si1l90lvMC11TuJmsHXhMnXodYv3MhgMces4rNx1TkYTbusbGuL4j+hGD0z4zeXW3WM5mQ2h3+F0mB2jPzumTfVXo5dYV0mzsgVT0lnhpkruoxFLrFge4wIqpffNitTPZaYK/VJh/rnHq74TsDsnQmm+AT7U6oIMXgTgw3H7HCLd/92UNYAl/KiM8eMBZh0pZGmNcVk2btBZmtmmUFME5QjBsYY+k=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;6:x4fkwDEzj6+OpPzR83XirDryX/vMoIvCaSa1YqlJe/CHDlEj5W8RwF4rHdmcPeOqmoSRmJAwHKFSRbtoX5IyqLxFqK+Hv1T3wFsFCwhusfuMpkwUMrDEN+YeXSLsq5zcpHq5Yh6eJ8JnJ6b+m0gdFGF0JVj77srVPrflqU4pTJJ5AyBHoDakJYbbjTBCJLPT96vB9KRmYdxLrjQzTTFp8cMTBYdk9QKMEDwCV39amsfak61AFGkIt8Zr0Cnb0m+CqXZRj9t2c4ACzMZkTyMV5B/ks+6TePkqLQd5BaAg5AIT9F9MtoZ6wyIcCDGdPQc/n7m6A6CrAxDza+2VlsmxExbhQiGZIoLgt6MmYUNsh8cT4ysWL5n4Q5SlPv0Od5kXmz4uEf+0G3rWExoXyhZ6IITBs92euu2dRK3p8HMB4KJO5WC68ZDgxexCPYEo0SX4TMvKoDI68xnUmwdQhku/MQ==;5:TZE3ikK73p7KNfTd5ljJqRBVqbSdyTff0xOR7kQk0AfCP9JZJh6PGATJUbhgQeoZvqKrqtsb5ylu2DTndHuc2SiMnBiD7xX9O8dcW3so3lhA3DNUM1jhMjnSTJQlv7iCHkskvysikV3AG6qx1aY1T4UG01DTuNHwG/axXoJvQOY=;24:LcanPFRmbNFyotfywVRX+KAmjnwfB4LxVbWMeswEZDxg8iKXdGA9eNPVNyJWDbPJS1ip9XfPRrbY/O7thxOSv/oEuDB5CleKzJhW0nqm2cE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;7:34OEMEkvsLpYon7IiWHfY5NV5Zf4A+ToxDK3c+ppHyt0cjaXZpu8LtCJYysgiqbl74Uh4C6O89GonnPr/9Z6h5GcKbGVcdA4yVa3UrFvZ9QRfe3PYip2OsLeXIWCOy5zVSb5d87NJ1nl0OQOcRrBZvOiSK0ojGx/ivcUu5s2QTbh7iWN8YlgzISIKTLOeiFN1+FVZLfkt63tBcYfrCHtSHeXDEwjpA//kcJXuYapdPulNvS4OBazttcAyG/cAtxQ
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 16:01:12.4365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ecdec8-0510-4a7c-4ba0-08d5e810b0cb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4941
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Thu, Jul 12, 2018 at 03:42:55PM +0200, Thomas Bogendoerfer wrote:
> Commit 205e1b7f51e4 ("dma-mapping: warn when there is no coherent_dma_mask")
> introduced a warning, if a device is missing a coherent_dma_mask.
> ESP and sonic are using dma mapping functions, so they need dma masks.
> 
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  arch/mips/jazz/setup.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

Applied to mips-next for 4.19, thanks!

Paul
