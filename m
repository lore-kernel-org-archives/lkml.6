Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D99C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830AA20659
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="EE5estAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830AA20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbeH1VXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:23:45 -0400
Received: from mail-co1nam03on0094.outbound.protection.outlook.com ([104.47.40.94]:49514
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727040AbeH1VXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhAt41GkKE/dfAvTVeAeOr0Z1O/NNzeP0Sb8YPzRpjQ=;
 b=EE5estAc33j07shULFqvtm/XY4snFnoglYDYGftCjFlHjB9CrL0Y5BfU5FFnYZWanpnCfLI7DdEpfcmH3aFrS5ch/7SydWiz2LezNrHXSStQ9ovZF0s/d5dpUX4GsZ7/409TkfGYxA8o5+NlkoQTm0j9i6XtaBl38+KAwn30ex8=
Received: from localhost (4.16.204.77) by
 BYAPR08MB4933.namprd08.prod.outlook.com (2603:10b6:a03:6a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Tue, 28 Aug 2018 17:30:58 +0000
Date:   Tue, 28 Aug 2018 10:30:54 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jonathan Corbet <corbet@lwn.net>, od@zcrc.me,
        Mathieu Malaterre <malat@debian.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v7 12/24] pwm: jz4740: Use regmap and clocks from TCU
 driver
Message-ID: <20180828173054.jlzczfxwjipdwntt@pburton-laptop>
References: <20180821171635.22740-1-paul@crapouillou.net>
 <20180821171635.22740-13-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821171635.22740-13-paul@crapouillou.net>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN6PR1001CA0032.namprd10.prod.outlook.com
 (2603:10b6:405:28::45) To BYAPR08MB4933.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fa05353-eef0-42ec-a5b2-08d60d0c0487
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4933;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;3:Tf5CY40xRp/tVsXK8bHyKGBe8S9cihp+8CAObBMPmCLLYmOTOLWOzvPYd3qj5ZclWzKBcQi7lF6xwpFVng3NF7fWsU1BsvsP4ebL+/Jz5eWb2m3BNIs1/ESOhRrC23gW2YkNxllBbifP2WMvlw2oM2H8n3lw+hrkY3j5jv542ZimKEUrI0RIRpsF4P4zhS/76MDLZe7N/GP5LvbbEW8AZz7eENSmxe3gSb+xHx+mBiWtOXujhKWrKK3jGTl2k+aF;25:UG1a1HZRHMv+5p9NOBXXlv1FUYnPp+4h5xFlZjvH38FhBHy1afubUhDlvvE+573nr5N65XVOQFxHG5g/N+Iw0vHjz5smucKNP1A6wofzYpGSg38r1D8Rq3G2mrpHx/eooDbXGplh/a3nXFpiGjNkS9eWfzdgSgWIW6p92zVk5lv8nm4pBLUtqBgI86QxhRKxH57nauSXuijW7NHtP1ykcDykWuQL2cKK9rY1VVdCt+b7kSn7oIbK0MqU6u66w9y83rnWVALDyRPp0E2TXhG91YrOewd44oxV1M6BWVnLicG6dpBegV7siIJnhRFO7qr1ZWuHuj5hF8A6q4qz8TElsA==;31:QfsxoRLjF7tuFMcQNGaYw+crQlAMalwucrudcL0IHUvL+fv8u+G3wmnXLvlzPxSLwMebkBWDBaxt9PfwjbDaY8rUbCU8BqDFz9abS+yfkZK+1ZsQ9mEkXmvuqjS8K73qDCNBsjCcXL4KL/+soGyzaRNx9O8N+0miRyJ7nf3ep/kgDSq+xE7u2RJQk2ApQ7E11YhxjxAd20KRHCVf59FbAB+ik+psN5roqmjULmZ7Oy4=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4933:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;20:VC5hlrQduLLniHm1c2jAipxdrQ25isMfvBPFvBE4PhSDwX/8mNlQYBUqyeIxOY69Wo5uyqIHlxjhYJz4DEXZJW2N4AaR8Ece+vKdiUbIymL9dp8YN/vY19lyUej4r48cGPLb9fZqoruAC5IgLNPJsMckKSo1G7nC0DeOLsJHRUQk9W5S4k6KjadM4o3Igac7Y9cl7IGFoowkML+4PTvg0iue022UZ2+IEkGCebHA/E2UshZ/1CdagaG8ONO8Jiht;4:fT8PZciN0XaGXC4VZ00h8tNpmXfrmo9yASrKwqhSzyomFRcjXTEpLn8yf53ncofy0wi7zex7OJ662nAov76ei99MVEosvHrE8p5AVpFqzgvCpP+ZAx8j7VltOCmRhTRw86g3/TwyeTNWPgtVLizuT25VNx52cXjhbC5wzBgIi83iXdLUsx5h3PqZrVGse8Grmseb2hgFrc2wfxIDZ4ndwB/uzKJVX4A4C7rQjozqzd97DC4iWcl7PCTnsLehmJowgYFQz6bgYkX4COffLa1ULw==
X-Microsoft-Antispam-PRVS: <BYAPR08MB4933EF29DE9C4F27E58BD141C10A0@BYAPR08MB4933.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699016);SRVR:BYAPR08MB4933;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4933;
X-Forefront-PRVS: 077884B8B5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(366004)(376002)(396003)(346002)(39850400004)(136003)(199004)(189003)(229853002)(23726003)(9686003)(76176011)(6486002)(305945005)(386003)(6496006)(47776003)(66066001)(14444005)(4326008)(7736002)(5660300001)(486006)(1076002)(44832011)(25786009)(956004)(53936002)(50466002)(52116002)(6246003)(97736004)(68736007)(476003)(33896004)(6346003)(33716001)(16526019)(16586007)(58126008)(54906003)(186003)(11346002)(76506005)(6666003)(446003)(7416002)(8676002)(6916009)(3716004)(478600001)(39060400002)(2906002)(3846002)(106356001)(316002)(105586002)(6116002)(81166006)(42882007)(8936002)(26005)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4933;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4933;23:P1+DoDszfukMNIdHiDvTpytffkw9FcgUF10qnFeVK?=
 =?us-ascii?Q?6Qr/0IXbszrXGTxmeOWk9N+7Yzzu/muFjiDBGKYCdXZatvoOAX8r+78fNJc8?=
 =?us-ascii?Q?KVGteA/WLOzagXTWQwKE97PGRKmLDcmEcRVfweUCoIvKwVqRF6PfWEqmdl2F?=
 =?us-ascii?Q?2xyDO57GBSWg26LZUurgQvuiEm41WvAUfcBPoBxPuzI2E48FwGvW8SVEeo1R?=
 =?us-ascii?Q?tCe1vESF6/6m+keVyBwN5gPqrZJmH39JacGt8HjVwf1+2rlf7yjWJCqfaP54?=
 =?us-ascii?Q?JZ9HWL2VeefDN+ajy1o+ob6uMw/9ZfmNG/kI8jVDleVB3w1hcMLnYExOc8h2?=
 =?us-ascii?Q?Z4KRZLwqBJWdY36K2Nt1Blfjrs3/Vqsp7X1tbFlCRodafWyokjCFvInYspbU?=
 =?us-ascii?Q?4kxQrI0AROwBeTvNmH2wrnssbiY1DOPPyPiNuQXaaw9fOR3PD6lXs6H72LxQ?=
 =?us-ascii?Q?FOyMya8/ZkZwv78eoKBiMzRwm6z+zdEViJLIiQvBBlOb1RyYcpQl7KPr9QKo?=
 =?us-ascii?Q?Hd93A2ucj+UsWQpGYBTKF0uBdYCk6BBmy1ed+tm79t5ZaCKIUy+p0DdtlCfx?=
 =?us-ascii?Q?N1ONVHHYre6ZtGWHyRH66fTMLTDBrf/imCdkjBUAg3qu6E0bbzzFXaMCulX/?=
 =?us-ascii?Q?LV7ZiCXgiDHXSyTXOubGJNwH4n2Q7wzhZSJAPbUNtfTjfJOJtfjR7NVoMkOj?=
 =?us-ascii?Q?kg2lxslP4Sn2+ew0tRrfH0Jw+c5/sVtmGDRpmphKYipe4VgTOSp1TkETGOzf?=
 =?us-ascii?Q?WYgxoIq9JAQ1FWPaKp4MYX6rRL8LumnnaFUrdWxQtxEavabpC2NROe1uWcPM?=
 =?us-ascii?Q?sDT1/UyRgbVQKHmehsTiuSeAQJzerwFcJTepquyndvhK32pfInkzEaU4qH4f?=
 =?us-ascii?Q?+coPliEU7qlJ8pyq5ygtnGRdhTAFEWyKlOBfcXJE0g1ea/YGe6UIkPavFNIN?=
 =?us-ascii?Q?aceYV3xXYb0PYb9eUoF2pzseop327dUhq7IaB3dhO2L3HaWwpaEzrr1toQ2L?=
 =?us-ascii?Q?/d9ldwL+GQkt6qzW2pCwoyOqI5/jAGzW9ZLBiTT6al1AXcIxFMFcpp7zhYxE?=
 =?us-ascii?Q?XD+2T3DJSVYSySan6V2obaN/I2UuTzITKq+xStXz+aP/HISNGUQnqhD3rp0w?=
 =?us-ascii?Q?0EpR04bleEoxvOzZ/j1jCyLg1BPCm8ss5MAb6KRmyE7xlyP8u3yytM9OxUVh?=
 =?us-ascii?Q?JW624hU8tD1mPybTCXR6TSR5oqV+mTzzFYpPjjDCjv8r7+L6Aekmo5F/2NfU?=
 =?us-ascii?Q?Bp88Ft/0d2vLiqcp/2tOoOe95ILv2de+M5WbxUmKeaHZnV69yNUWqBAAUaxc?=
 =?us-ascii?Q?NnEjL0il1Kb9r9vaLcx9OzXTdLkfsTyQEdgmsXP3h8irVjA6l8ql7pGIXfNW?=
 =?us-ascii?Q?t/XyrIHGDz8eRBZhVluyvv03i/3JTk1w87ckQZzJSF0+oPpeH39J2bzQESpZ?=
 =?us-ascii?Q?TWwELENTg=3D=3D?=
