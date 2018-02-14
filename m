Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966270AbeBNAiE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 19:38:04 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56842 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966207AbeBNAiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 19:38:02 -0500
Subject: Re: [patch 1/2] mm, page_alloc: extend kernelcore and movablecore for
 percent
To: David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
References: <alpine.DEB.2.10.1802121622470.179479@chino.kir.corp.google.com>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <a064d937-5746-3e14-bb63-5ff9d845a428@oracle.com>
Date: Tue, 13 Feb 2018 16:37:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1802121622470.179479@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8804 signatures=668670
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802140004
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2018 04:24 PM, David Rientjes wrote:
> Both kernelcore= and movablecore= can be used to define the amount of
> ZONE_NORMAL and ZONE_MOVABLE on a system, respectively.  This requires
> the system memory capacity to be known when specifying the command line,
> however.
> 
> This introduces the ability to define both kernelcore= and movablecore=
> as a percentage of total system memory.  This is convenient for systems
> software that wants to define the amount of ZONE_MOVABLE, for example, as
> a proportion of a system's memory rather than a hardcoded byte value.
> 
> To define the percentage, the final character of the parameter should be
> a '%'.
> 
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 44 ++++++++++++-------------
>  mm/page_alloc.c                                 | 43 +++++++++++++++++++-----
>  2 files changed, 57 insertions(+), 30 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1825,30 +1825,30 @@
>  	keepinitrd	[HW,ARM]
>  
>  	kernelcore=	[KNL,X86,IA-64,PPC]
> -			Format: nn[KMGTPE] | "mirror"
> -			This parameter
> -			specifies the amount of memory usable by the kernel
> -			for non-movable allocations.  The requested amount is
> -			spread evenly throughout all nodes in the system. The
> -			remaining memory in each node is used for Movable
> -			pages. In the event, a node is too small to have both
> -			kernelcore and Movable pages, kernelcore pages will
> -			take priority and other nodes will have a larger number
> -			of Movable pages.  The Movable zone is used for the
> -			allocation of pages that may be reclaimed or moved
> -			by the page migration subsystem.  This means that
> -			HugeTLB pages may not be allocated from this zone.
> -			Note that allocations like PTEs-from-HighMem still
> -			use the HighMem zone if it exists, and the Normal
> -			zone if it does not.
> -
> -			Instead of specifying the amount of memory (nn[KMGTPE]),
> -			you can specify "mirror" option. In case "mirror"
> +			Format: nn[KMGTPE] | nn% | "mirror"
> +			This parameter specifies the amount of memory usable by
> +			the kernel for non-movable allocations.  The requested
> +			amount is spread evenly throughout all nodes in the
> +			system as ZONE_NORMAL.  The remaining memory is used for
> +			movable memory in its own zone, ZONE_MOVABLE.  In the
> +			event, a node is too small to have both ZONE_NORMAL and
> +			ZONE_MOVABLE, kernelcore memory will take priority and
> +			other nodes will have a larger ZONE_MOVABLE.
> +
> +			ZONE_MOVABLE is used for the allocation of pages that
> +			may be reclaimed or moved by the page migration
> +			subsystem.  This means that HugeTLB pages may not be
> +			allocated from this zone.  Note that allocations like
> +			PTEs-from-HighMem still use the HighMem zone if it
> +			exists, and the Normal zone if it does not.

I know you are just updating the documentation for the new ability to
specify a percentage.  However, while looking at this I noticed that
the existing description is out of date.  HugeTLB pages CAN be treated
as movable and allocated from ZONE_MOVABLE.

If you have to respin, could you drop that line while making this change?

> +
> +			It is possible to specify the exact amount of memory in
> +			the form of "nn[KMGTPE]", a percentage of total system
> +			memory in the form of "nn%", or "mirror".  If "mirror"
>  			option is specified, mirrored (reliable) memory is used
>  			for non-movable allocations and remaining memory is used
> -			for Movable pages. nn[KMGTPE] and "mirror" are exclusive,
> -			so you can NOT specify nn[KMGTPE] and "mirror" at the same
> -			time.
> +			for Movable pages.  "nn[KMGTPE]", "nn%", and "mirror"
> +			are exclusive, so you cannot specify multiple forms.
>  
>  	kgdbdbgp=	[KGDB,HW] kgdb over EHCI usb debug port.
>  			Format: <Controller#>[,poll interval]

Don't you need to make the same type percentage changes for 'movablecore='?

-- 
Mike Kravetz
