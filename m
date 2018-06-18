Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BEAC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C472075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="q81Bizfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C472075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936071AbeFRSqV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 14:46:21 -0400
Received: from mail-sn1nam02on0052.outbound.protection.outlook.com ([104.47.36.52]:42070
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935726AbeFRSqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 14:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kxQlUCekxRUHNnOPSz9shrmcOIZ7ff/AKgPjdYxu1o=;
 b=q81BizfpJb8J6plxG66kp2k7g+Bzn7voilL2xi1ceVy3BbV6uq9Gns8k+8PXx4R9huU3RMN4b2zNPn7PlDXhoQxFNE+/jF8bpapPXDXfIe9/Y+Gjlk5P2oFfpvB4qIbelYRYRN3svUKmuK+X9ORPtUZVDtbYAYNExsjmRMF2Pr0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
Received: from [10.227.0.216] (165.204.78.2) by
 DM2PR12MB0138.namprd12.prod.outlook.com (2a01:111:e400:50cf::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Mon, 18 Jun
 2018 18:46:15 +0000
Subject: Re: [PATCH] x86/CPU/AMD: Fix LLC ID bit-shift calculation
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com
References: <1528915390-30533-1-git-send-email-suravee.suthikulpanit@amd.com>
 <20180618172048.GD24921@zn.tnic>
 <8552af6b-c6c6-82d7-9df9-8b928ff3f1d9@amd.com>
 <20180618182315.GE24921@zn.tnic>
From:   "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Message-ID: <55a20153-9416-404b-7442-ed851386e2e0@amd.com>
Date:   Mon, 18 Jun 2018 13:46:11 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180618182315.GE24921@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN2PR01CA0031.prod.exchangelabs.com (2603:10b6:804:2::41)
 To DM2PR12MB0138.namprd12.prod.outlook.com (2a01:111:e400:50cf::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e6e6ec0-df99-4fb2-f909-08d5d54bc5e3
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0138;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0138;3:0dR72+ygxYCLMfsl/S3QUbJPt0lXezHDaM9fq/X1PzfMsR1Mzg/upu6PefyQmrC5XQ3iX7mBRteJ1k2aJuDtcfgbFHCt44sYhPu0HiYhAKlvDBF52/yRoCRucXXSjqdL+1LmP25yIGw0mNUhc6COqKdCCRG7EDw3GYQifuwSu97d3HlkBws+FVxpsv1zT7KBio1H5d7rF6aRZqQCdsXpI9AjMxufCGscke/JaDA0IzirykDePYx66udzuJV0mSh8;25:HnM1m9Hxx7hsjAVjybkHWTdJ/mPfZiMvr9HzlcKp713/yerGGlFJc/Y0xd6ngdwA8E9cszIZe60KIsvaPaGOYwwtJJyoUfHrevgSuHcDZFY7xZ061BgGxjL2GCl1ZPfCaI9F2l33XGVRAZjn7WCcZIZV6MBoLh/OzJ2KlMOwZ3ZsZcDqw5eyySVemI8iy0eploRNZy6vSyL3GRGdxJ/UGfWnXit8J7FYvYViIATYWrpzYGRLgQeFh+n+JlEJMnIJs6fGokua0fFbuvWQlUrnJaFXfL4JTbXi3ErzfySybaVz4OCttZUv9e/k/eB6J9UYppOHoESMzMb/9QgIxVRuhQ==;31:PJiBT/Y3DCsPBgUbnusVMUMClt79+oerksnJyM10tn/FPIX6zFXvi9zS8KIy7P5YMKHie1rQysJAbZliRgXvECErivs/kF5cfm1pPFSIUkv8L9M4UIzpoiXKqm9yndIwT2geEiXmHY5NI+kid4rFtbd1sftXsCvf5LznTk6F5MnN8nE/yOKHeFl8cXHdaH7J7JpByw68MvSIxtXjH2mb7X2pjZ1yPd0q8FUmU9Cu5KI=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0138:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0138;20:FZZOVZ00ONyday18hewzLzHCpJ6lUacBY1359TYwjCisxxgbNahAgH5clOrpLnB/1gMVyfjzKG8+Q2WBItqreGvgO6ocuFT6kBSBO4YfIvGZd0cqDvww6Ar57o11OMmzPXs8v5oEx+a4ZA1ZH6sEucJ1AuRD1TcNSRre0361NjLO1pLXqM4iajrKbPiH5SxK43r573OdqdIYrsHplBfc8YUDCHHw/rIptOvDnXkWPh4bF5FrqOnP8ZqhKfZ/FHp5QrSkh9mwQXhAnlodmeBB5oU1oQcc4QP6frdvuuypTBVQJhZsmDfCc3JCtkF66XHL+cbh5igTPelyMdcm1YwH/SsQ2U45Nki3jlNX7r5Iw9YIZtiaMKJT679PJCEwHPF7BmbIdmnP8g056nvUQvnvM+6v9lfDa+v9IJCDrYdjNDwnZpHh1bH9kos0MK5yKSlUHmD0al0KmdvrvtrcA7yBP59YZNE15IfkuHiddoeKTzB23bL4D04r8rZ+VskFYmsP;4:8bEfvtvTVpjFRGVj0O4zjSqb1iM2++gKAGlb4+LYxGtXQG1PQuS4tWxaDI7QiZ5g1ve5CtcPN0fdTPaJWpd9zEj7t5TYp0w/SS1SadePzD9hN+DYc+i3bMJL9oWDgL3kOiD3kzEkrTqXnnhr1BJpfRimm7XTg9rJJG9DyDc/J0lIqkF+3lhi4MS6Ox4XV4C3qhqJO1MpFlJ29UTAoyk/kItxMGy0nLIokYXizKagOwLKAMr+gmTcBQRDs3PwnmMhXuEsyeK41pd0rzXr1xi82g==
X-Microsoft-Antispam-PRVS: <DM2PR12MB01383E6E573E6E1A656D55E5F3710@DM2PR12MB0138.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM2PR12MB0138;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0138;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(376002)(346002)(366004)(39380400002)(39860400002)(199004)(189003)(305945005)(486006)(229853002)(476003)(58126008)(31686004)(6916009)(446003)(7736002)(81166006)(105586002)(81156014)(25786009)(11346002)(8676002)(5660300001)(6246003)(106356001)(956004)(2616005)(6666003)(53546011)(230700001)(386003)(64126003)(77096007)(16526019)(186003)(93886005)(26005)(6116002)(316002)(2486003)(36756003)(52116002)(23676004)(76176011)(52146003)(3846002)(16576012)(53936002)(2906002)(31696002)(86362001)(6486002)(67846002)(478600001)(4326008)(50466002)(65826007)(8936002)(66066001)(65956001)(65806001)(68736007)(72206003)(97736004)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0138;H:[10.227.0.216];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjEyTUIwMTM4OzIzOmk2anI2VzlZNk5IR3kxQmNxUlBnMmpzWndM?=
 =?utf-8?B?dCtqdm9VMmloZzZKWm1mMk9xMUQrd25hckZTNllzWC9GaW1MeXJqb05aSTFX?=
 =?utf-8?B?a0ZWUkxiSlJRVXhXUWhKNTkyK09FbkFqdFdyMVFWb3oxaHpvL1dxMGkzWjdK?=
 =?utf-8?B?bnhiZ3B6WTh4OEU3aXhBZTlYNittZDRGR3laek9Qb2RJYzFEKzN6Yk5xdkxv?=
 =?utf-8?B?b0lObm5MU0NIRk5QT08ra0llaE9ZYWVZd0RtVnRVTHdUSmFpMVFqNFpXWjVh?=
 =?utf-8?B?enNiZVRBR2R0VmphWUpoMlI1YWRSSEQxdWQ1OURoMmhpY2VXcDV0dlBRTkxB?=
 =?utf-8?B?bCtiNHVidXowODFmb09HWFpGOHRaL3VaaWNmN1VpbERLUmdURXlVbGszZ3lY?=
 =?utf-8?B?Uzc4cVFnYzQ5azgvVzNsUHpVODZOaGFxb1l0Q2JNR2QweEt0NHN4SE5iYjVQ?=
 =?utf-8?B?WDY3NjhObDVxT3pVK0s4T0lSSWRNd0pLVkFibSszbi9Da01Kd01UbmNpYlRa?=
 =?utf-8?B?ZUI5eVk1ekM3VVdqeVhqbFhHR1hmZ0JEbW8yYU1xcWRIaTd5Ylc2bTF1SXNI?=
 =?utf-8?B?cTZQY2FocHp3ZUdwczlXL1FtakpTVzVnVjN4YVRxbUhjTGpuOU1QU0tOWmhK?=
 =?utf-8?B?eWNrSjZ4YmlkVXRrckJaTnJoSFlHc25Ja2NLVEtCUDc1cjNSR2g1aTBnbmV2?=
 =?utf-8?B?RmlZSWRBcERrVTQxdzJCUWdKTDFyMU9aODlxUytlRVZyc3BFQ3cxTXp6YVR5?=
 =?utf-8?B?eGlpYTIvK0IrWWNEeUVJV1FoNlRqcVF3VlkrTS9CTWtGOWdFU05Zcm1wd2FC?=
 =?utf-8?B?dHBGWmRncGdvNFdMZmE5em40MjVNS2JsNmpENm9xd29VYTA5M1hZSFNSU2pq?=
 =?utf-8?B?UjNUcmpsenNpUUFHY3A4ek9mejNWWlpaS1gvb2xHMVlIMXJLdEt2eEs2Snpq?=
 =?utf-8?B?TDlUbnlHWHZTaFdTMktRL3lNMDNBa3BFWnNhdUlYS1VnMDhjZWhIbFNrc1hx?=
 =?utf-8?B?bjV6WXptaHhGLzcyYnExVjNITDN0VFBaTnNyVStKdUZQYzBwZnQ5cUFVeDdJ?=
 =?utf-8?B?eHVLMXBCSFVmdy9Yd29WaEhtUmpyQ2tmLzc3SllQeVV1cFpLaHhBejAwYjND?=
 =?utf-8?B?bE9NYjlFZ3h3bXdNT1NyRlRFVExTZDBCaWxiQmxORjQ0Q3p2YkhaNSsrTWdK?=
 =?utf-8?B?ZmhXeFZlSDJqU1JjZFllWUJDRXBaTnRWVEw0V3lLSGVNdVhoK2ZuZEZoenBR?=
 =?utf-8?B?UmFQMG8wWHZ1QkpEdUdBSTdYc29rdXJXa2JoQWs2dUZ6YTBFd2lVekx4ckdY?=
 =?utf-8?B?eGxGK08wNE9tSnA5Y2FoMTRGSjA5cXBWNTJLT2NUNks1ZUxnY2Z0Z3haK0RN?=
 =?utf-8?B?OE1acTMzUk9hWkhXaEo2Q0VwQnFkUEVDUnAzd1pROUdhVHVvMk9Cc0JrU3JE?=
 =?utf-8?B?NFR2b1liM09CTmFmTkJaaTA5WmNZYzVPRnlvZENBWDFuZzdQUlExNDRvVGJj?=
 =?utf-8?B?VzlHTjlVdG12Z3dORGl5c2ZQMHl4enRaaDZUU0NBZGN2UXdMM3FnZm1RSEF6?=
 =?utf-8?B?cmptTnJudmpxWkVmbGFMbkRzbWxxamg0a20rTllmNzdmV1o1bWxHNHhtdGF2?=
 =?utf-8?B?SEc5U0pmMW4ybVRMMW5vOHVpQk1OWWRPMURmbG1ONzY1SXJpNnFPRkRzWEdI?=
 =?utf-8?B?MTlWWWZYc05aUnNwajNYL1psSE9RdXFyN1p6VHNRaTFCMlowdEdCdkF2WUhI?=
 =?utf-8?B?ZlNTN3NlcmRWMjVXcWtoRS9ydzdKai9Cd3RMRU91Qmo1K0N6RjZ1L3ptVy9l?=
 =?utf-8?B?QW4vTVRwckpYZEpsSXZZdVNwaVpCWFVvWkRxcDNYakROTUZzYXFmbDIyK2dq?=
 =?utf-8?B?MG5zMWF4RnE3YVJoZkxXU2NTcCttM0pkOXlHaSs3bGFENnIrdEhKeDZ5YjJF?=
 =?utf-8?B?cnVRMlVrTlpsZ3pwRWs1QXRBeFh4dDYxck12MDNENHlreVhscFcvV0puMWJ4?=
 =?utf-8?B?cnRhaEtBaDk4MUk2Vms1VXNrRDBWRmhpdFUrdz09?=
X-Microsoft-Antispam-Message-Info: xiMkuREzRLnpnRm88DctdMPj99W8AXl0C00ruINOXKKEl/6ZG+SiNv9ODT/tgzhtRWwu6QO3kgq8CeZzcoj0kxsBOQQd6tuLKbInanozHQPApgIFVLuu+jr+VA8P+IiXGHj86u5p28vR1Qs4yLFKKk5BjgQEiL3MkDbhmwek+/vejBQI2CkYkaiC4NgId9mGFbeYo1Rp9ttMroO2y9y+ENI+DWRRYfUs7hA5fW+HMWvrmyl1h2scrL44surbtC2je3jeE8LdjQRLSLTeHwh6jxUDJ81/NEr7JeqtQ6F/ckgHWsCU8EZzifEiCKtFmzOE
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0138;6:ldfDRsJoXBI3ZZT02THT5JOfKrE0pcnCCvnuMa1hI0oNit9RLOO3hSkf6nFp5Dw4q16gmgfeqS86joqFAV9xBhFejU3EaQGWnz5rCK8Ob8d6ntMY3Abx1yezlyokaVnE+3Y3GUJML+Woq5ROfxxVnXtpMEKa6wn9HryDPpsRTGZwkRKiG/ZhuzfJlWGAbekFnbDVVb+CF2w7F9wZX1CcflKHTV8pOeMgxuNlt9ehJYZVqkVDfDvSF91olNNgD5Eeza3XVu8SytZ9JYPontTGDAdhxzrT4ztvC/klk48c+5MHXbSngddmepDmj9GSmfCRdux4P8fLpo2MwFZF+nEqrTWbCpUHV+sLWNx+/+JaMq47l9r2ghWTXuLDoKsjGbSpfiXTL45sNAK7US3JxomcJ6HSiKwEV7H9+6x+j0B5Rz2iivVBi29/VpvrTw1cxnj3jWthaHQ5TWsrwUHIy8v2lw==;5:j4WlByKICJRQnZ5FQ1IrF5bgOYo/l3hyOTdbf0tp8X4t1cxX12dyNXLZ11iJnr0PxEwtjvfQi6NtMxwwnQSI9ViC766cuQZCNys9jA1QJAX8vl4VoZU4aLXqxf0oIqQpd1S29bTWjr84TJx1LAdgcOacEN9n2xkeOwTIlwEds1A=;24:TyVtkGXz8cjdkbJCu+HgLsgEVbdjE6CVBIquX5Z9ttW5Art8ssRqwvljDwM2E+4oPYgaDkC/jd6h2xBNPnv6PDeYZ0W6CNVd28mksUBEi40=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0138;7:e3JRU9nfIkOyJZkfmgq6oOjxuluVjBaeb4ZOdgqETlHEw3QZDpM4ExH21XQ0EznAik1MZq38wCNvgImqnRhqia96YNQp5l+5a1Uum15iwCXb+TbH5YRPte67yfwdtoW6vQ23tr6SrxW3el92+tDTQmImTSdB5crRYL/FRy+1w7b4EJUWTYcx2BEXqYTNiSBYAJbR3DFp711TRLYqnIkOY8dBD6SFCr25HlTKrpEOElGnOWxUxdszLWP683gx7Yn1;20:zw1q5riYfKtwKEbjgb3xCMbcil8+rZfeolUyBQeXXF8IFlY4Pc7m9wX3AyPggK4nEHM/AmbMGWNhZjRL0bzJFh5GSCPtKV9cLDrQH9O4rgmW/T6DuH1OmjTyI07TLNbb9n7hj5p9riSHcjxOZXjEsZBtrriQ0lIsA/KP/T5tg97hEwfB6LnzHquod+wn/oAlWiXWHB96HuITqEScDvVVXuGLcppFBG9XPSbemq5vYLsfJcC5uCoCw/6t/yk/0ylm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 18:46:15.4132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6e6ec0-df99-4fb2-f909-08d5d54bc5e3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boris,

On 6/18/2018 1:23 PM, Borislav Petkov wrote:
> On Mon, Jun 18, 2018 at 01:14:11PM -0500, Suthikulpanit, Suravee wrote:
>> This enumeration is only for the family17h model 00-1Fh of hardware
>> revision. The patch is intended for the future revision of hardware.
> 
> I realized that but the same holds true for the future revision - there
> you need to remove thread ID and core ID too, right?
> 

Your understanding is correct. I was not sure about what you were 
referring to earlier. Basically, the number of threads sharing cache is 
used to calculate the amount of right-shifting of APIC ID, which results 
in removing the core and thread ID bits.

Suravee
