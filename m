Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AG47ELsu5LNh+gLhFVy1J5y56eKV7tnVsG7L0BrgSaF/gIRzolAB2H9tuB3HiuDiGUGaexVfvvSx
ARC-Seal: i=1; a=rsa-sha256; t=1520302408; cv=none;
        d=google.com; s=arc-20160816;
        b=nXZfpBNMtGXx7rcZUgQkCkqm//16tiUfRczccZ1zoDfTjPRdJ7UbLXKXooWaiHZr9/
         +Gs7e5lzABIy0YYwCXKPhNHBmRvVskEnPcjellGFI29y/1Tj+As1aRXGk+jABgR3+Gm3
         mJHaEFbcoUiTLH8fX9Y2PdzvudaH21c2aslfV8XVPjoo2B1QOpdEeldI/SF/+nrkCEl/
         CIahIrQuyt33eETuDRP+HqXJw8gAbpJD+P3aKDIU40GAwv/GfdFQ6jBOgg8CImf6nzGW
         98RF7vLQMogR/O/E4pvfiXF7ElmpIkdS+rQPPdIkHSXOVC1bmWXOc131ShB6MByi30Qb
         lPxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=VpjqfdhR4H9l0zg06SsdMAGI/8xDdwIh8ltDSLPu31s=;
        b=sGlEhkRfibl3lc/34pWkh7Ooe686vExTCqgnKOJaU22pJIeFRHpuQU1rzRNjerzfh3
         qtg2gDd/QKyLGu2ooPXmXqVY3//u/RdqLfJZeq3uwkInDENrmM3rEJQrcbrnuqTsi//q
         jKgI9EgpmkZX6OlR/UHtAiHeS2chpXjX/Kb9M1fxcOZBe3l0rlJuKptjV4jOyxnLIJQm
         tDDOTBb3HmUegXO5k+AumnkFuujM/rjcfxENvkmEywAcYYF4JYyO04tOlHkW5iODcmvr
         t/x8Rizos/s+Wi5pZ0QCuwiFkCgrRjoLLmzHi/wmXAvvV/5AuWlYJ587TSXl2PUhgpK7
         9goQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=hPY7hwNF;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=hPY7hwNF;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
To: Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net
Cc: daniel@iogearbox.net, torvalds@linux-foundation.org,
 gregkh@linuxfoundation.org, mcgrof@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@fb.com, linux-api@vger.kernel.org
References: <20180306013457.1955486-1-ast@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <67abc3a2-80c9-7223-37c2-e15bbecdcd00@infradead.org>
Date: Mon, 5 Mar 2018 18:13:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306013457.1955486-1-ast@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594150201283124044?=
X-GMAIL-MSGID: =?utf-8?q?1594152617683655121?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 03/05/2018 05:34 PM, Alexei Starovoitov wrote:

> diff --git a/kernel/module.c b/kernel/module.c
> index ad2d420024f6..6cfa35795741 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c

> @@ -3669,6 +3683,17 @@ static int load_module(struct load_info *info, const char __user *uargs,
>  	if (err)
>  		goto free_copy;
>  
> +	if (info->hdr->e_type == ET_EXEC) {
> +#ifdef CONFIG_MODULE_SIG
> +		if (!info->sig_ok) {
> +			pr_notice_once("umh %s verification failed: signature and/or required key missing - tainting kernel\n",

That's not a very friendly message to tell a user.  "umh" eh?

> +				       info->file->f_path.dentry->d_name.name);
> +			add_taint(TAINT_UNSIGNED_MODULE, LOCKDEP_STILL_OK);
> +		}

And since the signature failed, why is it being loaded at all?
Is this in the "--force" load path?

> +#endif
> +		return 0;
> +	}
> +
>  	/* Figure out module layout, and allocate all the memory. */
>  	mod = layout_and_allocate(info, flags);
>  	if (IS_ERR(mod)) {

thanks,
-- 
~Randy
