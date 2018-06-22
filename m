Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0D7C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC6A6246C2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 17:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HiWQOqB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC6A6246C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933872AbeFVReZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 13:34:25 -0400
Received: from mail-eopbgr690067.outbound.protection.outlook.com ([40.107.69.67]:49556
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933095AbeFVReW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 13:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0wgoKxq/PMrsi0ELitVRSkZ4biXlxmUQFxgGNhJ1Aw=;
 b=HiWQOqB6+1X+FiSSefUqcUl4eqE+AKJWpxyxeloc/MEUUt09YCJD6LPibVDQJAynqz7cVSgNk6oYYM8/tp3XiVNZdTE/W85lw0+vuM0uxfZi7ti2UBK7W673AJtfvXpDBdq5RuNp0gGr5TgPSxMtd2k8pwkLj3TFx3GUT4Iw+VQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
Received: from [IPv6:2607:fea8:3ce0:41b:7b17:e1ad:f3b6:90c0]
 (2607:fea8:3ce0:41b:7b17:e1ad:f3b6:90c0) by
 CY4PR12MB1448.namprd12.prod.outlook.com (2603:10b6:910:f::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Fri, 22 Jun 2018 17:34:19 +0000
Subject: Re: [PATCH] drm/amdgpu: Count disabled CRTCs in commit tail earlier
To:     Lyude Paul <lyude@redhat.com>, amd-gfx@lists.freedesktop.org
Cc:     =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Harry Wentland <harry.wentland@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        Shirish S <shirish.s@amd.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180621204832.22448-1-lyude@redhat.com>
From:   Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <fe73a505-e4c6-a53f-b1e7-52b22457cd3b@amd.com>
Date:   Fri, 22 Jun 2018 13:34:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180621204832.22448-1-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2607:fea8:3ce0:41b:7b17:e1ad:f3b6:90c0]
X-ClientProxiedBy: YQXPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::15) To CY4PR12MB1448.namprd12.prod.outlook.com
 (2603:10b6:910:f::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 736cc865-f20f-464b-2d80-08d5d866633e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1448;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1448;3:5+sfUg+lliGD1MB2e8zH1dY/nhqShm/zo8yEmcDWtfkBBXrT2i1xKx/YL6nVYJcaKvrf/WSh9ij3aB+qrnMCbPocNour4j0/AcYhES3vsiDsp4VRFGb6k/xcJgQYKN5JBebr+7CDuJ5Jej9hunkWxmGcSDrQePQWFjP6emmCEZAbIvR+hTij1J8U6ZcneYYz1UrhVUGUtfq2lxrkM+LvNpP+pY5tJGab/I4QG61bUIzNvrlxkcM5kgWnp7SJ/V8y;25:/+RcOpEOC9IIlP3otInAJF7NPy7J2XRj1aigm3lVI+OeaV5XxgSLYLA5ecrMNFaKq/xsHAe4dp8+S6HTJU+1MT9kYVUywqDBULUoMrDWpEy/N3pWnRnIDANJqNcDIe78P4WicOjPuz34aMc2tBOtDpxjLEWhaW02HndNbNGrgGVYyWamgJPVj5DKPCGwvw2BcaxbJ2gsAbVWliGEDdbHPKOBgzhPLQrKTV6pM1G37LkL5+2wKg0/7TE9eEg4p+ndsmx8D3S9fkB0WxBttKV0xExFUlcVtNPecjRbQNOh0TZIs6vH7YLMeYNR3Vd5ib5zIsay9FMC0rXQqYZg9TMrMg==;31:HR/INEVOVmXumHFzKbsz5modHAOSWIZZdlrII2aXNd1aeFRgjtSwSYVpVJVxqXB30Jsaj6MO7cSn22rysWOjs/+ElbLlSWnewPByVj4gtaox5qc6VRsrQQLthEOjeHpheDEPYPc7SLRtJdlXt7rw4SwEimfNozcmTOiapDiFrc/PEkky6FLEgRXMscTFOkVd8dgOTTwbrt0VoEKBjkMPWPH48WelFm8tZrlyNodqHjc=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1448:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1448;20:0J3axtMoc6tknkg4Zj7rjTdYVfWfQS7rq4ir6GrpJHC7ocqkLzqkgylc9BNIkSnu2npQ24kKDxypt+6hF77rJS9moIFwucAD/FwX7eBTMDjz7s/UOGHbF8LvZuVaGcDM10UPcBgSD5/eOssMa4p6ZyrMRuYqoNgtaKObYnMlqJOa9gYea4LyQdGRthcibYfuckjDHcotgrAV5kxCTq/TKr9O0X7nCCUVNuTJu22qO4q8lTEqHgaD17QOZoN5QKqCqVdiVK7kmCE/BTMwM9GDIu9lBqm7I1ghh/Kc/zSisBt+YJL/H4jIex/LcXEnuEo0WN7GpdlY95wzCZmOAG4/n3EHEkz/c8+FX/m77n9+weI0wJhmfuVj48/ZxdZZcGFSi9UWPfEd6gKrPeveFMnFgTvHCseQ8DILYkf3NXeU1saXkmgNfdPpGIpxoyqyeUJb43DZ6EDklwL2C1vuxz5tT9MGdIkxY/+UkpYt4P15t5KL9kbcr+kR1KtqGNvEyzjd;4:Lqh4ySRfRMr+0amdcrzswiog4TRGZmsWOEc9nP/ML84YCsXgGU03hrM71/Y6RONbyYtWtiQU71vH8ia/TvwNbFDu/kJrzBv7ZjUvexprFQYyCWBdj4YDoDCE82DbULd6g662O+ypAko9OxyocEwzBfC4lmNLt9pXK2xfCGS1Fa6OaHMyk1W+8LgZ98O9plx53j7dDFRLAQSo+zOIXhwCjzHXBAPxGVLiw/O/Cw+7H88cPDEg2Ajzn/xlBSMd7NkRAknp1qtYnLZO1CecDg5UY7Rr952vCxi/zWQvtA/yXD1f5xvvxthK+WD0N+TcOmMS
X-Microsoft-Antispam-PRVS: <CY4PR12MB144813121FAE791CAD735D6EEA750@CY4PR12MB1448.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY4PR12MB1448;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1448;
X-Forefront-PRVS: 071156160B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(39380400002)(366004)(346002)(376002)(51234002)(199004)(189003)(476003)(59450400001)(2906002)(65826007)(72206003)(64126003)(446003)(54906003)(2616005)(58126008)(316002)(486006)(386003)(11346002)(5660300001)(16526019)(6666003)(478600001)(53546011)(46003)(229853002)(86362001)(31696002)(186003)(36756003)(81166006)(97736004)(81156014)(76176011)(52116002)(25786009)(47776003)(52396003)(23676004)(6116002)(8936002)(53936002)(68736007)(8676002)(2870700001)(7736002)(1706002)(65956001)(50466002)(67846002)(6486002)(31686004)(305945005)(105586002)(52146003)(65806001)(4326008)(6246003)(106356001)(2486003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1448;H:[IPv6:2607:fea8:3ce0:41b:7b17:e1ad:f3b6:90c0];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxNDQ4OzIzOjUvdUdJS1V0OXg0QUFxS2ZST2M1ME1GSzJX?=
 =?utf-8?B?YlJOWXg0eFE0NSt2Y2hpN3ZXT1VUUlVmZTJuYXE2Q0U4Rm9LUTVIcEgydzh5?=
 =?utf-8?B?UUNvMjJrWGk4cVBDTW1haUJHZlZEdmd3M2Y5MVZ4SGppYzdra3RoVHgxTGV3?=
 =?utf-8?B?SmN2N3MzdHBOMEdmbXdkakx0VTcrSUtYTUcvY211ckpmRUVNZWxLMnlxNHRn?=
 =?utf-8?B?UzNaMjdDaVNqTDRoUHRQYkxPNzZjejgvdDh6STJMNFZ0Q1hidlFHNEJFZENG?=
 =?utf-8?B?VkMzY1R0NEthdmxqVWxuTXFpTHFPS1c0SjlLanREM09Uby9sWnVpay95dCtN?=
 =?utf-8?B?N1lhN1dZYWlpbTNXVzVSMVlPcHRFZnJXSzVGaWJYbHlmdmFIM1FmL3h6Z2Zn?=
 =?utf-8?B?ZWdGRGhHZnJSQkpQTmpQcXNrUWpLSmVqT01aaGhoZUlkbDJEYXkvQ3AzeHFl?=
 =?utf-8?B?bE8wczZNbWVFYVhHdnVHblhPOFF2cWh3VVpBdWNjREZYYUo0R01UdzYrM1px?=
 =?utf-8?B?ajB3S1cvWkU0OW5zYkFabHhFUEVVaStudHovOHBiS1FxZmNaREJsNnA5eVBZ?=
 =?utf-8?B?QlByN0Y1RzRyQkRNRWRZdzdubm12a05oTEdVL0QrT3ZBdmpmUGJnU09DMmhu?=
 =?utf-8?B?OUpTUWdhcDdVUVRLVzByVDNOMFB2TEJTR053dkFadkpWc2JtcVJkdGtxeWwz?=
 =?utf-8?B?Ris0eForemtHYW9id0VLc2R4emQ0YlhNTno2bVFKYkFqdkJHcTF2Q3RBY1kr?=
 =?utf-8?B?L2pSVGplYTR0SnQ4UE1MeTdxclNyZ0h5UDBCQU5aNEFvN1BzVUY4eis1dmNl?=
 =?utf-8?B?aHk5TUlwRHY3NjRPVDVtS2V2VXAxbmFKeXE3TUM5OE5kdTU4ZWszalNieWw4?=
 =?utf-8?B?NGZIcFVMVmxVeS9FRm0wTVdJb0RZTFV4MVZuSVdsbHJqT3pURmZ2eWxRazFw?=
 =?utf-8?B?eWZML1NXZ1lGTDhnRGdnckFYbUlXTWU0SnpuMmpLSkpKdTNLUHBtVnVNVEts?=
 =?utf-8?B?aG5ScWlRU0NONDcxbHFSRUpaOTB1YVlXT2Q3ZTdDdkEzMTUrdUxTWUlNakFh?=
 =?utf-8?B?NER4SktIMFFTZjVablRLeWJ4YXlVbE9CYURZQ3ZDdTUxOE0xWlBYVmNESzl2?=
 =?utf-8?B?Q3B5UUQ0L2xkVWovZHhCV0RWS01NYnVHOHRtMGhLVjhoOXk1NDN5aWNKR0tt?=
 =?utf-8?B?V2F0Sm5CS2FmUEtlZGRVM0tuZVFKOHhrMkx3VEhpaWNMOFJ0dTNONE9rWDVv?=
 =?utf-8?B?RkR6LzBLMlhSd0tHSGw3QVhuOFJ1dWVyRUJ1dHFyOVhWdGxtaXBpTHZoZndj?=
 =?utf-8?B?NHRoRHdvMmF2bi8rTkhlRFI2UWRPbUx2ZzJjSGpEdVZhQ2NRc3JkSU5IZllp?=
 =?utf-8?B?T3Y3NmV6V21jU1VHTys0MjMwRmNBRjlJTVZ1bGQwa3pXZFpWanVFeVlxUlVq?=
 =?utf-8?B?aG9RT0ZUOFRyU0xseXZteEozYmhLM3FXcE14N3gyVWcvcVhzaXd4V09USUhH?=
 =?utf-8?B?amdXcWNmUUZOQmVWc0dGRC9yWDVnOVhrZDU4d29VakM3RlBUZWRVemJKNGti?=
 =?utf-8?B?a3pBQ0RQajN1MjJKYXQvZXJiY2xEaG5Henc2UkhTQVIyU3kxOGtUbkYzcHc2?=
 =?utf-8?B?MHJXQkswMHJMMDQ0dUR4WnJlMHdlQ2xGM0RRSjRkMm9LZUZMSmMvcXIyVG95?=
 =?utf-8?B?NDhOL0lZL1pRUSt5QzdKZ2IweXlpR3JBMWF6a3pWZXQwdWRqOGFxdVhPNElE?=
 =?utf-8?B?MVlhQnBiK3BQMDY4bDgwT1BKVzllSHRYNFcrSFd6ZXZROEl1VExTRENRbGky?=
 =?utf-8?B?Rm1IellTdkI3Qy9EcGFsMDFyNXB2KzJjbGtSbUQ5QXBuSjBucFh3T1VpRkFS?=
 =?utf-8?B?ZTNmQkt5KzM1eWlkNml5czBPNHMrYXNJWityeTIwVEQ5V0Q1ZWhObUhNQmpo?=
 =?utf-8?Q?NuIkRbPfdWAUO7IXfcfPGX1rOpEnLo=3D?=
X-Microsoft-Antispam-Message-Info: 9FWV4ULxBaMgv9YMbQeYCGbpS1RcHiP78yUURB5f0Xwoo7hfWWcT11aQM+BoudrelTnFcfJYZROhrpMCbbEsqZAN8mK93eow6sXxbK/Ww/TaPQ+GkvlDpuDY2PxHbsc8LzDbT+Yjw2iI/+0AD2QkwUzRxOOTCKiEXbVX8g4GsLAfprrgezKM8PyJHfZdDe8/d4XucnFOfr/DgNiU0FChDzTVflJKPPa6AZL+W7JZ/UKG8KNU+qkIEbDqQaFXH+QXouVXTMWtmegD82S/srcUFTisXQO415f6p5JYcBEJ1ar4f7xfbdZUS53zQM+av1K0C8CA7rULfM6tDp3xMW0Ziw==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1448;6:nPn1CQl6cPjrAAKXO6o9aYdsGm1YzaVSgwuekSsMKViAUi0smlA6U/Z6VrRlFNmsoafUi6Ta6f4KwYR3dQq012r8GLCOCWp5iSB8Ltg0ALM+89wJRUYFkp9DTZDYTfIj1H+CSAG1xnE6Qch7xnWqbGzOAgbuqs4GfbdgHMSS0t/jat6b1xOny8YrchnMuRbiKfmnvVUra3twMXnVivdtkW/YDUPWdGGqwINvRnYZKXdFaEihmuJIImhcZstnpKX9ZxdnNk8FHLJbHTO11j6LtcEMI502L1l+JAA4vxsSKA2lYMNIusUH07reO2EP4C0XtsqlSJClDtj+ZGF9eYORic0ziCNTJntBsrmvPRyolnQna75VDsMVwmuEKdQ4scXl7xM6gLEwwLOD5/HQoTw1l+/4qiT5FIJfJFCwV4gPE8+KDEJFeKQgGK4MW8JBCNBj/RaYBoukg4lsCUx4CYRCQw==;5:va2dcCGtRR/BNiyR8be++9lJmoBP8BNyzB/zrFebd6P/J/5+8iNEt1E9LbvK9xbP+3Sj3EbjY7uwxKrYu/4aB2bHWfNWHDrjf0mKFVaz0ymU7s6fBg4nbe2abPZ05365dA4CimF6B0RjT/AIQowjZA2/xqdz3kYz2vRZiBkUZZI=;24:LQVpWleFOe2Vee/jBizjw4jqiE3eGQvsgX70Qn8pHJ9Xndon5ba3+3NLm/wshkq5kx5V7pbFoXK9773RkkF4K4aO+G5cpb8sW4+Nyvi5jJ4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1448;7:WYAfh4lCH/ZZSLIF1doNORUDkDRqsGnT3Popa+qGG9q+z40l6jWIqyKieA3q06utdpm52LKlmj7RD2+9BfjlyRYFbuwIGHcExWkMYONseUEa8N6nUeMP0JgUaW03JumRqUvrMxyqaT+2pKc/AaGuPexOslTYVNn4n5iwViUrei4LYxzJAweIb/KScORZfCpUcnDy2mPaqbx95fPM4GKT1W3llWqfoDMq9BrWSgxnt9qJ2NTJRt82jFcNJTd6YR/7;20:v7WxeQUyhz1JFsPdHVfNm4RC+PiUd0eDHG4A0H8NFub5TAxwRJwkuWQRZpw9SgRU0INcC2hXWlCwO7tVMvwcBp64nmGOIW9AlDHnRXDIsYJynqotdoUXGdfyWadKx5Bx9ZWEY/VZsCH2+sFLejZDGQDmZiLaV7/iPDgMC6mc9wElij1MkWGNTdimNp79YokSOsMP3fOoFuqD2CWfON/6fBg3U3Tuo2LyEsqQtVbVc0VE248Tcp9YUdLs7ZAeCY5I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2018 17:34:19.2214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 736cc865-f20f-464b-2d80-08d5d866633e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1448
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/21/2018 04:48 PM, Lyude Paul wrote:
> This fixes a regression I accidentally reduced that was picked up by
> kasan, where we were checking the CRTC atomic states after DRM's helpers
> had already freed them. Example:
>
> ==================================================================
> BUG: KASAN: use-after-free in amdgpu_dm_atomic_commit_tail.cold.50+0x13d/0x15a [amdgpu]
> Read of size 1 at addr ffff8803a697b071 by task kworker/u16:0/7
>
> CPU: 7 PID: 7 Comm: kworker/u16:0 Tainted: G           O      4.18.0-rc1Lyude-Upstream+ #1
> Hardware name: HP HP ZBook 15 G4/8275, BIOS P70 Ver. 01.21 05/02/2018
> Workqueue: events_unbound commit_work [drm_kms_helper]
> Call Trace:
>   dump_stack+0xc1/0x169
>   ? dump_stack_print_info.cold.1+0x42/0x42
>   ? kmsg_dump_rewind_nolock+0xd9/0xd9
>   ? printk+0x9f/0xc5
>   ? amdgpu_dm_atomic_commit_tail.cold.50+0x13d/0x15a [amdgpu]
>   print_address_description+0x6c/0x23c
>   ? amdgpu_dm_atomic_commit_tail.cold.50+0x13d/0x15a [amdgpu]
>   kasan_report.cold.6+0x241/0x2fd
>   amdgpu_dm_atomic_commit_tail.cold.50+0x13d/0x15a [amdgpu]
>   ? commit_planes_to_stream.constprop.45+0x13b0/0x13b0 [amdgpu]
>   ? cpu_load_update_active+0x290/0x290
>   ? finish_task_switch+0x2bd/0x840
>   ? __switch_to_asm+0x34/0x70
>   ? read_word_at_a_time+0xe/0x20
>   ? strscpy+0x14b/0x460
>   ? drm_atomic_helper_wait_for_dependencies+0x47d/0x7e0 [drm_kms_helper]
>   commit_tail+0x96/0xe0 [drm_kms_helper]
>   process_one_work+0x88a/0x1360
>   ? create_worker+0x540/0x540
>   ? __sched_text_start+0x8/0x8
>   ? move_queued_task+0x760/0x760
>   ? call_rcu_sched+0x20/0x20
>   ? vsnprintf+0xcda/0x1350
>   ? wait_woken+0x1c0/0x1c0
>   ? mutex_unlock+0x1d/0x40
>   ? init_timer_key+0x190/0x230
>   ? schedule+0xea/0x390
>   ? __schedule+0x1ea0/0x1ea0
>   ? need_to_create_worker+0xe4/0x210
>   ? init_worker_pool+0x700/0x700
>   ? try_to_del_timer_sync+0xbf/0x110
>   ? del_timer+0x120/0x120
>   ? __mutex_lock_slowpath+0x10/0x10
>   worker_thread+0x196/0x11f0
>   ? flush_rcu_work+0x50/0x50
>   ? __switch_to_asm+0x34/0x70
>   ? __switch_to_asm+0x34/0x70
>   ? __switch_to_asm+0x40/0x70
>   ? __switch_to_asm+0x34/0x70
>   ? __switch_to_asm+0x40/0x70
>   ? __switch_to_asm+0x34/0x70
>   ? __switch_to_asm+0x40/0x70
>   ? __schedule+0x7d6/0x1ea0
>   ? migrate_swap_stop+0x850/0x880
>   ? __sched_text_start+0x8/0x8
>   ? save_stack+0x8c/0xb0
>   ? kasan_kmalloc+0xbf/0xe0
>   ? kmem_cache_alloc_trace+0xe4/0x190
>   ? kthread+0x98/0x390
>   ? ret_from_fork+0x35/0x40
>   ? ret_from_fork+0x35/0x40
>   ? deactivate_slab.isra.67+0x3c4/0x5c0
>   ? kthread+0x98/0x390
>   ? kthread+0x98/0x390
>   ? set_track+0x76/0x120
>   ? schedule+0xea/0x390
>   ? __schedule+0x1ea0/0x1ea0
>   ? wait_woken+0x1c0/0x1c0
>   ? kasan_unpoison_shadow+0x30/0x40
>   ? parse_args.cold.15+0x17a/0x17a
>   ? flush_rcu_work+0x50/0x50
>   kthread+0x2d4/0x390
>   ? kthread_create_worker_on_cpu+0xc0/0xc0
>   ret_from_fork+0x35/0x40
>
> Allocated by task 1124:
>   kasan_kmalloc+0xbf/0xe0
>   kmem_cache_alloc_trace+0xe4/0x190
>   dm_crtc_duplicate_state+0x78/0x130 [amdgpu]
>   drm_atomic_get_crtc_state+0x147/0x410 [drm]
>   page_flip_common+0x57/0x230 [drm_kms_helper]
>   drm_atomic_helper_page_flip+0xa6/0x110 [drm_kms_helper]
>   drm_mode_page_flip_ioctl+0xc4b/0x10a0 [drm]
>   drm_ioctl_kernel+0x1d4/0x260 [drm]
>   drm_ioctl+0x433/0x920 [drm]
>   amdgpu_drm_ioctl+0x11d/0x290 [amdgpu]
>   do_vfs_ioctl+0x1a1/0x13d0
>   ksys_ioctl+0x60/0x90
>   __x64_sys_ioctl+0x6f/0xb0
>   do_syscall_64+0x147/0x440
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Freed by task 1124:
>   __kasan_slab_free+0x12e/0x180
>   kfree+0x92/0x1a0
>   drm_atomic_state_default_clear+0x315/0xc40 [drm]
>   __drm_atomic_state_free+0x35/0xd0 [drm]
>   drm_atomic_helper_update_plane+0xac/0x350 [drm_kms_helper]
>   __setplane_internal+0x2d6/0x840 [drm]
>   drm_mode_cursor_universal+0x41e/0xbe0 [drm]
>   drm_mode_cursor_common+0x49f/0x880 [drm]
>   drm_mode_cursor_ioctl+0xd8/0x130 [drm]
>   drm_ioctl_kernel+0x1d4/0x260 [drm]
>   drm_ioctl+0x433/0x920 [drm]
>   amdgpu_drm_ioctl+0x11d/0x290 [amdgpu]
>   do_vfs_ioctl+0x1a1/0x13d0
>   ksys_ioctl+0x60/0x90
>   __x64_sys_ioctl+0x6f/0xb0
>   do_syscall_64+0x147/0x440
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> The buggy address belongs to the object at ffff8803a697b068
>   which belongs to the cache kmalloc-1024 of size 1024
> The buggy address is located 9 bytes inside of
>   1024-byte region [ffff8803a697b068, ffff8803a697b468)
> The buggy address belongs to the page:
> page:ffffea000e9a5e00 count:1 mapcount:0 mapping:ffff88041e00efc0 index:0x0 compound_mapcount: 0
> flags: 0x8000000000008100(slab|head)
> raw: 8000000000008100 ffffea000ecbc208 ffff88041e000c70 ffff88041e00efc0
> raw: 0000000000000000 0000000000170017 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>   ffff8803a697af00: fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff8803a697af80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> ffff8803a697b000: fc fc fc fc fc fc fc fc fc fc fc fc fc fb fb fb
>                                                               ^
>   ffff8803a697b080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff8803a697b100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
>
> So, we fix this by counting the number of CRTCs this atomic commit disabled
> early on in the function before their atomic states have been freed, then use
> that count later to do the appropriate number of RPM puts at the end of the
> function.

I am a bit not clear, are you saying that the problem was the 'in the 
middle' commit (cursor ioctl) doing

drm_atomic_state_default_clear->dm_crtc_destroy_state->kfree(state)

where the state is the one you access from from the non blocking part of 
page flip though old_crtc_state->active?

Andrey
>
> Fixes: 97028037a38ae ("drm/amdgpu: Grab/put runtime PM references in atomic_commit_tail()")
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Michel Dänzer <michel@daenzer.net>
> Reported-by: Michel Dänzer <michel@daenzer.net>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index f9add85157e7..689dbdf44bbf 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4206,6 +4206,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>   	struct drm_connector *connector;
>   	struct drm_connector_state *old_con_state, *new_con_state;
>   	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
> +	int crtc_disable_count = 0;
>   
>   	drm_atomic_helper_update_legacy_modeset_state(dev, state);
>   
> @@ -4410,6 +4411,9 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>   		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
>   		bool modeset_needed;
>   
> +		if (old_crtc_state->active && !new_crtc_state->active)
> +			crtc_disable_count++;
> +
>   		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
>   		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
>   		modeset_needed = modeset_required(
> @@ -4463,11 +4467,9 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>   	 * so we can put the GPU into runtime suspend if we're not driving any
>   	 * displays anymore
>   	 */
> +	for (i = 0; i < crtc_disable_count; i++)
> +		pm_runtime_put_autosuspend(dev->dev);
>   	pm_runtime_mark_last_busy(dev->dev);
> -	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
> -		if (old_crtc_state->active && !new_crtc_state->active)
> -			pm_runtime_put_autosuspend(dev->dev);
> -	}
>   }
>   
>   

