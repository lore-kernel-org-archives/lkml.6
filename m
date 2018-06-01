Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753100AbeFASTQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 14:19:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:35335 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751584AbeFASTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 14:19:15 -0400
Date: Fri, 1 Jun 2018 20:19:13 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4 4/8] firmware: add call to LSM hook before firmware
 sysfs fallback
Message-ID: <20180601181913.GN4511@wotan.suse.de>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1527616920-5415-5-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527616920-5415-5-git-send-email-zohar@linux.vnet.ibm.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 02:01:56PM -0400, Mimi Zohar wrote:
> Add an LSM hook prior to allowing firmware sysfs fallback loading.

Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>

> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Luis R. Rodriguez <mcgrof@suse.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> 
> Changelog v4:
> - call new LSM security_kernel_arg hook
> 
> Changelog v2:
> - call security_kernel_read_blob()
> - rename the READING_FIRMWARE_FALLBACK kernel_read_file_id enumeration to
> READING_FIRMWARE_FALLBACK_SYSFS.
> ---
>  drivers/base/firmware_loader/fallback.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> index 358354148dec..2443bda81631 100644
> --- a/drivers/base/firmware_loader/fallback.c
> +++ b/drivers/base/firmware_loader/fallback.c
> @@ -651,6 +651,8 @@ static bool fw_force_sysfs_fallback(unsigned int opt_flags)
>  
>  static bool fw_run_sysfs_fallback(unsigned int opt_flags)
>  {
> +	int ret;
> +
>  	if (fw_fallback_config.ignore_sysfs_fallback) {
>  		pr_info_once("Ignoring firmware sysfs fallback due to sysctl knob\n");
>  		return false;
> @@ -659,6 +661,11 @@ static bool fw_run_sysfs_fallback(unsigned int opt_flags)
>  	if ((opt_flags & FW_OPT_NOFALLBACK))
>  		return false;
>  
> +	/* Also permit LSMs and IMA to fail firmware sysfs fallback */
> +	ret = security_kernel_load_data(LOADING_FIRMWARE);
> +	if (ret < 0)
> +		return ret;
> +
>  	return fw_force_sysfs_fallback(opt_flags);
>  }
>  
> -- 
> 2.7.5
> 
> 

-- 
Do not panic
