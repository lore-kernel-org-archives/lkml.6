Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7F6C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA93020844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 18:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oj8P+paL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA93020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbeIFXOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 19:14:42 -0400
Received: from mail-sn1nam02on0047.outbound.protection.outlook.com ([104.47.36.47]:14496
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726031AbeIFXOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 19:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eo1Bf0/l1E9hc9ySIZjkKR8apVi6F3ooAEl+dWFTSIw=;
 b=oj8P+paL/28oYGr1J14p6Y3f+YdmTFi4UGaMaJCxnfnaXgyK7I+4KNAbDwJzxBJI6PEvXaei9EsqQzONfLZ/ZFp1E0mPBD15GcXlpgtD35/puoYOdHNQvMTTJb59cgDfjPuP+2zZSK+hJUS/UDPHmyiU4AADnTzcc85wdPW1UMg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from [10.236.136.62] (165.204.77.1) by
 BYAPR12MB2680.namprd12.prod.outlook.com (2603:10b6:a03:69::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Thu, 6 Sep 2018 18:37:54 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v5 5/5] x86/kvm: Avoid dynamic allocation of pvclock data
 when SEV is active
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@suse.de>
References: <1536234182-2809-1-git-send-email-brijesh.singh@amd.com>
 <1536234182-2809-6-git-send-email-brijesh.singh@amd.com>
 <20180906122423.GA11144@zn.tnic> <20180906135041.GB32336@linux.intel.com>
 <20180906141825.GB370@linux.intel.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <fcd5efe9-3e26-3aff-9173-9f8c3f3183f1@amd.com>
Date:   Thu, 6 Sep 2018 13:37:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906141825.GB370@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0501CA0045.namprd05.prod.outlook.com
 (2603:10b6:803:41::22) To BYAPR12MB2680.namprd12.prod.outlook.com
 (2603:10b6:a03:69::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78b01e8c-79d2-4a99-1e90-08d61427dc6b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2680;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;3:CGnngvBwrLU5iBVKDiRyYxF5gikrJhRos/vpxXp4ejgt/RBbokt+udSbUCoyxjmPXxEnOc5ZkEC1iNG5c6AnpsbeX+mqSsHAXBH5ua5ChY4U4macJgZm7uzXvrukFtkoCG+yRRwVDNq75jjV7dYnlgXcGOcx/u/w1x7lR35CUOe7LKGl13e5uvRvkdNZt/VPwRcsS1X8o/wJRrq2AueZJdQ6zzZdNhS6s5QxfiXgzqdv6/HFStxIfR9WYgj5Sn26;25:NrJqWKTtPtRy7zc2+QDEi+lGqzBuWIssYO3rutEOSGpnJ3aSP2fLdMot7bfqOwBwGSfiN0urv5CMgk0d7i08YgaxeHZDI4eOGSJh2dvOIaINB70Mjx4ZZ8xv28xBATEa5Me06TrnHuspVuIK2pC6UpeJolO+WKQkIsTGrd9Uq3xaOz6zll+R72nHAcK+u0L9H1O68k7R33GOobYYYe9Hbp18vLwodhtUyammvorcRmjV25RHaLgjZp1MWkzQFkh79eSsygt46UXJApve90VmukP0FRwnSKTQ/TvV9jdnW98TIzM8sjCwIcK3hbHgUTMuqu4YFNiXE3qgnj6bp4iOFw==;31:rurFaQbYCRR1lWmYo1rLoYsdybW1H2MftMNKfRKwul5vm2nBW9e/ZlUvCtnsmRK8DmVm1nLWC5D200eSdnP1Ecqh7ayALVr/RQor6jkcKGT2xC7JXzoBtoffhnO4KfLQHJawqlgEeS02zsXKJo5M3ruVjkIt8mZGB7G2ZvyM7HgloZmkG2EPU88xyCRmcVXY3lYkmL2Nzl1wtjK6bG2HIF/Z3FZNA5AgRzIcEHevpoE=
X-MS-TrafficTypeDiagnostic: BYAPR12MB2680:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;20:T+5s2cvFB2VLfqoNpefx+Zp4p6VotuAAnnsj5At42lrLy+ZsFoUqb8ngKSXFpAgxDkGxOPr+bzYimnE8aPWnfvtsnXX6ztA+dsE0YM3hww17jAASfpPoS96PhN5kIKVZUobwb0HnCRAlB04/WEka68MTnSslrpgBXWkp6+lvSNeUsfL1+YoJ7Smlu0F54ARJP4T8w7svccuPV0z2Y4P1t2ZR8FgCmNqmhrI5yDlX6wwFIADVqW15YdQL/7rKXvPDyLlasJ5lMSTQuwemVZcgjtGPrLEQKXhDx563Yc0bKdVif8d3dpLwcuvJaPHLw5MKi9CrI/dfBcRCmOPzD8tG0nOwBomgSTl7hWnx8WStBlA51YElO38jDxPrlOuOxxEBkosxnAPpH8pH6FxYRV2M/REmhInCnVaQlsOt6rOAAT6AtkkDg6fkgXnyKBEdpkB1DfGziGiqu8tjl3jrq5zOR6k/qgfz1RcRq5VDfKTPTIXiR560EANWsreAlYsHckwf;4:wFl/AQbNckysithRXYMehCOdRsILsuZi5LUTsSLZJCzDr78y1DG1GFQ3elaTayPl+ZFD8679ETIjBSTwJbjTJXWACZf2naHBszBSsOpy1VCpXCrjDgLECvVJDi4mbQ1fScnNsxpC0l9Fgh3FpBXoDuh0lFYzUCMREshp2RHylRH2RxNHKgP5V2zu1YKebHdOdvNIaOyIj4cKqjsQWm71HMaO5LBnRK7iXKhRn+ZKCtTNfzLoQMLTynTNOxg0TDVg0upVbuwjBv3weBsAtfBtag==
X-Microsoft-Antispam-PRVS: <BYAPR12MB2680A0DEFE21CA1390F11FE7E5010@BYAPR12MB2680.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BYAPR12MB2680;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB2680;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(346002)(366004)(396003)(136003)(39860400002)(199004)(189003)(446003)(386003)(77096007)(8676002)(186003)(16526019)(6666003)(26005)(31686004)(53546011)(64126003)(25786009)(68736007)(50466002)(4326008)(316002)(54906003)(110136005)(16576012)(58126008)(81156014)(76176011)(52116002)(105586002)(106356001)(67846002)(36756003)(2486003)(81166006)(23676004)(52146003)(97736004)(44832011)(8936002)(5660300001)(229853002)(486006)(6486002)(14444005)(2906002)(47776003)(53936002)(93886005)(65806001)(66066001)(65956001)(478600001)(65826007)(476003)(11346002)(3846002)(7736002)(6116002)(956004)(2616005)(6246003)(305945005)(86362001)(230700001)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2680;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjEyTUIyNjgwOzIzOkJRTzBYeVVNUXJvWnlzUnI2S1B3aENVVnZ5?=
 =?utf-8?B?Qlg2dUtUZU81RFhZaTNxaE5Pbmc3NEI0aGY2NEt1bmtCbTFKUkFKbnVjakhp?=
 =?utf-8?B?STg1YWlxeTkwVmxJcVc1bmNXMEtnclhiWnFkVy9LSWkxNmhmeE9wMUd5SzEv?=
 =?utf-8?B?cTlIYS85NXlOTCs3c3FPODVmcU5DVnBRSE1BZzczL2pTUEp5dVN6K1VGbEZI?=
 =?utf-8?B?NktwMEFFRGt2QTlSaHhiU3h3aitwZDdTVHhRZmpqWm1GNm5Tbm83c1p1Nkcy?=
 =?utf-8?B?anBhSENObDBRcjI4dFJ6U1c2dkFkZkNaTnBLY05lNGNNUGVJUm5NdTcxSnd2?=
 =?utf-8?B?VlJpQW0ycDhFSUVKbVJVRmRDNHBCcWRMcnVsMWtWZW90QW02WFNack56Z2to?=
 =?utf-8?B?VFQwUUVrc2pWaWFtRmE0MHJTMEFIR3hvN2tDN0hHNnNWUnp1QkVSRm1DaWdv?=
 =?utf-8?B?NVR2dWc1TFRxbHdrdnU1eXZpL2k5TVB2Qk9seE5paG84NlhEdHRiZm05Q2wx?=
 =?utf-8?B?bEZOVitqd0xsRUJUV1UrcDkrVzY4b2QyUTlFWGN5b3o4TVZjaUpnMzRsYnJS?=
 =?utf-8?B?emwzUEFpQVE0UXFVZkJOTVk1aFRzN3F6WFkxb1cxSUwwWEN1YkxRb1V4R20y?=
 =?utf-8?B?UmFtZ214a0xEWTBLSUpBWk5SV05ET1g3WXNvTjR3SWVwQ2tnWlFyR2YvUWJk?=
 =?utf-8?B?YVdmazRRMmFETWxQY1E3NklhT0txRVBaNnRrb3owM29UbmZ0TzYwWU5ON2RO?=
 =?utf-8?B?OU1CWGhCYU4vMkhxc0crV2FGRVpHRUxjcnlWMi9ZUVZYNS9WNVo5VFpkb2xG?=
 =?utf-8?B?TGtsa25Tb3RyNkQrYjd4VjI4bWNsYjVtZm15VGpvanRreWZjSGFQYUxQYWlI?=
 =?utf-8?B?WFZvVkk4ZFBSclpXdUp3TU11ZHI1UURBeHRhNVlGK214cWs2OWZVckJCMGRz?=
 =?utf-8?B?MXNqYWcyMnpWYWpmWDBMck5wckVPYzFOTlNIV1pWdlRZQmZrdk1OVHJKRU5l?=
 =?utf-8?B?bFM5WDVidCtNOWQwTzRHdFJFbnpwZ2NnVjBDdCtIMnpnZVhwNjY4RnFNZytP?=
 =?utf-8?B?UHI0OUM4ckFVdVo2UGlENkNrdnV3M3RJZkhEcjNwTDdNQ3dXWkVwYVU3WjF0?=
 =?utf-8?B?aGZEWEhzSTl3TmlxTFp6SWR6YWhmTHpqWDA0dS9SUEN2S1d0N2VVdDYzRXZX?=
 =?utf-8?B?UXpzcnh0aUVIY1BTQko3QklxUWoyeEVpNW80UzZaMDh6ZXlVL2l0Q0xMNlI5?=
 =?utf-8?B?TXBPZ3pJUFh6R2RzZW5kQ0NVMVFwTGtlZElUM1VvMWgrblVoYlFHa2M0WWN2?=
 =?utf-8?B?SjE0UGVFU3JPNjlKVHJQVW9VK2Q1Y2xrSEh0VFBRS21hWStxc0xNOGdSS3hE?=
 =?utf-8?B?NS9aZlc1R3A0dkVFM25LY01hWlI0emplODZaWlhNR3ZMdi80RGUyai9ObHhO?=
 =?utf-8?B?RjY4bjRyUEtOV05yTDBtTzZVeUEwazBpamd5eCtwdldEWXAvTmlvQTFLR3lq?=
 =?utf-8?B?Wng4OFRTU1RZV0tKSmt6cDZhU1E1dDFDTlFxZmZ4YS9UWVlPRWVYVHY3cUtO?=
 =?utf-8?B?OWJEZFVXR1ZxOHdDVHpocTk0MXZsc0svcTNabnorRjRKMjNsL3haQVoxdUpp?=
 =?utf-8?B?MU1aTU1HLzY5UUZFeDdnUGlPNEUrN0taSlBISWhvaktmMVNLdWNVUzNOVGQy?=
 =?utf-8?B?ZWNFWFI0d1ZEY3lsc1NCT2c5c2NVZEU4L01NWWNHcDlBa3lKU1F5Z0RkNUdU?=
 =?utf-8?B?MGkxUkFJRWZNbVBQRjJGRnZUdGJDNWVyL3BxWUFESytITG9tSlNzS1g1aldx?=
 =?utf-8?B?SFhNZHdBb3hKeWFURkl6ZWhrWWRUVUZ2RWpydkcwcE5xZ2hNMVFZdlRhVUNT?=
 =?utf-8?B?NStqdks1RDlsZE1FS2RkclJlVW9GSFdBUTBzbFBhRXZqMmNQSDlkbkFxYUNh?=
 =?utf-8?B?UDR3aFNCYis0VDNISXVjY2lxb2FETFI4ekh2aW5TeWE0aWx2YjFaT2VuVzBP?=
 =?utf-8?B?Y2VaNVdEbWoxRHY0OEtobFplSkRHVXhGenF5TzErZzNiUWJwckl5cmd2WUZS?=
 =?utf-8?Q?vEso=3D?=
X-Microsoft-Antispam-Message-Info: Dq99lIyC2XiiWbjEwS0apVetuw64HcRhwHkVAaPUiJCCeOweEntLGfKvBq7M3Wlsw0Nusb0WJWX+oYlZqbFx+9FjhgLxf2VO/boHUjj0xeSnphfLrXXYe01nsRWYgDxvzERnHUPpyOQr1wT/Ms5pf3oF6HToS+9LfyIfGLsDd/xPPUyRY6dDgfGSbYEzzXx61w2M/FANb+Vm11e+eWdsdlYRyN7z5OgjBy0Y1vxxDNiYzksJJ8Jr1tUJDcZcVhGaPqAuRS4OHnt3/dEFCbg1pOOf+CO4OO5iEfOeL2O9hognRdnGtMkGPksdfNm1Ve0QHlS/R45axeZtfvGbPakx2QoreTFf6mE3/t01FxQTjHA=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;6:VKe+FUIsZ7wKQMb8WKHyJuOnFnjAGfidoRw1AbolsOHnvkwdRUC7oFszXnR4thuGahAi+vAlZk6Jt27fcx49+KM46wjK0eW7Ma7UaICtU2sgeY8+o2p4XBG4x1TrnskjoeAqxs7FXwOGO7csPhPyknT5sZieI5DUXo57uT7Xuw9wrQewW90UP40zj/hDCCkgVFhQCOv1QSjdFkJt1+7ysGBJqyPdKEwE2R03Af7V5Lt+5aTwVqdW6rNFC+pjvq+nBw+szQYCbA1LqRWzB+EGxLbrUW0ZmcHavpISA/jHjkuSpGBJUNvnoEyvPxbHXSNyXRorvdStJGrMgJDU/gE6idCUl6hbcM/4wh+vW68gyh1PJVKHoy83/uqQF+r+PBQ95lnWEAbQ5trFiY0p50FdF8IRDI7Ifoam+JvN36tt19D5PgKi/yJArFp/i4+wEY5mPbMPG5s+/E3d/8eCwItrDQ==;5:eFWjpZMS2jrBuwPj/L6hz74VU0zJhTiKgW3cS7kvFlwWYYY0Uyg+qIopFWsK29GTJ5CvDWi48eSLe0AN+P+sctdGNfXqOxp8S6eevLrI45UAiQc6Za870Ql9aGrPzOPW+p5iJuwywBXTFO1Nk5utRYmYmnemvEbIx4/CNSZsdB0=;7:lqVC9Ut7Y6SdLdd5M9J+/O2ANWZJoqntTxll8avnaiaVHU0rGHeKMWQKKzNY0k+O1BO5OjvtsgUtlmRgZpYtO4+2OfM13f4+t4LHGVZn1cYbYjAj4gXB8l4JlGPby1M0/CaEPiUdcb0zGfXpNYpVSJKqm8zWzbwM7IrKDVWuwx6IX8TJHxshqZxoNPh30mkrBH+bDNKvuJuS72QGWeJVgmhGSY4YKR6962uwVKuso2F6NJG5T7S6vU5Okff4LG3i
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;20:OZmjOsrAPv+rT/J4RqFV8P+0AjTy4pKPtZ4MlmG4zp7Eb2GhCegJCHq6NwYHtLTz0/hU9APvHH9oqkUfVHyLoqo97XrfLiBHTz1xoZ07EBAJHCgmjB35rnid+p+OhV2t+O84ZbTtBssZgELfqLHVlFEkeF52ekshxDcejfg9VUp0+Mg4pUy9MUpYMRCFvnCHWYtnRT+19MvSdbr/L06O9a/aA32fAoeBpWWCgaU2t83EBbRm8LvaqybpKjbbSDfB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 18:37:54.5755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b01e8c-79d2-4a99-1e90-08d61427dc6b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2680
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2018 09:18 AM, Sean Christopherson wrote:
....

>>>
>>> So are we going to be defining a decrypted section for every piece of
>>> machinery now?
>>>
>>> That's a bit too much in my book.
>>>
>>> Why can't you simply free everything in .data..decrypted on !SVE guests?
>>
>> That would prevent adding __decrypted to existing declarations, e.g.
>> hv_clock_boot, which would be ugly in its own right.  A more generic
>> solution would be to add something like __decrypted_exclusive to mark
>> data that is used if and only if SEV is active, and then free the
>> SEV-only data when SEV is disabled.
> 
> Oh, and we'd need to make sure __decrypted_exclusive is freed when
> !CONFIG_AMD_MEM_ENCRYPT, and preferably !sev_active() since the big
> array is used only if SEV is active.  This patch unconditionally
> defines hv_clock_dec but only frees it if CONFIG_AMD_MEM_ENCRYPT=y &&
> !mem_encrypt_active().
> 

Again we have to consider the bare metal scenario while doing this. The
aux array you proposed will be added in decrypted section only when
CONFIG_AMD_MEM_ENCRYPT=y.  If CONFIG_AMD_MEM_ENCRYPT=n then nothng
gets put in .data.decrypted section. At the runtime, if memory
encryption is active then .data.decrypted_hvclock will contains useful
data.

The __decrypted attribute in "" when CONFIG_AMD_MEM_ENCRYPT=n.


-Brijesh
