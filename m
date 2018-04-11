Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753786AbeDKQin (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 12:38:43 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44622 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753040AbeDKQik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 12:38:40 -0400
To: <acme@redhat.com>
CC: Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Yonghong Song <yhs@fb.com>
Subject: bpf: handling non BPF register names in inline assembly with -target
 bpf
Message-ID: <c8b0b3c0-6687-1be2-66d0-95b20662145d@fb.com>
Date: Wed, 11 Apr 2018 09:37:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:200::4:c80c]
X-ClientProxiedBy: DM5PR1301CA0015.namprd13.prod.outlook.com
 (2603:10b6:4:2a::28) To CO2PR15MB0073.namprd15.prod.outlook.com
 (2a01:111:e400:5068::23)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO2PR15MB0073;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR15MB0073;3:OJfbBJWM39kJEPaB6TqKL+yy1K2bhI/bFprBahvtmIy7fpek7PEwOewlUawBahambBuBn96yjhzl+LRNE/jbYJbwKGCvd/qSubYW/NFBEpA67ywHRQXqHCoLl5g9hqcQQ8Gblu86EDXrRVv+SyduBNXqvgK+DFtgOMa0VR86J2w8etvMkKhpYQpC3wRXfvEdT68FTfc5YT8NJCiOXJ2s7kK1lIsb9IPAeDPv0lHAjjG2J4ZAuHPljt5KoH6iQ1E3;25:aAFWt9AqJHEXc3Zly1mpiNvG7UhcSPNDT3bPmWk9jU3KBHcbsv0/6uf0qZcCVJebXmY0ayfWridsFXCXK2ojM5YKJaKvVoW0Zuy0XI53A1TERo7XJmUfPBpal6EisaboaKrhTiPlVwsaLpsfzlok5TEpDNWTu8fpMI2F6MYzIOX1TK+PYSYxInCg0DYmGzvY7AuHQ1cXT7PyVB3QTZAFq0UufABLVAT+wCWVjpj4iyGyee25j11aOVsvpnX8DqeXLNtWC6RK348z8u0yFgVrpOM1QH4fuMw/fuIxhXU6O2fY4EMB3kRTzk/pEQ39CNiQWiN3VPIN44Y+baVfrVkgRw==;31:eKn40oS+KRswFAC/QMPvV2g2vuo8nmPC6gm/bPGs2WugwdUJ47OzL18IQCMGPEnLslSugTUqedjKAjNLoZDraFLMfAhTBLrl4sbTgWiGQwOcy33ieSapkK3vwI0U2SAGdPdJVIaP8uVlBbsfQk73/FaITOjcSRpK0rINf7umHi8bhWZ28BmK18qb20dAB2VrdyaApM0EhxdDoprnY3yXFd212x52Vl/2+kA5IsjTnqg=
