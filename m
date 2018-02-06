Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752482AbeBFPlK convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 10:41:10 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:57520 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbeBFPlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 10:41:05 -0500
Date: Tue, 6 Feb 2018 16:40:53 +0100
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: stefan@agner.ch
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
        shijie.huang@arm.com, max.oss.09@gmail.com, richard@nod.at,
        linux-kernel@vger.kernel.org, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org, cyrille.pitchen@wedev4u.fr,
        han.xu@nxp.com, dwmw2@infradead.org
Subject: Re: [PATCH] mtd: nand: gpmi: fall back to legacy mode if no ECC
 information present
Message-ID: <20180206164053.67fe4d0a@bbrezillon>
In-Reply-To: <4952bf96840ae5b0caba7b8f472e2b1b@agner.ch>
References: <20180129144440.13648-1-stefan@agner.ch>
        <20180130142348.35f1bce3@bbrezillon>
        <d7a812de1b96be3460230efde4914ec1@agner.ch>
        <20180131105705.17bbe858@bbrezillon>
        <33bcf28ff1c613886c950465160e5a97@agner.ch>
        <4952bf96840ae5b0caba7b8f472e2b1b@agner.ch>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Feb 2018 23:16:57 +0100
stefan@agner.ch wrote:

> Hi Boris,
> 
> [Also adding Huang]
> 
> On 31.01.2018 22:18, stefan@agner.ch wrote:
> > I accidentally removed ML/cc before, re-adding.
> > 
> > On 31.01.2018 10:57, Boris Brezillon wrote:  
> >> On Wed, 31 Jan 2018 10:19:05 +0100
> >> stefan@agner.ch wrote:
> >>  
> >>> On 30.01.2018 14:23, Boris Brezillon wrote:  
> >>> > Hi Stefan,
> >>> >
> >>> > On Mon, 29 Jan 2018 15:44:40 +0100
> >>> > Stefan Agner <stefan@agner.ch> wrote:
> >>> >  
> >>> >> In case fsl,use-minimum-ecc is set, the driver tries to determine
> >>> >> ECC layout by using the ECC information provided by the MTD stack.
> >>> >> However, in case the NAND chip does not provide any information,
> >>> >> the driver currently fails with:
> >>> >>   nand: device found, Manufacturer ID: 0xc2, Chip ID: 0xf1
> >>> >>   nand: Macronix NAND 128MiB 3,3V 8-bit
> >>> >>   nand: 128 MiB, SLC, erase size: 128 KiB, page size: 2048, OOB size: 64
> >>> >>   gpmi-nand 1806000.gpmi-nand: Error setting BCH geometry : 1
> >>> >>   gpmi-nand: probe of 1806000.gpmi-nand failed with error 1
> >>> >>
> >>> >> Fall back to implementation specific default mode if no ECC
> >>> >> information are provided by the NAND chip and fsl,use-minimum-ecc
> >>> >> is specified.  
> >>> >
> >>> > Hm, this sounds a bit fragile: if we ever fix the Macronix driver
> >>> > (which should be done BTW) to set the appropriate ECC requirements, it
> >>> > will break all platforms that were relying on this 'fall back to legacy
> >>> > logic'.  
> >>>
> >>> I see. It is just that downstream behaves that way, hence we sell
> >>> modules which use minimal ECC on ONFI enabled chips and legacy (maximum
> >>> ECC which fits into OOB) on modules with non-ONFI chips.  
> >>
> >> And I guess you use the same DT for both variants of the board :-/
> >>  
> > 
> > Actually we only have two SKUs, and they differ also otherwise so I have
> > two DTs anyway.
> >   
> >>>
> >>> Currently we operate the above Macronix chip with 8-bit ECC since quite
> >>> a while.  
> >>
> >> Honestly, I don't see a good solution here except adding an extra DT or
> >> live-patching it from the bootloader, because, even if this hack works
> >> for you know, it might not in the future.  
> > 
> > Extra DT is fine for Linux.
> > 
> > The problem is more with U-Boot, where I tried to add minimal ECC
> > support via Kconfig symbol and align with Linux behavior. For U-Boot I
> > would really prefer to have a single binary for all SKUs...
> > 
> > I already sent a first patchset
> > https://patchwork.ozlabs.org/patch/867180/
> > 
> > I guess it should be somehow possible to do a board specific selection
> > of ECC. But this is a discussion for another thread.
> >   
> >>
> >> In the future, if you plan to have boards with different variants of
> >> NANDs, I recommend that you always maximize ECC, this way you won't
> >> have this kind of issues.  
> > 
> > Makes sense. Unfortunately, for those products we already ship, changing
> > would be rather painful.
> >   
> >>  
> >>>  
> >>> > So, if what you really want is legacy_set_geometry(), don't specify
> >>> > "fsl,use-minimum-ecc" in your DT and you should be good. Otherwise, fix
> >>> > the Macronix driver to initialize ->ecc_{strength,step_size}_ds
> >>> > appropriately.  
> >>>
> >>> The datasheet says:
> >>> • High Reliability
> >>> - Endurance: 100K cycles (with 1-bit ECC per 528-byte)
> >>>
> >>> So we would set ecc_strenght to 1?  
> >>
> >> If the datasheet says so, then yes, you should have  
> >> ->ecc_strength_ds = 1 and ->ecc_step_size_ds = 512.  
> >>  
> >>> But then there is almost no room for
> >>> wear leveling. I remember that I dumped the fixed bits once on such a
> >>> chip, and there were several blocks from factory which needed one bit
> >>> fixed...  
> >>
> >> Well, that's a different issue. You might want to maximize the ECC
> >> strength for your specific board. In this case, you should not specify
> >> "fsl,use-minimum-ecc" in your DT, or, if the driver supports it (but I
> >> doubt it does), you should add "nand-ecc-maximize". Alternatively, if
> >> you want to keep some of the OOB space, you can ask for a specific ECC
> >> config with the "nand-ecc-strength" and "nand-ecc-step-size" properties.  
> > 
> > Different issue, but in the end all I care about: Does wear leveling
> > work properly.
> > 
> > The NAND chip documentation also mentions that typical access is per
> > page (2K), I guess if one uses a single ECC across the complete page
> > then 4-bits are available, which should allow a somewhat decent wear
> > leveling.
> > 
> > I guess we can go with nand-ecc-strength/nand-ecc-step-size for that
> > chip for now.  
> 
> This seems not to be the case for the driver in question gpmi_nand_init
> calls:
> nand_scan_ident -> nand_dt_init (which fills
> chip->ecc.strength/chip->ecc.size)
> 
> then
> 
> gpmi_init_last -> gpmi_set_geometry -> bch_set_geometry ->
> legacy_set_geometry/set_geometry_by_ecc_info
> 
> In both cases struct bch_geometry is calculated and overwrites
> ecc.strength/ecc.size (without considering either of them,
> set_geometry_by_ecc_info is considering ecc_strength_ds/ecc_step_ds
> though).
> 
> I guess we would have to add a third option in case device tree
> specifies strength/size, and validate whether it can be reasonably
> fulfilled?
> 
> E.g. extend common_nfc_set_geometry:
> 
> 
>  int common_nfc_set_geometry(struct gpmi_nand_data *this)
>  {
> +	struct nand_chip *chip = &this->nand;
> +
> +	if (chip->ecc.strength set && chip->ecc.strength set)
> +		return set_geometry_by_ecc_dt_info(this);
> +
>  	if ((of_property_read_bool(this->dev->of_node, "fsl,use-minimum-ecc"))
>  				|| legacy_set_geometry(this))
>  		return set_geometry_by_ecc_info(this);
>  
>  	return 0;
>  }

