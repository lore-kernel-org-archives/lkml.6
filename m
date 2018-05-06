Return-Path: <viro@ftp.linux.org.uk>
X-Google-Smtp-Source: AB8JxZr8UVHqPhAVAhEyJVRlsFfr1aO4b0VeXpi67sCzc1GOTtmFEtJYSHr+KVvMEo+x+XLS82hd
ARC-Seal: i=1; a=rsa-sha256; t=1525628743; cv=none;
        d=google.com; s=arc-20160816;
        b=NT9FekDLsAUcD88GkUlMs8wOma36XRn2khgNg0ZgSGt32LczdprYRB74GDtr4BVs+x
         nkjGWXyKvw11LyFurpFv35wNqMudJS9UwANo+amURcc5k1ylJ7EqCxv9Jxi8mmBHcVwU
         hsraK/R230wO8ECbf2lSnOU8XhwzlAQvIVaOTBV+fLX6+FUPQBbMDClSx6a/JL+RzuuN
         5/q9ztOT6HrV+Cmm8pVEF98eB9VkkZI92/sm2sAUuUJKaXbsDRNNM4nFBDvfVMGuSF5x
         RfB7vbqHFTdLVEgffxZY3yFrRcNbcaEI4Zr8A9k77EiKiQFwO9h8Gnc4oXphxIZvoOZ/
         cYzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=Farno0zDq0Sp3FzqBvV2O6gsbI0dgSYt0tYWxdGiSvs=;
        b=Y19nteJ7nqVbSx5CVvkl3B0Sief3IFsEvNOIIHjJROxR69rArxhJ5QVufPp/WGrhoY
         968tQBezV2P0kZ6j0BU5WfEhdWhCs1gXPs0R60GVR/7Sqka8hWPq1tMc9WDnEJkQL9zt
         lLEMVbmeDiY3davLKQZtrnZQOk9taKO1jhckGygd8m3OaGDRe/V+Ix5hxb1fMjTVIR4W
         XksMwrJ4SS+RDwm+lBk0DE+cYKwrGQAhJVhQuQw5xnWL+wmf4BMZPNBTFnBWlPOpQvvy
         ftifxGqMx/tu4PH2SMwQP6Dgf1Evz+gNzx+hxV1DEo7u7kluia+IUh+okFRG6rkZ2Be9
         3w0w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of viro@ftp.linux.org.uk designates 195.92.253.2 as permitted sender) smtp.mailfrom=viro@ftp.linux.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of viro@ftp.linux.org.uk designates 195.92.253.2 as permitted sender) smtp.mailfrom=viro@ftp.linux.org.uk
Date: Sun, 6 May 2018 18:45:31 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-acpi@vger.kernel.org, drbd-dev@lists.linbit.com,
	linux-ide@vger.kernel.org, netdev@vger.kernel.org,
	linux-rtc@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-afs@lists.infradead.org, linux-ext4@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: simplify procfs code for seq_file instances V2
Message-ID: <20180506174531.GK30522@ZenIV.linux.org.uk>
References: <20180425154827.32251-1-hch@lst.de>
 <20180506171948.GA769@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180506171948.GA769@avx2>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: Al Viro <viro@ftp.linux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598733748805898460?=
X-GMAIL-MSGID: =?utf-8?q?1599737685237560402?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, May 06, 2018 at 08:19:49PM +0300, Alexey Dobriyan wrote:
> +++ b/fs/proc/internal.h
> @@ -48,8 +48,8 @@ struct proc_dir_entry {
>  		const struct seq_operations *seq_ops;
>  		int (*single_show)(struct seq_file *, void *);
>  	};
> -	unsigned int state_size;
>  	void *data;
> +	unsigned int state_size;
>  	unsigned int low_ino;
>  	nlink_t nlink;
>  	kuid_t uid;

Makes sense

> @@ -62,9 +62,9 @@ struct proc_dir_entry {
>  	umode_t mode;
>  	u8 namelen;
>  #ifdef CONFIG_64BIT
> -#define SIZEOF_PDE_INLINE_NAME	(192-139)
> +#define SIZEOF_PDE_INLINE_NAME	(192-155)
>  #else
> -#define SIZEOF_PDE_INLINE_NAME	(128-87)
> +#define SIZEOF_PDE_INLINE_NAME	(128-95)

>  #endif
>  	char inline_name[SIZEOF_PDE_INLINE_NAME];
>  } __randomize_layout;

*UGH*

Both to the original state and that kind of "adjustments".
Incidentally, with __bugger_layout in there these expressions
are simply wrong.

If nothing else, I would suggest turning the last one into
	char inline_name[];
in hope that layout won't get... randomized that much and
used

#ifdef CONFIG_64BIT
#define PDE_SIZE 192
#else
#define PDE_SIZE 128
#endif

union __proc_dir_entry {
	char pad[PDE_SIZE];
	struct proc_dir_entry real;
};

#define SIZEOF_PDE_INLINE_NAME (PDE_SIZE - offsetof(struct proc_dir_entry, inline_name))

for constants, adjusted sizeof and sizeof_field when creating
proc_dir_entry_cache and turned proc_root into

union __proc_dir_entry __proc_root = { .real = {
        .low_ino        = PROC_ROOT_INO,
        .namelen        = 5,
        .mode           = S_IFDIR | S_IRUGO | S_IXUGO,
        .nlink          = 2,
        .refcnt         = REFCOUNT_INIT(1),
        .proc_iops      = &proc_root_inode_operations,
        .proc_fops      = &proc_root_operations,
        .parent         = &__proc_root.real,
        .subdir         = RB_ROOT,
        .name           = __proc_root.real.inline_name,
        .inline_name    = "/proc",
}};

#define proc_root __proc_root.real
(or actually used __proc_root.real in all of a 6 places where it remains).

> diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
> index baf1994289ce..7d94fa005b0d 100644
> --- a/fs/proc/proc_net.c
> +++ b/fs/proc/proc_net.c
> @@ -40,7 +40,7 @@ static struct net *get_proc_net(const struct inode *inode)
>  
>  static int seq_open_net(struct inode *inode, struct file *file)
>  {
> -	size_t state_size = PDE(inode)->state_size;
> +	unsigned int state_size = PDE(inode)->state_size;
>  	struct seq_net_private *p;
>  	struct net *net;

<shakes head>
You and your "size_t is evil" crusade...
