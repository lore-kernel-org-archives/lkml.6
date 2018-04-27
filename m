Return-Path: <kernel-hardening-return-13151-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZovzEyCAPiKsOkLs2Vf84CsLaTRdNBqgTHhRowWNETKuZs8NPD4V+gHgIbuOje0h9VtsJ8C
ARC-Seal: i=1; a=rsa-sha256; t=1524846024; cv=none;
        d=google.com; s=arc-20160816;
        b=pmRVxse9nvRcFdcdTH1Ea4ulr/QrYDlM5CyipkTYit5lTguFBxDhnQD+HBdPtok6HS
         +wcD05klCasyjm1Moy2vY2sonteUfBPDAL/mX+HCzSq/+Y0Ez4hNvVUk8C2eUjVkZsYJ
         SCabtYTBoyYX4R251QizPOKEQqGRKyWu1UfpfmEXSudhblfZ+qM+Yst833ZsiawVI7dr
         w++uU43gQdA3a8y4lZCAamwnS9Ky9hS1P/8bAtblHnlLh5Mq5V2lacQWuVFw73h7m4tf
         Bvj8SjAI08nzOSCEDKUNt0Czu/X/n5jrORSsLWkLV+Bwnf5D3Klf3mdAL5ZZiLB3eORD
         kXMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dmarc-filter:delivered-to:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=gS8gW4fBtb2TXK4/H7LzOcBtjKCFXhokZeuPVMKtHlw=;
        b=yZ5DnfFogHK9kaHfaMBjD2ahjziadr+38iNJpwcEM9tmGn4dyWD3BnyMU8wJUnUXwQ
         BYFWB+580i4OzXC0zt86YVHS/cb9bHDz/sItB58EAL+psRvfw2+/+bfDl/RxpWZOwf5m
         Rkog6i1QnUI75vVWUT35FMrvrI0FiZE4shyrQkac+sevjM9ZeKskKBQSMsoT30NDqsWP
         oZP5RdsNdYSKC8hdYP6rBUq3KtErt3+OVq7oGxKziWynNdVPKN2NIHursV6+qQslNTBi
         zDYxup7/ptfFByZ9xtvWZZHBevaDaEXpP+6kmthtGaQhtkp2zIg7iQdbUKrJvyX0eGOa
         rByQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13151-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13151-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13151-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13151-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292B221892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
Date: Fri, 27 Apr 2018 15:49:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kees Cook <keescook@chromium.org>,
	Thomas Richter <tmricht@linux.ibm.com>
Cc: kernel-hardening@lists.openwall.com, brueckner@linux.vnet.ibm.com,
	schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] inode: debugfs_create_dir uses mode permission from
 parent
Message-ID: <20180427134936.GA31171@kroah.com>
References: <20180427123547.15727-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180427123547.15727-1-tmricht@linux.ibm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598885939373348657?=
X-GMAIL-MSGID: =?utf-8?q?1598916944770368685?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I'm going to add Kees and the kernel-hardning list here, as I'd like
their opinions for the patch below.

Kees, do you have any problems with this patch?  I know you worked on
making debugfs more "secure" from non-root users, this should still keep
the intial mount permissions all fine, right?  Anything I'm not
considering here?

thanks,

greg k-h

