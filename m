Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbeBZI6n (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 03:58:43 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49915 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751064AbeBZI6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 03:58:41 -0500
X-ME-Sender: <xms:QMyTWqfNmuJOsvV4_mMlCgPNAj_ewtE7UYW3CBcSswPeFquC11oJ5w>
Date: Mon, 26 Feb 2018 19:58:37 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Andrew Cooks <andrew.cooks@opengear.com>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>,
        "open list:I2C/SMBUS CONTROLLER DRIVERS FOR PC"
        <linux-i2c@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Cooks <acooks@rationali.st>, linux-acpi@vger.kernel.org,
        platypus-sw@opengear.com
Subject: Re: [RESEND][PATCH v4 1/3] i2c: piix4: Fix port selection for AMD
 Family 16h Model 30h
Message-ID: <20180226085837.GA15131@eros>
References: <cover.1519601860.git.andrew.cooks@opengear.com>
 <be68c29f603153cf047cd893c6b9d6423073632d.1519601860.git.andrew.cooks@opengear.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be68c29f603153cf047cd893c6b9d6423073632d.1519601860.git.andrew.cooks@opengear.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 10:28:43AM +1000, Andrew Cooks wrote:
> Family 16h Model 30h SMBus controller needs the same port selection fix
> as described and fixed in commit 0fe16195f891 ("i2c: piix4: Fix SMBus port
> selection for AMD Family 17h chips")
> 
> commit 6befa3fde65f ("i2c: piix4: Support alternative port selection
> register") also fixed the port selection for Hudson2, but unfortunately
> this is not the exact same device and the AMD naming and PCI Device IDs
> aren't particularly helpful here.
> 
> The SMBus port selection register is common to the following Families
> and models, as documented in AMD's publicly available BIOS and Kernel
> Developer Guides:
> 
>  50742 - Family 15h Model 60h-6Fh (PCI_DEVICE_ID_AMD_KERNCZ_SMBUS)
>  55072 - Family 15h Model 70h-7Fh (PCI_DEVICE_ID_AMD_KERNCZ_SMBUS)
>  52740 - Family 16h Model 30h-3Fh (PCI_DEVICE_ID_AMD_HUDSON2_SMBUS)
> 
> The Hudson2 PCI Device ID (PCI_DEVICE_ID_AMD_HUDSON2_SMBUS) is shared
> between Bolton FCH and Family 16h Model 30h, but the location of the
> SmBus0Sel port selection bits are different:
> 
>  51192 - Bolton Register Reference Guide
> 
> We distinguish between Bolton and Family 16h Model 30h using the PCI
> Revision ID:
> 
>   Bolton is device 0x780b, revision 0x15
>   Family 16h Model 30h is device 0x780b, revision 0x1F
>   Family 15h Model 60h and 70h are both device 0x790b, revision 0x4A.
> 
> The following additional public AMD BKDG documents were checked and do
> not share the same port selection register:
> 
>  42301 - Family 15h Model 00h-0Fh doesn't mention any
>  42300 - Family 15h Model 10h-1Fh doesn't mention any
>  49125 - Family 15h Model 30h-3Fh doesn't mention any
> 
>  48751 - Family 16h Model 00h-0Fh uses the previously supported
>          index register SB800_PIIX4_PORT_IDX_ALT at 0x2e
> 
> Signed-off-by: Andrew Cooks <andrew.cooks@opengear.com>
> ---
>  drivers/i2c/busses/i2c-piix4.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> index 174579d..5c90a44 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -99,7 +99,7 @@
>  #define SB800_PIIX4_PORT_IDX_MASK	0x06
>  #define SB800_PIIX4_PORT_IDX_SHIFT	1
>  
> -/* On kerncz, SmBus0Sel is at bit 20:19 of PMx00 DecodeEn */
> +/* On kerncz and Hudson2, SmBus0Sel is at bit 20:19 of PMx00 DecodeEn */
>  #define SB800_PIIX4_PORT_IDX_KERNCZ		0x02
>  #define SB800_PIIX4_PORT_IDX_MASK_KERNCZ	0x18
>  #define SB800_PIIX4_PORT_IDX_SHIFT_KERNCZ	3
> @@ -359,18 +359,16 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
>  
>  	/* Find which register is used for port selection */
>  	if (PIIX4_dev->vendor == PCI_VENDOR_ID_AMD) {
> -		switch (PIIX4_dev->device) {
> -		case PCI_DEVICE_ID_AMD_KERNCZ_SMBUS:
> +		if ((PIIX4_dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) ||

nit:		if (PIIX4_dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS ||

> +		    (PIIX4_dev->device == PCI_DEVICE_ID_AMD_HUDSON2_SMBUS &&
> +			   PIIX4_dev->revision >= 0x1F)) {


Hope this helps,
Tobin.
