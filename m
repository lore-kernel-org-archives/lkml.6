Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753015AbeEKOSq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 10:18:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42160 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753137AbeEKOSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 10:18:43 -0400
Date: Fri, 11 May 2018 15:18:36 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: kishon@ti.com, bhelgaas@google.com, nsekhar@ti.com, john@metanate.com,
        shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: endpoint: Replace mdelay with usleep_range in
 pci_epf_test_write
Message-ID: <20180511141836.GA29104@e107981-ln.cambridge.arm.com>
References: <1523365446-31563-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523365446-31563-1-git-send-email-baijiaju1990@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 09:04:06PM +0800, Jia-Ju Bai wrote:
> pci_epf_test_write() is never called in atomic context.
> 
> The call chain ending up at pci_epf_test_write() is:
> [1] pci_epf_test_write() <- pci_epf_test_cmd_handler()
> 
> pci_epf_test_cmd_handler() is set as a parameter of INIT_DELAYED_WORK() 
> in pci_epf_test_probe().
> This function is not called in atomic context.
> 
> Despite never getting called from atomic context, pci_epf_test_write()
> calls mdelay() to busily wait.
> This is not necessary and can be replaced with usleep_range() to
> avoid busy waiting.
> 
> This is found by a static analysis tool named DCNS written by myself.
> And I also manually check it.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/endpoint for v4.18, thanks.

Lorenzo

> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index f9308c2..2f0642e 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -237,7 +237,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
>  	 * wait 1ms inorder for the write to complete. Without this delay L3
>  	 * error in observed in the host system.
>  	 */
> -	mdelay(1);
> +	usleep_range(1000, 2000);
>  
>  	kfree(buf);
>  
> -- 
> 1.9.1
> 
