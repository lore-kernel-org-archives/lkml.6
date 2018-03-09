Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751333AbeCIRKo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 12:10:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39056 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751182AbeCIRKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 12:10:42 -0500
Subject: Re: [PATCH v2 1/3] certs: define a trusted platform keyring
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>, dhowells@redhat.com
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Date: Fri, 09 Mar 2018 12:10:34 -0500
In-Reply-To: <20180309153803.25859-1-nayna@linux.vnet.ibm.com>
References: <20180309153803.25859-1-nayna@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18030917-0020-0000-0000-00000400D612
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030917-0021-0000-0000-000042951FF3
Message-Id: <1520615434.3911.3.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-09_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803090210
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-09 at 21:08 +0530, Nayna Jain wrote:
> The kernel can be supplied in SEEPROM or lockable flash memory in embedded
> devices. Some devices may not support secure boot, but the kernel is
> trusted because the image is stored in protected memory. That kernel may
> need to kexec additional kernels, it may be used as a bootloader, for
> example, or it may need to kexec a crashdump kernel. In such cases, it may
> want to verify the signature of the next kernel.
> 
> The kernel, however, cannot directly verify platform keys, and an
> administrator may therefore not want to trust them for arbitrary usage.
> In order to differentiate platform keys from other keys and provide the
> necessary separation of trust, the kernel needs an additional keyring to
> store platform keys.
> 
> This patch implements a built-in list of certificates that are loaded onto
> the trusted platform keyring named ".platform_keys" to facilitate signature
> verification during kexec. Because the platform keyring are builtin, it
> cannot be updated from userspace.
> 
> This keyring can be enabled by setting CONFIG_PLATFORM_KEYRING. The
> platform certificate can be provided using CONFIG_PLATFORM_TRUSTED_KEYS.
> 
> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>

Please add my Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com> on
this and 2/3.

Mimi

