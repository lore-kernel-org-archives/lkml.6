Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752960AbeE3OwR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:52:17 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:32796 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751215AbeE3OwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:52:13 -0400
From: Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>
To: Milan Broz <gmazyland@gmail.com>,
        Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>,
        Alasdair Kergon <agk@redhat.com>, "Mike Snitzer" <snitzer@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Manjunath M Bettegowda" <Manjunath.MB@synopsys.com>,
        Prabu Thangamuthu <Prabu.T@synopsys.com>,
        Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
        device-mapper development <dm-devel@redhat.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH] md: dm-crypt: Add Inline Encryption support for dmcrypt
Thread-Topic: [PATCH] md: dm-crypt: Add Inline Encryption support for dmcrypt
Thread-Index: AQHT9qGCqs8Dj7X7aUOxjJFw2Ba+qw==
Date: Wed, 30 May 2018 14:52:07 +0000
Message-ID: <BD7FB879CC136E419544C8E2AE7B9C3020BB94@IN01WEMBXA.internal.synopsys.com>
References: <e9120efc-1e25-79c8-6132-9062dd030539@synopsys.com>
 <7a510610-9133-39aa-6841-3925c532f3c0@gmail.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.12.239.235]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4UEqkc4027380

On Monday 28 May 2018 05:33 PM, Milan Broz wrote:
> On 05/28/2018 03:01 PM, Ladvine D Almeida wrote:
>> This patch adds new option
>>     -- perform_inline_encrypt
>> that set the option inside dmcrypt to use inline encryption for
>> the configured mapping. I want to introduce inline encryption support
>> in the UFS Host Controller driver. The usage of the same for accomplishing
>> the Full Disk Encryption is done by the following changes in the
>> dmcrypt subsystem:
>>     - New function crypt_inline_encrypt_submit() is added to the
>> dmcrypt which associate the crypto context to the bios which
>> are submitted by the subsystem.
>>     - Successful configuration for the inline encryption will result in
>> the crypto transformation job being bypassed in the dmcrypt layer and the
>> actual encryption happens inline to the block device.
> I am not sure this is a good idea. Dm-crypt should never ever forward
> plaintext sector to underlying device.
>
> And you do not even check that your hw is available in the underlying device!
>
> If you want to use dm-crypt, write a crypto API driver for your crypto hw that defines
> specific cipher and let dm-crypt use this cipher (no patches needed in this case!)

Thanks for sharing your review.
I am sharing the links for the patches which are related to inline encryption below:
https://lkml.org/lkml/2018/5/28/1153
https://lkml.org/lkml/2018/5/28/1196
https://lkml.org/lkml/2018/5/28/1158
https://lkml.org/lkml/2018/5/28/1173
https://lkml.org/lkml/2018/5/28/1178

we have crypto API implementation for the hardware for  XTS algorithm, which will get registered when
the XTS algorithm capability of the inline encryption engine inside UFS Host Controller get detected by the UFS HC
driver. dm-crypt will be using this registered cipher.
 dm-crypt patch is unavoidable because the encrypt/decrypt function cannot perform the transformation
when inline encryption engine is involved. Also, it demands forwarding the plaintext sectors to the underlying
block device driver and  the crypto transformation happens internally in controller when data transfer happens.

>
> If I read the patch correctly, you do not check any parameters for
> compatibility with your hw support (cipher, mode, IV algorithm, key length, sector size ...)

I am registering an algorithm with cipher mode, IV size, block size, supported key size etc. for use by dm-crypt
as per the hardware capability of inline encryption engine.
If any other cipher mode, etc is used during the setup stage, DM-Crypt will work as normal.

>
> It seems like if the "perform_inline_encrypt" option is present, you just submit
> the whole bio to your code with new INLINE_ENCRYPTION bit set.

when the optional argument "perform_inline_encrypt" is set, we are not unconditionally sending the bio
to the block devices. The steps are explained below:
1. user invokes the dm-setup command with the registered cipher "xts" and with the optional argument
"perform_inline_encrypt".
2. dm-setup invokes the setkey function of the newly introduced algorithm, which finds the available key slots
to be programmed(UFS Host controller Inline Encryption engine has multiple keyslots), program the key slot,
and return the key slot index as return value of the set key function.
3. When read/write operation happens, crypt_map() function in dm-crypt validates whether there is associated
key configuration index for the request. The Bio will be submitted directly in this case only with the associated
crypto context.
4. Block device driver, eg. UFS host controller driver will create the Transfer requests as per this crypto context and
encryption happens inside the controller.

