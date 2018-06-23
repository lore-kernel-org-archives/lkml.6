Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B684C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 01:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CB524A68
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 01:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Kx+Pn8AU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65CB524A68
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934516AbeFWBEN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 21:04:13 -0400
Received: from mail-eopbgr720061.outbound.protection.outlook.com ([40.107.72.61]:19136
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933773AbeFWBEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 21:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6tWMCu9lB6OwOMKrYmS3n2Fk+u60cxuXqFdKF0KFog=;
 b=Kx+Pn8AUpeJBSMjGUWLncyQ9KrsJU5lqKuxAPcRDLJjBgvBk1wmdA3yC9lyayRylsgyXoIJYrwYlYlnEWO7W3uBzJlNG9ATyvAVJpPpfx87afKUUSpnqGpgpc5GvE2AjTwrwWpX5P1hckXM1QAoCIxhsh4hVu3VR7MYgp34nz9c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
Received: from [IPv6:2607:fea8:3ce0:41b:7c30:310e:f51f:985e]
 (2607:fea8:3ce0:41b:7c30:310e:f51f:985e) by
 BN6PR12MB1441.namprd12.prod.outlook.com (2603:10b6:405:10::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.19; Sat, 23 Jun 2018 01:04:05 +0000
Subject: Re: [PATCH] drm/amdgpu: Count disabled CRTCs in commit tail earlier
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
From:   Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <060f9881-1b06-af1f-0a09-cf3739830f56@amd.com>
Date:   Fri, 22 Jun 2018 21:03:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <80f2a6d864cb7febb7465c4dfe6c2ba1753237c1.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2607:fea8:3ce0:41b:7c30:310e:f51f:985e]
X-ClientProxiedBy: YQBPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::38) To BN6PR12MB1441.namprd12.prod.outlook.com
 (2603:10b6:405:10::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c13539d-0f63-43e0-976f-08d5d8a53857
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1441;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1441;3:T9O8MPaH1b+kAdUxLo2MABtfVg81ixycyPC7yW1IsXs+RO3GY+jn5EShLd53jmCTLZ/ORAxjEJ7Zu2WM9PXuInj06i9PXkmUMiRjWNoS2GgtFSUEpcPYs3JDSGRxitdAKDnPe1UUSXrWxj4S8Nh+i/0HJxnPb3se+fMaHmNKE/asPZQix6RLouRZZXACKl6EHfxyv9P/WOybpgqlwqUeMFbDAXL5aEZnANiI2JNOiUSEcCRjPWS+Yxtuz14p7H0z;25:I3Nih0Qeyj4iMmdWQcTvYLmaztZeX1OrlkHQ4FqGMl4XfhDYv8LP3KVlVY9M9AAuyIyAspcAytQf5Un9Uua6nABx5OyNGBXzApPxHUAlTWzchycLUgzcjqMZwPLYLfElB2V6HSfELNSVdgnuFzn+LweYdbFgziGHVqiY5LoXMPriV+U6zWuaHhXxeRNZjZG7415ZWzZWS5KegyzjYltAtZDw+t8e2Zg3GtoPudxMx78uG3dixer6qE9AYTB1HHgq1ksvH/y3VVlcKikhRZ4KaFqrJaWLA7qMn8L4oOhA7EmqyPzWHsfcn3ciynA0fHHi6j1lzp++zNwO1pBpfcki4g==;31:olHHimKd3Twk4kF7VQAuDz9oEXn6OT3goY7zzndTt0hAnWbDGNYfZKbtyHG2mJog8RAidIzTUZhMBZhrOrXiXTdgeobOwuZFh6clI96m+wh/NAAI39gOB4lfyPD9Ohp8NhYtxWRiv2+r8ZPWcg5sVVx2D2ON4xxsvPXuozpxCBy0MO+kvBK2qJ0zL36dopL203a57imoxzLUtA/FIGLA1s6xAIv4vXJ7NugEzn2F+zM=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1441:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1441;20:QMD6SfUQHFFSJdkhLpzw6TNWWviDtk/LuMphKvfBiPx5MVyLyXNs4d9X2SU1EqtTloBXWFgs7kcNmNzLF5oF/PulGzNxbTPXUDfX9HVcN57IY6laEpQbFAMFwcn9+BdemMv2EtDcMVk5iF1vQGCOPQ4W9NqyLhNN3vTe+ZF+EWFZi0KwauHzSF3tmiZlKr9cegXrm3RbsDrzvwdkH3O17hZghTHc4Am1Ur+BWTGQYJz18iVU71Ooqw7iwoeaxJ9XuIW/krOIhz99VUF3MJjeJ3DecV5SbRrrtdaBj7vHZ1HyiieEwW0UbGw342eqh3FDoJRCTLnm9/wY/X88NVuyaTUAy/hEICqa68G8aE2/EsZoeKBjrpc048bo+UjrU2E4W4hlXY9FGKH2ZW1/cvo1YEeduHPh4OqE53wssBdx5Tk4mS3A3546OPUQVcCMDe4+u+GT2CJx6+55JlJvnxt98mzh7NHwRhRkOJWy5Vrfe4oX0ECH1Lc7oc0FSUJZvm9s;4:lk1Z/HImwa/dnwMXWtLin4GnK0BYWkPWKrmXO9/DGzW+XLtiJRPgk3J5q/Aw3bqSlGBP1p9RV4f+xSVwAGyYsJbGU1WqdTGjUfDTC6Lobv30LJD3YPqsONA9pdY9gJf1gsMSILHEXmInO6CQcfVefcxHz+9NbeHuvvlrk0xunOO4czqRkon1sEf+5qFugTc+Fagg46JpBX5NCAzvc7q/xz5kgbQGdMz1++gt7gFXwqyz7Z7DQc8kweTpDyRxzYoEgl3xS7CRyh6wHMLyHU+/DyAMC16lnIr1sjJ9dHAT+q3p8JJpcT3s4KCFVLIuUo8y
X-Microsoft-Antispam-PRVS: <BN6PR12MB14411AEFD3B04943CB968A96EA740@BN6PR12MB1441.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN6PR12MB1441;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1441;
X-Forefront-PRVS: 07126E493C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(366004)(39380400002)(51234002)(189003)(199004)(5660300001)(50466002)(72206003)(58126008)(8676002)(7736002)(6246003)(64126003)(68736007)(486006)(446003)(2616005)(476003)(4326008)(11346002)(53936002)(65826007)(6666003)(47776003)(97736004)(25786009)(6486002)(31686004)(478600001)(1706002)(8936002)(81156014)(81166006)(54906003)(2870700001)(76176011)(52116002)(305945005)(229853002)(316002)(106356001)(105586002)(386003)(36756003)(52146003)(23676004)(59450400001)(2486003)(52396003)(2906002)(65956001)(65806001)(31696002)(6116002)(86362001)(67846002)(16526019)(46003)(186003)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1441;H:[IPv6:2607:fea8:3ce0:41b:7c30:310e:f51f:985e];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNDQxOzIzOmdCTHhQa1BLdkd6UWhodkcxbGNrUVIxeXZU?=
 =?utf-8?B?SmlxcFdiSVRBL25sQXZvYVlnRmlWUEU5TlJjUVRUclNjcDhzTldia3J3QUV3?=
 =?utf-8?B?T2VjV2phM0hoWDZQVDdDUTZ4UE5Wc3FubFIzaEM1aXNmMGpsWWFvMENIN0xI?=
 =?utf-8?B?WHYyYlpMYm9uQzNMR2ZGS1hzenU5OWJiRHZxcUkzUkVBalBqN01mc1VxakpJ?=
 =?utf-8?B?MGJPd0cvVEZRTzgxV2ZsYUhpTGNQdHd4a2hJUUJyem93dTg4YWd2aUtCYldX?=
 =?utf-8?B?eDlDSTVKVUdyZVVjZnM5cXVNZWoxd1ZLR2FFemRQcEhVS3h2cEgwZDRrZmtI?=
 =?utf-8?B?MUJiU3A1b0RzbnF1MFl6ODRkckhNdHJJY2xURGhpWHptZjJHTTl4aHp0MjdY?=
 =?utf-8?B?YmdNZ1Z6SmdTQUM4bXkzZmh3VkROVGJveDNHUGdhdXlCVlRxQ0lZS08rQS83?=
 =?utf-8?B?akRWTHYyZFdPNGwvMU1nSk9Rd1M1QXNJaytzd1ozMkxxK2RyckFIZmg1RlhF?=
 =?utf-8?B?azBmY2RtaGtrdGJRdzlrYTZ0OEZ5cTJhMk5qTTJrTmM1cC91MjlCblBaM2wr?=
 =?utf-8?B?ZldPUUNFR0JUYzhtVlc0Mi9pWVVzcndPSGhlSjNJbkFMdVIzUWNxZjE4TXI5?=
 =?utf-8?B?dzAya092dUtKdzl3d1JqVk9YbHNqUFdhRmJ4WkZCRVNsSkorZFFTYnh4ZktT?=
 =?utf-8?B?aDE4RU9IVEpYaERuK0pzTlhrTFBXNHE0ZlFMVUthWUtsM25wWHRiZjBjMGor?=
 =?utf-8?B?aG5NK2F1ZkxMZjd4cGVsQkxWTW9OeEZ0bGU3a2FEOEc0dGdkZGxYR1pRNVBZ?=
 =?utf-8?B?ejdEU1FINmNDNCtqSUlwcUh6SkZobVRad1UrVmVBbXZSajFmc1pvekNDU0NV?=
 =?utf-8?B?OEc1TGtieXBWOGNvZTQ2L0FQU2FXRHRLUTNXZ3Bib2hzYUp1Rmt0TEg3NGJh?=
 =?utf-8?B?RC8yclZCV2JTeGp0UHBnZU9CYXRFRGdBNEpQMzUrOHQ2dDNHRkxrSDRLejBG?=
 =?utf-8?B?Y29VTmYrNm5OM3BZZTJpQWRVbUx4OUhEZnhXVmNBemhnMERCMWpYdmVlK3RR?=
 =?utf-8?B?YXpaei9SWWlQbzRWWmdlaHBkaldQL3hFR1lERVlFTUppemQ5cWRaZDhIaDJz?=
 =?utf-8?B?YjV1eXVoalp0UDhqMGE0VXNpS252TWFKc0Q0MWRCMFdDcGNOS3l5b2IwVFpx?=
 =?utf-8?B?dTBsWW1VZHhQNnFuSTUvdWc5R1laSHM2MndjMlhNQUhhYms4OFloc3FvcHpl?=
 =?utf-8?B?UldhR01lb3AzTTllNnBzTGN6NW1wODZ4Y1NqQ3kwK3RoblFuUUdwSkM5T1c5?=
 =?utf-8?B?WEJJL2lqRURuSUlWK1VncU1sWTlaMk1HODVIdkxUWDlsQkhjRVJ1RGJLTXky?=
 =?utf-8?B?NWJLMG5CMS9HeStOTFhsR0k5UTNQZ0tkVzgrWHJHZHhoNEo2YUF2UExPNlVy?=
 =?utf-8?B?aENmZE40TW1yOWNtYXl2eGlnSEZUcG9ENEtoOStwME00NmRZZlJPbTY1QkFU?=
 =?utf-8?B?WmhhNkl3bDdrWlFtQThiVnh1ZkMxVnVlSE1PMzlqcTEzSDg3Y1JEL1RTQlZv?=
 =?utf-8?B?VUxxTmtmQ2p2ZGhoWjVBakl6TWYrN0JHaVNqRFB0ZkNERHZpRmE3elRVZFVw?=
 =?utf-8?B?dldtMm43ZGd4QVlLUlFEcG5vaXlaMGJnZ3YrNnMrem96YzNZOUh5QVlKa1lI?=
 =?utf-8?B?SWxwclM5dzFBSWJiOG5TcnZ0MVJSQWVIdjJocGpSS1R4QnpGaW11UTNkekdm?=
 =?utf-8?B?SHRTZnpRN28rTTZXdDhqUkhCbVE3Z2U2ZTFOcGJKTzhVVXVpSmZmdEl2RnFW?=
 =?utf-8?B?dXdoaFdJZ3VYc1RBMGVIWjlYajNETU8yYXczUEUwc2NQaDk1RlNIT1duakpy?=
 =?utf-8?B?SGE1eFJ5SFJEQ0NrbzNnWFRkM1lpM3RlZVY5dUZrSmpvYVpaUTNNeGRQQ1VO?=
 =?utf-8?Q?IL2S/U3EMhh4ymSUafn+TNy3bZKGGA=3D?=
X-Microsoft-Antispam-Message-Info: 3zx09WlpS5Jw1YVtjYXcxiuxwqRogz/Aj7/WCJNAbH5efoV0ZfMBA1NY6LtmOuM+MAjhc+gnLoljwHigCwCkfcvz2ACDvpr0IcOd3O+HJ5yHPdS3/2oSU6GP0WGfYOhNhpkKl07y9UjEj2G1oF8bYtMQlSX6PD/rpO1YgnSqeqPfTlVlMvU8mXOlo1yPmHxUMP4eWeK4O7O3BEwO1Fi1r3g9z1+YyNnp7aHUxPHQgNWyHVHBzzVP61Cc/NIPCiGQLa5t5TkRAjVBmuTTRayJqdJBqtb+ZNGs70pPbAqAHifq/uPEgs/FaOwi6sgUg5EmmF6DyiIRhUuulAhZDA3I6C9lFlWsYV5t858zJMDKAII=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1441;6:RCpS3VL/dlNWHYVHsR2Lm15SSoVF8qLpe2hmu8bjsIfr0dNvEcQnZGM8Uz8JDCqZZiQRFNRqr+0fClkv7Wggxdqr7thTMtYnwuyQ7r6N/R8oe15XzFIIY/KUzDbUFa8WPy4r/HBYjF3H2/E/vUOT57A8ar7v0tKfLnJ2bqz8izEyHjtXFXxINwOg2Jj252c1sutgq7D8p5eTdOQFl2eztrDPASxao8PRKgp8FUxc/cb8npMBv80JnUUgzWA8yj6faX4cDIs9vJFFuXLD/r3qlMblADjIXBO7iwfiqcuLsqyHeRW24PZVIBGOzClRie2LxtV7fJllZ53hqlo1U8Fpv5v9/TWo3/x2CQS5Gycr0rP8efnrfFk10Csb1Ci6mVahokSqXHe2Mkg6/kKFXkY3ddWAI91mgue/pOofNStQAg0ic+femPtGkIOOMMqy0yBjLXBrjNKzrR5YCxZ0EhbPsg==;5:3rZmYpePbIKJTxpvgIiiBYKWT/FNAuzSDxjM2vkK4F7lPuOmrxN9KyvkXwlwmqp8pl9KDpuaq9t8IruebrfzMn2wPd8OL2HJF+t93YjhWqqOzWl75W7ek4OXJUhAC+Ehc4lwM3HUbSkdQYXOkXAJgtmbkYOyQpUvGMKeABQmQ4M=;24:Djxw5sBnqIpjbGZsOx2lxX25lXI7AR3JvXBBJmEtgRu0Xw9xKm/xirTyfRK0hzte6ceMGB533ACLLzxFgAhRYi/IOHWZqqg+OA2OD/T7Pgo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1441;7:QxjjFF6cIMmAvm685rlhGQbdjtiXyRHe5nYav80tojvqYcO4D5su8VMHD2wbnDDGSf1j7nChHl8hziGGURKA/lk+Gj99FwZCzJuTApKJzmO0+jQLPfT6dcQaWHpDmOQ7XQ4dG3QJ3Jx7LYyjHlGom06S3QG+ERLllcfodmOELo32kacpI+BjzN6bKMVxg/L+a5ttiHQxL5hMiLzovG3BzqlZUprAGgPQa8JHTXTsoI5h6tI27SSRNs+xWhScpHc2;20:YTJfq/YpXGi3Y3vp51cAAtAMD2zdjt3IdAs93d0pdYzZoYGRvtX+5IivDYN1HT6puKJE5M8O9bvIQF/pyc9yuygCM8ZAT1t9LUKPMMuDp7tIFul3JvRICrj39rxDrPTmNmVPF6txvtg+YZP7/8/gC8CCmq26i1Qbhb4/xshzxlHv08lH5CaOPlhBlSmoKBZyE+KdLPOHviufE7Z11jOhgFhe1jSRZao2FESSCsxaoqHOwKP+pO0AlRY5zVZqbRPk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2018 01:04:05.8636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c13539d-0f63-43e0-976f-08d5d8a53857
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1441
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/22/2018 02:56 PM, Lyude Paul wrote:
> On Fri, 2018-06-22 at 13:34 -0400, Andrey Grodzovsky wrote:
>> On 06/21/2018 04:48 PM, Lyude Paul wrote:
>>> This fixes a regression I accidentally reduced that was picked up by
>>> kasan, where we were checking the CRTC atomic states after DRM's helpers
>>> had already freed them. Example:
>>>
>>> ==================================================================
>>> BUG: KASAN: use-after-free in
>>> amdgpu_dm_atomic_commit_tail.cold.50+0x13d/0x15a [amdgpu]
>>> Read of size 1 at addr ffff8803a697b071 by task kworker/u16:0/7
>>>
>>> CPU: 7 PID: 7 Comm: kworker/u16:0 Tainted: G           O      4.18.0-
>>> rc1Lyude-Upstream+ #1
>>> Hardware name: HP HP ZBook 15 G4/8275, BIOS P70 Ver. 01.21 05/02/2018
>>> Workqueue: events_unbound commit_work [drm_kms_helper]
>>> Call Trace:
>>>    dump_stack+0xc1/0x169
>>>    ? dump_stack_print_info.cold.1+0x42/0x42
>>>    ? kmsg_dump_rewind_nolock+0xd9/0xd9
>>>    ? printk+0x9f/0xc5
>>>    ? amdgpu_dm_atomic_commit_tail.cold.50+0x13d/0x15a [amdgpu]
>>>    print_address_description+0x6c/0x23c
>>>    ? amdgpu_dm_atomic_commit_tail.cold.50+0x13d/0x15a [amdgpu]
>>>    kasan_report.cold.6+0x241/0x2fd
>>>    amdgpu_dm_atomic_commit_tail.cold.50+0x13d/0x15a [amdgpu]
>>>    ? commit_planes_to_stream.constprop.45+0x13b0/0x13b0 [amdgpu]
>>>    ? cpu_load_update_active+0x290/0x290
>>>    ? finish_task_switch+0x2bd/0x840
>>>    ? __switch_to_asm+0x34/0x70
>>>    ? read_word_at_a_time+0xe/0x20
>>>    ? strscpy+0x14b/0x460
>>>    ? drm_atomic_helper_wait_for_dependencies+0x47d/0x7e0 [drm_kms_helper]
>>>    commit_tail+0x96/0xe0 [drm_kms_helper]
>>>    process_one_work+0x88a/0x1360
>>>    ? create_worker+0x540/0x540
>>>    ? __sched_text_start+0x8/0x8
>>>    ? move_queued_task+0x760/0x760
>>>    ? call_rcu_sched+0x20/0x20
>>>    ? vsnprintf+0xcda/0x1350
>>>    ? wait_woken+0x1c0/0x1c0
>>>    ? mutex_unlock+0x1d/0x40
>>>    ? init_timer_key+0x190/0x230
>>>    ? schedule+0xea/0x390
>>>    ? __schedule+0x1ea0/0x1ea0
>>>    ? need_to_create_worker+0xe4/0x210
>>>    ? init_worker_pool+0x700/0x700
>>>    ? try_to_del_timer_sync+0xbf/0x110
>>>    ? del_timer+0x120/0x120
>>>    ? __mutex_lock_slowpath+0x10/0x10
>>>    worker_thread+0x196/0x11f0
>>>    ? flush_rcu_work+0x50/0x50
>>>    ? __switch_to_asm+0x34/0x70
>>>    ? __switch_to_asm+0x34/0x70
>>>    ? __switch_to_asm+0x40/0x70
>>>    ? __switch_to_asm+0x34/0x70
>>>    ? __switch_to_asm+0x40/0x70
>>>    ? __switch_to_asm+0x34/0x70
>>>    ? __switch_to_asm+0x40/0x70
>>>    ? __schedule+0x7d6/0x1ea0
>>>    ? migrate_swap_stop+0x850/0x880
>>>    ? __sched_text_start+0x8/0x8
>>>    ? save_stack+0x8c/0xb0
>>>    ? kasan_kmalloc+0xbf/0xe0
>>>    ? kmem_cache_alloc_trace+0xe4/0x190
>>>    ? kthread+0x98/0x390
>>>    ? ret_from_fork+0x35/0x40
>>>    ? ret_from_fork+0x35/0x40
>>>    ? deactivate_slab.isra.67+0x3c4/0x5c0
>>>    ? kthread+0x98/0x390
>>>    ? kthread+0x98/0x390
>>>    ? set_track+0x76/0x120
>>>    ? schedule+0xea/0x390
>>>    ? __schedule+0x1ea0/0x1ea0
>>>    ? wait_woken+0x1c0/0x1c0
>>>    ? kasan_unpoison_shadow+0x30/0x40
>>>    ? parse_args.cold.15+0x17a/0x17a
>>>    ? flush_rcu_work+0x50/0x50
>>>    kthread+0x2d4/0x390
>>>    ? kthread_create_worker_on_cpu+0xc0/0xc0
>>>    ret_from_fork+0x35/0x40
>>>
>>> Allocated by task 1124:
>>>    kasan_kmalloc+0xbf/0xe0
>>>    kmem_cache_alloc_trace+0xe4/0x190
>>>    dm_crtc_duplicate_state+0x78/0x130 [amdgpu]
>>>    drm_atomic_get_crtc_state+0x147/0x410 [drm]
>>>    page_flip_common+0x57/0x230 [drm_kms_helper]
>>>    drm_atomic_helper_page_flip+0xa6/0x110 [drm_kms_helper]
>>>    drm_mode_page_flip_ioctl+0xc4b/0x10a0 [drm]
>>>    drm_ioctl_kernel+0x1d4/0x260 [drm]
>>>    drm_ioctl+0x433/0x920 [drm]
>>>    amdgpu_drm_ioctl+0x11d/0x290 [amdgpu]
>>>    do_vfs_ioctl+0x1a1/0x13d0
>>>    ksys_ioctl+0x60/0x90
>>>    __x64_sys_ioctl+0x6f/0xb0
>>>    do_syscall_64+0x147/0x440
>>>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>
>>> Freed by task 1124:
>>>    __kasan_slab_free+0x12e/0x180
>>>    kfree+0x92/0x1a0
>>>    drm_atomic_state_default_clear+0x315/0xc40 [drm]
>>>    __drm_atomic_state_free+0x35/0xd0 [drm]
>>>    drm_atomic_helper_update_plane+0xac/0x350 [drm_kms_helper]
>>>    __setplane_internal+0x2d6/0x840 [drm]
>>>    drm_mode_cursor_universal+0x41e/0xbe0 [drm]
>>>    drm_mode_cursor_common+0x49f/0x880 [drm]
>>>    drm_mode_cursor_ioctl+0xd8/0x130 [drm]
>>>    drm_ioctl_kernel+0x1d4/0x260 [drm]
>>>    drm_ioctl+0x433/0x920 [drm]
>>>    amdgpu_drm_ioctl+0x11d/0x290 [amdgpu]
>>>    do_vfs_ioctl+0x1a1/0x13d0
>>>    ksys_ioctl+0x60/0x90
>>>    __x64_sys_ioctl+0x6f/0xb0
>>>    do_syscall_64+0x147/0x440
>>>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>
>>> The buggy address belongs to the object at ffff8803a697b068
>>>    which belongs to the cache kmalloc-1024 of size 1024
>>> The buggy address is located 9 bytes inside of
>>>    1024-byte region [ffff8803a697b068, ffff8803a697b468)
>>> The buggy address belongs to the page:
>>> page:ffffea000e9a5e00 count:1 mapcount:0 mapping:ffff88041e00efc0 index:0x0
>>> compound_mapcount: 0
>>> flags: 0x8000000000008100(slab|head)
>>> raw: 8000000000008100 ffffea000ecbc208 ffff88041e000c70 ffff88041e00efc0
>>> raw: 0000000000000000 0000000000170017 00000001ffffffff 0000000000000000
>>> page dumped because: kasan: bad access detected
>>>
>>> Memory state around the buggy address:
>>>    ffff8803a697af00: fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>>    ffff8803a697af80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>>> ffff8803a697b000: fc fc fc fc fc fc fc fc fc fc fc fc fc fb fb fb
>>>                                                                ^
>>>    ffff8803a697b080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>>    ffff8803a697b100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>> ==================================================================
>>>
>>> So, we fix this by counting the number of CRTCs this atomic commit disabled
>>> early on in the function before their atomic states have been freed, then
>>> use
>>> that count later to do the appropriate number of RPM puts at the end of the
>>> function.
>> I am a bit not clear, are you saying that the problem was the 'in the
>> middle' commit (cursor ioctl) doing
>>
>> drm_atomic_state_default_clear->dm_crtc_destroy_state->kfree(state)
>>
>> where the state is the one you access from from the non blocking part of
>> page flip though old_crtc_state->active?
> The problem is that (see the comment in drivers/gpu/drm/drm_atomic_helper.c:2065
> ) it's unsafe to touch any of the old_crtc_state structures after
> drm_atomic_helper_commit_hw_done() is called, as it's likely that they've been
> freed already.

I  am not sure about that, the comment in 
drm_atomic_helper_commit_hw_done says that
"the driver is not allowed to read or change any permanent software
or hardware modeset state" I interpret it as not the old_crtc_state but 
as the new_crtc_state or crtc->state after
drm_atomic_helper_swap_state completed.  It means that if you touch 
crtc->state after drm_atomic_helper_commit_hw_done
you actually could already be accessing a state which belong to the next 
atomic commit after you.
It really looks like cursor's atomic commit sneaks in in a middle of 
page flip between the page flip IOCTL
and it's commit_tail part and swaps away crct->state to his own new 
state and release the 'old' state which is not really
old yet and needs to be used by the tail part of page flip. This makes 
sense since do_aquire_global_lock we use in amdgpu_dm_atomic_check
to serialize against concurrent atomic_commits  is not called for case 
of cursor plane and so it may race against any commit_tail in flight...
Not sure why we haven't seen this problem before.
Obviously your fix makes the problem go away since you stopped accessing 
the new_crtc_state and not the old_crtc_state but the root problem
seems to me still there.

Andrey

>> Andrey
>>> Fixes: 97028037a38ae ("drm/amdgpu: Grab/put runtime PM references in
>>> atomic_commit_tail()")
>>> Signed-off-by: Lyude Paul <lyude@redhat.com>
>>> Cc: Michel Dänzer <michel@daenzer.net>
>>> Reported-by: Michel Dänzer <michel@daenzer.net>
>>> ---
>>>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++----
>>>    1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index f9add85157e7..689dbdf44bbf 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -4206,6 +4206,7 @@ static void amdgpu_dm_atomic_commit_tail(struct
>>> drm_atomic_state *state)
>>>    	struct drm_connector *connector;
>>>    	struct drm_connector_state *old_con_state, *new_con_state;
>>>    	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
>>> +	int crtc_disable_count = 0;
>>>    
>>>    	drm_atomic_helper_update_legacy_modeset_state(dev, state);
>>>    
>>> @@ -4410,6 +4411,9 @@ static void amdgpu_dm_atomic_commit_tail(struct
>>> drm_atomic_state *state)
>>>    		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
>>>    		bool modeset_needed;
>>>    
>>> +		if (old_crtc_state->active && !new_crtc_state->active)
>>> +			crtc_disable_count++;
>>> +
>>>    		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
>>>    		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
>>>    		modeset_needed = modeset_required(
>>> @@ -4463,11 +4467,9 @@ static void amdgpu_dm_atomic_commit_tail(struct
>>> drm_atomic_state *state)
>>>    	 * so we can put the GPU into runtime suspend if we're not driving
>>> any
>>>    	 * displays anymore
>>>    	 */
>>> +	for (i = 0; i < crtc_disable_count; i++)
>>> +		pm_runtime_put_autosuspend(dev->dev);
>>>    	pm_runtime_mark_last_busy(dev->dev);
>>> -	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
>>> new_crtc_state, i) {
>>> -		if (old_crtc_state->active && !new_crtc_state->active)
>>> -			pm_runtime_put_autosuspend(dev->dev);
>>> -	}
>>>    }
>>>    
>>>    
>>

