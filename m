Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA0EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B3562133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbfB0ONY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:13:24 -0500
Received: from 19.mo3.mail-out.ovh.net ([178.32.98.231]:47640 "EHLO
        19.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfB0ONY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:13:24 -0500
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Feb 2019 09:13:20 EST
Received: from player773.ha.ovh.net (unknown [10.109.146.19])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id 525681FAF81
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 14:53:57 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player773.ha.ovh.net (Postfix) with ESMTPSA id D6DA8323B00A;
        Wed, 27 Feb 2019 13:53:47 +0000 (UTC)
Date:   Wed, 27 Feb 2019 14:53:46 +0100
From:   Greg Kurz <groug@kaod.org>
To:     "Alastair D'Silva" <alastair@au1.ibm.com>
Cc:     alastair@d-silva.org, Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] ocxl: Rename struct link to ocxl_link
Message-ID: <20190227145346.2fc86646@bahia.lan>
In-Reply-To: <20190227045741.21412-2-alastair@au1.ibm.com>
References: <20190227045741.21412-1-alastair@au1.ibm.com>
        <20190227045741.21412-2-alastair@au1.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 10841571680088856907
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedutddrvddugdehkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2019 15:57:37 +1100
"Alastair D'Silva" <alastair@au1.ibm.com> wrote:

