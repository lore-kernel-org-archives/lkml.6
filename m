Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbeBYCG7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 21:06:59 -0500
Received: from mail4.protonmail.ch ([185.70.40.27]:27262 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751522AbeBYCG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 21:06:58 -0500
Date: Sat, 24 Feb 2018 21:06:49 -0500
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Aron <ewiwaeja@protonmail.com>
Reply-To: Aron <ewiwaeja@protonmail.com>
Subject: DMA map SG ignores DMA mask or don't report error
Message-ID: <gnrqZRQTQVRDFtW3ybhBm0RZjw4Mp-ujBvAndhAlssYvat9ftSUC5C9E05Wn1LTj-pf3vJwdPHtSG3NFhMJokL6YebBo7TgU4ZJEg5wCV9I=@protonmail.com>
Feedback-ID: exCRUuX-76GxIuv95SFjqAS-TGrJDbROW7I_en2_jyS4y96C4TnXotB0fN8goDtbIdkcYGa-Kav7YI3hXnaghg==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1P276ku030688

Hello,


tl;dr: Custom PCIe FPGA board, custom driver: dma_map_sg() and dma_set_mask() do not report any error, the dma addresses are bigger than the useable address space (30 bit).


I'm trying to write a direct I/O driver for a custom PCIe FPGA board (for my MSc thesis). I would like to use streaming scatter/gather DMA mapping to transfer large buffers between user space application and the FPGA.

I have set up the PCIe IP core in the FPGA to map the first 1 GB of the internal (AXI bus) address space to the host (so there is address space left for other internal peripherals).

In the driver in the PCIe probe function I call the dma_set_mask() and the dma_set_coherent_mask() to inform the kernel my device only can use 30 bit addressing, both returns 0. (I have found that this does not guarantees that I can use DMA [1].)

I use get_user_pages_fast() to get the pages of the user space buffer, and populate the scatter/gather list. After that I use the dma_map_sg() to set the dma addresses in the sg list, the return value of the dma_map_sg() is the same as the nents parameter (the number of pages returned by get_user_pages_fast()).
The DMA-API documentation says the dma_map_sg() returns 0 if it fails [2]. But the dma addresses in the sg list are grater than 1 GB (they can not be addressed with only 30 bits).

I have found in the drivers/usb/core/usb.c that "generic api broken like pci, can't report errors" [3]
so if this is true the dma_map_sg() will not report any errors if the dma addresses can't be used with the current DMA mask?


Questions:
How can / should I detect this? It is sufficient to looping trough the sg list and comparing the dma address with the mask?
Or this whole thing (30 bit addressing) is a bad practice? Should I put more effort to make possible to use the full 32 bit address space form the FPGA/PCIe?


Results:
Coherent DMA mapping works file, the dma address is 0x20000.
One page streaming DMA mapping reports error (dma_mapping_error() after dma_map_page()), dma address is 0xddff8000 (> 1 GB / 30 bit).
Scatter-gather streaming DMA mapping reports no error, but I get dma address somewhere 0xd85d0000 (> 1 GB / 30 bit).

Kernel: 4.9.65-3+deb9u2~bpo8+1 (debian jessie-backports)
Memory: 16 GB
CPU: i7-3930K
Motherboard: Asus P9X79


Thank you,
Aron


 [1] https://lkml.org/lkml/2016/10/17/531
 [2] https://www.kernel.org/doc/Documentation/DMA-API.txt
 [3] https://elixir.bootlin.com/linux/v4.15.5/source/drivers/usb/core/usb.c#L1069
