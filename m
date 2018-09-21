Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7804FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E9321531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="JSKOeKvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E9321531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389486AbeIUPZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:25:01 -0400
Received: from mail-eopbgr10139.outbound.protection.outlook.com ([40.107.1.139]:45270
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388944AbeIUPZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5E1ZF3LDTzO8MRqZdR807CajiI2Xpc8Ji7ncysXl8Vc=;
 b=JSKOeKvvVu8nMPThptowsnBGFGRa4UPaAXDg6DqS7IRSRkw8w/GqJQM0nVRo+CIOvm9antgVNhse9kQRlN5qVvRMwcd6DHtrGgO7AsCkBU7UD1RPtx/CQoaq8ZNTIxr7mQiIXxgq3KxNLDpGBLg5lgJxR7oqNbNLgjC3l3ffCok=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com; 
Received: from [172.16.25.12] (185.231.240.5) by
 DB7PR08MB3259.eurprd08.prod.outlook.com (2603:10a6:5:1f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Fri, 21 Sep 2018 09:36:54 +0000
Subject: Re: [PATCH] kernel/kcov: Replace vm_insert_page with vmf_insert_page
To:     Souptick Joarder <jrdr.linux@gmail.com>, willy@infradead.org,
        akpm@linux-foundation.org, mark.rutland@arm.com,
        dvyukov@google.com, tglx@linutronix.de, gregkh@linuxfoundation.org,
        tchibo@google.com
Cc:     linux-kernel@vger.kernel.org
References: <20180920191254.GA22764@jordon-HP-15-Notebook-PC>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <6fa7d32b-07f0-ab6d-8053-021b171153e6@virtuozzo.com>
Date:   Fri, 21 Sep 2018 12:37:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180920191254.GA22764@jordon-HP-15-Notebook-PC>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: HE1PR02CA0104.eurprd02.prod.outlook.com
 (2603:10a6:7:29::33) To DB7PR08MB3259.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83c71d33-924d-40b2-1313-08d61fa5c548
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3259;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3259;3:vb+zZGnxg/PqUtJteieH5NeKV6oOnwo0waEzGzH43QJ2GZpUnll0h9nRCN51IBsb4vjtQWcSu0w6rrNGIxk/pLdlTzfbexEtZLcGOgfN6a3+8dmiaRshIInniHWzrBQErlGuK+7a3gnn18EfmRVz+i27CSm2b6H8eCl33DH3oiqHw9ZDb1ZOE0j35pna8thdP0cG+xTGPui6jBuI01n6KUl6TDKGrIOQ60Cc8wf6dwe4vD6Fg7Z7KtQpmKtQCr2n;25:WoRXLWCGuKNRLVeQwUfGz5OiTcvjIRh3wXmYMtfGX76xl7eSa1k6nZfDxfKCsDvBO3sfxy3Xe2QVo1l7irpylieEsu75NDVuF4q9Rn5x6MPA7e31CCxv50E/WK5li6XvLeYgpQt7Tqe0Al60x517K5lVoL827XjQTUKeXL8uRHPOto45CdfQKDM+LiO89UektXmhlqPHVWDkYSYcKyMldDMHmbwjHOXkzLPU4BKtzBhyXkaOhowANpDjUOzYylmRlfPOKX6bkqhU29+0fOR2A1gmVfPbtx0AnRKbL683b5zhhqMuTFcQS+OWVZxysmQ8rYW8d84NBUePFEDYfaeiwA==;31:d/0FEhijgK7PN7+r2P4PPxG/JUJ0k3kdfMpMfYsDINzrsXOnWQY4ODARmi0L8HTcLGamkJx4S2YX1R6/2rw3WiClBCIqfB64dxobnOoKVxv73gtRitGoplwb4tKkZD6m5044Y+4OSLvnmkviNzKGMNhwhAKstvE7UIEOHt6c47E7qDdhW1ZihRNvyG8HIsTEhg3fcVkt6zHaMNeumY5t4hpl+g52zGLUG3cmuobmzZs=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3259:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3259;20:CFORs0450nAlYyP9W1irFDhf4juO+DEfSiiq7nXF1AS9oXPKsBB7ShZ6KFvXanH4fbwSq8v/H4wo48yZCclfdnE5bzopYhkFkPFV2xzejBH56x9EVhj6+uY7JEWLYZkG+tZbd9gIPYZNpznXa9HiovRNM9tnfbfIsOZbSp+X7kHlw6DpGR06X5xLgEIxUfNGe1wCJv3xk5pyK61dlTZ2BkkECYZ9AzOFNhPYCIsnpUEEC2b71W4AxGHRtNtC846nZtsRQ0q4EwasSZsBLyScSOZ6MTRS/Hp1LWZQ9D9Qq7nisRK45r9g90QYBmLTAtexz+AMT3K24CDGYZg3TxGLvmDUQnCK5oDI9IuHdRjy7uss21SNPd5HEqxmaru+kmgovvwCpPjej7tywuW/BPPqm+Y0GUFcFVqTi8ZUdIkHJNKu+Q2nbg4J8bSYS3YJ5horH2BoH6geH/Gi0ZeJ1E7k+4gGMHMIricy04aYHSI7D0ZKESXs2+orEt6ZL9SRM5NO;4:7x1B3VkZDeVpUKQ8p+NodreXrC4q960DFZ7cERRaOwLcokZNqc8Qmh4tIqXLXJ+Zo9H/DioQCjZGt4eTW8mdAJa3QPvwzJerG2GKdI5U3ICNfE+UavzW4F6nekDDVQSBjfEVndK1RFoxkThUijWQmpIZOvjpOrjgJdYa1nZc0h6U6KGNS5gECB0OqWopJtgVd17UDlPsU3gSg1eWcEtzxDMxzmw5ZyOO0tKlel1hmUCu+mLgR7MsEfqt91pckJEtP40g24vBXIVHbtMgM60IVz+TYjOXn14gS1n2H4VhKb/f9PRhWaBHwkxNkdT0gmVn4brQbLHFwxX1W36D/ggScw==
X-Microsoft-Antispam-PRVS: <DB7PR08MB3259AC60C53E3B7232A6FAFBB0120@DB7PR08MB3259.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:DB7PR08MB3259;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3259;
X-Forefront-PRVS: 0802ADD973
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(39850400004)(376002)(366004)(396003)(136003)(189003)(199004)(6246003)(76176011)(16526019)(81156014)(81166006)(476003)(2906002)(52116002)(2616005)(11346002)(58126008)(956004)(316002)(16576012)(97736004)(4326008)(26005)(39060400002)(6666003)(68736007)(23676004)(6486002)(186003)(486006)(53546011)(8936002)(386003)(446003)(77096007)(8676002)(52146003)(53936002)(478600001)(64126003)(66066001)(7736002)(105586002)(2486003)(50466002)(47776003)(305945005)(86362001)(14444005)(36756003)(31696002)(106356001)(230700001)(65826007)(65806001)(31686004)(229853002)(65956001)(6116002)(3846002)(25786009)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3259;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA4TUIzMjU5OzIzOnI4QXZ5bGVjSTZnYnZESjl4eGsvYjNvSStS?=
 =?utf-8?B?Nk1hQmJLTWdDbW5GcVpQcWQzbUhFQVVUNFVTK1pXMTdGOWlrVG14djB3cUZn?=
 =?utf-8?B?WXhobDgyeVRSeWwyRVhrTjVvVzdOQmI5WjlOQi9CTUpJSFVaT0R2M3djT05v?=
 =?utf-8?B?NUJIMUUyVWxNVE04WW52cmY3Nzd3TXBzdFhRd0dzM0FwSFBRRlJQbHgrUC9h?=
 =?utf-8?B?T3pmY1RFN0FxQ1hmejhzbzRSWnMvblRKSmZFdDFqZktIT0ZhNGI1U1BuMXFY?=
 =?utf-8?B?aTZ0OWRSbmUvMGNYWHRDZzVwNFBRcGdYTlNLVDFORFJTSjBlMktuenlHMC9a?=
 =?utf-8?B?RHdEOGhuTFVsZ1dXUXlmSU9Ub0QrTXI4dG4xZVk5QjZNbksvekVTZm9ranhp?=
 =?utf-8?B?Rmt2TnRCaTVGc3VrNndKTGthWWt3THlJbC9QZWlXcTI1bDhEQnJNQnpKa2RK?=
 =?utf-8?B?VEdBZmpaMWNLZlM3ejFDb1hXY2NqNVpVczMvOXY5R1A1Y2dpREVxY3hKSXpS?=
 =?utf-8?B?aGlZTzFpVmpmNHNJWFVnRVIzaXhTK0VvSWRsQkVzamw4N1BoakJPMGpCdldp?=
 =?utf-8?B?TFJSNG42dFpwaXMrZlFpZ2VPdUxIbU8rbXkrcUlaZ25iOEZKZ2xwci82Y3NK?=
 =?utf-8?B?TFFxVjZjWUFTYlpRdXo1Rk1jcDJ6Vkt4emhsY2h4R3NIOG1xMkZvc3RSdzYx?=
 =?utf-8?B?a3lxdDJ6WUt6M01MdHlMKzZnVC9TbnRLcjhMNTNuUXpvQnkwV3lieDdWL0Qv?=
 =?utf-8?B?MkFBaUNtZk5xZkMwc0pLMFc0bjNROHJvRW1BRmxtSTAwOGFpelZDc1lMci80?=
 =?utf-8?B?K0dWVUFQckpKWTk1YzFKZ1NuU2pCOGNmdDR5QXB6WFZKZlVPd3N5MjU3b2FC?=
 =?utf-8?B?WWtrWVY5anZCbVdIbVlLWElTNzQ5cWQyeENWN0Q1YVF2SVA1OHZzbVVQalln?=
 =?utf-8?B?NGUrUTNkK2hGSklCU3Z1Q1dUcjlpaUR0Q2pHbmpQOFVTMUcwYVErTWZqNkt5?=
 =?utf-8?B?eUVHVnpWS0hGWExMTzVZTVN4b2VBVVFXQittSmRYN29iWndkYW5ZN1pFMHBp?=
 =?utf-8?B?MjdBRElqUnJTakNFNzdRb1A3dElhNlFuN3oxcGhvWkRxc0owV25kRGlUaEd0?=
 =?utf-8?B?TG9RRUxJbnBBODRsemFVSkN3cTNCaDBTNVlad1M2elJDR3NnOHJzbVg3dDVn?=
 =?utf-8?B?Y3FicUw4RW9Uc1U2UEM4Y3BrVXN6bUFWdkFKcmdQVnoxcm02UXg1RnFITHhJ?=
 =?utf-8?B?M2pEbHRheUxRUTVxTUdISlNpYVRNNXhlWUFUYUpEd095aEVWT0xsZCt6L056?=
 =?utf-8?B?TTM3dmxiQnBYemhIRXRoZTlwZndpWWs3ZkxHNzRVdnFiQXVmZW9Tc2dUdHQy?=
 =?utf-8?B?d2k5NmV6dEdjV1dySW9tOFhiWHZKMElicUlQOWt4V0JMUXMxT1F2TElMWTFN?=
 =?utf-8?B?ZTV2TmdIcy93akQ4aTBlbHZtWGwzeXdqTkJFQXhXNzFiNTlNWjVSL0dVUzIr?=
 =?utf-8?B?VHc2bitva3UyV0FIMGVpdHlGZFZWVXdlUkJXOTNHQnZxWFc0L3QrdFpGRklC?=
 =?utf-8?B?Q0REWGF6Sk5OeXZBN0RITWZYSlN5RHlxUUJMMGlNRTNGMTJqdlkwaHBGbUxE?=
 =?utf-8?B?aW56Q1paSktyU1hkQ0lZbXJENkNPcW9iMEM4bEM3Zkg3M0F5QVAzKzR4aytZ?=
 =?utf-8?B?ZkZtVmE2bDJldllCSjF6TXl2aTF3a0Z3QVFHRk5PLzNBUnRMdGRjREFsMHkz?=
 =?utf-8?B?S05Sa3RLWWpSWjhmaVBYL1BhNTE1NHB5TFhXcjdHUjMrdllVdkN4Vk15Qk1M?=
 =?utf-8?B?S08rMEo1eFAwbEJOd29EN21QdEJOSGFVZjNnUmJPUTZVek5iY2o4SjhyeEk4?=
 =?utf-8?B?RmVVbnpsVU1RQVhweWhZLzFZTmdqanpRZVVraFpsMTA5YUVkVWx4aFA0VzRQ?=
 =?utf-8?B?V0NuckpRTW1RPT0=?=
X-Microsoft-Antispam-Message-Info: M6CwfXZGqMMKI4RyeAovfHkJdgmT+eeq9gVxDiowqmqmOLcqSBwOCHQIRv02Qn9wjP+uz6+ChybCC4im3C5bJfz2L1t6WteDAH0NneMPd3tn98fr9enfWk1MWHkltW/T3vnk9QEKbPYoz/NCi6WHVMDqJ/aOVWLu6wlAoVaqFUfdWjWUxJvR4hodU3CL5v1+XxkmRAfHReXHByF2E6Z+goUDHlTxcv0VXfPte/ZjWFXPTyHlZD3s6IKqYmD5u4h/xRcaDY+hT/z2s87GNzCL7JFhLwqL71laJf9hQMwFcLWPO23ldN5cpXug/ERmaxbY35tAlEyTcCa6ULaYpagCjSGCC1coiid6ep5LtXc44tI=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3259;6:ouQFvUnkr0USM1xQJd5LlVH3qOkUJDo3pwmBD3u3ISP5oMpn4v2JlP3jfq/EHo5tZoGbVbQ9bkGdLbdjOTtjgYKFRJcVpp0zi70JoDsUq6HFguZ8AOs6+KFkGHxNVrOT+eETfp7lcl7bV3/cwCUr9Ra5GAFjt2J4eO7Q+Trbg9hoS2/CTRfXatdG+3n9i4c7EcjRA905zHPracBeRlkW0PbGR71QmQMxsynrhUdhMYCss+hdZAKvaCuaq0yGAFLXTCmygXA2Zr9MtSGG8gs3sPoO6iyTqWuD+6NRNi5wq9xsrCagQlAHPR/mz8PEMJUlpL4XMwYlFkRzkWMSSJY1EM+6towyySLv/nJFavdndNAQmxtsgm1tGG39oVKtgMgUmI4PWJdjN7lYNeLWS50FhmRmie10fcHUO5cr/aoUOdCpSDPoo0IFkMicQL3GZJJy5EzS/PdXlefwdmyEqR8SSA==;5:OVXj3sDp5ZBwEEfWgv9b33PAKrtGjd5M0NHYbe1zSx68GJWZyXwHhlZprpAlWhjwMM5dZ2qjQyGM5XWttHQBXyknRw9H2idiF6tJAoF9K0rPp0qRER1+Q8A+cFp+ocZIBOo8/cfIFx0Kc2lsbngwjXHYsfdIWcgiTe236AiP8AQ=;7:QJgOglKEdoNa588TSWUGCdWiPlG8A2Cb4hGeoSLUOddUkMWWE2fx7GITFa1W6nessHbIwspW6JvDGDad8Bd4utWnQ9pqWinLIsErMOg67HmYlemnFeVy3TX21KBZDa4W+0QBztd0T3PRu/lCBbfewdHaPq6X67W85rQwR6LrO1CAdU1i3DqsvikXRO/UQ2lvgkp1VSSjnVUxvbvrCT6NFDEKm8uW9KsAlKjg3Im72o5CfbU721duUJMlU+66vjx/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3259;20:RIi9SZbdBSFMFXcxA+Wy37UklQGp6DE87MnWCzkHUCB7lVf48SLnNW2ZgYV7PrWnt7LMAWKuAlO0NwrbzFMMktYkDFUk45OBBrXPCBkT3E3HkYz3EPNSaPbZDvjqd4pk3g6v33qQL0EnSI5ZmXvHHu0PqJlwQhI+2Zb1iazYxkk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 09:36:54.8746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c71d33-924d-40b2-1313-08d61fa5c548
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3259
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/20/2018 10:12 PM, Souptick Joarder wrote:
> There is a plan to replace vm_insert_page with new API
> vmf_insert_page. As part of it, converting vm_insert_page
> to use vmf_insert_page.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  kernel/kcov.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index 3ebd09e..8900d8e 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -293,8 +293,9 @@ static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
>  		spin_unlock(&kcov->lock);
>  		for (off = 0; off < size; off += PAGE_SIZE) {
>  			page = vmalloc_to_page(kcov->area + off);
> -			if (vm_insert_page(vma, vma->vm_start + off, page))
> -				WARN_ONCE(1, "vm_insert_page() failed");
> +			if (vmf_insert_page(vma, vma->vm_start + off, page)
> +					!= VM_FAULT_NOPAGE)
> +				WARN_ONCE(1, "vmf_insert_page() failed");

Nack, don't see the reason for such change, it only makes code worse.


