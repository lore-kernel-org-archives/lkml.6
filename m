Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932525AbeCIWA7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 17:00:59 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:37024 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932104AbeCIWA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 17:00:58 -0500
X-Google-Smtp-Source: AG47ELt844RpzUheO+i4YyTCkZTXJe+3VFc+ZPG1Qbl/oFwLciO078sdN0kj11H4jb0LfYdBe5s/bF01m3iE933Iw3M=
MIME-Version: 1.0
In-Reply-To: <fee4d34acb0daffe56ab774612e4208b73f4f859.1520592053.git.geliangtang@gmail.com>
References: <fee4d34acb0daffe56ab774612e4208b73f4f859.1520592053.git.geliangtang@gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 9 Mar 2018 14:00:55 -0800
X-Google-Sender-Auth: hk9O9Txy1x-UMrF2UcfZJFdRE-M
Message-ID: <CAGXu5jJTqo7nP73Vr4K8etrPcs90JP6GhHY_5oxmg0hdb0Z9BA@mail.gmail.com>
Subject: Re: [PATCH] pstore: use crypto compress API
To: Geliang Tang <geliangtang@gmail.com>
Cc: Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 9, 2018 at 2:51 AM, Geliang Tang <geliangtang@gmail.com> wrote:
> In the pstore compression part, we use zlib/lzo/lz4/lz4hc/842
> compression algorithm API to implement pstore compression backends. But
> there are many repeat codes in these implementations. This patch uses
> crypto compress API to simplify these codes.
>
> 1) rewrite allocate_buf_for_compression, free_buf_for_compression,
> pstore_compress, pstore_decompress functions using crypto compress API.
> 2) drop compress, decompress, allocate, free functions in pstore_zbackend,
> and add zbufsize function to get each different compress buffer size.
> 3) use late_initcall to call ramoops_init later, to make sure the crypto
> subsystem has already initialized.
> 4) use 'unsigned int' type instead of 'size_t' in pstore_compress,
> pstore_decompress functions' length arguments.
> 5) rename 'zlib' to 'deflate' to follow the crypto API's name
> convention.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  fs/pstore/Kconfig    |  33 ++--
>  fs/pstore/platform.c | 413 ++++++++-------------------------------------------
>  fs/pstore/ram.c      |   2 +-
>  3 files changed, 80 insertions(+), 368 deletions(-)

Yay code removal! This is very nice. Thanks!

-Kees

