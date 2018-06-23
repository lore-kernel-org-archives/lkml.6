Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6196C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2E824AED
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="f7thfl7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2E824AED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934732AbeFWCmX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 22:42:23 -0400
Received: from mail-bn3nam01on0088.outbound.protection.outlook.com ([104.47.33.88]:52333
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934625AbeFWCmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 22:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpNVoN9mfw+I0cTTm80Uu7zn32vdPiVobAlLt7UFVO8=;
 b=f7thfl7avB9KfqrTTtNK9+9GjxuLi/+l4ipVt/r1KFWqTS9IGmTcNgPweVlrWWPVzzKD/tHP90JKRgw4npP8D7wiM7i5jAZPSuLJ048foH5o1LqGJdO/WHQ8CtOpzI8SQV/RMWJZ/pbmVYWD7mzRe296a/gWA5qe6f1ZfJHAz80=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
Received: from [IPv6:2607:fea8:3ce0:41b:7c30:310e:f51f:985e]
 (2607:fea8:3ce0:41b:7c30:310e:f51f:985e) by
 BN6PR12MB1441.namprd12.prod.outlook.com (2603:10b6:405:10::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.19; Sat, 23 Jun 2018 02:42:18 +0000
Subject: Re: [PATCH] drm/amdgpu: Count disabled CRTCs in commit tail earlier
From:   Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
To:     lyude@redhat.com, amd-gfx@lists.freedesktop.org
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
 <fe73a505-e4c6-a53f-b1e7-52b22457cd3b@amd.com>
 <80f2a6d864cb7febb7465c4dfe6c2ba1753237c1.camel@redhat.com>
 <060f9881-1b06-af1f-0a09-cf3739830f56@amd.com>
Message-ID: <58818f37-93a8-55e4-10be-7d4fb5e950f6@amd.com>
Date:   Fri, 22 Jun 2018 22:42:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <060f9881-1b06-af1f-0a09-cf3739830f56@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2607:fea8:3ce0:41b:7c30:310e:f51f:985e]
X-ClientProxiedBy: YQXPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::23) To BN6PR12MB1441.namprd12.prod.outlook.com
 (2603:10b6:405:10::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d96d5f28-0d92-48fd-fe2d-08d5d8b2f073
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1441;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1441;3:Tk8ZXrE6ceKauq1YRtAgJyVfIioiaxEg3R581ibrC+UOPj3LcHp43DDSzdONg/Kr9yNGlsTsiQR6ZFW6YJ6PrefJs1k330EpSPxauIEhXcYn45kg1g+5M2h4w64/paX2xjDLxHKEkcDyeZqWinmExu/9A5KVh9DdkvLvGwG+d+uy75DXeVwlOopSL7+esaZ6xDmvxlT7zRBUATTuMvuJMO+x8FJ8F+p/OYXrXRRhGucd6HIxFw+cAHjPZupE7lGh;25:YyOJsCjtPN/RjzGektnHJzk6UXtwrczE0fcBr995juB4SLOZvs90jEhTr7NXCG63zcHumffdrLlWDOxVTg/xB8+x7QvKrepp3jvZQWVlQjIr2k/unbDDNDkeqoo1291WU+L0BNKomTn71fiefNX+5ot9teZKecGtzty0qnzSpRjuwDKanywZzfb+FtnHqVEbrcVUe13kU1BnzFCzSHLunR/uXm2hnGeYVifwTTyECq+acCv6Uuk5/BjiymzUCJB9xtJXdaoYm3xRoMl4XH+iN0Kq5FQUVN3g8fGdJFWRyGth/+CHQCOB4ZDnlO9TIvjr+LWQTjZG5VL8ARDT7EQkzA==;31:8PvXKvZ7JvgrBDjEKD8CJtekhIbhS9pR8SK29gIEnELp+/DpngKuOsIC66vcPZ0Z0f195soMwdZBkPAEFhaVwBiinqSnzWhdK5lu84/kVEBIBXCm5Jv6CZg82zrg11jTDADd1jVXWaZXnHrbJbI3DLCNUcf9q16ClHRV5VEE04Zc8TS7b8+BPMFmxvas9lUPWLLkcIQjF0FE6636rHRy/IresT31LjEyIQS5gxCnQF4=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1441:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1441;20:c8sd3gExd97GWcbkAAL/HMQ3sOrZ597q7KnI3/L7gR6Xi36x5HwAZcbdLii3+voXLlEvUbsCwomYSr5YJyKx+oBgbUkOx+kfM1VLRGnHV5RFpOZQfeWQQ0UdDmSi+SxXxEstvla0/aNy3dy8xVWQ4B08XhUab/FzYJpfjXGaP/LTxT1r+ageoC0eMweuUMaYSqD+4CJVbPFO+KvbHiQ91Xj2Ns7s2ogtN6GxfmZpMw8fKxZecmywv0zq6y/XqiW8N198U5TlhfyyWQcpeAVYEpr2lZphFoT5UPHetUmPQHQ9hpxakr5TqHfdYurs79YN1tbeL51b1QmjGM/3CLAkUsQyKKlozy7KyQ9ls3WSxCKK2xMjDy02JSsw3fCiu5qaNagBGvvDbEewYet5e/X7rJ5HdDf7iNfuJagi/Q8lWfy2BXJph4n7cnpqxOqwEj2b9VpW30Le+gm585TM7rmvwRT9AKkGyqEVce/M5kwmFKnaFHdpv/domPxY8DrkMPas;4:6wx55/pN0yyNtYTGplwY5A6AJdoTV1NpfSK+XWngOOshh/bI5ewD3LoKZbKf8+dDgLFOKssUoll3pWSYPdx3g1KddJz4dvGLHj7UOfFfW1mIw3mDmc1eu0bibVx/3J0tC5jlsaB6fjN/Ya8bMr1FRM++4VPKOHjWU5SCF2RRqqzKIzSGueGM4VuAvMXafNrTfwe57K6WTyMsYc/e8yMCRJUd/uuUstqLmPX/yugoV8z7npCi2kLHGlyiB1kklZNfD9Kx7XhDOkp2IIFKVl8rvLVY7UXgovfsDT7pK3+kc//LFJNr7wYNYjrvBBkbZjuvSSdYQzD+OBCt7eHqy1ueBsXxZgwQfNyBS3O8a+Pz+lg=
X-Microsoft-Antispam-PRVS: <BN6PR12MB1441F920189A012922E67AF0EA740@BN6PR12MB1441.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN6PR12MB1441;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1441;
X-Forefront-PRVS: 07126E493C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39380400002)(396003)(39860400002)(52314003)(199004)(189003)(51234002)(6486002)(25786009)(81156014)(54906003)(81166006)(31686004)(8936002)(1706002)(478600001)(47776003)(97736004)(6116002)(65956001)(86362001)(67846002)(65806001)(31696002)(186003)(53546011)(16526019)(46003)(305945005)(229853002)(2870700001)(52116002)(76176011)(386003)(23676004)(52146003)(36756003)(2906002)(52396003)(2486003)(59450400001)(316002)(106356001)(105586002)(6246003)(93886005)(8676002)(58126008)(7736002)(72206003)(5660300001)(50466002)(53936002)(6666003)(65826007)(446003)(64126003)(68736007)(486006)(2616005)(476003)(4326008)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1441;H:[IPv6:2607:fea8:3ce0:41b:7c30:310e:f51f:985e];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNDQxOzIzOkExTHZPd0t4VzZKUUY4aENBU2lkWFdKeUg1?=
 =?utf-8?B?ZDhkc1pOeW0yalVUUlEybUxUSXpHZTRlMjZ4Vk1lNFlvdXBYL3JoRzBhQUVm?=
 =?utf-8?B?SlBkT09la0pGVDJ1WmJFNkNnZFAvcisyWkRzOElBOFlwUE5pS3pSM1lzZkJG?=
 =?utf-8?B?a0MvQmFyV2xKMG9TSERQbUJ5SkJTTmIxaFVGY01HaTYwZTJMY0hOb3RwdlVK?=
 =?utf-8?B?WHljeXpJSHN2b1JvQnI0blZ2ek5ORHlaaHhGZ1BlR2t2Z2h1MDJpWVBEMVpt?=
 =?utf-8?B?VWorVWV2b0Rtdkl3TU5VNVhDWEZPdGg1MUZkb3lhV1pETDh3NUJZZHNjbXNn?=
 =?utf-8?B?S0lWM1ZzWU4xV2ZjcUQ0bHZSUFcxQ0tGcGJyRG5YL1Z1V3RYR0ZCajVKcmRW?=
 =?utf-8?B?S0M3Q2NqL21wMGx6UkdkSVhyMXU0Rm9OQVJZbjhidkhzb2JYVHRQTTdoRUs2?=
 =?utf-8?B?aExBVTIwQmxDTTc3V2s4Qk5KYWRLdGpadjlrcmxTelAvNThwSEZKNWROWjUw?=
 =?utf-8?B?MmRuM0IwNDJMMWJxekxoT1Y4QkNKTFVkdEtPa1c0cTFLT2RWSVptZnd5RDRE?=
 =?utf-8?B?QWJrT1pBU2NUaVRVVWgvSHpqQWNHdzZQWUM4TWZJSTJ3KzJaem42Qmt6OVE4?=
 =?utf-8?B?bm80VVIyWnlvNXFROU05YkxCZlh5OHNXdkJyWlE0QUplNXRQcDdGbTlkSnhx?=
 =?utf-8?B?ZFR0RFEveVhjREdYZDcvTGw5WVhKVGEvNGI0d25wSEJ0dng1ZmhoZ3lsZ0Z6?=
 =?utf-8?B?RU9QKy9RVTFYQWh5Qko5bENpUkkzcU9xZ0xUbTFJbk5STXh5RHVVdDhTZkFB?=
 =?utf-8?B?VzNObmxnRTB2RnZ3ZHBuY2d2T2pwMjN4Q3ltUDNtc3RBNkZKdFJIZFh5SW9S?=
 =?utf-8?B?ZVBJWFZMU2FGazA3VmVmdWtnb0U0VjYvVWIzTStaVGU1cUtteGZrdnVKNjB6?=
 =?utf-8?B?SmNtVU5RMlo5WEhRQ3FzdW5sejl5U1E3bTZrbzkzaE50VFhQZU9DZ29oT2dt?=
 =?utf-8?B?ZkZZOFBsQnJNQ3JSMXlDbHF4bXRZQnVuT3ZWMUNJNHo3VVVyVnFMSFhIajlR?=
 =?utf-8?B?QnhGQXF2U3FRWG9KQjJDRm9LL1ZKU0NLWUVRVHdzb2x1YTVLRXZjWUNGYmlm?=
 =?utf-8?B?VXZScjNUaWtWMThxWElnQThjRE9MRG1LTGJIMlhlZlJmVFd6dDlRYUdkYkRi?=
 =?utf-8?B?OXQ5SnU2b1lNNHQyZXQvaU5hS1RDMUl2bTA1VDRUdE5hWTdpVHRMUkZ6NFho?=
 =?utf-8?B?TEgwdFNlQ2JmVGxvOVVPbWZrSWNpOTExMFZFT0YxRyswZXllaG1JdDNBZzlq?=
 =?utf-8?B?MXgybVRlcXlHRWxEcUVqNStLVGhvMDVieUx3UXZwZWJsNWc4aXUxWUNSaDIy?=
 =?utf-8?B?d1Brcmg5S1ViRW5IQUdPV2VGV0dOY0ZpZko4YXQ4R1I0cjdscGIvMC81MjBi?=
 =?utf-8?B?SlBVS2EzMS8wcGIxTFA3VCtYbFkrOFFlMXBlT0ZDamwvQkF0TlVWM3VqODFz?=
 =?utf-8?B?THdnbngxa1Q2VXQrOEN4MGYrR2w3OEFYSm5pMktZbW96eS9yYUFKYUtTK0hq?=
 =?utf-8?B?U0VoMTQ0QTIzd0hreTMwQmErcGxXOUhOUk9abUFOMGxsOS9lN09nYy82YmRL?=
 =?utf-8?B?MjBUNFpSb09WbjNCZGNpVkZYbDlYemVNMmtJZnFQdVc4Q1pLdXBaQ0N5TnRL?=
 =?utf-8?B?MDVmTUFPZ2tscFRveExtdjFXOCtNdmVPTEhRUTQ1K3dyZ0Z2aEhDeDlnK0p1?=
 =?utf-8?B?TmZjWS90ZVZqNkgyd2hjamdZejRTYndBOVVCK1VvQkxvSnhwSm45L0R4azcz?=
 =?utf-8?B?SGJ2dUFTcjNpSzNXTmNRdmtoN1NHTHJrS3hrbnFuVXIyNjZmTzhBSmJTMWkr?=
 =?utf-8?B?UW9lczN6cUlseStLRnNZNTN4UWhjY2ttVTllVmFhektOU1o4SEFVTEhOUlpj?=
 =?utf-8?B?M3hUOUFJUWszK1llZVhoYnZHbUVnUGhJT0dibG5yTkJjL2lmL3B3MVluT0tG?=
 =?utf-8?B?NTNYckN5VFFvVWlkeUEveTRoMjZxNHAzZWZqUT09?=
