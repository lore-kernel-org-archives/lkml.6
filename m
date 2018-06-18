Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75778C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA8E20852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zBP2ZOcA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA8E20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934795AbeFRQNO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 12:13:14 -0400
Received: from mail-dm3nam03on0076.outbound.protection.outlook.com ([104.47.41.76]:55059
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934536AbeFRQNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 12:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykGgGaQWh+/MuGIKjfFzR5Nd9thEI4jmG4lEfzMld6k=;
 b=zBP2ZOcAXAmxBRVO2cfA3pB+Sk0Cf7JSQMuKDJKOH1Vm2ZyHjeW+YvMxO9VUWJzY4I27pe/PxQFlrwmJqnR29fLqx4A5BxGmErZtkFawrh747WLzAf110SpgD4FgRU41jyPB6Yy5uOZCboTq5GhfYIxx062/NwInODFu+q0QPj4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from [172.29.157.77] (165.204.55.250) by
 DM2PR12MB0185.namprd12.prod.outlook.com (2a01:111:e400:50ce::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Mon, 18 Jun
 2018 16:13:08 +0000
Subject: Re: [PATCH 1/2] amdgpu: display: use modern ktime accessors
To:     Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     y2038@lists.linaro.org, David Airlie <airlied@linux.ie>,
        Tony Cheng <tony.cheng@amd.com>,
        Dave Airlie <airlied@redhat.com>, Rex Zhu <Rex.Zhu@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180618153649.2015346-1-arnd@arndb.de>
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
Message-ID: <72c5bb3e-bf77-6972-a953-66a8e04b08d5@amd.com>
Date:   Mon, 18 Jun 2018 12:13:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180618153649.2015346-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YQXPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::25) To DM2PR12MB0185.namprd12.prod.outlook.com
 (2a01:111:e400:50ce::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11ffd2cf-ea32-418f-85e4-08d5d536623a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0185;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0185;3:uyGMQUL/cw2jgQsphfTdK4jsMMPftnwsB++z+WpcYRBwVM4KIX9945++wOHutRVdzz/TA7PlnfWu150ajktLUsgVApuNyIA0c6vUn2VUqm636OhO73X2gsS8H2brJEm+5DT9ynqQGS7pvBzszmzdR6Ban4QdiKhj5s/mxtDcO2bOoI/PMXW37ASFMA7uZFGCeaufdZNv+OBnFCc+efrVCO7lRapRyUELs7bWDJvKYxkzQK10Y0ao3pfnRr1K2Idb;25:to564bgemPX0819x7LUM4ma+hmZ1fFjzwx4BLlBFxd7VeErH8ENOLDGUxSTI5c9VjcQyTQKSO6vL7QRKkCF+4U1frEnLMyFjEXk6MX9sC2ZIdekjtNt36SDwbPYphW4CZxrroYz9UPDrUnP/a7fsxCUzB+EwshlvYShmwBODDhkRTTRjYxoHMBXpKcQHAuGcA1ZrIqlAi/FJHtvgitKBXR438io2dsP0Yz4dsDUIsEA3bDZ2/Ut07wIPyWBxiM6oKZWbXV/7dE+Jq6p819Azu/Ut+2WcP/jaIDayxXucvVm4YqThuJ5bs4vJGgJ+z9RqrhVS1COeUckrLID2PtnhcQ==;31:QYs2/ga4OxPn2ZvMvyOuvr+5rxxtYomHd6ltIYtLEmLI6HGLwzyOXn2KpJ53fBOREMaCYhM9Jcd06XnEXLUkwNz0Lux/Cj68f5PRNP1jYADKI24pVK/ZeL+GlNR1DtD894NMFbwZHf7JyRJiG6axS2IUX6ZR9r2BB5nxRL7eZQQzJkKE2ojWAwjgbCBvFPOyc3sn4YmG98qoLglazlpZmmYaV0wzYVdEZeEVEZwQN3k=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0185:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0185;20:OB3JRqQmwS0HvFyATJUKCwxSZ8akyKJeju0BIP6qE7xupVLbXzO6rXtwlSDkk8rMRfnkXmZRNAXgY4B7Lt7Sb9lzsNDv+eHxRcqiAbbfFqfU8FNpDKw/W3SWxskTwetUS0wuJihD/HaUG+PT+tGY3QHxfyDqNnqB5hQ18e/ESLZxjZjr16S/VA5wD/jTW523t79L3+CV5OqIW+Xoz1vSh9VOzaIsEZ1rxH0qeeul/qI4tj1SNpp+J55ejctIMFDo+KdxuMS5p/A6mNCs5mctP9tzCyqiU6FRe7/GVaCSNjVmVYewl89KhfLOikSRZdev96zxLoQ1LE7M6HF7JLXOH+rkFHTn9rhVV/c9N3aJl8w+tDrDIfUAJKW48DJibYqsVuiADt2u2W+DKK3+cFcB00V3UB4FWqQqt1sR1ZIhv+xgsgMTkNjM4oIHXij2iP3dUlLtT80lwgmGdLGwQiGXbZzkb6a0rcl3HpDJcsACUPHTC41ZH3e2n1ts2uhPjegE;4:g3y+nkBLnPRrrax68rM1nh8j1BZqgkQeQ5KMAC4o4smyOg52ts7hL1UeJIXuGFWlrEr+qHFca8MICMRQa2qK3QDzGrYAW3QrVMqq5idq606L61uj/tOgg1TZTKITWb3CVYUK/wJemhovJsLbkIjZVzKvS1Gg+STgpE3M+u/vdKftsxLd4UzANt9rwu7qqUJO5nEjeodz054P7LXEm+5hF3pcc/X40NVz3ZgGU0x3KSt5Cg9mkoLq7Qscti7Vvji99BMOFfuFSRhuVCfzd9IGdrpnraMCEbwK99Hcnv4ASdMpqWEYBgDgWEyvFD8LzyEw
X-Microsoft-Antispam-PRVS: <DM2PR12MB01856A040FDB5C39615727968C710@DM2PR12MB0185.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM2PR12MB0185;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0185;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(396003)(366004)(346002)(39860400002)(39380400002)(189003)(199004)(6636002)(6666003)(36756003)(11346002)(446003)(5660300001)(64126003)(956004)(77096007)(26005)(6486002)(486006)(229853002)(65826007)(476003)(2616005)(305945005)(31686004)(44832011)(316002)(58126008)(110136005)(7736002)(186003)(76176011)(54906003)(52116002)(50466002)(52146003)(2486003)(23676004)(16576012)(386003)(106356001)(105586002)(53546011)(16526019)(25786009)(81166006)(81156014)(8676002)(68736007)(3846002)(6116002)(65956001)(230700001)(53936002)(8936002)(2906002)(66066001)(72206003)(4326008)(86362001)(47776003)(478600001)(31696002)(65806001)(97736004)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0185;H:[172.29.157.77];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjEyTUIwMTg1OzIzOjRQUGY1U3FmS0czeE1WUVBHVGtMNHI3Um0x?=
 =?utf-8?B?cHhWVGZPS05Gd1NQNS95RnVuMjNhK25sY0FDV1AycE5DWENqNXlGSkNpd3k0?=
 =?utf-8?B?NXExUnVCRzZsQUQyRk5IcEhydXNDUWYrUmdteGVnSHEyZGw5SnJvUUtsem1Q?=
 =?utf-8?B?ekxUVkN5aVUyai84UE01YWp5ZW45ZUU1em9LS3AzUzd4N1A0TmViSzVKcFc3?=
 =?utf-8?B?S0twUWdUaTF0WU92N1FNbldlcU54eENDNTZUWStwZHJiQVN5RUFnOEd3eWpL?=
 =?utf-8?B?UExYS0NhenE5dE52cmJpdi9TUWZHVnFuM2tGZWZ5VEJqYWppeUtUQUpJTlB0?=
 =?utf-8?B?YmlHT00rWTlSZWV3azdDWGk2ajdRaWpwVm5aSG40YzZRQ1Y2SklJTURRMVpZ?=
 =?utf-8?B?djFGNEVYSFFpbmVjVGthN2dDVVY3cWQ3bW8zbW5aaUVlTnVUcnFqeUdrSTBz?=
 =?utf-8?B?RjA0YmNtUUhidXVyOFlydW80bDJ1dU9jekZFSXBNbW5rSEFzTXpIRVllMGFT?=
 =?utf-8?B?MlBIcWlLYzMxbFVlT1dNMkZRUTVqd0RMeXVXbGhubUZFbE82V3AzS1YwUEJo?=
 =?utf-8?B?OGdaM1E1eU1EMExNVWtIb3l3cTJsWVBpMzlZZFpPdWUzWEhaSjQ1VFRPZFhG?=
 =?utf-8?B?emNhaGN0VmVJb2g4dmRmdWtPNmdzd3RKWDh4SGkvMnBETitlMU1Iam81YWJI?=
 =?utf-8?B?L1BoM1RNZUlFUVZjNG1Jb1VIcW9lZTE5VS9TSkpUQk45NkdFd3hMVWtVdWlq?=
 =?utf-8?B?UmNsaE55WVoxNURmL3VmRkFlb3JSRmxobkhVWUFGLy9teWprNEk3bTdTaEMv?=
 =?utf-8?B?VWRZcHpBdVdVbURoaFMvMVYrdm9zNHdBc1ZXMnNBdXA2YUtvSGF5TXFTTlNI?=
 =?utf-8?B?WnF5L1crdnI2OFJKSU9sREE0enVPNzRNV2MrYWFZdFo3MW13Q3hHOEl0ZGVr?=
 =?utf-8?B?NllEQi9QQTFtbmZ1TU8xdm5sYnAxS0gwTlFxdG1YRnRBaW1jSmFtUFpneExZ?=
 =?utf-8?B?aVBSalBnbXIwOW5lcE9wRm15QTZtQlhjcDVSTk5ibkd5TmsrbStvaUtNVUdN?=
 =?utf-8?B?eFQza1BubVdueWhURjJmKzdsclBkNmtJYkROWDd3bFdXYkhGWmdsZlU1cEZV?=
 =?utf-8?B?b1VRTXAzWHllbHh3NE1PQmF3OVg2QjVmMS9Sd283ZnFwQmFuQmE4YVc4WGt5?=
 =?utf-8?B?aXJMZC9YU3EvRjUraHdNd05WV2hXY1Rja0Irb2tCZGg2KzFKaVczVXVIblpQ?=
 =?utf-8?B?R2N0TkFVOXZkSWJ5OEU4KzR2VDRYTzUrVUNhKzB2eitxTmZ0K0ZJYlRwRTcr?=
 =?utf-8?B?cnZxSGlhdzdseVU1WTdERnNwSzJLaElhM2NQNnlqdktybGloZmpOZGtEYzk5?=
 =?utf-8?B?TEIzN3ZtdFRLSlNIcnF1WjJTazVyMWtpenhRRC9YV1owVEx0VVdVa3Vpb293?=
 =?utf-8?B?UW1JMC9wUm9hd1J1bmVJbm1vMU5XRHRqYllFTjZPMUxvOG5DOVhnY0h0NTU4?=
 =?utf-8?B?Yy9yUVhyamFrZHVoQmZ1OEtORmtwRHlEVTZtTGY0bWhnVFgxWXk5dk1Rbk5L?=
 =?utf-8?B?bG1qNlJpT2NmbWR5SzZ2Ymd4SVh5d0hHUzZnK3hwdXVWME1zdHN2anltUTNB?=
 =?utf-8?B?SEZBNEVzNHhUOGxCNDJtYXBnKytIR1pES1RxOFdJWEJ3SzFZa1F6YnFpcVdS?=
 =?utf-8?B?ZGJvSWcxTWRXU2tyWk1tL1p4bVFXVDNtR3lTUlNZeFlxbDRNV0FSZHUxVkJN?=
 =?utf-8?B?S0djK2ZDMG9qWkNpRXJsMXVZdVowSURZOXU3TXBxRUpvT28vT1A3bkU2cE9Z?=
 =?utf-8?B?L20wbFFGeWhpQTdhYnZJdFdZMDBoWWxjY3Vwclc3YlpjYnFvU2tKSkhiVERr?=
 =?utf-8?B?dm9HVndacWpyS0VOQjdBRVp3ZmM5UE9OVjRtUXVLNXpXNjlVWmZRTFRoNmNP?=
 =?utf-8?B?ekt3T2piOVhVT2NEM0pSZDlkSDB6amNDaXdTc1lDcy9mcGQ0S3dsMGR3ZUw4?=
 =?utf-8?B?TDRQdUVWYTdBdDBSTFpWZ1hDZnN2dWdPZDAzZnJnTENQTmxVTG9nOUdmQVho?=
 =?utf-8?Q?CDaA=3D?=
X-Microsoft-Antispam-Message-Info: hV3ZWmU8YjYcOx2uVloqYdzhBJqn+3sZcUuTY/m9rYUBP0+GrXiptttm8dLfu61Pr2jECHxOWA42IGkJYGlFCpTgkJgu8cHjGOBRxAH9cWR/xrcqDSOJacN1C2/kytacP39fYiunq3MrWlc5vF12B74SmsaRb6Rzajh8tKQmm8v79T8J2zvRCwIBj2+IsOQDPdvcA9CsJBgTvD9bFcnnOkWk39qZ9mPdfOKNjH4QTz8DdMLzE+/9s8Xh3zcQ4R3GAMrNhqGXMehIqWFjcdXVOqmfbyDZH4G/JQ0DpN651TOL2zhhejPL5IWiZu6IZOhgO10FUpdj4HFJd5fBMy9VNA==
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0185;6:9xgQ6lja0YquDTnqDuNzqK8tbA++rpMYe7YqnrVpwizBxH3VwocAj1ST7HxjOmtmSRxC534qPTtMGXwfnkQJ/EO8iBk8kfjLlRQIAhy1S9WhB7LQRxjAx8PieVE6fHLAAM4aZ/4zMCU+lOqr6v9J4Wt+W+SKnxBhd9waG8gdHxWSUr6S94V8ZzH4T5dzQpUhS0bmYsIf5sGDLlOC7yspqKd5QKTXPzQ9NO/HQw/xJqc2SbGaX3f82N+YGb4RUPmsnPpsCdmG90cgOeG0yIVGSNbJWvZEeBHOD9qVo7cxcNlrdKHJiS0p4tquzCwRxqicjRGpJpCJzNrN8btBdaRo/A5AwB3ss/lwqz1bPgfuVCB4Bmk5fZqoFfAztPNgPGRUJg89Z1hFgeDLg1D0dkmI7/H1YbLqCkO+2TeTAmsvsO7CJpxGBj/kLlBZmd7Jf9IeNiVW4PXvKDHzwuj5arbskg==;5:0/XYL272/u5WxVG1FJcuX7cBD6vZOP9luZyOACUaUYGl3emX3ieEjnjYGZpJGjsIhA7TaMKEtUuAqkAqw/PJQzshsj4OdqLXlT3jTszKY0GnoG3CaiyC3Zz+pNMfhUZzXs5Dhm2EgYsY8BwHlFqHpAz/jDzJnZPAIQ8YwJ8xr2g=;24:D8jyOWJMo87YvPb6FIcqDUcqE1+GdPWkaD/hCxxgSnhZ2u85KRkyYPTvrGJ/6k6K5gvBox8T4RG4Kd8F1SHSozNUnJBkw7Wb/K53JBwkZkw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0185;7:W/oEhbuZaZna54pqsOEGNSvVg84Qs9IEqLz9JQq0B4QGoyFybE360XFad5xMDkmLcSmILvfq9WQG7mihdanbQbexRRWpw4uSIuHdQslg5H1pdwiWkLnbZ8ZDWeJFmUQb/z7Y29e4oDSeYZ6H1caskm4NACml6qdRa8N7fBhWXHCQGIFubHo+3f2iRVxd8T+WTqBG7ZUFWrjwvl5GYPerAjwoXVE+i9hCSKE5t4Ay5ArTz3h6PUyzOmZ5HjGaJc+n;20:X+XPmjlIc9EXc5rUm1j1No/JJGmDJjbFuDLgXkkcCRnIysH8i9fzdEs/vMpV6ll+fZq6+K2wHUuBSpA5MulHaXvR1YUZKH/vYXmfk0V0EygNekxL6Z5ER2EujoFoM2Fp64xXozKaQie+v5B+KopyM4ZFSGOyGk0V9FWMYqReHb/CjvchLlSNqw+3++4XBScXTAT/h4DNLD+BNbCtKLwo3naXskX54KuADf/wTA/a5YT2B3osBrVww31Ct7QMP5Su
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 16:13:08.5218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ffd2cf-ea32-418f-85e4-08d5d536623a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-18 11:35 AM, Arnd Bergmann wrote:
> getrawmonotonic64() is deprecated because of the nonstandard naming.
> 
> The replacement functions ktime_get_raw_ns() also simplifies the callers.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c | 8 --------
>  drivers/gpu/drm/amd/display/dc/dm_services.h               | 5 ++++-
>  2 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
> index 5a3346124a01..e861929dd981 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
> @@ -35,14 +35,6 @@
>  #include "amdgpu_dm_irq.h"
>  #include "amdgpu_pm.h"
>  
> -unsigned long long dm_get_timestamp(struct dc_context *ctx)
> -{
> -	struct timespec64 time;
> -
> -	getrawmonotonic64(&time);
> -	return timespec64_to_ns(&time);
> -}
> -
>  unsigned long long dm_get_elapse_time_in_ns(struct dc_context *ctx,
>  		unsigned long long current_time_stamp,
>  		unsigned long long last_time_stamp)
> diff --git a/drivers/gpu/drm/amd/display/dc/dm_services.h b/drivers/gpu/drm/amd/display/dc/dm_services.h
> index 4ff9b2bba178..eb5ab3978e84 100644
> --- a/drivers/gpu/drm/amd/display/dc/dm_services.h
> +++ b/drivers/gpu/drm/amd/display/dc/dm_services.h
> @@ -339,7 +339,10 @@ bool dm_dmcu_set_pipe(struct dc_context *ctx, unsigned int controller_id);
>  #define dm_log_to_buffer(buffer, size, fmt, args)\
>  	vsnprintf(buffer, size, fmt, args)
>  
> -unsigned long long dm_get_timestamp(struct dc_context *ctx);
> +static inline unsigned long long dm_get_timestamp(struct dc_context *ctx)
> +{
> +	return ktime_get_raw_ns();
> +}
>  
>  unsigned long long dm_get_elapse_time_in_ns(struct dc_context *ctx,
>  		unsigned long long current_time_stamp,
> 