X-Microsoft-Antispam-Message-Info: rGRlCVIYBc/8dEx8O6xkvi/N9rMcO4c3kqx5M6Vv0VfU/dmok8YQEA3kpB8JqaG6DMxvoHfcHptzp81vjtR2ZNVFwo+Qh2Rh77gnK4NRRaEEZ/J7A9qjInfL7pC0kbMcbeCxhRAf1F9MuU9VxNl34EMQcyRBLBdSvHlMDtQQtGBpUAyBYTUBnKucaJtYt80DAun3lCx3fb415XxQqXY9EwR7BccgAzjzKqlm6WQvL+6Szo4KSrQL67sYRvYdN7JhGxJcVHoNKBUpG7hzbfE1Xc6LKNgOgPsynsGehB4GsNx6O3fxvyi2n/mMrvs/Ksmcl57bz87O4Yk6ElL7YmzX12d9Kmz7VRiwV/W+LIvSBew=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;6:BCcQUqucGWQOoS6Vj0I3oLEP9kWEmsuKPNwjlT0SknwE2aT/Rjtpmousb3xKfP3Svli2WK4SsjdM4XJVmgLK27w3CD6ujsoDWXbR62urTr3zxyGs9BJxr23BI/+IGO4J8pVXjUhb3EXSPns7v36m4odJ9YTqxmdndyrjTOG2UBLvNCSzlXZtwNta+cIynFbw4dIRVpVPwSthLHbIMdR6Oht/8P3lZwIXTSiSTB1OMLEKKC6LdpY5bsR/Bq9gZMOsMXj/DkDwLD52hN6LuEndKSHWSRoE/gmKERRYDsxx4WpBjh2oVhLSaQHIhOJUTNa/OG0cxqVjWkR+dRozWzFyBHjxPfEK+MFbZVmnOE8Cj4Jc08SEzIowvrWLwUaPPXDE91NfYPRP77iagFURzCDGDNC8173MTG6n35w5sJlWKw6H8MCigUm0i/qilLFWaLvHIvdRdIQWc8dWcNG/FYwY0g==;5:xCegXTYwfdqyZpGqGJW6IHWUlWjw5aVDuhpunUAlKcL3iEIp6Z4tBGe6+qCxw7RsNrizR0wVTiXhWtTMsK66DBKYMzkC5ddw3H4h9nPyE7teHyHppDDEjq6Y4GOFk1NHkMBGXsqqR/4zhnu8x4/CLdfRciiGASIRm9oTN7y52ZE=;7:KW2Ojl44CVUeGsDGH1wSHSvMWg4IRwNxSFcq5K0MQsBFIMrecODMknJ4zebPjhPdwKenIer3hkmfvIUWdXJd5uHGRKN4aTyllr9FQJBiJ1ZtBaqVZTekDqr61Fonjl+iClk8NB9kWGiWQI7HHrfdx0itBmXRp/s9bsh+2o1kv8+PMbBJq9uV+qAj8+2W+LaHn65NerYcNHEsbMt7HyI0HU1z25fAKoIYdhpbdbOwENnfWg/Zyn2O4HFNSECqXLpK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 17:30:58.3146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa05353-eef0-42ec-a5b2-08d60d0c0487
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4933
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

On Tue, Aug 21, 2018 at 07:16:23PM +0200, Paul Cercueil wrote:
> The ingenic-timer "TCU" driver provides us with a regmap, that we can
> use to safely access the TCU registers.
> 
> It also provides us with clocks, that can be (un)gated, reparented or
> reclocked from devicetree, instead of having these settings hardcoded in
> this driver.
> 
> While this driver is devicetree-compatible, it is never (as of now)
> probed from devicetree, so this change does not introduce a ABI problem
> with current devicetree files.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>      v5: New patch
>     
>      v6: Drop requirement of probing from devicetree
>     
>      v7: No change
> 
>  drivers/pwm/Kconfig      |   2 +
>  drivers/pwm/pwm-jz4740.c | 124 +++++++++++++++++++++++++++++++----------------
>  2 files changed, 83 insertions(+), 43 deletions(-)

How do patches 12-16 of this series look to you from a drivers/pwm
perspective?

If you're happy with them it'd be great to get an ack so I can take this
through the MIPS tree along with the rest of the series.

Thanks,
    Paul
