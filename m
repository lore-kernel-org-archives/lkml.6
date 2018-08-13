Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8900AC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD02217AA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD02217AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbeHMOZk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:25:40 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([207.82.80.211]:37885 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728834AbeHMOZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:25:39 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-58-4Ra5U1mZNBaqS6YaYlZ4AA-1; Mon, 13 Aug 2018 12:43:42 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon,
 13 Aug 2018 12:45:21 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 13 Aug 2018 12:45:21 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jeff Lien' <jeff.lien@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "david.darrington@wdc.com" <david.darrington@wdc.com>,
        "jeff.furlong@wdc.com" <jeff.furlong@wdc.com>
Subject: RE: [PATCH] Performance Improvement in CRC16 Calculations.
Thread-Topic: [PATCH] Performance Improvement in CRC16 Calculations.
Thread-Index: AQHUMN5vktn+vtPDWUaxGdn9R1jbpaS9kfkw
Date:   Mon, 13 Aug 2018 11:45:21 +0000
Message-ID: <8508c92d70dc41ffb66557e13c988dca@AcuMS.aculab.com>
References: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com>
In-Reply-To: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: 4Ra5U1mZNBaqS6YaYlZ4AA-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Lien
> Sent: 10 August 2018 20:12
> 
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
>  crypto/crct10dif_common.c | 605 +++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 569 insertions(+), 36 deletions(-)
> 
> diff --git a/crypto/crct10dif_common.c b/crypto/crct10dif_common.c
> index b2fab36..40e1d6c 100644
> --- a/crypto/crct10dif_common.c
> +++ b/crypto/crct10dif_common.c
> @@ -32,47 +32,580 @@
>   * x^16 + x^15 + x^11 + x^9 + x^8 + x^7 + x^5 + x^4 + x^2 + x + 1
>   * gt: 0x8bb7
>   */
> -static const __u16 t10_dif_crc_table[256] = {
...
> +	}
>  };
> 
>  __u16 crc_t10dif_generic(__u16 crc, const unsigned char *buffer, size_t len)
>  {
> -	unsigned int i;
> +	const __u8 *i = (const __u8 *)buffer;
> +	const __u8 *i_end = i + len;
> +	const __u8 *i_last16 = i + (len / 16 * 16);
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
...

I suspect that all the gain comes from a slight relaxation of the
register dependency chain and the loop unrolling.

A more interesting version would be to generate the lookup table
for a byte followed by 3 zero bytes.
You could then run four separate register dependency chains using the
same 256 entry lookup table.
A little bit of work at the end of the buffer should sort it all out.

There is also the lookup table free version:
uint32_t
crc_step(uint32_t crc, uint32_t byte_val)
{
    uint32_t t = crc ^ (byte_val & 0xff);
    t = (t ^ t << 4) & 0xff;
    return crc >> 8 ^ t << 8 ^ t << 3 ^ t >> 4;
}

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

