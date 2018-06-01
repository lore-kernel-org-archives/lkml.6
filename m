Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751842AbeFANvH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:51:07 -0400
Received: from mail-eopbgr10115.outbound.protection.outlook.com ([40.107.1.115]:28608
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750850AbeFANvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:51:03 -0400
In-Reply-To: 
To: Kees Cook <keescook@chromium.org>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v3 00/16] Provide saturating helpers for allocation
Message-ID: <0634bebc-e16d-ed40-ee26-5401e4bc7b50@axentia.se>
Date: Fri, 1 Jun 2018 15:50:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR06CA0158.eurprd06.prod.outlook.com
 (2603:10a6:7:16::45) To HE1PR0201MB2458.eurprd02.prod.outlook.com
 (2603:10a6:3:81::23)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2458;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;3:7YdagoqfLan2kvBj80Tadq5ZdMptjGWuSY/HmpP0jvZhDdC4GewIR1Rw2p/PNMafFjT7T6+093gpK/gxs+y4xCONe4XG/Z5rdFbrqIbPvRZ5b4LbvH87PC05mAc41AigW+0gBIK0bXxx6Dxz/eADDDtVgueKgxB92Yu1VghiiXn07MLNGQSPxEoFpiKIlSOoexI3cVtDzrXzYQkinET1D+KwTmxWTmDgaEXuF6ns00Dp+VMF1VpwmbeNdpxDbRMk;25:nKiaImIO+CqricZykVkJibRudiCgKEbOwtW7KEZldoIQFQec/CKbfxildw5OwBKvQPGNvHbsY3Pt/WFlEEFBKNCd0dN4EbWqtcXHWdzCB4oldqWobkwvWxYCs46os3ccgA+h6EJ/KQ5PStE/0if+EZ0urkIGunboKRszfItBRg3FhnFZrKvHJgr2wbH4Bfew1Ic8fufl60BSosy4e+5FMgqU72uHwXsktfcN8FERHLAuX9vSN4SNXv28scBoI7d+CCu1z7mLhkpTA+G+gMsYbJ/Vs7MvVjocbBJaP4olaUXzMcZhoMeonLsMda40aY3G2w5I0X30DjbqABrycpk/5w==;31:QMG51kXtyLDnzxK6S+uIKhnTy/W+koWf4qfyNVV7hL8+me8b2WF4fQIJ8IwBmuvcpMVL5gw3SWIznkm7QY9dJFN/cAGcxWqXWt2aF5fc7t0/PhR4Hd1fUw9tQwW48ycjcgPuP3LKibM4tyrjLPl0Lf/doq2S5zENrxtdV1Wt+avvQ2XO+Wvu4HAu68yEJCpDH3YFNMzWNMc/UUaqurvHctPM2+top6tYYznx8nW6Y1I=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2458:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
