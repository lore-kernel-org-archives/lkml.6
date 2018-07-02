Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15956C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26FE25A21
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26FE25A21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753457AbeGBHgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:36:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37048 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751420AbeGBHgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:36:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1E3118011454;
        Mon,  2 Jul 2018 07:36:47 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-216.ams2.redhat.com [10.36.116.216])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9942B2156700;
        Mon,  2 Jul 2018 07:36:45 +0000 (UTC)
Subject: Re: [PATCH] KVM: arm64: vgic-its: Remove VLA usage
To:     Kees Cook <keescook@chromium.org>,
        Christoffer Dall <christoffer.dall@arm.com>
References: <20180629184618.GA37364@beast>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <19f9ddb1-6009-850c-1949-3a8cdacdd2fc@redhat.com>
Date:   Mon, 2 Jul 2018 09:36:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180629184618.GA37364@beast>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 02 Jul 2018 07:36:47 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 02 Jul 2018 07:36:47 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'eric.auger@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On 06/29/2018 08:46 PM, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> switches to using a maximum size and adds sanity checks. Additionally
> cleans up some of the int-vs-u32 usage and adds additional bounds checking.
> As it currently stands, this will always be 8 bytes until the ABI changes.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Cc: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: kvmarm@lists.cs.columbia.edu
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  virt/kvm/arm/vgic/vgic-its.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
> index 4ed79c939fb4..3143fc047fcf 100644
> --- a/virt/kvm/arm/vgic/vgic-its.c
> +++ b/virt/kvm/arm/vgic/vgic-its.c
> @@ -168,8 +168,14 @@ struct vgic_its_abi {
>  	int (*commit)(struct vgic_its *its);
>  };
>  
> +#define ABI_0_ESZ	8
> +#define ESZ_MAX		ABI_0_ESZ
> +
>  static const struct vgic_its_abi its_table_abi_versions[] = {
> -	[0] = {.cte_esz = 8, .dte_esz = 8, .ite_esz = 8,
> +	[0] = {
> +	 .cte_esz = ABI_0_ESZ,
> +	 .dte_esz = ABI_0_ESZ,
> +	 .ite_esz = ABI_0_ESZ,
>  	 .save_tables = vgic_its_save_tables_v0,
>  	 .restore_tables = vgic_its_restore_tables_v0,
>  	 .commit = vgic_its_commit_v0,
> @@ -180,10 +186,12 @@ static const struct vgic_its_abi its_table_abi_versions[] = {
>  
>  inline const struct vgic_its_abi *vgic_its_get_abi(struct vgic_its *its)
>  {
> +	if (WARN_ON(its->abi_rev >= NR_ITS_ABIS))
> +		return NULL;
>  	return &its_table_abi_versions[its->abi_rev];
>  }
>  
> -int vgic_its_set_abi(struct vgic_its *its, int rev)
> +static int vgic_its_set_abi(struct vgic_its *its, u32 rev)
>  {
if vgic_its_get_abi is likely to return NULL, don't we need to check abi
!= NULL in all call sites.

abi_rev is actually set by vgic_its_set_abi() which is actually called
by vgic_mmio_uaccess_write_its_iidr() and vgic_its_create().

Only vgic_mmio_uaccess_write_its_iidr allows the userspace to overwrite
the default abi_rev. At this point a check against NR_ITS_ABIS is
already done. So to me the check is done at the source?

Thanks

Eric
>  	const struct vgic_its_abi *abi;
>  
> @@ -1881,16 +1889,19 @@ typedef int (*entry_fn_t)(struct vgic_its *its, u32 id, void *entry,
>   * Return: < 0 on error, 0 if last element was identified, 1 otherwise
>   * (the last element may not be found on second level tables)
>   */
> -static int scan_its_table(struct vgic_its *its, gpa_t base, int size, int esz,
> +static int scan_its_table(struct vgic_its *its, gpa_t base, int size, u32 esz,
>  			  int start_id, entry_fn_t fn, void *opaque)
>  {
>  	struct kvm *kvm = its->dev->kvm;
>  	unsigned long len = size;
>  	int id = start_id;
>  	gpa_t gpa = base;
> -	char entry[esz];
> +	char entry[ESZ_MAX];
>  	int ret;
>  
> +	if (WARN_ON(esz > ESZ_MAX))
> +		return -EINVAL;
> +
>  	memset(entry, 0, esz);
>  
>  	while (len > 0) {
> 