Or you can just patch set_geometry_by_ecc_info() to use
chip->ecc.strength and chip->ecc.size if they are set and fall back to 
chip->ecc_strength_ds and chip->ecc_step_ds when they're not:

--->8---
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index ab9a0a2ed3b2..ded4b7389960 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -204,11 +204,19 @@ static int set_geometry_by_ecc_info(struct gpmi_nand_data *this)
        struct nand_chip *chip = &this->nand;
        struct mtd_info *mtd = nand_to_mtd(chip);
        unsigned int block_mark_bit_offset;
-
-       if (!(chip->ecc_strength_ds > 0 && chip->ecc_step_ds > 0))
+       unsigned int ecc_strength, ecc_step;
+
+       if (chip->ecc.strength > 0 && chip->ecc.size > 0) {
+               ecc_strength = chip->ecc.strength;
+               ecc_step = chip->ecc.size;
+       } else if (chip->ecc_strength_ds > 0 && chip->ecc_step_ds > 0) {
+               ecc_strength = chip->ecc_strength_ds;
+               ecc_step = chip->ecc_step_ds;
+       } else {
                return -EINVAL;
+       }
 
-       switch (chip->ecc_step_ds) {
+       switch (ecc_step) {
        case SZ_512:
                geo->gf_len = 13;
                break;
@@ -218,11 +226,11 @@ static int set_geometry_by_ecc_info(struct gpmi_nand_data *this)
        default:
                dev_err(this->dev,
                        "unsupported nand chip. ecc bits : %d, ecc size : %d\n",
-                       chip->ecc_strength_ds, chip->ecc_step_ds);
+                       ecc_strength, ecc_step);
                return -EINVAL;
        }
-       geo->ecc_chunk_size = chip->ecc_step_ds;
-       geo->ecc_strength = round_up(chip->ecc_strength_ds, 2);
+       geo->ecc_chunk_size = ecc_step;
+       geo->ecc_strength = round_up(ecc_strength, 2);
        if (!gpmi_check_ecc(this))
                return -EINVAL;
 
@@ -230,10 +238,12 @@ static int set_geometry_by_ecc_info(struct gpmi_nand_data *this)
        if (geo->ecc_chunk_size < mtd->oobsize) {
                dev_err(this->dev,
                        "unsupported nand chip. ecc size: %d, oob size : %d\n",
-                       chip->ecc_step_ds, mtd->oobsize);
+                       ecc_step, mtd->oobsize);
                return -EINVAL;
        }
 
+       chip->ecc.strength = geo->ecc_strength;
+
        /* The default value, see comment in the legacy_set_geometry(). */
        geo->metadata_size = 10;