-- 
Kees Cook
Pixel Security<div class="gmail_extra"><br><div class="gmail_quote">On
Fri, Mar 9, 2018 at 2:51 AM, Geliang Tang <span dir="ltr">&lt;<a
href="mailto:geliangtang@gmail.com"
target="_blank">geliangtang@gmail.com</a>&gt;</span>
wrote:<br><blockquote class="gmail_quote" style="margin:0 0 0
.8ex;border-left:1px #ccc solid;padding-left:1ex">In the pstore
compression part, we use zlib/lzo/lz4/lz4hc/842<br>
compression algorithm API to implement pstore compression backends. But<br>
there are many repeat codes in these implementations. This patch uses<br>
crypto compress API to simplify these codes.<br>
<br>
1) rewrite allocate_buf_for_compression, free_buf_for_compression,<br>
pstore_compress, pstore_decompress functions using crypto compress API.<br>
2) drop compress, decompress, allocate, free functions in pstore_zbackend,<br>
and add zbufsize function to get each different compress buffer size.<br>
3) use late_initcall to call ramoops_init later, to make sure the crypto<br>
subsystem has already initialized.<br>
4) use 'unsigned int' type instead of 'size_t' in pstore_compress,<br>
pstore_decompress functions' length arguments.<br>
5) rename 'zlib' to 'deflate' to follow the crypto API's name<br>
convention.<br>
<br>
Signed-off-by: Geliang Tang &lt;<a
href="mailto:geliangtang@gmail.com">geliangtang@gmail.com</a>&gt;<br>
---<br>
&nbsp;fs/pstore/Kconfig&nbsp; &nbsp; |&nbsp; 33 ++--<br>
&nbsp;fs/pstore/platform.c | 413
++++++++----------------------<wbr>---------------------<br>
&nbsp;fs/pstore/ram.c&nbsp; &nbsp; &nbsp; |&nbsp; &nbsp;2 +-<br>
&nbsp;3 files changed, 80 insertions(+), 368 deletions(-)<br>
<br>
diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig<br>
index e4e22026c7a1..26f1c0fcada3 100644<br>
--- a/fs/pstore/Kconfig<br>
+++ b/fs/pstore/Kconfig<br>
@@ -12,51 +12,46 @@ config PSTORE<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;If you don't have a platform
persistent store driver,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;say N.<br>
<br>
-config PSTORE_ZLIB_COMPRESS<br>
-&nbsp; &nbsp; &nbsp; &nbsp;bool "ZLIB compression"<br>
+config PSTORE_DEFLATE_COMPRESS<br>
+&nbsp; &nbsp; &nbsp; &nbsp;bool "DEFLATE compression"<br>
&nbsp; &nbsp; &nbsp; &nbsp; default y<br>
&nbsp; &nbsp; &nbsp; &nbsp; depends on PSTORE<br>
-&nbsp; &nbsp; &nbsp; &nbsp;select ZLIB_DEFLATE<br>
-&nbsp; &nbsp; &nbsp; &nbsp;select ZLIB_INFLATE<br>
+&nbsp; &nbsp; &nbsp; &nbsp;select CRYPTO_DEFLATE<br>
&nbsp; &nbsp; &nbsp; &nbsp; help<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;This option enables ZLIB
compression algorithm support.<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;This option enables DEFLATE
compression algorithm support.<br>
<br>
&nbsp;config PSTORE_LZO_COMPRESS<br>
&nbsp; &nbsp; &nbsp; &nbsp; bool "LZO compression"<br>
&nbsp; &nbsp; &nbsp; &nbsp; depends on PSTORE<br>
-&nbsp; &nbsp; &nbsp; &nbsp;select LZO_COMPRESS<br>
-&nbsp; &nbsp; &nbsp; &nbsp;select LZO_DECOMPRESS<br>
+&nbsp; &nbsp; &nbsp; &nbsp;select CRYPTO_LZO<br>
&nbsp; &nbsp; &nbsp; &nbsp; help<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; This option enables LZO compression
algorithm support.<br>
<br>
&nbsp;config PSTORE_LZ4_COMPRESS<br>
&nbsp; &nbsp; &nbsp; &nbsp; bool "LZ4 compression"<br>
&nbsp; &nbsp; &nbsp; &nbsp; depends on PSTORE<br>
-&nbsp; &nbsp; &nbsp; &nbsp;select LZ4_COMPRESS<br>
-&nbsp; &nbsp; &nbsp; &nbsp;select LZ4_DECOMPRESS<br>
+&nbsp; &nbsp; &nbsp; &nbsp;select CRYPTO_LZ4<br>
&nbsp; &nbsp; &nbsp; &nbsp; help<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; This option enables LZ4 compression
algorithm support.<br>
<br>
&nbsp;config PSTORE_LZ4HC_COMPRESS<br>
&nbsp; &nbsp; &nbsp; &nbsp; bool "LZ4HC compression"<br>
&nbsp; &nbsp; &nbsp; &nbsp; depends on PSTORE<br>
-&nbsp; &nbsp; &nbsp; &nbsp;select LZ4HC_COMPRESS<br>
-&nbsp; &nbsp; &nbsp; &nbsp;select LZ4_DECOMPRESS<br>
+&nbsp; &nbsp; &nbsp; &nbsp;select CRYPTO_LZ4HC<br>
&nbsp; &nbsp; &nbsp; &nbsp; help<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; This option enables LZ4HC (high
compression) mode algorithm.<br>
<br>
&nbsp;config PSTORE_842_COMPRESS<br>
&nbsp; &nbsp; &nbsp; &nbsp; bool "842 compression"<br>
&nbsp; &nbsp; &nbsp; &nbsp; depends on PSTORE<br>
-&nbsp; &nbsp; &nbsp; &nbsp;select 842_COMPRESS<br>
-&nbsp; &nbsp; &nbsp; &nbsp;select 842_DECOMPRESS<br>
+&nbsp; &nbsp; &nbsp; &nbsp;select CRYPTO_842<br>
&nbsp; &nbsp; &nbsp; &nbsp; help<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; This option enables 842 compression
algorithm support.<br>
<br>
&nbsp;config PSTORE_COMPRESS<br>
&nbsp; &nbsp; &nbsp; &nbsp; def_bool y<br>
&nbsp; &nbsp; &nbsp; &nbsp; depends on PSTORE<br>
-&nbsp; &nbsp; &nbsp; &nbsp;depends on PSTORE_ZLIB_COMPRESS ||
PSTORE_LZO_COMPRESS ||&nbsp; &nbsp; &nbsp; &nbsp;\<br>
+&nbsp; &nbsp; &nbsp; &nbsp;depends on PSTORE_DEFLATE_COMPRESS ||
PSTORE_LZO_COMPRESS ||&nbsp; &nbsp; \<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;PSTORE_LZ4_COMPRESS || PSTORE_LZ4HC_COMPRESS ||&nbsp; &nbsp;
&nbsp; \<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;PSTORE_842_COMPRESS<br>
<br>
@@ -69,12 +64,12 @@ choice<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; the kernel command line.<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Currently, pstore has support for 5
compression algorithms:<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;zlib, lzo, lz4, lz4hc and 842.<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;deflate, lzo, lz4, lz4hc and 842.<br>
<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;The default compression algorithm
is zlib.<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;The default compression algorithm
is deflate.<br>
<br>
-&nbsp; &nbsp; &nbsp; &nbsp;config PSTORE_ZLIB_COMPRESS_DEFAULT<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;bool "zlib" if
PSTORE_ZLIB_COMPRESS=y<br>
+&nbsp; &nbsp; &nbsp; &nbsp;config PSTORE_DEFLATE_COMPRESS_<wbr>DEFAULT<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;bool "deflate"
if PSTORE_DEFLATE_COMPRESS=y<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; config PSTORE_LZO_COMPRESS_DEFAULT<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; bool "lzo" if
PSTORE_LZO_COMPRESS=y<br>
@@ -93,7 +88,7 @@ endchoice<br>
&nbsp;config PSTORE_COMPRESS_DEFAULT<br>
&nbsp; &nbsp; &nbsp; &nbsp; string<br>
&nbsp; &nbsp; &nbsp; &nbsp; depends on PSTORE_COMPRESS<br>
-&nbsp; &nbsp; &nbsp; &nbsp;default "zlib" if PSTORE_ZLIB_COMPRESS_DEFAULT<br>
+&nbsp; &nbsp; &nbsp; &nbsp;default "deflate" if
PSTORE_DEFLATE_COMPRESS_<wbr>DEFAULT<br>
&nbsp; &nbsp; &nbsp; &nbsp; default "lzo" if PSTORE_LZO_COMPRESS_DEFAULT<br>
&nbsp; &nbsp; &nbsp; &nbsp; default "lz4" if PSTORE_LZ4_COMPRESS_DEFAULT<br>
&nbsp; &nbsp; &nbsp; &nbsp; default "lz4hc" if PSTORE_LZ4HC_COMPRESS_DEFAULT<br>
diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c<br>
index 06e3b280c3a5..1d40b4588d68 100644<br>
--- a/fs/pstore/platform.c<br>
+++ b/fs/pstore/platform.c<br>
@@ -28,18 +28,13 @@<br>
&nbsp;#include &lt;linux/console.h&gt;<br>
&nbsp;#include &lt;linux/module.h&gt;<br>
&nbsp;#include &lt;linux/pstore.h&gt;<br>
-#ifdef CONFIG_PSTORE_ZLIB_COMPRESS<br>
-#include &lt;linux/zlib.h&gt;<br>
-#endif<br>
&nbsp;#ifdef CONFIG_PSTORE_LZO_COMPRESS<br>
&nbsp;#include &lt;linux/lzo.h&gt;<br>
&nbsp;#endif<br>
&nbsp;#if defined(CONFIG_PSTORE_LZ4_<wbr>COMPRESS) ||
defined(CONFIG_PSTORE_LZ4HC_<wbr>COMPRESS)<br>
&nbsp;#include &lt;linux/lz4.h&gt;<br>
&nbsp;#endif<br>
-#ifdef CONFIG_PSTORE_842_COMPRESS<br>
-#include &lt;linux/sw842.h&gt;<br>
-#endif<br>
+#include &lt;linux/crypto.h&gt;<br>
&nbsp;#include &lt;linux/string.h&gt;<br>
&nbsp;#include &lt;linux/timer.h&gt;<br>
&nbsp;#include &lt;linux/slab.h&gt;<br>
@@ -85,25 +80,10 @@ static char *compress =<br>
&nbsp;#endif<br>
<br>
&nbsp;/* Compression parameters */<br>
-#ifdef CONFIG_PSTORE_ZLIB_COMPRESS<br>
-#define COMPR_LEVEL 6<br>
-#define WINDOW_BITS 12<br>
-#define MEM_LEVEL 4<br>
-static struct z_stream_s stream;<br>
-#endif<br>
-#if defined(CONFIG_PSTORE_LZO_<wbr>COMPRESS)&nbsp; &nbsp;|| \<br>
-&nbsp; &nbsp; defined(CONFIG_PSTORE_LZ4_<wbr>COMPRESS)&nbsp; &nbsp;|| \<br>
-&nbsp; &nbsp; defined(CONFIG_PSTORE_LZ4HC_<wbr>COMPRESS) || \<br>
-&nbsp; &nbsp; defined(CONFIG_PSTORE_842_<wbr>COMPRESS)<br>
-static unsigned char *workspace;<br>
-#endif<br>
+static struct crypto_comp *tfm;<br>
<br>
&nbsp;struct pstore_zbackend {<br>
-&nbsp; &nbsp; &nbsp; &nbsp;int (*compress)(const void *in, void *out,
size_t inlen, size_t outlen);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;int (*decompress)(void *in, void *out,
size_t inlen, size_t outlen);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;void (*allocate)(void);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;void (*free)(void);<br>
-<br>
+&nbsp; &nbsp; &nbsp; &nbsp;int (*zbufsize)(size_t size);<br>
&nbsp; &nbsp; &nbsp; &nbsp; const char *name;<br>
&nbsp;};<br>
<br>
@@ -162,77 +142,12 @@ bool pstore_cannot_block_path(enum
kmsg_dump_reason reason)<br>
&nbsp;}<br>
&nbsp;EXPORT_SYMBOL_GPL(pstore_<wbr>cannot_block_path);<br>
<br>
-#ifdef CONFIG_PSTORE_ZLIB_COMPRESS<br>
-/* Derived from logfs_compress() */<br>
-static int compress_zlib(const void *in, void *out, size_t inlen,
size_t outlen)<br>
+#ifdef CONFIG_PSTORE_DEFLATE_COMPRESS<br>
+static int zbufsize_deflate(size_t size)<br>
&nbsp;{<br>
-&nbsp; &nbsp; &nbsp; &nbsp;int err, ret;<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;ret = -EIO;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;err = zlib_deflateInit2(&amp;stream,
COMPR_LEVEL, Z_DEFLATED, WINDOW_BITS,<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;MEM_LEVEL, Z_DEFAULT_STRATEGY);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;if (err != Z_OK)<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto error;<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;stream.next_in = in;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;stream.avail_in = inlen;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;stream.total_in = 0;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;stream.next_out = out;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;stream.avail_out = outlen;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;stream.total_out = 0;<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;err = zlib_deflate(&amp;stream, Z_FINISH);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;if (err != Z_STREAM_END)<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto error;<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;err = zlib_deflateEnd(&amp;stream);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;if (err != Z_OK)<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto error;<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;if (stream.total_out &gt;= stream.total_in)<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto error;<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;ret = stream.total_out;<br>
-error:<br>
-&nbsp; &nbsp; &nbsp; &nbsp;return ret;<br>
-}<br>
-<br>
-/* Derived from logfs_uncompress */<br>
-static int decompress_zlib(void *in, void *out, size_t inlen, size_t
outlen)<br>
-{<br>
-&nbsp; &nbsp; &nbsp; &nbsp;int err, ret;<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;ret = -EIO;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;err = zlib_inflateInit2(&amp;stream,
WINDOW_BITS);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;if (err != Z_OK)<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto error;<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;stream.next_in = in;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;stream.avail_in = inlen;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;stream.total_in = 0;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;stream.next_out = out;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;stream.avail_out = outlen;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;stream.total_out = 0;<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;err = zlib_inflate(&amp;stream, Z_FINISH);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;if (err != Z_STREAM_END)<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto error;<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;err = zlib_inflateEnd(&amp;stream);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;if (err != Z_OK)<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto error;<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;ret = stream.total_out;<br>
-error:<br>
-&nbsp; &nbsp; &nbsp; &nbsp;return ret;<br>
-}<br>
-<br>
-static void allocate_zlib(void)<br>
-{<br>
-&nbsp; &nbsp; &nbsp; &nbsp;size_t size;<br>
&nbsp; &nbsp; &nbsp; &nbsp; size_t cmpr;<br>
<br>
-&nbsp; &nbsp; &nbsp; &nbsp;switch (psinfo-&gt;bufsize) {<br>
+&nbsp; &nbsp; &nbsp; &nbsp;switch (size) {<br>
&nbsp; &nbsp; &nbsp; &nbsp; /* buffer range for efivars */<br>
&nbsp; &nbsp; &nbsp; &nbsp; case 1000 ... 2000:<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; cmpr = 56;<br>
@@ -252,287 +167,61 @@ static void allocate_zlib(void)<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; break;<br>
&nbsp; &nbsp; &nbsp; &nbsp; }<br>
<br>
-&nbsp; &nbsp; &nbsp; &nbsp;big_oops_buf_sz = (psinfo-&gt;bufsize *
100) / cmpr;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;big_oops_buf = kmalloc(big_oops_buf_sz,
GFP_KERNEL);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;if (big_oops_buf) {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;size =
max(zlib_deflate_<wbr>workspacesize(WINDOW_BITS, MEM_LEVEL),<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;zlib_inflate_workspacesize());<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;stream.workspace = kmalloc(size, GFP_KERNEL);<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if
(!stream.workspace) {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;pr_err("No memory for compression workspace; skipping
compression\n");<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;kfree(big_oops_buf);<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;big_oops_buf = NULL;<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
-&nbsp; &nbsp; &nbsp; &nbsp;} else {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;pr_err("No
memory for uncompressed data; skipping compression\n");<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;stream.workspace = NULL;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;}<br>
-<br>
-}<br>
-<br>
-static void free_zlib(void)<br>
-{<br>
-&nbsp; &nbsp; &nbsp; &nbsp;kfree(stream.workspace);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;stream.workspace = NULL;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;kfree(big_oops_buf);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;big_oops_buf = NULL;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;big_oops_buf_sz = 0;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;return (size * 100) / cmpr;<br>
&nbsp;}<br>
&nbsp;#endif<br>
<br>
&nbsp;#ifdef CONFIG_PSTORE_LZO_COMPRESS<br>
-static int compress_lzo(const void *in, void *out, size_t inlen,
size_t outlen)<br>
+static int zbufsize_lzo(size_t size)<br>
&nbsp;{<br>
-&nbsp; &nbsp; &nbsp; &nbsp;int ret;<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;ret = lzo1x_1_compress(in, inlen, out,
&amp;outlen, workspace);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;if (ret != LZO_E_OK) {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;pr_err("lzo_compress error, ret = %d!\n", ret);<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return -EIO;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;}<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;return outlen;<br>
-}<br>
-<br>
-static int decompress_lzo(void *in, void *out, size_t inlen, size_t outlen)<br>
-{<br>
-&nbsp; &nbsp; &nbsp; &nbsp;int ret;<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;ret = lzo1x_decompress_safe(in, inlen,
out, &amp;outlen);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;if (ret != LZO_E_OK) {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;pr_err("lzo_decompress error, ret = %d!\n", ret);<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return -EIO;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;}<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;return outlen;<br>
-}<br>
-<br>
-static void allocate_lzo(void)<br>
-{<br>
-&nbsp; &nbsp; &nbsp; &nbsp;big_oops_buf_sz =
lzo1x_worst_compress(psinfo-&gt;<wbr>bufsize);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;big_oops_buf = kmalloc(big_oops_buf_sz,
GFP_KERNEL);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;if (big_oops_buf) {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;workspace =
kmalloc(LZO1X_MEM_COMPRESS, GFP_KERNEL);<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (!workspace) {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;pr_err("No memory for compression workspace; skipping
compression\n");<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;kfree(big_oops_buf);<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;big_oops_buf = NULL;<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
-&nbsp; &nbsp; &nbsp; &nbsp;} else {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;pr_err("No
memory for uncompressed data; skipping compression\n");<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;workspace = NULL;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;}<br>
-}<br>
-<br>
-static void free_lzo(void)<br>
-{<br>
-&nbsp; &nbsp; &nbsp; &nbsp;kfree(workspace);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;kfree(big_oops_buf);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;big_oops_buf = NULL;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;big_oops_buf_sz = 0;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;return lzo1x_worst_compress(size);<br>
&nbsp;}<br>
&nbsp;#endif<br>
<br>
&nbsp;#if defined(CONFIG_PSTORE_LZ4_<wbr>COMPRESS) ||
defined(CONFIG_PSTORE_LZ4HC_<wbr>COMPRESS)<br>
-static int decompress_lz4(void *in, void *out, size_t inlen, size_t outlen)<br>
-{<br>
-&nbsp; &nbsp; &nbsp; &nbsp;int ret;<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;ret = LZ4_decompress_safe(in, out, inlen,
outlen);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;if (ret &lt; 0) {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; *
LZ4_decompress_safe will return an error code<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * (&lt; 0) if
decompression failed<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; */<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;pr_err("LZ4_decompress_safe error, ret = %d!\n", ret);<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return -EIO;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;}<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;return ret;<br>
-}<br>
-<br>
-static void free_lz4(void)<br>
-{<br>
-&nbsp; &nbsp; &nbsp; &nbsp;kfree(workspace);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;kfree(big_oops_buf);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;big_oops_buf = NULL;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;big_oops_buf_sz = 0;<br>
-}<br>
-#endif<br>
-<br>
-#ifdef CONFIG_PSTORE_LZ4_COMPRESS<br>
-static int compress_lz4(const void *in, void *out, size_t inlen,
size_t outlen)<br>
-{<br>
-&nbsp; &nbsp; &nbsp; &nbsp;int ret;<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;ret = LZ4_compress_default(in, out, inlen,
outlen, workspace);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;if (!ret) {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;pr_err("LZ4_compress_default error; compression failed!\n");<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return -EIO;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;}<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;return ret;<br>
-}<br>
-<br>
-static void allocate_lz4(void)<br>
-{<br>
-&nbsp; &nbsp; &nbsp; &nbsp;big_oops_buf_sz =
LZ4_compressBound(psinfo-&gt;<wbr>bufsize);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;big_oops_buf = kmalloc(big_oops_buf_sz,
GFP_KERNEL);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;if (big_oops_buf) {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;workspace =
kmalloc(LZ4_MEM_COMPRESS, GFP_KERNEL);<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (!workspace) {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;pr_err("No memory for compression workspace; skipping
compression\n");<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;kfree(big_oops_buf);<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;big_oops_buf = NULL;<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
-&nbsp; &nbsp; &nbsp; &nbsp;} else {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;pr_err("No
memory for uncompressed data; skipping compression\n");<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;workspace = NULL;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;}<br>
-}<br>
-#endif<br>
-<br>
-#ifdef CONFIG_PSTORE_LZ4HC_COMPRESS<br>
-static int compress_lz4hc(const void *in, void *out,<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;size_t inlen, size_t outlen)<br>
+static int zbufsize_lz4(size_t size)<br>
&nbsp;{<br>
-&nbsp; &nbsp; &nbsp; &nbsp;int ret;<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;ret = LZ4_compress_HC(in, out, inlen, outlen,<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;LZ4HC_DEFAULT_CLEVEL,
workspace);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;if (!ret) {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;pr_err("LZ4_compress_HC error; compression failed!\n");<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return -EIO;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;}<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;return ret;<br>
-}<br>
-<br>
-static void allocate_lz4hc(void)<br>
-{<br>
-&nbsp; &nbsp; &nbsp; &nbsp;big_oops_buf_sz =
LZ4_compressBound(psinfo-&gt;<wbr>bufsize);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;big_oops_buf = kmalloc(big_oops_buf_sz,
GFP_KERNEL);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;if (big_oops_buf) {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;workspace =
kmalloc(LZ4HC_MEM_COMPRESS, GFP_KERNEL);<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (!workspace) {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;pr_err("No memory for compression workspace; skipping
compression\n");<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;kfree(big_oops_buf);<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;big_oops_buf = NULL;<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
-&nbsp; &nbsp; &nbsp; &nbsp;} else {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;pr_err("No
memory for uncompressed data; skipping compression\n");<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;workspace = NULL;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;}<br>
+&nbsp; &nbsp; &nbsp; &nbsp;return LZ4_compressBound(size);<br>
&nbsp;}<br>
&nbsp;#endif<br>
<br>
&nbsp;#ifdef CONFIG_PSTORE_842_COMPRESS<br>
-static int compress_842(const void *in, void *out, size_t inlen,
size_t outlen)<br>
-{<br>
-&nbsp; &nbsp; &nbsp; &nbsp;int ret;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;unsigned int size;<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;if (outlen &gt; UINT_MAX)<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return -EIO;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;size = outlen;<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;ret = sw842_compress(in, inlen, out,
&amp;size, workspace);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;if (ret) {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;pr_err("sw842_compress error; compression failed!\n");<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return ret;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;}<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;return size;<br>
-}<br>
-<br>
-static int decompress_842(void *in, void *out, size_t inlen, size_t outlen)<br>
+static int zbufsize_842(size_t size)<br>
&nbsp;{<br>
-&nbsp; &nbsp; &nbsp; &nbsp;int ret;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;unsigned int size;<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;if (outlen &gt; UINT_MAX)<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return -EIO;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;size = outlen;<br>
-<br>
-&nbsp; &nbsp; &nbsp; &nbsp;ret = sw842_decompress(in, inlen, out,
&amp;size);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;if (ret) {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;pr_err("sw842_decompress error, ret = %d!\n", ret);<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return ret;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;}<br>
-<br>
&nbsp; &nbsp; &nbsp; &nbsp; return size;<br>
&nbsp;}<br>
-<br>
-static void allocate_842(void)<br>
-{<br>
-&nbsp; &nbsp; &nbsp; &nbsp;big_oops_buf_sz = psinfo-&gt;bufsize;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;big_oops_buf = kmalloc(big_oops_buf_sz,
GFP_KERNEL);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;if (big_oops_buf) {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;workspace =
kmalloc(SW842_MEM_COMPRESS, GFP_KERNEL);<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (!workspace) {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;kfree(big_oops_buf);<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;big_oops_buf = NULL;<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
-&nbsp; &nbsp; &nbsp; &nbsp;} else {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;pr_err("No
memory for uncompressed data; skipping compression\n");<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;workspace = NULL;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;}<br>
-}<br>
-<br>
-static void free_842(void)<br>
-{<br>
-&nbsp; &nbsp; &nbsp; &nbsp;kfree(workspace);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;kfree(big_oops_buf);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;big_oops_buf = NULL;<br>
-&nbsp; &nbsp; &nbsp; &nbsp;big_oops_buf_sz = 0;<br>
-}<br>
&nbsp;#endif<br>
<br>
&nbsp;static const struct pstore_zbackend *zbackend __ro_after_init;<br>
<br>
&nbsp;static const struct pstore_zbackend zbackends[] = {<br>
-#ifdef CONFIG_PSTORE_ZLIB_COMPRESS<br>
+#ifdef CONFIG_PSTORE_DEFLATE_COMPRESS<br>
&nbsp; &nbsp; &nbsp; &nbsp; {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;.compress&nbsp; &nbsp; &nbsp; &nbsp;= compress_zlib,<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;.decompress&nbsp; &nbsp; &nbsp;= decompress_zlib,<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;.allocate&nbsp; &nbsp; &nbsp; &nbsp;= allocate_zlib,<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;.free&nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;= free_zlib,<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;.name&nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;= "zlib",<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;.zbufsize&nbsp; &nbsp; &nbsp; &nbsp;= zbufsize_deflate,<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;.name&nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;= "deflate",<br>
&nbsp; &nbsp; &nbsp; &nbsp; },<br>
&nbsp;#endif<br>
&nbsp;#ifdef CONFIG_PSTORE_LZO_COMPRESS<br>
&nbsp; &nbsp; &nbsp; &nbsp; {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;.compress&nbsp; &nbsp; &nbsp; &nbsp;= compress_lzo,<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;.decompress&nbsp; &nbsp; &nbsp;= decompress_lzo,<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;.allocate&nbsp; &nbsp; &nbsp; &nbsp;= allocate_lzo,<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;.free&nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;= free_lzo,<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;.zbufsize&nbsp; &nbsp; &nbsp; &nbsp;= zbufsize_lzo,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; .name&nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;= "lzo",<br>
&nbsp; &nbsp; &nbsp; &nbsp; },<br>
&nbsp;#endif<br>
&nbsp;#ifdef CONFIG_PSTORE_LZ4_COMPRESS<br>
&nbsp; &nbsp; &nbsp; &nbsp; {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;.compress&nbsp; &nbsp; &nbsp; &nbsp;= compress_lz4,<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;.decompress&nbsp; &nbsp; &nbsp;= decompress_lz4,<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;.allocate&nbsp; &nbsp; &nbsp; &nbsp;= allocate_lz4,<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;.free&nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;= free_lz4,<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;.zbufsize&nbsp; &nbsp; &nbsp; &nbsp;= zbufsize_lz4,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; .name&nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;= "lz4",<br>
&nbsp; &nbsp; &nbsp; &nbsp; },<br>
&nbsp;#endif<br>
&nbsp;#ifdef CONFIG_PSTORE_LZ4HC_COMPRESS<br>
&nbsp; &nbsp; &nbsp; &nbsp; {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;.compress&nbsp; &nbsp; &nbsp; &nbsp;= compress_lz4hc,<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;.decompress&nbsp; &nbsp; &nbsp;= decompress_lz4,<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;.allocate&nbsp; &nbsp; &nbsp; &nbsp;= allocate_lz4hc,<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;.free&nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;= free_lz4,<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;.zbufsize&nbsp; &nbsp; &nbsp; &nbsp;= zbufsize_lz4,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; .name&nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;= "lz4hc",<br>
&nbsp; &nbsp; &nbsp; &nbsp; },<br>
&nbsp;#endif<br>
&nbsp;#ifdef CONFIG_PSTORE_842_COMPRESS<br>
&nbsp; &nbsp; &nbsp; &nbsp; {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;.compress&nbsp; &nbsp; &nbsp; &nbsp;= compress_842,<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;.decompress&nbsp; &nbsp; &nbsp;= decompress_842,<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;.allocate&nbsp; &nbsp; &nbsp; &nbsp;= allocate_842,<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;.free&nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;= free_842,<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;.zbufsize&nbsp; &nbsp; &nbsp; &nbsp;= zbufsize_842,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; .name&nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;= "842",<br>
&nbsp; &nbsp; &nbsp; &nbsp; },<br>
&nbsp;#endif<br>
@@ -540,37 +229,65 @@ static const struct pstore_zbackend zbackends[] = {<br>
&nbsp;};<br>
<br>
&nbsp;static int pstore_compress(const void *in, void *out,<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; size_t inlen, size_t outlen)<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; unsigned int inlen, unsigned int outlen)<br>
&nbsp;{<br>
-&nbsp; &nbsp; &nbsp; &nbsp;if (zbackend)<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return
zbackend-&gt;compress(in, out, inlen, outlen);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;else<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return -EIO;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;int ret;<br>
+<br>
+&nbsp; &nbsp; &nbsp; &nbsp;ret = crypto_comp_compress(tfm, in, inlen,
out, &amp;outlen);<br>
+&nbsp; &nbsp; &nbsp; &nbsp;if (ret) {<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;pr_err("crypto_comp_compress failed, ret = %d!\n", ret);<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return ret;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;}<br>
+<br>
+&nbsp; &nbsp; &nbsp; &nbsp;return outlen;<br>
&nbsp;}<br>
<br>
-static int pstore_decompress(void *in, void *out, size_t inlen,
size_t outlen)<br>
+static int pstore_decompress(void *in, void *out,<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; unsigned int inlen, unsigned int
outlen)<br>
&nbsp;{<br>
-&nbsp; &nbsp; &nbsp; &nbsp;if (zbackend)<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return
zbackend-&gt;decompress(in, out, inlen, outlen);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;else<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return -EIO;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;int ret;<br>
+<br>
+&nbsp; &nbsp; &nbsp; &nbsp;ret = crypto_comp_decompress(tfm, in,
inlen, out, &amp;outlen);<br>
+&nbsp; &nbsp; &nbsp; &nbsp;if (ret) {<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;pr_err("crypto_comp_decompress failed, ret = %d!\n", ret);<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return ret;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;}<br>
+<br>
+&nbsp; &nbsp; &nbsp; &nbsp;return outlen;<br>
&nbsp;}<br>
<br>
&nbsp;static void allocate_buf_for_compression(<wbr>void)<br>
&nbsp;{<br>
-&nbsp; &nbsp; &nbsp; &nbsp;if (zbackend) {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;zbackend-&gt;allocate();<br>
-&nbsp; &nbsp; &nbsp; &nbsp;} else {<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;pr_err("allocate compression buffer error!\n");<br>
+&nbsp; &nbsp; &nbsp; &nbsp;if (!zbackend)<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return;<br>
+<br>
+&nbsp; &nbsp; &nbsp; &nbsp;if
(!crypto_has_comp(zbackend-&gt;<wbr>name, 0, 0)) {<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;pr_err("No %s
compression\n", zbackend-&gt;name);<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;}<br>
+<br>
+&nbsp; &nbsp; &nbsp; &nbsp;big_oops_buf_sz =
zbackend-&gt;zbufsize(psinfo-&gt;<wbr>bufsize);<br>
+&nbsp; &nbsp; &nbsp; &nbsp;if (big_oops_buf_sz &lt;= 0)<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return;<br>
+<br>
+&nbsp; &nbsp; &nbsp; &nbsp;big_oops_buf = kmalloc(big_oops_buf_sz,
GFP_KERNEL);<br>
+&nbsp; &nbsp; &nbsp; &nbsp;if (!big_oops_buf)<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return;<br>
+<br>
+&nbsp; &nbsp; &nbsp; &nbsp;tfm =
crypto_alloc_comp(zbackend-&gt;<wbr>name, 0, 0);<br>
+&nbsp; &nbsp; &nbsp; &nbsp;if (IS_ERR_OR_NULL(tfm)) {<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;kfree(big_oops_buf);<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;big_oops_buf = NULL;<br>
&nbsp; &nbsp; &nbsp; &nbsp; }<br>
&nbsp;}<br>
<br>
&nbsp;static void free_buf_for_compression(void)<br>
&nbsp;{<br>
-&nbsp; &nbsp; &nbsp; &nbsp;if (zbackend)<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;zbackend-&gt;free();<br>
-&nbsp; &nbsp; &nbsp; &nbsp;else<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;pr_err("free
compression buffer error!\n");<br>
+&nbsp; &nbsp; &nbsp; &nbsp;if (!IS_ERR_OR_NULL(tfm))<br>
+&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;crypto_free_comp(tfm);<br>
+&nbsp; &nbsp; &nbsp; &nbsp;kfree(big_oops_buf);<br>
+&nbsp; &nbsp; &nbsp; &nbsp;big_oops_buf = NULL;<br>
+&nbsp; &nbsp; &nbsp; &nbsp;big_oops_buf_sz = 0;<br>
&nbsp;}<br>
<br>
&nbsp;/*<br>
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c<br>
index 7125b398d312..49b2bc114868 100644<br>
--- a/fs/pstore/ram.c<br>
+++ b/fs/pstore/ram.c<br>
@@ -938,7 +938,7 @@ static int __init ramoops_init(void)<br>
&nbsp; &nbsp; &nbsp; &nbsp; ramoops_register_dummy();<br>
&nbsp; &nbsp; &nbsp; &nbsp; return
platform_driver_register(&amp;<wbr>ramoops_driver);<br>
&nbsp;}<br>
-postcore_initcall(ramoops_<wbr>init);<br>
+late_initcall(ramoops_init);<br>
<br>
&nbsp;static void __exit ramoops_exit(void)<br>
&nbsp;{<br>
<span class="HOEnZb"><font color="#888888">--<br>
2.14.1<br>
<br>
</font></span></blockquote></div><br><br clear="all"><div><br></div>--
<br><div class="gmail_signature" data-smartmail="gmail_signature">Kees
Cook<br>Pixel Security</div>
</div>
