Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751497AbeCNLiR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 07:38:17 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54634 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750964AbeCNLiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 07:38:14 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: George Cherian <george.cherian@cavium.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org
Subject: Re: [PATCH] ACPI / CPPC: Update all pr_(debug/err) messages to log the susbspace id
Date: Wed, 14 Mar 2018 12:38:47 +0100
Message-ID: <2096618.kPeo7EJefy@aspire.rjw.lan>
In-Reply-To: <1519125363-23907-1-git-send-email-george.cherian@cavium.com>
References: <1519125363-23907-1-git-send-email-george.cherian@cavium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, February 20, 2018 12:16:03 PM CET George Cherian wrote:
> CPPC dirver is aware of multiple PCC subspace IDs. Enhance the debug
> and error messages in the driver to print the subspace id. In case of
> error it will be helpful to find which particular subspace is failing.
> 
> Signed-off-by: George Cherian <george.cherian@cavium.com>
> ---
>  drivers/acpi/cppc_acpi.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 06ea474..a4133d7 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -227,7 +227,8 @@ static int check_pcc_chan(int pcc_ss_id, bool chk_err_bit)
>  	if (likely(!ret))
>  		pcc_ss_data->platform_owns_pcc = false;
>  	else
> -		pr_err("PCC check channel failed. Status=%x\n", status);
> +		pr_err("PCC check channel failed for ss: %d. Status=%x\n",
> +		       pcc_ss_id, status);
>  
>  	return ret;
>  }
> @@ -291,7 +292,8 @@ static int send_pcc_cmd(int pcc_ss_id, u16 cmd)
>  			time_delta = ktime_ms_delta(ktime_get(),
>  						    pcc_ss_data->last_mpar_reset);
>  			if ((time_delta < 60 * MSEC_PER_SEC) && pcc_ss_data->last_mpar_reset) {
> -				pr_debug("PCC cmd not sent due to MPAR limit");
> +				pr_debug("PCC cmd for subspace %d not sent due to MPAR limit",
> +					 pcc_ss_id);
>  				ret = -EIO;
>  				goto end;
>  			}
> @@ -312,8 +314,8 @@ static int send_pcc_cmd(int pcc_ss_id, u16 cmd)
>  	/* Ring doorbell */
>  	ret = mbox_send_message(pcc_ss_data->pcc_channel, &cmd);
>  	if (ret < 0) {
> -		pr_err("Err sending PCC mbox message. cmd:%d, ret:%d\n",
> -				cmd, ret);
> +		pr_err("Err sending PCC mbox message. ss: %d cmd:%d, ret:%d\n",
> +		       pcc_ss_id, cmd, ret);
>  		goto end;
>  	}
>  
> @@ -553,7 +555,8 @@ static int register_pcc_channel(int pcc_ss_idx)
>  			pcc_mbox_request_channel(&cppc_mbox_cl,	pcc_ss_idx);
>  
>  		if (IS_ERR(pcc_data[pcc_ss_idx]->pcc_channel)) {
> -			pr_err("Failed to find PCC communication channel\n");
> +			pr_err("Failed to find PCC channel for subspace %d\n",
> +			       pcc_ss_idx);
>  			return -ENODEV;
>  		}
>  
> @@ -566,7 +569,8 @@ static int register_pcc_channel(int pcc_ss_idx)
>  		cppc_ss = (pcc_data[pcc_ss_idx]->pcc_channel)->con_priv;
>  
>  		if (!cppc_ss) {
> -			pr_err("No PCC subspace found for CPPC\n");
> +			pr_err("No PCC subspace found for %d CPPC\n",
> +			       pcc_ss_idx);
>  			return -ENODEV;
>  		}
>  
> @@ -584,7 +588,8 @@ static int register_pcc_channel(int pcc_ss_idx)
>  		pcc_data[pcc_ss_idx]->pcc_comm_addr =
>  			acpi_os_ioremap(cppc_ss->base_address, cppc_ss->length);
>  		if (!pcc_data[pcc_ss_idx]->pcc_comm_addr) {
> -			pr_err("Failed to ioremap PCC comm region mem\n");
> +			pr_err("Failed to ioremap PCC comm region mem for %d\n",
> +			       pcc_ss_idx);
>  			return -ENOMEM;
>  		}
>  
> @@ -973,8 +978,8 @@ static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 *val)
>  			*val = readq_relaxed(vaddr);
>  			break;
>  		default:
> -			pr_debug("Error: Cannot read %u bit width from PCC\n",
> -					reg->bit_width);
> +			pr_debug("Error: Cannot read %u bit width from PCC for ss: %d\n",
> +				 reg->bit_width, pcc_ss_id);
>  			ret_val = -EFAULT;
>  	}
>  
> @@ -1012,8 +1017,8 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
>  			writeq_relaxed(val, vaddr);
>  			break;
>  		default:
> -			pr_debug("Error: Cannot write %u bit width to PCC\n",
> -					reg->bit_width);
> +			pr_debug("Error: Cannot write %u bit width to PCC for ss: %d\n",
> +				 reg->bit_width, pcc_ss_id);
>  			ret_val = -EFAULT;
>  			break;
>  	}
> 

Applied, thanks!
