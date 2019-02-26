Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C0BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD73B2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="VkDtoYQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfBZLH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:07:26 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35038 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfBZLHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:07:25 -0500
Received: from zn.tnic (p200300EC2BCDB2001DA4ECEFA9208567.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:b200:1da4:ecef:a920:8567])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B31321EC023E;
        Tue, 26 Feb 2019 12:07:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1551179243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=S+sF4zuPyQuLopZCEv3V03HQgV2m49QsiOAixpJRiaM=;
        b=VkDtoYQRfnP7U0+wF6IbjbAxhI5Ndr1UapdxZyTeWGobBWhjrChevsAA8K+Ogv57nsdilQ
        IcVyzoAWBtk3+t/jCuJ2tcKRCUx6V1UJyYb7PILtSNKR0apHtgE6Xr33IDYcRhgi5xBXbj
        nVDho6RwPVGWbwLJtGw1dnKS1GXacBA=
Date:   Tue, 26 Feb 2019 12:07:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] EDAC/amd64: Support more than two UMCs
Message-ID: <20190226110716.GC14836@zn.tnic>
References: <20190219202536.15462-1-Yazen.Ghannam@amd.com>
 <20190219202536.15462-2-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190219202536.15462-2-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 08:25:53PM +0000, Ghannam, Yazen wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> The first few models of Family 17h all had 2 UMCs per Die, so we treated

Write out what that abbreviation UMC is.

> this as a fixed value. However, future systems may have more UMCs per
> Die.
> 
> Related to this, we were finding the channel number and base address of

Passive tone pls, no "we". From Documentation/process/submitting-patches.rst:

 "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
  to do frotz", as if you are giving orders to the codebase to change
  its behaviour."

> a UMC by matching on fixed, known values. However, a pattern has emerged
> so we no longer need to match on hardcoded values.

a pattern has emerged?!

