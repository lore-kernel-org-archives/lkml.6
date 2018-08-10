Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7416C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1922242A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 20:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pppdjJNw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1922242A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeHJWrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 18:47:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbeHJWrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 18:47:25 -0400
Received: from gmail.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4250622429;
        Fri, 10 Aug 2018 20:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533932163;
        bh=FR5Ywpe30dxkzAaniIGx8R0LRGRfGXpHYSDACxRskc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pppdjJNwVFsJ9hQeXCZPRnQztzQHvXodcecKqVuVZBT2syg79WWxeWXypVlK8tDYm
         tjMT9s/B4kfFmSc8JHbgMtgu+zRYveg0AXzKhiiuEAi1/fI7OVXKoOCVnCL8Lt+G0t
         hJLxg3pBWLLYQQk3jrb3uSfKAPPz5uvt/4GcghK8=
Date:   Fri, 10 Aug 2018 13:16:02 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Lien <jeff.lien@wdc.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        herbert@gondor.apana.org.au, tim.c.chen@linux.intel.com,
        martin.petersen@oracle.com, david.darrington@wdc.com,
        jeff.furlong@wdc.com
Subject: Re: [PATCH] Performance Improvement in CRC16 Calculations.
Message-ID: <20180810201601.GA80850@gmail.com>
References: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com>
User-Agent: Mutt/1.10.1+60 (20b17ca5) (2018-08-02)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 02:12:11PM -0500, Jeff Lien wrote:
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

Did you also test the slice-by-4 (requires 2048-byte table) and slice-by-8
(requires 4096-byte table) methods?  Your proposal is slice-by-16 (requires
8192-byte table); the original was slice-by-1 (requires 512-byte table).

>  __u16 crc_t10dif_generic(__u16 crc, const unsigned char *buffer, size_t len)
>  {
> -	unsigned int i;
> +	const __u8 *i = (const __u8 *)buffer;
> +	const __u8 *i_end = i + len;
> +	const __u8 *i_last16 = i + (len / 16 * 16);

'i' is normally a loop counter, not a pointer.
Use 'p', 'p_end', and 'p_last16'.

>  
> -	for (i = 0 ; i < len ; i++)
> -		crc = (crc << 8) ^ t10_dif_crc_table[((crc >> 8) ^ buffer[i]) & 0xff];
> +	for (; i < i_last16; i += 16) {
> +		crc = t10_dif_crc_table[15][i[0] ^ (__u8)(crc >>  8)] ^
> +		t10_dif_crc_table[14][i[1] ^ (__u8)(crc >>  0)] ^
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
> +	}

Please indent this properly.

		crc = t10_dif_crc_table[15][i[0] ^ (__u8)(crc >>  8)] ^
		      t10_dif_crc_table[14][i[1] ^ (__u8)(crc >>  0)] ^
		      t10_dif_crc_table[13][i[2]] ^
		      t10_dif_crc_table[12][i[3]] ^
		      t10_dif_crc_table[11][i[4]] ^
		      ...

- Eric
