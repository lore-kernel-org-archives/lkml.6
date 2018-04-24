Return-Path: <tom.hromatka@oracle.com>
X-Google-Smtp-Source: AB8JxZopBX4li0+g0I5QMn8KNEcMvdLUioAWeEiB+sxNZl6PT2ZZB2qAQxjeHByfXUaqeegiPikn
ARC-Seal: i=1; a=rsa-sha256; t=1524588482; cv=none;
        d=google.com; s=arc-20160816;
        b=QDo/Qx4RUmAeGHeB+LRl14DlJ0xbBAuGJxXv5w7wnqkcKvvfu45gJgRjWxaJL22s4/
         Yj+8KTfVYvfrvNH/XhS1iesCyWbzfn+jEBkOSsoQDzXBnQIiC8etMDSTrt/esFuxsKyC
         EMtQVG8eIIBjR9EP1bn/Qy3Y2KVA/QNSQaPJIZ/Ui3GLAnSpxve+d+lX5Fvip9XKdmWz
         as78neTIA16DzZv8xcsHVMdshtSpvTjT2xrYZyKKOf4q+m30GS1LaRlc41Jqfb9T+Yit
         Ji8YGmdVLNvfozbjzPa+Mkm87NHkMJZ/2qrb39+enhN3qwOv61CA8t3UqIxhw9DMNgXx
         mWDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=sgAoKI7rL8T3O0ELoo5jVpQGuSBjrzAuRjafa8k4bgA=;
        b=Fse5R1yH/ZMx6OV8szzIqSqHO6JuOcISeFJW4ERYHDtTs/wdqhWLMOcjUdorNlQd1t
         TDB2EbUMWwhUCdU64/bapeG/wYEbJyhDbe7IHiJLnM2+mdCpLryDrUh+J2vOSOsDpcYO
         tO19KjXEcMLrRDjh9Hf9f8ThUIhmXsyCYIlvyY0eu1nk7235ymbTe9Imc5eNJaF9Qg3w
         u8fH6+NZEGSYcB68e8nDFO2ivOvA5Z/eGlEIcIQRWopMMsJcZnJBazpGwE+KEtUkayjM
         qQGElq3uAzwE223dhwiBRtX3hGd1TOiBCYYC3T3abEqMJ4omKYXDoV/m5XYgYpTnERH4
         /ecg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=KCI2pZws;
       spf=pass (google.com: domain of tom.hromatka@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=tom.hromatka@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=KCI2pZws;
       spf=pass (google.com: domain of tom.hromatka@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=tom.hromatka@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Subject: Re: [PATCH v5 1/2] char: sparc64: Add privileged ADI driver
To: Greg KH <gregkh@linuxfoundation.org>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, allen.pais@oracle.com,
        khalid.aziz@oracle.com, shannon.nelson@oracle.com,
        anthony.yznaga@oracle.com
References: <20180423173332.561489-1-tom.hromatka@oracle.com>
 <20180423173332.561489-2-tom.hromatka@oracle.com>
 <20180423175216.GA16904@kroah.com>
From: Tom Hromatka <tom.hromatka@oracle.com>
Message-ID: <3648cb70-c5a0-c316-4e61-93c533ea0bcc@oracle.com>
Date: Tue, 24 Apr 2018 10:47:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423175216.GA16904@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8873 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804240160
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598559168608761030?=
X-GMAIL-MSGID: =?utf-8?q?1598646892650719586?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 04/23/2018 11:52 AM, Greg KH wrote:
> On Mon, Apr 23, 2018 at 11:33:31AM -0600, Tom Hromatka wrote:
>> SPARC M7 and newer processors utilize ADI to version and
>> protect memory.  This driver is capable of reading/writing
>> ADI/MCD versions from privileged user space processes.
>> Addresses in the adi file are mapped linearly to physical
>> memory at a ratio of 1:adi_blksz.  Thus, a read (or write)
>> of offset K in the file operates upon the ADI version at
>> physical address K * adi_blksz.  The version information
>> is encoded as one version per byte.  Intended consumers
>> are makedumpfile and crash.
> What do you mean by "crash"?  Should this tie into the pstore
> infrastructure, or is this just a userspace thing?  Just curious.

My apologies.  I was referring to the crash utility:
https://github.com/crash-utility/crash

A future commit to store the ADI versions to the pstore would be
really cool.  I am fearful the amount of ADI data could overwhelm
the pstore, though.  The latest sparc machines support 4 TB of RAM
which could mean several GBs of ADI versions.  But storing the ADI
versions pertaining to the failing code should be possible.  I need
to do more research...

>
> Minor code comments below now that the license stuff is correct, I
> decided to read the code :)

:)