X-MS-TrafficTypeDiagnostic: CO2PR15MB0073:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR15MB0073;20:MNrx+rJr90T66+1tjtpsK/b8TVEc2PTSSWZp82Ux/OnDhJWduwE6/GzdXYLVQJowO0VLuWXw/HYz5zdKIXFPoSWeNxC4nHVa+vcSewUtURCbLIbE0wkWOR7U2iDH362U5LI6URA7LL9zgMCejnsLcBz0TN2O23sWZiiithmhrCGNaXzun7DqMQHGni2WX5KhKXTpgqQJZEzB/lTzIJChvoMP8Y7TlNFynmtrE0ZFMdsR/eNzi/7xP9TTfbm0LLE611rVqxciaOXhrG9Ze1YVYKS/Lo7VPQ9ZUHbwpOBpVzYHaFtLqkTL4yPKR+kN1REedD/vQdcTrPpP5xm950X9Y7Kbzd38TRzOQsmskANXtd2nytCX5kU8xxeFAXEZaA/c93mMQIljp4YrMGDburs7Rn4f1vcg+wm1j7OwisYlDMhhCTXf1AH/NHyrDO+/+aQva4UAuF/ue1S6v7LoJrxbTHaIBz3s4a9egg7OjB4E4IolexFAnTw1yPRp9AKIMTXH;4:G1DV6ITIH9pS+1q4Lf9AO3gPXwqPPz9rXnQIGkSKxjNzZ/AJ3vp+yPcdDl1i/sfF9qir8otT25xUX/ZF0odqJkNR5cnczERBynTMY7eaFJPZsbrZT+16E8vCKi0bbBfD4ijAzdQ48cNFCn2NjmKsAHeDyIYSD5uG3mQWC2Y8WtR+3csIzXOVEraEjqNBE7R0W5ij9vT0AGell7KcPPh7iwEniIKJi/wPOBegMFUHrUqQFQvHV4Zv2yplQ9Q/wSRjttqNZqDfBbekqL55E00O5Jkm0rYGP333pfHO1n6Av4W150Rq31w/RboXTKCWK81ddluF48D8rzOJ0IvqlCucko4LZViJhDuBLSducrwTFPTbVByz/2PTI0PCP8qbBcuO
X-Microsoft-Antispam-PRVS: <CO2PR15MB00736916A6324CFB81F230CDD3BD0@CO2PR15MB0073.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(15185016700835)(2884558487581)(262104967686372);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(11241501184)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CO2PR15MB0073;BCL:0;PCL:0;RULEID:;SRVR:CO2PR15MB0073;
X-Forefront-PRVS: 0639027A9E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(39860400002)(346002)(39380400002)(199004)(189003)(16526019)(23676004)(50466002)(53936002)(52146003)(186003)(2906002)(2486003)(52116002)(2351001)(31696002)(68736007)(2361001)(6512007)(305945005)(7736002)(486006)(386003)(6306002)(5660300001)(6506007)(65826007)(46003)(2616005)(966005)(476003)(36756003)(52396003)(81156014)(8936002)(86362001)(58126008)(105586002)(25786009)(54906003)(31686004)(230700001)(316002)(106356001)(4326008)(81166006)(6916009)(64126003)(6666003)(6116002)(6486002)(65806001)(478600001)(97736004)(65956001)(47776003)(67846002)(8676002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR15MB0073;H:iphone-409c2846b52f.dhcp.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDTzJQUjE1TUIwMDczOzIzOlVnRGM3VnV6WkRQQ0xUdUFMZWVHQUJSQ0tC?=
 =?utf-8?B?VTNDZVZWOTNKWUs2QXBoVlA1R0taNXFzLy9ZblRFUmtnSG1HMHdJUUxXQ3lV?=
 =?utf-8?B?ZVBHWjk2Q0RETmNGVFphbmwvRDBReFEySnJGN1BOUWlBWFBzWjB3dVB3d21k?=
 =?utf-8?B?TTBRcHlMS0ZNR1hFZmdBaWFKR0RiMnR0VkRFUDF1bFJWVG9pQWNQc3dJVGlv?=
 =?utf-8?B?MG5rb0lwamwzQzJab01OWGRLcGVWWWs4UHNkaXRJVFpEMTlBalRxSDB1RmVi?=
 =?utf-8?B?RDlzVGlBVmtkMkdZM3UwRklTSGxuTndOd3ROQk54dmllQ2dIZlNGZi8rVUs0?=
 =?utf-8?B?Q3dHTGE4OGVyeVBzMW1vdy9NdHlVMmQwWmtYZ2lsMzZ2ZEgwbk5qaDJOcU51?=
 =?utf-8?B?OURuVEwzNHpLdTZ3MnYzMnIycFVkZFg3dVY4bFgyUURIWnN0UjZWdXRXbEht?=
 =?utf-8?B?UE1lbzZhWEo3eklVTFBsY2NMTGt0czVsREc3UlN5clJ0OXViUnBmUThRM0NB?=
 =?utf-8?B?VnVzYkhrR2p5OXk0bHVCTHFDZXBYVzNuZ2s1T2lqUzZTNkkrb0x4cFgweXBH?=
 =?utf-8?B?dWxsME9FVU41ek1GS2JhTk0welpYL0RmUS9uOTk2OUZFOHRkc2kxbERiSkFa?=
 =?utf-8?B?bCs5QWJqemRacXdCNnJGN1p6eXo4QWxKYlJUaktiandkNXVlM21TVGNYaGZB?=
 =?utf-8?B?ZE1nS2JHL1FGcGxhUVFRbFhRaGR0dXJ1ZVoySGxCeXRCT2dFNmU1UytlL3Zu?=
 =?utf-8?B?Tmk2b0w4MXM1OTJDWG00ZHNPR0xFVjVDWEU0YXJhTzJTdUxKeGIvc0tOd2ZB?=
 =?utf-8?B?MzRkSHVJbC9QMHU4V0Yxc29hNEplUEVrQkxkay9OdTlOL3FKczRjYzU0eVZU?=
 =?utf-8?B?UGNzZjdoNkpEZUJLajRNRmx2aWZnVjZoNmp2QjhHd0VZa0ZlKzBGRnpsdUFN?=
 =?utf-8?B?STZlSG1UTDZkakp1ZlhDM1Z0c0RNZE8vMjBJeldONnhHejYzT0x0RE1ITjAw?=
 =?utf-8?B?anhsUTRnampYcmJ4ZkdZelQya1JjUEo0bXVXcGJrV3ZrSFpVZm4rdWtmamox?=
 =?utf-8?B?c2N4VUpRTGhwMytzN1FnNTlnVEFhL3BBNWxFbkRjYXhhaUdMenlMRVBoYU96?=
 =?utf-8?B?OTR2RXd5U2FrYUtyL00wZ1loWjFzUGpSWUZxTytPZlBjLzZ1R3hzSzFBbHQy?=
 =?utf-8?B?UVF5VGoxVFY3djJodmFFUndkV2Nrc2dodzg2bVlHSklIM09FL0NyNC8wcG1y?=
 =?utf-8?B?TGFWV3RPM0lvY3JoQUlpY0krczFDYTZ4VGtudG54YmJDSHkybzNtakRaTERP?=
 =?utf-8?B?WXg1S2RrZGdCY2JUSHIzek9HQVlOMXVFVlFNVTZmdWtBRzZSVXh2MmcxOWdY?=
 =?utf-8?B?TU5NQTVCdnMvUHZEaEJqd2FoN0lpL005ZVdnbWpmQ1RCKzRrdjNMYXl5aEFh?=
 =?utf-8?B?bWFLdDB6TllpdUlpSERPdmxuQXFzNGE5TCtzeWt2SXoyVXVLNFdoR09NdjlZ?=
 =?utf-8?B?SHFvUVRkck9lNmJWOU9wR2s5NWpmYUEyc253a0tFdTBCWkxyZ2hoc3NoUDJJ?=
 =?utf-8?B?SWlqZDZTT29HVkk2YUI0aVFRTURScHJBMFFjRjRuTzdCa3hkWE5HYys1UGIy?=
 =?utf-8?B?TWdjMnQwWk5VdUJoMW4xK3pFMldkZDFWUEZaRG4zQjhMaWs1L3haNmdGM3Mz?=
 =?utf-8?B?ci80NUFyay9GZitGNEJ0NHBGU2M0ME5Fam1oTzJLQjdOMjFzYkdqRE9xU1NL?=
 =?utf-8?B?c24ybENqUzdCZjNuSXFoTk1La0tROTRqL3hKVG03L20xY3JmdmxHbUo3RXl1?=
 =?utf-8?B?K0pSSDVtYXBJSDhxeHIxaElSVWxxTkpET1N3KzFrNmFWaFdrbmxnYXpNT3Rh?=
 =?utf-8?Q?wVaZ/z1pMa4=3D?=
X-Microsoft-Antispam-Message-Info: DpMS7OhgOGTPbdoDZfyL+gq7VN+4KvatoBjng47ZDHOx5VsVCZBQy5s3FYzJCa19TsabbU8YOIRphoKRle80GHAXTao8sVMdhfOZPVby1OLjyVVOfGdTfvu01Uxe5gRMQqNm1iCpLDVdW5//rq0YogNIbVT+xH7oCx3yVm+Yyy26mpcWBlIy2omHKiWHtHyv
X-Microsoft-Exchange-Diagnostics: 1;CO2PR15MB0073;6:rXjklOjDp9+EMntbXcDVRiGU5y8Te5YiitmdWq+yaUPqY50JrWNoq0BwF71SL6L9MSGiMeqM7KwhokE9M5NxGi6q3ZFMcUDvHs+bHx6PHtae5ZKzqCQj5CrrQlqnD+8v4cdPiGQf2jIS2YaMPY613ShMQQxW0P/ZxfuAzglsqU/T7QhgUioTpv6Ugfyjdiyim+0VMjYr9IUBXAMYF2kFaZzek/jwPxVmn5iwzO2ksy6LXkU++s2Iu50onuQwbnMmzUMC2RTQ5i9Q6TrJKa1BDYc7b/pONEaESjvZZV9qAyhOcxtIYeD/6pc2gfKoKZ15m5M9lSxXKHSftSmi6GipmJFj7zenl7PrqE+dDu9LaDsqkkQJEkPrQ2+Sr/Tey+CoHrsqBVerTts7mT+krriPq1nzl8QsSMRoRLgO3/rBFqKY6mCcn3O+Gp1VjedIPhyWUKBoW/NQjecuYrmfP1HbtA==;5:hFW4j5UAqwryO0mNyGUQzUQajflPwi6yvLj+nQSKLEUfFnPUeRuEu/TRq4y0kbgmKpfJ5iews+y8zByH9xdToJMzW6k7pAkZBFdi5f7PCPiyFmwBM++M07t9KpUB0mYfRmRMUF7MhsdR0BYQsUzt2wQbLkAE0fMVmjNxli1OdFQ=;24:Q1dt1azTiSpvYGAKtqVUDxJV+XVljtiqTqIJh3m2iFx7i+ECdDyflFGnwNoHQ3h6XKwe9dcYTJTYKx5bNCBq/OdU7dx/JGavDH5D9MKAbcQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO2PR15MB0073;7:6OIYTFHuoOcgLY5IT2F4z/b10lbuGsLNzBbhHiAdy6gRoxR7Xx+MENRslrwNXJVfFYdbfG9FFks5obABU2rUQyj8DElus8ba32TQEgPAaw2X2xqe3Nxue9nJxLpRiVV7LZAgyZcdSbEzEl+9qSyAG3UOsBkiqdxrLlGFpjejnIuRjKxIOla1x3xAKn2kIakuuklqKW1/IKkeOJ2e2J9F/d4s6f7ono0KGryM2P0R3zDFpZzBcND94PlfwdOjDxwK;20:8dHmI4DXyiirpuRS+JBun+waL9TYP+XqLutQfdFChSn06LlGm1F6Hgkrq5KCODsAVVAtwgJOBMPyb2Sfw3HzL64F1CZnW6e4UGN7lbi6Xz17KJmCxV7/HRQW1aFD2SvovIUVRAIIE/kfELup9w4X8iDA9FkUvUbRc00Br9K0hXA=
X-MS-Office365-Filtering-Correlation-Id: 03f1c328-1034-4577-b77d-08d59fca9163
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 16:37:50.2828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f1c328-1034-4577-b77d-08d59fca9163
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR15MB0073
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-11_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Arnaldo,

When I studied the bpf compilation issue with latest linus/net-next 
kernel (https://patchwork.kernel.org/patch/10333829/), an alternative
approach I tried is to use __BPF__ macro. The following patch
introduced "#ifndef __BPF__" in arch/x86/include/asm/asm.h for
some inline assembly related to x86 "esp" register name.

==========
  commit ca26cffa4e4aaeb09bb9e308f95c7835cb149248
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Mon Dec 4 13:08:47 2017 -0300

     x86/asm: Allow again using asm.h when building for the 'bpf' clang 
target

     Up to f5caf621ee35 ("x86/asm: Fix inline asm call constraints for 
Clang")
     we were able to use x86 headers to build to the 'bpf' clang target, as
     done by the BPF code in tools/perf/.
  ...
diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 219faae..386a690 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -136,6 +136,7 @@
  #endif

  #ifndef __ASSEMBLY__
+#ifndef __BPF__
  /*
   * This output constraint should be used for any inline asm which has 
a "call"
   * instruction.  Otherwise the asm may be inserted before the frame 
pointer
@@ -145,5 +146,6 @@
  register unsigned long current_stack_pointer asm(_ASM_SP);
  #define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)
  #endif
+#endif
...
==========

I just landed a clang patch (clang 7.0.0 trunk)
https://reviews.llvm.org/rL329823
which will permit bpf clang target to accept ANY register
names. In this case, the inline assembly will be accepted by clang
and will be thrown away since variable current_stack_pointer is
not used in bpf programs.

If the inline assembly is indeed for BPF program, later llc AsmParser 
will do syntax and semantics checking again.

With the above clang patch, the above "#ifndef __BPF__" can be removed.
You can decide when is the appropriate time to use latest clang compiler
and remove the above "#ifndef __BPF__".

Thanks!

Yonghong