X-Microsoft-Antispam-Message-Info: 5P+k5S0t0NDJ1bjZjaXiebGSy0e7bImTuwHlNJuk2VP9VLXUKTA8tSAHassQINav/BHW3ztzMHUgxqpC4aB1bAq+lIxq6Tn0v4P4iPbFWgQlxAQ5BPBixGFT3y7CARwHP/7qGVXKDDH1BMHXvPhN0i8XePaY2GHYrzRnkLtziD6tGovSBk39P5pSqWVaSIQOaQV7I0GxkDX/CCNCOuK3aE76EI6HBuc7MLleTTpRwMLitPeo4iexP58L9DRcJlXae/yj5pqbpZstkpwcWs3FwnwSH4Y96p/KiClT0DouH/j8W2tIpTZWKvxKBqnMzozOBkaFUaxVME2hTwZ9zsx+ntJsCSoBYsDMFQBNcA2w0m8=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1441;6:DKhmeZxaM5CTmfNg7JqIr2J1x2QygPMjeG3EFxl3U8iDYGYJrnE3JBsFLSaYXhQ/3yOCWdhJgatCgY7lYfTs5v1SxEqQIPKsVW28tB3PRml9afPsoBTh8cpkVowDbi3D5iZm8VhQ4z/p1x64GazbrXXVuXX9lwrj8P279tyNm08LZ9GPh0kri0jLktVruPvnsuOeB3+MFezM1jsuAHRtTOjiK2hYLm42m0skfLbQ1sp2myNkkuKDJY34rn0AZXJ2+h1m3m/u//ZnvRBLA2GObg6HiZs1uGEfTZPkF1GSmFSJ/+j9OOOHgaho+uNOKJNAMR//AI2i+/nO/zfjk7pphpIzP1jaUqJGpCkex6W1yqi3qJYwGlZZONHf4eg0Rcudc7J96PewIFF+x/bAjao2No1dlHNqEeklOA5KOBCtsI2Q8IgaN1uRMee1QnQ5CKXXKdUIVei3Jn7DUEtoKa76/g==;5:RzxK5RMLUhSIm3/1pe5T2QnFI9rajA0iul9pA4z+xgdmeUOUqj2p7qCyr040piI9TE8C1bfWaAnnBio6eU9tXg06t9QG3vKvYGmcO6GfT8Q0+NwFPEyNI/UMuTcbuwUSeA40oxuDNkP2cQlPY1x/DZ18he3ByORx2nTfz3q/z7g=;24:sA8XbNthNSsPjd3hNmbbQvJ+M78y4JlvoL5p9XhvE18jNRSxW3ctpiLN1wTgAsWI0Yt18tCl7w9ycZBWFvctOoDmgnNtyYklPykJrB59uEc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1441;7:30MnJ0PLa0BPQEQZdKiCD7i7xNfQb5Qn/zV+Wm7mJERIrX/OnfPr0ttu7LmahUcIW9essUtN8fJ+0ygWmqcY/jDyPC1KmxYctBRQcN8C+u90loFN2M0Yc29+EzX9uLtBJbRqEcs3bs3is7EvKt5dj0mMTiz59Oop/DUt9W86gVc+ZAAejdupj+41JEOb8OEqOAHKFjfSYWXbzuwhPEEDUFpCOD4xPL0SK/GAQMFTO7RGlQRc/wo3p0OafzeZLwHG;20:UAjTACCFHdmjE5E2BhR8bRVvnHZ2PNJeUphDlmwol4eHZLE/BTlrVKZbDNAA/AQgSxoIsu6bbfOUGPwv2V26zcpvU3v8OKcDtFbXASTDkbZaBdWOwfA+RYNlaKos4yimCs/ehl2uRyh8DZuLZLVV1B2lZ6GaFSKIp3JLJDi9urByralJ0ybGEp5P7NAlSNsHnJ7331A9QN+21MP5+XbUZG+TfAXXNrvZeAci8tqgfzHi2vCAgFTG6FGfYoJHScTB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2018 02:42:18.2704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d96d5f28-0d92-48fd-fe2d-08d5d8b2f073
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1441
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/22/2018 09:03 PM, Andrey Grodzovsky wrote:
>
>
> On 06/22/2018 02:56 PM, Lyude Paul wrote:
>> On Fri, 2018-06-22 at 13:34 -0400, Andrey Grodzovsky wrote:
>>> On 06/21/2018 04:48 PM, Lyude Paul wrote:
>>>> This fixes a regression I accidentally reduced that was picked up by
>>>> kasan, where we were checking the CRTC atomic states after DRM's 
>>>> helpers
>>>> had already freed them. Example:
>>>>
>>>> ==================================================================
>>>> BUG: KASAN: use-after-free in
>>>> amdgpu_dm_atomic_commit_tail.cold.50+0x13d/0x15a [amdgpu]
>>>> Read of size 1 at addr ffff8803a697b071 by task kworker/u16:0/7
>>>>
>>>> CPU: 7 PID: 7 Comm: kworker/u16:0 Tainted: G O      4.18.0-
>>>> rc1Lyude-Upstream+ #1
>>>> Hardware name: HP HP ZBook 15 G4/8275, BIOS P70 Ver. 01.21 05/02/2018
>>>> Workqueue: events_unbound commit_work [drm_kms_helper]
>>>> Call Trace:
>>>>    dump_stack+0xc1/0x169
>>>>    ? dump_stack_print_info.cold.1+0x42/0x42
>>>>    ? kmsg_dump_rewind_nolock+0xd9/0xd9
>>>>    ? printk+0x9f/0xc5
>>>>    ? amdgpu_dm_atomic_commit_tail.cold.50+0x13d/0x15a [amdgpu]
>>>>    print_address_description+0x6c/0x23c
>>>>    ? amdgpu_dm_atomic_commit_tail.cold.50+0x13d/0x15a [amdgpu]
>>>>    kasan_report.cold.6+0x241/0x2fd
>>>>    amdgpu_dm_atomic_commit_tail.cold.50+0x13d/0x15a [amdgpu]
>>>>    ? commit_planes_to_stream.constprop.45+0x13b0/0x13b0 [amdgpu]
>>>>    ? cpu_load_update_active+0x290/0x290
>>>>    ? finish_task_switch+0x2bd/0x840
>>>>    ? __switch_to_asm+0x34/0x70
>>>>    ? read_word_at_a_time+0xe/0x20
>>>>    ? strscpy+0x14b/0x460
>>>>    ? drm_atomic_helper_wait_for_dependencies+0x47d/0x7e0 
>>>> [drm_kms_helper]
>>>>    commit_tail+0x96/0xe0 [drm_kms_helper]
>>>>    process_one_work+0x88a/0x1360
>>>>    ? create_worker+0x540/0x540
>>>>    ? __sched_text_start+0x8/0x8
>>>>    ? move_queued_task+0x760/0x760
>>>>    ? call_rcu_sched+0x20/0x20
>>>>    ? vsnprintf+0xcda/0x1350
>>>>    ? wait_woken+0x1c0/0x1c0
>>>>    ? mutex_unlock+0x1d/0x40
>>>>    ? init_timer_key+0x190/0x230
>>>>    ? schedule+0xea/0x390
>>>>    ? __schedule+0x1ea0/0x1ea0
>>>>    ? need_to_create_worker+0xe4/0x210
>>>>    ? init_worker_pool+0x700/0x700
>>>>    ? try_to_del_timer_sync+0xbf/0x110
>>>>    ? del_timer+0x120/0x120
>>>>    ? __mutex_lock_slowpath+0x10/0x10
>>>>    worker_thread+0x196/0x11f0
>>>>    ? flush_rcu_work+0x50/0x50
>>>>    ? __switch_to_asm+0x34/0x70
>>>>    ? __switch_to_asm+0x34/0x70
>>>>    ? __switch_to_asm+0x40/0x70
>>>>    ? __switch_to_asm+0x34/0x70
>>>>    ? __switch_to_asm+0x40/0x70
>>>>    ? __switch_to_asm+0x34/0x70
>>>>    ? __switch_to_asm+0x40/0x70
>>>>    ? __schedule+0x7d6/0x1ea0
>>>>    ? migrate_swap_stop+0x850/0x880
>>>>    ? __sched_text_start+0x8/0x8
>>>>    ? save_stack+0x8c/0xb0
>>>>    ? kasan_kmalloc+0xbf/0xe0
>>>>    ? kmem_cache_alloc_trace+0xe4/0x190
>>>>    ? kthread+0x98/0x390
>>>>    ? ret_from_fork+0x35/0x40
>>>>    ? ret_from_fork+0x35/0x40
>>>>    ? deactivate_slab.isra.67+0x3c4/0x5c0
>>>>    ? kthread+0x98/0x390
>>>>    ? kthread+0x98/0x390
>>>>    ? set_track+0x76/0x120
>>>>    ? schedule+0xea/0x390
>>>>    ? __schedule+0x1ea0/0x1ea0
>>>>    ? wait_woken+0x1c0/0x1c0
>>>>    ? kasan_unpoison_shadow+0x30/0x40
>>>>    ? parse_args.cold.15+0x17a/0x17a
>>>>    ? flush_rcu_work+0x50/0x50
>>>>    kthread+0x2d4/0x390
>>>>    ? kthread_create_worker_on_cpu+0xc0/0xc0
>>>>    ret_from_fork+0x35/0x40
>>>>
>>>> Allocated by task 1124:
>>>>    kasan_kmalloc+0xbf/0xe0
>>>>    kmem_cache_alloc_trace+0xe4/0x190
>>>>    dm_crtc_duplicate_state+0x78/0x130 [amdgpu]
>>>>    drm_atomic_get_crtc_state+0x147/0x410 [drm]
>>>>    page_flip_common+0x57/0x230 [drm_kms_helper]
>>>>    drm_atomic_helper_page_flip+0xa6/0x110 [drm_kms_helper]
>>>>    drm_mode_page_flip_ioctl+0xc4b/0x10a0 [drm]
>>>>    drm_ioctl_kernel+0x1d4/0x260 [drm]
>>>>    drm_ioctl+0x433/0x920 [drm]
>>>>    amdgpu_drm_ioctl+0x11d/0x290 [amdgpu]
>>>>    do_vfs_ioctl+0x1a1/0x13d0
>>>>    ksys_ioctl+0x60/0x90
>>>>    __x64_sys_ioctl+0x6f/0xb0
>>>>    do_syscall_64+0x147/0x440
>>>>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>>
>>>> Freed by task 1124:
>>>>    __kasan_slab_free+0x12e/0x180
>>>>    kfree+0x92/0x1a0
>>>>    drm_atomic_state_default_clear+0x315/0xc40 [drm]
>>>>    __drm_atomic_state_free+0x35/0xd0 [drm]
>>>>    drm_atomic_helper_update_plane+0xac/0x350 [drm_kms_helper]
>>>>    __setplane_internal+0x2d6/0x840 [drm]
>>>>    drm_mode_cursor_universal+0x41e/0xbe0 [drm]
>>>>    drm_mode_cursor_common+0x49f/0x880 [drm]
>>>>    drm_mode_cursor_ioctl+0xd8/0x130 [drm]
>>>>    drm_ioctl_kernel+0x1d4/0x260 [drm]
>>>>    drm_ioctl+0x433/0x920 [drm]
>>>>    amdgpu_drm_ioctl+0x11d/0x290 [amdgpu]
>>>>    do_vfs_ioctl+0x1a1/0x13d0
>>>>    ksys_ioctl+0x60/0x90
>>>>    __x64_sys_ioctl+0x6f/0xb0
>>>>    do_syscall_64+0x147/0x440
>>>>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>>
>>>> The buggy address belongs to the object at ffff8803a697b068
>>>>    which belongs to the cache kmalloc-1024 of size 1024
>>>> The buggy address is located 9 bytes inside of
>>>>    1024-byte region [ffff8803a697b068, ffff8803a697b468)
>>>> The buggy address belongs to the page:
>>>> page:ffffea000e9a5e00 count:1 mapcount:0 mapping:ffff88041e00efc0 
>>>> index:0x0
>>>> compound_mapcount: 0
>>>> flags: 0x8000000000008100(slab|head)
>>>> raw: 8000000000008100 ffffea000ecbc208 ffff88041e000c70 
>>>> ffff88041e00efc0
>>>> raw: 0000000000000000 0000000000170017 00000001ffffffff 
>>>> 0000000000000000
>>>> page dumped because: kasan: bad access detected
>>>>
>>>> Memory state around the buggy address:
>>>>    ffff8803a697af00: fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>>>    ffff8803a697af80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>>>> ffff8803a697b000: fc fc fc fc fc fc fc fc fc fc fc fc fc fb fb fb
>>>>                                                                ^
>>>>    ffff8803a697b080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>>>    ffff8803a697b100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>>> ==================================================================
>>>>
>>>> So, we fix this by counting the number of CRTCs this atomic commit 
>>>> disabled
>>>> early on in the function before their atomic states have been 
>>>> freed, then
>>>> use
>>>> that count later to do the appropriate number of RPM puts at the 
>>>> end of the
>>>> function.
>>> I am a bit not clear, are you saying that the problem was the 'in the
>>> middle' commit (cursor ioctl) doing
>>>
>>> drm_atomic_state_default_clear->dm_crtc_destroy_state->kfree(state)
>>>
>>> where the state is the one you access from from the non blocking 
>>> part of
>>> page flip though old_crtc_state->active?
>> The problem is that (see the comment in 
>> drivers/gpu/drm/drm_atomic_helper.c:2065
>> ) it's unsafe to touch any of the old_crtc_state structures after
>> drm_atomic_helper_commit_hw_done() is called, as it's likely that 
>> they've been
>> freed already.
>
> I  am not sure about that, the comment in 
> drm_atomic_helper_commit_hw_done says that
> "the driver is not allowed to read or change any permanent software
> or hardware modeset state" I interpret it as not the old_crtc_state 
> but as the new_crtc_state or crtc->state after
> drm_atomic_helper_swap_state completed.  It means that if you touch 
> crtc->state after drm_atomic_helper_commit_hw_done
> you actually could already be accessing a state which belong to the 
> next atomic commit after you.
> It really looks like cursor's atomic commit sneaks in in a middle of 
> page flip between the page flip IOCTL
> and it's commit_tail part and swaps away crct->state to his own new 
> state and release the 'old' state which is not really
> old yet and needs to be used by the tail part of page flip. This makes 
> sense since do_aquire_global_lock we use in amdgpu_dm_atomic_check
> to serialize against concurrent atomic_commits  is not called for case 
> of cursor plane and so it may race against any commit_tail in flight...
> Not sure why we haven't seen this problem before.
> Obviously your fix makes the problem go away since you stopped 
> accessing the new_crtc_state and not the old_crtc_state but the root 
> problem
> seems to me still there.
>
> Andrey

