Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4/iDDH+1bk1U3k2+kMgC9SPy0/U49DfEByaZ+apoupZCKLJTjA86l4JgJFOpN9t4jHe1Nh1
ARC-Seal: i=1; a=rsa-sha256; t=1524505945; cv=none;
        d=google.com; s=arc-20160816;
        b=ICQhkK8ykZCGy+rgi1j4p4A3i0gg0ZflEX7+j26TVeFQdpb+PNrVeNWgqjga8X90w0
         QGIfl+o9AsikGCpwSxkpXDRbEJqcT5Zgg1xdO5HR0DHez6aXSIE7k4t7XYJEzFOj6AGw
         zONDP8ZXMBgenS65csm3Mc3AzgCnr/cMJUbbD9x9tUogfXB6WDjnw3hVQUts8+58Vg+1
         mmXXKuar6LV1szjpkiFzAKUDjKTY/M3vhjGdYo2TbotckTO2/OtrAmTJOPSqHasLjBtU
         pMwrjkW72+oVdxzvlQ6Peo5mfSLw2HeZ06y2nN445K031fNLMOrhOJnN7rQM/gIHokLz
         8O2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=jckneIoacGVntR9LPy8FVNa4eYpDoxYDg1fyZYH8A9w=;
        b=oR1Yli9TrLYjrQTkNDHja+sMIGqkFjAh5nZ9QXpYZbrjlrAJk6TgBTU4xg7FTliQl/
         cO3xgQOJPHT9Lu/UQjmCKxFhBhAC9eANdwD5Vr4HbvM3c7mRpgKflLlz2ROAeW7FVI29
         ERsXXKUONqGYFQFqepIJuJTDgtQ86IbXkDtc4xHP5Wq8CSfXGKsyMlUAOAdkVfesE/mt
         CTxZ7scO67FXraaMz6UqLB96chQnVDtocW5MFbL4YK2N+fhAZfZfShEWfQQgz6HP+SPR
         PI7gA8vAI8YFHRSd1btuFzvDdM01TJFLg0Qg1XQJqCZm2uKWQaYF2w1e4LR8o6b0nSp6
         tNlw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932349AbeDWRwY (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 23 Apr 2018 13:52:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47446 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932204AbeDWRwX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Apr 2018 13:52:23 -0400
Date: Mon, 23 Apr 2018 19:52:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tom Hromatka <tom.hromatka@oracle.com>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, allen.pais@oracle.com,
        khalid.aziz@oracle.com, shannon.nelson@oracle.com,
        anthony.yznaga@oracle.com
Subject: Re: [PATCH v5 1/2] char: sparc64: Add privileged ADI driver
Message-ID: <20180423175216.GA16904@kroah.com>
References: <20180423173332.561489-1-tom.hromatka@oracle.com>
 <20180423173332.561489-2-tom.hromatka@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423173332.561489-2-tom.hromatka@oracle.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598559168608761030?=
X-GMAIL-MSGID: =?utf-8?q?1598560346315197174?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 11:33:31AM -0600, Tom Hromatka wrote:
> SPARC M7 and newer processors utilize ADI to version and
> protect memory.  This driver is capable of reading/writing
> ADI/MCD versions from privileged user space processes.
> Addresses in the adi file are mapped linearly to physical
> memory at a ratio of 1:adi_blksz.  Thus, a read (or write)
> of offset K in the file operates upon the ADI version at
> physical address K * adi_blksz.  The version information
> is encoded as one version per byte.  Intended consumers
> are makedumpfile and crash.

What do you mean by "crash"?  Should this tie into the pstore
infrastructure, or is this just a userspace thing?  Just curious.

Minor code comments below now that the license stuff is correct, I
decided to read the code :)

> +#include <linux/kernel.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/proc_fs.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <asm/asi.h>
> +
> +#define MODULE_NAME	"adi"

What's wrong with KBUILD_MODNAME?  Just use that instead of MODULE_NAME
later on in the file.

> +#define MAX_BUF_SZ	4096

PAGE_SIZE?  Just curious.

