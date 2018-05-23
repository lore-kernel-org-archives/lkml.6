Return-Path: <willy@infradead.org>
X-Google-Smtp-Source: AB8JxZraQmYuPy33sahWlaF7UtF0dWtSF8tLCrN+E8oXMpn+MF5Zu7YjFv1G1QhAA23E8zb/IPNG
ARC-Seal: i=1; a=rsa-sha256; t=1527074908; cv=none;
        d=google.com; s=arc-20160816;
        b=cOD5JQUpvRoJuT8647xKa45hZgPWUcfM3DkyAI6TPyZWsaNFhKgVGZxhPuxTen50Jc
         lN5J67sIZp7HyW2h+N/WEnD6c3+SoAmA74Oj3mLeI0TITZJuzY8VVOMSuymwpAITCygO
         I3Mg1Xr2RXITNtWlAxAHAOyF68OImL4gDAGhgqH7Tk7ulTKH+sAaj9VaK/2PYPzn7nCs
         0UsDA79XIRLKtlZL8P/Vlj0dyZcmwpxlkAp4cmRk3inGtLBZSEr3DqyuBI2lm/TzekJI
         0KCFc1BQ8EnRn2EMG5r4yAxa2PMNj8Kyynr9xbqyqdhvvXZJROycmtGbM9mFwAmKLIIc
         3vag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=tdLXb5WgbrHERVENdOL+FKIm9Jm1ErHnlq0dBg1xPdE=;
        b=uXpPcBmX8VW7B6jlwYxulViBbCJzREAuBL4spzeXY3GBVsIcElha+mvAI9LIbXGMsB
         z6GswzwWvfpU8vN2w3yyDU8M/mSnrKYWWoP4n4vWmmMQJ5CHfMKO4WFamLGGoaz1tGue
         ET4JMYUKdiSOcjOAb+ecmkxx446CFaNd2rvv2o+Adt5L78zgpk2nta9MXPxybSkPGdhI
         yYsApRJpzIrLSSwX4jz0k8B3jmi3Y4BUSbjWQerZHJrcNIHf5FCkpCKzhRgEbLORL77j
         bACP3jtGff8pM5fIaDB3MGfiw1pP6cYunNulYKw1hqkoBlWLuvnUnfMVLDre0TPtUCgs
         BhKA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=KBD1fq5E;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=willy@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=KBD1fq5E;
       spf=pass (google.com: best guess record for domain of willy@infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=willy@infradead.org
Date: Wed, 23 May 2018 04:28:23 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org, gregkh@linuxfoundation.org,
	linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
	dev@openvswitch.org, shli@kernel.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH 2/6] proc: commit to genradix
Message-ID: <20180523112823.GA19987@bombadil.infradead.org>
References: <20180523011821.12165-1-kent.overstreet@gmail.com>
 <20180523011821.12165-2-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523011821.12165-2-kent.overstreet@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601215737590926779?=
X-GMAIL-MSGID: =?utf-8?q?1601254099942102923?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 22, 2018 at 09:18:17PM -0400, Kent Overstreet wrote:
> @@ -2140,11 +2140,12 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
>  	struct task_struct *task;
>  	struct mm_struct *mm;
>  	unsigned long nr_files, pos, i;
> -	struct flex_array *fa = NULL;
> -	struct map_files_info info;
> +	GENRADIX(struct map_files_info) fa;
>  	struct map_files_info *p;
>  	int ret;
>  
> +	genradix_init(&fa);

Could we have a DEFINE_GENRADIX(type, name) which initialises the tree?
