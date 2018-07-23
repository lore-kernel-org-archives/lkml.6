Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEA0ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC6920856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="KftyVuyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC6920856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388299AbeGWTOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 15:14:06 -0400
Received: from mail-he1eur01on0078.outbound.protection.outlook.com ([104.47.0.78]:5462
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387907AbeGWTOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 15:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4l7/sZKFV1cgh9E1tbpDPPYvCiMmrV2AST665VuwSc=;
 b=KftyVuyVcHLOQisWQWN4yRZDtGH2BQg0evee97nqTOK51WWU6f3JX9AisJKB6H8VvV07bYmLQeHdYP+y5noQZ3Ss5xyIlWdi4aXsHfEzwAPowjkDoXMr4Cbdg/cleiolTd7roRkRkbxHR2xwK4S0vKk8GlHamd/hXl1urcWLNVo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=danielj@mellanox.com; 
Received: from [10.12.146.131] (208.176.44.194) by
 AM4PR0501MB2258.eurprd05.prod.outlook.com (2603:10a6:200:53::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.16; Mon, 23 Jul
 2018 18:11:27 +0000
Subject: Re: [PATCH] IB/mlx5: avoid binding a new mpi unit to the same devices
 repeatedly
To:     Qing Huang <qing.huang@oracle.com>,
        Or Gerlitz <gerlitz.or@gmail.com>,
        Parav Pandit <parav@mellanox.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>, gerald.gibson@oracle.com
References: <20180713235021.18141-1-qing.huang@oracle.com>
 <CAJ3xEMi5zF83aA_SWfYT+JtWGGhqRhLyTKe-qYwevSBLuiK=cA@mail.gmail.com>
 <dc4d502c-bc3c-46e3-a984-41271951a5f7@mellanox.com>
 <556984ea-c35f-197d-0e45-16272da3f604@oracle.com>
From:   Daniel Jurgens <danielj@mellanox.com>
Message-ID: <f2a5d82c-f65c-152d-5545-0d50a4e5e150@mellanox.com>
Date:   Mon, 23 Jul 2018 13:11:12 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <556984ea-c35f-197d-0e45-16272da3f604@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [208.176.44.194]
X-ClientProxiedBy: MWHPR19CA0091.namprd19.prod.outlook.com
 (2603:10b6:320:1f::29) To AM4PR0501MB2258.eurprd05.prod.outlook.com
 (2603:10a6:200:53::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d300fd2-50cf-47a7-a77d-08d5f0c7b6f3
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR0501MB2258;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0501MB2258;3:4rq39SVqjwJ3dvF09Yd3sctuUfHuCmcdDtLz6l+N+quF+LcDCz2Qr4H8oafAlFK1zwk/J8XEEw6vQNJlEYoAItrN+LgjbnSXU/qpDGWFTCVnLg3mt0hS09LFiaduCKiVgw+b5V/u7dcBctwDUZo7PAG0fw9VpuCaupw9NaxyRdrfYyOmPAP8UocNKNaS2sdZ/rlFLSfhpcYgl8e7k4SiQHiKqUfunVNf4aVe2aEiEffMjhmVKsH6jjOjBv/xsc3r;25:fJwVmZlvSJS+WADScUiFCxOHtE0yoCjNa8tv6wobkwz5OevWejHRKXZfNx+nPE9RdhnjeU5Wsp++woC6gvpKXItYnHsv7gJIGnDzCfssiHkz1iKpWpbCu7B9IN3lrXLPDN0L0O/DjM5lVKNmBVhk6iVzfFZ1RJeQzx5SkRmxKPdRiTzPKo5gVJUvyz1lTdRFkJKU5y/K/A0Vvv38XNmYyiY/0Bj0Eziz5cjjetsC2bDxgo5PEpSAThDrN0+qrvkeO1qbFKJeWccBav2D4rhou2xWzZj1QUtcB/OoHMODPhlaEBgJi7ntpwnLsmvBRR9dH9bYiwnU+7zRP0hnLcg7SQ==;31:ySEm3kie1qd72n2MBsKLkRqz/V1ak9CCEMXcyj3mhy/lFrhPR3IM8OdRfLwMo3EYH553JAAVg1KNM8D74xGXh5Pv/UCk1HThEVyfFn3LA0hIbpq+W4ZTm+SBmLUV8NDVJtvb/5rnxMpDB/K5rCggp4HXFuYXcazDP6pVf2yHM4R5QMN0t3COEobjPrWw1u+XDTMLAOaqysXoWEBqbCZNyp9Suc2UIpAC34kJOwqdgHc=
X-MS-TrafficTypeDiagnostic: AM4PR0501MB2258:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0501MB2258;20:bu04h/4jT8PNk98Yo3Ir65jR6jYI6FWcUMl8azybj3aXXpt+iCb4U7OCI2sIgHFwqFP8LvXjyaWPm8pWYoocdDQYyXzMF3KfygJRmTAFUgO1k/b6ZZNQWU3/k2ZvlTYmfWeMWb62pAhn3D8CVYSK/xuEUN5T3kf95VpuqVHtMhHWKbB5pXhMlx3GCClC9o697Z+XvTyz8pyO/RpzKnp5EiHOZ+/tr6XaObP5/3zyybXWFCWgmBocXbxNWgvRnnat1ineupJQIbei3R8ETSx9sWiZUeSm7auprVf55NsNlHo1QqASJ3vdIRdsZGn7g38XpCgs9NMqv4g8xcmFv2LVbiXn6j5lQGx1WSaa3Hc0qPU9UJPnz8rZcx+yHEtbMq8f7rSM8fP+Ctp+tgsqd0qQcS9U9qIgKnHvisnA3G1496sW6s5zh9LID5A8cIoOnsa9kl9T+IFScHWblZOSnYvNquJym0nyY+rL2QdGqmQPPKePZXx1JyKJnkIlfkAL/edy;4:PnU3SSBqiSs1YNBAW+yWSfZgLDV3FefSWVXsJs9VkH3EjOR3Lnu97p4+JsRcON8jXADGsl2IqLUxhrDD0Y4/mm1JqEXfOEdOL1H4auSRIHZFe4DuWD2mjhXDdHvrfTFrBa9qbpfSpzgx76nqOxHoTRqbCyjF6DS4lcz6krlAYrqOVQM0Svu2pOjNLmJqCRLtMTveaataRyqGxpdQvK0ch1vBptAYTIVx/CTVe4p6pSVFjOTUnl4oxjXrR7XYUMZ802hP1lTJNATgzIJMFzpn9IH8uGOoZzV+m71ZsslFYnAny9OpqYcf/wBZY70mtxGOkE0bexC2D0IH1cjeHwO/BTyj7CX/968HiK2wUWtdxEU=
X-Microsoft-Antispam-PRVS: <AM4PR0501MB2258CD23595CBF02D98CD9F4C4560@AM4PR0501MB2258.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(146099531331640);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM4PR0501MB2258;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0501MB2258;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(376002)(346002)(39860400002)(366004)(136003)(199004)(189003)(6306002)(53546011)(229853002)(65956001)(386003)(6636002)(66066001)(2906002)(39060400002)(86362001)(446003)(47776003)(81156014)(65806001)(64126003)(81166006)(6666003)(6246003)(5660300001)(93886005)(6486002)(31696002)(6116002)(3846002)(2870700001)(8936002)(11346002)(68736007)(31686004)(65826007)(305945005)(76176011)(8676002)(52116002)(26005)(77096007)(23676004)(52146003)(2486003)(14444005)(97736004)(53936002)(186003)(956004)(4326008)(16526019)(2616005)(478600001)(36756003)(106356001)(50466002)(966005)(486006)(25786009)(16576012)(105586002)(316002)(3260700006)(476003)(110136005)(7736002)(54906003)(58126008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0501MB2258;H:[10.12.146.131];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjA1MDFNQjIyNTg7MjM6UURqaDFtektiQnlZb0sreG5oaytsWTlh?=
 =?utf-8?B?QXdaTlV6VlZiZmdDNHZHQXhId0Z1aDVtVlk2WkJ5bVpSakdtN21ucFBEZnlk?=
 =?utf-8?B?cHVZOE1vU1lxQ1BqYlVDb0oweDlXRDZ2Ynh5c09hZld3S3JwbnZ6Vm9BeUNw?=
 =?utf-8?B?NTEvWVBIQ2gwcUtkSkNTZGhXd21LZXhOT2hXVi8wWUFyN1haamZDdWZJK3J0?=
 =?utf-8?B?SWo4VVpPL1ZUb2xMcmNLTFdDMEFuSWVMZFdOQlljM3RMdWttdzIzdkIwaHIz?=
 =?utf-8?B?ZU12QlRRQlJsK0YzL3FOMkxWUExrOTZiR1FxSVdGUGd3L0tCZmFtUC9kSjBr?=
 =?utf-8?B?M3l0UEZGUGhkKyt1VW5BUitwdnp1R01zcXR3K2lXVFNQSEhLa0krUlZ4SGQw?=
 =?utf-8?B?ODMxVk1PY0FpVWpZbW1UOW9PbjFCS1dHUDBibnNXRi9kZ1JZbm5rQm9YRlJJ?=
 =?utf-8?B?V2h4ZEJhVTZNN2pzU2Z3Tm9tZkZDOXBhV2h3WDhiZFN2aEo3NWo0bzBhbjVX?=
 =?utf-8?B?RWMzdkdYTC9TekRseElManRoc2huQys4YWo0RldHVFN4WVV4dm9Yc1NRSkVT?=
 =?utf-8?B?bTloeTBWeGhNMDR5aEpRREQzbE42Qk84c1FMaVB2bUZCK1ZRWWw4SWU2NEJU?=
 =?utf-8?B?d3IwcE5qQk56NW1uWFNqbnhuMUdqVi8vQXFGeS9ZNVp0REYydm9jRm5rSkE2?=
 =?utf-8?B?V2QwUFI1WE5JNGFhdzQrR2k5SnZ6dlRhY1VaL0ErakxhN1lBTXNSRS9wbms2?=
 =?utf-8?B?ZjVTOWlWVDU1b1NGQ1lBM0lMOG9Eb3JxWXg1b0wwYVZwZ0NNQXpxSGdhM0l6?=
 =?utf-8?B?ZGQzVjRySGlLMlZXMStrMncranlCbzUrUFRlakhSTlYrVGcyb2ZPMVpGRVJq?=
 =?utf-8?B?RWEvTmJ0SkNYeTduNjhMM0hnY1lCYzZvNWxXVWRJbmlOV1NGUisyZjNkd1Vu?=
 =?utf-8?B?NWNDRG1tS1ZrYWowQmZFMGhGVzFyTUhmS3QyV3cxcmJtbjB6cnRFVHBETnFQ?=
 =?utf-8?B?M25jcEhrQjJXYUx1cUdOc2JyUGticktoNDVCaHZWbmJaWm03d3lic0dFR0do?=
 =?utf-8?B?ZTRmRFRJcTIwb3hEeE81TitqQjVJT2M0NmhTTVhibHJRY0xJY2NTQW9CWkdQ?=
 =?utf-8?B?ZXpxUzRHcU5nUU1xOUpBYTZlOE5RKzMvNHZHY1BtRkhuVENNaUJOQmQ1ZURP?=
 =?utf-8?B?SGd1Sm5PNVpKLytnZ2UxU21uQ0Vwbjg5YmhWSGtLRnRNNis5VDV6cnpXRTlJ?=
 =?utf-8?B?YzBJYXZURERDY25YeG5ZeHNkMzUwL1JyQmV6ZUVQNFhVZENWcm93QUdQNndD?=
 =?utf-8?B?T0pnL21jQ1JIUksreG02SEVma1p1aEVsemlFTnlRQ2dmUFUrckFhL3R3ZEZx?=
 =?utf-8?B?K2xobUR4Nkp6KzZjT2sxSXhZUnViSndacTRLYStDc2Z3NXFuWTZRc25vYzMy?=
 =?utf-8?B?ZjlVYXhKa3pBU0FuNXRwcGRLZHRodWV5WDdBeGo2UWVzVU95c2NGS2FrQnJ5?=
 =?utf-8?B?R0ZFczgreTVqRStLS0wyVitTU1NlRngxU0NPZndIcFBhTjcyZjIwQjZKdVBJ?=
 =?utf-8?B?SEQ0TU1TNWxlVDRDV2dzM3ZXZm4ra05zWHZHVVU2UkJNOXZpWW9wN1pQMmRY?=
 =?utf-8?B?NkFVbEYvS3JiaHVQOGREYlh3QXlkd0xNS0Y0RlNia3krZFdrc21KOVVCRzZP?=
 =?utf-8?B?SXpJRS9FYWxEZ0U3VkFmL3RnVjNhdzN5RVRCUEhtWHQ3VkNuS0FMOUVaZ0lZ?=
 =?utf-8?B?SW1UbFFrbG1PNC9xbEI5UjJKaHI1dmJla2gwdmtNakRYRU5RY0RLWE9KWTNZ?=
 =?utf-8?B?VHN6ZW9zN1FhR2grTGR1MnpzaWNGOGJOR1FRTXlIVFFtaEFMQTR1VDJ4cmVl?=
 =?utf-8?B?NjJEWHh2TGtHL2hpZFFrM1ByNFZWU2xabEFOOHVQd1dkVHdRcmdLWWJIdnhT?=
 =?utf-8?B?VFE1dWlQSVBDSWR4cC8wa05TN0RZRFJ6R3JvaDQwZGNMb0hMblRVdXFlSkt2?=
 =?utf-8?B?MSsrZ2tvZ1pUTEhEV2hhZThzUU12WFFiZmN3U1dZQkVOZ3hpTUY1QjA4a2lU?=
 =?utf-8?B?RUlnMlc4ZU1EcEErb1lOaFpmcGFBSVF4d3ZZVEVWK0ZhNVVmSE1BVVovSk9L?=
 =?utf-8?Q?6P4iTf8+hWFZmFmsorkfS4C9g=3D?=
X-Microsoft-Antispam-Message-Info: hQrFKHi4k5KDvjOGr07foaGzB4TEQ2Qxl0JJdL62MpEay1BPyQ8PmohzHvhLp0cXWEKYtHFWUDPF395PBwKoSJaOR+L4oswwiP8X5Cvfc3VPI7u9b8J4x+3tCuta4/pWNckGcmBPVWyIhy2RBXtsec/gNgZN/QHXdLCjffSBaIwCb28GT5ceJxbOFQHVfpPg7y3frf8Ji9Fnb31pNEi+Re4xvvNhYFjJ6eYZoRgkEG0+w5ReNcC7RGp07WJRYrbJSTk6zMc3xi12HzGYdM3FoS5fvC3XuyhlbVyHQlYqwXSF1nlnd315z8Pm6hgoalCXGsPEp35g4UNk99+o8tb+RUcVaSlAfov/IKnRttOzv0w=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0501MB2258;6:WNn0R54xbZTHFNiJvDqeBSTYviY5bcz9kHU0K6zYoiZ8WwVd28MArk1N0KlNrmojZWja/o03gk0JKuUSlqIcqieaeKUxNdDo6Vi3rUHQIlj7ES5xma7jADGb344+VMndy82aXfmkMYXqYwljK7thikL+qQ61cf+Xrh6nEpGe/apEFjhe57lYIZvvnYdgO7PL2RsfiXcqHvV+yGO0sZOoXdSPcWGYkwPCTDsvkG6qhuNYtxTieIF8MnIzXZeqkCGmP5nGgYB4dJczYalNZPfEfowv0qS8M+iB3CxaHt5bc7OvYDLQu74Z35AjojkPGMF5/UegHK9kxId79tL7ZrkBZZk2E4dGZfM/jftx6fvtQZyaVi0A66n7849cGJPEZbHP5V5pUuTKVJSLx5xQYesWEd8TbTyvWyBrLt1HdpPzj6CYWbkhUWnQ0XqbQutmuDVEu5FJNAXuUDXuSe6u/fwKOQ==;5:YHpy/WJNJWwky8Qp+0Q7k7ETq6lh5ZbFCIcs0HX6JciFM/AtcXC2aCnuJD8iQR4jwDI9cdBUDsTrbU8CaSExJD0UgwVAw3goAT5sU/QW5ZxSjyCLunIxHQSeTakKm3XCgSox4U1WvZhuJLPpRjYu4jA4iz215kkDIfpGJRj7DPA=;7:QNwbA6PFifY42z4Rmx1yj/HdLtxwhMfBPpK4rf6D6kx2KBkxJItXvn6SfNj+r223dJ9kT3/6w3Vg1l9mixf4BepgQcIaM6NhiOo13g/hSL2TFTdDuqu3m2DfvzkTliy4eZe+Bk0gUEpHegKumgbMWkx6sE5K2LqsY9gY5xnVv1s17+YIF9kkVdUpcjJ2aI8E2Y1RiGLlBgZ2TxRnrP7cxGGFeO+quLLw1YAeDJj6um+4spoBpvyHZGuRLRreRlns
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 18:11:27.8403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d300fd2-50cf-47a7-a77d-08d5f0c7b6f3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0501MB2258
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/23/2018 10:36 AM, Qing Huang wrote:
>
> Hi Daniel/Parav,
>
> Have you got a chance to review this patch? Thanks!
Hi Qing, sorry for the delay, I just got back to the office today. I don't agree with the proposed fix, I provided an alternative suggestion below.
>
>>> Or.
>>>
>>>> Reported-by: Gerald Gibson <gerald.gibson@oracle.com>
>>>> Signed-off-by: Qing Huang <qing.huang@oracle.com>
>>>> ---
>>>>   drivers/infiniband/hw/mlx5/main.c | 3 ++-
>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
>>>> index b3ba9a2..1ddd1d3 100644
>>>> --- a/drivers/infiniband/hw/mlx5/main.c
>>>> +++ b/drivers/infiniband/hw/mlx5/main.c
>>>> @@ -6068,7 +6068,8 @@ static void *mlx5_ib_add_slave_port(struct mlx5_core_dev *mdev, u8 port_num)
>>>>
>>>>          mutex_lock(&mlx5_ib_multiport_mutex);
>>>>          list_for_each_entry(dev, &mlx5_ib_dev_list, ib_dev_list) {
>>>> -               if (dev->sys_image_guid == mpi->sys_image_guid)
>>>> +               if (dev->sys_image_guid == mpi->sys_image_guid &&
>>>> +                   !dev->port[mlx5_core_native_port_num(mdev) - 1].mp.mpi)
You shouldn't check the mpi field that without holding the lock in the mp structure. Prefer you change the print from a warning in mlx5_ib_bind_slave_port to a debug message.

>>>>                          bound = mlx5_ib_bind_slave_port(dev, mpi);
>>>>
>>>>                  if (bound) {
>>>> -- 
>>>> 2.9.3
>>>>
>>>> -- 
>>>> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

