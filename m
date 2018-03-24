Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752704AbeCXW1x convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 18:27:53 -0400
Received: from trem.minaslivre.org ([148.251.208.85]:51614 "EHLO
        grilo.cascardo.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752229AbeCXW1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 18:27:51 -0400
Date: Sat, 24 Mar 2018 19:18:50 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@debian.org>
To: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        indranil@chelsio.com, nirranjan@chelsio.com,
        stephen@networkplumber.org, ganeshgr@chelsio.com,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, davem@davemloft.net,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH net-next v2 2/2] cxgb4: collect hardware dump in second
 kernel
Message-ID: <20180324221849.GW14312@siri.cascardo.eti.br>
References: <cover.1521888444.git.rahul.lakkireddy@chelsio.com>
 <f06cca21650affa10d83a28dbd7fb577792e35a9.1521888444.git.rahul.lakkireddy@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <f06cca21650affa10d83a28dbd7fb577792e35a9.1521888444.git.rahul.lakkireddy@chelsio.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 24, 2018 at 04:26:34PM +0530, Rahul Lakkireddy wrote:
> Register callback to collect hardware/firmware dumps in second kernel
> before hardware/firmware is initialized.  The dumps for each device
> will be available under /sys/kernel/crashdd/cxgb4/ directory in second
> kernel.
> 
> Signed-off-by: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
> Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
> ---
> v2:
> - No Changes.
> 
> Changes since rfc v2:
> - Update comments and commit message for sysfs change.
> 
> rfc v2:
> - Updated dump registration to the new API in patch 1.
[...]
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> index e880be8e3c45..265cb026f868 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> @@ -5527,6 +5527,18 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (err)
>  		goto out_free_adapter;
>  
> +	if (is_kdump_kernel()) {
> +		/* Collect hardware state and append to
> +		 * /sys/kernel/crashdd/cxgb4/ directory
> +		 */
> +		err = cxgb4_cudbg_crashdd_add_dump(adapter);
> +		if (err) {
> +			dev_warn(adapter->pdev_dev,
> +				 "Fail collecting crash device dump, err: %d. Continuing\n",
> +				 err);
> +			err = 0;
> +		}
> +	}
>  

The problem I see with this approach is that you require that the driver
is built into the kdump kernel (or present as a module in the kdump
initramfs), and that you will probe the device during the collection of
the dumps.

IMHO, if you are going to require the device to be probed by the same
driver during kdump, you might just as well use the device object itself
to present the crash data. I think that's what Stephen Hemminger meant
when he said to use sysfs. No need at all for any special crashdd. Just
add an attribute or attribute group to the device object.

Otherwise, as Eric Biederman pointed out, you should just add that data
into the vmcore before you kexec, so you don't even need to look at a
different file, and the driver does not even need to be present in the
kdump kernel.

Cascardo.

>  	if (!is_t4(adapter->params.chip)) {
>  		s_qpp = (QUEUESPERPAGEPF0_S +
> -- 
> 2.14.1
