Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB00EC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89297250A8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GU5Y5oT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89297250A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753561AbeGBVgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:36:02 -0400
Received: from mail-eopbgr680086.outbound.protection.outlook.com ([40.107.68.86]:38190
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752930AbeGBVf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yha16T8LchjUd5Wb6hhGypG7eAcSVBmBnU0kQJcvaps=;
 b=GU5Y5oT0RSuQB6ReK49BbDLl/q4KoAasn/pUBwFgYc4PnWPWNHP+EuWgwBx5Emy9Lwrw6askV5W08HjTHBgW5rkUUC5BEaPkhIQmBcB+08sJjrxRQ7fsB1xWTFyWC0N/zZJkvI/wKKNmtzlgtiDfLjRD02bCbTjpbD4EdgKiYpc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from tlendack-t1.amdoffice.net (165.204.77.1) by
 CY1PR12MB0166.namprd12.prod.outlook.com (2a01:111:e400:50f6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.24; Mon, 2 Jul
 2018 21:35:56 +0000
From:   Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH 1/2] x86/bugs: Update when to check for the LS_CFG SSBD
 mitigation
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bpetkov@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Date:   Mon, 02 Jul 2018 16:35:53 -0500
Message-ID: <20180702213553.29202.21089.stgit@tlendack-t1.amdoffice.net>
In-Reply-To: <20180702213543.29202.79104.stgit@tlendack-t1.amdoffice.net>
References: <20180702213543.29202.79104.stgit@tlendack-t1.amdoffice.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR1501CA0017.namprd15.prod.outlook.com
 (2603:10b6:805::30) To CY1PR12MB0166.namprd12.prod.outlook.com
 (2a01:111:e400:50f6::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b958aed0-71fb-4ad7-a1cf-08d5e063cbe2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR12MB0166;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0166;3:OD/nCvMKqtR7IRqJX9/S/ppDaYG5E5RxvBjsyOYNyQLuR7r7Qlt6L8KKBOKtfef60PxOp+1Q2OlOd1OSSc13TW8rDkeye2IqQd6opq5+OpdLCr4hlzz6SoSnyuIISjPh4Pc9jQ6uMAJqhhRFDiIv86roM3NDuYpfj1eU6z4mbQC5JDM2NzKZBL0J8We4r4loRDUNjv+I5aWmP14C3Ogo+AVbQKH3pglrNjWiBMvFQtUAfakQsHpUcAEctndaufX+;25:HdTM3QZrR6NF7Z8/WXIJkXIN1ecwlm3/4qKAKgp2kTkOew8ubsHTYgdfZthL2I+A5919X6BFKl/oTFMD8cga1fQklizXPT9bHzgELqgIoVyiU3EIk00apWRSCa7KrkHBB+E6hlcKWyK7JwBOXgVAkx4zV5O+m3WsFE4WziRCi75DOZxiNH7aVWt3elgGEinCnemBHiuuUAmR+P/vMIQdqThQp+MVoOsmnMgFw5hJ5JMHnfDnQjnxGDdCMTbUh3z7RFtgqPACiGRdTHx6GqUz8A/RS+gb1tr65XO+RtTL2Lhua0ar0fbBKKMsLYcisNw+BEhZnFFHBuhyzkwqWANwwA==;31:Ctekby+boMMs+GGpgj52xj/dBsFDRwI3ZZ1BkP/b96kXxaVuFHL7cv3BZ6ym20mqKp9ugGIhptysUe3IayzqFX7s63XJBkseLyx8313RK6lVbHlvN6Q/kRkO25r6+l0rRsRRMFcN1QIedFb8jbWejDRShwTm3HlWRkkjvCjsLcw8Y4vqcYvksLGD2JEbkXy4PHEfco7a0skqNApB/CR9nvPOtM9TA7ak63ycsEt4CXA=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0166:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0166;20:CLF+xlKGJ/UReamAFJK7j4qHvMxBmkzzT3FJZn7S7b1+bjeRSk2AEdXyfbhqX2rxi06F1zWxhCT3QQEoYWuv4n3rmHOLDRhgd/6eYK/Pylg/eXz0A8ifKxHa0GMbDxRqQQjFW5wm3bXF5OPWle+88QsxohZD2zUHt1UjUiaC0aztkGvwuj5Mx/e/e9mpxlyNpOnYh76zesWIf6UjEA/QU9eRxn0yCznMI/FZFDnXFdHjnUUTFgPN5dqNWYTH4yY8f/cMiG9PGp6c6kMA2vnTn6aJeahN87bjWnRNttJWOTV4AbYdN4+9SSGQ7aG1JsbnpkCyJVJoOoSiINv5mCxxN5W0oNgW3VlPsEyosI1WVHEU2IyotIVydSuTDzBzOdJjU5tmyEC0/Ysb6Ou7ZJME4gDMGfXpOirgZvOrUjYZpwn94239VYY2/Kw6vMcyExBX9O6nL0YEpDma1PafqO4ozAmGfPeHMr28wwBL8VkWZddKiHuJCIsfdRbUbjI+2mVY;4:ky1zljgYSijAJiF9Do4X3s1GyA0VU6JksEAK1pdUDVpDP2063RfvUxVp7mrxUCGQH8kwovM+8ECYeC0gTIeQdM+DQ7MQWH/kJS5AimZS7FZgIgehBnbLKir5yOMToYP4dvhSgorvxsQllWC/uPqIWTsHcSgliibX0IwvMTIs0+CoEbDEyDN3PHjLfm7zSsEAmGMQHXgwPGDogzWmywN4WtdMj1BpfojbQzeIYPZUCAyHCel53DdNTJYStlQStRI+Uv4en4YbyMiFF3VS+sFqQP7tG8wtd2yBPFOeMKarWnpIn+Wps/AX6MFJdpIUGc2F
X-Microsoft-Antispam-PRVS: <CY1PR12MB016649AF1B04C40AD4FB1DBDEC430@CY1PR12MB0166.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CY1PR12MB0166;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0166;
X-Forefront-PRVS: 07215D0470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(136003)(376002)(346002)(199004)(189003)(50466002)(106356001)(105586002)(53936002)(66066001)(230700001)(6116002)(1076002)(3846002)(2906002)(6666003)(97746001)(47776003)(11346002)(446003)(14444005)(25786009)(55016002)(4326008)(53416004)(9686003)(5660300001)(8676002)(81166006)(2486003)(52116002)(72206003)(23676004)(478600001)(7696005)(81156014)(6506007)(186003)(386003)(97736004)(76176011)(26005)(7736002)(8936002)(305945005)(16526019)(86362001)(68736007)(476003)(956004)(486006)(69596002)(58126008)(103116003)(316002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0166;H:tlendack-t1.amdoffice.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjEyTUIwMTY2OzIzOnoyUmNDTktmR0N5LzNHbUxSdU04VExBZ0Uy?=
 =?utf-8?B?b2ZIQ1ZNanozMWVMSzY4bEh3VHhyVC9TSDFNSXhKdjdGbmFwRG03bWJERE1M?=
 =?utf-8?B?QzVpMzVFd2V5Qk1CNkxiZ0lySnpLSHJwalFzeHhqOExpVEowQnZOYWpIUWsz?=
 =?utf-8?B?cEVPb0FVOFZnSndhRWh6ZE9CenlWYlVsK0gyYU9MeW9pbm9TTERKM1RWcnhx?=
 =?utf-8?B?NU9GNVpyYkpsdXhFYU9DTUJTNDJyVThIdmJVZEplZkw3ZVc0WXBxaUpSUTJv?=
 =?utf-8?B?Nm11RGVuRnZkMjByMXk3aGlOd2hFczlJc2NYYnUwNnBSQ2R6bXhZa2tpRWVt?=
 =?utf-8?B?cS9TWnJOaHhwZERUWjV3OWM3QWZybTZBQ1dJRnRHenlkRWJ1QUR4SUpDdG9r?=
 =?utf-8?B?ejM0RGtQRFkrRVV1WTRyU0NtVDF4MTN6L2pJeDBmaFNraGlYT1QzQTdTRHg0?=
 =?utf-8?B?bHNuUXJCcFJLQk03V0p3UUNBV3VnbkNjMGlUZXMxMWRKa1hNbGl3UkNERVJW?=
 =?utf-8?B?Rzh2bEVzOEV3aE5jRGpGbHlTTmxCaWVXZk1hdmcrQUkycDhXbEREQncwd0tY?=
 =?utf-8?B?NW9IcGZvUENTcUdKbUNvMW4zMVovQVRxb2F1aWNQN2Z0ajlpNi8rNTZMRzZh?=
 =?utf-8?B?VG5sUEJ3M04zdFZ2RzU1Z01lN1QxQmNlalBweEpUM3c5WUx0ZXhhM0FMblU1?=
 =?utf-8?B?L3NqM2R2WWNvWHNxUkRzUmpnZ3ZMMGxmZWdrUnhNemYvTjlDbHNJUUNmb1ZS?=
 =?utf-8?B?N084cm1WVFRkWFF6dTd1S3B0ZnNYZjNaV3FwMFZRdW0wemVRaldaekVNYVh0?=
 =?utf-8?B?bWVDd1p4c1pMYWVOcE93VS9rNXcyaHYzQzAwM3BUQXZBT09Jc3E4VHc0Q28y?=
 =?utf-8?B?ZXJleEg4dG1GZFV2NXpoaXNzeXU2d0VYUk45WmVwaWRYeFRQQWtWb3BKRTl6?=
 =?utf-8?B?dDdabml6cXBBU0JPL09PWmpGT3k3b3FoV2poODdYVlZ2bUhnNXJFSG8vUGh0?=
 =?utf-8?B?WFY5dkdvRkoySFFwWEpJakVGWjhrYVE2Wi9URGRHT2lKQkVUL3V4VFVXTG9p?=
 =?utf-8?B?REc4UC92bXBzWUxiQVZDMTl1UGRWK01hTnhlMEVCT0pZcTZOVE5YMjRUdmJJ?=
 =?utf-8?B?cVdUa2ZuTTBVTTZIeW42Y04rdDlxOEVhYzlIN0pxczRQVm5xQTF0ekZSZkRB?=
 =?utf-8?B?TTUxNFFpYVdvQUJZaUcvVVNwaTVWenVkK000RGFmSWNXdVNadkZEeVorTjN0?=
 =?utf-8?B?QnRjUmlxWTZjTHBlaWpJRFc5QXRyWG9KamVoUnA5RklVQnhUa1BhaGVpVkUv?=
 =?utf-8?B?OU5JRE9US0pIL3VTcUhmeFZHUktFelFUMkd3OVhZTHo2RHlBY28xbVQvODg1?=
 =?utf-8?B?cXNNU2lDK1B5ZXNHM1M0OWR5Q1MzYUdrYWgyZjdHOTBYRGk3ME85OElmMU9j?=
 =?utf-8?B?cFBsdFpMSlY0U3NHdVNYZmg3NlVHSHFpQlJLU2oxR3l3dVp3OFpid3I1UXJl?=
 =?utf-8?B?dE8vSGZyRXJJQjByTkxjcUtUWnhTOVRMRTdNV2VzWlZtb1NrZml3amZnSVFS?=
 =?utf-8?B?TlZLZllENGtCOHA5bWowODloMjFPSmxYTEpTZDNqcWl4Sy90MlZHRE1XV1dY?=
 =?utf-8?B?YXlPVEZtLzlFVkhMNGYyVGU4ZDUyNUJWUEl2S3lXN0Q2cEt4RE9aaWpGQUF3?=
 =?utf-8?B?ekpJTWVKZ3pXY2ErZmFYdit2MTlqRTV2NzJwZmk0eVZKUE5iYS85elB0UmRB?=
 =?utf-8?B?UzUyN3NIQ1QrZmR5MjM2Zz09?=
X-Microsoft-Antispam-Message-Info: EmBb33cbkVBczJIFby0HXTaIHrPNbrMh9ciReVz6Tq020TV+ws5+XpTPhV8JsIdub38TZPQwTmGSIBzKswS7X8rQ0tkSZOydMsMt8WYsnIsH+eWw1jsWEXm9l9mAkZZY0UNRvvqlrHSM9kqOdKsgGk4yyOdEBs3WffGFHJaUPiJkcQm9UVa+HhGHRAAj97nFlWFYsoCkvyOgXyQemr65Kme6dAePDNHplBvO5umbBVT8MrdFKVMyIjuezW/HP+k/QpShFVbbPT7++eZV+3AomlAe1glwMC/pR5nNj81IWT9zMpzwgnlfpG6edqfOE7oL1+j1BFhz883qxXF4VMUhKT2v6MRLdpMNEvuw2HnKIf0=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0166;6:O0JSJ6ddeGBgv5uU+ktJwJd4ELzM7Ua2D/gOzM9tAuiu5fui2nhNtk1jJSkACrHz3a6rUflVGCBO9j26ysICKPY0t3L8KwkEty5InEldpff4FUiC4+Q87TO7f10A3uolC6RC19nmRmHUtOluUh5GuYUViq1iygv8vUqGqeJpQZ26X/PVUN5RFwcl/qh+VGYKcCFFwObsYFvXsW2MmIgtKkXglkVD6tUDqz5kMax5Pfi5iHYsJEGeZaAIPTTKH/i6d7/wk2FFkJBmQ01zRa8rYE+SYVPMnlon8nwYyLhnQCasvUGN8cSWKb/zFIome0MwKRnm/BpfPYQ49Dm8sdhmXwRRuvy1XLayhmrLXolXm1fgWT7GKVIi8ye//Vln0HlGC/e2dowFaOZom9eU//y7scBYhwAIsnOuvF3nS9ZnJVvqewGDfcFxkS3eHctVoUo+03zBv2LcBJ0n/ErpV9rKqw==;5:gIzA+zlf1phn4+uom2Y7pYTj15vKzM/RBQF0kD2kHowF7QQIR0x9B/pDNN0OWNFjzZMXpnaak/PGu7fuzyfeVdx8SptCkMxu/jlpNoZz7qZ5y727HuthBqnKu3beIh3pPNs99OW1JiZ4NLJMg1IKs4tYblxPRR+qxNBETY/nSTU=;24:XhE/TDyqcCDqF7LAeFq4ZoGTZobhFeAOH7GeitkgdA/73OjP3YD/S7ygv7m+1NRYoscZMwREzcrAmbPaJ3/VbmTu5rIu8TBqh6elqUs92mk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0166;7:RjxhKVopjyA+Oyw8F3hDMZXIlG3569AHmCLK1ArPuuIgUEl1miYKrQeqFVpRpVX4t0wr+yOQN0FbJsfcBLNHDklIoX/iq2DZ8qCzG1S1PweWNcwiPDYFmztiWGVk7cPpzOoTJl5NAO/rYPWJvmzLnYJgwRvaZBlWepQh4MapYwyUkYa/4dhdv42g09Yt9KejCudxe234mtVTfq/V9U3uKagM00pGr6ZpWRImqWvfizWrM708679KnTJhe/A3lwXq;20:0m6W2o/xtHZ80xkXpKphlJBt84wdSEGa+K7+7mRH6K6s8eNNCxh/7y9+mGUCFqBu0IdnUelLBWBsi/3m3vRbMbBIbUBoMaO1FgARRLLx5n+zx+MRw9BorDdHmMHfWZ5ORr6DGJvePjydl4m34fucisGrpO1Wi4HHtYKIwKJnF+PCgXLJFTmgwK9GrAdaEvTyCPon08PMStmgYDlv7eUs1NkwAvPTXrE7sGMcac9QukSGwkFXe8kjnbT4sQ6qXOVB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2018 21:35:56.4460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b958aed0-71fb-4ad7-a1cf-08d5e063cbe2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If either the X86_FEATURE_AMD_SSBD or X86_FEATURE_VIRT_SSBD features are
present, then there is no need to perform the check for the LS_CFG SSBD
mitigation support.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/cpu/amd.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 082d787..38915fb 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -543,7 +543,9 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 		nodes_per_socket = ((value >> 3) & 7) + 1;
 	}
 
-	if (c->x86 >= 0x15 && c->x86 <= 0x17) {
+	if (!boot_cpu_has(X86_FEATURE_AMD_SSBD) &&
+	    !boot_cpu_has(X86_FEATURE_VIRT_SSBD) &&
+	    c->x86 >= 0x15 && c->x86 <= 0x17) {
 		unsigned int bit;
 
 		switch (c->x86) {

