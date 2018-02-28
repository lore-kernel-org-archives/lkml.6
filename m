Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934856AbeB1Uzt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 15:55:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:39618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934739AbeB1Uzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 15:55:47 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D43214EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Wed, 28 Feb 2018 14:55:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Change type of threshold_ns variable to u32
Message-ID: <20180228205546.GL127842@bhelgaas-glaptop.roam.corp.google.com>
References: <20180227231952.GA9001@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227231952.GA9001@embeddedor.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 05:19:52PM -0600, Gustavo A. R. Silva wrote:
> It seems that the expression threshold_us * 1000 will never exceed the
> 32-bit limits [1]. So changing the type of threshold_ns from u64 to u32
> seems sensible [2].
> 
> [1] https://marc.info/?l=linux-kernel&m=151855021100725&w=2
> [2] https://marc.info/?l=linux-kernel&m=151976318924615&w=2
> 
> Addresses-Coverity-ID: 1462501
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Applied with Andy's Reviewed-by to pci/aspm for v4.17, thanks!

I included a more detailed analysis in the changelog:

    PCI/ASPM: Declare threshold_ns as u32, not u64
    
    aspm_calc_l1ss_info() computes l1_2_threshold in microseconds as:
    
      l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
    
    where t_common_mode is at most 255us:
    
      PCI_L1SS_CAP_CM_RESTORE_TIME  0x0000ff00   <-- 8 bits; <256us
    
    and t_power_on is at most 31 * 100us = 3100us:
    
      PCI_L1SS_CAP_P_PWR_ON_VALUE   0x00f80000   <-- 5 bits; <32
      PCI_L1SS_CAP_P_PWR_ON_SCALE   0x00030000   <-- *2us, *10us, or *100us
    
    So l1_2_threshold is at most 2 + 4 + 255 + 3100 = 3361, which means
    threshold_ns is at most 3361 * 1000 = 3361000, which easily fits in a
    u32.
    
    Declare threshold_ns as u32, not u64.  This fixes a Coverity warning.
    
    Addresses-Coverity-ID: 1462501
    Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
    [bhelgaas: changelog]
    Signed-off-by: Bjorn Helgaas <helgaas@kernel.org>
    Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> ---
>  drivers/pci/pcie/aspm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 57feef2..8633fc4 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -322,7 +322,7 @@ static u32 calc_l1ss_pwron(struct pci_dev *pdev, u32 scale, u32 val)
>  
>  static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
>  {
> -	u64 threshold_ns = threshold_us * 1000;
> +	u32 threshold_ns = threshold_us * 1000;
>  
>  	/* See PCIe r3.1, sec 7.33.3 and sec 6.18 */
>  	if (threshold_ns < 32) {
> -- 
> 2.7.4
> 
