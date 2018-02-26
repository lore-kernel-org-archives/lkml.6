Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752768AbeBZLRb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 06:17:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47010 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751999AbeBZLR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 06:17:29 -0500
Date: Mon, 26 Feb 2018 12:17:18 +0100
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: catalin.marinas@arm.com, will.deacon@arm.com,
        bauerman@linux.vnet.ibm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        akpm@linux-foundation.org, mpe@ellerman.id.au, dyoung@redhat.com,
        bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        julien.thierry@arm.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 03/13] kexec_file, x86, powerpc: factor out
 kexec_file_ops functions
In-Reply-To: <20180222111732.23051-4-takahiro.akashi@linaro.org>
References: <20180222111732.23051-1-takahiro.akashi@linaro.org>
        <20180222111732.23051-4-takahiro.akashi@linaro.org>
Organization: IBM
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18022611-0040-0000-0000-00000437E848
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022611-0041-0000-0000-000020DA0F03
Message-Id: <20180226121718.3432bbd6@ThinkPad>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802260153
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AKASHI

On Thu, 22 Feb 2018 20:17:22 +0900
AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:

[...]

> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 990adae52151..a6d14a768b3e 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -26,34 +26,83 @@
>  #include <linux/vmalloc.h>
>  #include "kexec_internal.h"
> 
> +const __weak struct kexec_file_ops * const kexec_file_loaders[] = {NULL};
> +

Having a weak definition of kexec_file_loaders causes trouble on s390 with 
gcc 4.8 (newer versions seem to work fine). For me it looks like that in this
version gcc doesn't recognize __weak but use the default value for
optimization. This leads to _kexec_kernel_image_probe to always return ENOEXEC
because the for-loop gets optimized out.

The problem can easily be worked around by declaring kexec_file_loaders in
include/linux/kexec.h and defining it in arch code. In particular doing this

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 37e9dce518aa..fc0788540d90 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -139,6 +139,8 @@ struct kexec_file_ops {
 #endif
 };
 
+extern const struct kexec_file_ops * const kexec_file_loaders[];
+
 /**
  * struct kexec_buf - parameters for finding a place for a buffer in memory
  * @image:	kexec image in which memory to search.
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 17ba407d0e79..4e3d1e4bc7f6 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -31,8 +31,6 @@
 #include <linux/vmalloc.h>
 #include "kexec_internal.h"
 
-const __weak struct kexec_file_ops * const kexec_file_loaders[] = {NULL};
-
 #ifdef CONFIG_ARCH_HAS_KEXEC_PURGATORY
 static int kexec_calculate_store_digests(struct kimage *image);
 #else

A nice side effect of this solution is, that a developer who forgets to define
kexec_file_loaders gets a linker error. So he directly knows what's missing
instead of first having to find out where/why an error gets returned.

Otherwise the series is fine for me.

Thanks
Philipp

>  #ifdef CONFIG_ARCH_HAS_KEXEC_PURGATORY
>  static int kexec_calculate_store_digests(struct kimage *image);
>  #else
>  static int kexec_calculate_store_digests(struct kimage *image) { return 0; };
>  #endif
> 
> +int _kexec_kernel_image_probe(struct kimage *image, void *buf,
> +			     unsigned long buf_len)
> +{
> +	const struct kexec_file_ops * const *fops;
> +	int ret = -ENOEXEC;
> +
> +	for (fops = &kexec_file_loaders[0]; *fops && (*fops)->probe; ++fops) {
> +		ret = (*fops)->probe(buf, buf_len);
> +		if (!ret) {
> +			image->fops = *fops;
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>  /* Architectures can provide this probe function */
>  int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
>  					 unsigned long buf_len)
>  {
> -	return -ENOEXEC;
> +	return _kexec_kernel_image_probe(image, buf, buf_len);
> +}
> +
> +void *_kexec_kernel_image_load(struct kimage *image)
> +{
> +	if (!image->fops || !image->fops->load)
> +		return ERR_PTR(-ENOEXEC);
> +
> +	return image->fops->load(image, image->kernel_buf,
> +				 image->kernel_buf_len, image->initrd_buf,
> +				 image->initrd_buf_len, image->cmdline_buf,
> +				 image->cmdline_buf_len);
>  }
> 
>  void * __weak arch_kexec_kernel_image_load(struct kimage *image)
>  {
> -	return ERR_PTR(-ENOEXEC);
> +	return _kexec_kernel_image_load(image);
> +}
> +
> +int _kimage_file_post_load_cleanup(struct kimage *image)
> +{
> +	if (!image->fops || !image->fops->cleanup)
> +		return 0;
> +
> +	return image->fops->cleanup(image->image_loader_data);
>  }
> 
>  int __weak arch_kimage_file_post_load_cleanup(struct kimage *image)
>  {
> -	return -EINVAL;
> +	return _kimage_file_post_load_cleanup(image);
>  }
> 
>  #ifdef CONFIG_KEXEC_VERIFY_SIG
> +int _kexec_kernel_verify_sig(struct kimage *image, void *buf,
> +			    unsigned long buf_len)
> +{
> +	if (!image->fops || !image->fops->verify_sig) {
> +		pr_debug("kernel loader does not support signature verification.\n");
> +		return -EKEYREJECTED;
> +	}
> +
> +	return image->fops->verify_sig(buf, buf_len);
> +}
> +
>  int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>  					unsigned long buf_len)
>  {
> -	return -EKEYREJECTED;
> +	return _kexec_kernel_verify_sig(image, buf, buf_len);
>  }
>  #endif
> 