>> +#include <linux/kernel.h>
>> +#include <linux/miscdevice.h>
>> +#include <linux/module.h>
>> +#include <linux/proc_fs.h>
>> +#include <linux/slab.h>
>> +#include <linux/uaccess.h>
>> +#include <asm/asi.h>
>> +
>> +#define MODULE_NAME	"adi"
> What's wrong with KBUILD_MODNAME?  Just use that instead of MODULE_NAME
> later on in the file.

Good catch.  I'll do that in the next rev of this patch.

>> +#define MAX_BUF_SZ	4096
> PAGE_SIZE?  Just curious.

When a user requests a large read/write in makedumpfile or the crash
utility, these tools typically make requests in 4096-sized chunks.
I believe you are correct that these operations are based upon page
size, but I have not verified.  I was hesitant to connect MAX_BUF_SZ to
PAGE_SIZE without this verification.  I'll look into it more...

>> +
>> +static int adi_open(struct inode *inode, struct file *file)
>> +{
>> +	file->f_mode |= FMODE_UNSIGNED_OFFSET;
> That's odd, why?

sparc64 currently supports 4 TB of RAM (and could support much more in the
future).  Offsets into this ADI privileged driver are address / 64, but
that could change also in the future depending upon cache line sizes.  I
was afraid that future sparc systems could have very large file offsets.
Overkill?

>
>> +	return 0;
>> +}
>> +
>> +static int read_mcd_tag(unsigned long addr)
>> +{
>> +	long err;
>> +	int ver;
>> +
>> +	__asm__ __volatile__(
>> +		"1:	ldxa [%[addr]] %[asi], %[ver]\n"
>> +		"	mov 0, %[err]\n"
>> +		"2:\n"
>> +		"	.section .fixup,#alloc,#execinstr\n"
>> +		"	.align 4\n"
>> +		"3:	sethi %%hi(2b), %%g1\n"
>> +		"	jmpl  %%g1 + %%lo(2b), %%g0\n"
>> +		"	mov %[invalid], %[err]\n"
>> +		"	.previous\n"
>> +		"	.section __ex_table, \"a\"\n"
>> +		"	.align 4\n"
>> +		"	.word  1b, 3b\n"
>> +		"	.previous\n"
>> +		: [ver] "=r" (ver), [err] "=r" (err)
>> +		: [addr] "r"  (addr), [invalid] "i" (EFAULT),
>> +		  [asi] "i" (ASI_MCD_REAL)
>> +		: "memory", "g1"
>> +		);
>> +
>> +	if (err)
>> +		return -EFAULT;
>> +	else
>> +		return ver;
>> +}
>> +
>> +static ssize_t adi_read(struct file *file, char __user *buf,
>> +			size_t count, loff_t *offp)
>> +{
>> +	size_t ver_buf_sz, bytes_read = 0;
>> +	int ver_buf_idx = 0;
>> +	loff_t offset;
>> +	u8 *ver_buf;
>> +	ssize_t ret;
>> +
>> +	ver_buf_sz = min_t(size_t, count, MAX_BUF_SZ);
>> +	ver_buf = kmalloc(ver_buf_sz, GFP_KERNEL);
>> +	if (!ver_buf)
>> +		return -ENOMEM;
>> +
>> +	offset = (*offp) * adi_blksize();
>> +
>> +	while (bytes_read < count) {
>> +		ret = read_mcd_tag(offset);
>> +		if (ret < 0)
>> +			goto out;
>> +
>> +		ver_buf[ver_buf_idx] = (u8)ret;
> Are you sure ret fits in 8 bits here?

Yes, I believe so.  read_mcd_tag() will return a negative number
on an error - which is checked a couple lines above.  Otherwise,
the read succeeded which means a valid ADI version was returned.
Valid ADI versions are 0 through 16.

>> +		ver_buf_idx++;
>> +		offset += adi_blksize();
>> +
>> +		if (ver_buf_idx >= ver_buf_sz) {
>> +			if (copy_to_user(buf + bytes_read, ver_buf,
>> +					 ver_buf_sz)) {
>> +				ret = -EFAULT;
>> +				goto out;
>> +			}
>> +
>> +			bytes_read += ver_buf_sz;
>> +			ver_buf_idx = 0;
>> +
>> +			ver_buf_sz = min(count - bytes_read,
>> +					 (size_t)MAX_BUF_SZ);
>> +		}
>> +	}
>> +
>> +	(*offp) += bytes_read;
>> +	ret = bytes_read;
>> +out:
>> +	kfree(ver_buf);
>> +	return ret;
>> +}
>> +
>> +static int set_mcd_tag(unsigned long addr, u8 ver)
>> +{
>> +	long err;
>> +
>> +	__asm__ __volatile__(
>> +		"1:	stxa %[ver], [%[addr]] %[asi]\n"
>> +		"	mov 0, %[err]\n"
>> +		"2:\n"
>> +		"	.section .fixup,#alloc,#execinstr\n"
>> +		"	.align 4\n"
>> +		"3:	sethi %%hi(2b), %%g1\n"
>> +		"	jmpl %%g1 + %%lo(2b), %%g0\n"
>> +		"	mov %[invalid], %[err]\n"
>> +		"	.previous\n"
>> +		"	.section __ex_table, \"a\"\n"
>> +		"	.align 4\n"
>> +		"	.word 1b, 3b\n"
>> +		"	.previous\n"
>> +		: [err] "=r" (err)
>> +		: [ver] "r" (ver), [addr] "r"  (addr),
>> +		  [invalid] "i" (EFAULT), [asi] "i" (ASI_MCD_REAL)
>> +		: "memory", "g1"
>> +		);
>> +
>> +	if (err)
>> +		return -EFAULT;
>> +	else
>> +		return ver;
>> +}
>> +
>> +static ssize_t adi_write(struct file *file, const char __user *buf,
>> +			 size_t count, loff_t *offp)
>> +{
>> +	size_t ver_buf_sz, bytes_written = 0;
>> +	loff_t offset;
>> +	u8 *ver_buf;
>> +	ssize_t ret;
>> +	int i;
>> +
>> +	if (count <= 0)
>> +		return -EINVAL;
>> +
>> +	ver_buf_sz = min_t(size_t, count, MAX_BUF_SZ);
>> +	ver_buf = kmalloc(ver_buf_sz, (size_t)GFP_KERNEL);
> (size_t) for GFP_KERNEL?  That's really odd looking.

Agreed.  Good find.

>
>> +	if (!ver_buf)
>> +		return -ENOMEM;
>> +
>> +	offset = (*offp) * adi_blksize();
>> +
>> +	do {
>> +		if (copy_from_user(ver_buf, &buf[bytes_written],
>> +				   ver_buf_sz)) {
>> +			ret = -EFAULT;
>> +			goto out;
>> +		}
>> +
>> +		for (i = 0; i < ver_buf_sz; i++) {
>> +			ret = set_mcd_tag(offset, ver_buf[i]);
>> +			if (ret < 0)
>> +				goto out;
>> +
>> +			offset += adi_blksize();
>> +		}
>> +
>> +		bytes_written += ver_buf_sz;
>> +		ver_buf_sz = min(count - bytes_written, (size_t)MAX_BUF_SZ);
>> +	} while (bytes_written < count);
>> +
>> +	(*offp) += bytes_written;
>> +	ret = bytes_written;
>> +out:
>> +	__asm__ __volatile__("membar #Sync");
>> +	kfree(ver_buf);
>> +	return ret;
>> +}
>> +
>> +static loff_t adi_llseek(struct file *file, loff_t offset, int whence)
>> +{
>> +	loff_t ret = -EINVAL;
>> +
>> +	switch (whence) {
>> +	case SEEK_END:
>> +	case SEEK_DATA:
>> +	case SEEK_HOLE:
>> +		/* unsupported */
>> +		return -EINVAL;
>> +	case SEEK_CUR:
>> +		if (offset == 0)
>> +			return file->f_pos;
>> +
>> +		offset += file->f_pos;
>> +		break;
>> +	case SEEK_SET:
>> +		break;
>> +	}
>> +
>> +	if (offset != file->f_pos) {
>> +		file->f_pos = offset;
>> +		file->f_version = 0;
>> +		ret = offset;
>> +	}
>> +
>> +	return ret;
>> +}
> Why can't you use default_llseek here?  Why do you not allow HOLE and
> others?

I believe default_llseek() would work, but I chose not to use it because I
haven't tested some cases - like SEEK_HOLE.  My ADI changes to makedumpfile
and crash utility don't utilize SEEK_HOLE.  I felt uncomfortable providing
a feature without testing it thoroughly, so I decided to save it for a
future patchset.

>
> Anyway, just tiny questions, all are trivial and not really a big deal
> if you have tested it on your hardware.  I'm guessing this will go
> through the SPARC tree?  If so feel free to add:

That was my plan since this driver is only applicable to sparc64 machines.
But I'm open to however you and Dave M think it would be best to proceed.

>
> 	Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> Or if you want/need me to take it through my char/misc tree, just let me
> know and I can.

Thanks so much for the help.  I really appreciate it.

Tom

>
> thanks,
>
> greg k-h
