Return-Path: <SRS0=DzSU=HV=goodmis.org=rostedt@kernel.org>
X-Google-Smtp-Source: AB8JxZrtcDQBZOizH4gqo8ENqAJ6F20NuszEpElYCKHhvOVMHDqzc4pWzZtUvGJMG1AElvypLHwh
ARC-Seal: i=1; a=rsa-sha256; t=1525225145; cv=none;
        d=google.com; s=arc-20160816;
        b=rovlz9WAGdaE8Q0pUJKQR39VaTBtSFIwHObTYFwaSpJEKME/qwJScmU0AoeahTxbF1
         wAHY75RCdI1wh+wrUZ//jSqKwYklpdsSi929DeX9IEDxgp2YzU+Lh3uHkP3YMb8fRzxl
         8e2MfPHaEwniIYB96jkvTyB/k6fFfFWG2qUlMDH0FIHzV+IHsF2bWlZiJNH/xPGvLyj/
         wLZCqSTvingazN+tdS3Wa+NoNZOSYkoOMlHr7rFuga4c7rleRSX6i68miaGxY1pTfEaa
         +DdFt65WzG315QZlcPLkXkgV4FWwgt4jouxod7j31LRoyz8BkR2pYPvtsYeASVxGATEr
         YxAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=DaQvtI4DADD8/3lg6TzKKjmCrEhH/4GgzK1As5qsLKA=;
        b=YVdSbY9RMq00loTGD5GBWSS6lQje0CysrG9tRCudWmIeJXFbGgpFIp0acNi7S8UiMl
         MSBPDaWITmC8dMT4bXMJ+VI3mKVAdlUeORithgXbt7MZ5Ybu+or5rjPW8J13r0V9VP/f
         Y0UpIn/TBnfVM1JK0IxqOzswcnVfg0koDyeymQkimlwkFvjtmz5pJScvW9VQXJOft6h/
         bb3Hny3EPYeGP6iyVjy/Mzm125oOjHpS4vNAqvCdCPhhjLqS/jP83KoQ5JOUpYUSJDo3
         pyMgjoK2OT5FpdDwJeUQ1WUmOr66lslGFZn201KqVfc3r1Tcl4eE6XapKFGDnPbnCwpp
         W93w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of srs0=dzsu=hv=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=DzSU=HV=goodmis.org=rostedt@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of srs0=dzsu=hv=goodmis.org=rostedt@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=DzSU=HV=goodmis.org=rostedt@kernel.org
Date: Tue, 1 May 2018 21:39:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Kees
 Cook <keescook@chromium.org>, Anna-Maria Gleixner
 <anna-maria@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>,
 "Theodore Ts'o" <tytso@mit.edu>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] random: Return nbytes filled from hw RNG
Message-ID: <20180501213902.4ea6bbf9@vmware.local.home>
In-Reply-To: <1525217620-4107-3-git-send-email-me@tobin.cc>
References: <1525217620-4107-1-git-send-email-me@tobin.cc>
	<1525217620-4107-3-git-send-email-me@tobin.cc>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599306642017406992?=
X-GMAIL-MSGID: =?utf-8?q?1599314482381552532?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed,  2 May 2018 09:33:39 +1000
"Tobin C. Harding" <me@tobin.cc> wrote:

> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 031d18b31e0f..3a66507ea60b 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -1725,26 +1725,28 @@ EXPORT_SYMBOL(del_random_ready_callback);
>   * key known by the NSA).  So it's useful if we need the speed, but
>   * only if we're willing to trust the hardware manufacturer not to
>   * have put in a back door.
> + *
> + * Return number of bytes filled in.
>   */
> -void get_random_bytes_arch(void *buf, int nbytes)
> +int __must_check get_random_bytes_arch(void *buf, int nbytes)

The "__must_check" makes no sense in the C file. It belongs in the
header file. There wont be any complaint about it here.

-- Steve


>  {
>  	char *p = buf;



> diff --git a/include/linux/random.h b/include/linux/random.h
> index 2ddf13b4281e..308168c0a637 100644
> --- a/include/linux/random.h
> +++ b/include/linux/random.h
> @@ -38,7 +38,7 @@ extern void get_random_bytes(void *buf, int nbytes);
>  extern int wait_for_random_bytes(void);
>  extern int add_random_ready_callback(struct random_ready_callback *rdy);
>  extern void del_random_ready_callback(struct random_ready_callback *rdy);
> -extern void get_random_bytes_arch(void *buf, int nbytes);
> +extern int get_random_bytes_arch(void *buf, int nbytes);
>  
>  #ifndef MODULE
>  extern const struct file_operations random_fops, urandom_fops;
