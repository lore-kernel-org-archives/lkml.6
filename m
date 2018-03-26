Return-Path: <minchan.kim@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522058239; cv=none;
        d=google.com; s=arc-20160816;
        b=0gR6zbyd0Ks+xsbCuqaUAo9X2rymAnlCRaAe7f6X2YMWf9uHJ5SSOT5/Y6a/1sGIm3
         iCiVChg8T0lpptdKgo1TiRmNBkFWBdgS1Eqs57+sPoZKK1TjdAbz6NtYeP111g66RYFm
         sE+BzrPdsL4JdZlFcUSsXBFmZdg9S66+AwOl/JAz3NhsXY+pj8fccsf34l1Y53rStpa4
         t98zqnHTX/c7xFo/GyGclF6lva4VSIYbM3oL9H2F22w4rj69RXquAzmKlj0MJQQT1RQJ
         8taQ8PNqHn7rVN2vwWS+oEYsbbjueaRjPzp1i6Nj11rZLVAho1TEII/+6EaXCnevCfAk
         bgMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=WP11b4IaGiQLASgjxh1JGDtFw/9XpNavcu5ixI/0KA4=;
        b=RdWW2GBWFDlTiRBkjiTYgkxEm5miCly3eRJnAmYg27038kC2Q2HDzERMvX314gSX2Z
         xQiVMdW01wphzLvI4cf8EUA6+U4VXU2Y5OdNhvmxGSs4EHk4LjX0g9fKgLcVtXRyivb7
         La3xTOXrQ8OYJ4QM0EkbzG0onPxlMkt37abWykDWUPf6+5cu7fAhnPl2FwJn0EjjxEio
         ocIFKg6xZZVKF/i8SK2uVbIHeG9S3bsI+OqVAsdr4EwyeifvEpycx4/xmYeQQonh3X0Q
         EHVOXCSyFzK6SrSJ27y8xvYINW2ibYj3gz4dgkZd+6rK20StqC+al2Tv/2uzVXWQ+iPR
         197A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=kKy+sj9B;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=kKy+sj9B;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
X-Google-Smtp-Source: AIpwx4+oIskiyIb53H3pVM4UB6hZQFhZ5u6JFt3qwRa+DnyzYmuFl9P9Dlw+dgTz0Wrqy0ZspyeAJg==
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Mon, 26 Mar 2018 18:57:12 +0900
From: Minchan Kim <minchan@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] zram: idle memory tracking
Message-ID: <20180326095712.GA214483@rodete-desktop-imager.corp.google.com>
References: <20180326064951.123940-1-minchan@kernel.org>
 <20180326064951.123940-2-minchan@kernel.org>
 <20180326081511.GA15432@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326081511.GA15432@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1595993740126920687?=
X-GMAIL-MSGID: =?utf-8?q?1595993740126920687?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 10:15:11AM +0200, Greg KH wrote:
> On Mon, Mar 26, 2018 at 03:49:51PM +0900, Minchan Kim wrote:
> > +static int zram_debugfs_register(struct zram *zram)
> > +{
> > +	struct dentry *ret;
> > +
> > +	if (!zram_debugfs_root)
> > +		return -ENOENT;
> 
> No need to care, you should not error out if debugfs is not enabled or
> not working, your code path should be identical either way.  debugfs is
> not required for any functionality, so don't treat it like it matters :)

Glad to hear. It makes code much clean.

> 
> > +	zram->debugfs_dir = debugfs_create_dir(zram->disk->disk_name,
> > +						zram_debugfs_root);
> > +	if (!zram->debugfs_dir)
> > +		return -ENOMEM;
> 
> No need to check the return value of any debugfs call, you can always
> either use it for future debugfs calls, or ignore it.
> 
> > +	ret = debugfs_create_file("access_time", 0400, zram->debugfs_dir,
> > +				zram, &proc_zram_access_operations);
> > +	if (!ret)
> > +		return -ENOMEM;
> 
> Again, you shouldn't care :)
> 
> > +
> > +	return 0;
> 
> just return void, no need to test any of this.

Thanks for the quick review, Greg.