>
> What happens, if the cipher in table is different from what your hw is doing?

In this case, the dm-crypt will work as previous. This is because the setkey returns 0.
whenever there is key configuration index associated, setkey returns index value(greater than 0). The bios are submitted
with that information to underlying block device drivers.
Also, care is taken to ensure that fallback will happen incase hardware lacks the support of any key lengths.

Appreciate your suggestions/feedback. We are trying to bring modifications into the subsystem to support controllers with
inline encryption capabilities and tried our best to take care of any vulnerabilities or risks associated to same.
Inline encryption engines got huge advantage over the accelerators/software algorithms that it removes overhead associated
to current implementation like performing transformation on 512 byte chunks, allocation of scatterlists etc.

>
> Milan
>
>> Another patch set is sent to the block layer community for
>> CONFIG_BLK_DEV_INLINE_ENCRYPTION config, which enables changes in the
>> block layer for adding the bi_ie_private variable to the bio structure.
>>
>> Signed-off-by: Ladvine D Almeida <ladvine@synopsys.com>
>> ---
>>  drivers/md/dm-crypt.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 53 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
>> index 44ff473..a9ed567 100644
>> --- a/drivers/md/dm-crypt.c
>> +++ b/drivers/md/dm-crypt.c
>> @@ -39,6 +39,7 @@
>>  #include <linux/device-mapper.h>
>>  
>>  #define DM_MSG_PREFIX "crypt"
>> +#define REQ_INLINE_ENCRYPTION REQ_DRV
>>  
>>  /*
>>   * context holding the current state of a multi-part conversion
>> @@ -125,7 +126,8 @@ struct iv_tcw_private {
>>   * and encrypts / decrypts at the same time.
>>   */
>>  enum flags { DM_CRYPT_SUSPENDED, DM_CRYPT_KEY_VALID,
>> -	     DM_CRYPT_SAME_CPU, DM_CRYPT_NO_OFFLOAD };
>> +	     DM_CRYPT_SAME_CPU, DM_CRYPT_NO_OFFLOAD,
>> +		 DM_CRYPT_INLINE_ENCRYPT };
>>  
>>  enum cipher_flags {
>>  	CRYPT_MODE_INTEGRITY_AEAD,	/* Use authenticated mode for cihper */
>> @@ -215,6 +217,10 @@ struct crypt_config {
>>  
>>  	u8 *authenc_key; /* space for keys in authenc() format (if used) */
>>  	u8 key[0];
>> +#ifdef CONFIG_BLK_DEV_INLINE_ENCRYPTION
>> +	void *ie_private; /* crypto context for inline enc drivers */
>> +	int key_cfg_idx;  /* key configuration index for inline enc */
>> +#endif
>>  };
>>  
>>  #define MIN_IOS		64
>> @@ -1470,6 +1476,20 @@ static void crypt_io_init(struct dm_crypt_io *io, struct crypt_config *cc,
>>  	atomic_set(&io->io_pending, 0);
>>  }
>>  
>> +#ifdef CONFIG_BLK_DEV_INLINE_ENCRYPTION
>> +static void crypt_inline_encrypt_submit(struct crypt_config *cc,
>> +	struct dm_target *ti, struct bio *bio)
>> +{
>> +	bio_set_dev(bio, cc->dev->bdev);
>> +	if (bio_sectors(bio))
>> +		bio->bi_iter.bi_sector = cc->start +
>> +			dm_target_offset(ti, bio->bi_iter.bi_sector);
>> +	bio->bi_opf |= REQ_INLINE_ENCRYPTION;
>> +	bio->bi_ie_private = cc->ie_private;
>> +	generic_make_request(bio);
>> +}
>> +#endif
>> +
>>  static void crypt_inc_pending(struct dm_crypt_io *io)
>>  {
>>  	atomic_inc(&io->io_pending);
>> @@ -1960,6 +1980,9 @@ static int crypt_setkey(struct crypt_config *cc)
>>  
>>  	/* Ignore extra keys (which are used for IV etc) */
>>  	subkey_size = crypt_subkey_size(cc);
>> +#ifdef CONFIG_BLK_DEV_INLINE_ENCRYPTION
>> +	cc->key_cfg_idx = -1;
>> +#endif
>>  
>>  	if (crypt_integrity_hmac(cc)) {
>>  		if (subkey_size < cc->key_mac_size)
>> @@ -1978,10 +2001,19 @@ static int crypt_setkey(struct crypt_config *cc)
>>  			r = crypto_aead_setkey(cc->cipher_tfm.tfms_aead[i],
>>  					       cc->key + (i * subkey_size),
>>  					       subkey_size);
>> -		else
>> +		else {
>>  			r = crypto_skcipher_setkey(cc->cipher_tfm.tfms[i],
>>  						   cc->key + (i * subkey_size),
>>  						   subkey_size);
>> +#ifdef CONFIG_BLK_DEV_INLINE_ENCRYPTION
>> +			if (r > 0) {
>> +				cc->key_cfg_idx = r;
>> +				cc->ie_private = cc->cipher_tfm.tfms[i];
>> +				r = 0;
>> +			}
>> +#endif
>> +		}
>> +
>>  		if (r)
>>  			err = r;
>>  	}
>> @@ -2654,6 +2686,10 @@ static int crypt_ctr_optional(struct dm_target *ti, unsigned int argc, char **ar
>>  			cc->sector_shift = __ffs(cc->sector_size) - SECTOR_SHIFT;
>>  		} else if (!strcasecmp(opt_string, "iv_large_sectors"))
>>  			set_bit(CRYPT_IV_LARGE_SECTORS, &cc->cipher_flags);
>> +#ifdef CONFIG_BLK_DEV_INLINE_ENCRYPTION
>> +		else if (!strcasecmp(opt_string, "perform_inline_encrypt"))
>> +			set_bit(DM_CRYPT_INLINE_ENCRYPT, &cc->flags);
>> +#endif
>>  		else {
>>  			ti->error = "Invalid feature arguments";
>>  			return -EINVAL;
>> @@ -2892,6 +2928,13 @@ static int crypt_map(struct dm_target *ti, struct bio *bio)
>>  	if (unlikely(bio->bi_iter.bi_size & (cc->sector_size - 1)))
>>  		return DM_MAPIO_KILL;
>>  
>> +#ifdef CONFIG_BLK_DEV_INLINE_ENCRYPTION
>> +	if (cc->key_cfg_idx > 0) {
>> +		crypt_inline_encrypt_submit(cc, ti, bio);
>> +		return DM_MAPIO_SUBMITTED;
>> +	}
>> +#endif
>> +
>>  	io = dm_per_bio_data(bio, cc->per_bio_data_size);
>>  	crypt_io_init(io, cc, bio, dm_target_offset(ti, bio->bi_iter.bi_sector));
>>  
>> @@ -2954,6 +2997,10 @@ static void crypt_status(struct dm_target *ti, status_type_t type,
>>  		num_feature_args += test_bit(DM_CRYPT_NO_OFFLOAD, &cc->flags);
>>  		num_feature_args += cc->sector_size != (1 << SECTOR_SHIFT);
>>  		num_feature_args += test_bit(CRYPT_IV_LARGE_SECTORS, &cc->cipher_flags);
>> +#ifdef CONFIG_BLK_DEV_INLINE_ENCRYPTION
>> +		num_feature_args +=
>> +			test_bit(DM_CRYPT_INLINE_ENCRYPT, &cc->flags);
>> +#endif
>>  		if (cc->on_disk_tag_size)
>>  			num_feature_args++;
>>  		if (num_feature_args) {
>> @@ -2970,6 +3017,10 @@ static void crypt_status(struct dm_target *ti, status_type_t type,
>>  				DMEMIT(" sector_size:%d", cc->sector_size);
>>  			if (test_bit(CRYPT_IV_LARGE_SECTORS, &cc->cipher_flags))
>>  				DMEMIT(" iv_large_sectors");
>> +#ifdef CONFIG_BLK_DEV_INLINE_ENCRYPTION
>> +			if (test_bit(DM_CRYPT_INLINE_ENCRYPT, &cc->flags))
>> +				DMEMIT(" perform_inline_encrypt");
>> +#endif
>>  		}
>>  
>>  		break;
>>
>

Best Regards,

Ladvine
