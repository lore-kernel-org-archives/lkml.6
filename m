Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69960ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE365206B5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4LEvJp/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE365206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbeINTmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:42:03 -0400
Received: from mail-by2nam03on0062.outbound.protection.outlook.com ([104.47.42.62]:2177
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727152AbeINTmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64JhhTKuTNGako3p815x2+ITPYuxp90SvtSbVa08IVw=;
 b=4LEvJp/jtrEzb3F+Qfif/Fge4rixemrEsK+GyvO96Ayi1HlPRneBwYLymPBHfM3f31Vz3l7wD72nGHJcHJoJ1QkhOBxh2iVCS3fStpCGPG4gYxs5imZjp7X+W/Q8zeSqU3y4PDY4FbYCSHRi3QWVCzKSp4YY6dWvpHP0u3qmBzo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from [10.236.136.62] (165.204.77.1) by
 BYAPR12MB2680.namprd12.prod.outlook.com (2603:10b6:a03:69::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.13; Fri, 14 Sep 2018 14:27:13 +0000
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v8 1/2] x86/mm: add .bss..decrypted section to hold shared
 variables
To:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>
References: <1536875471-17391-1-git-send-email-brijesh.singh@amd.com>
 <1536875471-17391-2-git-send-email-brijesh.singh@amd.com>
 <20180914071056.GA4747@zn.tnic>
 <3517a0db-2f64-6d09-7100-dced40561d08@amd.com>
 <alpine.DEB.2.21.1809141414390.10480@nanos.tec.linutronix.de>
 <20180914141216.GA29898@zn.tnic>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <43895f0e-fea7-001e-d727-d962a20f7f6c@amd.com>
Date:   Fri, 14 Sep 2018 09:27:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180914141216.GA29898@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0501CA0155.namprd05.prod.outlook.com
 (2603:10b6:803:2c::33) To BYAPR12MB2680.namprd12.prod.outlook.com
 (2603:10b6:a03:69::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01bec59f-ede0-4403-6d03-08d61a4e2a75
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2680;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;3:rJ+rz2jcMofXTt6bbSjZcxfrxxOi9KGW4gxdyVNxmom/k53+eps9typwuzkwTfJ6cxHL6OSnhVQqyhBCEr+vAX1YS9KDgkrDPM29y00NOvG888CfcP1ucVah/SOUnDSS/W2U8bETN7i2gp4rAOf5g9732+4hx3XcHHSOt8c9wfgB8gVSjOOFF6QLY6jd/d3BoubOc6oX99pDn1xwGM1mnUvq+NeuWavwwWgl5PoStyF/HE4FTYJBSLaa/otR+OmA;25:x2imVfDg+H41sXqe4AjqJT4XKeKROY1aSRKB3hEmnm6gehK8ms936DcwOczKHoWYDVkelDwngLry/X9Lto74vSKu6hnktK49+Imgu/uQuOmS+RVaI3f4aMFJ7KkOtcLtuhCyx2P3kwRrtCPUnkqM/Zc/CVafB33tjTQEX+a32hI4TIU2h14Qk1nnbOfyGiTTVWUN8vJHN0pUP2afkSl6JxNxWne3Rdi+5zwiBF3knSXow9KVyk5wsqA99H2s+f8u0gIB9bowsnXXSxTpE0V/XMF0lz96U+BqIHEWdIcL83/RG2I7I9QJ0uf/iFkrK5Xqs57yCFOzmLS2XyfPwdtxxA==;31:Jm7y4rJ8xxqeT7wQrfyJA5tHLFZMXB4jZv23m/5iCrWDWMwm56hhRZzNml2GI4t3FgRVuqMf7EbQYI4ggLqmY7HCSW8VlcJSbdm9fIKxBB7+uORb0Qr10WL2FtfqlYLYjs0O7Th/sv8bkOp/yUg/FQ0Op23P81f21PsDF35My0Dky2fYm3FANV3iqzxagvLVp8bvOirUlXbpH7xF5xec93AX0XJTzO/Ug9s7xhOA85w=
X-MS-TrafficTypeDiagnostic: BYAPR12MB2680:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;20:j2aDayzfpVYOyctNbxJJhX7wW+BqZF1ivL09YT/vfsVEYZJZ/YLvqATidTh3+jXDICO50QBO4QN1d661PwRzDxq6QRsbZjuXDlHMf8XOGT86lBjtiyGlb+Rl4CC4PX0ryw9/IeT1l1OgA5EouvrrYeRR5CG7zH4trLdSnnGP00mm6JQ9DkwS+a3xb0+kofohUZ4YwwAzfEDhwv9P/9VnnpJWT9PGFqp85JGbPAd8IJwJS+sLQJvBl8gCiJrusY1wzwtOULQa4mZiFKTC6L9ISweKzHJu585sIAbF1IwWptLG/7yKEyPgyk66HQMEJqygP73mLZVTa2Wa71x+79Xv5JYeR73CJ8rsjpuFsalDPGWbGt9Swi4Tdk0TKPa6IuOLGMbJdRFv6Vb0xvNBIck7lahXW9ZuNOs6XHNOTyaVV/FVKXGkwfM2vbHff2RXgknIIfTjqaz0m0Iy0+KuZ/YXe52chDTvDNwG7g3N6dxSDowXqBVcGBHy9qhE48wpN1gl;4:9B8HrGtzPUAfF0Bdynwe7qI0tPKpnpSk/mFOQanaf3Bj4oX51plN8q1RzdXdmcIiTFrL0BhmrCcPnZiHzFRj4JofZU0iM7CpGDiuAnhI/Bmxj9DXxlgLnb759SrUq3LrdVqxmrY0PuMcZIEX2WI6jlK6ThdFsAvcEe4Nqy9tX8d7kh8gLZbTo62VBUFu6vfuoYd4XbowluJvWMOC0NwyLvzbbW/FYl5ggEBncvo3VS1et0x95RHhx0nKgG2mHIYAP9Wa2YceZWRvaot7yJZ50w==
X-Microsoft-Antispam-PRVS: <BYAPR12MB26804A78C7D96D4F9BDCE678E5190@BYAPR12MB2680.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:BYAPR12MB2680;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB2680;
X-Forefront-PRVS: 07954CC105
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(396003)(376002)(346002)(136003)(39860400002)(189003)(199004)(316002)(486006)(8676002)(14444005)(65826007)(23676004)(76176011)(47776003)(65956001)(52146003)(476003)(2486003)(44832011)(446003)(2616005)(7736002)(11346002)(386003)(478600001)(66066001)(956004)(65806001)(305945005)(67846002)(53546011)(25786009)(53936002)(186003)(52116002)(31696002)(16576012)(575784001)(54906003)(229853002)(6486002)(86362001)(110136005)(58126008)(4326008)(230700001)(64126003)(6666003)(2906002)(97736004)(50466002)(6246003)(93886005)(81166006)(36756003)(81156014)(31686004)(8936002)(5660300001)(77096007)(26005)(3846002)(105586002)(6116002)(68736007)(106356001)(16526019)(142923001)(101420200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2680;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjEyTUIyNjgwOzIzOjNKR2VibXlxcWtZQ2ZvTzNQYTZaRUZnWkxo?=
 =?utf-8?B?UFNFeitXQ2V1bUhlZC84dnNHeTlhMmtKV0czSVhiRklqK3owTExQaU45RnZN?=
 =?utf-8?B?em15eEdKbU9KQkRkLzNNT00yM2htbU1CVnhtdS9KRzgrWmZMdGkrZ1pydU9h?=
 =?utf-8?B?VFp6eUdYUmM0ODRlT1BtcWFabE1XMjRDb1FMcEpaUXdpd1NrNnhRM1RvYklE?=
 =?utf-8?B?MTVLalJpbkN3VFFoMXZaZmJ2UjdqTDVQYm5BS05rSExPZGdFVFJKdC9xSDN2?=
 =?utf-8?B?SzNjQ0RtTEwxYy9iOU8yRllqa0p3TDhaZUpPaSsvdGI2blIzaDlGZjhHTytv?=
 =?utf-8?B?U3NDcHZncyt2MmZWYUwya3ZyRWJvbE4va09VK1ZVR2xVWXdJcitVRFZPQ29J?=
 =?utf-8?B?RWZhOGhtM3dWWXlSdXJKSjB3NlV1VE1ieDk5U3BFRlcyYmZ0L015TlpDbE9a?=
 =?utf-8?B?YWxwN3FMOUdZNkViOUx4L1RXMGgvYyt0cUlrOVJpK1ludXFnV2R0dTlpSlpX?=
 =?utf-8?B?cWFPWTRtYW1Db1ZoVWFZbXFEYllONTRRMXZkOXR1amZibDRKZmFzNnVzMWt1?=
 =?utf-8?B?OCs3ZFhVNDdBWkZaMzZFWUxZVGxXMXg3Y0NTWXVqQ1N5aXBnTXhCQ0hLRUxt?=
 =?utf-8?B?WU13bzBaU2dTNW5BUk1DdVptdWhxNWJCVXZWMm1UdmxySmdpSGd6LzdFTnEr?=
 =?utf-8?B?OFRMcmZNRzExMG5BY1pCbUJqQ1I1TG85VlBiZ1ZVRUZaT0llcittdCt5OUFG?=
 =?utf-8?B?dXNsSXZzTFpyR3hvekJIN1ZRckxjbmwrdStmdDdSUHVSczdXa1hIbEdpM3g1?=
 =?utf-8?B?SHRTQW8xUUwzUngybDFvcTAwWWNSeGdoZHgvZDRnNmJ1d1JjdnpmdCt0UmUx?=
 =?utf-8?B?YytFUXVkcUVUc2tFc3czQVpuODB3V3h2NlRib280NU5wVkxrYzdlU1FSbEVq?=
 =?utf-8?B?aWFIQzV3Q3lBK0djTHAyUHJUaEs0MngwNnlRU09GYlhDUGsySXN4d20zZjBz?=
 =?utf-8?B?c25wdUJWeGx1SWdNVXRLaTcrV3pUckNMSWoyNkluMVk4Uy9QQVMyeURVbFFL?=
 =?utf-8?B?MzVaL0FKMU1KVUtYYnhldnA3UENyT1cwL2crTWMweXZaT0tsNDVYeWlXbHls?=
 =?utf-8?B?R0labFplQnZRM3hwVDl0NHArckR0alhTaHJuUERKbmIyMUdGbldJTnNjNVkr?=
 =?utf-8?B?aGV4RHovbkN5SStRSFlENDlkaUtFKzY1SEs5cis2QnJkZ3hoMTB6MUFzRGlu?=
 =?utf-8?B?dFVCN3RJcnJBanhWQnE3Y3dMOFI4VENwak5PWXhkM2xIT3NJcy9VOHZIQXZq?=
 =?utf-8?B?MkRNRHRLaitnMkNCMU1MSXNpNU1KYlN0bnYwYm5sT1JqYzVIM3lIRTZJekF5?=
 =?utf-8?B?aWtuN2tJbFFaRzRGT2loWFQrd0djQVBxZC84Y0p6U3lSQTdOa2NaRExNN3ky?=
 =?utf-8?B?MVZJcUN0L0JiRnZITW9Vc1ZnNFBmYXY0WTFlS3dvU1ZkejdPVU0vblVEb0ZJ?=
 =?utf-8?B?QXl6SFBoV0pRN2tZSWwrbUtQQm9pcml2emdXL0s3TGVYN3d3NE9UQWR3L3BG?=
 =?utf-8?B?MDE1em5PREFldDluSmF0UlpJWmNObDlkeFBGSDdueDlBNGtKMm9hb0t2bmha?=
 =?utf-8?B?RXdpMnlraHhFdDlFb2labkZpOWVhMTZFeXFFMVdVQkdFaHhFVElEbXFkRDdh?=
 =?utf-8?B?Qm1KQlhhVlBoU3Yza0NWQ240alZCZHpKRWphd0crWUhlTEJxMU5aZlVuZmxL?=
 =?utf-8?B?UDI3bTZnN2YyZHMrOTNUOXBPUTd4bkFucmNjeEZ2MHlJSEZSTWc4YmxMMmVI?=
 =?utf-8?B?b3BnR2Z6WW9JdGJmMDlQVjJJOHBNNUVuZjlma3l3QzY5SjJXR0ZTY2V6WExQ?=
 =?utf-8?B?V0xyanZwaU9jSHNPMXBTOUUrWG01OHA5VXROTEVWSjRRWEJUaHJiOUlRS3JX?=
 =?utf-8?B?UmZaZXJ3RHBaelJnQTFuT1M1RlE0Nk93K1p2dHBTQ3BycGpsSThtNFNXeHFC?=
 =?utf-8?B?NDkvWjJLeENsSUM4aE84ZHpPQ3ZGWWhRdWRJSHhnZ3hCNXk1YnlkNkN2blda?=
 =?utf-8?B?NGdpWlVWRmZiWlZ5OFJqL0VXbFlIMWVyWndEY2tzWmpLNDB6V01zNFdnQWlW?=
 =?utf-8?Q?/dPI1g6xj/wgk12ardf9bCHZOrUHLbqBjuFrqjkdTpsF?=
X-Microsoft-Antispam-Message-Info: QK4jbcVIsD6/bTfw478195i5uf0l2kpfyEmA6MYNU6ma057cMDHd5+R7ay57j8hfPVyl2smCy4mmsJ3ppwg0wxSIz/5Noq3iHUguDQtVsxHFusOfDcGTUspBfgWtUETOwsJsTjZMxXMjFpUKgxY39LEX11/THlQ/4qv0dn5LUny/9vComLYKzLDDIjJWcy/vcvCQTBG1X0Qea6R+vKSHSz2coN/r76s/t+ColQToVC8DNp5IvkeCc2q0uyqcqER80K8oKLW7J22zwh0BGuJMNylBsrn9gY0HbrzmL22E0whru8mXy5aBdAf4GS0o1HQ1Uw7Gdrgir+PsMTfZZ7aVHVCH4YuplLfXpmkkQGMVaeU=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;6:bx+IrO1DyN77ircsggka4Y9rf8vlwvuRLLGzuNTUnzMgjWXITxG9uEhCTEqr3j4ieOC1q7gtbN7hcnxkKFWmLv0tIXtLTbfEa3OsDBLqYfcrGIkTqkWcb67M+WW5EHwW3Fiv96sFbtbun4OKUFtJTOdofACYXECRiK07jgoxqrVdpTna7NyQOSATk7jZVMglTN9YEofiy/1HCMfSCU2Q1emyQIW4ldYnG7Pv6vjnwB8J3GkT9PiyJOQdq2CAYg3WoDnDbre9SwJQjCZDpApvjDx6Hk3RrBMEtSVpRUacgUL62YUvRjLInENibmFgXh+xTaWrXLM04Nzpyq1+JEg3simFxXhiGiSjYsg0P5lwPKzBevAYwK20ypKdIFinsDkJdmsrePDsYAURFrtH+L7BmjtOV/vlfzxeimTpZmLAINnxJCU1A1ByJPXo8z/0Sr+aYTftp29XKRz7O8pT0cASvg==;5:LWENr2gCEVPn0U1z+F+mFmQbhcfatvnj7cW7NzOULaJ8P89scHbeFS1anwiePG0v5zwqmy0xS9SB7rAwFh2AcwnxBmaXN6C1tVH7DKoF2vRL6c8TFnuQBdNYOTq6PZ9wEaPmDjEV5gdKJfK4AhHOr0P1Lf3x5nmtPx/XcG93DLA=;7:y2Mul9X5UnbNhhL3QSCXWyBfEovJkO3wh8Dx+wL7Ts83fuNqac4xtLiSUG9UXzjXObv2RYentMxRVOugzyFCL6wsExpODnzZyInK6bSAkJ0O6wCW6Vzh6A7ongbgzETBd8OG0b7RLRt6nsQY7dcq0AGoUO0f+5QA99zL46uLONZWirASkOuVlUvdR7hGpJ17+sfq/jzLeOxmpbS95XeCCsYdsu1r62YBL73/ZrpmxH85cvijpPfWPghBRv9+1M9e
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR12MB2680;20:+h0GK0GIi0qIa/2sK4kCCdCPKMHn4u1wTm6qZyMcc4ILW1aQALxB0KK8mxrBDCHJM6V7eED/he24Wty8xjKViBG17obQLMBxrdetPzt6Q649PVpjtFiY5+jA4fhVV4Cpal0ly/fMXE9OQl5T9ROQvrreRD0VA5kReydeT/QgTyN+DIZ8az2+iDoPGNtCEyjqhEFTApHdb+CoXZoCPP5gxHgoaCz9UiGtvuE81houKGa77TF6cWhJypoErKbAYpKu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 14:27:13.1846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01bec59f-ede0-4403-6d03-08d61a4e2a75
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2680
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/14/2018 09:12 AM, Borislav Petkov wrote:
> On Fri, Sep 14, 2018 at 02:17:05PM +0200, Thomas Gleixner wrote:
>>> The sme_encrypt_kernel() does not have access to pmd (after pointer
>>> fixup is applied). You can extend the sme_encrypt_kernel() to pass an
>>> additional arguments but then we start getting in include hell. The pmd
>>> is defined as "pmdval_t". If we extend the sme_encrypt_kernel() then
>>> asm/mem_encrypt.h need to include the header file which defines
>>> "pmdval_t". Adding the 'asm/pgtable_type.h' was causing all kind of
>>> compilation errors. I didn't spend much time on it. IMO, we really don't
>>> need to go in this path unless we see some value from doing this.
>>
>> Keep it here then.
> 
> *For what is worth*, a simple forward declaration works. I've taken the
> 64-bit forward declaration of pmdval_t as SME is 64-bit only anyway.
> 
> The below diff ontop passes the mandatory all*config smoke builds:
> 
> ---
>   arch/x86/include/asm/mem_encrypt.h |  6 ++++--
>   arch/x86/kernel/head64.c           | 18 +-----------------
>   arch/x86/mm/mem_encrypt_identity.c | 18 +++++++++++++++++-
>   3 files changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> index 616f8e637bc3..67c0e6cfdfb3 100644
> --- a/arch/x86/include/asm/mem_encrypt.h
> +++ b/arch/x86/include/asm/mem_encrypt.h
> @@ -19,6 +19,8 @@
>   
>   #include <asm/bootparam.h>
>   
> +typedef unsigned long pmdval_t;
> +
>   #ifdef CONFIG_AMD_MEM_ENCRYPT
>   
>   extern u64 sme_me_mask;
> @@ -40,7 +42,7 @@ void __init sme_unmap_bootdata(char *real_mode_data);
>   
>   void __init sme_early_init(void);
>   
> -void __init sme_encrypt_kernel(struct boot_params *bp);
> +void __init sme_encrypt_kernel(struct boot_params *bp, pmdval_t *pmd);
>   void __init sme_enable(struct boot_params *bp);
>   
>   int __init early_set_memory_decrypted(unsigned long vaddr, unsigned long size);
> @@ -69,7 +71,7 @@ static inline void __init sme_unmap_bootdata(char *real_mode_data) { }
>   
>   static inline void __init sme_early_init(void) { }
>   
> -static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
> +static inline void __init sme_encrypt_kernel(struct boot_params *bp, pmdval_t *pmd) { }
>   static inline void __init sme_enable(struct boot_params *bp) { }
>   
>   static inline bool sme_active(void) { return false; }
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index c16af27eb23f..6f8e9b534e80 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -112,7 +112,6 @@ static bool __head check_la57_support(unsigned long physaddr)
>   unsigned long __head __startup_64(unsigned long physaddr,
>   				  struct boot_params *bp)
>   {
> -	unsigned long vaddr, vaddr_end;
>   	unsigned long load_delta, *p;
>   	unsigned long pgtable_flags;
>   	pgdval_t *pgd;
> @@ -233,22 +232,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
>   	*fixup_long(&phys_base, physaddr) += load_delta - sme_get_me_mask();
>   
>   	/* Encrypt the kernel and related (if SME is active) */
> -	sme_encrypt_kernel(bp);
> -
> -	/*
> -	 * Clear the memory encryption mask from the .bss..decrypted section.
> -	 * The bss section will be memset to zero later in the initialization so
> -	 * there is no need to zero it after changing the memory encryption
> -	 * attribute.
> -	 */
> -	if (mem_encrypt_active()) {
> -		vaddr = (unsigned long)__start_bss_decrypted;
> -		vaddr_end = (unsigned long)__end_bss_decrypted;
> -		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
> -			i = pmd_index(vaddr);
> -			pmd[i] -= sme_get_me_mask();
> -		}
> -	}
> +	sme_encrypt_kernel(bp, pmd);
>   
>   	/*
>   	 * Return the SME encryption mask (if SME is active) to be used as a
> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> index a19ef1a416ff..9dbc145d10f8 100644
> --- a/arch/x86/mm/mem_encrypt_identity.c
> +++ b/arch/x86/mm/mem_encrypt_identity.c
> @@ -267,15 +267,17 @@ static unsigned long __init sme_pgtable_calc(unsigned long len)
>   	return entries + tables;
>   }
>   
> -void __init sme_encrypt_kernel(struct boot_params *bp)
> +void __init sme_encrypt_kernel(struct boot_params *bp, pmdval_t *pmd)
>   {
>   	unsigned long workarea_start, workarea_end, workarea_len;
>   	unsigned long execute_start, execute_end, execute_len;
>   	unsigned long kernel_start, kernel_end, kernel_len;
>   	unsigned long initrd_start, initrd_end, initrd_len;
>   	struct sme_populate_pgd_data ppd;
> +	unsigned long vaddr, vaddr_end;
>   	unsigned long pgtable_area_len;
>   	unsigned long decrypted_base;
> +	int i;
>   
>   	if (!sme_active())
>   		return;
> @@ -467,6 +469,20 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
>   
>   	/* Flush the TLB - no globals so cr3 is enough */
>   	native_write_cr3(__native_read_cr3());
> +
> +	/*
> +	 * Clear the memory encryption mask from the .bss..decrypted section.
> +	 * The bss section will be memset to zero later in the initialization so
> +	 * there is no need to zero it after changing the memory encryption
> +	 * attribute.
> +	 */
> +	vaddr = (unsigned long)__start_bss_decrypted;
> +	vaddr_end = (unsigned long)__end_bss_decrypted;
> +
> +	for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
> +		i = pmd_index(vaddr);
> +		pmd[i] -= sme_get_me_mask();
> +	}
>   }


The above code will never get executed for the SEV case.

See if (!sme_active()) check in the start of function.

If we decide to go on this patch, then we have to do something like
this:

sme_encrypt_kernel(...)
{
	if (!mem_encrypt_active())
		return;

	if (sev_active())
		goto out;

	/* Do kernel and initrd in-place encrypts for SME only case */
	.....
	.....

out:
	/* Clear the C-bit from .bss..decrypted section */
	...
	...
}


>   
>   void __init sme_enable(struct boot_params *bp)
> 
