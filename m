Return-Path: <akpm@linux-foundation.org>
X-Google-Smtp-Source: AIpwx48nu2aw/GEa4K1RbCc6MVj6BU/Gv+aln4VgTBHWKvPrWB4E7j38JfQc3IQ+tctNQ4qJNVFE
ARC-Seal: i=1; a=rsa-sha256; t=1524080615; cv=none;
        d=google.com; s=arc-20160816;
        b=geSfXUUAldCPTzeCKRzZvZiPUpyICjkhxlpQ3ayHZnJzn/pOgvBE7HoquyAwMqy7PM
         N8dCgBjWuZbuV/wsuHYf8TLXd51lGNBcv6dOvO1pTPCL5GUReaMq3J6Dl87RwHUov7JI
         Rg/G9ivQUxYFYzxn93hnJ1YWXKOYyvz3bSjNbcqS0gQT1PDQARdvaEat9LVsPnJZ8M8q
         ljvcuBNKOMoT/y0qs+M3NTBd0KMeojzR+lQcPEnRdJ75DfvNegR8Vss+a2VhlIPfWF4g
         XNx5sWB8+4HtOBkp5QJBuhsnYL6yTjeMjVpYLL1Fkr61QXd+c2zJMNh1hImFaP8WXb2B
         6Siw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=nah9djZiT1fXujSSfLvtlGQVOvHJgCIJ4wgoqY2/euA=;
        b=HIEeDb0C2rKe193Y/jqwxyr+PxPkjWCCjl18D9bAyXDMYmlKtrdjbFUmyx0/ZMl4MC
         BQPQ9HVPEvEG+Fi9/7WJAeWru5pcxvwIrHN/4On+PHShP8uWcHDnQ3mcY8iNfHzBrvRl
         U50EKETm+ocK7YjqNCfd4FqDNU9kjxNjS7ldXpOcWEnwSmngMrL12i30YdmVunMUEGNn
         8YsxLd9A3z720GbpstVGmPzSb8/6rGBqAyMPP0OKP/3eoBPcj/LVl20HoZrLfE9dPl+e
         JNE//b/e6W+MDX6b/kvos6pI4euqVDC0jRlP24sohzdpajjbX0Ga6+Soy0g6vJZnqyw3
         x9LQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.71 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Date: Wed, 18 Apr 2018 12:43:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Chengguang Xu <cgxu519@gmx.com>
Cc: linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
 kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
 tglx@linutronix.de, pombredanne@nexb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hfsplus: fix potential refcnt problem of nls module
Message-Id: <20180418124332.aac5d1d8f331ce78732836d6@linux-foundation.org>
In-Reply-To: <1523948733-8537-2-git-send-email-cgxu519@gmx.com>
References: <1523948733-8537-1-git-send-email-cgxu519@gmx.com>
	<1523948733-8537-2-git-send-email-cgxu519@gmx.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597976104302734055?=
X-GMAIL-MSGID: =?utf-8?q?1598114355120735408?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 17 Apr 2018 15:05:33 +0800 Chengguang Xu <cgxu519@gmx.com> wrote:

> When specifying nls option multiple times in a mount,
> current option parsing will cause inaccurate refcount of nls
> module. Hence, call unload_nls for previous one in this case.
> 
> --- a/fs/hfsplus/options.c
> +++ b/fs/hfsplus/options.c
> @@ -171,8 +171,10 @@ int hfsplus_parse_options(char *input, struct hfsplus_sb_info *sbi)
>  				return 0;
>  			}
>  			p = match_strdup(&args[0]);
> -			if (p)
> +			if (p) {
> +				unload_nls(sbi->nls);
>  				sbi->nls = load_nls(p);
> +			}
>  			if (!sbi->nls) {
>  				pr_err("unable to load nls mapping \"%s\"\n",
>  				       p);

Same problem as in [patch 1/2]
