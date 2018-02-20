Return-Path: <nicolas.pitre@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519143990; cv=none;
        d=google.com; s=arc-20160816;
        b=ZvV/oQkMD1MY26qA7L83IjvQMbynQ6o/5nyLAxO7TwzsAyXwG6ObwSwj4ZT+AVRF4b
         zy59hNld8dbCR0rFQ2v2fmOGiFTrWD+msqAZ4U6Rw7gFrk6SgZ7MeueUlTS7sSeR//to
         yZEytBqcZv6zBkL4gJ1khjxnjNGatxTIZY7PJ8Bdj1Y52hlTCU2k++7Z5qlTefAFQ1El
         RvXsD7SS1FbcrBBwb57x8Ia0l5ma7dFQQqgZElDZb2ZNSJxnbks6t8ryf9kjWurID7ot
         ZK40CwrArQQyMzC5qsnkY3HjtZbVCNxeJVCYda1NWYeNmR7uK6FM5hIle01FcFiLWTOh
         LERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=d5H+wDCMbC4VQe2cY8bzilCgKnhBy95cBPO+HyFN51Y=;
        b=HQP+5087v4DboaBetbvyAosQXXXkGxy4h7ChHHv0iWWex/qjxRbOPIgtJDOgqLXC9L
         lJ1u8jl26xOho7EMaSgUhM4YToogwfiOH2rQfSH2kyg/XBuuAaeBFkODe03c5cBPeB4O
         VIOpIopkol/rvgirumwwhWSADhtADDCJzeu5b+xzdXDq8BUSNVnVgR/jQKibph4Ve5Qc
         0wPf5c4TOa3MHyv6AQTQxc1NQbKGbsLgfRS0iUScj6JC1xwl4XVMCAdu98tN0j7mpbDh
         yUBadVivsyogfitawxvL+poZUuQu3mhBpgtloMZKbFv1+x8qahERA2lOBhvxQdl6+oLj
         79Qw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Js5/gWa9;
       spf=pass (google.com: domain of nicolas.pitre@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=nicolas.pitre@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Js5/gWa9;
       spf=pass (google.com: domain of nicolas.pitre@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=nicolas.pitre@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AH8x225rIOcflsyRPoUuF4Fb05lByNCp4+QTZOTjBPAMUIrgqctqONJgQm5ib4178HK2iGP9dvQQcw==
Date: Tue, 20 Feb 2018 11:26:28 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Richard Weinberger <richard@nod.at>
cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Kate Stewart <kstewart@linuxfoundation.org>,
    Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
    Andrew Morton <akpm@linux-foundation.org>, david@sigma-star.at,
    kbuild-all@01.org, Sam Ravnborg <sam@ravnborg.org>,
    Arnaud Lacombe <lacombar@gmail.com>,
    Nick Bowler <nbowler@elliptictech.com>, Michal Marek <mmarek@suse.cz>,
    Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v2] kbuild: Don't source kernel config
In-Reply-To: <1919455.eZKeABUfgV@blindfold>
Message-ID: <nycvar.YSQ.7.76.1802201125210.31644@knanqh.ubzr>
References: <20180219092245.26404-1-richard@nod.at> <14335276.CH3Xr2i6I8@blindfold> <CAK7LNAQT8jEHt39xG7BvMMWjObdvCCpPhJAA83LFut4ewUVQsg@mail.gmail.com> <1919455.eZKeABUfgV@blindfold>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592820606337824892?=
X-GMAIL-MSGID: =?utf-8?q?1592937929325855376?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 20 Feb 2018, Richard Weinberger wrote:

> An alternate approach would be this:
> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> index 5c12dc91ef34..ff0a7c62344b 100644
> --- a/scripts/kconfig/confdata.c
> +++ b/scripts/kconfig/confdata.c
> @@ -161,6 +161,13 @@ static int conf_set_sym_val(struct symbol *sym, int def, 
> int def_flags, char *p)
>  	case S_STRING:
>  		if (*p++ != '"')
>  			break;
> +
> +		p2 = strpbrk(p, "`$");
> +		if (p2 && !(p2[0] == '$' && p2[1] != '(')) {
> +			conf_warning("string contains forbidden characters");
> +			return 1;
> +		}
> +
>  		for (p2 = p; (p2 = strpbrk(p2, "\"\\")); p2++) {
>  			if (*p2 == '"') {
>  				*p2 = 0;
> 
> That way the conf tool will sanitize the .config before shell scripts will 
> source it.

Looks like a much saner approach to me indeed.


Nicolas
