Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262A5C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 07:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9EE920821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 07:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9EE920821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbeJaQA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 12:00:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38514 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726097AbeJaQA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 12:00:58 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9V6we1a059088
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 03:04:07 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nf3ykquax-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 03:04:06 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 31 Oct 2018 07:04:03 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 31 Oct 2018 07:03:56 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9V73tt457540644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 Oct 2018 07:03:55 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0993E4C052;
        Wed, 31 Oct 2018 07:03:55 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A4DA4C058;
        Wed, 31 Oct 2018 07:03:52 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.68])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 31 Oct 2018 07:03:52 +0000 (GMT)
Date:   Wed, 31 Oct 2018 09:03:50 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stefan Agner <stefan@agner.ch>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Greg Hackmann <ghackmann@android.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        CHANDAN VN <chandan.vn@samsung.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, linux@armlinux.org.uk,
        green.hu@gmail.com, deanbo422@gmail.com, gxt@pku.edu.cn,
        ard.biesheuvel@linaro.org, linux-snps-arc@lists.infradead.org,
        vgupta@synopsys.com
Subject: Re: [PATCH v2 4/6] arm64: Utilize phys_initrd_start/phys_initrd_size
References: <20181030230721.28429-1-f.fainelli@gmail.com>
 <20181030230721.28429-5-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030230721.28429-5-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18103107-0020-0000-0000-000002DD59D3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18103107-0021-0000-0000-0000212CAC67
Message-Id: <20181031070350.GA12503@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-31_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810310059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 04:07:19PM -0700, Florian Fainelli wrote:
> ARM64 is the only architecture that re-defines
> __early_init_dt_declare_initrd() in order for that function to populate
> initrd_start/initrd_end with physical addresses instead of virtual
> addresses. Instead of having an override we can leverage
> drivers/of/fdt.c populating phys_initrd_start/phys_initrd_size to
> populate those variables for us.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/arm64/mm/init.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 3cf87341859f..e95cee656a55 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -72,8 +72,8 @@ static int __init early_initrd(char *p)
>  	if (*endp == ',') {
>  		size = memparse(endp + 1, NULL);
>  
> -		initrd_start = start;
> -		initrd_end = start + size;
> +		phys_initrd_start = start;
> +		phys_initrd_size = size;
>  	}
>  	return 0;
>  }
> @@ -408,14 +408,14 @@ void __init arm64_memblock_init(void)
>  		memblock_add(__pa_symbol(_text), (u64)(_end - _text));
>  	}
>  
> -	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
> +	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {
>  		/*
>  		 * Add back the memory we just removed if it results in the
>  		 * initrd to become inaccessible via the linear mapping.
>  		 * Otherwise, this is a no-op
>  		 */
> -		u64 base = initrd_start & PAGE_MASK;
> -		u64 size = PAGE_ALIGN(initrd_end) - base;
> +		u64 base = phys_initrd_start & PAGE_MASK;
> +		u64 size = PAGE_ALIGN(phys_initrd_size);
>  
>  		/*
>  		 * We can only add back the initrd memory if we don't end up
> @@ -460,13 +460,10 @@ void __init arm64_memblock_init(void)
>  	 */
>  	memblock_reserve(__pa_symbol(_text), _end - _text);
>  #ifdef CONFIG_BLK_DEV_INITRD
> -	if (initrd_start) {

There may be no initrd at all, so the condition here would rather become

	if (phys_initrd_start)

> -		memblock_reserve(initrd_start, initrd_end - initrd_start);
> -
> -		/* the generic initrd code expects virtual addresses */
> -		initrd_start = __phys_to_virt(initrd_start);
> -		initrd_end = __phys_to_virt(initrd_end);
> -	}
> +	/* the generic initrd code expects virtual addresses */
> +	initrd_start = __phys_to_virt(phys_initrd_start);
> +	initrd_end = initrd_start + phys_initrd_size;
> +	initrd_below_start_ok = 0;
>  #endif

I also wonder what is the reason to keep memstart_addr randomization and
initrd setup interleaved?

What we have now is roughly:

1) set memstart_addr
2) enforce memory_limit
3) reserve initrd
4) randomize memstart_addr
5) reserve text + data
6) reserve initrd again and set virtual addresses of initrd_{start,end}

Maybe it's possible to merge (3) into (6) ?

>  	early_init_fdt_scan_reserved_mem();
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

