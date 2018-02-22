Return-Path: <kernel-hardening-return-11896-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226qQ283fsnUVBPwHRFvzsmXUViAMsOxsWCm9ydCMA1paTWrtl9E2x8rwcextKLspYEaBJHx
ARC-Seal: i=1; a=rsa-sha256; t=1519318733; cv=none;
        d=google.com; s=arc-20160816;
        b=FRTlpFsplhaotXqZmWshBm3JWwjseYOWGQcQMUEcTFM1waOf+wZ/uwVD7xsw9QTdQu
         TMItjSrTH1sZtIHlKLsywbj1UCCHF32zY2EbcUl9cHX15yup3SIY5epb9f6EpyTpWeRV
         1nK8LeOLYJr/cOa3cXvn1t8J9Vu/AiAgrGxnA/h1SYmXak0qv9E+11/cxm8KFMvIGYfJ
         eB9D4R8Ued+0QOw53E6PnrtZnIsX5WyMIE8bmMl1YuQXsV6uZJDU6YnaNQOvQtae7JZc
         oTwPx2VJFaTxx/wlB1lNffBOEzK59bkL6vnhwHgSkfQigGSQAepMYAYgZfVu6Qc4PAfs
         Nw/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=jDqpFOQiJnErCAB3GVhSo32BP/83i/q9s8H1vsT+Exg=;
        b=wrYM6oUY3YZGmn+ahsuKqXdaIcu49F7r/x4BjknwG0BXh71v3mfzSVDV7TdX29kbz9
         yI3qTIl6jQcxs1/fVJmLupxNL3ThBi7keL+iv1fdnLiCidJb9az+OLMpl4RSWoPHyShC
         Khcww99+zz41K6QOMdUILney/XgeMTHz21d24xVSdaekt384nXZtc/BevdcwIoKzbgoq
         85fUpPkF+u0WJfbSEp2o4ZA5IKvsRGihp2nXuPNtNF55RFZTNowXPPOzESV75zRMs98o
         eCghCl6cgVDkVfzSzek50isE7h4GipQVF8v7dGS/OofhHtLemkVpbgJUrEJsWqlHyPUD
         m7Nw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11896-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11896-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11896-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11896-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 22 Feb 2018 16:58:34 +0000
From: Will Deacon <will.deacon@arm.com>
To: Laura Abbott <labbott@redhat.com>
Cc: Alexander Popov <alex.popov@linux.com>,
	Kees Cook <keescook@chromium.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel-hardening@lists.openwall.com, richard.sandiford@arm.com
Subject: Re: [PATCH 1/2] stackleak: Update for arm64
Message-ID: <20180222165834.GC18421@arm.com>
References: <20180221011303.20392-1-labbott@redhat.com>
 <20180221011303.20392-2-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221011303.20392-2-labbott@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592971096374608879?=
X-GMAIL-MSGID: =?utf-8?q?1593121159654031748?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Laura,

On Tue, Feb 20, 2018 at 05:13:02PM -0800, Laura Abbott wrote:
> 
> arm64 has another layer of indirection in the RTL.
> Account for this in the plugin.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  scripts/gcc-plugins/stackleak_plugin.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
> index 6fc991c98d8b..7dfaa027423f 100644
> --- a/scripts/gcc-plugins/stackleak_plugin.c
> +++ b/scripts/gcc-plugins/stackleak_plugin.c
> @@ -244,6 +244,11 @@ static unsigned int stackleak_final_execute(void)
>  		 * that insn.
>  		 */
>  		body = PATTERN(insn);
> +		/* arm64 is different */
> +		if (GET_CODE(body) == PARALLEL) {
> +			body = XEXP(body, 0);
> +			body = XEXP(body, 0);
> +		}

Like most kernel developers, I don't know the first thing about GCC internals
so I asked our GCC team and Richard (CC'd) reckons this should be:

	if (GET_CODE(body) == PARALLEL)
		body = XVECEXP(body, 0, 0);

instead of the hunk above. Can you give that a go instead, please?

Cheers,

Will
