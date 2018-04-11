Return-Path: <viro@ftp.linux.org.uk>
X-Google-Smtp-Source: AIpwx4+5Nfxoc2Dohz7CsQcscrMD25iywFpIOrLTMR01MhSUrn1xv0CLT5xD5xXhLWdIGfXViOXg
ARC-Seal: i=1; a=rsa-sha256; t=1523406815; cv=none;
        d=google.com; s=arc-20160816;
        b=E+7SU9YmbvMbdKaWd3OoOVEigCI+mIAYoQGON3LN4H0DMcc9DimG4bU3H2ubkUOF5A
         7q5X9ZCXhRm512jWzcFr3KccyqqoOiDct595p/Hj34HOTA67IUSYd0yF6GvuRYciP0YJ
         ZCYBXV1rT+VcYarqvHTeV+1Cp5OybVrj8Dt/twGlsVfFzXjTTNWGqSARTQhuAOwMct8Q
         3W+LVR/ooqQcHM2JhpX1ZsMuKapeoQueGBpqxhcBnEoKaYmV6muwUXPlIRSrSCXeVGcC
         v6qhWI99QQMZTSPVM3rq6Jp3O81g7YzQ9oO62u2ea0rJWMZrcA+2Ki8gdw90aB+raF7H
         Woyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=pK1qtwsR/x4ltvvb3X9EOLL6JT5Ors2laTQGS8PAHiM=;
        b=vt6DKSD9SRcmjmjadfUnaGaaPQVHP5kwyL4rEraaMnbB3mMjJUpEWappY6xvXejqqj
         aNdF9srClyefW1tluYUTAYoqLDyHAwZb49lWPTngL064DZ/Q+fzaHb+GAqHF6g7fPkjo
         LwrAl2x3BwZRMJm33RMztni/7qJ9e3LgRoAquZhBaYGmbsLN8D7zSeEV/BYQvUKuBi9L
         VN/beUkNpMrRPYqKGjVecE4fn1Ezpgqh4j4upcuhQYCXJDFk0dhfachgoj4TZPGsEExO
         a693JMTubF2serx5XYyOXMVLWkMPV7+2+OQUdO9HLrCSPy3SdjHW8jTyOyyacNp2B4E/
         UHgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of viro@ftp.linux.org.uk designates 195.92.253.2 as permitted sender) smtp.mailfrom=viro@ftp.linux.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of viro@ftp.linux.org.uk designates 195.92.253.2 as permitted sender) smtp.mailfrom=viro@ftp.linux.org.uk
Date: Wed, 11 Apr 2018 01:33:31 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Kyle Spiers <ksspiers@google.com>
Cc: jack@suse.cz, arnd@arndb.de, dhowells@redhat.com,
	gregkh@linuxfoundation.org, keescook@chromium.org, joe@perches.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] isofs compress: Remove VLA usage
Message-ID: <20180411003331.GM30522@ZenIV.linux.org.uk>
References: <20180410234532.185426-1-ksspiers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410234532.185426-1-ksspiers@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: Al Viro <viro@ftp.linux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597404821961766971?=
X-GMAIL-MSGID: =?utf-8?q?1597407824760696303?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 04:45:32PM -0700, Kyle Spiers wrote:
> As part of the effort to remove VLAs from the kernel[1], this changes
> the allocation of the bhs and pages arrays from being on the stack to being
> kcalloc()ed. This also allows for the removal of the explicit zeroing
> of bhs.
> 
> https://lkml.org/lkml/2018/3/7/621

Do you even bother reading the feedback given to such patches?  I'm just
curious,

> @@ -80,7 +81,9 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
>  
>  	/* Because zlib is not thread-safe, do all the I/O at the top. */
>  	blocknum = block_start >> bufshift;
> -	memset(bhs, 0, (needblocks + 1) * sizeof(struct buffer_head *));
> +	bhs = kcalloc(needblocks + 1, sizeof(*bhs), GFP_KERNEL);
> +	if (!bhs)
> +		return -ENOMEM;

... because I distinctly remember comments along the lines of "check what
other failure exits look like in there, such as
                *errp = -EIO;
                return 0;
nearby".

> @@ -330,6 +334,10 @@ static int zisofs_readpage(struct file *file, struct page *page)
>  		full_page = 0;
>  		pcount = 1;
>  	}
> +	pages = kcalloc(max_t(unsigned int, zisofs_pages_per_cblock, 1),
> +					sizeof(*pages), GFP_KERNEL);
> +	if (!pages)
> +		return -ENOMEM;
>  	pages[full_page] = page;

What, in your opinion, is going to unlock that page after that failure exit?
