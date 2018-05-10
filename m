Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935605AbeEJAMG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 20:12:06 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46483 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933493AbeEJAMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 20:12:05 -0400
X-Google-Smtp-Source: AB8JxZoGjLR8rYd7O+kkLhLcZZWI9Xg1D7x/tASU/dKvCuAnFUZV1sSY043ZCVEcRXSmdzGDx5YE2A==
Date: Wed, 9 May 2018 17:12:02 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Loic Pallardy <loic.pallardy@st.com>
Cc: ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com,
        benjamin.gaignard@linaro.org
Subject: Re: [PATCH v3 04/13] remoteproc: add name in rproc_mem_entry struct
Message-ID: <20180510001202.GC29093@builder>
References: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
 <1519921440-21356-5-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519921440-21356-5-git-send-email-loic.pallardy@st.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01 Mar 08:23 PST 2018, Loic Pallardy wrote:

> Add name field in struct rproc_mem_entry.
> This new field will be used to match memory area
> requested in resource table with pre-registered carveout.
> 
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/remoteproc/remoteproc_core.c    | 1 +
>  drivers/remoteproc/remoteproc_debugfs.c | 1 +
>  include/linux/remoteproc.h              | 2 ++
>  3 files changed, 4 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 5f11536..f73a0cf 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -749,6 +749,7 @@ static int rproc_handle_carveout(struct rproc *rproc,
>  	carveout->dma = dma;
>  	carveout->da = rsc->da;
>  	carveout->release = rproc_release_carveout;
> +	strlcpy(carveout->name, rsc->name, sizeof(carveout->name));
>  
>  	list_add_tail(&carveout->node, &rproc->carveouts);
>  
> diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
> index a204883..fc0e570 100644
> --- a/drivers/remoteproc/remoteproc_debugfs.c
> +++ b/drivers/remoteproc/remoteproc_debugfs.c
> @@ -260,6 +260,7 @@ static int rproc_carveouts_show(struct seq_file *seq, void *p)
>  
>  	list_for_each_entry(carveout, &rproc->carveouts, node) {
>  		seq_puts(seq, "Carveout memory entry:\n");
> +		seq_printf(seq, "\tName: %s\n", carveout->name);
>  		seq_printf(seq, "\tVirtual address: %p\n", carveout->va);
>  		seq_printf(seq, "\tDMA address: %pad\n", &carveout->dma);
>  		seq_printf(seq, "\tDevice address: 0x%x\n", carveout->da);
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index dedc138..2202c08 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -315,6 +315,7 @@ struct fw_rsc_vdev {
>   * @da: device address
>   * @release: release associated memory
>   * @priv: associated data
> + * @name: associated memory region name (optional)
>   * @node: list node
>   */
>  struct rproc_mem_entry {
> @@ -323,6 +324,7 @@ struct rproc_mem_entry {
>  	int len;
>  	u32 da;
>  	void *priv;
> +	char name[32];
>  	struct list_head node;
>  	int (*release)(struct rproc *rproc, struct rproc_mem_entry *mem);
>  };
> -- 
> 1.9.1
> 
