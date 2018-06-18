Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A30C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E5220693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="a9Ax1rPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E5220693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935752AbeFRSOW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 14:14:22 -0400
Received: from mail-sn1nam01on0055.outbound.protection.outlook.com ([104.47.32.55]:19136
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935533AbeFRSOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 14:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbrsBbp/MqMIZPpBCbT/L2buAuwyDPLQYF478w35qos=;
 b=a9Ax1rPq5SIIW6AFlmjZecgueFE20RvvhBC06UUBUqynSf47I+y6gYAsVd9pL5yNc9YkqGeBxphSPHYl2rxoxk9q/UUiR3olK/w3mEyDyog5Cqv3PvcOL1k/ByOfz6OYTSeffCHtmGxo4l/t0qeW5XGE4IhBgxQmO6MaExjpLb8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
Received: from [10.227.0.216] (165.204.78.2) by
 BY2PR12MB0131.namprd12.prod.outlook.com (2a01:111:e400:585a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Mon, 18 Jun
 2018 18:14:15 +0000
Subject: Re: [PATCH] x86/CPU/AMD: Fix LLC ID bit-shift calculation
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com
References: <1528915390-30533-1-git-send-email-suravee.suthikulpanit@amd.com>
 <20180618172048.GD24921@zn.tnic>
From:   "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Message-ID: <8552af6b-c6c6-82d7-9df9-8b928ff3f1d9@amd.com>
Date:   Mon, 18 Jun 2018 13:14:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180618172048.GD24921@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN4PR0501CA0041.namprd05.prod.outlook.com
 (2603:10b6:803:41::18) To BY2PR12MB0131.namprd12.prod.outlook.com
 (2a01:111:e400:585a::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9c0b0eb5-c854-406c-9d4c-08d5d5474da4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0131;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0131;3:Y1jNrnDdve3PAy4wsAxSY61y9MKFiK4MFJyOLvYDpbpq5SnqSyfb6n1uxGQJqqvolFLRJZ8gcN4Yo4BS/MOz0AIKmUVzc4nJOxJYevqTcwvWDiPgl8/1V0LiFUgmcBM0eRDyUGGNPf0Gb+jjLw7pWbz0Qn1TxYTEwIUk1q96qWvFacqvCY6r+ssm2NQePzOUuM9fFjXMa6QAe4u9Ic7k5b9PoCARMLm+tXy0Jt48fi2NZ5yV0KB5lxoeWLQqbol5;25:jl+mkF1jZB2bVv4g85oLCKz6ife67LU2ZYN3z1DsgThQxkgldraIeW2/8jfTrwoROKlSoMMRFqnzR00j4/a21OqJp6b9nWKyACKVrC7XGHLv96m85nR9uNXDUThtckF1cw/wRNnOByydLhW3e4B3QL8A3ieYKdKIPfGkj3qZT2VNKs5JEyWN4v3G1FsDI1Kkprogx28u5++YzHCcSwp56A+LP0DOQFjo54hpLEc3x5jtlTPCi41v7xifU81aQFEfBPRuokBjh83bR0GiP9drfj4Hgxs4Fi5a5V1obcZqgEf+nwBR82OR30Fy6Oj/lsvyD8UMSwZNjJqWaRKTtG8iug==;31:YLatHFdGbEsw/SJ06jNNRy3qlMUWiWzu66zSTjNUuEDvieI6Neeu2RysYCygnf5Zr58BWitBgQTtY17H8I6/5VPRSBqKRGo3Qut3KuU9lgyyNm5nS9c/SBH+g9sEbKQ5Cqx3f4+TA6+hM3L3yA/jv9Yz0YlL+NIceKkATsUqDlXpwRYMvwk15k3DJGIDgJ3VnJvqnE2xw38E0meQCaTnHcmVXgZj9iuQmkWfL0f7lUc=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0131:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0131;20:b0ARrwV9DcQ0ugpgK2erI+M53lsaEChhd6tRJFQ6hiatRGCef+YoA7EdIe7/eI/rZFlPK/FKlqwuquYHZztxYA+Lrk2O8vOf4Gfq4EKLl8YN3lzJ2Fq9PnYSToA9oo+ZzLsreY4l+Fj6S2gN3ZJ2ePHfL5/khmxx7RaEGpNhYYSbIvOn30l9rNbEmcVCwz8AMTiQqcoF1lrjUQjhIuuz5bOmNCu3DxwHNHuxkCDHhB9RMU+Nife61dZO85+xAxxFCNuidx1vHh9X2OojMcpeH8vAJuV548IkgtVngKCCYlh8usYVUh85+5qUblReDZ5kaMekBOVnrgmQpbTaJL8VqJ8sZGXFc8mO5Bqa32LvFNkM09vJDIB+Vb0vlCCjkUxwUhlSdY4TAqtK4qBdnBb+pKrL7hXnCxIlgvkiG3Wmj8jc1sCi6JiKX5MdjWzOUat4SOm2fbkxaM/TGqBE5gT7iMdrX+hZ3VzVIY80UpGKvxfACqopDwhP8pZ7E6JbNhoq;4:H5jbSHNK3mGUpt/YKwdSGjJLVijrtiax0kyyOeyn9Xd3ldRL4IgLFKeJ2SDGVAms1yqczh0vHoZQgC2e+zkdr9yGTXf5ZValuV7zfGng3hNZDF9XtVamZcbpfnEEvdghLSLp/r+4BtohpsCpvQ4B/KyU+YNyVpnLBiT9JEFoPU0pS9D8rM2IX+W8m64eeMe+RvxUriEczddt6V1rzbwQQDuMOIt3oNJ+82liDcrv05dWa+BhjLw9ROH2VuXFNlWdiFuVcd/jO+mZSIfx5ln5zw==
X-Microsoft-Antispam-PRVS: <BY2PR12MB013141B65CD0247A1A599F46F3710@BY2PR12MB0131.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BY2PR12MB0131;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0131;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(346002)(39380400002)(396003)(376002)(39860400002)(189003)(199004)(50466002)(316002)(476003)(31696002)(3846002)(65806001)(65956001)(86362001)(106356001)(6246003)(5660300001)(66066001)(105586002)(64126003)(6116002)(58126008)(65826007)(7736002)(305945005)(16526019)(186003)(11346002)(486006)(53936002)(2616005)(446003)(956004)(25786009)(67846002)(6486002)(16576012)(68736007)(478600001)(97736004)(72206003)(6666003)(81156014)(81166006)(26005)(52116002)(53546011)(2906002)(386003)(36756003)(8676002)(77096007)(59450400001)(6916009)(31686004)(47776003)(52146003)(23676004)(2486003)(229853002)(76176011)(8936002)(4326008)(2870700001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0131;H:[10.227.0.216];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjEyTUIwMTMxOzIzOmdMWHZiQ3o3ZEx1bGVJak00QUQrVzBkbDVJ?=
 =?utf-8?B?OHljdEEzQVIwTU5ueVlObHRSaElaeFBTRzZlZXkvVUgrMFArckdLRWRDajdY?=
 =?utf-8?B?VlZIcFlOaG45Zk9IN2diVWRHbllMZTY5V0lLWHBVbUdwNWlNdU4xb1ByVjdv?=
 =?utf-8?B?QzBtc3J5NkpKd1h5VW5rS1ZWSlZOdER3ZnA2eE1BTFJtcDUzSnB0VG15VHFN?=
 =?utf-8?B?Q2Q1KzNiV1FsejJqTm9ERFNlK0p2K1hwM1ZoS3VRdnZmeEpqQVMzV2MzY3N5?=
 =?utf-8?B?ZThOajNocHk5VHZDM2NxNlZDY3BLRTZYazZqK0R6L2loZ2M2QVZOZVRkeGZG?=
 =?utf-8?B?Um1yMXp4OUppYUtVRUo2YnkwVHYvN2dnaWdtYTdRb0wrNjV4UlZWcEIySUcy?=
 =?utf-8?B?VG5jUE0vQXJIZGR0VUI4aVR4UGVuQ2RjYkU2SmJ4RGRFS3FHUkpnZ1QvWVFT?=
 =?utf-8?B?SERid0hBaEllOE0vT0VnVHFaUkNBQnJWeVg2UG93SnA2YmdvVlNHZFdVQ011?=
 =?utf-8?B?aUd3UVFwa1BNSFZFREgycjVuL3NQSitmMnRNRGdMQWY3M0NJT0lHNnhKdGp2?=
 =?utf-8?B?aGJqaDBqdnhvbUVmcC9QUHllc0NrWU5vY0tHNmZqUElGNmxIdHJBTVowSWlK?=
 =?utf-8?B?c3duVC9nVjV4NFc1cVN3Tm5jaUN4SURSU3JFTTZJajh5YWZVOUdYRUVmNzNR?=
 =?utf-8?B?TDl3aWxoREwrN3c5M21pbm95V1d2Tnc3aVYxT2xXVEgxYkJiM3lTU0grV1cr?=
 =?utf-8?B?cUtZMWtEWFhBYno3TlBBbjlXN2ZlcERYUFM0MHdoVm4rcEZFeXJSaHZlQmp6?=
 =?utf-8?B?MmpjL2tvUzNhV0dYcEl0SmRtL2tXUWljakJkdnRla3hqajVpT25CYk1Jd0NU?=
 =?utf-8?B?anNQM3o0K2x1Nnc2ckhhNkpLYzk3aE9mNkdlYVRlVlFpT0l6SUtPRGpzQ09m?=
 =?utf-8?B?b3FjTDgzaFBaMlFrVEpubFB6d2txQjkzbjRPNHRBVVllNzQwR3U0SHBiYVQz?=
 =?utf-8?B?RDRPbXJhL05RNFF2VVNEQmo4Zk56VW5KOWMyWnlRZ2ZlbEc5Z0wrKzR5bVBo?=
 =?utf-8?B?UlBCSnJ3b20wVGJneVJOSUd3S2ZiYlJsOFp3ek81bEFqLzVjQmJEL25MYTkr?=
 =?utf-8?B?UEdvZ3F3TEV0MFlkMnJ6VjZ3eFg4T0V4bVF0eWhJY1A5cGF1VFJ3TG1LWE9t?=
 =?utf-8?B?MnpuMjd0N1hta1l3NGRseE91MXJGaExlK1gyd1Y4c2hLQmViK3MxTVJJQzRX?=
 =?utf-8?B?QlFKT2FjN3ZiMWorNzI3VEk4MTRMOEppYWJKZDV2MTFRdEl4Ungramg0RUJV?=
 =?utf-8?B?MmQzbnQ1WjFISGZsazg5OUhXMnV0WU1OMEFNcTRwM2YzbnR6NHM2cllmYkoy?=
 =?utf-8?B?TDVabS8xVFROMHlJQjRHWEFJaFVlRWRYR1huV0F2YmhaREYzMWM5b3ZQdVVU?=
 =?utf-8?B?Y2RNU2lydCtqYUdSUC9TZEllOThyOEFUb3pJaCtuUlM5dS9FQ1VUZG02VWhD?=
 =?utf-8?B?OTN6R25XMkNnc3FsVFFUdFRYbHVtS1dJdHJialdYUzExRE5YRFAvRWk4cVlD?=
 =?utf-8?B?dXd4NGhSUUZZU1JLUVMrZHdyL3ZmcjdMUEczTUVyM1dnL0tpOXh6elNqZ3g4?=
 =?utf-8?B?OWpFUm5uMi9yZ3ZXQlVwQW1xYWg4MVZsdVdZL3pJZ0w2bkpybDZPekc1NzB2?=
 =?utf-8?B?a0hPSm9RTGdFSUNsOEF6U1lNRnhoUVRySlZXRVEzcTQxSUR2MlpTK1l6MzQ0?=
 =?utf-8?B?U3NKWkQrODhQV2RORHhJOUJPUG9FempsNHJYSC96T3NjZTY2RjJXdk5KbHQy?=
 =?utf-8?B?dTR5VWJwVG9aYzMwWjJvQjZjT0Z0MXd5WFR4UjdoMFpPTVVtVXZxODZuSjVQ?=
 =?utf-8?B?RFo4SXo3SURwK0tZZ2ZQQnBXMmp3aUlySTFpWnFqVStUTEJ2cFJ0ODBBd3R2?=
 =?utf-8?B?Nmltcng1ZURySWFyVjg0RmNFT3l6bnZFa3JDSXdQRzc4cy9rUk9iTW56SGM2?=
 =?utf-8?B?SnlrRC9yVStxLzQ4YW11enI2cUZNQmNUT21SZz09?=
X-Microsoft-Antispam-Message-Info: QOBxeiogpqM9YUr6UEEgn9qvzDuke/W801bMm8eL6i7d7S2Iz77BJcl6hklWuz1q6O3wypa2cOBkMtRo7kALRhOJ+A4FDRX1QtdI8486oP5/mu2jKGVcXxy4bXMA5jAgAO0xf8IGGqQmUNWatevWhxRHv5eiyJbhAvGu+Zl8ka39H0aYawObfMSOh8mZSOPPPF6yi0B3VrnOXhuYzGD1zGSTJDbjWIZ2rb066Ptt9w+XeMMjvq+KrtPi/RBJZYA04sFVYEsOteOj1nwdf/XRPv8cPM85vUvem0UVr5T8seygPM2wKNjaBWuC5g7KXNHVK9OuRLUOJj1BAA24Wl+j8A==
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0131;6:b06a3QyKbOA78t3XAtQxpw9Jkj42O8AAagZ71ueyhAEJgBea/gnWie2BYiaXW09BKObVNmBc4JVCx5o0s2GvisDyAJZobXOktJpFJVJr4wyR9GlifRsrH0xMma9j7wuSK10VloB5EFK/KeHgqHrWoUxTgtJpMLEyW2gTLc5E8RseMr2aCpisw2d2oX9XIBxUeAQewN72f9ZYtoYyF/HwI5vrPMDnF+Amc4Mg6IIxeG9m6tEjBfWaANzEWS5C0tvEj79+ZaNpDHW2MPY6TDlQYXmrNXt19mrbI78vDva4s9LzNVExHV8nH1+J5JCcne47ryGkM4Bpz6WTwcpcOLZB221NkS7vDdp0DxBplrkSC5stD9ADcajr14BLTe20ktQ71hrRUi1MZHM+tir2sdSsu+S0VbkO19y70hKo53VdnkctrIBKUILCdcblasK7qwSyJOWmdnsaHg7MsRhVpuR5qg==;5:13bPJj4OGoE2HpbaTr6MB0cXzrdRWCMNM6u9tZV6k2RMkTtNZDIgNDji3yzEtYYtZHNemsMdCnzuSGU2qV/Br4PzZAO9+ZqjqlOEYSRVsRu85zNzE3PNn2no/i0oJ7xF1NDhHP4YqR2W+/7KuzYIRvy8Vez7b7f6UmnEYyiXVyk=;24:2HnKLxfUsSDq80EFmjq7k3DOuVdEXFN+9FTpuWQrp5t5gGWBhZbJEnglN5EXIBS7GrqjKKqZ39zg/xEZ7zL5fOy9iH3eRUaAj8YZRYrsiHY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0131;7:bHl/rnBz8b1O6fo/oLf+4k3/ceyUyfmwoyrFQo9Qnusm/erBX7JK1YxoiWfLvx9Nu8APTGQz7oXK/tYRH6R9VF+NWSK1oGfVtUJuPS3RnalIMYLJCXYjUnKrBGNPdBOoHoQrbon9zgJAlbqE5T3fdpbJLXxWEt6SbmWB4yvUqdBm4LoYWxmm2+f8BmHtSelbROk0X5ztYiGzQdlaGIkfeVXQYA7jamiBeq88EUvwKroj9IvAHcteLFO/RVnWiyB0;20:mya+P5Jez1D9A4cjAnlGkLizJmzFz3Dkg8AygJQ5xy/CKy5Ci5OcmM9L8xLTUTrA6hZhMsMoHcgFe3jTgknJ4s4wn0SR3BRRwZ9UalgMGsilTRzlc0hgCG/bFVKPDMMDL8Nc5PZ2FmZ6ENlFO6+dAcZmcR53fPTnGvjlAbGE20YkGKgx3Y0HZjH55MV2Y9if1R05Yy4juUmHbUNwcZvsSzUF/w0sNmAkumPbstdKZ0rgypk23AoEImV2hCupNbI3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 18:14:15.8571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0b0eb5-c854-406c-9d4c-08d5d5474da4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boris,

On 6/18/2018 12:20 PM, Borislav Petkov wrote:
> On Wed, Jun 13, 2018 at 01:43:10PM -0500, Suravee Suthikulpanit wrote:
>> The current logic incorrectly calculates the LLC ID from the APIC ID.
>> Unless specified otherwise, the LLC ID should be calculated from
>> the count order of the number of threads sharing cache.
> 
> Don't you mean:
> 
> "... should be calculated by removing the Core and Thread ID bits"?
> 
> here?
> 
> I'm looking at
> 
> "2.1.10.2.1.3 ApicId Enumeration Requirements
> 
> ...
> 
> Each Core::X86::Apic::ApicId[ApicId] register is preset as follows:
> • ApicId[6] = Socket ID.
> • ApicId[5:4] = Node ID.
> • ApicId[3] = Logical CCX L3 complex ID
> • ApicId[2:0]= (SMT) ? {LogicalCoreID[1:0],ThreadId} : {1'b0,LogicalCoreID[1:0]}.
> 
> and in order to get a unique LLC ID, you simply need to shift out the
> CoreID and the ThreadId, right?
> 
> Or am I misreading it?
> 

This enumeration is only for the family17h model 00-1Fh of hardware 
revision. The patch is intended for the future revision of hardware.

Thanks,
Suravee
