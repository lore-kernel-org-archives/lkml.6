Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC475C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 18:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 972B820847
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 18:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OZuvVeht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972B820847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbeGDSFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 14:05:30 -0400
Received: from mail-by2nam01on0063.outbound.protection.outlook.com ([104.47.34.63]:16474
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752251AbeGDSF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 14:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xi+bxW5m9s0xZ3VrrI1ym+1EARi6eY7QpCJvhrPKn74=;
 b=OZuvVehtM7ge0OAj0UOBUpsL2AiagoIsz/IV5AYjCpX93hgL7VpgOSjFgamNQrZgZKM9Wcdwyu+lhrnQqcgRji29xFTw+HfaSJbvJh7U+HQWwvq4u8J0Qhv+szRDGzkNCWGx9qbLlcSp3WBFRIjb0l0VdMLgB1wBYsTtmcv/S8E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from [10.60.233.33] (165.204.55.251) by
 CY1PR12MB0183.namprd12.prod.outlook.com (2a01:111:e400:50f8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.884.21; Wed, 4 Jul
 2018 18:05:22 +0000
Subject: Re: [PATCH] drm/amd/display/dc/dce: Fix multiple potential integer
 overflows
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180704011305.GA15742@embeddedor.com>
 <c663121e-1db8-9d7f-6b66-2c41e6a8bb70@daenzer.net>
 <421747e5-e6e0-6680-e3b7-a3a2a5b7b307@amd.com>
 <ab3d5e10-e25b-46a1-d3ab-da3619d8c5b4@embeddedor.com>
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
Message-ID: <ced95410-1b3c-8344-fe62-7f22f310c86d@amd.com>
Date:   Wed, 4 Jul 2018 14:05:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <ab3d5e10-e25b-46a1-d3ab-da3619d8c5b4@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTOPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::18) To CY1PR12MB0183.namprd12.prod.outlook.com
 (2a01:111:e400:50f8::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5b42b1f1-e0fb-41ed-df41-08d5e1d8b71e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(48565401081)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0183;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0183;3:/fSTxqlmfLX0N4dP5DZpnNmtN1X5Nk8gX14+nmw63kH9Rzc/3v5CB/7Gcw3xhwOVxd5YKG2DFbbd2kkrwZdYTmv4w3fJw6pcR0m/Q56ssayCyJQdbKpqxxTZGBlPUicWu2bEpKYwrK1GKCKLzwxVrmsaJu8EssjPxDrwu96OzWJSP3p0/p0SYTlMUI8Ix+0LvCcBeu26pHulLWhNptC/Yg746o8iZTAO8zgWZqVKSXpaFs5Oo8k7nx8Mh+Hlu0H4;25:aQD7/DFYCfwNF0Zkbkz58bJ5+9vEJnRkETJ7NsPgkSiPUP1XeckCN91+RGWW4rXngHW8cFLgH/QpZiDzXzDyZivLDc5y+86BmidDb50W37NalSrCgY8zeMBcZh5/dT/yzBUE6CnC9/ZaOESHm+NXqHtrfcxLkCByJcQVZKdXdSt+sTGavwk+N/+RcXD+MM5Jb+iul3MgbipdKwvvC8zduWqWOk0udcLmpLv2snmHf79Ax/QPABJvP18+IrdSR5TwmtzumO3ywxGvWt8nbD7PJ54lUBrsNFuzSpiKSsN4ob095xFu8ee4KrjTzOc6dvGVBIRTUejNSBGIoU6cqUPnTA==;31:5dWL8B2fKA2fJQZSK6cpFvmfdKm6u0J3H5VXk8+OzNl9QSV12vXMPLFs/h1co99K2jGyzuyjUUVO6ICnOjmjxO7oPPvYP4IlGcc46YBZHJLiLF0SQ3xZ/BWXTbCDtkbkDRx05UNTKlQtkqeKLN8LsRbvH84lIEaq18mlyHaQ34XDdTx+Je2VmWQgb01Sd0gnLt1l4WUQcvx11zmBKA8zbYQtTNTfcFj0/ZMxJDENQd0=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0183:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0183;20:cK4JLtn0wywMBT83x9TmgMsnixzlaT34feD/YGV9hgkgDxtsYF39vmi1XCHgi5POQXWbvVSokmhJrR98NwOKUFnj6ZvJRXxva6qGGDWe5TgqNd8NDeUfOQVObjwC6yEd83GAdRw6hippUh0vHEojh3q+JGEqL6siMMEtdzKlNM/eqO+PsEzLEZGcMQqDTSw8xJAerTd1p9gQQHmVoNQaTvayHgLS6Sf/QquLMSBEoQhgMBjrLHP/L28kuUGjTzV9lP5vQcPxRLdQ7WGaD8fJ0V9PfB5YOYcLyupxs7jAB30DbAAiZref++Ty663SKW4Co8M3lSf6SIdvEIXQL4U3k9nS6dxN941NHcVPvU5xmQUfhYcZca7WGxdBvG6dvxgLB2d2Qd28IzOLpDLII0RjBi6Q2TVtcL9nPfxjB3XCW3jYYvnTwwMudEndbp3LiDe3ac2EENf00VUEuxOh6pTJ5cqOV5pnsRnUYlom9tZ4DeDBaCGniXEHCN0xmP4GdNwo;4:4BwUEG78Vjf0Ih7xOhCfPdfUkzwy4WgHosPt0M4Cam416XLS288T89FG9uE4YfZ82Mp5JGdYaVNFuIn8Nkwf8J3HPC5B+fHQQr0VSllCftKzgQCzUj7TYOUM8U7rkwltRzICHVVLKcUiHj3jhnOUs1qyRSHgoXcXRcPb7CGebcqme238oITqv2vFsODYsg5VW7V9xttgTUj3xzzzpai81V3HCwsC3+FUJQ5iaOSoe55BfxHcDZf83E+ve1BKKubWN7Fq/qWaO7uY0dt7IMB4lpYcMoU6Hy9F1OQJVU5Bz8jJQ3gVgAMqLnEEeetGJA9S
X-Microsoft-Antispam-PRVS: <CY1PR12MB018326CAB8487147BFF939088C410@CY1PR12MB0183.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR12MB0183;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0183;
X-Forefront-PRVS: 0723A02764
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(76176011)(6116002)(478600001)(65806001)(105586002)(65956001)(44832011)(68736007)(2486003)(47776003)(7736002)(52146003)(31686004)(305945005)(956004)(31696002)(86362001)(6486002)(2616005)(476003)(52116002)(5660300001)(66066001)(3846002)(50466002)(23676004)(2906002)(486006)(446003)(11346002)(93886005)(316002)(25786009)(186003)(110136005)(77096007)(386003)(26005)(229853002)(16526019)(81156014)(966005)(81166006)(58126008)(97736004)(6666003)(53936002)(8676002)(72206003)(6246003)(36756003)(4326008)(16576012)(8936002)(6306002)(230700001)(64126003)(65826007)(53546011)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0183;H:[10.60.233.33];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjEyTUIwMTgzOzIzOkRCbzdtQzRvaDZULzdxRGx4QWJEa1BDMCt2?=
 =?utf-8?B?U1ExWFYwMFlUNWVuSEpHbnpCaGZPYXVCa01JZTNIVVdQRlZYUXAzTGpkOTFL?=
 =?utf-8?B?TTJpbU9VekJzKzl0OW1CS0dmVVlTSmNWQUhCeTR4WkJ4LzZueE8wcUNHMENF?=
 =?utf-8?B?SEQ4VnNmcmxUdUVaYjUyWU41UFRnbC9qNEorMXcrSGtFYytzM3ZkcmNuNmZB?=
 =?utf-8?B?K2x3Y3RwQnR2dUF0blJJV3oybUYralNjeGp4WnBHQmVxVWtGcmRCYkMyUERR?=
 =?utf-8?B?MVp2RzNRcE41MWlyZjRrV0ZuV3ZpUXZseFlZQmFMcXZsb1FtdzZJS0dwVUhj?=
 =?utf-8?B?Y2s0SnJ5NWx2blErNXVLMnlKUXBDek9GMzJxWnBSTWdra0hsdDljVUhjRWdr?=
 =?utf-8?B?TlUySjRrNzFXdGhiVGZZR0JJNEd4UG9ZSWNmQ2RxTjZvSHlMRDYwWGIrRXlG?=
 =?utf-8?B?OGNqdjcwU041SUh0WFl0MlN2cUtYbXl6R0EvdlBRVU14M05UVU1YNEpwUkZQ?=
 =?utf-8?B?TWVVaWZqb0ZCSzRmQWVZS3BqUElnRW9ON2ttVWRhMVYyd2dsWEY1YmY5R3dH?=
 =?utf-8?B?bHM3aExINUdUZUZTNmpZckJUZlpZR3FCaW1zeTd4VVBseGovTE5aMzc1K0kv?=
 =?utf-8?B?RXNCUWhLeU5Oeis3b09SLzJ5YVA3RWFaclFYMnU4dkFmaEI5bTZxR2s0dHVP?=
 =?utf-8?B?MFYydmt0Z1BocWE5dnhPYmtiZzk2bHVod2ExclVNZnY1bVBENFgrbTZHNE42?=
 =?utf-8?B?ek9VMXhib0NtWFF3TXM3dXU3ekR0RlhhN0dYc21lUjdoVlVaaUIzSzdwcVBV?=
 =?utf-8?B?dEdpZ01lSjBsTmpVL3FZUnI1Y1ZEVVlhNEZvUU90NzNnOUxoZlVXcitMd3Nu?=
 =?utf-8?B?Y0t3d3N6eUErc1ZKamlsNlNWK0lMRmg5dUdTMFk1OFZYRkc5MVZrRFdocVdK?=
 =?utf-8?B?TUFnV05IOWRpUzh1cFlhdTg4OExaTXpjaUR1TGJ3NDBoRmtaSElBbnZVZE00?=
 =?utf-8?B?V0EzN0R0WXVsNFVYNWh5MmE5U01FSzYrVUpmd283TzNlRUptbHp2aHpaT0xS?=
 =?utf-8?B?STgxLytITnVrNGlma2pxSndBdHIxYTFzVWVUa2ZtczIwZUdjZDVFaHNud3RQ?=
 =?utf-8?B?NFZYQmJpNXBDVEw2VVZDdXRUR1VoTVVWWVNSQWZGQk56bzBTSExnQm15YVg0?=
 =?utf-8?B?WlZuR1V2Y0d1SmlxU1NqMUNld0hNTGJxV2hyN2lhQ3lIZklQTGhxTklLVnI2?=
 =?utf-8?B?MWwxWkxDKzhMV0ppZHlhWTdBQ3BxRlkxUHhOdEwvemtmVEVEdXhxdU5hUC9T?=
 =?utf-8?B?QWhNK1FjaUJzM3llRk9zdGFQT3VxYjV6UlN3czdzYTg2NmVyUUlsSEV2bVgv?=
 =?utf-8?B?NEQ3cmtxRXVkOFFQYzRuNkplREJFandqOEcyc0dSWlJYR2tPcytLbFBiTlYw?=
 =?utf-8?B?MloxNjZhRVplM01ZNFB1QXBSMjJpTFh5TXUrUU1lZlVIM1hEM1JhSUpTSU1l?=
 =?utf-8?B?R1BFQlRaN1VhS1k2SWRiWVJRdGYySjcwTmFIT2VlWGtkaFhMK1lXbUhFd041?=
 =?utf-8?B?S1gxZEN4R0lKdHJkZmF3dFJKM29MWk5xK1EvMldGK1pUZUpDVWd3L2hIRElX?=
 =?utf-8?B?TTV6a0gvaUFHSjIrK3NEb0dHNlRtNjc2YzNjTUVvdmRySTZtMFM4cStERlRU?=
 =?utf-8?B?ZjhWaS9MWVRaK1lKaWhGcEF2VG1OT3RiWnpxcWtUcWY4N3BiTEplaXQyTVUv?=
 =?utf-8?B?UzVyK2hSR3FxcnYyZ1htT00vM3JGRG9SbFA5dXNpNXp0azl5WTl5UXgxTDV4?=
 =?utf-8?B?U1VlZ052OXhrU0s4cjZndGsvYzZ3cUdBR2IxUjNGNlBnWC9qNzFEdU1zZEhU?=
 =?utf-8?B?STd4Z3JRZmVXN3QrcEVnMzUvTitxTEhDclJnc1Jiai92QjV6cWp0dm90Zmhx?=
 =?utf-8?B?bFJPSGQ1V29TVytEY2p1Vi96R0RKQTBvVkVEYlhsMWJNWXcyQkpzbTNzWldi?=
 =?utf-8?B?YkJaSVpHSjB1YkRzdklBVGFSZU5jTnlaS3NlSms1UWJsQmNWZVo4UUZPYnU3?=
 =?utf-8?Q?i270=3D?=
X-Microsoft-Antispam-Message-Info: GEszTxb9uQPHeVoA253FFUKGV7lFm4X2w4ffxX53hg1BvrkW6zpTqE8mrFjsofZOOXBpQTOltWmg3le97oZ7h3xoEjQRtQz49ul0HURi2YsIk406Ndjg30qZN4aw1oMeTiXNevHxLAm4bSngrvm9DZFgTrGZ72BOHeAdv6/62Yis52212UguAYv0krHNkCbWloP6GBSK3CvVSd/63pSPQRGkjsj7awmEPBtXkltvwcCdukGJl1QG/KewJFYEET6ib4ZYavmjRApDF6POIuiV5tKWBWdtESC0XqpNOMxDYXwJZGY11+sQs809ReiHpYW8vTpJhpkaVMNw6Rz9ET5y3Ohq0FrQUzldDQtZsRanJzg=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0183;6:siWIqHn9izTSZ2XA6DHXO5vLwf4O3pyXkIwKzrNNmpWpTullQXaGCfNqx6zG3+ji9oq9xA7+WQ3hnzupCwNQ08oWvFMv6yllQt7VLhYhlcGxhA6Rs5TqAy4c2r3Qi6b16pXMN6/D6lnEOGIVw9IjYntgrjkN3dO4ns2E7za1eykPq/0Y2X8/BvKTh2Lt00BlFt5NQVjzEeqa5yGVYyT7d2oC9qJ2GV8f+v+vsBNAA0ADc9r+IqUQTyCFwKi9YndMYaHcsKM7yS8FoPFXQZ7tge0YXPQo5Ki1THbaT/xnCdLW3B2xG2z6E4cmPpN4Yvmm0gaVALUPk4JZll5k2eMoSvwNOMuVNO6+95swSQ7bFrvhTwMfncNpiKTQpSHRKAJyQP2BEYFPIeVCCRVuySTyW75j+/NSc7mbaXfKbTJgYsQlag6s2Bt9/i8eXfIxxNv8sU3wl/VmVxJTGhJp4TtOEg==;5:gHLDKNUzRifS03IlfzqfQ27ZpwEDVfT7wIHoJaBpTNSuG2SCUkckYubLjaxyPQNmmBnX5vV0wheHbVqsfsStWhBnvUdkqjz9gj8AEnwLsgy/G41yZ64FlsHIcfsfEZZeRxj9wgn5bKRYM96SJX+ySQJ9FBdr5cUusdn6hdvbI+k=;24:6gjl6gw/ysFuaP2/XJHh23D+nvuHhBAZOsau3ThnE59C9uRkQaYGsTrDkLQG4k3H0GWqTlWI2t2m/6No5i9PHPA7Dl91WhUROAVBGCrXEr4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0183;7:DAnORkvoZPU42WoYbGyAnz/FAKBQM4ki+faUamc4AO5QfIvDI2jelgIJS02LtYHUuJ/sAkJ+XB7jbMyXiMKkiKxKo2d70jWlsEUzjmP4bKAa6pkLG30/6aLl0IDFPQ1DTyZCmkuOxkSpwjw4CgBn2jwvoV7jRRqzVqdCLtgS62vu7K4By1oRb98awW3Sd7IqK8KRJAgth2x7DnQ0qTCEbIXliCvLQVPNz+VLPl53CRkJ6rdpap91vfjO56hRvw0s;20:Cp5aWJ5jzUlSv5dBZZkjvw7qApu3wZ1LIhvEiSQKxakeRE7lmIlMFKL0sC/kgmGVbZmDom6gHyY8i49EwOEC9Zv+vihl4NapCOX+R2zFZxMn/nKsysfTx/wWGbOr1MPX3iFNsDB2LLZJh1H9lRoiPjuX8YGPAFIAVvsUM1969lP43HVcqTnbcEzn1iz6BtAbVa4swxjaOMcmF5hrRtxnECMyA/kj5vbbt2Xf9LcYtJoVUGPieDfaMSp8hBRF1/2V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2018 18:05:22.7358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b42b1f1-e0fb-41ed-df41-08d5e1d8b71e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-04 01:54 PM, Gustavo A. R. Silva wrote:
> 
> 
> On 07/04/2018 12:51 PM, Harry Wentland wrote:
> [..]
>>>>  
>>>> @@ -145,8 +145,8 @@ static bool calculate_fb_and_fractional_fb_divider(
>>>>   * of fractional feedback decimal point and the fractional FB Divider precision
>>>>   * is 2 then the equation becomes (ullfeedbackDivider + 5*100) / (10*100))*/
>>>>  
>>>> -	feedback_divider += (uint64_t)
>>>> -			(5 * calc_pll_cs->fract_fb_divider_precision_factor);
>>>> +	feedback_divider += 5UL *
>>>> +			    calc_pll_cs->fract_fb_divider_precision_factor;
>>>
>>> This should be 5ULL, as the commit log says, otherwise it's still only
>>> 32 bits on 32-bit platforms.
>>>
>>
>> Agreed.
>>
>> Otherwise this looks good.
>>
>> With that fixed this patch is
>> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>>
> 
> Hi Harry,
> 
> I already sent v2: https://patchwork.kernel.org/patch/10506897/
> 

Thanks. Merged.

Harry

> Thanks
> --
> Gustavo
> 
