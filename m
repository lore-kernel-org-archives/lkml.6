Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE98C65BAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631EA20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 631EA20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbeLFXJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:09:21 -0500
Received: from mail.hallyn.com ([178.63.66.53]:54170 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbeLFXJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 18:09:19 -0500
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 450B28B8; Thu,  6 Dec 2018 17:09:16 -0600 (CST)
Date:   Thu, 6 Dec 2018 17:09:16 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Nayna Jain <nayna@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, jforbes@redhat.com,
        seth.forshee@canonical.com, kexec@lists.infradead.org,
        keyrings@vger.kernel.org, vgoyal@redhat.com, ebiederm@xmission.com,
        mpe@ellerman.id.au
Subject: Re: [PATCH 7/7] ima: Support platform keyring for kernel appraisal
Message-ID: <20181206230916.GA10203@mail.hallyn.com>
References: <20181125151500.8298-1-nayna@linux.ibm.com>
 <20181125151500.8298-8-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181125151500.8298-8-nayna@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 08:45:00PM +0530, Nayna Jain wrote:
> On secure boot enabled systems, the bootloader verifies the kernel
> image and possibly the initramfs signatures based on a set of keys. A
> soft reboot(kexec) of the system, with the same kernel image and
> initramfs, requires access to the original keys to verify the
> signatures.
> 
> This patch allows IMA-appraisal access to those original keys, now
> loaded on the platform keyring, needed for verifying the kernel image
> and initramfs signatures.
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

The overall set seems sensible to me, and I see no errors here,

Acked-by: Serge Hallyn <serge@hallyn.com>

I do think that replacing the 'rc' with xattr_len in the previous line might
help future readers save a few cycles.

> ---
>  security/integrity/ima/ima_appraise.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index deec1804a00a..9c13585e7d3e 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -294,7 +294,16 @@ int ima_appraise_measurement(enum ima_hooks func,
>  					     iint->ima_hash->length);
>  		if (rc == -EOPNOTSUPP) {
>  			status = INTEGRITY_UNKNOWN;
> -		} else if (rc) {
> +			break;
> +		}
> +		if (rc && func == KEXEC_KERNEL_CHECK)
> +			rc = integrity_digsig_verify(
> +					INTEGRITY_KEYRING_PLATFORM,
> +					(const char *)xattr_value,
> +					xattr_len,
> +					iint->ima_hash->digest,
> +					iint->ima_hash->length);
> +		if (rc) {
>  			cause = "invalid-signature";
>  			status = INTEGRITY_FAIL;
>  		} else {
> -- 
> 2.13.6
> 
