Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbeBTTlu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 14:41:50 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:38239 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbeBTTls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 14:41:48 -0500
X-Google-Smtp-Source: AG47ELuVRy6yh4jsHA3UHPG9jRK/P5ww464LD0gN9h+VfD9uviAAh6wb951+YqqyFx0tVjbhGznLTg==
Date: Tue, 20 Feb 2018 11:41:44 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH RESEND] KEYS: remove CONFIG_KEYS_COMPAT
Message-ID: <20180220194144.GB70958@gmail.com>
References: <20180105191947.91775-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180105191947.91775-1-ebiggers3@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2018 at 11:19:47AM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> KEYS_COMPAT now always takes the value of COMPAT && KEYS.  But the
> security/keys/ directory is only compiled if KEYS is enabled, so in
> practice KEYS_COMPAT is the same as COMPAT.  Therefore, remove the
> unnecessary KEYS_COMPAT and just use COMPAT directly.
> 
> (Also remove an outdated comment from compat.c.)
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  security/keys/Kconfig    | 4 ----
>  security/keys/Makefile   | 2 +-
>  security/keys/compat.c   | 5 -----
>  security/keys/internal.h | 4 ++--
>  4 files changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/security/keys/Kconfig b/security/keys/Kconfig
> index 6462e6654ccf..e115d691d977 100644
> --- a/security/keys/Kconfig
> +++ b/security/keys/Kconfig
> @@ -20,10 +20,6 @@ config KEYS
>  
>  	  If you are unsure as to whether this is required, answer N.
>  
> -config KEYS_COMPAT
> -	def_bool y
> -	depends on COMPAT && KEYS
> -
>  config PERSISTENT_KEYRINGS
>  	bool "Enable register of persistent per-UID keyrings"
>  	depends on KEYS
> diff --git a/security/keys/Makefile b/security/keys/Makefile
> index ef1581b337a3..b92ef62b99a1 100644
> --- a/security/keys/Makefile
> +++ b/security/keys/Makefile
> @@ -17,7 +17,7 @@ obj-y := \
>  	request_key_auth.o \
>  	user_defined.o
>  compat-obj-$(CONFIG_KEY_DH_OPERATIONS) += compat_dh.o
> -obj-$(CONFIG_KEYS_COMPAT) += compat.o $(compat-obj-y)
> +obj-$(CONFIG_COMPAT) += compat.o $(compat-obj-y)
>  obj-$(CONFIG_PROC_FS) += proc.o
>  obj-$(CONFIG_SYSCTL) += sysctl.o
>  obj-$(CONFIG_PERSISTENT_KEYRINGS) += persistent.o
> diff --git a/security/keys/compat.c b/security/keys/compat.c
> index e87c89c0177c..d7445946b701 100644
> --- a/security/keys/compat.c
> +++ b/security/keys/compat.c
> @@ -50,11 +50,6 @@ static long compat_keyctl_instantiate_key_iov(
>  
>  /*
>   * The key control system call, 32-bit compatibility version for 64-bit archs
> - *
> - * This should only be called if the 64-bit arch uses weird pointers in 32-bit
> - * mode or doesn't guarantee that the top 32-bits of the argument registers on
> - * taking a 32-bit syscall are zero.  If you can, you should call sys_keyctl()
> - * directly.
>   */
>  COMPAT_SYSCALL_DEFINE5(keyctl, u32, option,
>  		       u32, arg2, u32, arg3, u32, arg4, u32, arg5)
> diff --git a/security/keys/internal.h b/security/keys/internal.h
> index 9f8208dc0e55..6d54fa8baa64 100644
> --- a/security/keys/internal.h
> +++ b/security/keys/internal.h
> @@ -272,7 +272,7 @@ extern long keyctl_dh_compute(struct keyctl_dh_params __user *, char __user *,
>  			      size_t, struct keyctl_kdf_params __user *);
>  extern long __keyctl_dh_compute(struct keyctl_dh_params __user *, char __user *,
>  				size_t, struct keyctl_kdf_params *);
> -#ifdef CONFIG_KEYS_COMPAT
> +#ifdef CONFIG_COMPAT
>  extern long compat_keyctl_dh_compute(struct keyctl_dh_params __user *params,
>  				char __user *buffer, size_t buflen,
>  				struct compat_keyctl_kdf_params __user *kdf);
> @@ -287,7 +287,7 @@ static inline long keyctl_dh_compute(struct keyctl_dh_params __user *params,
>  	return -EOPNOTSUPP;
>  }
>  
> -#ifdef CONFIG_KEYS_COMPAT
> +#ifdef CONFIG_COMPAT
>  static inline long compat_keyctl_dh_compute(
>  				struct keyctl_dh_params __user *params,
>  				char __user *buffer, size_t buflen,
> -- 
> 2.16.0.rc0.223.g4a4ac83678-goog
> 

Ping.  
