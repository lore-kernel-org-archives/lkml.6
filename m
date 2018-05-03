Return-Path: <ecree@solarflare.com>
X-Google-Smtp-Source: AB8JxZrPVbIHtMbHMZQvCv+DIccfWbwO3+2+1sXJYFFcudiwjz3jGq0nVuJ6Gzm7hKCBiMl8Z76I
ARC-Seal: i=1; a=rsa-sha256; t=1525357447; cv=none;
        d=google.com; s=arc-20160816;
        b=QGGNz1/PJucOtcOMcgkKZO3jYiBSdMTXR1lUOFQUtRrfwLZA/6X3+JFTTVvvhcdvGe
         DC5+iE+Sow93U3GRPdRwnSYm04xUhEzLEuYh94WBCeuOzTaqzRfqAbE9JdMec7PHJo6/
         PJ+SG0IY9ruQr2hfJsoD11WdKaK5RcBDmV4P+M52T3ksfBHYe5D70gysNsvNC9Cbvlgb
         ZjPgrQs9p12Za1I9euntZi56yrccLS0amKW63wKtrYuyAwtmqR2DVfpwySQTopVF0lpW
         TCMpcottdVX3J0VCOHgSIYhPIWDNkVWyWuIYiiRpAb58WNsTw2scNTYZAFkmZHbhSpmN
         kPSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=xobuUqalWnIT4SniZ1U4i4PlRYbPaHlkNAuGnygFKSU=;
        b=WGsw3fLq4Jy13b3f9+zthfFm4J60dvG6Isot/HhIobnpA1FCXFvF0RuJy2NDgMsnoB
         +CNyj+HCTsLYV6fBCq3DNsQ0CFiFToxBNPe2ZU5ZqqWKiUOkvXIAxvQL9qBxtFm+HqOj
         ukTysAs5bD6hvpgxyuVGqXmcyXuuJowAXkGiS5JbZLi6uyHMeRSMFckNAqPItlvJpw4i
         3Km+9cp99Dv+yTUPcxmIIc10r0xcCPWKkzgF93r3fvJBgJHKWl4xxWgJPd0xCCioRXG4
         QDWWAE7C48PwBT3o8WOPN6/acFhXb74ZSfECVdYaFVZ9qjWl2U+/QMty8Pr655leps6G
         A4CA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ecree@solarflare.com designates 67.231.154.164 as permitted sender) smtp.mailfrom=ecree@solarflare.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ecree@solarflare.com designates 67.231.154.164 as permitted sender) smtp.mailfrom=ecree@solarflare.com
Subject: Re: [PATCH v2 net-next 2/4] net: add skeleton of bpfilter kernel
 module
To: Alexei Starovoitov <ast@kernel.org>, <davem@davemloft.net>
CC: <daniel@iogearbox.net>, <torvalds@linux-foundation.org>,
	<gregkh@linuxfoundation.org>, <luto@amacapital.net>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-team@fb.com>
References: <20180503043604.1604587-1-ast@kernel.org>
 <20180503043604.1604587-3-ast@kernel.org>