> ---
> Changelog:
> 
> v2:
> 
> * Include David Howell's feedback:
>  * Fix the indentation
> * Fix the patch description per line length as suggested by Mimi
> 
>  certs/Kconfig               | 17 ++++++++++++++
>  certs/Makefile              | 13 +++++++++++
>  certs/system_certificates.S | 20 +++++++++++++++++
>  certs/system_keyring.c      | 55 ++++++++++++++++++++++++++++++++++++++-------
>  4 files changed, 97 insertions(+), 8 deletions(-)
> 
> diff --git a/certs/Kconfig b/certs/Kconfig
> index 5f7663df6e8e..608a4358a25e 100644
> --- a/certs/Kconfig
> +++ b/certs/Kconfig
> @@ -83,4 +83,21 @@ config SYSTEM_BLACKLIST_HASH_LIST
>  	  wrapper to incorporate the list into the kernel.  Each <hash> should
>  	  be a string of hex digits.
> 
> +config PLATFORM_KEYRING
> +        bool "Provide keyring for platform trusted keys"
> +        depends on KEYS
> +        depends on ASYMMETRIC_KEY_TYPE
> +        help
> +	  Provide a separate, distinct keyring for platform trusted keys, which
> +	  the kernel automatically populates during initialization from values
> +	  embedded during build, used for verifying the kexec'ed kernel image
> +	  and, possibly, the initramfs signature.
> +
> +config PLATFORM_TRUSTED_KEYS
> +	string "Platform/Firmware trusted X.509 certs."
> +	depends on PLATFORM_KEYRING
> +	help
> +	  Provide the filename of a PEM-formatted file containing the platform
> +	  trusted X.509 certificates to be loaded in the platform keyring.
> +
>  endmenu
> diff --git a/certs/Makefile b/certs/Makefile
> index 5d0999b9e21b..680903725031 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -104,3 +104,16 @@ targets += signing_key.x509
>  $(obj)/signing_key.x509: scripts/extract-cert $(X509_DEP) FORCE
>  	$(call if_changed,extract_certs,$(MODULE_SIG_KEY_SRCPREFIX)$(CONFIG_MODULE_SIG_KEY))
>  endif # CONFIG_MODULE_SIG
> +
> +
> +ifeq ($(CONFIG_PLATFORM_KEYRING),y)
> +
> +$(eval $(call config_filename,PLATFORM_TRUSTED_KEYS))
> +
> +# GCC doesn't include .incbin files in -MD generated dependencies (PR#66871)
> +$(obj)/system_certificates.o: $(obj)/platform_certificate_list
> +
> +targets += platform_certificate_list
> +$(obj)/platform_certificate_list: scripts/extract-cert $(PLATFORM_TRUSTED_KEYS_FILENAME) FORCE
> +	$(call if_changed,extract_certs,$(CONFIG_PLATFORM_TRUSTED_KEYS))
> +endif # CONFIG_PLATFORM_KEYRING
> diff --git a/certs/system_certificates.S b/certs/system_certificates.S
> index 3918ff7235ed..b0eb448ee617 100644
> --- a/certs/system_certificates.S
> +++ b/certs/system_certificates.S
> @@ -14,6 +14,15 @@ __cert_list_start:
>  	.incbin "certs/x509_certificate_list"
>  __cert_list_end:
> 
> +#ifdef CONFIG_PLATFORM_KEYRING
> +	.align 8
> +	.globl VMLINUX_SYMBOL(platform_certificate_list)
> +VMLINUX_SYMBOL(platform_certificate_list):
> +__platform_cert_list_start:
> +	.incbin "certs/platform_certificate_list"
> +__platform_cert_list_end:
> +#endif /* CONFIG_PLATFORM_KEYRING */
> +
>  #ifdef CONFIG_SYSTEM_EXTRA_CERTIFICATE
>  	.globl VMLINUX_SYMBOL(system_extra_cert)
>  	.size system_extra_cert, CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE
> @@ -35,3 +44,14 @@ VMLINUX_SYMBOL(system_certificate_list_size):
>  #else
>  	.long __cert_list_end - __cert_list_start
>  #endif
> +
> +#ifdef CONFIG_PLATFORM_KEYRING
> +	.align 8
> +	.globl VMLINUX_SYMBOL(platform_certificate_list_size)
> +VMLINUX_SYMBOL(platform_certificate_list_size):
> +#ifdef CONFIG_64BIT
> +	.quad __platform_cert_list_end - __platform_cert_list_start
> +#else
> +	.long __platform_cert_list_end - __platform_cert_list_start
> +#endif
> +#endif /* CONFIG_PLATFORM_KEYRING */
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index 6251d1b27f0c..594b4986a081 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -19,14 +19,22 @@
>  #include <keys/system_keyring.h>
>  #include <crypto/pkcs7.h>
> 
> +#define BUILTIN_TRUSTED_KEYRING	0
> +#define PLATFORM_KEYRING	1
> +
>  static struct key *builtin_trusted_keys;
>  #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
>  static struct key *secondary_trusted_keys;
>  #endif
> +#ifdef CONFIG_PLATFORM_KEYRING
> +static struct key *platform_keys __ro_after_init;
> +#endif
> 
>  extern __initconst const u8 system_certificate_list[];
>  extern __initconst const unsigned long system_certificate_list_size;
> 
> +extern __initconst const u8 platform_certificate_list[];
> +extern __initconst const unsigned long platform_certificate_list_size;
>  /**
>   * restrict_link_to_builtin_trusted - Restrict keyring addition by built in CA
>   *
> @@ -123,6 +131,18 @@ static __init int system_trusted_keyring_init(void)
>  		panic("Can't link trusted keyrings\n");
>  #endif
> 
> +#ifdef CONFIG_PLATFORM_KEYRING
> +	platform_keys =
> +		keyring_alloc(".platform_keys",
> +			      KUIDT_INIT(0), KGIDT_INIT(0), current_cred(),
> +			      ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
> +			      KEY_USR_VIEW | KEY_USR_READ | KEY_USR_SEARCH),
> +			      KEY_ALLOC_NOT_IN_QUOTA,
> +			      NULL, NULL);
> +	if (IS_ERR(platform_keys))
> +		panic("Can't allocate platform keyring\n");
> +#endif
> +
>  	return 0;
>  }
> 
> @@ -132,18 +152,19 @@ static __init int system_trusted_keyring_init(void)
>  device_initcall(system_trusted_keyring_init);
> 
>  /*
> - * Load the compiled-in list of X.509 certificates.
> + * Load the certificates to the keyring.
>   */
> -static __init int load_system_certificate_list(void)
> +static __init int load_certificate_list(const u8 *p, unsigned long size,
> +		struct key *keyring)
>  {
>  	key_ref_t key;
> -	const u8 *p, *end;
> +	const u8 *end;
>  	size_t plen;
> 
> -	pr_notice("Loading compiled-in X.509 certificates\n");
> +	pr_notice("Loading compiled-in X.509 certificates to %s\n",
> +			keyring->description);
> 
> -	p = system_certificate_list;
> -	end = p + system_certificate_list_size;
> +	end = p + size;
>  	while (p < end) {
>  		/* Each cert begins with an ASN.1 SEQUENCE tag and must be more
>  		 * than 256 bytes in size.
> @@ -158,7 +179,7 @@ static __init int load_system_certificate_list(void)
>  		if (plen > end - p)
>  			goto dodgy_cert;
> 
> -		key = key_create_or_update(make_key_ref(builtin_trusted_keys, 1),
> +		key = key_create_or_update(make_key_ref(keyring, 1),
>  					   "asymmetric",
>  					   NULL,
>  					   p,
> @@ -185,7 +206,25 @@ static __init int load_system_certificate_list(void)
>  	pr_err("Problem parsing in-kernel X.509 certificate list\n");
>  	return 0;
>  }
> -late_initcall(load_system_certificate_list);
> +
> +/*
> + * Load the compiled-in list of system and platform X.509 certificates.
> + */
> +static __init int load_compiled_certificate_list(void)
> +{
> +	/* Loading certs in builtin keyring */
> +	load_certificate_list(system_certificate_list,
> +			system_certificate_list_size, builtin_trusted_keys);
> +
> +#ifdef CONFIG_PLATFORM_KEYRING
> +	/* Loading certs in platform keyring */
> +	load_certificate_list(platform_certificate_list,
> +			platform_certificate_list_size, platform_keys);
> +#endif
> +
> +	return 0;
> +}
> +late_initcall(load_compiled_certificate_list);
> 
>  #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
> 
