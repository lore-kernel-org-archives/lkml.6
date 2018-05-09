Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965890AbeEIW2k (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 18:28:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:44207 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965118AbeEIW2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 18:28:37 -0400
From: NeilBrown <neil@brown.name>
To: Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>
Date: Thu, 10 May 2018 08:28:25 +1000
Cc: David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] mtd: spi-nor: honour max_message_size for spi-nor writes.
In-Reply-To: <20180509160240.23ef11f2@bbrezillon>
References: <87efj1kw9u.fsf@notabene.neil.brown.name> <20180509160240.23ef11f2@bbrezillon>
Message-ID: <87vabwa2gm.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, May 09 2018, Boris Brezillon wrote:

> On Fri, 27 Apr 2018 16:18:05 +1000
> NeilBrown <neil@brown.name> wrote:
>
>> Hi,
>>  I've labeled this an RFC because I'm really not sure about removing the
>>  error path from spi_nor_write() -- maybe that really matters.  But on
>>  my hardware, performing multiple small spi writes to the flash seems
>>  to work.
>>=20
>>  The spi driver is drivers/staging/mt7621-spi.  Possibly this needs to
>>  use DMA instead of a FIFO (assuming the hardware can) - or maybe
>>  drivers/spi/spi-mt65xx.c can be made to work on this hardware, though
>>  that is for an ARM SOC and mt7621 is a MIPS SOC.
>>=20
>>  I note that openwrt has similar patches:
>>   target/linux/generic/pending-4.14/450-mtd-spi-nor-allow-NOR-driver-to-=
write-fewer-bytes-th.patch
>>=20
>>  They also change the spi driver to do a short write, rather
>>  than change m25p80 to request a short write.
>>=20
>>  Is there something horribly wrong with this?
>
> Marek, any opinion on this patch?
>

Hi,
 thanks for following up.
 I have since found that I don't need this patch, though maybe others
 still do(??).
 My hardware can only send 36 bytes and receive 32 in a single
 transaction.  However I can run a sequence of transactions
 to process a whole message no matter how large that message is.  As
 long as I keep chip-select asserted, all the slave device sees is that
 the clock period isn't quite constant, and the slave shouldn't care
 much about that.
 When reading from flash, I found that handling large messages with
 multiple hardware transactions was 50% faster than breaking the
 read down into lots of 32 byte messages.

 So, I won't object if this patch is forgotten.  Thanks for
 your time anyway.

NeilBrown

>>=20
>> Thanks,
>> NeilBrown
>>=20
>> -----------------------8<------------------------
>>=20
>> m25p80 honours max_message_size and max_transfer_size
>> for reads, but not for writes.
>> I have a driver that has a max message size of 36 bytes
>> (command, address, 32 bytes data, all places in a FIFO
>> in the controller).
>> This requires m25p80_write() to honour the size limits.
>> For that to work, spi-nor needs to quietly accept partial
>> writes.
>>=20
>> With this, I can successfully re-flash my device.
>>=20
>> Signed-off-by: NeilBrown <neil@brown.name>
>> ---
>>  drivers/mtd/devices/m25p80.c  | 3 ++-
>>  drivers/mtd/spi-nor/spi-nor.c | 7 -------
>>  2 files changed, 2 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
>> index a4e18f6aaa33..7ded13507604 100644
>> --- a/drivers/mtd/devices/m25p80.c
>> +++ b/drivers/mtd/devices/m25p80.c
>> @@ -117,7 +117,8 @@ static ssize_t m25p80_write(struct spi_nor *nor, lof=
f_t to, size_t len,
>>=20=20
>>  	t[data_idx].tx_buf =3D buf;
>>  	t[data_idx].tx_nbits =3D data_nbits;
>> -	t[data_idx].len =3D len;
>> +	t[data_idx].len =3D min3(len, spi_max_transfer_size(spi),
>> +			       spi_max_message_size(spi) - cmd_sz);
>>  	spi_message_add_tail(&t[data_idx], &m);
>>=20=20
>>  	ret =3D spi_sync(spi, &m);
>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor=
.c
>> index 42ae9a1529bb..cfa15f2801ad 100644
>> --- a/drivers/mtd/spi-nor/spi-nor.c
>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>> @@ -1445,13 +1445,6 @@ static int spi_nor_write(struct mtd_info *mtd, lo=
ff_t to, size_t len,
>>  			goto write_err;
>>  		*retlen +=3D written;
>>  		i +=3D written;
>> -		if (written !=3D page_remain) {
>> -			dev_err(nor->dev,
>> -				"While writing %zu bytes written %zd bytes\n",
>> -				page_remain, written);
>> -			ret =3D -EIO;
>> -			goto write_err;
>> -		}
>>  	}
>>=20=20
>>  write_err:

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrzdgoACgkQOeye3VZi
gbmP3A//bBZkozjrzVgiLiGqxSxJXp/fTZEQIkesVDNh0gaVGdGD+w8CqepThjZC
qlGKJWArkE3yWwrBzSwhn2mf9tETV9AVTWsoIFcx2SJWgzb5CbkmZ0gHwMwzAcPT
i2iD0mW+BV09NZEX1t7S8MDSgVLyG7t63gtU1000bwejPmmmd7/TXbGQfcpPkBzw
jVEzDn7T61OeFOfoBmvteet29fIg891jykw5zpbeEd2P5xcYS/M9XqCfIyhpXSSh
7G9XrcILxexYZKONFouFoiQISZLTh/qLSsehJspZ9B6+IzR/8DrQIAcdrtTXZv6Z
Jj2dfNLyZRhacZ2qHG0lIXhbACJWTkQSV+XRGBA+BDhBXhJy5hdfEvElL9QEJ04P
4dl15hX0QjpIOloWNsk4j8od3P9DHJeLcnI21P6bMHa26FkYMTnMDpntW9ANP8b7
0HTHxVtOGoPT9/h+hPZqa/DDXr/uaDBhT6hCn5NiVuDw9ektS9NZO6JJJCciIjJk
nqo6g+VPTNPl1cp4Ipi1rwfQciokYEPZbmVlDYHHj5/xuUf1lFObBZA5zdeq7dv3
03KD5+XTDuwxjZ+mnUSbYF7Q1M7rDxjO7Jr7M/rlTgqdDkI8XCY7iU47gvANgW5j
U+T0SBdm7HVHAZjCqsyNTVP3RMygPf6bmqMzOfny7wcwKIgErEU=
=vv01
-----END PGP SIGNATURE-----
--=-=-=--
