Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A09BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89EE21386
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vozKDyty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89EE21386
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeGDRvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:51:19 -0400
Received: from mail-by2nam03on0071.outbound.protection.outlook.com ([104.47.42.71]:22042
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752251AbeGDRvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+qV0mCeWd1aJOurjE0oKNx+4udqVdOZBM794jw2f3s=;
 b=vozKDytyZ3P8hG4qdBMQu6ly6gQk6MqwMYj/ShLxSWk6aiL9nlpkJ2OKnWNaLPCZx0YfDh7aTVwJhwMvRryjZfRu12UOfQeMO0yQyVQCjqskJhkP51B4Xh9gocO6CIGdag0IAbFNRmJqnbe8lbXI8Rhes3v2WjhDKk6UJviyaMg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from [172.29.157.77] (165.204.55.250) by
 DM2PR12MB0187.namprd12.prod.outlook.com (2a01:111:e400:50ce::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.19; Wed, 4 Jul
 2018 17:51:13 +0000
Subject: Re: [PATCH] drm/amd/display/dc/dce: Fix multiple potential integer
 overflows
To:     =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180704011305.GA15742@embeddedor.com>
 <c663121e-1db8-9d7f-6b66-2c41e6a8bb70@daenzer.net>
From:   Harry Wentland <harry.wentland@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=harry.wentland@amd.com; prefer-encrypt=mutual; keydata=
 xsBNBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAHNJ0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPsLAdwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2zsBNBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAHCwF8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <421747e5-e6e0-6680-e3b7-a3a2a5b7b307@amd.com>
Date:   Wed, 4 Jul 2018 13:51:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <c663121e-1db8-9d7f-6b66-2c41e6a8bb70@daenzer.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTXPR0101CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::23) To DM2PR12MB0187.namprd12.prod.outlook.com
 (2a01:111:e400:50ce::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccafee79-0e7b-4c42-3fb5-08d5e1d6bc75
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0187;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0187;3:OD1mSZMt5j8/xIudUbTkIFcYZ249CRFRo4AraksL9UVQ6O55+5KewZZbImAobglqSJpDc8Q+xcp7kFfUbogOOVwsoeJAPDwwjeVS7McADvKHrPdafQlluNJF30JeuQhlPF5056TEe7UBqGwWaeX7pjAMK/Rq07Y5WVoZWHJ71dxra4IFu/k/WU3QQUGB7p2lMyuq7L8XTBTExiDwdhzM3bKPG10wNLpAlEQEnCAC85CqsVAH6HU/NUCTIpbVtMM8;25:G2UpFftXRML6hzQoG5t7g1+ivYGwe7wBli1iK4BT/wMogGAzLqEdpjUlLiLPCR8kvnLHhV64BFkw4J0fSs89cSeFg2Jbs4/MMfCAhW35APdt2nUk1I4oZul8AiVKatHN+XonRcODFYsaBrVQOrKLDt9qvCTptPxpy2aP7k4AUUw6V4wXmjiVw6A13BEo+b+X8XplaeZVXpGXOfAYVa1gQK5zBHe/uflAP3pTpWGzzWbEIfLk2kKf6N+mE1djRTS+vQd0AB4RPRUFOvNIdbjIG+AcDSQ5RQ4sajXzD21dgqQ2w4rj/HL5oQlA9ORa75eBUmNfHfv5LugnPNXC2JCLPQ==;31:ot8GBWtaYxDbUVHESdyWLTyJjbRNyMJggHaLRCoYyosmGTpxXhtwy9ADftzNWN4ujfJFOw0qD/BkOoO7IPGjhNitLTbl4qnExwY93WelNLFbHEY7kl9phRp8e9PsPSsxduom4PsJrIQdhY/shC6pxBYE+iNHSvQk8irdbRZs59ioAZiKPuBq5NmoBiwq10+cjZKS2EQMQLEuQ7dgfnd5AUXdmoWgXsl/bkCi45s/I6E=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0187:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0187;20:qXc5BufI0CFT+a2PirKvkxe3EKeIJm1LtSdDizjTV/Ufk8qxq5Yx0xDxLBt2/btmtOvGB3jGPmRqoc/inQw2zymgAUBYUy028UNPBYoPICVNmMcfrpp60rUwIegXXggGN7CkiWUPFGJpj0z71Cg27zybLc3I9pX7OSaMHYBURTZYPxZdp1DQ25aXX/pokmIn4y8sLsKX4HNjie7Yc+We6usqkfZFmwOCn6PdagSLjueGQq/pTnxDWzGzdNdGf3Pgkz1E27oVlJLRX/EghTmcjFpXJGh5D0SJT8f8m5KPfur1tixOjjPd6HuxvOw16/Btems65d3GxQBPwGR4BOAOEtXoUeZWv4oWztB/EtcdYTA/5PAyuwYNdGJOn0bt1MTfEhEHSoJaEVJ34TP//aMUTCCgY9V4TgaIl4TWu+TTCg022x/ZPthvosU5dQRwAsDW3Zq9HPKaocH4pHIvlnJwcOOJ+6zets/WBEaNkDb38qJtvM0d0D4RSCiP1fCmRab8;4:3WmCgDMpiFAl/cpOl5CUBk8BaBhELz4kDDVhHiCN8JwmZ9DFFIQgQIvQ4VaPg0TPUaZocdYPfz/Rhcrl0i1xot+aoL8uKm7zBw/RHVvnyCEN/AvWPo+rOkwwYK8/63e4mbjhTdrsQXHuYHkKfO1n1umgG//6lefO38lP+eh0kspIHsmiDyIAgglXdeG6V1s7U/44dk7sZmNUvYO4l+ay5RwmgKjML0bBhxXXHmxrMwD+Q/pmZH2dl8GpVyhIX60AwNfjbfJ9h9wOstU9XnUSkGhQ7tGUYLFWOilZ/F0O/tlB5fkYE+4yDi8T89IjzsBj
X-Microsoft-Antispam-PRVS: <DM2PR12MB01873B47BD579D65252010878C410@DM2PR12MB0187.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM2PR12MB0187;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0187;
X-Forefront-PRVS: 0723A02764
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(136003)(396003)(376002)(346002)(39860400002)(366004)(199004)(189003)(7736002)(2486003)(65956001)(65806001)(6116002)(47776003)(2870700001)(50466002)(25786009)(2906002)(64126003)(14444005)(86362001)(4326008)(66066001)(31696002)(110136005)(72206003)(31686004)(16576012)(6486002)(229853002)(3846002)(97736004)(478600001)(58126008)(316002)(68736007)(53936002)(81166006)(81156014)(6246003)(26005)(6666003)(53546011)(16526019)(77096007)(956004)(186003)(486006)(11346002)(476003)(76176011)(8676002)(446003)(386003)(8936002)(44832011)(2616005)(305945005)(52116002)(52146003)(106356001)(36756003)(23676004)(65826007)(5660300001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0187;H:[172.29.157.77];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjEyTUIwMTg3OzIzOkFwOVBSN045Ky9HUnpuYlFUUG9OMjNqWlpG?=
 =?utf-8?B?WUdVbDZWTTVscEZsU2p6SU1HT2orN3ZWc1cvV3dMODNwaFZTNnUrSGpuS0ph?=
 =?utf-8?B?TkFIdEl4Z002U254MzM0RTBWYnRLeVc4UGFQOGwzbm8zMEdPb0JjbjJQenIv?=
 =?utf-8?B?VXU1MTZYOFo5Rm1vOG5jU0hMbG9QLzhtb2pvYUhaSEc0WUdSREdWSzhoNlRx?=
 =?utf-8?B?QjdBdmNNbkJqU3dlbDlDSTBNUmtJa1QrWTJpTzRRd1NXeWl0QzhtMnkxV0Zh?=
 =?utf-8?B?VFJSb1VBRVNOSnVQSnJHRE00YTczQkpyNjBGdFpIaTNBL0w2QlNNNjRQaVky?=
 =?utf-8?B?TDh0WkpGT3RxZ3RzOFNVQmE3TlJ1OXlMeFVmY1Z0UkJoMm9kZjREbG9mKy92?=
 =?utf-8?B?SGRGVXFIYzU1eUltN2t3N3UvMDVPZit0cldOdnRqenlLVzVySzFxVTlKdWlq?=
 =?utf-8?B?TVNaQm9QdDNEaDdQTnVGOUZvOSt3WmhxMXBMZE85Ri9GdU5YWkNTN3g2cmN1?=
 =?utf-8?B?QzFSZm5uR0Z4TXB3aXJXUDlJVG9NM0NyaytENUZaVHd2cDFJdmNTRkRMSmJD?=
 =?utf-8?B?Si9YQVhJZTlzdXFaa1lXRWUzOUhVTSt1dm1Hb3RzdG9ZL3BzMVZlcWJHREFk?=
 =?utf-8?B?S1JNZElaVzJpb0dxLzNiMXpNWXdkQ1B2c0N3QWhJaG9TaGY4QXhMdHl4SlVj?=
 =?utf-8?B?ay9CR2pZM0hGTS9NUER3UEY1RHAyVEt2M3EzTk0xNUNPUHVDdEtVNTlsZ1VT?=
 =?utf-8?B?WWRXOHg4UVF5YWs2WGhjTE5FRjFBOFVCR0VOcHRZYzBZYlhLTGs1WDBTcEhJ?=
 =?utf-8?B?LzB2YnhSVEIvQWhvSFBSeXdJWHQzYWdabjFWcXlIMjhBdmRUMG1PU1p5K3dq?=
 =?utf-8?B?ZWNwbHZzdU5rNThGYTlWY3VBL0JLRDVuYy91NXZGRjZ5MkQ0dUF0QytDbkY5?=
 =?utf-8?B?OGtpWUNrRVBCc2ZQcllGeisyMkVjSE5ZL00vTVVqeVlBYkxXWmNxOGp4YXI4?=
 =?utf-8?B?VVBORGwvNFhvYUMrMXBTdERtU3RwckRIckZDMmJMN1FMOFR5MC9SVldoc0FQ?=
 =?utf-8?B?VzBMekpUNm9LNjRIZVNVOTdpRlA3a1hYS28raEJlczlPMXg1UFBFTmFQT3p3?=
 =?utf-8?B?b0NwbXYzNGplbzVTR0ZsTmw3a2pXYlBRbXRZd0hQMW0zTEZ0ckZYektlbjc0?=
 =?utf-8?B?dkVwYk5vRkQvNjl5bXNSWjE2c3NWN0VTdnpjb2F3RE1sdlBaTGthS09CL0dw?=
 =?utf-8?B?SDVwR1J4NTRwWk90bjdDYlFwTjU5NEdwWUVBTDVCazl4TFRzN3BFNU9WcVRG?=
 =?utf-8?B?c2g1WGFBdWkzT3lyT3VUTFVaakFEcFVNbjBNUzQwaHJUWk9EVDE5bE1RM2c1?=
 =?utf-8?B?VmdNcTg2SEdFa2duS2lod0NiOTczYVdsclEyQ0lhRDdLdlRsT3FraGV5ekl1?=
 =?utf-8?B?MGpwbGR2bkR4QUk1THhwci9NRlV5TWFlUGg0WFBIbWdXaG5FOVkvNVVVNjRF?=
 =?utf-8?B?T2VZc0lZV1p3amo2V3VES0JZSmNLNUVSYzNRNXdKOWRuemk1YndMNEpTYVBI?=
 =?utf-8?B?YnZyaHZlTzlmSkJUSllnS2VQSlNIZ0tQdlNKcmdYSTgzZFRUVW9KNGxxZC9B?=
 =?utf-8?B?b053djR6bFFmVWtOY081azFQT084RFZ1YWRGME9PMUROUS9hN3BGY3pib3NL?=
 =?utf-8?B?M3hEY0xKUGU3UWhseE4xcWg3YXRONFFmYUVKczZTTWZCSGpQMEdFTWVyL0RC?=
 =?utf-8?B?R1dXM1U5VXN1Vk94aTV0UzMxcW43eXRINGNvTWxTMlVvS1I4M1NocWJ0NXhn?=
 =?utf-8?B?TzN2cjF4SWFLeXM1cm13dm9JbGlHejRtdGVuRFRSR0JlenpMK1Fkd2RSMkNi?=
 =?utf-8?B?MmZTMFZOMzNvQW0zNGV3OGl5RW91dHFVYldCUGFHa2g1YmRqZmVqaTBUNWZk?=
 =?utf-8?B?dWkxZFNrTFJ6UllhL3VFcWY5R2phSXRWSnUyRG5vNm5aNk9RM0NrWWxSQUU5?=
 =?utf-8?Q?ER4rNF?=
X-Microsoft-Antispam-Message-Info: DOi88TNtUdZSdQznA9mkMmHaa3O0hddmlVVgI1cnjkTxXXvT1bOJcvsE1sZqzUMH6lOhGRCVfj9XWyUOx0P8mvRoNLsEn2SZPxeQ4uyhPYRKMdW/849TQYfmm4YguK31MjFRSIJOlEQzAi8nQeoONv5yzZG+zMjiA48zegAJHIEGBgKUeCFCqh7abqXnPUVxfInO1zoMz6+foRVqGT65reLZzxT0pLiLH9ld76tRwGnwCLO+s8uBs/D0SN97VDawS8PJ5DZubkbvsFaVHdb9hBoyRi99pnaIPjq2TXM0h/fh7sgPRhJ+xTWUYY1sUGZJbnX9J5/JJpbbJNbz8Lk6gZMqrtV2LDB2UsxXm58NGzA=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0187;6:UWZtn8qmNjusfTpM2yW1m7pGP0gjQevRH37YcKSs5kAZeqcdQxHC3dXfLGWoxH6KpmNImzftCvL7nMfqrPTLHEGDTpE+bW2o8cM5zdm36XwNw9gaACZswFKzasknWF5rarvXILrwZw70tmboU+RoYRSqC2DT7rKdeD1wd6wn3u4dNDEh7yoYjiC2TlbvcFzrqMx1UKevwKC3Ikdxx94g+rkMQHeblEvV7MxdkwdqI7u7119aZIsdXUQW+2ZcqJCR3IsSWxhtIZY/7cA69t1ivrc7Fb01MfVe2ehCM8p/DBZ68E3hStOHf/BKcBOvvItA5gNtyJGzRJxxINeTqTIrdVRXD7F2c1ZoaT90Q+ARjYWYVpgRp1cPBWBR8FZ9jKtcj4yrx+RfclVwAcKgXKT05GFJFWcdba+Q5Ej3nJiKzA1OUzHbMnNAnBwUZp+exBu74/699FLRxadpP9tpuKgs1A==;5:m0Bqo+mJOswqfi8fr0iYyxYni5dDm3YRE6R6T2ScJ/2+qsdGUq6FF3MRRPV3wYJziI7ebLP9UgnR3MZAbJ+U+/bnMPOGoyIaKfhS13ZxjGVpWFx7x1a9RZgqMzPQy6kXpw6hovvitlQirX8sg9rh67eqEHKI0y7R6OJCQSG5Ums=;24:FbDMzhnRfgI+zwttE51QJfegxBIawCCgqfFHuB8F612jjhpwAO9KtfX2BnCC5Fvc0g/ZoN2Nj262E2rBCpTrXxiuOrejKX5zsQjClsG5I/s=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0187;7:Edtb9WOhYWOinkrGUNT1sLMaD2ELJLaoQY3pQJKOcEAkm1vWRvSOipzrs5ZJJ6CQ6wx8NoSFuyi7POiQFVlVRyTYW4DzaGrJ9euPqjSWDLDBiGsf/DbPuTXdqjUICBIr07Iu2ABfuNPf3KC7HhxZ9RSJa+ZDql4DbJUK2K00NgBp4K8VzPtAe42YhiOCcKKM9+4gnAjm+CRXzH/VOmTdIlAtLn63N3gOZl9BgkBKCDXvTiZvxrLnfEJKTA08LcoD;20:516iHpyc5/Xm7eJmNBbCMmkSmmz5b+2Sw2BL4NUzK3Y2WcefPbn7WJUg7G8t4AH8GXrLSyaTosc/why4IJJPr9f5clscW/H48P7gSuGyy90FTpFmwD8c55xqjf4HPm3j/8JToMfBjniJnUKjiCT1l/gCRhFk6SWzgGcPR/boAglk6mqLy/8qGe7wmPbNK4lZpRqHnTDq1F8CfJZhBffOaDOLw/N5fgOX25H7GkDfDNBweSa/5X0G/ZdZgrGmhaJh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2018 17:51:13.2956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccafee79-0e7b-4c42-3fb5-08d5e1d6bc75
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-07-04 03:38 AM, Michel Dänzer wrote:
> On 2018-07-04 03:13 AM, Gustavo A. R. Silva wrote:
>> Add suffix ULL to constant 5 and cast variables target_pix_clk_khz and
>> feedback_divider to uint64_t in order to avoid multiple potential integer
>> overflows and give the compiler complete information about the proper
>> arithmetic to use.
>>
>> Notice that such constant and variables are used in contexts that
>> expect expressions of type uint64_t (64 bits, unsigned). The current
>> casts to uint64_t effectively apply to each expression as a whole,
>> but they do not prevent them from being evaluated using 32-bit
>> arithmetic instead of 64-bit arithmetic.
>>
>> Also, once the expressions are properly evaluated using 64-bit
>> arithmentic, there is no need for the parentheses that enclose
>> them.
>>
>> Addresses-Coverity-ID: 1460245 ("Unintentional integer overflow")
>> Addresses-Coverity-ID: 1460286 ("Unintentional integer overflow")
>> Addresses-Coverity-ID: 1460401 ("Unintentional integer overflow")
>> Fixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>
>> [...]
>>  
>> @@ -145,8 +145,8 @@ static bool calculate_fb_and_fractional_fb_divider(
>>   * of fractional feedback decimal point and the fractional FB Divider precision
>>   * is 2 then the equation becomes (ullfeedbackDivider + 5*100) / (10*100))*/
>>  
>> -	feedback_divider += (uint64_t)
>> -			(5 * calc_pll_cs->fract_fb_divider_precision_factor);
>> +	feedback_divider += 5UL *
>> +			    calc_pll_cs->fract_fb_divider_precision_factor;
> 
> This should be 5ULL, as the commit log says, otherwise it's still only
> 32 bits on 32-bit platforms.
> 

Agreed.

Otherwise this looks good.

With that fixed this patch is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> 
