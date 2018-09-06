Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A722C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F0220659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Wh1YQnzw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F0220659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbeIGABj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 20:01:39 -0400
Received: from mail-eopbgr680079.outbound.protection.outlook.com ([40.107.68.79]:62837
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726265AbeIGABj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 20:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIY+9brWdo991BUALw4JIhiX5w0IK2URvHeRR7dTCBA=;
 b=Wh1YQnzwKJ50YWDAT6oAnZYLvvHrgUXocmDbEi/Z2j7ZZ8Py/0HKlPUzKqInpTTuS0JiauBIVfKrfM0mC1e/LRIXJvFJGMjlHRbNT8oWG4LPwNgjFFwvD9TDjzGd9oprH+6kBBKKi975GN8+A9oAaS/0FaR82zxrpmvmYXrUI8Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from [10.236.136.62] (165.204.77.1) by
 DM6PR12MB2684.namprd12.prod.outlook.com (2603:10b6:5:4a::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.17; Thu, 6 Sep 2018 19:24:35 +0000
Cc:     brijesh.singh@amd.com, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v5 5/5] x86/kvm: Avoid dynamic allocation of pvclock data
 when SEV is active
To:     Sean Christopherson <sean.j.christopherson@intel.com>
References: <1536234182-2809-1-git-send-email-brijesh.singh@amd.com>
 <1536234182-2809-6-git-send-email-brijesh.singh@amd.com>
 <20180906122423.GA11144@zn.tnic> <20180906135041.GB32336@linux.intel.com>
 <20180906141825.GB370@linux.intel.com>
 <fcd5efe9-3e26-3aff-9173-9f8c3f3183f1@amd.com>
 <20180906184750.GB4570@linux.intel.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <c219ec47-1a1f-5d19-0b5b-0cebb706ca6c@amd.com>
Date:   Thu, 6 Sep 2018 14:24:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906184750.GB4570@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0201CA0052.namprd02.prod.outlook.com
 (2603:10b6:803:20::14) To DM6PR12MB2684.namprd12.prod.outlook.com
 (2603:10b6:5:4a::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 060db194-bfda-47cb-08b5-08d6142e61d0
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2684;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;3:uzMW1E2KXMvZlh6D8hvPoYUL3tvn6gSY4lIg76ESk3h/mOGEMtnr5OWDvogyj4iCNa0902X4zHISHM4yAkxMzB5hY69ikXUOB9nyn4Ap/JByZNDtybDBDBYbeidLSomB32vv/2+kCp5Cxs5mM4lYY87XQrxhDK9fXPZ67GYvN2EkI/LWvosaKm7wz7e4yeeL5pKVbAW+sLDHX+Nf03xyNjhOKnNK2E4T6s7/prFMzBPnMASGAUNkB3ztIZZzBbBz;25:uriUGkOzbf4brvdLqORy8+DuJJ/A97CK3jpnHbFApBNqeS/8EIgboE9ir/oxIP0uUivaXjO9wnFgV1aKYm1UvSzi2uHIVC+r+zMhvU2cR4Ae41mpl0GmXDKcnC+0fjwg6aixzVw82NKs5gfUFcBcBtRUzEXQbWglgN5MYkXN5L71XawuPJ8cjIsYRl6Pt4gfdetSl+1PerJCWEVFCGfdZcxwde2+QJvV8JEQ5PpdgnFGqgiO+l1Ngm1gt01+Xt21IWbot3m5nbiLDzoTQzpI/v4YN7HgcCe26DN35Xjsjvh/EX6Aqkw+VCRTAf3x9R0mcLfZrWwKfMGh4gJxbn6CeA==;31:8cVwyZeyTBVLOUC8EBT1PJFdVvqTksyBo2YybQyBImzPms0infkh6GiTfNydjny9bYHPsODYzabdh00O9sj4VCELIPfY0heopH4apBEakfstdVLP8V6/H6UbG9j0XTjZGvtBpkha7nv7HGA5CAPGdJdafJ3t3eDeNUULDc9wvPminFzWd/VLLokbm211PkJ0LAbUk+hmV0chjKAQ/eBRJVpUiwT4vuHun8ekWUMXomQ=
X-MS-TrafficTypeDiagnostic: DM6PR12MB2684:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;20:gykTqGpvJqtgHmqN04nCAykY1gs6kg7q3vutrs4fUViEPJrQeu4xmpXmPUMlTEtEeNpkXVbpYyrJprLB4gWaBWAwcokPm5y4FNHFxB7HHHc3xJXD9HDoA3G37o7EjrtgJnFz9dgbnByc2z3ris0ewwV06DAJefZTk+FuqjL5w3flAK0kvz5V1fdudMSfokeUfe1MICQmN7HCWx22tvhrsGIT5dDUUCRZoyWPVt3uTr3ZRxTJW6I5aLdFDqL9FJ36Xtn5nsaUg80UBKdb29Iq9IG8ya2fWZucgzGKrlRdO9vx7g5geeCsYLkYnEyHOrLGkzBLzq77+JUP6bfgatMURWxsKBOQWkluRoZ7BwmTd3hIOoJ0RBV6LXG9qReMLidAN+ZnrfIZ23D9h4bDY/GB8fvp1oh0UhIfuz+2R9M1Qz6nticAiD79gSBeT0J1nNb7c2IhVD4cUQhN9EB7DEKZjvR2d6oH30irtSJdv0n1kbZfpj78Ik5A1tOTziSE6Dxl;4:hN/jaMCYwDSwYDZ16uMePbl5ZhRnHLrbsF9SzDnPIPTZjSoNnLRndpA/CuhbW/jTYltbqXR43QyM4M/J6OGoa/WThcERNO5F1KBMEWPyrrUhxkLEKqAmEvVj1yaGS0cPeFTYqO9eR2Dldv/zsosBjyVCGHxrH9zKPzkMeMjA6va/RDYGl3GANBdIV2nPEYbcBeOMxptTp+6H/ZADFQKYBFjsw85qQb0lIwGfyjZYVVGR5rThk11pEve4Ad8RmqVvpa8eJ4w5uWKzWYLztr9CLA==
X-Microsoft-Antispam-PRVS: <DM6PR12MB26842DFDA1001B38984E152EE5010@DM6PR12MB2684.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(201708071742011)(7699016);SRVR:DM6PR12MB2684;BCL:0;PCL:0;RULEID:;SRVR:DM6PR12MB2684;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(136003)(396003)(346002)(366004)(39860400002)(189003)(199004)(77096007)(14444005)(6116002)(8936002)(2616005)(446003)(11346002)(956004)(3846002)(54906003)(64126003)(97736004)(230700001)(44832011)(229853002)(476003)(486006)(65806001)(65956001)(66066001)(47776003)(53546011)(16526019)(8676002)(316002)(26005)(386003)(93886005)(6246003)(36756003)(16576012)(58126008)(68736007)(52116002)(7736002)(76176011)(65826007)(50466002)(6916009)(6666003)(105586002)(31696002)(23676004)(52146003)(2486003)(31686004)(86362001)(305945005)(53936002)(6486002)(2906002)(186003)(67846002)(478600001)(106356001)(4326008)(81166006)(81156014)(25786009)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2684;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjEyTUIyNjg0OzIzOmFYdEQra3FuK3ZLdEpZdTlJTnpWMEJhd21N?=
 =?utf-8?B?cHVsRVJIYWdiUEg5VDd3cWdlUklreUN5cm5oN0FGc0l4d3BvcTdDeXhTT2x2?=
 =?utf-8?B?b2tjUjJhV1ZxUkptUUd1L080ZlUyclcvM2lLellWSEh3YmVkQytIb0srVnd5?=
 =?utf-8?B?VEdTcUVoT043c0M5bmsvUVFoQkh0OXIxa0o2eFZOallEQ3FIL2RZWmE0NWov?=
 =?utf-8?B?T0RyanJjbjZ1d0NhdElVcDB6ZUtDT3lqL2dSSEN6aHhVa1VkeXpzOVdYZVdD?=
 =?utf-8?B?aFBYcUJQV0VFSjA4cG4vVm1FYXVmcWJ5ZHFtZEdPaG9XVEcxeGZlRlNUbXNY?=
 =?utf-8?B?T0NNQy9ZUCtqSGVLUXc2V29tMkJMajVTZXJhZFl4dmEyczN6YzJLaXYrL2t4?=
 =?utf-8?B?L1JWMDVNVDR4emtkSGZsaGpDWlA0dCszYytXQXhSem9sbFdrNm5YMStNYWFR?=
 =?utf-8?B?OUszVjZ1Tm5iYk9zd0tQQ2x0b1A2b1ppaExwbzJ0eStKMXNZcHg2MGViSmV1?=
 =?utf-8?B?RS8vZk54d1c0cWFLbDAzUzh5VzVreCtmemUwMzZLNzRFREg1U0puQjZ3V0c5?=
 =?utf-8?B?ZmNYWVNIbTVNdnZPbGliNXlzdUxEYlNIUFUvK0dtK0graU85bit4cTdCMnNu?=
 =?utf-8?B?RmF5cXphWC9LYTVkTE42czRrMWUrS21pOXVzYW9Pd3lqR1hXbi9LU0dvdlRW?=
 =?utf-8?B?MFEvcko3ejBkZTZ3aFREai9GaSs3R0FLODBtZWROV3VXanVvdHFqbGtOcEhC?=
 =?utf-8?B?bVRmK1p5NzBsTVo3OEhUT3E2cU40c3F1MGR6N3B3dVVxb05yMy9IVkdVTjU0?=
 =?utf-8?B?a3hqWnZkZzE1N29VYTZ3TThaanI5TXdTV3gzTUUxdkUzTEhOdGNLNHFPSTFT?=
 =?utf-8?B?aWZuZ0VTU1lrSXpLWlNyVXNSb3hsMHpUMURjOXo5ZmJqY1IxVER3VjR6OVpj?=
 =?utf-8?B?SlNYN1NkM3R1UmtFYWdiZzRiN1dmS3JTdnl6ZldmbmtvL0dManZzY016NVJH?=
 =?utf-8?B?YmRtbWQ4TDZ5R0VjL3RMYWx3ZEUyN3Ara25mWUtIK0NiS3JkWVYwTW5oZC91?=
 =?utf-8?B?dlVqMGdjNW9qR0pnWElLdk5uR2JPckx1NHBOSE9WR0dudDFTUmxLeHVpM0F1?=
 =?utf-8?B?UHg1NU54bjZVRE5GQjhTaHdtc3hnRXNKaXhjRGViTzI1R1d1cUx5QzMxSzgr?=
 =?utf-8?B?dFBGQTBvaEFZbmlaZUtUSjNKakhLc1VteDNRZVRCbnFTdGU5Tm1zUkhvYWRw?=
 =?utf-8?B?RDVDbUVOTXZGN25uY1dNZHR1Q05qRlk4bVloRmNFOUx6ZmpBYTJ4WFZyaW5l?=
 =?utf-8?B?QWlJRkFDbVkxMm5kTTNMOWlFaFEyZnpZYUVXRnB0Zkc0bC9JMUhXSDJ0cmh6?=
 =?utf-8?B?b2FyeDBueXRaMkRGR3MxT1NBQmVGYWJteU9MUThjQUtyN093VENNNWdCS3JF?=
 =?utf-8?B?WG5OWFRXclF0UTg3bnZ6My9NRHBMSXJZbXVhTk95VFVmajJZeFh6MVEwLzFB?=
 =?utf-8?B?OEtmY0g3dGpCVUU2Z1NtSXRBQWJvcThYdlFMNFBtdjgxOFY2OG9VQXIvT01L?=
 =?utf-8?B?YUUwTzIySlNOemNoRnRLQnhnWHhVV1dyMXFkWUdIbm4vTWRjdEJSb0l6LzFQ?=
 =?utf-8?B?WTYwbnRpUm51YXRoYlhNUTZNTFBaeitEaUN4cUFPSUpGcVZJNHYvR1JCbkRl?=
 =?utf-8?B?NFF0YXpnYjhQUUVPYXhWZUdNUG42a3dvSDIvM2IzZTYzQ0RnSW5KNFdBdXFx?=
 =?utf-8?B?Q0dXNEFrUzNoTEdOQmRoOGJlSE1jK1NCS1N4RGJGazNpWWNMZXBtc2xwazdK?=
 =?utf-8?B?ckdEaWF4NUJQZ1JESFpRcjZYWk00YTZuRitQMDl6VmYrUDZyblhxWUVMSVEw?=
 =?utf-8?B?RTRNekxMSnJwUkZFc0ZhdyttYjVsMlJQYyttU0pLNEgvK3ZOYkMwYjVUaDNT?=
 =?utf-8?B?ZkJSMzQ0SWJ4a0QvanlyZ2d1eHZGVVJWMlVOa1FMWklHQjF5QW1zWXNrOWFR?=
 =?utf-8?B?K1RrMEJiV2R1aUh2Wk5Hb0JrK1E2SndjblNLWGFCaUprUURjVDRwTHgzekFO?=
 =?utf-8?Q?wRJU=3D?=
X-Microsoft-Antispam-Message-Info: 7ilBREyXQbQohnLfU+5lLXE9JIwYAsj6dbbNQ5axpEobdzeVBBqHcWoM56S702cX5MW7BI6Z0POvrs7PljedBbcQ9iNrFsvsav+a+K8NM4umdYEYIfNaKYchdL6qfh+1ZC3VN5NzerDgaELaJ2wTpzhdcqGv2FgDLiSAoL9vFAyF2Tbd86tCSrFQB4uIY3uY1zAohx9NDRA/ZQdcH3YOYPF493wyrIgtaxdq+fNtBdVS0OFXE8ZbquG28EF4PC1Zcj1Wg/Wg5fvZ80jEs0vHxKYXDy3j6DLt/U2E03VlEtyxUxq4ay3yyiyqviU7fOilsKw3gI9fSbMRKbeHDc1BlpGCLErLmSNWOuZEq3J8McI=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;6:MAp5POgT+dytMBBIp41VhzaxsZmxfRkiLVkJBhlBkUSHO9wemYC2LTvvey7SNcD7RmcYgGD8lJNqZvlZl/apdfouk2cbcq+7NWFxyf0i98ejSX9gj6ICeNwMVGOgjN1VzwpePixGMQNx43+SDlQkJHIES7J31mdHtwa0Kd7arPAt5fQ08nGNMVQerOsSBAahbaJ0FlxbgTFTrZbotGbhwhmmVK8tz1OXKev6h3IhpzcAyT17LAgI9fhTgOFE4lg38VL+wb79yEJ/SRNGI+qJ3/4S4W3eL3H8qzasB0I7cXC1yPwnqkI1FLVZ22Ixo0PbUR1Kae39TDKQmDf5ZmhmDjHA+R8Pp5JGbizQ5CqnK5etifZj/6gTVv6dINugaFvIlJ+7+V9OFMZJhYwGeMoQCnXq3frO4COR0Q7YJFmuLdBvTSIo+KdzdVJ+73ksQXEKyICukEa7ayN7MQQy0gwyLg==;5:Mo39uFNlyxFyem2EdRsQiVWQ4JkTCZP5QYVA7dKxZuBGQ/T9UeckQWJvXY6Jg7R3iJMEaGVL2ndUefkIKlC5CnKK8DvqXwj4jFqbloJC8b87HjXv7NZ1bMREUiWwrZMcvfG/jEQDgnsq3W/Pu2HttPyWaP8/fLT3kEHfs15zhro=;7:bKgvTkHWJSWQ2b3QeRmopczMBkuYZ/NbcHj03N1IX8eWHKr4k3XGHw3DcewsKlkJRgSFZGfmVQVu9KM6QQb7OmWbW3EJVRGBQpKoGnKUChKBg8bqexZb7Qhp7PaoXlsFDvD6+ws5FMnHF+FMGw2ZebAgpiqbkBMbd3d8idxxKIRRXSGa2CH0Pr8kL7Xi9N6d0otMPYJYAEjZJYtViycqWmTaiAE+7H/FDjz627rVqfQJfZiJiTI3SluP3hKxrhVI
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2684;20:tkiBEQtoOjT8wOubgGeMIoNR4V5hR73YiPg5HzyxMwNpN515lg2wzoZRxBMKvvBhIyolhZRfbkbY03iXcpOJ+bIctYMwJaHUiEJa+MJcI+aaN+YAkVchr1/SycaCjBBa50qEOAuIwLx66PIPGbBupaPjt74YJS2/hK1YF1bksW7cuouz4edGJP8e0XVsfZF3C6wy7LSvFBwrCuBffgVx9U8O1w1jW7NFL6/0h/QZfuvKAEiUdL+opf9GN/Bojspo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 19:24:35.5016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 060db194-bfda-47cb-08b5-08d6142e61d0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2684
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2018 01:47 PM, Sean Christopherson wrote:
> On Thu, Sep 06, 2018 at 01:37:50PM -0500, Brijesh Singh wrote:
>>
>>
>> On 09/06/2018 09:18 AM, Sean Christopherson wrote:
>> ....
>>
>>>>>
>>>>> So are we going to be defining a decrypted section for every piece of
>>>>> machinery now?
>>>>>
>>>>> That's a bit too much in my book.
>>>>>
>>>>> Why can't you simply free everything in .data..decrypted on !SVE guests?
>>>>
>>>> That would prevent adding __decrypted to existing declarations, e.g.
>>>> hv_clock_boot, which would be ugly in its own right.  A more generic
>>>> solution would be to add something like __decrypted_exclusive to mark
>>>> data that is used if and only if SEV is active, and then free the
>>>> SEV-only data when SEV is disabled.
>>>
>>> Oh, and we'd need to make sure __decrypted_exclusive is freed when
>>> !CONFIG_AMD_MEM_ENCRYPT, and preferably !sev_active() since the big
>>> array is used only if SEV is active.  This patch unconditionally
>>> defines hv_clock_dec but only frees it if CONFIG_AMD_MEM_ENCRYPT=y &&
>>> !mem_encrypt_active().
>>>
>>
>> Again we have to consider the bare metal scenario while doing this. The
>> aux array you proposed will be added in decrypted section only when
>> CONFIG_AMD_MEM_ENCRYPT=y.  If CONFIG_AMD_MEM_ENCRYPT=n then nothng
>> gets put in .data.decrypted section. At the runtime, if memory
>> encryption is active then .data.decrypted_hvclock will contains useful
>> data.
>>
>> The __decrypted attribute in "" when CONFIG_AMD_MEM_ENCRYPT=n.
> 
> Right, but won't the data get dumped into the regular .bss in that
> case, i.e. needs to be freed?
> 


Yes, the auxiliary array will dumped into the regular .bss when
CONFIG_AMD_MEM_ENCRYPT=n. Typically it will be few k, I am not
sure if its worth complicating the code to save those extra memory.
Most of the distro's have CONFIG_AMD_MEM_ENCRYPT=y anyways.
