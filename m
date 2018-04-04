Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751710AbeDDPFK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 11:05:10 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51304 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751392AbeDDPFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 11:05:08 -0400
Date: Wed, 4 Apr 2018 17:05:03 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Nick Dyer <nick@shmanahar.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Nandor Han <nandor.han@ge.com>
Subject: Re: [PATCHv1] Input: atmel_mxt_ts - fix the firmware update
Message-ID: <20180404150503.tw7dsy72rh4soee6@earth.universe>
References: <20180322164330.24809-1-sebastian.reichel@collabora.co.uk>
 <20180323194736.7fhgb6qjkwbivsvx@hairyalien>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xh5suhrbkt5zzyu4"
Content-Disposition: inline
In-Reply-To: <20180323194736.7fhgb6qjkwbivsvx@hairyalien>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xh5suhrbkt5zzyu4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nick,

On Fri, Mar 23, 2018 at 07:47:36PM +0000, Nick Dyer wrote:
> On Thu, Mar 22, 2018 at 05:43:30PM +0100, Sebastian Reichel wrote:
> > The automatic update mechanism will trigger an update if the
> > info block CRCs are different between maxtouch configuration
> > file (maxtouch.cfg) and chip.
> >=20
> > The driver compared the CRCs without retrieving the chip CRC,
> > resulting always in a failure and firmware flashing action
> > triggered. The patch will fix this issue by retrieving the
> > chip info block CRC before the check.
>=20
> Thanks for raising this, I agree it's definitely something we want to
> fix.
>=20
> However, I'm not convinced you're solving the problem in the best way.
> You've attached it to the read_t9_resolution() code path, whereas the
> info block is common between T9 and T100 and works in the same way.
>=20
> Would you mind trying the below patch? I've dusted it off from some
> work that I did back in 2012 and it should solve your issue.
>=20
> It also has the benefit that by reading the information block and the
> object table into a contiguous region of memory, we can verify the
> checksum at probe time. This means we make sure that we are indeed
> talking to a chip that supports object protocol correctly.
>=20
> Signed-off-by: Nick Dyer <nick.dyer@shmanahar.org>
> Acked-by: Benson Leung <bleung@chromium.org>

