Return-Path: <akpm@linux-foundation.org>
X-Google-Smtp-Source: AIpwx4/r8oMtd1kRVxlH0XFzIWYLQ6anIEr8yh6UpTwup6zXRFLTVh900xjELiGIwv8n4JZaRX08
ARC-Seal: i=1; a=rsa-sha256; t=1524080572; cv=none;
        d=google.com; s=arc-20160816;
        b=WUjJRC7hqk9IAAyxGi69JdyB2Q+AtJBdGx4xTc51Vmmv2ClfF2CHZH1yPoniI4dOO+
         Pw6VzHJ58OnFeenykURMU1TVJjsPJbFyKz6OMlTZ75CKtQ42eUDTS0vHSFn7aezdADhL
         qVizJ4Vyh52G+sqf67umK/CbBSJPpzFOGNdbAlq5L2O6gQSxrwxCnmoi1B00AHCER6an
         uCgtSaKQNRuLPan3gN7PRtCYRQ+qQLhtUzLm6/Z6sBI2DVm6MjWkikId1cyjPH81n5qj
         AeKfwAjAWEhul1FwOmG/JosapevrkqTQ6zAvUCdhMSlXVLmSuloXaZ+O12P1sHDeFHnG
         vIhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=5nsYo5OGCjWrKFtPPWYRRNINV1USs8XAJA8yYDWwmF0=;
        b=pcksuUnMoeuyaBsJz4+/kHwjN/U+a7RshNyuSPdt6MlycxaCtFko2u0LOJrcu/0X+n
         hR9EpL0VdtpiXT/XywOswdH59FnZ0WKKVH+lVupcOOjLXS/LwbKnSdoKSwXcjmOfqFZE
         kLR/tFPPgJyjFI551TgQ3sC7oEjRvMf/WO1n8Dm9BWgm9UkUa3DUXiA2xTF3wUrgpjfF
         ebsA+TxPkGdVMVv4f/I/QGkzTjmhavtiXYCDbW2RToRTHz3utVdhfKX552aZUEvpXXjG
         0V6kXLRmEKLJ+IZr8+gZZaITEEIVhjHZWtBLUcu630KakoYr971MYzqnoM71TT+mkSWo
         9OAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Date: Wed, 18 Apr 2018 12:42:51 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Chengguang Xu <cgxu519@gmx.com>
Cc: linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
 kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
 tglx@linutronix.de, pombredanne@nexb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hfs: fix potential refcnt problem of nls module
Message-Id: <20180418124251.d66a36cb23673f0d8b152910@linux-foundation.org>
In-Reply-To: <1523948733-8537-1-git-send-email-cgxu519@gmx.com>
References: <1523948733-8537-1-git-send-email-cgxu519@gmx.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597976097754652065?=
X-GMAIL-MSGID: =?utf-8?q?1598114310757576099?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 17 Apr 2018 15:05:32 +0800 Chengguang Xu <cgxu519@gmx.com> wrote:

> When specifying iocharset/codepage multiple times in a mount,
> current option parsing will cause inaccurate refcount of nls
> module. Hence, call unload_nls for previous one in this case.
> 
> ...
>
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -329,8 +329,10 @@ static int parse_options(char *options, struct hfs_sb_info *hsb)
>  				return 0;
>  			}
>  			p = match_strdup(&args[0]);
> -			if (p)
> +			if (p) {
> +				unload_nls(hsb->nls_disk);
>  				hsb->nls_disk = load_nls(p);
> +			}
>  			if (!hsb->nls_disk) {
>  				pr_err("unable to load codepage \"%s\"\n", p);
>  				kfree(p);
> @@ -344,8 +346,10 @@ static int parse_options(char *options, struct hfs_sb_info *hsb)
>  				return 0;
>  			}
>  			p = match_strdup(&args[0]);
> -			if (p)
> +			if (p) {
> +				unload_nls(hsb->nls_io);
>  				hsb->nls_io = load_nls(p);
> +			}
>  			if (!hsb->nls_io) {
>  				pr_err("unable to load iocharset \"%s\"\n", p);
>  				kfree(p);

Confused.

			break;
: 		case opt_codepage:
: 			if (hsb->nls_disk) {
: 				pr_err("unable to change codepage\n");
: 				return 0;
: 			}

Here, hsb->nls_disk is known to be zero.

: 			p = match_strdup(&args[0]);
: 			if (p) {
: 				unload_nls(hsb->nls_disk);

So this will always do unload_nls(0).

: 				hsb->nls_disk = load_nls(p);
: 			}

And the same applies to your opt_iocharset change.
