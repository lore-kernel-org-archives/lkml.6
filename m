Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C727DECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753FA20856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="QcpeHb4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753FA20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388137AbeGWSkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:40:12 -0400
Received: from mail-eopbgr690139.outbound.protection.outlook.com ([40.107.69.139]:22560
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387995AbeGWSkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfFuWeiWHmMWgqwIs0KozekcH/fD4kuIHWSPjQKvAvk=;
 b=QcpeHb4DAkFZi8lanoYp+FUypjPpxde14L7de8LRSm4pqAgNxQfP0Ui1+JHwMZJ3M66koFiS1oh+Btl1cz1mSTT2EhRm4P7D7mryK0tpucQaabPxPj+tD/HAYuq2HUVjLkIpydPWXmBpW77Ocp2/BWcdLAGxz0tcDMTEQ55euKE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4934.namprd08.prod.outlook.com (2603:10b6:a03:6a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Mon, 23 Jul 2018 17:37:50 +0000
Date:   Mon, 23 Jul 2018 10:37:47 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        wuzhangjin <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Change definition of cpu_relax() for Loongson-3
Message-ID: <20180723173747.kdeoyhie7jur25zm@pburton-laptop>
References: <1531467477-9952-1-git-send-email-chenhc@lemote.com>
 <20180717175232.ea7pi2bqswnzmznc@pburton-laptop>
 <CAAhV-H5_==ZdKTOJTNXkRBTqmr5cxFvcaVabfNarEiQt_LvHZQ@mail.gmail.com>
 <20180719211547.7hlkkljnmtbdubot@pburton-laptop>
 <tencent_49EB501232FD02AC001F9E93@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_49EB501232FD02AC001F9E93@qq.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR2001CA0009.namprd20.prod.outlook.com
 (2603:10b6:4:16::19) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6e063a0-083d-4c1f-b0ba-08d5f0c3033f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600073)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4934;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;3:INCq1CkPE3mflQGhMagAevfu/DIh68A4LAaZ1SEAZzsHFQ/NmuDfrgYmL3NQtw+RrM8D3Ycw8YOxPizmBfJJUyr7JVGPvMJ5MRwpaUa1J/L3mAyTETH9raZQy0Fj/Hykf+hwnN2zQdXi93NaO83pvRWjjXNenPIlN2NWcL2KOhstfVMZWPDaddz+YuvWI2i1pQsQXe6+gsVMHR52O56nA/LXyhKIrLrPXn4TuypRv8nihHQIP5L79pD/DjZSe0Bf;25:BoDC3BGDkjcZVaPQrwAurbog5OhrjSfv2CZqo7WqHjJihpcJWS77QA+gpjW8z4igJIYK1R5hMe3pPQkuzKpxaupkFji1NB4hJy+o1DiH4eTbZ/5zbs3tFkgW74t3+KK6ooGpVlB7I/NNUO/8VWwL1jFEGSA0lHqmlUecAsxPlvrlMG4FZ3isjnHRx3R+e87d3W/q8EUX0wviKB7turahvYgrtle87p/J5tCfoFypsIO3q3S6j4rId863K6aJgyjyEcjNtpqeXizWMV6+GMuRXaklq3h25QzlkMaIAroQm9PFObH+lGRVai/EO8+JArx0Q/ubZykhaYupZupq5+2Pdg==;31:9B77YHD+5vOyIIQ8Tvcjl7FEtxHvI0WkddvwX4JfvTDjNhw/0WH5naL+XU9S40CaeNFEBT3Jzr0WZm80X1mdWBWOBom3yasJ8jXbQ1O6AANeE7P/+jnMmfi0j+pB4VyxVeTHek7F9tbpz4Z866+dwrs8SELxp4+Emv9GDTVHI4wXkq9Datic2pJHCQi2me1utecf2BKnN24hs8aKflEP30nhVHbNlv0TfUHp9hBG2J4=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4934:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;20:zI5s1jsPBqYTAwPIjzGzYixVp2biISrcgzRbpiE3Oc3MXU7l3mUArYE9pLMntY2/t440ccGwgxQoUu4l5qlGx3u7Oib0joUBHuosfev/UGMTc3DP8L7kHZDirJ/vwIjj9eU7W9pFrm3ebNXORBdhV+FltNofOkiJsvS8/gcM5pmCl71sKaaE1GdOne/WNfCbOSNdVy04E6v1IJNM+YYgKMkI0WGHQ4AgdVirLGLnUHctl6dNtaFjKh0Gk3BroxZN;4:/us1ob4A+smuIXy+rjqGTwP9VmjbT/tmC5s4VXYxFy4mLxAO4y1d9IWNYgbqgoxxgndOrhxDtKedyOocrBs+P6iXSKf9jmr9mf+cupsBPgip7DGhFVpI4NBMkX+KCUjeJPozmeg661HPCJLgX4HayOFODtPOjHYXQoxpb2G7NxzrXYkdwukPRPKFAOwK3L4SeoDGCpdlIDsQJHePKct3yAeYJJW8baWPPk3KmtR43Z9EObQsOrSxYeh7FMNA35S66kFc0vBm12AwYi1qffmd5Q==
X-Microsoft-Antispam-PRVS: <BYAPR08MB4934227DA74C3207096D27DAC1560@BYAPR08MB4934.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(10201501046)(3002001)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(6043046)(201708071742011)(7699016);SRVR:BYAPR08MB4934;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4934;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(39840400004)(376002)(346002)(136003)(366004)(396003)(189003)(199004)(50466002)(305945005)(386003)(16526019)(105586002)(2906002)(8936002)(7416002)(186003)(93886005)(76506005)(5660300001)(106356001)(476003)(52116002)(446003)(6666003)(4326008)(8676002)(6916009)(33896004)(2486003)(7736002)(11346002)(68736007)(25786009)(26005)(9686003)(42882007)(956004)(478600001)(52146003)(23676004)(316002)(229853002)(58126008)(66066001)(33716001)(53936002)(2870700001)(54906003)(6246003)(1076002)(6116002)(47776003)(44832011)(97736004)(3846002)(6486002)(39060400002)(81156014)(486006)(81166006)(76176011)(6496006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4934;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjA4TUI0OTM0OzIzOnYwdzZJaFBDN2g1R3pUeGI2RzFtQ3ArRTVE?=
 =?utf-8?B?TU9HYTFYOXpBekdlM1hlWHNEdnQ5anlKbVVkUUQrYUI5SUpPMW1JUm1NdG1D?=
 =?utf-8?B?KytDTVc4SFJ1SWl5NXExQkVmTmJWT0Nxc2V2ajJUWG4zY3FXSmE0aXV3UE1Q?=
 =?utf-8?B?U1A1SVBPaCtvNXRmNEZENTdZbXNDRmpUM3p1QkIzejB5N2ttUVNZMnBFT0h6?=
 =?utf-8?B?RkJFc1RVQnpGWGcvSnFDbmkwR0FNOWNaMFpoaGdWekJGMk12ekRTVEZEaWNH?=
 =?utf-8?B?K1ZteXpJUDArTUdTS0l4ZVppTi9LR3VMZmthWGNVU1J1SFowSnl1NGk3WFFz?=
 =?utf-8?B?TUN4ZUFTMTNVWWxjeEJnVVVnTmVVR1lwTjNPdGhET1RVajBJOUllUFRmSDVt?=
 =?utf-8?B?V0VTa25xYzJkMkxyM1FoMEVuUGVxbzJNS3lEaDA0MWlEcngwOWJ1Um8yRytj?=
 =?utf-8?B?MGthdk1ZdzZzUHJ0S3psMTJIV1Eyb3VEdHVEZjRmcDJ2WWJCQ1ZXdUFEWFl3?=
 =?utf-8?B?LzVqRnBZL3l2VDVWNmRyQlFlNHE4bEZtR0JrMVlCVlRPVGZXZkRZSldlREdQ?=
 =?utf-8?B?bWdFVlZ4VVpRbDNTVkhFZ1hvcGxZa2NNbjRCMzFudUdjcmRySWVjMUU0NkJj?=
 =?utf-8?B?YndHdmIvelRvUXBJZDFYUjgxNGlOTVlLdlEyODc3MGpwaTJCaDFjZXVyeEta?=
 =?utf-8?B?eVlvanNZQURac2dhQUlJbUZIQXhIQkNrbjZjTkNzbGlGTjBMWWVnTVJGT29m?=
 =?utf-8?B?RjVoYXdvaklLVlR6Y08rRVBmcXFKb0phL0J1eHV5Q2pjRTZhZGE2d1JHTExD?=
 =?utf-8?B?d0I5eHZaL2gwSVR1YWNFODF4Y0o4OE5KcXlKWkZJWkt2U3d5MzRMWW5kcHNh?=
 =?utf-8?B?dVlubXBWd25JSmFDL08xTVQ5YXh2U1V0bTNoU2dmYkVkSmZ5c0xXNjBJSW42?=
 =?utf-8?B?MkYwMmdNU2E3clhYYjR3cWVsNlBPZnllcVYyRjM1czBvbDNZRFV0eGp1K1cz?=
 =?utf-8?B?Z1YwcUpLRXJ6WlN0RE1aYTAya3E0SjZ5UEdJYllKVTVRR2dTTlJnWXJUaytE?=
 =?utf-8?B?WHJ1K1BjMkk4RVpLcHF6SkZxaHRwWlRkdmFyMWFETVRDU0VTU1FGMlE3ZnVY?=
 =?utf-8?B?THdGOFFMbUlPRFJ5SDYxaUtVbC9zT2hIR21kQ2p0QmZMNmUzYkRoWitxTFNz?=
 =?utf-8?B?UnhtWnZ3aGcyR216bUMwckYvZnBXTkVtRkFiSXlKcThucFRSZE55cE11VlJp?=
 =?utf-8?B?bUdmeXFMWDk0ZkkydERJU3hTSnlXdUtJZkNZKzZlLzhyODhpUWk4UWFtaVk0?=
 =?utf-8?B?aUxidVJBczFta2NKVE5DUlgzL0RReVBEWjJLL3h3NHZDcXdwYTlzelF5a3h6?=
 =?utf-8?B?ZUZURlQ3MjVVQTkreE5UMDBUdHFnZk03dXBmV0hyM2d1L3o4WlI3R1plUi9w?=
 =?utf-8?B?SmhtQ1pTcnlVRlEweVhtcHNaRzFFRlc5eWRtZjF5NjduVG1yckVJajZINFhp?=
 =?utf-8?B?MjQ3a2h4a3RtTmR5bkdKQXJsaE1jV1Blano0aHdVQkE5bGcwRG5kRDdCRyt5?=
 =?utf-8?B?TXhnMUIySno4cmFFSitZblR3TkNYajlwTGhXNFBsV3BSSG5rVjZnT0tvRGMr?=
 =?utf-8?B?R0pCM3lIZHVJQk1rVTByNEN2UUZhWk4rM1hybjBoU1VwQXg3Y25Kb0x0c1hr?=
 =?utf-8?B?cjJINWh6akYrdTZCZk43Z2JzMFJUVUI5ZVRrN0lWREp6RytqOUNVVXZKeUhR?=
 =?utf-8?B?VUNaSWFVOHBKZlN1M2xqWlQxUklMNExiSG90Y3JJcTRJbTJRL2ZPb2ZKZVl2?=
 =?utf-8?B?NnhHalZ5NXk3eWRGN25Eekh6eThtR3ZnNU1JRUJkQlUrNGd2c2xSSkh0cm5n?=
 =?utf-8?B?NitjZU9rVFpFMkJBNE9sQkpwT1dkQnROUFA4YVRJVEZ5V0liWENxQmVBYUlh?=
 =?utf-8?B?ZlJwbWp5bmhBPT0=?=
X-Microsoft-Antispam-Message-Info: Hnq9Fdpn11RMqDcj8g1XoHKf9DKy2uJ+2mDKZARybPX8Qeg8DFe5WN5+KjrYKrZhxRIVjS/nT5qTSyYAp7k6Pe1ETJg0bHsN3q5M5+LUt6Z0coCMqFbCSKejFWdpUjmS052P+5/EmhGNZ/APBCQ2d4xuy3MWsd24HVt9FAVBVVyJHLsQbdnrZRhBCgLkAmyMCcwrBa8ow7kXz7rV5ZVbkaTgx0Bai5tX5ewwNAoppeXDV5ma/7EhSMagObT8owjDx5X+kZVyAXVq7rvahhytrzJgc3wTnr6gdbbWC+99MHpjAD0R//YdJeOk6exsynU4geMY9etM4ibxkh0PY1QyffVk1WbFjwdjaph9R0RYjbw=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4934;6:F1EnLAs0lkM/hbt3QMm99jfntMK5hvHYnxZ3sGVExrl41aidma79wpSQf/hiWY0K1Wj0r6cbYdHfjAl6aIrc26Tf1YL9s8gzzlLqpcL3q9f3DbH+vREJ4hIeoiLdk62W4WCzIbdrkqYS83JKjyg9g2c4i3zQdazlu7QtYYHai7PWvgO7giw+hM7LA2rSk5kS3FoiLxYqc70LkTq3phCU1QUIR/1x6yX5HTlcCSjJ6ECJBE/jedRkcPaZXfgNl54SQsi+nTTQdb3fvRIMEHEWmFd0uDcr/MWaXVA9IA93Hbvy9Mz4vOETvf1wNbeCriikwWcmhHDCzXXLBC/YrqTkpAXgfR9sJQiMBCYdDFG4QDY7wBic+QkjPufxxbSASxnbqXBktBx7MUCpR5EdbcA92BWtjEkcRoNFK5lv9I4YgQjgrHuxJ7zhmlapGZOcXWzjI+8+xXf3URcXL9hX31hrdw==;5:xTcWRLs356YXP1/tgCwdYkT0kRJFpi+Vt+I8uhrLEpXOElQzAJtU0xkW2vYKpa/bJSBB+S5T0zBKmHcl9UZzuTFFpBs9WahJYEQwQfHHoziJnLKxhT4tpu0WwvtgehuW9RvCafUPTM2xnkarzJy6Cudd7r6XXByuh68dpnWoQTc=;7:IA8txtpANkNRYcf+WXGF/J7vcQPVVS2fXBAVSvITPVD+CVPPy/s2ybwj3mNKzXCzAkM4IiH6obE3xySw6prbsy/0O0T5w3mLhPG/aJoujZ6+NupF4M5DfgbYKufjaigJZ3QzrGnwtajEpUCheTF89rZm7mv3S6PUVkAKU3q5rv2fknxfKGu3JujRVds+AAZG+CCK+sgeYenQ4m917D8Wn2IRzGmcfNc85jrs5YSsJFa7S1CMKK20ex89FNOA/C2F
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 17:37:50.4400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e063a0-083d-4c1f-b0ba-08d5f0c3033f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4934
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huacai,

On Sat, Jul 21, 2018 at 09:35:59AM +0800, 陈华才 wrote:
> SFB can improve the memory bandwidth as much as 30%, and we are
> planning to enable SFB by default. So, we want to control cpu_relax()
> under CONFIG_CPU_LOONGSON3, not under CONFIG_LOONGSON3_ENHANCEMENT.

OK, applied to mips-next for 4.19 with changes to the commit message &
comment.

Thanks,
    Paul