X-Microsoft-Antispam-PRVS: <HE1PR0201MB2458FFBCC3CFC62F88C1463BBC620@HE1PR0201MB2458.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011)(7699016);SRVR:HE1PR0201MB2458;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2458;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;4:kUY/5a10S1Y+nY44HmGRxrbVVNqeCQy9WJ1Uz8C2+3utSQevbwBY3pJUISuX5Px8WDUasFuZZCWWRqX4AopaGmsViuiehWcE/Bs7UTphrPE/XAlouSQQn3pYBiD5Rzmxh/rSBHzfTycRcrEiI7mugCyYH9Z2ipGZaE1SbIGWgkaxLhBj8cNShj7ZNRfCKSs5NSqUOes5MjVBMRM9yadmFQFTLtUAvzQZnFa6DhzkQZkMyqCbWZnRKgwqvYU+P3k0OARlEPT3PtQLOJkhbMBVT77B5gA6Yb/ZghrUiMnx8x3mT1aO0lZPj88epjGtWluz
X-Forefront-PRVS: 0690E5FF22
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(396003)(376002)(366004)(346002)(39380400002)(199004)(189003)(65956001)(486006)(2616005)(50466002)(6666003)(3260700006)(58126008)(74482002)(77096007)(31696002)(86362001)(6916009)(16576012)(106356001)(36916002)(97736004)(26005)(23676004)(66066001)(31686004)(25786009)(65826007)(5660300001)(7736002)(3846002)(52146003)(6116002)(47776003)(316002)(956004)(8936002)(8666007)(6246003)(476003)(105586002)(305945005)(65806001)(230700001)(4326008)(229853002)(2486003)(81156014)(16526019)(64126003)(6486002)(36756003)(54906003)(186003)(68736007)(53936002)(478600001)(2906002)(8676002)(81166006)(117156002)(52116002)(386003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2458;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDFNQjI0NTg7MjM6TUFyMkJ3THBCdVhBTjRvZHpLeWRoMkpp?=
 =?utf-8?B?QnRma1JWTERnNzUwTlI5dG9kK2hMYm9RSmphMURwOGJxVFVMd0JKTkxvbVRH?=
 =?utf-8?B?Y2pYN3ppVVlFb1ljbFhLdnVsWWhZUmd1eng2MkVUOUt5Vm9WVm0vbmpvMnJ4?=
 =?utf-8?B?cTlEa2R3Y2JzK2M0bWtjSXhjVWdkdDEzYVZOZ3RDZVBmWjhYODRIMktTMEdu?=
 =?utf-8?B?VVFJd3lwdE9ROUw5dFRmV0RhTjlma21XVUx6dlZyUDVvZy9XOWF3NGlwOWFw?=
 =?utf-8?B?ak9neDY5RU9JWkNDbHZpZVlvaTNXQWIwalJkNDYyRlFOUkR6SWJ0SWkvck44?=
 =?utf-8?B?Wit5K0hhTTMrc09jV2k5NG91ME92S244UjNpY0ZLS2tFY05XNWZuNWl4SVpu?=
 =?utf-8?B?d0JIRWhkdlZHUFhtWjE3aVdacGphS0R5Q0UySFA5Qmw2ZWpBaXRyQkhPbUdo?=
 =?utf-8?B?Tml1eWVwZzY5UGxMNXlXdTJQaXZzSEtMUHZwRXZmN1Vva0R3dFRvQVZ5Tmg0?=
 =?utf-8?B?aHNvUzZONHQzRE10REg0UVFtNUFnWmRmRUpORzFhcUhyTjh6c0thZjVFUEFR?=
 =?utf-8?B?aHdTd1Y3VEd6SmI2VE9yT0lwZFlvWmJ0Yzh6bkhvZkNuU00vejVaRXh6Qmha?=
 =?utf-8?B?ZlFNRjIzSGs4Y2l4L0E1Nzd4TE1YRjdpTVNoc0tHT3ArUGpqb0xYa2tqTU5O?=
 =?utf-8?B?RFcwVHVkakgyNTZGbjVXNUlkL01JWDlPNElTY1JkMlZDckt1VkhZc1VMZThY?=
 =?utf-8?B?OXhiRmRnTmN0QWFIQ2xvZ09UOUs2Ujlmelg3YnM2cENCaG5pbUc5NlEwTzdX?=
 =?utf-8?B?K0lQNW93UDE3eklsOFRmSkZmTGdJRTM2ejRnaXR1QkRKV28vTDlvYWlDNjU1?=
 =?utf-8?B?RDU2UnZsbWdBZGhXeGQrUExQSU1qOTdJVFA0MmNHQUxMaW1XRXRaUHpKeVUw?=
 =?utf-8?B?amlIQk4yU0ZQWENSN29QdEkvNCtYZ05tbDhnWjJOM3lscWxhTGF6UjNENi9j?=
 =?utf-8?B?ZzlBamZvdWZkR0xXeFZ4L2tGR0FaT1k5YnlWNGMxblJYdnFJOGlaM2ZMRzI0?=
 =?utf-8?B?NSthUmorU3pDR1VpREw3Qk5TZ1VpdEdDQ0pxcWsyTThPT3dId1Yvd2hKKzEy?=
 =?utf-8?B?THFUODgrUWNvS2pPNGlZM2R6TldvS1BzRytZZktTVVUzbWlmMGU3RXFiV1JN?=
 =?utf-8?B?OVRGVmh4MGh4MWE5T1pWSk5ncUhCUU5qZjFMZXI5U1NVbWRGNGZmNkI3cFBp?=
 =?utf-8?B?NTIvWGNId1FUL2lGam5KUitLSDlXSWh3eGVtNkU5LzVEdWZFSGY2MStwOEpL?=
 =?utf-8?B?MzYwdlBWZFJLTW1WZXJ4dU0wTzFSLzRQNDV6NVd4cTBhTEM5aVlCVlFtYUhw?=
 =?utf-8?B?MlA0MGx6RjJVRVNtQmx2eGsrek03YWIwY3Jnd3dpMjhIVWc2OHR6UTRhMkJI?=
 =?utf-8?B?UkdkWGgzQmRzVHB5dysrUEQwOHNZWW9uTGUyMEl6RHl3S3dYRmZYbzlKUzJj?=
 =?utf-8?B?eWhIZkFSaTc5aTRVcDhDMlo4ZHhGRXVTdmw3Y0lwaVNhZjRhenZMY0RuYXg4?=
 =?utf-8?B?R3lvYjdxMTY0eVFWdDFXRktMQWpCWkVJUXVpckRDYUhlanZFL1V2bkYwbW8x?=
 =?utf-8?B?ZkI5aFEzcDdSNDJod0tvZ1dQTmgzR2lFRHlCbk1BU3NLakFLaWx5TEE4YWV1?=
 =?utf-8?B?VGVGKzhiSjlTWE5UWXd6cmhSZFBoUFJHaHl5V2xRK25DSU9MaGJROXhDSWY3?=
 =?utf-8?B?dUNnSGhoK2NzblF5L0pDcm5pWnhOdzQ5UlVJbG1OSmNFb3drMzQveTZDUWxP?=
 =?utf-8?B?QVMrTS91ejZyOVo3VEFzekFWUFd4a2JScUlRT0FtWTlZZ0xMOXNNMEJlZzdJ?=
 =?utf-8?B?SnU1ZkZhYzBUZ2cxOU5jSEpLM1dGTkdoelczbDdSMUZscnAwRm04S3ROQXNm?=
 =?utf-8?B?akp4Z3FIOUl1ZENWN2JweGxuUjdDRzFUUysxTHl4dmdhc0N2UVo2L2N3TU1V?=
 =?utf-8?B?V3BmSkdCK05PN1NtM1ZrWDFiazQxT2VIcytJT2VBPT0=?=
X-Microsoft-Antispam-Message-Info: YiqjsEx7yMhZg/DLVtHGVAT68G9mBS5E3dcVOd5EHzRmXmA/1h2Uq3lZ5EXihr6ofJiVTd1ArHWQNmiHgwFhAQIe23KxFQjvK0TBJhXkUIO0RCJKlqMMO0Bb0LsTVB6A6fXZGahZVqbTLoaQADymg07NOD645M2ZFnCPcoWxLN9T3ed/ORGFpb7RY/XKQunS
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;6:kWDlpwJCV1TwUkzXuOgJGrxlDFoEzi1R3BwBArRqRBIENNPKU3blg9FPeZWlBa2BQbF4R+McCMTBfNjq39sfKC5ITo8KJ2LiHpLf/2VKb8SoambdRfceK+fi3PAYZ6Od/NnFw5Iuxw1O0Qga6xCImOD7nTEhwKq+48T7hRres9jXxC62ZZ7A6k2ZhFa6CBa/ES3f7unuOTZMJHEJnS2SNjimoZ5QkGMuw33iQ5zfNhw+VpEGP60uswxTF8n3e+z2kWFH09lA0PdmUJKrBhCsqYrtBoqYNjijnh2IZG2uzywfiYKfn8if6ELlL0+OJSnWvV8eONabGV3pflr9HxiFBJKulapQNjsYy1NN6Kf6x9U3DTI+DqNEffl+3+qjTfHUsUmjh0G4GgYkvSbIauz9MKPqDdQ3oaUJ+kybUD2/y5D09JUQw+7azNmFG+x4REdFquyeXLxcggpELDVDFyzzhg==;5:EUUDr+wmKYUQzvR6r36EtfpldzFNzEB/B0k/iiG7tCb0mOtZGKfU2GnrJA9wSIwlOAl4w1kd6T5RoslFT24A0UQqomay7oFtT5ForeaIr/Z+4fvhR0/aPeV/LgrHyW7+mTrAaH6GUzMW/Pbn1tWeyI1/hXyv+bwHCniB/uahkO4=;24:eKHi+1gwoy1fJdDF5A8bA4qBWiG+rgxbrHJH80fknyZw7MO9dNbaDh4gTpe/KESwvamhCDrTwCvjsI2IrbnzlbsTfMZBgkGIsWPIqnHUEaY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;7:cYghmQ84JpHdlK/LS0zz+IVZVkI0UAXnekSwEpv4Z/jcNJ12leaW/a54UyBCoOO+X3Pro1q5gtf8Y6Kt/lk7arQPJ0+dblldd/gUucfTn9E1oK4DbKDXcQtC5tK4/ahmnLFqFTOEdIda+8okLs4PG6FNo1BJaSXc8Jxjmf/sqQBBRjzpE4IsDYj/Dc3iCy+WTazcvJ90vdKznL6IbNK193QQI8SSaWbBSYYCJuFOL54qmxykmliR8WLCiaRVRjCb
X-MS-Office365-Filtering-Correlation-Id: b8c3bcb4-3520-462b-8e50-08d5c7c6b5b0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2018 13:51:00.5835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c3bcb4-3520-462b-8e50-08d5c7c6b5b0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2458
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook wrote:
> This is a stab at providing three new helpers for allocation size
> calculation:
> 
> struct_size(), array_size(), and array3_size().
> 
> These are implemented on top of Rasmus's overflow checking functions. The
> existing allocators are adjusted to use the more efficient overflow
> checks as well.
> 
> While the tree-wide conversions continue to be largely unchanged,
> I've updated their commit logs a bit with some more details on
> rationale and options. Notably, while there are NO plans to replace
> kmalloc_array() and kcalloc() with kmalloc(array_size(...),...) and
> kzalloc(array_size(...),...), the treewide conversions only add the
> new helpers, as making the ..._array() and ...calloc() conversions
> balloons the Coccinelle script terribly (I haven't found a way to
> make the replacement function name depend on the matched regular expression).
> So, while nothing does:
>     kmalloc_array(a, b, ...) -> kmalloc(array_size(a, b), ...)
> the treewide changes DO perform changes like this:
>     kmalloc(a * b, ...) -> kmalloc(array_size(a, b), ...)
> 
> It should also be noted that the treewide changes overlap with a few
> recently reported "real" overflows, so these aren't theoretical fixes.
> 
> At the very least, I'd like to get the helpers and self-test landed in
> the v4.18 merge window (coming right up!) since those are relatively
> self-contained. If the treewide changes need adjustment we've got,
> in theory, through the end of -rc2 to land those.

In some places you make an effort to have the count as the first
argument, e.g. in "treewide: Use array_size() for kmalloc()-family"

-	kbuf = kmalloc(sizeof(*kbuf) * maxevents, GFP_KERNEL);
+	kbuf = kmalloc(array_size(maxevents, sizeof(*kbuf)), GFP_KERNEL);

which is reordered, and from the same patch

-	mapping->bitmaps = kzalloc(extensions * sizeof(unsigned long *),
-				GFP_KERNEL);
+	mapping->bitmaps = kzalloc(array_size(extensions, sizeof(unsigned long *)),
+				   GFP_KERNEL);

which is not reordered. That is all fine by me.

But then, in "treewide: Use array_size() for devm_*alloc()-like, leftovers"
this reordering thing is not happening, e.g.

 	values = devm_kzalloc(&pdev->dev,
-			      sizeof(*mux->data.values) * mux->data.n_values,
+			      array_size(sizeof(*mux->data.values), mux->data.n_values),
 			      GFP_KERNEL);

Also, the above shows two of numerous examples of the tools breaking the
80 column "rule", even though the surrounding code makes decent effort to
uphold it.

I can see why these things happen, but they are annoying.

Cheers,
Peter
