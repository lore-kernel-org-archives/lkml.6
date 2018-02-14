Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031520AbeBNVgW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 16:36:22 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:53415 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030501AbeBNVgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 16:36:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Wed, 14 Feb 2018 22:36:19 +0100
From: Stefan Agner <stefan@agner.ch>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Han Xu <han.xu@nxp.com>, boris.brezillon@free-electrons.com,
        marek.vasut@gmail.com, richard@nod.at, dwmw2@infradead.org,
        cyrille.pitchen@wedev4u.fr, max.oss.09@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mtd: nand: gpmi: add support for specific ECC
 strength
In-Reply-To: <20180214200537.2c043a21@bbrezillon>
References: <20180206174021.5947-1-stefan@agner.ch>
 <20180206174021.5947-2-stefan@agner.ch>
 <2f28681f-c261-31f7-9f93-602f50109343@nxp.com>
 <20180214200537.2c043a21@bbrezillon>
Message-ID: <27a3becf329c1aa8ce8b3cc99f5a4de7@agner.ch>
User-Agent: Roundcube Webmail/1.3.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.02.2018 20:05, Boris Brezillon wrote:
> On Wed, 14 Feb 2018 16:28:36 +0000
> Han Xu <han.xu@nxp.com> wrote:
> 
>> On 02/06/2018 11:40 AM, Stefan Agner wrote:
>> > Add support for specified ECC strength/size using device tree
>> > properties nand-ecc-strength/nand-ecc-step-size.
>> >
>> > Signed-off-by: Stefan Agner <stefan@agner.ch>
>> > ---
>> >   .../devicetree/bindings/mtd/gpmi-nand.txt          |  5 ++++
>> >   drivers/mtd/nand/gpmi-nand/gpmi-nand.c             | 29 ++++++++++++++--------
>> >   2 files changed, 24 insertions(+), 10 deletions(-)
>> >
>> > diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.txt b/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
>> > index eb2d9919d063..ea6e9b735160 100644
>> > --- a/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
>> > +++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
>> > @@ -46,6 +46,11 @@ Optional properties:
>> >                          partitions written from Linux with this feature
>> >                          turned on may not be accessible by the BootROM
>> >                          code.
>> > +  - nand-ecc-strength: integer representing the number of bits to correct
>> > +                       per ECC step. Needs to be a multiple of 2.
>> > +  - nand-ecc-step-size: integer representing the number of data bytes
>> > +                       that are covered by a single ECC step. The driver
>> > +                       supports 512 and 1024.
>> >
>> >   The device tree may optionally contain sub-nodes describing partitions of the
>> >   address space. See partition.txt for more detail.
>> > diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
>> > index 50f8d4a1b983..8cb378358e11 100644
>> > --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
>> > +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
>> > @@ -198,17 +198,15 @@ static inline bool gpmi_check_ecc(struct gpmi_nand_data *this)
>> >    *
>> >    * We may have available oob space in this case.
>> >    */
>> > -static int set_geometry_by_ecc_info(struct gpmi_nand_data *this)
>> > +static int set_geometry_by_ecc_info(struct gpmi_nand_data *this,
>> > +			unsigned int ecc_strength, unsigned int ecc_step)
>> >   {
>> >   	struct bch_geometry *geo = &this->bch_geometry;
>> >   	struct nand_chip *chip = &this->nand;
>> >   	struct mtd_info *mtd = nand_to_mtd(chip);
>> >   	unsigned int block_mark_bit_offset;
>> >
>> > -	if (!(chip->ecc_strength_ds > 0 && chip->ecc_step_ds > 0))
>> > -		return -EINVAL;
>> > -
>> > -	switch (chip->ecc_step_ds) {
>> > +	switch (ecc_step) {
>> >   	case SZ_512:
>> >   		geo->gf_len = 13;
>> >   		break;
>> > @@ -221,8 +219,8 @@ static int set_geometry_by_ecc_info(struct gpmi_nand_data *this)
>> >   			chip->ecc_strength_ds, chip->ecc_step_ds);
>> >   		return -EINVAL;
>> >   	}
>> > -	geo->ecc_chunk_size = chip->ecc_step_ds;
>> > -	geo->ecc_strength = round_up(chip->ecc_strength_ds, 2);
>> > +	geo->ecc_chunk_size = ecc_step;
>> > +	geo->ecc_strength = round_up(ecc_strength, 2);
>> >   	if (!gpmi_check_ecc(this))
>> >   		return -EINVAL;
>> >
>> > @@ -230,7 +228,7 @@ static int set_geometry_by_ecc_info(struct gpmi_nand_data *this)
>> >   	if (geo->ecc_chunk_size < mtd->oobsize) {
>> >   		dev_err(this->dev,
>> >   			"unsupported nand chip. ecc size: %d, oob size : %d\n",
>> > -			chip->ecc_step_ds, mtd->oobsize);
>> > +			ecc_step, mtd->oobsize);
>> >   		return -EINVAL;
>> >   	}
>> >
>> > @@ -423,9 +421,20 @@ static int legacy_set_geometry(struct gpmi_nand_data *this)
>> >
>> >   int common_nfc_set_geometry(struct gpmi_nand_data *this)
>> >   {
>> > +	struct nand_chip *chip = &this->nand;
>> > +
>> > +	if (chip->ecc.strength > 0 && chip->ecc.size > 0)
>> > +		return set_geometry_by_ecc_info(this, chip->ecc.strength,
>> > +						chip->ecc.size);
>> > +
>>
>> I was wondering how to keep, let's say u-boot, and kernel ecc setting
>> aligned, if users can specify the strength and step_ds in DT? Did u-boot
>> enable to get these parameters from DT?
> 
> Both u-boot and Linux have to support using strength/step information
> passed through the DT before you can start patching dts files. Anyway,
> users will have to change their DT (add the nand-ecc-strength/step-size
> properties) to use this feature, so they should quickly notice that
> something is going wrong and update their bootloader or drop those
> nand-ecc-xxx props.
> 

Yes, the MTD stack has support for those properties also in U-Boot.

But currently the GPMI NAND driver (mxs_nand) in U-Boot has no DT
support.

But I do have a preliminary patch set for this. Will send it out soon.

--
Stefan


>> >   	if ((of_property_read_bool(this->dev->of_node, "fsl,use-minimum-ecc"))
>> > -				|| legacy_set_geometry(this))
>> > -		return set_geometry_by_ecc_info(this);
>> > +				|| legacy_set_geometry(this)) {
>> > +		if (!(chip->ecc_strength_ds > 0 && chip->ecc_step_ds > 0))
>> > +			return -EINVAL;
>> > +
>> > +		return set_geometry_by_ecc_info(this, chip->ecc_strength_ds,
>> > +						chip->ecc_step_ds);
>> > +	}
>> >
>> >   	return 0;
>> >   }
