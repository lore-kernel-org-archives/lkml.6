Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DBCC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0BE9216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Jf7x6uai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0BE9216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbeHCJJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:09:20 -0400
Received: from mail-db5eur01on0103.outbound.protection.outlook.com ([104.47.2.103]:45129
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726792AbeHCJJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiI56SFoyWwoqorunYMCQMhj4dAyZ6wkOh1VlNwCf8U=;
 b=Jf7x6uai70ggO8FwyPg7bftZCKE0r63C4fcrItmi4jF5GXffUB71G8VhohUq1BSh68Ihs9gfOaLQODG1lSYhNOBtGkkx8XK1jSWdIlUJ8aIORWQfkHEVWmjD0s9AnW/ZUfMAe55Mp+i9T4dObQtdAp8jB6U0GpyDWsY/MQAUDN8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from [172.16.25.169] (185.231.240.5) by
 DB6PR0801MB2021.eurprd08.prod.outlook.com (2603:10a6:4:76::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.14; Fri, 3 Aug 2018 07:11:35 +0000
Subject: Re: [PATCH] mm: Move check for SHRINKER_NUMA_AWARE to
 do_shrink_slab()
To:     Yang Shi <shy828301@gmail.com>, Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Huang Ying <ying.huang@intel.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Matthew Wilcox <willy@infradead.org>, jbacik@fb.com,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <153320759911.18959.8842396230157677671.stgit@localhost.localdomain>
 <CAHbLzkpBnNN4RBMHXzy09x1PZw4m5D99jANmjD=0GT=1tkxniQ@mail.gmail.com>
 <CALvZod6cUJktTAGrc-q7XPRTykdWR6MfgyPXE1B=AZq9U7P31g@mail.gmail.com>
 <CAHbLzkpexLdg=eEudwxV-ztF81gs2a4HeyYb2zeAWZmV45ja4w@mail.gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <58099219-edd1-e855-4660-30de1e1b16fb@virtuozzo.com>
Date:   Fri, 3 Aug 2018 10:11:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAHbLzkpexLdg=eEudwxV-ztF81gs2a4HeyYb2zeAWZmV45ja4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1P189CA0035.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::48) To DB6PR0801MB2021.eurprd08.prod.outlook.com
 (2603:10a6:4:76::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40118333-a270-45eb-faa1-08d5f9105a42
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB2021;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2021;3:0PzVn8JIqMwCogP2y7huzyQ+2sjAi35wqhB/q2J+qc1pLpxechWjl2kwlKttaDiRuEEYZcuYQO0RTwAVYRU4SWF26ZA+U/CHLqubRfkLK7zS94LjglSCmxsm98t45vB/fkfpDpgf82gbHV8hb1T8qFb+an3oCwEhzT9ZvPiMzw27ZiBGW3xwbnOvRR82hvcblB2ucAr+zajnsMUtxJ9zmgxOSaK6i0Ky7lAnNWyMB8gKtuL0jEiGXn7PzENTDiCy;25:j6qHS5C1Xt/kPgXIwwz+w+VYdThAggZFGtIPKPfATxVQts2zn4F2VkvHvvQ5r/0fxET7dT/tVfcjCkSs7YAANP/eHctpYvmWn0bZoZXxUwoBTjFL8N9+abMXKmP8n7hFytzW7B/He+vdru0zqaQ08g4Fop1lx52bxAj68Twh8Z4rYpAZbZCMhMiWWNfPoH1W1RVJgOpRPlgmLdpiKYKS6ZmwlElaxv6XxwmbHpQL/fHQT2bQU7a3rLpBmng9BPbDEEQpcf2Zl5WifBcmxjm1qeGAtpgsnMjCUd2aHKpRi8c4rxPsjlaITyBx1ji5gOswF1A4i9+U5s12R0T1PaxigQ==;31:nK0kB8T+Ms7EpWNmNI9JXA7jw0fRaKWzz7KbilrM9uEAWhjCGeforQdoJ//tGVCfLWWov219mu3JyOiIRbbJAvZv4WKLfPu8AR9HwsKbGDka71k8DTtYCjn8CU98c9ZE+35zJIvwAxaA6V44rbRg8ETNyfX/zW7EM2kP9IlNSuXFz8hN6B95c2LCZC3v5AI5VRSUQ85Of7yuirM/9wVZZY2FKJdL3gRWICgG2jHRppA=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB2021:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2021;20:voGTuCG6kB30pyj7Je+QomLS54jA0l3QggKjRbxVIbHalT92hLAfoB9ZsonGbOqwhgqr5JL4wlQKmpcr2KQuwCLgaL9RfS7t4vYW19iq6ilIJ3wQJdy5zoOsRZs8HSk92e3yefkogSecJHoT0y031PvleXVZ32a/avW0fzExdn0yZ3b5bSiGZayAVcwRMFDZehOrk3WTLz7lZzoDuNIsppJ66XGfO4qfPe6jgnlvkRpmxlTdKPG78KfQL8DBR+D+l8ixKMnnjBOg2D1EyV7jA6CIIMRgVWOJeYYTKzV6d1Z61++juBXARmdH5mRw5rebfmhusPqrGesOo/EX3E21TyZhDwozdQdTj2Y1Isxtp33kCfpaw3YkdPy/8oq/7/PirzyQD/46Ic4S6j6R/QOzXqEHMHtRQ8JEvcISGYtsYOmHov3Uez3m8aYe65o3Fz4mu80rx5MksRIr1sendCgZDSezzeM7IytthlJmrBw/+gL5DrmWI8VqG/ShHcIY0Pn7;4:itPpeoG2NBenKBTcY5y6YN3sthmGkOSBLHKREyqkxTfkpvHGC/nEnOvOvHO8UiE0kooujncmDbA2KwCzhJcWjL8kY66lD2Uab51gnVKIAOij88GzGB1jUX3RvjHYPr44c7zrdb+HcwPOmB7bOlXY/H7WdZc962nGuQezvRsUuwDIARh8Gsie1d40/UVyibdNOsMnOcYrJPO5W8Nf4SOCAm3qSjj9Vf2RDPdQ/K/3Ht0sdUXcY31lO+bxTLwov9QAdjuNEwBmFMAKyeXkRPAH51fhyCxDNfrTHX7iHEN1UbBhyLS0j1PkJtl0vCjMpjAKZzgO5R/InVf8TR4cvuprliXEV07y3PwglKXwktbOZoH6q0BJg0KQSNj6yfGWfOXy
X-Microsoft-Antispam-PRVS: <DB6PR0801MB202155B33450824DDAD6C1FCCD230@DB6PR0801MB2021.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB2021;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB2021;
X-Forefront-PRVS: 0753EA505A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(396003)(366004)(136003)(376002)(346002)(189003)(199004)(2486003)(77096007)(66066001)(6666003)(446003)(16526019)(110136005)(6116002)(229853002)(86362001)(16576012)(11346002)(2906002)(230700001)(3846002)(316002)(186003)(81156014)(64126003)(8936002)(50466002)(386003)(53546011)(26005)(65956001)(81166006)(76176011)(25786009)(36756003)(93886005)(52146003)(65806001)(54906003)(58126008)(23676004)(31686004)(47776003)(31696002)(52116002)(105586002)(7736002)(39060400002)(6246003)(4326008)(8676002)(68736007)(476003)(5660300001)(478600001)(65826007)(53936002)(6486002)(106356001)(2616005)(305945005)(956004)(14444005)(486006)(7416002)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB2021;H:[172.16.25.169];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjIwMjE7MjM6d2V2S2t5dStuZC92TU9RVDJ6bGhPMTBl?=
 =?utf-8?B?RHVMZUQ5NDBNQ0RPSTBEVGd1SlZ1a0QwdGphNVdRRE8wWTA4Q2lhK2xGNXJN?=
 =?utf-8?B?bjhpWjBaVmU5ci9aSXNrZHRIUDZ1cnBTaW5XU3pqL0lCSlZiVUgwbURkWnRm?=
 =?utf-8?B?VWFpZ2NEMkZWSFlSalpxbkt6R0R5QmpPR2tEK1NrRXl4VU5QdEZlUVc2aGpM?=
 =?utf-8?B?UGhTYTI2YVRxOTVqdGxwZGNSUWNIcTNnUFIzdlZVcHFxcG45ZGhZOEZVTFJr?=
 =?utf-8?B?Z0RpWnBDZWpLVHIvSS9GdHR6SW9ncW5iWm4xY1B4UGxNR212WXltT0QzL1pH?=
 =?utf-8?B?RHlRUFd3MUJlSGJZUGJuMnJmVGVUWGlKeHVxay8yWkptRkVPd2FCUkk3b3Jq?=
 =?utf-8?B?aXliVXVYdk9md1JWT2ludEZSbStVTDk2K0FzYXN2WitSVjRvMk1maElZOTlt?=
 =?utf-8?B?OFo2YVlLWmx2cEF3TzVTQkdmRDd3bWw1SG1rM2NuVzZiUUcvcWduTTBEY0Fy?=
 =?utf-8?B?bm9Qd3NDVVdYNGlyL1Q2MXZncW9LbW5VTnZTYTJsYVlmOUpNZ2oraFBJVnYy?=
 =?utf-8?B?YUZRMGs2UDVZdktabzkyKzQxVGNvMXljb0prM1djWk9NaUZ0MGdXZ3MvdDB2?=
 =?utf-8?B?QStjNm9JREFlaCsyalYxdVdHb2VpYXNoVUR5VmN0R0hudW5Dd1lRYlFVUDJz?=
 =?utf-8?B?N1ROb2JYYWdsenR6OXJnMG04dG5nV3lYWVh4UnBRYjlqaHVhZTlOR3BnemEy?=
 =?utf-8?B?T3ZIS2hvaTNYRjF3WmVZdnNtN1l6ejVMSm5jZVlnSEhEZ2hUREZpQ2NGTGIz?=
 =?utf-8?B?RjE4Ymt0TGVqNFZtZkFpbjEwenBGcnM0czRON1o4UXZPOFVMQzlmUGVTTm1E?=
 =?utf-8?B?T1ZRQWMxME9GczMrQ1V3aFVSYlFsNHk2OElUUm9lMzVOazNOcjZmaTlTczV6?=
 =?utf-8?B?dTBqUHBJVXRNVERxTnA2WGE2aE1lWllwR0k1NmprS1lDS0JsNVNaMkZmTXJy?=
 =?utf-8?B?SEpSOVd0YzdRSjFLZXBnMXB2UXNLOXpYOFp0R096ckRaODBCWktDU1AxSW1Y?=
 =?utf-8?B?STZ6TndBU3pteSs3V2tDWG9aSlJaODBUOFJvMzlyS25oZ1Q0c1RYMHVFUDEx?=
 =?utf-8?B?Z3F4Ui9nbEdCb00rY1U4Q0pqd3dVZTN3TnliY2g1L09kS3V5U2J3dm5xd2Q5?=
 =?utf-8?B?K2dXdm93c0lLQi9PbGluWjZUSmlRTHR5N0RPYkhRRjYvS3pBVzlDKzN1c0JN?=
 =?utf-8?B?NHM1MzV0TkxDSjF5bWdabExoRDF2RVlvZmVYaGd2dWVhaldKcGJrQ0VlUmM1?=
 =?utf-8?B?c0pRNnJyWkY3Yy9WMmRCRWpTeU40N3EyR3IzUW51WVVoMnlyRFRRUno5TWVG?=
 =?utf-8?B?cU9yR1Z4NHp5RWNCNEQrc2EwZ25YaHFNd0IwcndLeVZFZC8vbm9obU5mMm9J?=
 =?utf-8?B?WHBlbXNPR2JWYWEyQnEwdHczVlNFcVIySFVCc3BqZnlwZGtCVnpOU0Fzc1JQ?=
 =?utf-8?B?d082Rlg5YlhLb2c3YUU5TlRFTW5qOUhYWUc0aFhKUWQyNHduNndaaXl4Mnhz?=
 =?utf-8?B?YnMyS0g4bTFZaVprQ0UyQ2dWN3hIb1RTUWVKOWhXUkVYS3JhQnZtN3pGRWRm?=
 =?utf-8?B?OStwL2FIVU80QUE4Q1o1dWtObDN4eU1JbHhMQjZWNmhVVmRuYkRMU0piL1NN?=
 =?utf-8?B?dmFyeHdBelhXYzR4cEY5cy9JTExhMjJHRTB6R2xHZWRsZHBPVnRJK2hkMGhu?=
 =?utf-8?B?dXRGbDJwTEtOZVR1Y1JaMWtGSVpoY0YzMDNWTkFIWjBKUE1XWWR1c2QrY1Rn?=
 =?utf-8?B?dWRjblgyK28vWThKblFaZkJ1aG8wSFNndTdybnNPUDlRRk5QdHFpSEtlblpG?=
 =?utf-8?B?elc5UEZ2eWp3dEdPMzFhbVpTQllMQU54Mm5scTlDN3dtelF4NWt2NkhZSElp?=
 =?utf-8?B?Wi9VRGZXUkJkU2tuZGF3WXFURzliT01PYTZudm0xVHZvakVIUkxwT01CSGNE?=
 =?utf-8?B?RHdyTXRGZW1wSmpUNnpnWUVtWUFmSlBQcGhkV2UrQXQ5YkcxeXFWTHNPSHF1?=
 =?utf-8?Q?mMVVi4=3D?=
X-Microsoft-Antispam-Message-Info: Mt2tFjyzDrPs4nqV+9aHjQJEOxLbrEdfg+/Aw622a1N79QrgQY7dAP4U1pAGoUorlTMYVY+M2BeaEi/hF7xn8nSnCZUA3Aq9nKqZzUKpkTPnh5hiHJyI/85LCd9FzfcbxqBCQMR9xcPu/xtPmm8tij7S26lvXJ5xfQ2EtVcMrFmYL6tl8tu0aJ8bplDEP44W0vzrAb3gOiAT4tPNn+XmkVz1jWUQV4FMWmzYqwnfMbFIrnGJA/DCKJqrZwlfSQZE8vfjXMPkn8JZu6LnfX+mM7AFjBM30ZHzqtR+Pjzfnh1WvwLPXE+yKb/viZct7ekh8fSm74RZxi6Ih1l1LAUiWAVTe3KopasUNK+CloqUDkk=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2021;6:XsdgnNr1RffWP+2zeUS/XlXaF3YdU8clZIyFAKARhvrOwY3Fy/Ydrj+TWQg3gerWyVHunnSqC2AiuSli7IA+gypd/CIXC78uctmQeoHAkCnbow58ofHQi5n1lxxZlwFzZ9BUMwiBiSzOzzkfdBKClyacc3iwhSCFcm7M4jXgWyezrEMAvGw6aeN6ik+0d3Y7OTiZ/cIuLz7obM4sXKkteuFpj6t/f3zb3h0bi8n8PFWC9j1725gkm72kT/0L3k5PpbIyXvRev+mSXpM/M4Zb/PfOoxdhsK83zpr1bxmiajMVIgirsSI68ZuDgwzsfS3Vjdz0ZI8/tnz9pcnz5S8/HNKte2Yzehoj4QWd2uq0a+RGhKpBUU/tf+1u5TkV/qIy6aRosxD8K/SqCuqBpp1eSyfUZ0Bl0xr4AFs4QM4YUaHGG3d1+VRzrNSkqRS/v4NPcRHMuV517/wDdEv/RqZ5rA==;5:DWnMMomE1EyaesU2ZoduBbSGgLxjoYxS6RtpWSWcIJp1uU4ZHagl5xW5d8YCfhg4r1BkYtcWTaTTs6IKdyXm2jigaMEXSEWfahnOmhmHruSivRd+fmr+yD8ResfLMPznm1JcY34Ie0cVThNKprZ24R3/iCZWsySh4l4RAZmquWk=;7:7QCTSFTeLM52N5yoL5Pjy4jqSqVeKQ8X5Ia8hkzXs99SY1WxxlrlWFyJxrdvjzeIb2REAfiyu9/Zwc3/fVBGM5Pa56wzV6U+FvNr8br4dj+SKLXtJfOhcOKK5kw4T1LNKcJvgoFw8jwlXlQUlMsfkrUevfR4BgPkTI7JWrqI2hLoXqLCoUvxTVYz9xo+lvXttNAqhKkgvOvP1BuypKUVsFyelTfQzJfu/HzusAM3ECVlz1Q9KMUIRc9Tr6FU5hrx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB2021;20:+n6YMd3BNvGUl9z2C+ftnYH6cBFDEaECZwo1uDz86TjGBsOwlkYgO4bxmt8m+I23h2X742w20+ygP0uxG17g6ISPjljCHv6ITmJSOk/MLK+7oyGWTMY2r3mndsKtTYnVMI6cLcB+Z3D763Eaq7NVKnNisX6Rc0U3n7nPci4X+TY=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 07:11:35.9014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40118333-a270-45eb-faa1-08d5f9105a42
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.08.2018 20:26, Yang Shi wrote:
> On Thu, Aug 2, 2018 at 9:54 AM, Shakeel Butt <shakeelb@google.com> wrote:
>> On Thu, Aug 2, 2018 at 9:47 AM Yang Shi <shy828301@gmail.com> wrote:
>>>
>>> On Thu, Aug 2, 2018 at 4:00 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>>> In case of shrink_slab_memcg() we do not zero nid, when shrinker
>>>> is not numa-aware. This is not a real problem, since currently
>>>> all memcg-aware shrinkers are numa-aware too (we have two:
>>>
>>> Actually, this is not true. huge_zero_page_shrinker is NOT numa-aware.
>>> deferred_split_shrinker is numa-aware.
>>>
>>
>> But both huge_zero_page_shrinker and huge_zero_page_shrinker are not
>> memcg-aware shrinkers. I think Kirill is saying all memcg-aware
>> shrinkers are also numa-aware shrinkers.
> 
> Aha, thanks for reminding. Yes, I missed that memcg-aware part.

Yes, I mean workingset_shadow_shrinker.
