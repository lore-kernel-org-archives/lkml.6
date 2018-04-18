Return-Path: <slava@dubeyko.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524071458; cv=none;
        d=google.com; s=arc-20160816;
        b=Pi4PbcnslZEK6X1pNHolcBdpOBxf9EDT4JAkVQWe5iyz2gTbEr5LWsqPA4rq3IvdRB
         fXKFAFq/PbcVLYFFjg9rTYc176b2V59Oy7lQtqpFIAQ0a8W09lyBDvOZZW47xIBqYrE7
         lNiSlCRi7zc9aqwBakhF1qmL9jfqde4psUqCrexhNqugqfpqsM1PHpA7uE0azcAGk0WG
         ULdhDbR3Nnch6yZ2usoqDuWXQN9kgYJ7j1QEGSYPTr6de9qO3s3VPxHyxGMD2hobubCH
         t6LzfYTTKBmDOiKSkeU8cagTk/wLzkTuVRfFRSH+OKSJQKNzp+3AKo+oAT+AWE9oWW0b
         NEHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:dkim-signature
         :arc-authentication-results;
        bh=2Q6c0Bc61t5iB28o3BorWXPIiVZJJe8ixEwpKjTazik=;
        b=PM5DrviOYA+KPyCrrdAefyEedgRukV4wmrUzqCDZ2XPoTCG60cZDf8wpmoKPaycMFp
         VLimekASu8FRUt/px5hIfOT/hrXZHnyx3nJo4eY/E/dC1+xxFC3Re8wkt+iP9GtcSIvj
         lizyjW94QAeN9Tv2eM8n01NeLZYoWrYHbD07Uo6zwNUMMA/8G9dWO2T7nnSwoMT82OLf
         tqHIQzBxWqteJbA6/JHLkIQ0aEQrt2T9s5lTz74E6K2iZt9zlOGmNRkwg310O5A3bLn5
         mFZu0IY2sJYsbSwEDSN0nLTRBoxZH3gzhn4YKCqBrvdQAZ0AM3kb8UHgJ5JUiVXbE5xy
         Xgfw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@dubeyko-com.20150623.gappssmtp.com header.s=20150623 header.b=qMlV+tTM;
       spf=pass (google.com: domain of slava@dubeyko.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=slava@dubeyko.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@dubeyko-com.20150623.gappssmtp.com header.s=20150623 header.b=qMlV+tTM;
       spf=pass (google.com: domain of slava@dubeyko.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=slava@dubeyko.com
X-Google-Smtp-Source: AIpwx4+XePyU2CYDxVWi6jT/99pJpcDcvJmMedB120crVNxbOp7Z0kBvGnxzDRn8Zh8IUaoDJ4ZKag==
Message-ID: <1524071456.2606.7.camel@dubeyko.com>
Subject: Re: [PATCH 1/2] hfs: fix potential refcnt problem of nls module
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Chengguang Xu <cgxu519@gmx.com>, linux-fsdevel@vger.kernel.org
Cc: dhowells@redhat.com, kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, pombredanne@nexb.com,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 18 Apr 2018 10:10:56 -0700
In-Reply-To: <1523948733-8537-1-git-send-email-cgxu519@gmx.com>
References: <1523948733-8537-1-git-send-email-cgxu519@gmx.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597976097754652065?=
X-GMAIL-MSGID: =?utf-8?q?1598104753132068531?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-04-17 at 15:05 +0800, Chengguang Xu wrote:
> When specifying iocharset/codepage multiple times in a mount,
> current option parsing will cause inaccurate refcount of nls
> module. Hence, call unload_nls for previous one in this case.
> 
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>


Looks good.

Reviewed-by: Vyacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Vyacheslav Dubeyko.


> ---
>  fs/hfs/super.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index 1738767..6a5f6fd 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -329,8 +329,10 @@ static int parse_options(char *options, struct
> hfs_sb_info *hsb)
>  				return 0;
>  			}
>  			p = match_strdup(&args[0]);
> -			if (p)
> +			if (p) {
> +				unload_nls(hsb->nls_disk);
>  				hsb->nls_disk = load_nls(p);
> +			}
>  			if (!hsb->nls_disk) {
>  				pr_err("unable to load codepage
> \"%s\"\n", p);
>  				kfree(p);
> @@ -344,8 +346,10 @@ static int parse_options(char *options, struct
> hfs_sb_info *hsb)
>  				return 0;
>  			}
>  			p = match_strdup(&args[0]);
> -			if (p)
> +			if (p) {
> +				unload_nls(hsb->nls_io);
>  				hsb->nls_io = load_nls(p);
> +			}
>  			if (!hsb->nls_io) {
>  				pr_err("unable to load iocharset
> \"%s\"\n", p);
>  				kfree(p);