> Set the number of UMCs at init time based on the Family/Model. Also,
> update the functions that find the channel number and base address of a
> UMC in order to support more than two UMCs.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/edac/amd64_edac.c | 42 ++++++++++++++++++---------------------
>  drivers/edac/amd64_edac.h | 20 +++++++++++++++----
>  2 files changed, 35 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 9947437d9574..507d824fe45a 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -449,6 +449,9 @@ static void get_cs_base_and_mask(struct amd64_pvt *pvt, int csrow, u8 dct,
>  #define for_each_chip_select_mask(i, dct, pvt) \
>  	for (i = 0; i < pvt->csels[dct].m_cnt; i++)
>  
> +#define for_each_umc(i) \
> +	for (i = 0; i < num_umcs; i++)

That change and the resulting conversion needs to be a separate patch so
that the diff doesn't distract from the UMC count figuring out addition.

>  /*
>   * @input_addr is an InputAddr associated with the node given by mci. Return the
>   * csrow that input_addr maps to, or -1 on failure (no csrow claims input_addr).
> @@ -722,7 +725,7 @@ static unsigned long determine_edac_cap(struct amd64_pvt *pvt)
>  	if (pvt->umc) {
>  		u8 i, umc_en_mask = 0, dimm_ecc_en_mask = 0;
>  
> -		for (i = 0; i < NUM_UMCS; i++) {
> +		for_each_umc(i) {
>  			if (!(pvt->umc[i].sdp_ctrl & UMC_SDP_INIT))
>  				continue;
>  
> @@ -811,7 +814,7 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
>  	struct amd64_umc *umc;
>  	u32 i, tmp, umc_base;
>  
> -	for (i = 0; i < NUM_UMCS; i++) {
> +	for_each_umc(i) {
>  		umc_base = get_umc_base(i);
>  		umc = &pvt->umc[i];
>  
> @@ -1388,7 +1391,7 @@ static int f17_early_channel_count(struct amd64_pvt *pvt)
>  	int i, channels = 0;
>  
>  	/* SDP Control bit 31 (SdpInit) is clear for unused UMC channels */
> -	for (i = 0; i < NUM_UMCS; i++)
> +	for_each_umc(i)
>  		channels += !!(pvt->umc[i].sdp_ctrl & UMC_SDP_INIT);
>  
>  	amd64_info("MCT channel count: %d\n", channels);
> @@ -2473,18 +2476,14 @@ static inline void decode_bus_error(int node_id, struct mce *m)
>   * To find the UMC channel represented by this bank we need to match on its
>   * instance_id. The instance_id of a bank is held in the lower 32 bits of its
>   * IPID.
> + *
> + * Currently, we can derive the channel number by looking at the 6th byte in
> + * the instance_id. For example, instance_id=0xYXXXXX where Y is the channel
> + * number.
>   */
> -static int find_umc_channel(struct amd64_pvt *pvt, struct mce *m)
> +static int find_umc_channel(struct mce *m)
>  {
> -	u32 umc_instance_id[] = {0x50f00, 0x150f00};
> -	u32 instance_id = m->ipid & GENMASK(31, 0);
> -	int i, channel = -1;
> -
> -	for (i = 0; i < ARRAY_SIZE(umc_instance_id); i++)
> -		if (umc_instance_id[i] == instance_id)
> -			channel = i;
> -
> -	return channel;
> +	return (m->ipid & GENMASK(31, 0)) >> 20;
>  }
>  
>  static void decode_umc_error(int node_id, struct mce *m)
> @@ -2506,11 +2505,7 @@ static void decode_umc_error(int node_id, struct mce *m)
>  	if (m->status & MCI_STATUS_DEFERRED)
>  		ecc_type = 3;
>  
> -	err.channel = find_umc_channel(pvt, m);
> -	if (err.channel < 0) {
> -		err.err_code = ERR_CHANNEL;
> -		goto log_error;
> -	}
> +	err.channel = find_umc_channel(m);
>  
>  	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_addr)) {
>  		err.err_code = ERR_NORM_ADDR;
> @@ -2612,7 +2607,7 @@ static void determine_ecc_sym_sz(struct amd64_pvt *pvt)
>  	if (pvt->umc) {
>  		u8 i;
>  
> -		for (i = 0; i < NUM_UMCS; i++) {
> +		for_each_umc(i) {
>  			/* Check enabled channels only: */
>  			if ((pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) &&
>  			    (pvt->umc[i].ecc_ctrl & BIT(7))) {
> @@ -2648,7 +2643,7 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
>  	u32 i, umc_base;
>  
>  	/* Read registers from each UMC */
> -	for (i = 0; i < NUM_UMCS; i++) {
> +	for_each_umc(i) {
>  
>  		umc_base = get_umc_base(i);
>  		umc = &pvt->umc[i];
> @@ -3061,7 +3056,8 @@ static bool ecc_enabled(struct pci_dev *F3, u16 nid)
>  	if (boot_cpu_data.x86 >= 0x17) {
>  		u8 umc_en_mask = 0, ecc_en_mask = 0;
>  
> -		for (i = 0; i < NUM_UMCS; i++) {
> +		set_num_umcs();

Do you think this call belongs here conceptually?

It is called once per each driver instance even though the number is
static and needs to be computed only once, at driver init.

Also, the function name should be something like "compute_num_umcs" or
so.

> +		for_each_umc(i) {
>  			u32 base = get_umc_base(i);
>  
>  			/* Only check enabled UMCs. */
> @@ -3114,7 +3110,7 @@ f17h_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pvt)
>  {
>  	u8 i, ecc_en = 1, cpk_en = 1;
>  
> -	for (i = 0; i < NUM_UMCS; i++) {
> +	for_each_umc(i) {
>  		if (pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) {
>  			ecc_en &= !!(pvt->umc[i].umc_cap_hi & UMC_ECC_ENABLED);
>  			cpk_en &= !!(pvt->umc[i].umc_cap_hi & UMC_ECC_CHIPKILL_CAP);
> @@ -3273,7 +3269,7 @@ static int init_one_instance(unsigned int nid)
>  		goto err_free;
>  
>  	if (pvt->fam >= 0x17) {
> -		pvt->umc = kcalloc(NUM_UMCS, sizeof(struct amd64_umc), GFP_KERNEL);
> +		pvt->umc = kcalloc(num_umcs, sizeof(struct amd64_umc), GFP_KERNEL);
>  		if (!pvt->umc) {
>  			ret = -ENOMEM;
>  			goto err_free;
> diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
> index de8dbb0b42b5..435450bf8684 100644
> --- a/drivers/edac/amd64_edac.h
> +++ b/drivers/edac/amd64_edac.h
> @@ -274,8 +274,6 @@
>  
>  #define UMC_SDP_INIT			BIT(31)
>  
> -#define NUM_UMCS			2
> -
>  enum amd_families {
>  	K8_CPUS = 0,
>  	F10_CPUS,
> @@ -399,8 +397,22 @@ struct err_info {
>  
>  static inline u32 get_umc_base(u8 channel)
>  {
> -	/* ch0: 0x50000, ch1: 0x150000 */
> -	return 0x50000 + (!!channel << 20);
> +	/* chY: 0xY50000 */
> +	return 0x50000 + (channel << 20);
> +}
> +
> +static u8 num_umcs;
> +

You and I know what "UMC" means but I doubt the reader does. Please add
some blurb here so that it is clear what it is.

> +static inline void set_num_umcs(void)
> +{
> +	u8 model = boot_cpu_data.x86_model;
> +
> +	if (model >= 0x30 && model <= 0x3f)
> +		num_umcs = 8;
> +	else
> +		num_umcs = 2;
> +
> +	edac_dbg(1, "Number of UMCs: %x", num_umcs);
>  }

Why is this function inline and in the header? I don't see anything
special about it and should be in amd64_edac.c instead, AFAICT.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
