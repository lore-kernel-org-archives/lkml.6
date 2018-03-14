Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbeCNX5Z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 19:57:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44708 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbeCNX5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 19:57:24 -0400
Subject: Re: [LINUX PATCH v8 1/2] Documentation: nand: pl353: Add
 documentation for controller and driver
To: nagasureshkumarrelli@gmail.com, boris.brezillon@bootlin.com,
        richard@nod.at, dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, cyrille.pitchen@wedev4u.fr,
        miquel.raynal@bootlin.com
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        michals@xilinx.com, punnaia@xilinx.com,
        Naga Sureshkumar Relli <nagasure@xilinx.com>
References: <1521024494-30632-1-git-send-email-nagasureshkumarrelli@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0abb517f-6360-5b45-18a8-d049f3ab7a4e@infradead.org>
Date: Wed, 14 Mar 2018 16:57:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521024494-30632-1-git-send-email-nagasureshkumarrelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/14/2018 03:48 AM, nagasureshkumarrelli@gmail.com wrote:
> From: Naga Sureshkumar Relli <nagasure@xilinx.com>
> 
> Added notes about the controller and driver
> 
> Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
> ---

Hi,

> ---
>  Documentation/mtd/nand/pl353-nand.txt | 92 +++++++++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/mtd/nand/pl353-nand.txt
> 
> diff --git a/Documentation/mtd/nand/pl353-nand.txt b/Documentation/mtd/nand/pl353-nand.txt
> new file mode 100644
> index 0000000..ac6fbd5
> --- /dev/null
> +++ b/Documentation/mtd/nand/pl353-nand.txt
> @@ -0,0 +1,92 @@
> +This documents provides some notes about the ARM pl353 smc controller used in

s/smc/SMC/

> +Zynq SOC and confined to NAND specific details.
> +
> +Overview of the controller
> +==========================
> +	The SMC (PL353) supports two memory interfaces:
> +	Interface 0 type SRAM.
> +	Interface 1 type NAND.
> +	This configuration supports the following configurable options:
> +	   . 32-bit or 64-bit AXI data width
> +	   . 8-bit, 16-bit, or 32-bit memory data width for interface 0
> +	   . 8-bit, or 16-bit memory data width for interface 1
> +	   . 1-4 chip selects on each interface
> +	   . SLC ECC block for interface 1
> +
> +For more information, refer the below link for TRM
> +http://infocenter.arm.com/help/topic/com.arm.doc.ddi0380g/
> +DDI0380G_smc_pl350_series_r2p1_trm.pdf
> +
> +NAND memory accesses
> +====================
> +	. Two phase NAND accesses
> +	. NAND command phase transfers
> +	. NAND data phase transfers
> +
> +Two phase NAND accesses
> +	The SMC defines two phases of commands when transferring data to or from
> +NAND flash.
> +
> +Command phase
> +	Commands and optional address information are written to the NAND flash.
> +The command and address can be associated with either a data phase operation to
> +write to or read from the array, or a status/ID register transfer.
> +
> +Data phase
> + Data is either written to or read from the NAND flash. This data can be either
> +data transferred to or from the array, or status/ID register information.
> +
> +NAND AXI address setup
> +       AXI address      Command phase      Data phase
> +	[31:24]         Chip address       Chip address
> +	[23]            NoOfAddCycles_2    Reserved
> +	[22]            NoOfAddCycles_1    Reserved
> +	[21]            NoOfAddCycles_0    ClearCS
> +	[20]            End command valid  End command valid
> +	[19]            0                  1
> +	[18:11]         End command        End command
> +	[10:3]          Start command      [10] ECC Last
> +					   [9:3] Reserved
> +	[2:0]           Reserved           Reserved
> +
> +ECC
> +===
> +    It operates on a number of 512 byte blocks of NAND memory and can be
> +programmed to store the ECC codes after the data in memory. For writes,
> +the ECC is written to the spare area of the page. For reads, the result of
> +a block ECC check are made available to the device driver.
> +
> +------------------------------------------------------------------------
> +|               n * 512 blocks                  | extra  | ecc    |     |
> +|                                               | block  | codes  |     |
> +------------------------------------------------------------------------
> +
> +The ECC calculation uses a simple Hamming code, using 1-bit correction 2-bit
> +detection. It starts when a valid read or write command with a 512 byte aligned
> +address is detected on the memory interface.
> +
> +Driver details
> +==============
> +	The NAND driver has dependency with the pl353_smc memory controller
> +driver for intializing the nand timing parameters, bus width, ECC modes,

              initializing the NAND

> +control and status information.
> +
> +Since the controller expects that the chipselect bit should be cleared for the
> +last data transfer i.e last 4 data bytes, the existing nandbase page
> +read/write routines for soft ecc and ecc none modes will not work. So, inorder

                                                                          in order

> +to make this driver work, it always updates the ecc mode as HW ECC and

                                                   ECC mode

> +implemented the page read/write functions for supporting the SW ECC.

   implements the

> +
> +HW ECC mode:
> +	Upto 2K page size is supported and beyond that it retuns

	Up to                                             returns

> +-ENOSUPPORT error. If the flsh has ONDIE ecc controller then the

                             flash (?) has on-die ECC

> +priority has given to the ONDIE ecc controller. Also the current

            is               on-die ECC

> +implementation has support for upto 64 byte oob area

                                  up to            area.

> +
> +SW ECC mode:
> +	It supports all the pgae sizes. But since, zynq soc bootrom uses

	                                           Zynq SOC

> +HW ECC for the devices that have pgae size <=2K so, to avoid any ecc related

                                    page      <= 2K, to avoid any ECC-related

> +issues during boot, prefer HW ECC over SW ECC.
> +
> +For devicetree binding information please refer the below dt binding file

                                      please refer to the below

> +Documentation/devicetree/bindings/memory-controllers/pl353-smc.txt.
> 


-- 
~Randy