From: Edward Cree <ecree@solarflare.com>
Message-ID: <c0ad0d12-418f-8dfd-ed2c-92e36316310b@solarflare.com>
Date: Thu, 3 May 2018 15:23:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180503043604.1604587-3-ast@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.45]
X-MDID: 1525357443-mGoY2g856LdY
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599416225694736469?=
X-GMAIL-MSGID: =?utf-8?q?1599453210158333675?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/05/18 05:36, Alexei Starovoitov wrote:
> bpfilter.ko consists of bpfilter_kern.c (normal kernel module code)
> and user mode helper code that is embedded into bpfilter.ko
>
> The steps to build bpfilter.ko are the following:
> - main.c is compiled by HOSTCC into the bpfilter_umh elf executable file
> - with quite a bit of objcopy and Makefile magic the bpfilter_umh elf file
>   is converted into bpfilter_umh.o object file
>   with _binary_net_bpfilter_bpfilter_umh_start and _end symbols
>   Example:
>   $ nm ./bld_x64/net/bpfilter/bpfilter_umh.o
>   0000000000004cf8 T _binary_net_bpfilter_bpfilter_umh_end
>   0000000000004cf8 A _binary_net_bpfilter_bpfilter_umh_size
>   0000000000000000 T _binary_net_bpfilter_bpfilter_umh_start
> - bpfilter_umh.o and bpfilter_kern.o are linked together into bpfilter.ko
>
> bpfilter_kern.c is a normal kernel module code that calls
> the fork_usermode_blob() helper to execute part of its own data
> as a user mode process.
>
> Notice that _binary_net_bpfilter_bpfilter_umh_start - end
> is placed into .init.rodata section, so it's freed as soon as __init
> function of bpfilter.ko is finished.
> As part of __init the bpfilter.ko does first request/reply action
> via two unix pipe provided by fork_usermode_blob() helper to
> make sure that umh is healthy. If not it will kill it via pid.
>
> Later bpfilter_process_sockopt() will be called from bpfilter hooks
> in get/setsockopt() to pass iptable commands into umh via bpfilter.ko
>
> If admin does 'rmmod bpfilter' the __exit code bpfilter.ko will
> kill umh as well.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/bpfilter.h      | 15 +++++++
>  include/uapi/linux/bpfilter.h | 21 ++++++++++
>  net/Kconfig                   |  2 +
>  net/Makefile                  |  1 +
>  net/bpfilter/Kconfig          | 17 ++++++++
>  net/bpfilter/Makefile         | 24 +++++++++++
>  net/bpfilter/bpfilter_kern.c  | 93 +++++++++++++++++++++++++++++++++++++++++++
>  net/bpfilter/main.c           | 63 +++++++++++++++++++++++++++++
>  net/bpfilter/msgfmt.h         | 17 ++++++++
>  net/ipv4/Makefile             |  2 +
>  net/ipv4/bpfilter/Makefile    |  2 +
>  net/ipv4/bpfilter/sockopt.c   | 42 +++++++++++++++++++
>  net/ipv4/ip_sockglue.c        | 17 ++++++++
>  13 files changed, 316 insertions(+)
>  create mode 100644 include/linux/bpfilter.h
>  create mode 100644 include/uapi/linux/bpfilter.h
>  create mode 100644 net/bpfilter/Kconfig
>  create mode 100644 net/bpfilter/Makefile
>  create mode 100644 net/bpfilter/bpfilter_kern.c
>  create mode 100644 net/bpfilter/main.c
>  create mode 100644 net/bpfilter/msgfmt.h
>  create mode 100644 net/ipv4/bpfilter/Makefile
>  create mode 100644 net/ipv4/bpfilter/sockopt.c
>
> diff --git a/include/linux/bpfilter.h b/include/linux/bpfilter.h
> new file mode 100644
> index 000000000000..687b1760bb9f
> --- /dev/null
> +++ b/include/linux/bpfilter.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_BPFILTER_H
> +#define _LINUX_BPFILTER_H
> +
> +#include <uapi/linux/bpfilter.h>
> +
> +struct sock;
> +int bpfilter_ip_set_sockopt(struct sock *sk, int optname, char *optval,
> +			    unsigned int optlen);
> +int bpfilter_ip_get_sockopt(struct sock *sk, int optname, char *optval,
> +			    int *optlen);
> +extern int (*bpfilter_process_sockopt)(struct sock *sk, int optname,
> +				       char __user *optval,
> +				       unsigned int optlen, bool is_set);
> +#endif
> diff --git a/include/uapi/linux/bpfilter.h b/include/uapi/linux/bpfilter.h
> new file mode 100644
> index 000000000000..2ec3cc99ea4c
> --- /dev/null
> +++ b/include/uapi/linux/bpfilter.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _UAPI_LINUX_BPFILTER_H
> +#define _UAPI_LINUX_BPFILTER_H
> +
> +#include <linux/if.h>
> +
> +enum {
> +	BPFILTER_IPT_SO_SET_REPLACE = 64,
> +	BPFILTER_IPT_SO_SET_ADD_COUNTERS = 65,
> +	BPFILTER_IPT_SET_MAX,
> +};
> +
> +enum {
> +	BPFILTER_IPT_SO_GET_INFO = 64,
> +	BPFILTER_IPT_SO_GET_ENTRIES = 65,
> +	BPFILTER_IPT_SO_GET_REVISION_MATCH = 66,
> +	BPFILTER_IPT_SO_GET_REVISION_TARGET = 67,
> +	BPFILTER_IPT_GET_MAX,
> +};
> +
> +#endif /* _UAPI_LINUX_BPFILTER_H */
> diff --git a/net/Kconfig b/net/Kconfig
> index b62089fb1332..ed6368b306fa 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -201,6 +201,8 @@ source "net/bridge/netfilter/Kconfig"
>  
>  endif
>  
> +source "net/bpfilter/Kconfig"
> +
>  source "net/dccp/Kconfig"
>  source "net/sctp/Kconfig"
>  source "net/rds/Kconfig"
> diff --git a/net/Makefile b/net/Makefile
> index a6147c61b174..7f982b7682bd 100644
> --- a/net/Makefile
> +++ b/net/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_TLS)		+= tls/
>  obj-$(CONFIG_XFRM)		+= xfrm/
>  obj-$(CONFIG_UNIX)		+= unix/
>  obj-$(CONFIG_NET)		+= ipv6/
> +obj-$(CONFIG_BPFILTER)		+= bpfilter/
>  obj-$(CONFIG_PACKET)		+= packet/
>  obj-$(CONFIG_NET_KEY)		+= key/
>  obj-$(CONFIG_BRIDGE)		+= bridge/
> diff --git a/net/bpfilter/Kconfig b/net/bpfilter/Kconfig
> new file mode 100644
> index 000000000000..782a732b9a5c
> --- /dev/null
> +++ b/net/bpfilter/Kconfig
> @@ -0,0 +1,17 @@
> +menuconfig BPFILTER
> +	bool "BPF based packet filtering framework (BPFILTER)"
> +	default n
> +	depends on NET && BPF
> +	help
> +	  This builds experimental bpfilter framework that is aiming to
> +	  provide netfilter compatible functionality via BPF
> +
> +if BPFILTER
> +config BPFILTER_UMH
> +	tristate "bpftiler kernel module with user mode helper"
sp. "bpftiler" -> "bpfilter"
> +	default m
> +	depends on m
> +	help
> +	  This builds bpfilter kernel module with embedded user mode helper
> +endif
> +
> diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
> new file mode 100644
> index 000000000000..897eedae523e
> --- /dev/null
> +++ b/net/bpfilter/Makefile
> @@ -0,0 +1,24 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for the Linux BPFILTER layer.
> +#
> +
> +hostprogs-y := bpfilter_umh
> +bpfilter_umh-objs := main.o
> +HOSTCFLAGS += -I. -Itools/include/
> +
> +# a bit of elf magic to convert bpfilter_umh binary into a binary blob
> +# inside bpfilter_umh.o elf file referenced by
> +# _binary_net_bpfilter_bpfilter_umh_start symbol
> +# which bpfilter_kern.c passes further into umh blob loader at run-time
> +quiet_cmd_copy_umh = GEN $@
> +      cmd_copy_umh = echo ':' > $(obj)/.bpfilter_umh.o.cmd; \
> +      $(OBJCOPY) -I binary -O $(CONFIG_OUTPUT_FORMAT) \
> +      -B `$(OBJDUMP) -f $<|grep architecture|cut -d, -f1|cut -d' ' -f2` \
> +      --rename-section .data=.init.rodata $< $@
> +
> +$(obj)/bpfilter_umh.o: $(obj)/bpfilter_umh
> +	$(call cmd,copy_umh)
> +
> +obj-$(CONFIG_BPFILTER_UMH) += bpfilter.o
> +bpfilter-objs += bpfilter_kern.o bpfilter_umh.o
> diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
> new file mode 100644
> index 000000000000..e0a6fdd5842b
> --- /dev/null
> +++ b/net/bpfilter/bpfilter_kern.c
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/umh.h>
> +#include <linux/bpfilter.h>
> +#include <linux/sched.h>
> +#include <linux/sched/signal.h>
> +#include <linux/fs.h>
> +#include <linux/file.h>
> +#include "msgfmt.h"
> +
> +#define UMH_start _binary_net_bpfilter_bpfilter_umh_start
> +#define UMH_end _binary_net_bpfilter_bpfilter_umh_end
> +
> +extern char UMH_start;
> +extern char UMH_end;
> +
> +static struct umh_info info;
> +
> +static void shutdown_umh(struct umh_info *info)
> +{
> +	struct task_struct *tsk;
> +
> +	tsk = pid_task(find_vpid(info->pid), PIDTYPE_PID);
> +	if (tsk)
> +		force_sig(SIGKILL, tsk);
> +	fput(info->pipe_to_umh);
> +	fput(info->pipe_from_umh);
> +}
> +
> +static void stop_umh(void)
> +{
> +	if (bpfilter_process_sockopt) {
I worry about locking here.  Is it possible for two calls to
 bpfilter_process_sockopt() to run in parallel, both fail, and thus both
 call stop_umh()?  And if both end up calling shutdown_umh(), we double
 fput().
> +		bpfilter_process_sockopt = NULL;
> +		shutdown_umh(&info);
> +	}
> +}
> +
> +static int __bpfilter_process_sockopt(struct sock *sk, int optname,
> +				      char __user *optval,
> +				      unsigned int optlen, bool is_set)
> +{
> +	struct mbox_request req;
> +	struct mbox_reply reply;
> +	loff_t pos;
> +	ssize_t n;
> +
> +	req.is_set = is_set;
> +	req.pid = current->pid;
> +	req.cmd = optname;
> +	req.addr = (long)optval;
> +	req.len = optlen;
> +	n = __kernel_write(info.pipe_to_umh, &req, sizeof(req), &pos);
> +	if (n != sizeof(req)) {
> +		pr_err("write fail %zd\n", n);
> +		stop_umh();
> +		return -EFAULT;
> +	}
> +	pos = 0;
> +	n = kernel_read(info.pipe_from_umh, &reply, sizeof(reply), &pos);
> +	if (n != sizeof(reply)) {
> +		pr_err("read fail %zd\n", n);
> +		stop_umh();
> +		return -EFAULT;
> +	}
> +	return reply.status;
> +}
> +
> +static int __init load_umh(void)
> +{
> +	int err;
> +
> +	err = fork_usermode_blob(&UMH_start, &UMH_end - &UMH_start, &info);
> +	if (err)
> +		return err;
> +	pr_info("Loaded umh pid %d\n", info.pid);
> +	bpfilter_process_sockopt = &__bpfilter_process_sockopt;
> +
> +	if (__bpfilter_process_sockopt(NULL, 0, 0, 0, 0) != 0) {
> +		stop_umh();
> +		return -EFAULT;
> +	}
> +	return 0;
> +}
> +
> +static void __exit fini_umh(void)
> +{
> +	stop_umh();
> +}
> +module_init(load_umh);
> +module_exit(fini_umh);
> +MODULE_LICENSE("GPL");
> diff --git a/net/bpfilter/main.c b/net/bpfilter/main.c
> new file mode 100644
> index 000000000000..81bbc1684896
> --- /dev/null
> +++ b/net/bpfilter/main.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +#include <sys/uio.h>
> +#include <errno.h>
> +#include <stdio.h>
> +#include <sys/socket.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include "include/uapi/linux/bpf.h"
> +#include <asm/unistd.h>
> +#include "msgfmt.h"
> +
> +int debug_fd;
> +
> +static int handle_get_cmd(struct mbox_request *cmd)
> +{
> +	switch (cmd->cmd) {
> +	case 0:
> +		return 0;
> +	default:
> +		break;
> +	}
> +	return -ENOPROTOOPT;
> +}
> +
> +static int handle_set_cmd(struct mbox_request *cmd)
> +{
> +	return -ENOPROTOOPT;
> +}
> +
> +static void loop(void)
> +{
> +	while (1) {
> +		struct mbox_request req;
> +		struct mbox_reply reply;
> +		int n;
> +
> +		n = read(0, &req, sizeof(req));
> +		if (n != sizeof(req)) {
> +			dprintf(debug_fd, "invalid request %d\n", n);
> +			return;
> +		}
> +
> +		reply.status = req.is_set ?
> +			handle_set_cmd(&req) :
> +			handle_get_cmd(&req);
> +
> +		n = write(1, &reply, sizeof(reply));
> +		if (n != sizeof(reply)) {
> +			dprintf(debug_fd, "reply failed %d\n", n);
> +			return;
> +		}
> +	}
> +}
> +
> +int main(void)
> +{
> +	debug_fd = open("/dev/console", 00000002 | 00000100);
Should probably handle failure of this open() call.
> +	dprintf(debug_fd, "Started bpfilter\n");
> +	loop();
> +	close(debug_fd);
> +	return 0;
> +}
> diff --git a/net/bpfilter/msgfmt.h b/net/bpfilter/msgfmt.h
> new file mode 100644
> index 000000000000..94b9ac9e5114
> --- /dev/null
> +++ b/net/bpfilter/msgfmt.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _NET_BPFILTER_MSGFMT_H
> +#define _NET_BPFTILER_MSGFMT_H
Another bpftiler here, should be
+#define _NET_BPFILTER_MSGFMT_H

