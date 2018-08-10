Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03348C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B827C2199B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B827C2199B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=interlog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeHJX2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 19:28:01 -0400
Received: from smtp.infotech.no ([82.134.31.41]:57135 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbeHJX2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 19:28:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 717D720423D;
        Fri, 10 Aug 2018 22:56:29 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id l2S8yP+31XI9; Fri, 10 Aug 2018 22:56:23 +0200 (CEST)
Received: from [192.168.0.16] (CPEa84e3fcc6793-CMa84e3fcc6790.cpe.net.cable.rogers.com [99.242.181.9])
        by smtp.infotech.no (Postfix) with ESMTPA id 3D207204188;
        Fri, 10 Aug 2018 22:56:17 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH] Performance Improvement in CRC16 Calculations.
To:     Jeff Lien <jeff.lien@wdc.com>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, tim.c.chen@linux.intel.com,
        martin.petersen@oracle.com, david.darrington@wdc.com,
        jeff.furlong@wdc.com
References: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <04670610-3a33-f9cb-ecac-6cb2967a1ae5@interlog.com>
Date:   Fri, 10 Aug 2018 16:56:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-10 03:12 PM, Jeff Lien wrote:
> This patch provides a performance improvement for the CRC16 calculations done in read/write
> workloads using the T10 Type 1/2/3 guard field.  For example, today with sequential write
> workloads (one thread/CPU of IO) we consume 100% of the CPU because of the CRC16 computation
> bottleneck.  Today's block devices are considerably faster, but the CRC16 calculation prevents
> folks from utilizing the throughput of such devices.  To speed up this calculation and expose
> the block device throughput, we slice the old single byte for loop into a 16 byte for loop,
> with a larger CRC table to match.  The result has shown 5x performance improvements on various
> big endian and little endian systems running the 4.18.0 kernel version.
> 
> FIO Sequential Write, 64K Block Size, Queue Depth 64
> BE Base Kernel:        bw=201.5 MiB/s
> BE Modified CRC Calc:  bw=968.1 MiB/s
> 4.80x performance improvement
> 
> LE Base Kernel:        bw=357 MiB/s
> LE Modified CRC Calc:  bw=1964 MiB/s
> 5.51x performance improvement
> 
> FIO Sequential Read, 64K Block Size, Queue Depth 64
> BE Base Kernel:        bw=611.2 MiB/s
> BE Modified CRC calc:  bw=684.9 MiB/s
> 1.12x performance improvement
> 
> LE Base Kernel:        bw=797 MiB/s
> LE Modified CRC Calc:  bw=2730 MiB/s
> 3.42x performance improvement
> 
> Reviewed-by: Dave Darrington <david.darrington@wdc.com>
> Reviewed-by: Jeff Furlong <jeff.furlong@wdc.com>
> Signed-off-by: Jeff Lien <jeff.lien@wdc.com>
> ---
>   crypto/crct10dif_common.c | 605 +++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 569 insertions(+), 36 deletions(-)
> 
> diff --git a/crypto/crct10dif_common.c b/crypto/crct10dif_common.c
> index b2fab36..40e1d6c 100644
> --- a/crypto/crct10dif_common.c
> +++ b/crypto/crct10dif_common.c
> @@ -32,47 +32,580 @@
>    * x^16 + x^15 + x^11 + x^9 + x^8 + x^7 + x^5 + x^4 + x^2 + x + 1
>    * gt: 0x8bb7
>    */
> -static const __u16 t10_dif_crc_table[256] = {

    <snip table>
>   
>   __u16 crc_t10dif_generic(__u16 crc, const unsigned char *buffer, size_t len)
>   {
> -	unsigned int i;
> +	const __u8 *i = (const __u8 *)buffer;
> +	const __u8 *i_end = i + len;
> +	const __u8 *i_last16 = i + (len / 16 * 16) >
> -	for (i = 0 ; i < len ; i++)
> -		crc = (crc << 8) ^ t10_dif_crc_table[((crc >> 8) ^ buffer[i]) & 0xff];
> +	for (; i < i_last16; i += 16) {
> +		crc = t10_dif_crc_table[15][i[0] ^ (__u8)(crc >>  8)] ^

The bswap_16() macro may be faster than crc >> 8 .

> +		t10_dif_crc_table[14][i[1] ^ (__u8)(crc >>  0)] ^

How is (crc >> 0) different from crc?

> +		t10_dif_crc_table[13][i[2]] ^
> +		t10_dif_crc_table[12][i[3]] ^
> +		t10_dif_crc_table[11][i[4]] ^
> +		t10_dif_crc_table[10][i[5]] ^
> +		t10_dif_crc_table[9][i[6]] ^
> +		t10_dif_crc_table[8][i[7]] ^
> +		t10_dif_crc_table[7][i[8]] ^
> +		t10_dif_crc_table[6][i[9]] ^
> +		t10_dif_crc_table[5][i[10]] ^
> +		t10_dif_crc_table[4][i[11]] ^
> +		t10_dif_crc_table[3][i[12]] ^
> +		t10_dif_crc_table[2][i[13]] ^
> +		t10_dif_crc_table[1][i[14]] ^
> +		t10_dif_crc_table[0][i[15]];

Since n in i[n] is marching from 0 to 15 then all but the first (i.e. i[0])
could be replaced by *(++i) . The first for loop statement would then
become:
     for (; i < i_last16; ++i) {

The two dimensional indexing could be flattened to further (ugly) pointer
manipulations, perhaps gaining some cycles, at the expense of clarity.
If so you could keep some of the two dimensional indexing lines commented
for documentation of the intent.

Doug Gilbert

> +	}
> +
> +	for (; i < i_end; i++)
> +		crc = t10_dif_crc_table[0][*i ^ (__u8)(crc >>  8)] ^ (crc << 8);
>   
>   	return crc;
>   }
> 

