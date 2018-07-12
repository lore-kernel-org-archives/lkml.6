Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F80C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AFC20883
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="Cg9aJbys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8AFC20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732437AbeGLIxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:53:52 -0400
Received: from mail-eopbgr00123.outbound.protection.outlook.com ([40.107.0.123]:56530
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbeGLIxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9TTyTBkxohpJpku1rYg97bQm5Z08Aslibl+Of9T3iA=;
 b=Cg9aJbysJxBemqtue61Z39b3VLaSpNZ6uq5asbLIHRxRyd3obi9CQAmFc6tYHkoUsezEFL8JaaN3R5SBXfFVUXXNUqyoiSnWPqn4rPLE54qCWIsteqIXhojghPgL+nuknm+xP3LpBQJP60bH6Lvm5sL/J3c/ZJEI7ZanuO0HEhI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 VI1PR0201MB2464.eurprd02.prod.outlook.com (2603:10a6:800:55::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Thu, 12 Jul
 2018 08:45:03 +0000
Subject: Re: [PATCH v4 01/10] i3c: Add core I3C infrastructure
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>, linux-gpio@vger.kernel.org
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
 <20180330074751.25987-2-boris.brezillon@bootlin.com>
 <CAK8P3a1aZXf2sQW2mgwJScycKPhdoOAwxRjm5cQG83513uc3fg@mail.gmail.com>
 <20180711164120.3e32fb08@bbrezillon>
 <CAK8P3a2EZB_tMS_47wv6M2Qpm79ZocxxhG5zLxXsBM_YjZgkyA@mail.gmail.com>
 <20180711191212.3855bb25@bbrezillon>
 <a31dc625-56bf-7a59-d9a3-2841360b864e@axentia.se>
 <CAK8P3a2oMDw2zHzE5vFFHDqzKVKEzOga6v0ExdYVawnMtcdbrQ@mail.gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <bd07430a-8ec6-e2b5-64fd-c4361fe5760f@axentia.se>
Date:   Thu, 12 Jul 2018 10:44:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2oMDw2zHzE5vFFHDqzKVKEzOga6v0ExdYVawnMtcdbrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR02CA0096.eurprd02.prod.outlook.com
 (2603:10a6:7:29::25) To VI1PR0201MB2464.eurprd02.prod.outlook.com
 (2603:10a6:800:55::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb077ece-9b3f-48c2-663b-08d5e7d3c41e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;3:3+m9jvrZEl2nu8BA0EeAmmiLkC06tKVqrfKglKT+tvpENSWZSoBchBPOYayIWgeFFNUgbuhpy+ELnXZot3bfUUDkIa/vg5uTJ7Gv+kXv9vgaPVFrToxei3VvjO6M8IavvyaW01hUyEjrwQTivdrAiQCmQYvF+R7a14NWWp+QMyOUsH4EoU666F5ufnJ9pHMrZbl8G9+FQFd5I9ppW4zd182A9j6+dVkv3SxBRpfSbaPnAXQaVEnYli/UMSLS3ViF;25:mTBSU8OzglAtxsG5550c4GhX0ZEOPjU4CxZ3u0ecBa+xdv6c5eGaerlD+LGAU2XgFJp4jWpiJEFgaVVhcMcms+cbqQUzJyIItHtGaDACYEwvAut6hQj75Ht58SnBuWuHm9IQS/JZvQvhK+irTxPp4/sVWY+UBWY97iuvFVMijOyA/Hxcr1w4CO5zAY2BgVk4ZcZ79gDnNJ8kpq56tTKujimqxpQC0Chfm5Eap7aHv7qa6f26BHqQQ7E9RNuOVs8a/hbl/+dSsL53UcLlUH1BoOnxA/k1KHPF45UkPNQsMlll02KhgoRmEpF1oOTwfOsu6GB9BDDSKsZpoNqpqIpZbA==;31:F9fCZP8HGfb4b25tDwmiXvaT2QbOStUeqm9Kj6rAn/XF9F//hOJyTSg/PfN/64obWyVLDhRoaEWKrMrrdrA6sz3beYARG68fiQqj6wiR+9krRSiyLXWXwThawCJhAjaY2/O6pI6dSTS3MxhWD0b0dfLgRu19VuBnWo+rQ6N/nlE+gnyXiNYvyLBDR5DALBA86mtR7MwmOlTdkwRAYaZQniTHxTTBgtrayb7soYwNXsg=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2464:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB2464B48C93A6A1A7A82CE885BC590@VI1PR0201MB2464.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0201MB2464;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;4:rdxKprIUmuiopG3T2XIiEOHh/dOShCJFgfs6SJdupSlaQnvQcgjQTWZFY4rCIp+shHDNmljEozgtmRsbDBWknDbzzyaFjjPv5tQJOKWy3QRueYNCsKLJo9CY5PolMy6nIBRqaq5kRrFzyfwtKUMMIzhH7Aa/TVqVij444w+tylV1hMd2yIcUcw+gw+faz9Dedm19cWft7sp5Vqa4rhEOGpUGFCBvVcxd2+51YOr1Vg+GMyNxdc5SwHFRSBFZ887ACgeEEaqTIX1h6rqdeNYTYw==
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(136003)(366004)(39830400003)(376002)(346002)(199004)(189003)(6486002)(65956001)(66066001)(65806001)(47776003)(36756003)(230700001)(3846002)(229853002)(6116002)(97736004)(7736002)(31696002)(86362001)(105586002)(106356001)(305945005)(31686004)(8676002)(81156014)(81166006)(2906002)(8936002)(93886005)(50466002)(386003)(53546011)(68736007)(53936002)(6246003)(54906003)(4326008)(316002)(64126003)(74482002)(58126008)(117156002)(25786009)(3260700006)(16576012)(2486003)(52116002)(6916009)(6666003)(36916002)(23676004)(52146003)(2616005)(5660300001)(7406005)(7416002)(11346002)(476003)(956004)(26005)(16526019)(478600001)(76176011)(486006)(65826007)(446003)(186003)(77096007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2464;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDFNQjI0NjQ7MjM6OEpId2NNUGRCRmNvblppRm9nZWtBT2w0?=
 =?utf-8?B?M1lIdEpwcDlucjNFdWVQQm5SaGVEd2REdzE0bWNqVGpaRFdvUkJ2WFNjMUl1?=
 =?utf-8?B?aEJFdjlzMkdITWdmREliQytnL0tSdlkvNWR5T2p1alFXOVl1SWcyM0pMOGMy?=
 =?utf-8?B?UkZJRnBhZVNBT3VQcU55by9IN044Uk1wZEFkY0lhR01GbjF6Tys5VHhTZzZk?=
 =?utf-8?B?RDh1VVQ3OWxidld1cXd0N0NBaWJVMGVjVFpNQk44Z0NPVjVSVitMZnYwVHli?=
 =?utf-8?B?aEFpSVdaaWhJYmxFYnR2RGY5L1B2ZDcrYVp0L0ZzWWdJMHNQSnFWQVBhOTB0?=
 =?utf-8?B?eng0bHV1OHlYZENtbk5XNzRDblB6ajBCcnRUeDh4aHFKaGxRbS9QYy8raWo2?=
 =?utf-8?B?M1F4WnMwdndXYkFGbmttTUhPQmdkYXArUjJVbkV4aG5lUGZyZzJUdTM2Zm5y?=
 =?utf-8?B?eDNOcGlSY05FeHhiRUFEQkdyejk0amUyWG1Wczc3N2pNTHpxNk9KbmUra1ZI?=
 =?utf-8?B?V3VxRW41cjkrVTFYQkNVUnNyaXNjb3dqcE5YMUN5LzcvWXdmc3FTU3pzbkxP?=
 =?utf-8?B?cHpsTlNCdEw3Y0xMQmp1TSs1ekE4YjlQMlhTWGcyOHg5QWhSem9JRUU3cXNB?=
 =?utf-8?B?dFMvSlBqTXF4cEFxbXBpTmx0aFRPdWVEYVpEWG0zR1ZBS1BUbDNFTFdYdVNX?=
 =?utf-8?B?eC9PMk9RZXN0QXVudkpoaERnWWJ1SWp2cjlialVnSVZNWDE0d0ROV2VCUE05?=
 =?utf-8?B?elc0Yk1YSjVtMzVmWDZUR0RFb2t4bHl2b2l3T2NDTjI4Q0o3Y1F6Q0Qrc0Nm?=
 =?utf-8?B?M1RWazAzbFAwdTRha3Rjei82akFSeFEzZFV5RVRsUGRpR1JKK0t4dEl4NEtv?=
 =?utf-8?B?TW5aSGRsd1ErRWRNRmJ5V0k4L2dNaFhXaldIeUVtc2ZLbmNpRS8xQzFsVWkv?=
 =?utf-8?B?R2NienY3M1ZnMVdaRFdIQVorSmxsN1I2TE5FSTU1aVdiTGk1TVlPWnhSNEhI?=
 =?utf-8?B?WXF2K1RYWkZmQ05RT0hoSDZ6Y1JiKzBlTTdBeHNFWTBFUHFoQkNTT3dUQ241?=
 =?utf-8?B?VW5BYmttYlpMaG9DbXZjMXVMUHZoZTJFOXNVQlMwc1VqbEZUeUt3SVVoaEp1?=
 =?utf-8?B?NzZVeGFNMEFwY0tkVExrRDBrS29WSno5MEVXamdnMVBNZGQwZkNlaDFnb2Vl?=
 =?utf-8?B?ekd6SFRCeC9KWlRpWEpNc0VIUDVaaE5mOGMvQlRwOHRWMm0rZ09MK1YrUnAx?=
 =?utf-8?B?K1A2UUxIUlAybXlhWHRhaW12TlY0YU9WMVF5bUJybjE3V3lCd3ZHOHRrbC9V?=
 =?utf-8?B?RFB2Zm15Q2t1b29laE9VU3Y2eWFZRWtyNzloVUtsWStnd3U1cmdPeG1RWmYv?=
 =?utf-8?B?YTkvdDlQR2I0NWJlblJhcVV3b3Jqc041OUR0UzQ0VVFVdzZueElvbzIxVitx?=
 =?utf-8?B?cUVCRlk3WWNMdWRsWFlsOW4rTzhwNGFyTFNya1RKSFRLN3ljc1lTYTdiaTI1?=
 =?utf-8?B?YTNSMTBKT0hNQTBFZXpTbFUxMjQ2cHBlZ0ROZWs3MDAvUTBpS1BIeUJXUDVH?=
 =?utf-8?B?VG96aTFONG9DTE1YWWpBZjB1K29CM25UUjdZUHgvWnAzU0JEUkk0cHZ3ZDdK?=
 =?utf-8?B?MUtPak1hMTJUMi9IWUNyRHkzUzRBemFWVy9ZTTlGblJ6eldCNjY1RUhRM0Zw?=
 =?utf-8?B?eVg3Sm43Y3FKR0lReWtBMFZSendXS2ladTBERjI5NzNoeGl3WGQ1MUhaSDY4?=
 =?utf-8?B?UmtVdDZ6M0VLVXNMdmlWRkVBNUlodE5wdmtWVU5Tc2lRWUR5MkF4eFNxS0Vy?=
 =?utf-8?B?WWJ2Mm1NZkZKNWIyTTUwVDgzRlBQK0pYbjNuMG9SODdxeGdjZlIzcDdPSXE0?=
 =?utf-8?B?MXdrNzB2SjlKeCtVZmNoSVhPcHAya0UrbWhsTGtQZFVSVmZjM3NQd0pZUk5L?=
 =?utf-8?B?SGVrcUlnODBnM1NoaXZaQW1Zc0lIbkg2eFNQY0RjSnhRbUxzL00yclB1NkVO?=
 =?utf-8?B?OCtQdFF0NEExL2tNdHBZTUlNUGVaKy9MYWhsUk5CMUFtdVRVMThsS3lJdWdC?=
 =?utf-8?B?T0hkMGJOMTJaL0p0WGpCc3E0NnF2RUhzSjhPMzU5Rnp1QzNNQW94YzFsMkxX?=
 =?utf-8?Q?WhjV87JfH6JaBgyQUur52E0lfg8GHJZa5nhjf/URnnR0NH?=
X-Microsoft-Antispam-Message-Info: 8cGUalrYyDF4tay0faEvTc6ZZVOJR9ogVG6bGB59M0mMfHgXIjuzJtmFu44aGOuyu+GKoRnevZq068EnGsLaRJW3O2K2jLDbX8U3MFssmAH7C+Q6KCDiKUlWfIfQ/rXWvjYp4Y9uPGlp9FfQ7IY/2rWR/QHI93m5svVQSg8C2rF/hEnMuJGxeNzJn4ZfAtea9jdy2XL+gfC3z3g88p+XdZ/z8hSoT+7rOyEZct9pbxxQK38M4uS7yMfkUcd/Cdg+jleik9hknYG6zs27BM5zUToHnku1Ey9YaI/eoXCFCbi7F6CKHGwgOSAOuANNkTm/81RFsIcG0GGmtNaj0qaD7vhFUomWD46Nz4HzyWk3Tk4=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;6:qVLoC3D1xDf+H4TtjgUUH39vSCa8R92xKsFDQCz0+IhtKD7Q3SQ9UVA4mHrfR8bxOx/wvpN081to0A/3R1RB0zDMPzzi9iiayGmdGSddmOwdy4CnPGKqy6eTN+MLqIlyf3HVParvogEjf3npXgz55+2wHm03f46azyGwll4X7JDOtNy4CgRyg/Zb8F/dzzzAw1VsJK54smgY8ZqAHQ3pQgQr0mblL4S7fD+RCX3UX2ndVFByY0yfbwq3QnpeZVnf1QqzDBk3UeFeY7EBADjv3tr5oHM7lBJyEj0ZkXmMAQgOWpOupjLIz38shzTcEkJkOid2+UIfSV611sw3/lYWaK/QSWOwCbukanlL97VCLrDYAmsksDzOrq36y5l1rDPliiqDaZNawVu1E93bKGB7Mg8jVQ+TAhshXTIdM64iV2SiopMFrIERhMQ6fIiUT8KlyjufUAyImnriYYN99KHPbQ==;5:Jn+syLSD3FUehwnVqqfj2nowdvk/owjxKttk8pwVquUlWEk+6KJpX6/q3fLIXKW5pGgknQlh2qSkctJL+jEvtVn2iUfUipjFzY0nvpo3eb3zvWp0G1N+ocLvasfc+bWWvzKUaXhnnFvMxFgEDotVmn3FUZYqdGH2hlv45hxaK7I=;24:AolY3b4z5YvFsbHl5Tdwg7OWbqQ6fERixW0sN6nVN7gPm502w0IGb2NmL1ZxwlyhRlt/4+qgdEMZ8gJk68z+PeR/aRen6OyZZr4P9RWdBEs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;7:Z2P+cMJb4oTQP8yL99SAI5Rkt2pMOKbdCwrfySInjMj7VnL75bWXs9o5ne5fp5HVc2cXKVyDhG1HZapS0PxIjqz6luukCBkj1WtLGZY7nrX56t6LWXF3Ja6oDEWXOeRRiQ44f0bWjoL74h/d7TCAhEC3lMXHoJC6e5znOgf5qDqkZpI4lBmjwC7E+fSl4hhrGe2Z9qQLgKBe9t/yFxCUh5z4Q6SjPs36mVyNCn9YVJV6O1Tw2dzDPe/4+RgIaOPT
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 08:45:03.6922 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb077ece-9b3f-48c2-663b-08d5e7d3c41e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-12 10:08, Arnd Bergmann wrote:
> On Thu, Jul 12, 2018 at 6:41 AM, Peter Rosin <peda@axentia.se> wrote:
>> On 2018-07-11 19:12, Boris Brezillon wrote:
>>> On Wed, 11 Jul 2018 17:39:56 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>>>
>>> That's exactly the sort of discussion I wanted to trigger. Maybe we
>>> shouldn't care and expose this use case as if it was X different I3C
>>> buses (with all devices present on the bus being exposed X times to the
>>> system).
>>
>> For I2C, this multiple masters for one bus case was retrofitted in
>> the i2c-demux-pinctrl driver. It's a huge kludge with a number of
>> undesirable quirks. I don't know if the circumstances for adding
>> this I2C driver also applies for I3C, but it might be an argument
>> in favor of the proposed extra bus object...
> 
> From reading the documentation and git history on that driver,
> it seems to be used only for static configuration, i.e. you use
> one driver or the other, but don't flip between them at runtime,
> right?

There is a sysfs file that can be used to change master at runtime
(current_master). This causes all client drivers to be reprobed,
which may not be the best thing to do for every client out there...

> I'm guessing that even with i3c we may have to support something
> like that, as a likely scenario might be that the i3c controller is
> multiplexed with a traditional i2c controller and/or gpios, but you
> would not be able to perform the i3c standard secondary master
> transition with the latter two because they are (by definition) not
> i3c compatible.

i2c-demux-pinctrl should probably not be used as template for something
else, but it is a good argument for some other design IMHO...

Cheers,
Peter