> +
> +static int adi_open(struct inode *inode, struct file *file)
> +{
> +	file->f_mode |= FMODE_UNSIGNED_OFFSET;

That's odd, why?

> +	return 0;
> +}
> +
> +static int read_mcd_tag(unsigned long addr)
> +{
> +	long err;
> +	int ver;
> +
> +	__asm__ __volatile__(
> +		"1:	ldxa [%[addr]] %[asi], %[ver]\n"
> +		"	mov 0, %[err]\n"
> +		"2:\n"
> +		"	.section .fixup,#alloc,#execinstr\n"
> +		"	.align 4\n"
> +		"3:	sethi %%hi(2b), %%g1\n"
> +		"	jmpl  %%g1 + %%lo(2b), %%g0\n"
> +		"	mov %[invalid], %[err]\n"
> +		"	.previous\n"
> +		"	.section __ex_table, \"a\"\n"
> +		"	.align 4\n"
> +		"	.word  1b, 3b\n"
> +		"	.previous\n"
> +		: [ver] "=r" (ver), [err] "=r" (err)
> +		: [addr] "r"  (addr), [invalid] "i" (EFAULT),
> +		  [asi] "i" (ASI_MCD_REAL)
> +		: "memory", "g1"
> +		);
> +
> +	if (err)
> +		return -EFAULT;
> +	else
> +		return ver;
> +}
> +
> +static ssize_t adi_read(struct file *file, char __user *buf,
> +			size_t count, loff_t *offp)
> +{
> +	size_t ver_buf_sz, bytes_read = 0;
> +	int ver_buf_idx = 0;
> +	loff_t offset;
> +	u8 *ver_buf;
> +	ssize_t ret;
> +
> +	ver_buf_sz = min_t(size_t, count, MAX_BUF_SZ);
> +	ver_buf = kmalloc(ver_buf_sz, GFP_KERNEL);
> +	if (!ver_buf)
> +		return -ENOMEM;
> +
> +	offset = (*offp) * adi_blksize();
> +
> +	while (bytes_read < count) {
> +		ret = read_mcd_tag(offset);
> +		if (ret < 0)
> +			goto out;
> +
> +		ver_buf[ver_buf_idx] = (u8)ret;

Are you sure ret fits in 8 bits here?

> +		ver_buf_idx++;
> +		offset += adi_blksize();
> +
> +		if (ver_buf_idx >= ver_buf_sz) {
> +			if (copy_to_user(buf + bytes_read, ver_buf,
> +					 ver_buf_sz)) {
> +				ret = -EFAULT;
> +				goto out;
> +			}
> +
> +			bytes_read += ver_buf_sz;
> +			ver_buf_idx = 0;
> +
> +			ver_buf_sz = min(count - bytes_read,
> +					 (size_t)MAX_BUF_SZ);
> +		}
> +	}
> +
> +	(*offp) += bytes_read;
> +	ret = bytes_read;
> +out:
> +	kfree(ver_buf);
> +	return ret;
> +}
> +
> +static int set_mcd_tag(unsigned long addr, u8 ver)
> +{
> +	long err;
> +
> +	__asm__ __volatile__(
> +		"1:	stxa %[ver], [%[addr]] %[asi]\n"
> +		"	mov 0, %[err]\n"
> +		"2:\n"
> +		"	.section .fixup,#alloc,#execinstr\n"
> +		"	.align 4\n"
> +		"3:	sethi %%hi(2b), %%g1\n"
> +		"	jmpl %%g1 + %%lo(2b), %%g0\n"
> +		"	mov %[invalid], %[err]\n"
> +		"	.previous\n"
> +		"	.section __ex_table, \"a\"\n"
> +		"	.align 4\n"
> +		"	.word 1b, 3b\n"
> +		"	.previous\n"
> +		: [err] "=r" (err)
> +		: [ver] "r" (ver), [addr] "r"  (addr),
> +		  [invalid] "i" (EFAULT), [asi] "i" (ASI_MCD_REAL)
> +		: "memory", "g1"
> +		);
> +
> +	if (err)
> +		return -EFAULT;
> +	else
> +		return ver;
> +}
> +
> +static ssize_t adi_write(struct file *file, const char __user *buf,
> +			 size_t count, loff_t *offp)
> +{
> +	size_t ver_buf_sz, bytes_written = 0;
> +	loff_t offset;
> +	u8 *ver_buf;
> +	ssize_t ret;
> +	int i;
> +
> +	if (count <= 0)
> +		return -EINVAL;
> +
> +	ver_buf_sz = min_t(size_t, count, MAX_BUF_SZ);
> +	ver_buf = kmalloc(ver_buf_sz, (size_t)GFP_KERNEL);

(size_t) for GFP_KERNEL?  That's really odd looking.

> +	if (!ver_buf)
> +		return -ENOMEM;
> +
> +	offset = (*offp) * adi_blksize();
> +
> +	do {
> +		if (copy_from_user(ver_buf, &buf[bytes_written],
> +				   ver_buf_sz)) {
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +
> +		for (i = 0; i < ver_buf_sz; i++) {
> +			ret = set_mcd_tag(offset, ver_buf[i]);
> +			if (ret < 0)
> +				goto out;
> +
> +			offset += adi_blksize();
> +		}
> +
> +		bytes_written += ver_buf_sz;
> +		ver_buf_sz = min(count - bytes_written, (size_t)MAX_BUF_SZ);
> +	} while (bytes_written < count);
> +
> +	(*offp) += bytes_written;
> +	ret = bytes_written;
> +out:
> +	__asm__ __volatile__("membar #Sync");
> +	kfree(ver_buf);
> +	return ret;
> +}
> +
> +static loff_t adi_llseek(struct file *file, loff_t offset, int whence)
> +{
> +	loff_t ret = -EINVAL;
> +
> +	switch (whence) {
> +	case SEEK_END:
> +	case SEEK_DATA:
> +	case SEEK_HOLE:
> +		/* unsupported */
> +		return -EINVAL;
> +	case SEEK_CUR:
> +		if (offset == 0)
> +			return file->f_pos;
> +
> +		offset += file->f_pos;
> +		break;
> +	case SEEK_SET:
> +		break;
> +	}
> +
> +	if (offset != file->f_pos) {
> +		file->f_pos = offset;
> +		file->f_version = 0;
> +		ret = offset;
> +	}
> +
> +	return ret;
> +}

Why can't you use default_llseek here?  Why do you not allow HOLE and
others?

Anyway, just tiny questions, all are trivial and not really a big deal
if you have tested it on your hardware.  I'm guessing this will go
through the SPARC tree?  If so feel free to add:

	Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Or if you want/need me to take it through my char/misc tree, just let me
know and I can.

thanks,

greg k-h
