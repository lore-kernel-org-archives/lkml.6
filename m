Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755095AbeDTNnS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:43:18 -0400
Received: from mail-cys01nam02on0048.outbound.protection.outlook.com ([104.47.37.48]:7344
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754940AbeDTNnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:43:16 -0400
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=caviumnetworks.com;
Date: Fri, 20 Apr 2018 16:43:05 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: micro-optimization for __bitmap_complement()
Message-ID: <20180420134305.azmvwwmgi7avga7s@yury-thinkpad>
References: <20180411145914.6011-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411145914.6011-1-ynorov@caviumnetworks.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Originating-IP: [176.59.47.253]
X-ClientProxiedBy: LNXP265CA0027.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::15) To DM5PR07MB2905.namprd07.prod.outlook.com
 (2603:10b6:3:9::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR07MB2905;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2905;3:ZYk++NxfW+8LrHE5NuSYYkIPJW97zHdn2oIB4wBCG/3dtMSc9RYZAPUJU1Thkj8GHaU6i6CumWDV+J1znntDRD0Ec6A8brQdpE8IUvaq/VZ9EPvzcTzyLQQCe/bM5Czr7Vz2ADw1Y6cHyoIedSCZbZKrWWrankXLyF83vRSMimLumEfN/kO86zihz1OVIyZZe2zRlO5GVmqN8fw0GZ2GDOFVxhfZ5WQ9NpWtLg/F5CCSAesRbiTTMB1Ba52mnDEg;25:SEzIQ+m0g/tfKT+RCvh6yeMB9EI/C8gUk2D5aDh7EK1NX2U1lh+Fw106BfKBvug6hP3fIdFbCm18khvFUZgZndwCWJGs7rSeRCxhOTBiWBPlmELC4anE0XVPtlhlIvyebPvOr6lTGDSZSHFS24EijUNGU/1nUzduCg2iKxMAamiuLRvf4PuKKqyXDjukLpEhmdzAx1/6DxEsKIEjeKqMMvKD4OlYLhX4qYwjvsfycP5Duld0tGY39JI/pzF3X4T4+/Hwo9AbnBeA10+TemzvCjgmoHG818yliPEKZHClYJe8LhK6CeaG3sZUhxNS0LjYWB3rCqd9Tpx+7ZZ8rrrPRA==;31:4zg6dut4WWYaTAfDgrtYv2L6jtp94ShyHFRjy9Iobyuy212i7oPTMmrkxUb/b9/jLOYaOFjaT/Vgs+WL7MQM2R3oT8zUT/kpxLxeEHARLERJiZE2Te532GLAtqY3ubNkhl6YMkNdeVwt+QaO3tPHbgJoGIzM8d6dHekXuDUR4CdLIxMFK0RtBzDxiNMqSG3RGWJabsJXi+iFKp1jJWOatqhl+kgtQEdJYFgaEk+f7H0=
X-MS-TrafficTypeDiagnostic: DM5PR07MB2905:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2905;20:jb9MDcAjA0cbEW4QrDkmJ5Jt2REiTKah5wjAw14MuT6CTlqJSRX7N3aai+hNuZbVyj9+YUBGJ56/WPdb9RB4gReyXVrt96bq7JX/qEwy+vOBZwSnXgHPY0hcWFZjccYlY8OhYcgDbvLAHv8Kdure8ZZ0tw3BFRq2eX3u4GM1STa8K4mWkWqM3GoJOfSZa9T9s4ygo+4956HzboNzrG4I4Z866H4FbNSrhRiYWocUuY7xEufpqrHqvfBGLacB7s4kB4jguvJRy8bxNS0C/IORwdJfxzkduUn9hOM6JYW6ZYUPOkGPhkyk55Kr2mh9aXaa+INhC11TzfX8RiFx0fWmfuvRu6VNvBG7C7HBO/P4kEummVrr7gVXihPXYUZAP1w6QOTY6QmpyMTpfG2TWFfrae0vQWWZCJTfxd23CTmElnlHxjXapPpQrgFq3mY5j6shTJ1HypnOAjyBgS0Y9oZleGo1ws/B6QIhpTIQVuyWp6Dv/M8IsqgxFhPhxbPOME1cPyvCaGrvhEAJWoPTOCuXwqCkSTwGdNhh0DGT3IPsi7IzzkzBIfby5OJTEqdutPf1PcPjfxPXobbSLve5Dq/o7aCHPgKv93wnAX9+wie48VQ=;4:dxPLfl5SAghq+n/x/IysfktFmfbxAz14AdZSO/J9gfH5RrPo15EptQv9K3NN+OxZp0onT+8EuVdwKRpBWWDqQPX9kQ1qQinRB/sA1ubgDvDAQ46IZgxNXhQDfQJ7pvjDIa0qdv1kPpn3gNjw6C9SwrDX4J8Aw8k8J2xV9GHAIQk3xGgYminowpG6k28t/tePC/kDxAYHCPFuDE6HiH8OVmmD+jk7m19RwAvH+NCQjhG/BGeoRW9xowuLvmJa9REyY3r7VMJEajd/mlzPEq60qA==
X-Microsoft-Antispam-PRVS: <DM5PR07MB2905522357EE3327D67CFD85E3B40@DM5PR07MB2905.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501327)(52105095)(93006095)(10201501046)(3002001)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR07MB2905;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB2905;
X-Forefront-PRVS: 0648FCFFA8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(366004)(346002)(39860400002)(376002)(39380400002)(42882007)(3846002)(2906002)(476003)(229853002)(72206003)(8676002)(47776003)(50466002)(8936002)(81166006)(66066001)(26005)(1076002)(8666007)(305945005)(6246003)(9686003)(1511001)(16526019)(478600001)(53936002)(110136005)(11346002)(5660300001)(956004)(446003)(23726003)(76506005)(6486002)(7736002)(6116002)(33716001)(16586007)(186003)(6666003)(316002)(25786009)(59450400001)(6496006)(52116002)(76176011)(386003)(33896004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB2905;H:localhost;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB2905;23:ssuHZamx0KxnEoCY8XGS5cmICiBaqDjB8+9MFKPFM?=
 =?us-ascii?Q?tuAGoJaTd+Wr7IvcYqRWbWlMTxNcfjesx2MqODlJcBmfkjMUOaciQBqMH85f?=
 =?us-ascii?Q?UYkkOk8fJw/0rvk588ucjVvOp2AG4TRfn42Vgssfr39BgycN11AcWz6g0pli?=
 =?us-ascii?Q?tTgOEI0Ww6DyKwPQ/pZR2qr7PWJql2+yn+38RNBH7NDlBvnw/OkZadCgpvMm?=
 =?us-ascii?Q?Gdr6S1ohOB9Unlb/M0Reu35IyjG/mES6lbEzTNjTDMDSuFp+VD/3RH/U9Dtj?=
 =?us-ascii?Q?2MZWCxyggWlcAQM9gSB7VBgaSBWIX8n4RwRrjuMrYWLd8BRp21M6kTVQLLo/?=
 =?us-ascii?Q?YIK7II1RwiSqN3rVtVKdcMo62MYaTIVg2g5xlPMaqK6oHsGUB60GtSGWSYWG?=
 =?us-ascii?Q?uCApxF2MEIccMMGJhcMaHJcEci8glk0YGXpr6ARplfym9j0j0Auksd4pw9EL?=
 =?us-ascii?Q?zhgmMHD7U5YKY6+8F38FxdKFh+SLKJAMf5hzi8TEBK/Fe/ZyBDyixApxexSI?=
 =?us-ascii?Q?eXvlmVYU6RASWMy58mqbb918o7W7oIR8vfZ0FgwMbCeEZvUvOgXwXRinaKWY?=
 =?us-ascii?Q?255e2iymevYD56FxYhTkBkIEaMNsTHSr9jRl5mwgkC7dBYaeU02X0tSOQkkI?=
 =?us-ascii?Q?ksdkNzvlgZa4yQomnWBqnup/gzjK2eDCstWxhCNFzxt02tTv4YfCMGB29Nm4?=
 =?us-ascii?Q?r1t563HVKo+s1mTbiAXPCmxL1FAkdzdpZT+aSAt5mbshVSP2yLTXscGz4PZ4?=
 =?us-ascii?Q?2uVuqBIbaUo8pZ13PrGCSMkuIKWx8cc9OzuPCYQyTNBhLiFNZNSjnzI9QCRp?=
 =?us-ascii?Q?aNF0n83I7+ZwJM5+fWiH+Y80XbrDGvOevSsdci+rME4ge6cPVj9T1CWY2Jjc?=
 =?us-ascii?Q?DWxrxBEGa4GpJtYdvp/BZBnJsxnWZZhhWKVoplxtysPISUov3tlayLUYV0Ek?=
 =?us-ascii?Q?lgR+XlWORIlIchwVIAJfstNShNR3lvmJxQ6aGniXekNBeCVMquMej32Yqj7O?=
 =?us-ascii?Q?5zIzs+0k6JFiP0YqAk4liGWjG005JcJffxajpMAiqWLy+XGCcyPYABApUm88?=
 =?us-ascii?Q?rhqBqxPLDA8+gHEmhO44E2e4UDS6V2OprOinng4B+zp53mdI0tHOQ+oI17Qt?=
 =?us-ascii?Q?6nUe/4QylsRDfseppY1nxig6INi3AXk?=
X-Microsoft-Antispam-Message-Info: YkyZaI7zcAMQzmRgEZHY3ZWcfIv0u9LR7WyQb9wuvlXOucc8RujzH1zlBwn63umWQj+X6haVNWPRnxsZB+AEzB28Y/ld3fSTFtU2AknG23IKAfGYiJBbAEWNTJGcsukKDUhFL6sJLrKVTARRqOw9XFq6AoDPuc9izc8DjzPjw5McTSq3zgJ2k1xQXHOIHhJW
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2905;6:HHf6SSo5lssPldOOBEUxPrC2f64LS82jL1eeYyuIqA4d03fcgbIubd0g2HhpV9DjnIpXwGK5BzkxFWLH7+zUUy5jXXevKUHvLUc50x3T+8cCqmgsx6mWe6y/7LUj8vrDW4FUbH6hP0u0h63mEMuYSKCDi5O9Wz2tSBFTbIjkczE3i5v2sXyBH0hCz/WB9iDDQlBwgBK1XF7kfW5Uhz0f0VwnuXIqDN6FplxrMEpe6XEOlxIzt2IVUP9pLmrJJFYlsV+wXUZ6jJ3/vXv1e5Pgd6DgVZTjl9iG8+k+x4jnMjDRGxeFNrETqYpPFk1rsM4f/rcC+AfxXJYG5XHLQC66HNBWu3TyywI4xFotaoVipA+snso9pFHHs5s5ADj3zy8z7hgURDMds5FiQcBqW+DNicg1klneifs829twf1vPcMm24v0Lh5kmHpf11bUKRHu9jeq9z7utUB1MbcEajSJ6xA==;5:WYQKMrlvRgJQFfJNxFCNZq+AbCiPJK6V+o07oZckOlYbqSac8Az9/rAvLsnoSHsLfD2jDE+iHnBW2DeBCVrx9R0guCuDIJWqfA+K2UGJOhP+9VnqblJUAkvsiB0ugfh+EWgij/jIKfqICP0kI57muIjC9KPhfLMsR+NNyWb160o=;24:fn2gosU1A+19CtZEcLjccDCXtsQJ4yyvRW6EQN9Koj4Bx4BF8cMYYHsQjr8uNswT63HwGTcg3+3NadRkHIF3N2FY542NcnyuKAnZ7NUGgek=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB2905;7:Cm81aLN+5Ep+zhIvyyMrZ6TwEQBT02PI418pK+HRQz+LXzBvdc1EbzN6zHxLcNmr2p5rNT0Uv6s9HjJ7W4GL4pa3lrVYN2qlCu7GRDgJm+cSl6QnSmOgm5PSo0qUyTB5tUfqPPW1Xr0dYsdl1fGqZetGJ6MQS++MdrxQ7SK2baXIEJcqVXVf21UktHgFpahZ0RR81U7Rc6bUqoQT8E2wfLENcqutIDfOTeQLYR+J69aNl7E4BrC9O6AF0ZLkmIsm
X-MS-Office365-Filtering-Correlation-Id: b21ffa16-fa22-4bbe-157a-08d5a6c4aab2
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 13:43:14.5235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b21ffa16-fa22-4bbe-157a-08d5a6c4aab2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB2905
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

On Wed, Apr 11, 2018 at 05:59:14PM +0300, Yury Norov wrote:
> Use BITS_TO_LONGS() macro to avoid calculation of reminder
> (bits % BITS_PER_LONG) On ARM64 it saves 5 instruction for function -
> 16 before and 11 after.
> 
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ---
>  lib/bitmap.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index c82c61b66e16..7adc10074cff 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -62,12 +62,9 @@ EXPORT_SYMBOL(__bitmap_equal);
>  
>  void __bitmap_complement(unsigned long *dst, const unsigned long *src, unsigned int bits)
>  {
> -	unsigned int k, lim = bits/BITS_PER_LONG;
> +	unsigned int k, lim = BITS_TO_LONGS(bits);
>  	for (k = 0; k < lim; ++k)
>  		dst[k] = ~src[k];
> -
> -	if (bits % BITS_PER_LONG)
> -		dst[k] = ~src[k];
>  }
>  EXPORT_SYMBOL(__bitmap_complement);
>  
> -- 
> 2.14.1
