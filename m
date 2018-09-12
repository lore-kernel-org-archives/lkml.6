Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6C6C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC4320882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3f3fBoxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC4320882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbeILWV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:21:58 -0400
Received: from mail-sn1nam01on0068.outbound.protection.outlook.com ([104.47.32.68]:38385
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726862AbeILWV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3a32XgpeY+Fi38xbNz8Vd30GGmw5OgdBcgxw/0oK7+I=;
 b=3f3fBoxSTNUYuocMSxop03SO7JM7/xzMIZamuWv7XjvHDmrzPssXMD+T5ydbkZB4Zd11Wu8ejwXMGST+fmaHqYVyReDAexc7MoFzoTjV/X44uBNHEdkNRBW/gwHPmRHFKZgU5cBBgY/s+DRIcPf3LY2Cm6LWKrpXx93ITILb7Sk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from [10.236.18.82] (165.204.77.1) by
 CY1PR12MB0166.namprd12.prod.outlook.com (2a01:111:e400:50f6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.18; Wed, 12 Sep
 2018 17:16:20 +0000
Subject: Re: [PATCH v5 2/2] x86/speculation: Enable cross-hyperthread spectre
 v2 STIBP mitigation
To:     Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <nycvar.YFH.7.76.1809101119280.15880@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1809101123520.15880@cbobk.fhfr.pm>
 <alpine.DEB.2.21.1809101158080.1402@nanos.tec.linutronix.de>
 <nycvar.YFH.7.76.1809101259520.15880@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1809101343370.15880@cbobk.fhfr.pm>
 <f0fcbcd9-4619-391e-3c1b-34d06b00de50@linux.intel.com>
 <alpine.DEB.2.21.1809112315320.1427@nanos.tec.linutronix.de>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thomas.lendacky@amd.com; prefer-encrypt=mutual; keydata=
 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
 zSNqP+QUNp6BotWI
Message-ID: <f95c28d6-70f2-3f18-4ab9-c756c7581126@amd.com>
Date:   Wed, 12 Sep 2018 12:16:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1809112315320.1427@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0401CA0034.namprd04.prod.outlook.com
 (2603:10b6:803:2a::20) To CY1PR12MB0166.namprd12.prod.outlook.com
 (2a01:111:e400:50f6::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c985306d-bd06-4a61-91ad-08d618d37586
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0166;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0166;3:NpYWIMbeTAqsstM8aM44TqIugRXW6YZV5hqdIQx3WxqZ7NFmZHnBZ37YvuZRnCPisr9HT6X8L72C7e/GfyPv3NVwBQamjfPZ/wrFpbWTDVS7qv7lcyHCD2Va7r8cJdBryYnm1G5ejOOr2E4+c47rQY+Ca93NbBTskXYr2H+iDHnjPU1epqfTMDwvIiIlrRnVyitlElZdriKBJFGc/n4qhZKkVPya+ooH0AMXT5oOxopg6oj/5TVyULzA0pUmdXn+;25:M22kXGs0hYDgmljulSenDgYSiwBa0qbuOPjssjQqUKOW30JdMH3TU/KQbLvV7dgtTiHr0OzlZ+8EXesblUc1fTngtv2S19o5qGCVFoLQXzIyNdCd7BLfmCinA8uZvEmlRMCEkcbFEdp8CRn/LY+JJO3oRu6EtnvCfK6SSREbJmHAv78SqgCdW2qTPEzLjkORoQQNKFfmfJPXphDFPTL1/jl4N9HYMjv4sABEdZdN0nLA3K5YLKTN2yfTKtteZGuqLDOVmDWkDx/7Fjwowgsd9lkjPHAYqJ0CoKmekbBhBsqtkfQYwo31mQFVm3m3fDmCls/nXipGortvikc2TMuxiw==;31:QM/T0pX4AfdbP5C/5SSZEcFq8DHB5vEeFVZAMcQ6GvJKdlzt5jBpCTjEF42SYTHtawGNLgptEtqqpirVZeFimqnnODqzD+LVsnHYTmxw0Ao+ys2+s1UJsvEUQ50sVBRNGm0WJM+Y1AW5XBKyML1fdel1fbnOYcoKnq68AGkZi2bxbnYZWhTr/GL8C1TNEZkxj1wmJTo1eXL66MuqDDlW+5NKPFyUtPTyvKa78Sc3Ano=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0166:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0166;20:wFm1DYbEs8hDRgP1F358v9NIDnYRfBpCgZ30tImnIhBxXJ3xgH2xgqSSwOO6jkbfx8mzGkdtBfm5Vmgzv7FBdpa8eOniTuE2fA25b1M5gDWPVcGvB4SHyuIdeKDMawLDYGPJsj7K+NGShCM1hoKwHH5ZRIEva9WUmKWyoCExLx6zv6U1WKPuc66VJhBKytj9hA9Mm+hTUtq0ZAsXZJJsoGHrJinFNiyfBKjId84YmVX9tSWD+vSOD+VpACHVYridIsl7yKsY5hT+Em6pWAmk/PHOFH3czU0SHRonvyKKRbnGzLTWs35uMpDTcJXAmdaOFX04wNLvyCZX55Z3xaMW58NEuWGoKSIPJqlntVQPaL9tinlQVTMjWTCAyLYMsjisb8ydS3uX+BEgUg3iR16m3ml6EnETD7jDrhIXJa5dWrUcTpA6q3BM2m3M1q/EnEePszyE3SK81UX90P6GYABUs+UrRoNUf+pA+7OZrm2I9Lzi4P08wVABW/K90HgOSdXE;4:NLS0VlaUZIjZzUFLQbv60tvBfZioqpwLv0cHaloQJzXadbGNLBX6OzDbvbCkz9fsGmgUV8EflxDOahBAiQ+w4YoQA75jG3jfh/TjZI6zLiDWZz6QpQLIm7DCyTUR5ioPNfdS1XvVzROu5HkeiNw2zouXCKqItSVZYM8FKlXJTQe+jYKC83RnLIGU+uERSmNr5lk4W5Alg/DZoLlFSl3r62ZE5oTE6vsqvkso0AjwH9Jxstbso417T4NizcNIVjZNEmYllVtJZg/WOvJEBJj2ulwx+AMfhb3CZ+WlOgo7LzWeJ/zdPekdI46o9g9Mz0Kq
X-Microsoft-Antispam-PRVS: <CY1PR12MB01662AD5897B4DC0B91DE96FEC1B0@CY1PR12MB0166.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211171220733660);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699050);SRVR:CY1PR12MB0166;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0166;
X-Forefront-PRVS: 07935ACF08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(366004)(136003)(346002)(396003)(39860400002)(189003)(199004)(8936002)(31696002)(54906003)(478600001)(26005)(446003)(6666003)(386003)(53546011)(68736007)(64126003)(316002)(81156014)(8676002)(3846002)(110136005)(16576012)(97736004)(58126008)(16526019)(81166006)(7416002)(23676004)(31686004)(52146003)(186003)(229853002)(47776003)(77096007)(6246003)(230700001)(25786009)(65956001)(66066001)(86362001)(76176011)(105586002)(6116002)(52116002)(53936002)(4326008)(7736002)(2906002)(486006)(72206003)(65806001)(5660300001)(6486002)(36756003)(93886005)(50466002)(65826007)(2486003)(305945005)(11346002)(956004)(2616005)(476003)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0166;H:[10.236.18.82];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjEyTUIwMTY2OzIzOmhKRnZNTmNsY3Y4eVFXdXYzc0hzWWVzOUZr?=
 =?utf-8?B?cWNVV2g0TitYUUdDSTZRT21UZHNFbExhZjlzbU0wL0lEdHQySkIrQ2kxNldn?=
 =?utf-8?B?NW5iY0tMNmpuYlBtYnMwWEJZVzhzMzNlQ0plVzV1VFVYM3NrY3FycmdKaW1E?=
 =?utf-8?B?KzRXYVpZYU04L05YTkIrWGNsQ0wyd1hVVDFFY1h2S0lUTXRtbGhPTENXdjZJ?=
 =?utf-8?B?Y1ZST3diNE11WXNmNm9JdGtuN1lmeFZacStVMk1GYkNpNm9sejNQcHpCN1Bt?=
 =?utf-8?B?UFV2QlQyR1dyRlg4ODFZZlROWE9oRXdNaEdkT0tEeGtSSjVlbm1OenVKdW9x?=
 =?utf-8?B?MEk4WHMweFpab1hMd1FOTHdtdmJEdFZhNlBjZUlKTitTNzJoM045ZlhBK3JI?=
 =?utf-8?B?Rlh1RkRQWXFPdDNOOGVVVGROc0xPNUk4NkJBRUxUQUEzL0Q2SmY2bGJ0Y1lS?=
 =?utf-8?B?S1B0M0dKaWtUUjZUODBLRkpzd0dLNWVBdCtQRm5TMVppRkNySGxyLzJROWY4?=
 =?utf-8?B?eUtkdXRmalFsT1NxaFZHd1ZqTU84bHpEZzkrTWQvT3kzS3lpS2E4NFg3eEVN?=
 =?utf-8?B?RUR3TE8vYWpmRjRZOFhsellaODF2NnJBcVVKUjdSUzBJeWRyT0VOT2RuZDF3?=
 =?utf-8?B?YlB6Y3hoZjV1SlpJQlBETUlXbWFheTJFb05VdUIzblVCR3k2NFdNYkVUT3Na?=
 =?utf-8?B?VlBNREF3a1FWZzFvZ3g5b1NzUWxnQ1lrbEMyb2Z2eklvdHdUWjIrV2lwNFVH?=
 =?utf-8?B?bUpaWFpvVjhXUkNDcXhXb29zODRWY1JhMEp1bElPMnhHUjRlMExzVEk0Zkli?=
 =?utf-8?B?QktxS2RQRGlqK290L05lc1pSMHh2WmNnZU5Oc0JZSTRnbVR2MUR4aFZCRFc5?=
 =?utf-8?B?WFhaRUxsbTQzM2ErRjVNYUtJR09kdnBwYkJtUjFkQWVEaWs4c09RTFJuTTVn?=
 =?utf-8?B?Y2tPWUU4VWxTbGJkYzhsZE5aSko2blg5b21qZlBvK25sQUJNSG9YRERuYXZF?=
 =?utf-8?B?RHFlM3NKcWp3KysyTVlQc05tUTdLUUo2MlZqS3FXME00TDA4ZitEbnRFeGxu?=
 =?utf-8?B?S3lmMnMyZ3VWN0lrZ3MrSXhpZ0t4bS85ZXQwbHdCSlVlK0dNaTBqckVERHlU?=
 =?utf-8?B?d3RYWlNOdHNBaXdQU0wxUC9oamd0L1FDL2NzZ0ZIZm5PMkFDeG95dENVZFoz?=
 =?utf-8?B?TUViMDBiemM3QitBVDdQWm01L2tQa0lCZUV4MTE1bGd0MC8yUXBaanhVR1Qy?=
 =?utf-8?B?U0t6NVY3TGYxcFdpNEVZci9IZ0tXRjlzUkh6WXhaZ0dBZXZsNXloNkpzSTZ2?=
 =?utf-8?B?UXdqZ0tVTU0xWCtNaFlpNzQ2S1NmOU04Q2R2WjdJY1lDckkvQlF5K2kyRmo5?=
 =?utf-8?B?Qkl6SUZQTGRsdmZGSElXbTBmc0NwWVBtaVdtTlRNZ3ZWQ3Z0YTRjcTRpNUhG?=
 =?utf-8?B?d0x5M3lyRGZtUjhOK25vTzRtWVBwZ1FFdS9zc1ZXTlZ1Q1ZrS1cwWTRPeUpa?=
 =?utf-8?B?Vkt3WFN4VDUwVEdoY1FYMjBHQ2dhY1p1UW9oMEFDQ05MTEtlUFplMGt6R3ZH?=
 =?utf-8?B?RXhscDRVODd4MnV3YldWUVVPMk00Yk5jYUR5Wk5QQnlSMSs4czRVYVB4aXYv?=
 =?utf-8?B?Nk10TElPVmdoYjhEU1FFU3ZBSjNXNWU5ejN2d29wR0NYcXI2TVhzMUhnYzU2?=
 =?utf-8?B?Z3J3a0d1YUszcXJ2U3hPWUtDWEhmc1dST05KS1lYd21SZXBHTlVaWXJ4c29m?=
 =?utf-8?B?MUVQTjR1ZDdxRFVmZmhWd0RmTVQxaWhPOGFiVGpaOTVHMy8xVTBkdDBlQmhy?=
 =?utf-8?B?Znp0SCtFeWJ0cHZWWkxka3REUm93NE5xTEpjeVltVjNpUDFRRGxYZDcvYVVL?=
 =?utf-8?B?YnRKSDNHZnhrN0taVXMxdkdGN2dSemVRYklJeEFpbHVnTXlDbTRKcUtKTURh?=
 =?utf-8?B?Z3ArdHJCdWxVOXJrUnVqM1J5ZE9mVmtaVHZBa2tJTCtKQW9iWGV3T2c3dWMz?=
 =?utf-8?B?NnhKT2wxOXhiK3daR2V6L29SKytGTnBFajAyZz09?=
X-Microsoft-Antispam-Message-Info: d9JoBwkXrj3jOqulQJRxUYR76CodMtXENtvOl4TnaYo40tHYD2fnxHlRQgspiXX5jCkkdA4cPr61qmAiuPSd1APnkVwZ0j1jo1GrzzCOmTqk9n4raUCAPGg3wzSmNw8Ggvo3tJsU+1n1qKBbzujoNOQnU5ZWPCk9AoUia8Fz+UguWOYLfXAPmxEIEIzbNXVM7MiTfTIBN4B6i1rpsV8S5qO+Ltk+bG4/J/uwQZIN5G6Nch6j+7uhvrVtRg6Al5xdLn/lV+aPk0gzCvqx1V1KJpEzk0ij4eiNZb67ms6Ch2oVKJjbrrKpi418N/XsZoxX5goGbpGunBEsLoh+UcdY+rGETb7mbXrU7VsoglOI1nk=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0166;6:q7krP+yGyRFmLGowfpwmIibYhGmcxN558jiP1ATnasNpRzUvI/exYHEqjQpCcdZ8zTZxBq6Ssi02+XBhZcWltX26xHyhG24sGDksZes/4Sa6jg8KLsYYxrHhUBW0hVFCn33BRaa9g1Op7P4YiE5Fp1ZHUXRBP3tAX6trzPNIW6HbZpOn2rIO9Q2QnuEEwqaiipOzRXkJpHXvIeeqSpVg48pYK3iZK/NNr3aRhp+qeL/GfKTTbBSZ0WvbT/wGf+Lvznbyqi6uw2PUNv6YnxbX/86isa8HPfDy8AZjdMq0L2DiycuRMzP/Ig4GNuj+VR+hjy7aA1yC1MsB579M82u/VmvJS512hobiUnfE6uUD83Qe0PnfJZVimPUBFrvTBBr1k3jodtg4usKSuw6YHDfk3c6/hC7lzF5aNUKQRqV1LH34VHQprMj7lskjrBy2fvqEDGlqsFA77eWvx9ngmjCStg==;5:RHn7w99fUmLbI69jaE8Oesj2wW6aSIQiOMfudWLrqz2sgTkDcDeZx2TxJRDI5rIMXlkX4uGXARB5TMnU3d6N9DKTb1kGr3JxXlxCs08vyM8Y240F7lRKA53xkfTC7V4Wh6Z+nPEP/0OMeS9lFHLWZhX5mnKBlz9EDNG4nBCMqjQ=;7:5UGMiaFAFElmfCXYtXxI4Uowi5HixJQvdbhp+vg6u6R/G11jkTy1nyPT4UQS1aLnf9/Xk94ezgHkx9hKYPdP0/hitrrYimE5FAujKtedLrrqk8CUCoaRIaIJzX1dxDrvGUOVqCDpz2H47Ojl8VcHboNKiggv4Zqc3whVux6Is/WwH1kzcybnFgyeN7l/6C9+vsAzAsJK7M20EvkmOS++IG7g+uHWOPW0Femx1gydrM1CSjKE5ACaSBGT2lmHqK8n
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0166;20:cSAr+kGJA/FfPgHhF1QsxNUmqh0ZohRxij6kUDjQYqcgn347aG3wwmdMAm/fAAADZ32eFX76WzzGuf2KFxJlQkqemI6WO1a3RqcG9QwjVdz//iudPn623fgKAEgeglkC5LrqBcrNrqBLcsWhBs2Ms20FKsO4XtZbQ1+9E/VmlvIJ1LC3jEZZD0ekue9zZUwZJfacE8recYYaUDOm3p3lyuxp9y/1Tg5GTWS5K/FH/M41g6FEjXOqjLxEPLiACEsO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2018 17:16:20.0267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c985306d-bd06-4a61-91ad-08d618d37586
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/11/2018 04:16 PM, Thomas Gleixner wrote:
> On Tue, 11 Sep 2018, Tim Chen wrote:
>> On 09/10/2018 04:46 AM, Jiri Kosina wrote:
>>> Nah, IBPB is actuall there, sorry. So I'll add reporting of STIBP + fixup 
>>> the missing reporting of RSB_CTXSW for v6.
>>>
>>
>> I anticipate that STIBP could affect workloads with a lot of indirect
>> branches (see previous discussion with Andrea).  We should have a 
>> knob for people to opt in or opt out of STIBP.
> 
> Feel free to send a patch to that effect.

Tim, are you planning on sending a patch for this?  If so, what type of
opt in/out are you thinking about, something similar to SSBD?

Thanks,
Tom

> 
> Thanks,
> 
> 	tglx
> 