On Fri, Apr 27, 2018 at 02:35:47PM +0200, Thomas Richter wrote:
> Currently function debugfs_create_dir() creates a new
> directory in the debugfs (usually mounted /sys/kernel/debug)
> with permission rwxr-xr-x. This is hard coded.
> 
> Change this to use the parent directory permission.
> 
> Output before the patch:
> root@s8360047 ~]# tree -dp -L 1 /sys/kernel/debug/
> /sys/kernel/debug/
> ├── [drwxr-xr-x]  bdi
> ├── [drwxr-xr-x]  block
> ├── [drwxr-xr-x]  dasd
> ├── [drwxr-xr-x]  device_component
> ├── [drwxr-xr-x]  extfrag
> ├── [drwxr-xr-x]  hid
> ├── [drwxr-xr-x]  kprobes
> ├── [drwxr-xr-x]  kvm
> ├── [drwxr-xr-x]  memblock
> ├── [drwxr-xr-x]  pm_qos
> ├── [drwxr-xr-x]  qdio
> ├── [drwxr-xr-x]  s390
> ├── [drwxr-xr-x]  s390dbf
> └── [drwx------]  tracing
> 
> 14 directories
> [root@s8360047 linux]#
> 
> Output after the patch:
> [root@s8360047 ~]# tree -dp -L 1 /sys/kernel/debug/
> sys/kernel/debug/
> ├── [drwx------]  bdi
> ├── [drwx------]  block
> ├── [drwx------]  dasd
> ├── [drwx------]  device_component
> ├── [drwx------]  extfrag
> ├── [drwx------]  hid
> ├── [drwx------]  kprobes
> ├── [drwx------]  kvm
> ├── [drwx------]  memblock
> ├── [drwx------]  pm_qos
> ├── [drwx------]  qdio
> ├── [drwx------]  s390
> ├── [drwx------]  s390dbf
> └── [drwx------]  tracing
> 
> 14 directories
> [root@s8360047 linux]#
> 
> Here is the full diff output done with:
> [root@s8360047 ~]# diff -u treefull.before treefull.after |
> 	sed 's-^- # -' > treefull.diff
>  # --- treefull.before	2018-04-27 13:22:04.532824564 +0200
>  # +++ treefull.after	2018-04-27 13:24:12.106182062 +0200
>  # @@ -1,55 +1,55 @@
>  #  /sys/kernel/debug/
>  # -├── [drwxr-xr-x]  bdi
>  # -│   ├── [drwxr-xr-x]  1:0
>  # -│   ├── [drwxr-xr-x]  1:1
>  # -│   ├── [drwxr-xr-x]  1:10
>  # -│   ├── [drwxr-xr-x]  1:11
>  # -│   ├── [drwxr-xr-x]  1:12
>  # -│   ├── [drwxr-xr-x]  1:13
>  # -│   ├── [drwxr-xr-x]  1:14
>  # -│   ├── [drwxr-xr-x]  1:15
>  # -│   ├── [drwxr-xr-x]  1:2
>  # -│   ├── [drwxr-xr-x]  1:3
>  # -│   ├── [drwxr-xr-x]  1:4
>  # -│   ├── [drwxr-xr-x]  1:5
>  # -│   ├── [drwxr-xr-x]  1:6
>  # -│   ├── [drwxr-xr-x]  1:7
>  # -│   ├── [drwxr-xr-x]  1:8
>  # -│   ├── [drwxr-xr-x]  1:9
>  # -│   └── [drwxr-xr-x]  94:0
>  # -├── [drwxr-xr-x]  block
>  # -├── [drwxr-xr-x]  dasd
>  # -│   ├── [drwxr-xr-x]  0.0.e18a
>  # -│   ├── [drwxr-xr-x]  dasda
>  # -│   └── [drwxr-xr-x]  global
>  # -├── [drwxr-xr-x]  device_component
>  # -├── [drwxr-xr-x]  extfrag
>  # -├── [drwxr-xr-x]  hid
>  # -├── [drwxr-xr-x]  kprobes
>  # -├── [drwxr-xr-x]  kvm
>  # -├── [drwxr-xr-x]  memblock
>  # -├── [drwxr-xr-x]  pm_qos
>  # -├── [drwxr-xr-x]  qdio
>  # -│   └── [drwxr-xr-x]  0.0.f5f2
>  # -├── [drwxr-xr-x]  s390
>  # -│   └── [drwxr-xr-x]  stsi
>  # -├── [drwxr-xr-x]  s390dbf
>  # -│   ├── [drwxr-xr-x]  0.0.e18a
>  # -│   ├── [drwxr-xr-x]  cio_crw
>  # -│   ├── [drwxr-xr-x]  cio_msg
>  # -│   ├── [drwxr-xr-x]  cio_trace
>  # -│   ├── [drwxr-xr-x]  dasd
>  # -│   ├── [drwxr-xr-x]  kvm-trace
>  # -│   ├── [drwxr-xr-x]  lgr
>  # -│   ├── [drwxr-xr-x]  qdio_0.0.f5f2
>  # -│   ├── [drwxr-xr-x]  qdio_error
>  # -│   ├── [drwxr-xr-x]  qdio_setup
>  # -│   ├── [drwxr-xr-x]  qeth_card_0.0.f5f0
>  # -│   ├── [drwxr-xr-x]  qeth_control
>  # -│   ├── [drwxr-xr-x]  qeth_msg
>  # -│   ├── [drwxr-xr-x]  qeth_setup
>  # -│   ├── [drwxr-xr-x]  vmcp
>  # -│   └── [drwxr-xr-x]  vmur
>  # +├── [drwx------]  bdi
>  # +│   ├── [drwx------]  1:0
>  # +│   ├── [drwx------]  1:1
>  # +│   ├── [drwx------]  1:10
>  # +│   ├── [drwx------]  1:11
>  # +│   ├── [drwx------]  1:12
>  # +│   ├── [drwx------]  1:13
>  # +│   ├── [drwx------]  1:14
>  # +│   ├── [drwx------]  1:15
>  # +│   ├── [drwx------]  1:2
>  # +│   ├── [drwx------]  1:3
>  # +│   ├── [drwx------]  1:4
>  # +│   ├── [drwx------]  1:5
>  # +│   ├── [drwx------]  1:6
>  # +│   ├── [drwx------]  1:7
>  # +│   ├── [drwx------]  1:8
>  # +│   ├── [drwx------]  1:9
>  # +│   └── [drwx------]  94:0
>  # +├── [drwx------]  block
>  # +├── [drwx------]  dasd
>  # +│   ├── [drwx------]  0.0.e18a
>  # +│   ├── [drwx------]  dasda
>  # +│   └── [drwx------]  global
>  # +├── [drwx------]  device_component
>  # +├── [drwx------]  extfrag
>  # +├── [drwx------]  hid
>  # +├── [drwx------]  kprobes
>  # +├── [drwx------]  kvm
>  # +├── [drwx------]  memblock
>  # +├── [drwx------]  pm_qos
>  # +├── [drwx------]  qdio
>  # +│   └── [drwx------]  0.0.f5f2
>  # +├── [drwx------]  s390
>  # +│   └── [drwx------]  stsi
>  # +├── [drwx------]  s390dbf
>  # +│   ├── [drwx------]  0.0.e18a
>  # +│   ├── [drwx------]  cio_crw
>  # +│   ├── [drwx------]  cio_msg
>  # +│   ├── [drwx------]  cio_trace
>  # +│   ├── [drwx------]  dasd
>  # +│   ├── [drwx------]  kvm-trace
>  # +│   ├── [drwx------]  lgr
>  # +│   ├── [drwx------]  qdio_0.0.f5f2
>  # +│   ├── [drwx------]  qdio_error
>  # +│   ├── [drwx------]  qdio_setup
>  # +│   ├── [drwx------]  qeth_card_0.0.f5f0
>  # +│   ├── [drwx------]  qeth_control
>  # +│   ├── [drwx------]  qeth_msg
>  # +│   ├── [drwx------]  qeth_setup
>  # +│   ├── [drwx------]  vmcp
>  # +│   └── [drwx------]  vmur
>  #  └── [drwx------]  tracing
>  #      ├── [drwxr-xr-x]  events
>  #      │   ├── [drwxr-xr-x]  alarmtimer
> 
> Fixes: edac65eaf8d5c ("debugfs: take mode-dependent parts of debugfs_get_inode() into callers")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  fs/debugfs/inode.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index 13b0135..a913b12 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -512,7 +512,9 @@ struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
>  	if (unlikely(!inode))
>  		return failed_creating(dentry);
>  
> -	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
> +	if (!parent)
> +		parent = debugfs_mount->mnt_root;
> +	inode->i_mode = S_IFDIR | ((d_inode(parent)->i_mode & 0770));
>  	inode->i_op = &simple_dir_inode_operations;
>  	inode->i_fop = &simple_dir_operations;
>  
> -- 
> 2.9.3
