Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeEDAKW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 20:10:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:33502 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751133AbeEDAKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 20:10:20 -0400
Date: Fri, 4 May 2018 00:10:18 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Jones <pjones@redhat.com>, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Stephen Boyd <stephen.boyd@linaro.org>
Subject: Re: [RFC PATCH 6/6] ima: prevent loading firmware into a
 pre-allocated buffer
Message-ID: <20180504001018.GS27853@wotan.suse.de>
References: <1525182503-13849-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1525182503-13849-7-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525182503-13849-7-git-send-email-zohar@linux.vnet.ibm.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 09:48:23AM -0400, Mimi Zohar wrote:
> Question: can the device access the pre-allocated buffer at any time?
> 
> By allowing devices to request firmware be loaded directly into a
> pre-allocated buffer, will this allow the device access to the firmware
> before the kernel has verified the firmware signature?
> 
> Is it dependent on the type of buffer allocated (eg. DMA)?  For example,
> qcom_mdt_load() -> qcom_scm_pas_init_image() -> dma_alloc_coherent().
> 
> With an IMA policy requiring signed firmware, this patch would prevent
> loading firmware into a pre-allocated buffer.

Android folks went silent on the other thread .. Best poke them there?

  Luis
> 
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Luis R. Rodriguez <mcgrof@suse.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Cc: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  security/integrity/ima/ima_main.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index eb9c273ab81d..3098131f77c4 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -454,6 +454,15 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
>  		return 0;
>  	}
>  
> +	if (read_id == READING_FIRMWARE_PREALLOC_BUFFER) {
> +		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
> +		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
> +			pr_err("Prevent device from accessing firmware prior to verifying the firmware signature.\n");
> +			return -EACCES;
> +		}
> +		return 0;
> +	}
> +
>  	if (read_id == READING_FIRMWARE_FALLBACK) {
>  		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
>  		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
> -- 
> 2.7.5
> 
> 

-- 
Do not panic