> From: Alastair D'Silva <alastair@d-silva.org>
> 
> The term 'link' is ambiguous (especially when the struct is used for a
> list), so rename it for clarity.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---
>  drivers/misc/ocxl/file.c |  2 +-
>  drivers/misc/ocxl/link.c | 36 ++++++++++++++++++------------------
>  2 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
> index e6a607488f8a..16eb8a60d5c7 100644
> --- a/drivers/misc/ocxl/file.c
> +++ b/drivers/misc/ocxl/file.c
> @@ -152,7 +152,7 @@ static long afu_ioctl_enable_p9_wait(struct ocxl_context *ctx,
>  
>  		if (status == ATTACHED) {
>  			int rc;
> -			struct link *link = ctx->afu->fn->link;
> +			void *link = ctx->afu->fn->link;
> 

Thinking about that again, the link variable only has one user. Irrespectively
of the discussion on adding a struct ocxl_link forward declaration in the
private header and changing the API, link isn't needed in the first place...
 
>  			rc = ocxl_link_update_pe(link, ctx->pasid, ctx->tidr);

... and we could just do:

			rc = ocxl_link_update_pe(ctx->afu->fn->link, ctx->pasid,
						 ctx->tidr);

I guess it is acceptable to do this change "while here" since the patch is
about dropping the ambiguous 'link' term.

>  			if (rc)
> diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
> index d50b861d7e57..8d2690a1a9de 100644
> --- a/drivers/misc/ocxl/link.c
> +++ b/drivers/misc/ocxl/link.c
> @@ -76,7 +76,7 @@ struct spa {
>   * limited number of opencapi slots on a system and lookup is only
>   * done when the device is probed
>   */
> -struct link {
> +struct ocxl_link {
>  	struct list_head list;
>  	struct kref ref;
>  	int domain;
> @@ -179,7 +179,7 @@ static void xsl_fault_handler_bh(struct work_struct *fault_work)
>  
>  static irqreturn_t xsl_fault_handler(int irq, void *data)
>  {
> -	struct link *link = (struct link *) data;
> +	struct ocxl_link *link = (struct ocxl_link *) data;
>  	struct spa *spa = link->spa;
>  	u64 dsisr, dar, pe_handle;
>  	struct pe_data *pe_data;
> @@ -256,7 +256,7 @@ static int map_irq_registers(struct pci_dev *dev, struct spa *spa)
>  				&spa->reg_tfc, &spa->reg_pe_handle);
>  }
>  
> -static int setup_xsl_irq(struct pci_dev *dev, struct link *link)
> +static int setup_xsl_irq(struct pci_dev *dev, struct ocxl_link *link)
>  {
>  	struct spa *spa = link->spa;
>  	int rc;
> @@ -311,7 +311,7 @@ static int setup_xsl_irq(struct pci_dev *dev, struct link *link)
>  	return rc;
>  }
>  
> -static void release_xsl_irq(struct link *link)
> +static void release_xsl_irq(struct ocxl_link *link)
>  {
>  	struct spa *spa = link->spa;
>  
> @@ -323,7 +323,7 @@ static void release_xsl_irq(struct link *link)
>  	unmap_irq_registers(spa);
>  }
>  
> -static int alloc_spa(struct pci_dev *dev, struct link *link)
> +static int alloc_spa(struct pci_dev *dev, struct ocxl_link *link)
>  {
>  	struct spa *spa;
>  
> @@ -350,7 +350,7 @@ static int alloc_spa(struct pci_dev *dev, struct link *link)
>  	return 0;
>  }
>  
> -static void free_spa(struct link *link)
> +static void free_spa(struct ocxl_link *link)
>  {
>  	struct spa *spa = link->spa;
>  
> @@ -364,12 +364,12 @@ static void free_spa(struct link *link)
>  	}
>  }
>  
> -static int alloc_link(struct pci_dev *dev, int PE_mask, struct link **out_link)
> +static int alloc_link(struct pci_dev *dev, int PE_mask, struct ocxl_link **out_link)
>  {
> -	struct link *link;
> +	struct ocxl_link *link;
>  	int rc;
>  
> -	link = kzalloc(sizeof(struct link), GFP_KERNEL);
> +	link = kzalloc(sizeof(struct ocxl_link), GFP_KERNEL);
>  	if (!link)
>  		return -ENOMEM;
>  
> @@ -405,7 +405,7 @@ static int alloc_link(struct pci_dev *dev, int PE_mask, struct link **out_link)
>  	return rc;
>  }
>  
> -static void free_link(struct link *link)
> +static void free_link(struct ocxl_link *link)
>  {
>  	release_xsl_irq(link);
>  	free_spa(link);
> @@ -415,7 +415,7 @@ static void free_link(struct link *link)
>  int ocxl_link_setup(struct pci_dev *dev, int PE_mask, void **link_handle)
>  {
>  	int rc = 0;
> -	struct link *link;
> +	struct ocxl_link *link;
>  
>  	mutex_lock(&links_list_lock);
>  	list_for_each_entry(link, &links_list, list) {
> @@ -442,7 +442,7 @@ EXPORT_SYMBOL_GPL(ocxl_link_setup);
>  
>  static void release_xsl(struct kref *ref)
>  {
> -	struct link *link = container_of(ref, struct link, ref);
> +	struct ocxl_link *link = container_of(ref, struct ocxl_link, ref);
>  
>  	list_del(&link->list);
>  	/* call platform code before releasing data */
> @@ -452,7 +452,7 @@ static void release_xsl(struct kref *ref)
>  
>  void ocxl_link_release(struct pci_dev *dev, void *link_handle)
>  {
> -	struct link *link = (struct link *) link_handle;
> +	struct ocxl_link *link = (struct ocxl_link *) link_handle;
>  
>  	mutex_lock(&links_list_lock);
>  	kref_put(&link->ref, release_xsl);
> @@ -488,7 +488,7 @@ int ocxl_link_add_pe(void *link_handle, int pasid, u32 pidr, u32 tidr,
>  		void (*xsl_err_cb)(void *data, u64 addr, u64 dsisr),
>  		void *xsl_err_data)
>  {
> -	struct link *link = (struct link *) link_handle;
> +	struct ocxl_link *link = (struct ocxl_link *) link_handle;
>  	struct spa *spa = link->spa;
>  	struct ocxl_process_element *pe;
>  	int pe_handle, rc = 0;
> @@ -558,7 +558,7 @@ EXPORT_SYMBOL_GPL(ocxl_link_add_pe);
>  
>  int ocxl_link_update_pe(void *link_handle, int pasid, __u16 tid)
>  {
> -	struct link *link = (struct link *) link_handle;
> +	struct ocxl_link *link = (struct ocxl_link *) link_handle;
>  	struct spa *spa = link->spa;
>  	struct ocxl_process_element *pe;
>  	int pe_handle, rc;
> @@ -594,7 +594,7 @@ int ocxl_link_update_pe(void *link_handle, int pasid, __u16 tid)
>  
>  int ocxl_link_remove_pe(void *link_handle, int pasid)
>  {
> -	struct link *link = (struct link *) link_handle;
> +	struct ocxl_link *link = (struct ocxl_link *) link_handle;
>  	struct spa *spa = link->spa;
>  	struct ocxl_process_element *pe;
>  	struct pe_data *pe_data;
> @@ -666,7 +666,7 @@ EXPORT_SYMBOL_GPL(ocxl_link_remove_pe);
>  
>  int ocxl_link_irq_alloc(void *link_handle, int *hw_irq, u64 *trigger_addr)
>  {
> -	struct link *link = (struct link *) link_handle;
> +	struct ocxl_link *link = (struct ocxl_link *) link_handle;
>  	int rc, irq;
>  	u64 addr;
>  
> @@ -687,7 +687,7 @@ EXPORT_SYMBOL_GPL(ocxl_link_irq_alloc);
>  
>  void ocxl_link_free_irq(void *link_handle, int hw_irq)
>  {
> -	struct link *link = (struct link *) link_handle;
> +	struct ocxl_link *link = (struct ocxl_link *) link_handle;
>  
>  	pnv_ocxl_free_xive_irq(hw_irq);
>  	atomic_inc(&link->irq_available);