I took another look and actually no problem with the CURSOR IOCTL as it 
will wait in drm_atomic_helper_swap_state for hw_done event, so
I agree with the fix but just disagree with the explanation, it should 
be said that it's unsafe to touch the new_crtc_state (same as 
crtc->state) after
call to drm_atomic_helper_commit_hw_done. So I would make the 
explanation a bit more detailed on this point.

Anyway, the fix is Reviewed-by: Andrey Grodzovsky 
<andrey.grodzovsky@amd.com>

Andrey



>
>>> Andrey
>>>> Fixes: 97028037a38ae ("drm/amdgpu: Grab/put runtime PM references in
>>>> atomic_commit_tail()")
>>>> Signed-off-by: Lyude Paul <lyude@redhat.com>
>>>> Cc: Michel Dänzer <michel@daenzer.net>
>>>> Reported-by: Michel Dänzer <michel@daenzer.net>
>>>> ---
>>>>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++----
>>>>    1 file changed, 6 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> index f9add85157e7..689dbdf44bbf 100644
>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> @@ -4206,6 +4206,7 @@ static void amdgpu_dm_atomic_commit_tail(struct
>>>> drm_atomic_state *state)
>>>>        struct drm_connector *connector;
>>>>        struct drm_connector_state *old_con_state, *new_con_state;
>>>>        struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
>>>> +    int crtc_disable_count = 0;
>>>>           drm_atomic_helper_update_legacy_modeset_state(dev, state);
>>>>    @@ -4410,6 +4411,9 @@ static void 
>>>> amdgpu_dm_atomic_commit_tail(struct
>>>> drm_atomic_state *state)
>>>>            struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
>>>>            bool modeset_needed;
>>>>    +        if (old_crtc_state->active && !new_crtc_state->active)
>>>> +            crtc_disable_count++;
>>>> +
>>>>            dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
>>>>            dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
>>>>            modeset_needed = modeset_required(
>>>> @@ -4463,11 +4467,9 @@ static void amdgpu_dm_atomic_commit_tail(struct
>>>> drm_atomic_state *state)
>>>>         * so we can put the GPU into runtime suspend if we're not 
>>>> driving
>>>> any
>>>>         * displays anymore
>>>>         */
>>>> +    for (i = 0; i < crtc_disable_count; i++)
>>>> +        pm_runtime_put_autosuspend(dev->dev);
>>>>        pm_runtime_mark_last_busy(dev->dev);
>>>> -    for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
>>>> new_crtc_state, i) {
>>>> -        if (old_crtc_state->active && !new_crtc_state->active)
>>>> -            pm_runtime_put_autosuspend(dev->dev);
>>>> -    }
>>>>    }
>>>
>