-Ed
> +
> +struct mbox_request {
> +	__u64 addr;
> +	__u32 len;
> +	__u32 is_set;
> +	__u32 cmd;
> +	__u32 pid;
> +};
> +
> +struct mbox_reply {
> +	__u32 status;
> +};
> +
> +#endif
> diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
> index b379520f9133..7018f91c5a39 100644
> --- a/net/ipv4/Makefile
> +++ b/net/ipv4/Makefile
> @@ -16,6 +16,8 @@ obj-y     := route.o inetpeer.o protocol.o \
>  	     inet_fragment.o ping.o ip_tunnel_core.o gre_offload.o \
>  	     metrics.o
>  
> +obj-$(CONFIG_BPFILTER) += bpfilter/
> +
>  obj-$(CONFIG_NET_IP_TUNNEL) += ip_tunnel.o
>  obj-$(CONFIG_SYSCTL) += sysctl_net_ipv4.o
>  obj-$(CONFIG_PROC_FS) += proc.o
> diff --git a/net/ipv4/bpfilter/Makefile b/net/ipv4/bpfilter/Makefile
> new file mode 100644
> index 000000000000..ce262d76cc48
> --- /dev/null
> +++ b/net/ipv4/bpfilter/Makefile
> @@ -0,0 +1,2 @@
> +obj-$(CONFIG_BPFILTER) += sockopt.o
> +
> diff --git a/net/ipv4/bpfilter/sockopt.c b/net/ipv4/bpfilter/sockopt.c
> new file mode 100644
> index 000000000000..42a96d2d8d05
> --- /dev/null
> +++ b/net/ipv4/bpfilter/sockopt.c
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/uaccess.h>
> +#include <linux/bpfilter.h>
> +#include <uapi/linux/bpf.h>
> +#include <linux/wait.h>
> +#include <linux/kmod.h>
> +
> +int (*bpfilter_process_sockopt)(struct sock *sk, int optname,
> +				char __user *optval,
> +				unsigned int optlen, bool is_set);
> +EXPORT_SYMBOL_GPL(bpfilter_process_sockopt);
> +
> +int bpfilter_mbox_request(struct sock *sk, int optname, char __user *optval,
> +			  unsigned int optlen, bool is_set)
> +{
> +	if (!bpfilter_process_sockopt) {
> +		int err = request_module("bpfilter");
> +
> +		if (err)
> +			return err;
> +		if (!bpfilter_process_sockopt)
> +			return -ECHILD;
> +	}
> +	return bpfilter_process_sockopt(sk, optname, optval, optlen, is_set);
> +}
> +
> +int bpfilter_ip_set_sockopt(struct sock *sk, int optname, char __user *optval,
> +			    unsigned int optlen)
> +{
> +	return bpfilter_mbox_request(sk, optname, optval, optlen, true);
> +}
> +
> +int bpfilter_ip_get_sockopt(struct sock *sk, int optname, char __user *optval,
> +			    int __user *optlen)
> +{
> +	int len;
> +
> +	if (get_user(len, optlen))
> +		return -EFAULT;
> +
> +	return bpfilter_mbox_request(sk, optname, optval, len, false);
> +}
> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index 5ad2d8ed3a3f..e0791faacb24 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
> @@ -47,6 +47,8 @@
>  #include <linux/errqueue.h>
>  #include <linux/uaccess.h>
>  
> +#include <linux/bpfilter.h>
> +
>  /*
>   *	SOL_IP control messages.
>   */
> @@ -1244,6 +1246,11 @@ int ip_setsockopt(struct sock *sk, int level,
>  		return -ENOPROTOOPT;
>  
>  	err = do_ip_setsockopt(sk, level, optname, optval, optlen);
> +#ifdef CONFIG_BPFILTER
> +	if (optname >= BPFILTER_IPT_SO_SET_REPLACE &&
> +	    optname < BPFILTER_IPT_SET_MAX)
> +		err = bpfilter_ip_set_sockopt(sk, optname, optval, optlen);
> +#endif
>  #ifdef CONFIG_NETFILTER
>  	/* we need to exclude all possible ENOPROTOOPTs except default case */
>  	if (err == -ENOPROTOOPT && optname != IP_HDRINCL &&
> @@ -1552,6 +1559,11 @@ int ip_getsockopt(struct sock *sk, int level,
>  	int err;
>  
>  	err = do_ip_getsockopt(sk, level, optname, optval, optlen, 0);
> +#ifdef CONFIG_BPFILTER
> +	if (optname >= BPFILTER_IPT_SO_GET_INFO &&
> +	    optname < BPFILTER_IPT_GET_MAX)
> +		err = bpfilter_ip_get_sockopt(sk, optname, optval, optlen);
> +#endif
>  #ifdef CONFIG_NETFILTER
>  	/* we need to exclude all possible ENOPROTOOPTs except default case */
>  	if (err == -ENOPROTOOPT && optname != IP_PKTOPTIONS &&
> @@ -1584,6 +1596,11 @@ int compat_ip_getsockopt(struct sock *sk, int level, int optname,
>  	err = do_ip_getsockopt(sk, level, optname, optval, optlen,
>  		MSG_CMSG_COMPAT);
>  
> +#ifdef CONFIG_BPFILTER
> +	if (optname >= BPFILTER_IPT_SO_GET_INFO &&
> +	    optname < BPFILTER_IPT_GET_MAX)
> +		err = bpfilter_ip_get_sockopt(sk, optname, optval, optlen);
> +#endif
>  #ifdef CONFIG_NETFILTER
>  	/* we need to exclude all possible ENOPROTOOPTs except default case */
>  	if (err == -ENOPROTOOPT && optname != IP_PKTOPTIONS &&
