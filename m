Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbeEDNfg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:35:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:60936 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750820AbeEDNff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:35:35 -0400
Date: Fri, 4 May 2018 15:35:33 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Huaisheng Ye <yehs1@lenovo.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, vbabka@suse.cz,
        mgorman@techsingularity.net, pasha.tatashin@oracle.com,
        alexander.levin@verizon.com, hannes@cmpxchg.org,
        penguin-kernel@I-love.SAKURA.ne.jp, colyli@suse.de, chengnt@lenovo.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] include/linux/gfp.h: use unsigned int in gfp_zone
Message-ID: <20180504133533.GR4535@dhcp22.suse.cz>
References: <1525416729-108201-1-git-send-email-yehs1@lenovo.com>
 <1525416729-108201-3-git-send-email-yehs1@lenovo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525416729-108201-3-git-send-email-yehs1@lenovo.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-05-18 14:52:08, Huaisheng Ye wrote:
> Suggest using unsigned int instead of int for bit within gfp_zone.
> 
> Within function gfp_zone, the value of local variable bit comes from
> formal parameter flags, which's type is gfp_t. Local variable bit
> indicates the number of bits in the right shift for GFP_ZONE_TABLE
> with GFP_ZONES_SHIFT. So, variable bit shall always be unsigned
> integer, it doesn't make sense that forcing it to be a signed integer.
> 
> Current GFP_ZONEMASK is just valid as low four bits, the largest
> value of bit shall be less or equal 0x0F. But in the future, as the
> mask expands to higher bits, there will be a risk of confusion.

I am highly skeptical we will ever grow the number of zones enough
that signed vs. unsigned would matter. So I guess this all boils down to
aesthetic. I do not care either way. The generated code seems the be the
same.

> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
> ---
>  include/linux/gfp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 1a4582b..21551fc 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -401,7 +401,7 @@ static inline bool gfpflags_allow_blocking(const gfp_t gfp_flags)
>  static inline enum zone_type gfp_zone(gfp_t flags)
>  {
>  	enum zone_type z;
> -	int bit = (__force int) (flags & GFP_ZONEMASK);
> +	unsigned int bit = (__force unsigned int) (flags & GFP_ZONEMASK);
>  
>  	z = (GFP_ZONE_TABLE >> (bit * GFP_ZONES_SHIFT)) &
>  					 ((1 << GFP_ZONES_SHIFT) - 1);
> -- 
> 1.8.3.1
> 

-- 
Michal Hocko
SUSE Labs
