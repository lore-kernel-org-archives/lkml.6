Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D021C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47FD208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1QhZTVld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47FD208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731928AbeGaKqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 06:46:49 -0400
Received: from mail-cys01nam02on0087.outbound.protection.outlook.com ([104.47.37.87]:45152
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730449AbeGaKqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 06:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ucbSjijuMLyX287kM4ZvMrQj0PAdNDvbFskD6iZjKc=;
 b=1QhZTVldLswHs9VLRkamO8+wjHTHksdJLPRDSVTW0+1cT/4bwc6mHXh5oq9tCSL89NqDeQm8XmeavpdnQyl2IGfhHbVhWceXy6RMJ6wJIhHrNFg/7TeOO1Cl2iWCftmg+2GfgvGy9hnXte1ybtNhdxM1+QM4Va0g9fYMI8gIbB4=
Received: from [10.224.116.116] (125.21.194.1) by
 SN1PR12MB2367.namprd12.prod.outlook.com (2603:10b6:802:25::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.19; Tue, 31 Jul 2018 09:07:19 +0000
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-pcm: Use delay set in pointer
 function
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Alexander.Deucher@amd.com,
        djkurtz@chromium.org, Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1532686422-1790-1-git-send-email-akshu.agrawal@amd.com>
 <66c8b8c4-bdd0-0129-5e5b-850890cfdb8d@linux.intel.com>
 <e0990b62-897c-6dc7-8ac9-296932c505b7@amd.com>
 <dd4d3dc6-88f3-d53f-cd5c-5035c80be3da@linux.intel.com>
 <s5hy3dsviwq.wl-tiwai@suse.de> <20180730155030.GP5789@sirena.org.uk>
 <7a88c7b4-d31d-b044-bb8e-a866d49d1256@amd.com> <s5hwotc0y6v.wl-tiwai@suse.de>
From:   "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Message-ID: <5b3249cb-6212-6a14-b644-7548cf0ad00c@amd.com>
Date:   Tue, 31 Jul 2018 14:36:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <s5hwotc0y6v.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [125.21.194.1]
X-ClientProxiedBy: MAXPR0101CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::30) To SN1PR12MB2367.namprd12.prod.outlook.com
 (2603:10b6:802:25::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7a9da7f-c341-4548-7d2e-08d5f6c50690
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2367;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2367;3:yC8J00uHYUG912B5j3e4F/nh23Ao7OCoWpXyiY/AVKwXR92cgURe35VOF7j0b+kLPR0niEK6sEUBEUFHQOKWBHNJAejsYFXZnR5X3USoTGShqNJADEXYEFKxwTKzB3OO+3R5B/DmMYSbbHpRSotzWmudyIxvHXVThdQZrHS0mNbAGw0TFHvx04sVl/oz9uTybkqRnSvmYeyXQCec0afKUuP3BggIIQX4UKQ4IREhbvkTKdfzOTvJJqpNvZLSx0W6;25:NYpyk8wO2KC/1zcOXu75y7a7qQ/xXMQh626p4hMX0YZWVqIIABnjb0UbaSvGGpVg/lEIzClFnvOGnzqG8qPFA6HD8jYi+oU3B6Dy0LWTrUWtJ3IEINxhAsLx/INyow2uoyCsw1bjkgx/9WCP+A3yXLe9+pIFAx60zGQ+5yyDBZcwlgxXXSvBfszRUUQLPxsbXfARJYc8KrN9bxp/EuOdXsk0IFp+l3WiWmlj8LSlCt7aq3as5kLHY311PXqoKNz8X4/yHv0hdS64NTY8MoHhlpe2d2/dzcEvJfe0r6qMAIIce9scQ2YR3l6h5tmm82MpCBS+HUlTEdRnLsQ8DCox+w==;31:qe/pAGlGxfU9BD9XHMie6EaXwwmZCvPkeXcBtJDyrydgz2s4imU6XVYugIqIlnp7ZIcTsjvh1Uv62z9STvh/YeUexm1L+rvqPyt6G6F4C4CVmOiKxHaEKQA1n2YqBlVFwPVvEuWiTMXN5puMG+XD6G2mjwlCRWbRuY6ILxIl+yCDzSXx8YZFVZBxnMN+qS2We5qT2m+65IJoNim1gkMJwNIQJgeBP1IiDX3f1FM4RVw=
X-MS-TrafficTypeDiagnostic: SN1PR12MB2367:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2367;20:VeLIHYN1CEkShjJ+C6t5Zgk9KLn7e/6SO8op48cbH/OfUZbrgNSATqGvhslJDM9qSjf/WsnSgqyfDW5ND/SWRka+9/n+QEW4BgER6ZKVnklya0wiFaWbH2hIXT3V7R0fOPtBOIEPwLe4HG2X6MBVIerouKXcO9qYj4GGOx8iXYXhb6Q0ql9RaBwBTsm2K1TfnKi6Cq0MamRvUU6e0A2Bye44JMJAU/Z3UUnuySDFtExB5gdd75oYi1TXRRcznAjhh83PY5SCks2akXV+S9htOkpPED9xAgL7Nxvl2VrN38cuhy7HBP51OhJeeB23NPi0A1Rc63HynpqPOXSlxJpvZBW4cNLcSHhbs/uMDjjl3n2+f8vpjNJFJ0E/cEApMVdltyKwjku2vxYLGY0t4ogcku6P0VyH62tjkzpC7p5e0IpuU6nnpx0kdI+1JtcNlitUic1nDFY5qZYlkyYYCC5D7mj/C9EMzDBr9de0lEGJV2DWLDjn8nkaZl23CkWSedrk;4:I6yyyyZnqVlhJ3QOMjSmZ+ejX0QyuFX4duXpXSvobFYFsSJs71Gdjeu0DY2H2HzAcquraou2utjqB9l/Dfz7Z4cJiHOUEzdMWoob9fRGO6ZZKRi7x+Xpwd71dc7793bD9rfEN0NnNQ1m8HtT3XWdB6tLBRtiK7VBXULsSl52+GxHZHfOuzxZFtyW0VILCQ49fivGdSXcd3CbgIFOrkaysgvP04TL4ZwHnY/QqSqgXEtpa4a0lU9iyB6xf89ILqYiT2TZXJ1fh4j6g2+rus1Kiw==
X-Microsoft-Antispam-PRVS: <SN1PR12MB23672EEF3823325377589050F82E0@SN1PR12MB2367.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN1PR12MB2367;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2367;
X-Forefront-PRVS: 0750463DC9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(396003)(136003)(39860400002)(366004)(376002)(189003)(199004)(2906002)(68736007)(305945005)(486006)(72206003)(47776003)(65956001)(6916009)(65806001)(66066001)(6666003)(81166006)(8676002)(50466002)(6486002)(6116002)(956004)(2616005)(478600001)(476003)(3846002)(7736002)(5660300001)(23676004)(26005)(52116002)(97736004)(6246003)(52146003)(446003)(54906003)(3260700006)(53936002)(106356001)(25786009)(2486003)(58126008)(11346002)(64126003)(77096007)(16576012)(105586002)(76176011)(31696002)(39060400002)(229853002)(316002)(81156014)(186003)(53546011)(65826007)(230700001)(16526019)(31686004)(93886005)(8936002)(86362001)(4326008)(386003)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2367;H:[10.224.116.116];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIyMzY3OzIzOnpiRjVIalZYN29rRVN1RWtTcDRnMkxwV3dW?=
 =?utf-8?B?MVY1bEczVENNSVpkS1BoK0owb0tOTU5tcnN1VHJvZktBU3JOUUVJYlZ0b0dN?=
 =?utf-8?B?azFlTzJ0S0lCN1BHaEt5aEt6WklCNDV5elN4M0xybUdYK3FEN2Z1c1d0NDAx?=
 =?utf-8?B?Y2VNMGpKMkRuamlIaFFvZzh1OXpBOUZuVXorWDJvdmZJU3B4Qk9pUGNFMlBM?=
 =?utf-8?B?SmF0ZUdvTWtMRDJDV2dHb0hWUGFhZ2tXbmV1aHR0ZHdJdHgvbzNzZUVJNjg1?=
 =?utf-8?B?TEp1QURjQzdibGVxcDlmcGEwNk41ZG1oTzdXWXZuR0JhQldVb05HVE5leitG?=
 =?utf-8?B?NnpuZStQdzZCK00zNlJ5SllFRDNwRGl4R2NmMzRGbXF4UUtUczNCaG92N21m?=
 =?utf-8?B?UTU4WFJpT3duWjdtL1dFckRiR05rUnRUT3FUWk5meFhFdyt0eVI5d3JtQXE4?=
 =?utf-8?B?VitOR3NYd2txOXZuTGxYd3RHRFJJdGFNZmRtMytmanVTNG9yVERYWUZISU11?=
 =?utf-8?B?OEVUN1hhSG5pajYzWWRxY2VaR2Z4Z2dDQ1JFYld2RVhFTGlQZzhQK0wvbnFx?=
 =?utf-8?B?bmVwc3U1Zis5VHowdnEyK05zYlVscGRzL0NIekVIeWt2MGRna0FyOGY0aG1K?=
 =?utf-8?B?MnpoemtXeC8yWHE4Q3c2V3c3SndZaWVZNjJFd0ptaXpETGZsRnd6QnJidjZB?=
 =?utf-8?B?bjVEYUMzMHhJa0lMMDFnNERIWktmakp4bytaaDZSampmNndPQnBCbUVKdHdP?=
 =?utf-8?B?RmJ5UlJUZE1ia0VvRldlVDNhSlZxUW8yVWRyVTM5Z2tDMWU2K1htb0JjZFla?=
 =?utf-8?B?SXlIa1FINGRORTZMYXRmOG1KTjhUUTFvT1pzbHJwK05xL2pzZktEekRoN1lX?=
 =?utf-8?B?bUVnbk1adnVZdFZqRUZZcXpKU1FiMG1DSDBOc3NVcnB0dURYTTVxUk1DcHJ1?=
 =?utf-8?B?b0lXbGw1L3JKNUdaK2NyL2JBYUJXU2xVVWhBZW5PVnIyQ3BVZ1VJUld1YmF6?=
 =?utf-8?B?Q3MyVm44d0VZcjE5bGVUU1RsRnpkZW91TmRIQW1SWkNYS214Q05qd1pJdkNo?=
 =?utf-8?B?bUc2KzRRM2kwMlo0bWRxYWF3MFBoWXUxZzRNRFZNb1IzcU12U1VOUXpockdP?=
 =?utf-8?B?RGZ6K0hCVVhLUEpybXpqZkNnakZzR0MyYUMrUS96cVQ1UjRnRUtkRGg2THJT?=
 =?utf-8?B?UlNKVG5HNG55S2Q4NExBcmkrRGdEMUZzYi8yOWZiNXFIYTlwckdKblpkbTJH?=
 =?utf-8?B?Q2F1MkxWdTQwZ1FFMU5zZGNvbzIyelUyWGdhZjNja0oyRW90bmM5SmZxS0dk?=
 =?utf-8?B?dEZFMUlOdlYxbm5Nb2k3Q1BkTVduYVZ1MWMrcnFLdlRXR3BFTHdySSt1RlRu?=
 =?utf-8?B?blRhaDFYay9LZEhLa0lJbmVEb2htUFN0K24yOXNaYWU3dUI1MW1UTGJTZzFI?=
 =?utf-8?B?REd1cUlMSUVSUzNtTVBPNjR5SEpuNFJXbGdrY2FGNFVUOUNackZMWFd1QkVo?=
 =?utf-8?B?a3NFT1FEeUJDSVhXci9LMXU3cmtmK1UrSVc0ZUtPRnFBMWFITjVsYmhWQ0lZ?=
 =?utf-8?B?dC8xR3ZndytrOEw4bFArd20zVDcyekRkVkNGRGtGU1R3Sjl2NHN6UHRDaHov?=
 =?utf-8?B?Q3BzaFZCZmZWZy9rNVJKZUlUZlFGdUo4VktmODAyU29qVllQNXhuOTJBaHpS?=
 =?utf-8?B?ZTlMUG5mSVNlVE14RklSYlNwVkhxaStVWWEydDU2OXpNYU45UnArcS9kZ0Q3?=
 =?utf-8?B?Mm1HTklUbXB2NXd1Z0JSY0I1bUJGOHNFVWMyQzhDTDVCdk14bzNka2FYUEFB?=
 =?utf-8?B?cmVKZGNqWlJra2VpWDAreGpLMkRkb3VXR3V1VTIvMlMyeThtV0FTSHBlY2Y5?=
 =?utf-8?B?dUk2b3ZrUW41aG5tOWVLamZHVmZ0YmdRQXBMcm1iZmdUL25YRTl6cEpDT2VU?=
 =?utf-8?B?djhJSTd6TFkvbVBZZ2h4aUN2YkhLTFRqZFJBT0hKWGY3aHhsMXZ5RWVSUWhJ?=
 =?utf-8?B?am5IdDJjVEt1Vk1Oa0VsQUJoTkZhbnpLNFRDUXVTVnhkSTNOd29VMXpmNnht?=
 =?utf-8?Q?xHqI=3D?=
X-Microsoft-Antispam-Message-Info: pcbqrJq2u6iKMAbOrFA5toWCqtedXQRwpXm2stGYw2awh7/oHxTMoPlnsQktJRne0obDDUMnlv/CV+jQG/W06H1yS0tnwd03LA5cBI4ixca2vEPvzGuz9fup5YDbIBRM5pdGjS00GSjZNRAjJVxbT+pxDmU87GdMr86PN4oNTqr2KAGv2n+QHrkDEwyccIAM/RLRmnbyQnir6ylgAJC089lqweEExYahircNzenaWuBE+37kLztUU/QwNauQb/x6hYiJMhOq0SlbEcOnDBy/8B8htfwpgcdSMpRoY6UsAJ/v6byJBfUD9LhCk4PWsI81QlQHkvl9xk5wdTm7ZMgJHn1cY8fKO7JqtM7J8SUkHDY=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2367;6:gx5B2GtjvU9Ce7A9JCc14lwaY0Sg65INDTbj+TFM159cW/D3QVaKAQkXZ1jm7yWjTCkMGOA9bHh7/0HvuzM3mKut90f8X/lDyk6IYg1Z/kjWopxBCK01tCKAG6xQoqAdZeGOTC/xX1foXBFEdPdIM7szkcczmhAtewAWK+EZVUoDe76YASsdnvtbSgkqz/Q1aVQv2vb8uogvYaG4aJtqCsVQWUqiue5ejZTSeFXeaxMvUQdNqhWYwFrQaWUnqdK2dnnOZ/KFvkT50p03rZIUolk9kvWUCJMo2754NlyRfZEkGQzF42+QRFI7Zi4VV/HfkkYvqmJaE6JqEHeYKZXMTc7WH/+l8Y+b0myWbYN8ihzBgEcOWg/O6DRfrsAn7IetJWnrcfgQvLBoaELgu+gms3TI8zhhXNeSnPUlnHlkHnVnGYoyzlAyegnRWmJdYj3N70PUP68ZWnW3iABnYAgbRw==;5:9Pf1Ls4z5ckv1Ltn0PHFBAxj7yfAc8Z1acsJmCcMmHbYtVXQQeUpULrebwEuQDAHGLf4AE7q7ikHX4HKwBYpk5I4jkVcyaOug2+l4ovTafZlwHKUvVuSpPYG2KhGjroa8CgbyP5iwipZuTB3/xrP12RzX/m5LxaHuCeSwWv+HWA=;7:Dp6BynN6sixIg6JB+Di29kxazctroeB3PrXTnK/6FKTVPz2g+iFNTVL5ft9MrjhSBCbYujX2x0hZ2048XHknj1iAgAFFp4UDXNV9bje2iOLDK3dX6U1qPpXx2XAak0yKPZVahyTWPjTsAsvBJsHpbMNvTgoAb6dbdZoJL3ZqsuTNdtb/tAMw6rN3jqq4T5sqAj1CiSoFwl5LSkxQa8tlrBgkk3JGZ+tcPf6AKfwRSmV/09wVpkW0cPHt7wurLFn8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2367;20:NmyWC5/BQXqPKpoDgM1S5af3jdp7IcVujZMuXl281SJNLBmifMvJXCQH1RpAQS/vXqK0SGtl0lFVWfbl+valaVpTRwUotPvuWheQrkox6rbYlHgOhzfUuqqNFOgbf0wi2IwMCh/UKC3uiAnvw7Q+joq4yb6mfxYOZKAb4RpTruUwvRNLhbGQDklGRrVSg1tIqINinBQv+fWr26S6/ucjWnk5vvvn5sIUHRkWdmBNtuhnAmVW0aZiPe5h8ctA+WD5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2018 09:07:19.0003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a9da7f-c341-4548-7d2e-08d5f6c50690
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2367
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/2018 11:00 AM, Takashi Iwai wrote:
> On Tue, 31 Jul 2018 03:25:06 +0200,
> Agrawal, Akshu wrote:
>>
>>
>>
>> On 7/30/2018 9:20 PM, Mark Brown wrote:
>>> On Mon, Jul 30, 2018 at 05:32:21PM +0200, Takashi Iwai wrote:
>>>
>>>> That said, if delay callback of CPU dai provides the additional delay,
>>>> the patch does correct thing.  OTOH, if CPU dai provides the base
>>>> delay instead, we need to clarify that it's rather a must; the delay
>>>> calculation in pointer callback becomes bogus in this scenario.
>>>
>>> Part of the theory here is that every component might have a delay
>>> independently of the rest and we need to add them all together to figure
>>> out what the system as a whole will see.  Personally I'd rather just
>>> have everything use a callack consistently to avoid confusion.
>>>
>>
>> For consistency we can add a delay callback in snd_pcm_ops and modify
>> the drivers which directly assigning runtime->delay to use the callback.
> 
> No, ALSA PCM ops definition is fine.  The delay calculation is
> basically tied with the position, hence it has to be set together, and
> that's the pointer callback.
> 
> Judging from the call pattern, the current design of ASoC delay
> callback implies that the return value is more or less constant, which
> can be accumulated on top of the base value.  So your patch is natural
> from that POV.
> 
> OTOH, if the CPU dai can really provide a dynamic value that is
> strictly tied with pointer, CPU dai itself should provide the pointer
> callback that covers both the pointer and the base delay, and it
> should be used instead of component pointer callback.
> 

Not sure if all cpu dai can provide the base delay and thus require
component pointer callback for it. For example, in case of AMD, it uses
designware cpu dai which is a common code.

>> Apart from the 2 drivers mentioned in commit message I also found
>> sound/usb to be doing the same and its delay getting lost.
> 
> The USB driver hasn't been used in ASoC, no?
> 

Don't know, was looking who all might have been impacted by this.

Thanks,
Akshu
