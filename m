Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752553AbeC0PCL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 11:02:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55337 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752001AbeC0PCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 11:02:08 -0400
Date: Tue, 27 Mar 2018 08:02:52 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        okaya@codeaurora.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] docs/memory-barriers.txt: Fix broken DMA vs MMIO
 ordering example
Reply-To: paulmck@linux.vnet.ibm.com
References: <1522156287-15169-1-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522156287-15169-1-git-send-email-will.deacon@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18032715-0008-0000-0000-000002EBA2DE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008753; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01009189; UDB=6.00514075; IPR=6.00788471;
 MB=3.00020270; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-27 15:02:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032715-0009-0000-0000-000038B2368E
Message-Id: <20180327150252.GN3675@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803270152
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 02:11:27PM +0100, Will Deacon wrote:
> The section of memory-barriers.txt that describes the dma_Xmb() barriers
> has an incorrect example claiming that a wmb() is required after writing
> to coherent memory in order for those writes to be visible to a device
> before a subsequent MMIO access using writel() can reach the device.
> 
> In fact, this ordering guarantee is provided (at significant cost on some
> architectures such as arm and power) by writel, so the wmb() is not
> necessary. writel_relaxed exists for cases where this ordering is not
> required.
> 
> Fix the example and update the text to make this clearer.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Reported-by: Sinan Kaya <okaya@codeaurora.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Good catch, queued on my lkmm branch, thank you!

							Thanx, Paul

> ---
>  Documentation/memory-barriers.txt | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index a863009849a3..3247547d1c36 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -1909,9 +1909,6 @@ There are some more advanced barrier functions:
>  		/* assign ownership */
>  		desc->status = DEVICE_OWN;
> 
> -		/* force memory to sync before notifying device via MMIO */
> -		wmb();
> -
>  		/* notify device of new descriptors */
>  		writel(DESC_NOTIFY, doorbell);
>  	}
> @@ -1919,11 +1916,15 @@ There are some more advanced barrier functions:
>       The dma_rmb() allows us guarantee the device has released ownership
>       before we read the data from the descriptor, and the dma_wmb() allows
>       us to guarantee the data is written to the descriptor before the device
> -     can see it now has ownership.  The wmb() is needed to guarantee that the
> -     cache coherent memory writes have completed before attempting a write to
> -     the cache incoherent MMIO region.
> -
> -     See Documentation/DMA-API.txt for more information on consistent memory.
> +     can see it now has ownership.  Note that, when using writel(), a prior
> +     wmb() is not needed to guarantee that the cache coherent memory writes
> +     have completed before writing to the MMIO region.  The cheaper
> +     writel_relaxed() does not provide this guarantee and must not be used
> +     here.
> +
> +     See the subsection "Kernel I/O barrier effects" for more information on
> +     relaxed I/O accessors and the Documentation/DMA-API.txt file for more
> +     information on consistent memory.
> 
> 
>  MMIO WRITE BARRIER
> -- 
> 2.1.4
> 
