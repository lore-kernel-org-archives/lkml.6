Return-Path: <tom.hromatka@oracle.com>
X-Google-Smtp-Source: AIpwx4/QLwsjDIXPBle62VuevnYVK7eMFJ5E/WDiJOmutDvmoMzp8dJKdhOLkzD+m7buBwpTJfI1
ARC-Seal: i=1; a=rsa-sha256; t=1524253187; cv=none;
        d=google.com; s=arc-20160816;
        b=uzyWErI3pZx2PemRFC1t9UfYKAi4niGth0yHJ50u6xlHYSSb+Hxz7YQavSYKPD7emg
         KOJooUm+APaqYJb4jsj9eMPKF1QX4Gt6e6OW+OOkjorKOK5PaJ5uGXWn6csndBa765yU
         AAPEigroN+wMAdbwI0/O4lfiNdxtuyR+9X/K7ell8VBST1lx76bu7ahLVI4gzIxGkHYK
         GQW/LjcAFVeWvC4ML1Mhw2E9WINpli+bJo+Uc4XwT1s2TsGcQ+dNfPspoFCnM7mTuxTo
         bp1OOx63kw9l4KQtOzsI1gXz2Ly3IzCRG/gaTo/1toeAt7VenAaNKonTEYSsP5W8POHO
         r9yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=CfbHXnP7a658rleVxmOflJcL2iNCSnsJDrEEiBjsm6I=;
        b=n8RWexIEoHdvrJkyUhVCDLRIYUA8n8OyoaAEPMxEpUSU2FJcyA5fle4cyDkqybn5D1
         +HlHQDPwWgJP7+xcABfV9mw3Q+Qdaxlo4aKeYF1lk2MJIESKIi3KI3f7fF/a+RxGjVQX
         jtKCtg3sP8xH6wcFzpyV7fxAx2WOtYoUvy0BxZCg8otjPch+WRUtx2GUQpdof5FjC7ar
         yTehi/bVxZEO+Bn4EfLp9wa/4tSXVdhQcAHRHQMzYwhcAKTwDdjDE2WVPHvFt33YhxGx
         3WrFjIiHua+GoI3E47Dr3yfippRlB0oiFAz9gAVK3+iBws/WiHW9ClX6CidDCI+ttrtO
         Tx4g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=jFw8OMs1;
       spf=pass (google.com: domain of tom.hromatka@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=tom.hromatka@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=jFw8OMs1;
       spf=pass (google.com: domain of tom.hromatka@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=tom.hromatka@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Tom Hromatka <tom.hromatka@oracle.com>
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, tom.hromatka@oracle.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        allen.pais@oracle.com, khalid.aziz@oracle.com,
        shannon.nelson@oracle.com, anthony.yznaga@oracle.com
Subject: [PATCH v3 1/2] SPARC M7 and newer processors utilize ADI to version and protect memory.  This driver is capable of reading/writing ADI/MCD versions from privileged user space processes. Addresses in the adi file are mapped linearly to physical memory at a ratio of 1:adi_blksz.  Thus, a read (or write) of offset K in the file operates upon the ADI version at physical address K * adi_blksz.  The version information is encoded as one version per byte.  Intended consumers are makedumpfile and crash.
Date: Fri, 20 Apr 2018 13:39:38 -0600
Message-Id: <20180420193939.487546-2-tom.hromatka@oracle.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180420193939.487546-1-tom.hromatka@oracle.com>
References: <20180420193939.487546-1-tom.hromatka@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8869 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804200197
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598295310382738467?=
X-GMAIL-MSGID: =?utf-8?q?1598295310382738467?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Tom Hromatka <tom.hromatka@oracle.com>
Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 drivers/char/Kconfig  |  12 +++
 drivers/char/Makefile |   1 +
 drivers/char/adi.c    | 240 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 253 insertions(+)
 create mode 100644 drivers/char/adi.c

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 40947a796666..5ecddc95a698 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -540,5 +540,17 @@ source "drivers/s390/char/Kconfig"
 
 source "drivers/char/xillybus/Kconfig"
 
+config ADI
+	tristate "SPARC Privileged ADI driver"
+	depends on SPARC64
+	default m
+	help
+	  SPARC M7 and newer processors utilize ADI (Application Data
+	  Integrity) to version and protect memory.  This driver provides
+	  read/write access to the ADI versions for privileged processes.
+	  This feature is also known as MCD (Memory Corruption Detection)
+	  and SSM (Silicon Secured Memory).  Intended consumers of this
+	  driver include crash and makedumpfile.
+
 endmenu
 
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index c97c768cd1dd..b8d42b4e979b 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -57,3 +57,4 @@ js-rtc-y = rtc.o
 
 obj-$(CONFIG_XILLYBUS)		+= xillybus/
 obj-$(CONFIG_POWERNV_OP_PANEL)	+= powernv-op-panel.o
+obj-$(CONFIG_ADI)		+= adi.o
diff --git a/drivers/char/adi.c b/drivers/char/adi.c
new file mode 100644
index 000000000000..cb033305d1c4
--- /dev/null
+++ b/drivers/char/adi.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Privileged ADI driver for sparc64
+ *
+ * Author: Tom Hromatka <tom.hromatka@oracle.com>
+ */
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <asm/asi.h>
+
+#define MODULE_NAME	"adi"
+#define MAX_BUF_SZ	4096
+
+static int adi_open(struct inode *inode, struct file *file)
+{
+	file->f_mode |= FMODE_UNSIGNED_OFFSET;
+	return 0;
+}
+
+static int read_mcd_tag(unsigned long addr)
+{
+	long err;
+	int ver;
+
+	__asm__ __volatile__(
+		"1:	ldxa [%[addr]] %[asi], %[ver]\n"
+		"	mov 0, %[err]\n"
+		"2:\n"
+		"	.section .fixup,#alloc,#execinstr\n"
+		"	.align 4\n"
+		"3:	sethi %%hi(2b), %%g1\n"
+		"	jmpl  %%g1 + %%lo(2b), %%g0\n"
+		"	mov %[invalid], %[err]\n"
+		"	.previous\n"
+		"	.section __ex_table, \"a\"\n"
+		"	.align 4\n"
+		"	.word  1b, 3b\n"
+		"	.previous\n"
+		: [ver] "=r" (ver), [err] "=r" (err)
+		: [addr] "r"  (addr), [invalid] "i" (EFAULT),
+		  [asi] "i" (ASI_MCD_REAL)
+		: "memory", "g1"
+		);
+
+	if (err)
+		return -EFAULT;
+	else
+		return ver;
+}
+
+static ssize_t adi_read(struct file *file, char __user *buf,
+			size_t count, loff_t *offp)
+{
+	size_t ver_buf_sz, bytes_read = 0;
+	int ver_buf_idx = 0;
+	loff_t offset;
+	u8 *ver_buf;
+	ssize_t ret;
+
+	ver_buf_sz = min_t(size_t, count, MAX_BUF_SZ);
+	ver_buf = kmalloc(ver_buf_sz, GFP_KERNEL);
+	if (!ver_buf)
+		return -ENOMEM;
+
+	offset = (*offp) * adi_blksize();
+
+	while (bytes_read < count) {
+		ret = read_mcd_tag(offset);
+		if (ret < 0)
+			goto out;
+
+		ver_buf[ver_buf_idx] = (u8)ret;
+		ver_buf_idx++;
+		offset += adi_blksize();
+
+		if (ver_buf_idx >= ver_buf_sz) {
+			if (copy_to_user(buf + bytes_read, ver_buf,
+					 ver_buf_sz)) {
+				ret = -EFAULT;
+				goto out;
+			}
+
+			bytes_read += ver_buf_sz;
+			ver_buf_idx = 0;
+
+			ver_buf_sz = min(count - bytes_read,
+					 (size_t)MAX_BUF_SZ);
+		}
+	}
+
+	(*offp) += bytes_read;
+	ret = bytes_read;
+out:
+	kfree(ver_buf);
+	return ret;
+}
+
+static int set_mcd_tag(unsigned long addr, u8 ver)
+{
+	long err;
+
+	__asm__ __volatile__(
+		"1:	stxa %[ver], [%[addr]] %[asi]\n"
+		"	mov 0, %[err]\n"
+		"2:\n"
+		"	.section .fixup,#alloc,#execinstr\n"
+		"	.align 4\n"
+		"3:	sethi %%hi(2b), %%g1\n"
+		"	jmpl %%g1 + %%lo(2b), %%g0\n"
+		"	mov %[invalid], %[err]\n"
+		"	.previous\n"
+		"	.section __ex_table, \"a\"\n"
+		"	.align 4\n"
+		"	.word 1b, 3b\n"
+		"	.previous\n"
+		: [err] "=r" (err)
+		: [ver] "r" (ver), [addr] "r"  (addr),
+		  [invalid] "i" (EFAULT), [asi] "i" (ASI_MCD_REAL)
+		: "memory", "g1"
+		);
+
+	if (err)
+		return -EFAULT;
+	else
+		return ver;
+}
+
+static ssize_t adi_write(struct file *file, const char __user *buf,
+			 size_t count, loff_t *offp)
+{
+	size_t ver_buf_sz, bytes_written = 0;
+	loff_t offset;
+	u8 *ver_buf;
+	ssize_t ret;
+	int i;
+
+	if (count <= 0)
+		return -EINVAL;
+
+	ver_buf_sz = min_t(size_t, count, MAX_BUF_SZ);
+	ver_buf = kmalloc(ver_buf_sz, (size_t)GFP_KERNEL);
+	if (!ver_buf)
+		return -ENOMEM;
+
+	offset = (*offp) * adi_blksize();
+
+	do {
+		if (copy_from_user(ver_buf, &buf[bytes_written],
+				   ver_buf_sz)) {
+			ret = -EFAULT;
+			goto out;
+		}
+
+		for (i = 0; i < ver_buf_sz; i++) {
+			ret = set_mcd_tag(offset, ver_buf[i]);
+			if (ret < 0)
+				goto out;
+
+			offset += adi_blksize();
+		}
+
+		bytes_written += ver_buf_sz;
+		ver_buf_sz = min(count - bytes_written, (size_t)MAX_BUF_SZ);
+	} while (bytes_written < count);
+
+	(*offp) += bytes_written;
+	ret = bytes_written;
+out:
+	__asm__ __volatile__("membar #Sync");
+	kfree(ver_buf);
+	return ret;
+}
+
+static loff_t adi_llseek(struct file *file, loff_t offset, int whence)
+{
+	loff_t ret = -EINVAL;
+
+	switch (whence) {
+	case SEEK_END:
+	case SEEK_DATA:
+	case SEEK_HOLE:
+		/* unsupported */
+		return -EINVAL;
+	case SEEK_CUR:
+		if (offset == 0)
+			return file->f_pos;
+
+		offset += file->f_pos;
+		break;
+	case SEEK_SET:
+		break;
+	}
+
+	if (offset != file->f_pos) {
+		file->f_pos = offset;
+		file->f_version = 0;
+		ret = offset;
+	}
+
+	return ret;
+}
+
+static const struct file_operations adi_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= adi_llseek,
+	.open		= adi_open,
+	.read		= adi_read,
+	.write		= adi_write,
+};
+
+static struct miscdevice adi_miscdev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = MODULE_NAME,
+	.fops = &adi_fops,
+};
+
+static int __init adi_init(void)
+{
+	if (!adi_capable())
+		return -EPERM;
+
+	return misc_register(&adi_miscdev);
+}
+
+static void __exit adi_exit(void)
+{
+	misc_deregister(&adi_miscdev);
+}
+
+module_init(adi_init);
+module_exit(adi_exit);
+
+MODULE_AUTHOR("Tom Hromatka <tom.hromatka@oracle.com>");
+MODULE_DESCRIPTION("Privileged interface to ADI");
+MODULE_VERSION("1.0");
+MODULE_LICENSE("GPL");
-- 
2.15.0