I currently have an unrelated issue that breaks boot on that board,
so I can't test it, but the patch looks mostly good to me. I
noticed, two useless error messages for -ENOMEM. After fixing those
the patch is

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 193 +++++++++++++++++++------=
------
>  1 file changed, 117 insertions(+), 76 deletions(-)
>=20
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/tou=
chscreen/atmel_mxt_ts.c
> index 7659bc48f1db..8a60d91d49a6 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -275,7 +275,8 @@ struct mxt_data {
>  	char phys[64];		/* device physical location */
>  	const struct mxt_platform_data *pdata;
>  	struct mxt_object *object_table;
> -	struct mxt_info info;
> +	struct mxt_info *info;
> +	void *raw_info_block;
>  	unsigned int irq;
>  	unsigned int max_x;
>  	unsigned int max_y;
> @@ -450,12 +451,13 @@ static int mxt_lookup_bootloader_address(struct mxt=
_data *data, bool retry)
>  {
>  	u8 appmode =3D data->client->addr;
>  	u8 bootloader;
> +	u8 family_id =3D data->info ? data->info->family_id : 0;
> =20
>  	switch (appmode) {
>  	case 0x4a:
>  	case 0x4b:
>  		/* Chips after 1664S use different scheme */
> -		if (retry || data->info.family_id >=3D 0xa2) {
> +		if (retry || family_id >=3D 0xa2) {
>  			bootloader =3D appmode - 0x24;
>  			break;
>  		}
> @@ -682,7 +684,7 @@ mxt_get_object(struct mxt_data *data, u8 type)
>  	struct mxt_object *object;
>  	int i;
> =20
> -	for (i =3D 0; i < data->info.object_num; i++) {
> +	for (i =3D 0; i < data->info->object_num; i++) {
>  		object =3D data->object_table + i;
>  		if (object->type =3D=3D type)
>  			return object;
> @@ -1453,12 +1455,12 @@ static int mxt_update_cfg(struct mxt_data *data, =
const struct firmware *cfg)
>  		data_pos +=3D offset;
>  	}
> =20
> -	if (cfg_info.family_id !=3D data->info.family_id) {
> +	if (cfg_info.family_id !=3D data->info->family_id) {
>  		dev_err(dev, "Family ID mismatch!\n");
>  		return -EINVAL;
>  	}
> =20
> -	if (cfg_info.variant_id !=3D data->info.variant_id) {
> +	if (cfg_info.variant_id !=3D data->info->variant_id) {
>  		dev_err(dev, "Variant ID mismatch!\n");
>  		return -EINVAL;
>  	}
> @@ -1503,7 +1505,7 @@ static int mxt_update_cfg(struct mxt_data *data, co=
nst struct firmware *cfg)
> =20
>  	/* Malloc memory to store configuration */
>  	cfg_start_ofs =3D MXT_OBJECT_START +
> -			data->info.object_num * sizeof(struct mxt_object) +
> +			data->info->object_num * sizeof(struct mxt_object) +
>  			MXT_INFO_CHECKSUM_SIZE;
>  	config_mem_size =3D data->mem_size - cfg_start_ofs;
>  	config_mem =3D kzalloc(config_mem_size, GFP_KERNEL);
> @@ -1554,20 +1556,6 @@ static int mxt_update_cfg(struct mxt_data *data, c=
onst struct firmware *cfg)
>  	return ret;
>  }
> =20
> -static int mxt_get_info(struct mxt_data *data)
> -{
> -	struct i2c_client *client =3D data->client;
> -	struct mxt_info *info =3D &data->info;
> -	int error;
> -
> -	/* Read 7-byte info block starting at address 0 */
> -	error =3D __mxt_read_reg(client, 0, sizeof(*info), info);
> -	if (error)
> -		return error;
> -
> -	return 0;
> -}
> -
>  static void mxt_free_input_device(struct mxt_data *data)
>  {
>  	if (data->input_dev) {
> @@ -1582,9 +1570,10 @@ static void mxt_free_object_table(struct mxt_data =
*data)
>  	video_unregister_device(&data->dbg.vdev);
>  	v4l2_device_unregister(&data->dbg.v4l2);
>  #endif
> -
> -	kfree(data->object_table);
>  	data->object_table =3D NULL;
> +	data->info =3D NULL;
> +	kfree(data->raw_info_block);
> +	data->raw_info_block =3D NULL;
>  	kfree(data->msg_buf);
>  	data->msg_buf =3D NULL;
>  	data->T5_address =3D 0;
> @@ -1600,34 +1589,18 @@ static void mxt_free_object_table(struct mxt_data=
 *data)
>  	data->max_reportid =3D 0;
>  }
> =20
> -static int mxt_get_object_table(struct mxt_data *data)
> +static int mxt_parse_object_table(struct mxt_data *data,
> +				  struct mxt_object *object_table)
>  {
>  	struct i2c_client *client =3D data->client;
> -	size_t table_size;
> -	struct mxt_object *object_table;
> -	int error;
>  	int i;
>  	u8 reportid;
>  	u16 end_address;
> =20
> -	table_size =3D data->info.object_num * sizeof(struct mxt_object);
> -	object_table =3D kzalloc(table_size, GFP_KERNEL);
> -	if (!object_table) {
> -		dev_err(&data->client->dev, "Failed to allocate memory\n");
> -		return -ENOMEM;
> -	}
> -
> -	error =3D __mxt_read_reg(client, MXT_OBJECT_START, table_size,
> -			object_table);
> -	if (error) {
> -		kfree(object_table);
> -		return error;
> -	}
> -
>  	/* Valid Report IDs start counting from 1 */
>  	reportid =3D 1;
>  	data->mem_size =3D 0;
> -	for (i =3D 0; i < data->info.object_num; i++) {
> +	for (i =3D 0; i < data->info->object_num; i++) {
>  		struct mxt_object *object =3D object_table + i;
>  		u8 min_id, max_id;
> =20
> @@ -1651,8 +1624,8 @@ static int mxt_get_object_table(struct mxt_data *da=
ta)
> =20
>  		switch (object->type) {
>  		case MXT_GEN_MESSAGE_T5:
> -			if (data->info.family_id =3D=3D 0x80 &&
> -			    data->info.version < 0x20) {
> +			if (data->info->family_id =3D=3D 0x80 &&
> +			    data->info->version < 0x20) {
>  				/*
>  				 * On mXT224 firmware versions prior to V2.0
>  				 * read and discard unused CRC byte otherwise
> @@ -1707,24 +1680,108 @@ static int mxt_get_object_table(struct mxt_data =
*data)
>  	/* If T44 exists, T5 position has to be directly after */
>  	if (data->T44_address && (data->T5_address !=3D data->T44_address + 1))=
 {
>  		dev_err(&client->dev, "Invalid T44 position\n");
> -		error =3D -EINVAL;
> -		goto free_object_table;
> +		return -EINVAL;
>  	}
> =20
>  	data->msg_buf =3D kcalloc(data->max_reportid,
>  				data->T5_msg_size, GFP_KERNEL);
>  	if (!data->msg_buf) {
>  		dev_err(&client->dev, "Failed to allocate message buffer\n");
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mxt_read_info_block(struct mxt_data *data)
> +{
> +	struct i2c_client *client =3D data->client;
> +	int error;
> +	size_t size;
> +	void *id_buf, *buf;
> +	uint8_t num_objects;
> +	u32 calculated_crc;
> +	u8 *crc_ptr;
> +
> +	/* If info block already allocated, free it */
> +	if (data->raw_info_block !=3D NULL)
> +		mxt_free_object_table(data);
> +
> +	/* Read 7-byte ID information block starting at address 0 */
> +	size =3D sizeof(struct mxt_info);
> +	id_buf =3D kzalloc(size, GFP_KERNEL);
> +	if (!id_buf) {
> +		dev_err(&client->dev, "Failed to allocate memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	error =3D __mxt_read_reg(client, 0, size, id_buf);
> +	if (error) {
> +		kfree(id_buf);
> +		return error;
> +	}
> +
> +	/* Resize buffer to give space for rest of info block */
> +	num_objects =3D ((struct mxt_info *)id_buf)->object_num;
> +	size +=3D (num_objects * sizeof(struct mxt_object))
> +		+ MXT_INFO_CHECKSUM_SIZE;
> +
> +	buf =3D krealloc(id_buf, size, GFP_KERNEL);
> +	if (!buf) {
> +		dev_err(&client->dev, "Failed to allocate memory\n");
>  		error =3D -ENOMEM;
> -		goto free_object_table;
> +		goto err_free_mem;
> +	}
> +
> +	/* Read rest of info block */
> +	error =3D __mxt_read_reg(client, MXT_OBJECT_START,
> +			       size - MXT_OBJECT_START,
> +			       buf + MXT_OBJECT_START);
> +	if (error)
> +		goto err_free_mem;
> +
> +	/* Extract & calculate checksum */
> +	crc_ptr =3D buf + size - MXT_INFO_CHECKSUM_SIZE;
> +	data->info_crc =3D crc_ptr[0] | (crc_ptr[1] << 8) | (crc_ptr[2] << 16);
> +
> +	calculated_crc =3D mxt_calculate_crc(buf, 0,
> +					   size - MXT_INFO_CHECKSUM_SIZE);
> +
> +	/*
> +	 * CRC mismatch can be caused by data corruption due to I2C comms
> +	 * issue or else device is not using Object Based Protocol (eg i2c-hid)
> +	 */
> +	if ((data->info_crc =3D=3D 0) || (data->info_crc !=3D calculated_crc)) {
> +		dev_err(&client->dev,
> +			"Info Block CRC error calculated=3D0x%06X read=3D0x%06X\n",
> +			calculated_crc, data->info_crc);
> +		error =3D -EIO;
> +		goto err_free_mem;
>  	}
> =20
> -	data->object_table =3D object_table;
> +	data->raw_info_block =3D buf;
> +	data->info =3D (struct mxt_info *)buf;
> +
> +	dev_info(&client->dev,
> +		 "Family: %u Variant: %u Firmware V%u.%u.%02X Objects: %u\n",
> +		 data->info->family_id, data->info->variant_id,
> +		 data->info->version >> 4, data->info->version & 0xf,
> +		 data->info->build, data->info->object_num);
> +
> +	/* Parse object table information */
> +	error =3D mxt_parse_object_table(data, buf + MXT_OBJECT_START);
> +	if (error) {
> +		dev_err(&client->dev, "Error %d parsing object table\n", error);
> +		mxt_free_object_table(data);
> +		return error;
> +	}
> +
> +	data->object_table =3D (struct mxt_object *)(buf + MXT_OBJECT_START);
> =20
>  	return 0;
> =20
> -free_object_table:
> -	mxt_free_object_table(data);
> +err_free_mem:
> +	kfree(buf);
>  	return error;
>  }
> =20
> @@ -2039,7 +2096,7 @@ static int mxt_initialize(struct mxt_data *data)
>  	int error;
> =20
>  	while (1) {
> -		error =3D mxt_get_info(data);
> +		error =3D mxt_read_info_block(data);
>  		if (!error)
>  			break;
> =20
> @@ -2070,13 +2127,6 @@ static int mxt_initialize(struct mxt_data *data)
>  		msleep(MXT_FW_RESET_TIME);
>  	}
> =20
> -	/* Get object table information */
> -	error =3D mxt_get_object_table(data);
> -	if (error) {
> -		dev_err(&client->dev, "Error %d reading object table\n", error);
> -		return error;
> -	}
> -
>  	error =3D mxt_acquire_irq(data);
>  	if (error)
>  		goto err_free_object_table;
> @@ -2155,25 +2205,24 @@ static int mxt_init_t7_power_cfg(struct mxt_data =
*data)
>  static u16 mxt_get_debug_value(struct mxt_data *data, unsigned int x,
>  			       unsigned int y)
>  {
> -	struct mxt_info *info =3D &data->info;
>  	struct mxt_dbg *dbg =3D &data->dbg;
>  	unsigned int ofs, page;
>  	unsigned int col =3D 0;
>  	unsigned int col_width;
> =20
> -	if (info->family_id =3D=3D MXT_FAMILY_1386) {
> -		col_width =3D info->matrix_ysize / MXT1386_COLUMNS;
> +	if (data->info->family_id =3D=3D MXT_FAMILY_1386) {
> +		col_width =3D data->info->matrix_ysize / MXT1386_COLUMNS;
>  		col =3D y / col_width;
>  		y =3D y % col_width;
>  	} else {
> -		col_width =3D info->matrix_ysize;
> +		col_width =3D data->info->matrix_ysize;
>  	}
> =20
>  	ofs =3D (y + (x * col_width)) * sizeof(u16);
>  	page =3D ofs / MXT_DIAGNOSTIC_SIZE;
>  	ofs %=3D MXT_DIAGNOSTIC_SIZE;
> =20
> -	if (info->family_id =3D=3D MXT_FAMILY_1386)
> +	if (data->info->family_id =3D=3D MXT_FAMILY_1386)
>  		page +=3D col * MXT1386_PAGES_PER_COLUMN;
> =20
>  	return get_unaligned_le16(&dbg->t37_buf[page].data[ofs]);
> @@ -2483,7 +2532,6 @@ static const struct video_device mxt_video_device =
=3D {
> =20
>  static void mxt_debug_init(struct mxt_data *data)
>  {
> -	struct mxt_info *info =3D &data->info;
>  	struct mxt_dbg *dbg =3D &data->dbg;
>  	struct mxt_object *object;
>  	int error;
> @@ -2508,11 +2556,11 @@ static void mxt_debug_init(struct mxt_data *data)
>  	/* Calculate size of data and allocate buffer */
>  	dbg->t37_nodes =3D data->xsize * data->ysize;
> =20
> -	if (info->family_id =3D=3D MXT_FAMILY_1386)
> +	if (data->info->family_id =3D=3D MXT_FAMILY_1386)
>  		dbg->t37_pages =3D MXT1386_COLUMNS * MXT1386_PAGES_PER_COLUMN;
>  	else
>  		dbg->t37_pages =3D DIV_ROUND_UP(data->xsize *
> -					      info->matrix_ysize *
> +					      data->info->matrix_ysize *
>  					      sizeof(u16),
>  					      sizeof(dbg->t37_buf->data));
> =20
> @@ -2569,7 +2617,6 @@ static int mxt_configure_objects(struct mxt_data *d=
ata,
>  				 const struct firmware *cfg)
>  {
>  	struct device *dev =3D &data->client->dev;
> -	struct mxt_info *info =3D &data->info;
>  	int error;
> =20
>  	error =3D mxt_init_t7_power_cfg(data);
> @@ -2594,11 +2641,6 @@ static int mxt_configure_objects(struct mxt_data *=
data,
> =20
>  	mxt_debug_init(data);
> =20
> -	dev_info(dev,
> -		 "Family: %u Variant: %u Firmware V%u.%u.%02X Objects: %u\n",
> -		 info->family_id, info->variant_id, info->version >> 4,
> -		 info->version & 0xf, info->build, info->object_num);
> -
>  	return 0;
>  }
> =20
> @@ -2607,9 +2649,9 @@ static ssize_t mxt_fw_version_show(struct device *d=
ev,
>  				   struct device_attribute *attr, char *buf)
>  {
>  	struct mxt_data *data =3D dev_get_drvdata(dev);
> -	struct mxt_info *info =3D &data->info;
>  	return scnprintf(buf, PAGE_SIZE, "%u.%u.%02X\n",
> -			 info->version >> 4, info->version & 0xf, info->build);
> +			 data->info->version >> 4, data->info->version & 0xf,
> +			 data->info->build);
>  }
> =20
>  /* Hardware Version is returned as FamilyID.VariantID */
> @@ -2617,9 +2659,8 @@ static ssize_t mxt_hw_version_show(struct device *d=
ev,
>  				   struct device_attribute *attr, char *buf)
>  {
>  	struct mxt_data *data =3D dev_get_drvdata(dev);
> -	struct mxt_info *info =3D &data->info;
>  	return scnprintf(buf, PAGE_SIZE, "%u.%u\n",
> -			 info->family_id, info->variant_id);
> +			data->info->family_id, data->info->variant_id);
>  }
> =20
>  static ssize_t mxt_show_instance(char *buf, int count,
> @@ -2656,7 +2697,7 @@ static ssize_t mxt_object_show(struct device *dev,
>  		return -ENOMEM;
> =20
>  	error =3D 0;
> -	for (i =3D 0; i < data->info.object_num; i++) {
> +	for (i =3D 0; i < data->info->object_num; i++) {
>  		object =3D data->object_table + i;
> =20
>  		if (!mxt_object_readable(object->type))
> --=20
> 2.14.1
>=20

--xh5suhrbkt5zzyu4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrE6ZwACgkQ2O7X88g7
+pp+Yg/9Hw4fZJpEskKGUkPLOD3QImh1oxJF9kFmG9LKS13jO2ZrjHWbrkq5ukq4
unlhz3/YO2UgnRjLpYx0XopPSgPYkn9GZo0CZJWfod99ohBhD1+Vf7tHThM9uUqt
zB831mDU4DLitEyrQGtf8jaNSShpzVmHVfFt5obaJnUTy4sJI5aB2NrSd7uNaqN8
deM8VR1gq0h4/xZOwW1D6ZFxEQPH29vYvFpLfKWuSQhFkDpZrx6E4WuFrRgSnSyn
57kR0vOyZo2h/Pq0kCvIjF+Z1E2r5zezf9GBtzdPazPjPAmHpxfPWKwF+b6FnZ2p
1FoZBj+G3OSGjzPn3tGXf13CbCSglv3DlvZaax9HnfX9+/Ty3cL48b8RUYoMBzYW
8Zqdki61aMQ8yoSmnod21FnbIfhGrVRbC2z4uPYBMPYxrQjfQYXBh9EwjPvhQG4M
FMGbjBkW5hr/bAGfRQYY+7MeVrRWQHdtsUSijMGZc+wogkpEJIYePHV3sTNqeSOC
TgqDjMQo8PDAyrR9ePhbj1nn39XO3fTLgHaimjtb9RMqG82rzwDw8ZTgrCqvT0oM
dULkTzaIa3REBEiuq5N8xIYIEBFVASAt1oZxOWBW7C4ka4agT1Nj/CDIKZwoC5p3
gcvOvZym6rOdkGvwj8qHp38aT0VX6zNQNhtwLS76fxWtE0E/KRY=
=ooVP
-----END PGP SIGNATURE-----

--xh5suhrbkt5zzyu4--
