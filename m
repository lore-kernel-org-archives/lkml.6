Return-Path: <slava@dubeyko.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524071463; cv=none;
        d=google.com; s=arc-20160816;
        b=PCVm/V4XPh7v1pBOlIV232ZAZNpRi0Um89Mg2EzF592Emgb0i0zai6Zsh1KQVTtHkF
         NoMhppZnWS4XcrwBlVDvKqYiDYav1YmkaAQJ358YMKqJDYJ8zsQAIpMZsvGh3KajyxwR
         UB+xp8tdjTyJobUBita/+z/RfawcQL/IhzDr3rq5Zt1fczhvgLvFUSuHobWFCIunpUQ2
         qYwMpVSB4GlkuegBARn0VpkDCE3HSXbH4iwEoTBy6xI427X5vV6GltoOpoUTpJ9QYIK1
         qnBEulXWs13B1Rp1bTobF4KySIE/isRvkWQ6StvOJN7EB9rFwmzcPLFaGVlYn6Fl40Zm
         KIbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:dkim-signature
         :arc-authentication-results;
        bh=cSVPMAjgTV8D8ArKAsiOUOYTSMJRmpKS1cC0kXMC9fQ=;
        b=oniatlCsBZlQ6TGjqMlgSUX9kxJajNv4jIX2LmqyUTItWHM5UolckQtVigQ5nXT3Rn
         GdwLDt4LFyHaaBMdVw0ToMVb1L+b3e7lL3aQtFXOjkvKHqvTbmmmwwqPCCLG72cOsdSo
         PSMCZlgjccOlZYzYZzT6yUvLAYnbx5Q+FFt6yWt+CI63PtBoYqPG7H2Trf/FaZcz2oKJ
         WzybRPCWPYG6MzLYkDmvsDhMgR/fvqgr3Ovwbexkzn2s5E5Wr/enXy0gwR73JCEe0xhT
         Xu/nmgc1UI1LJGNfoulLoucQT82iZlmj6U1SUu/xFU+PX8a3WtUNYAArqKNbFR9J8eB8
         SD0A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@dubeyko-com.20150623.gappssmtp.com header.s=20150623 header.b=Q4/QMRGz;
       spf=pass (google.com: domain of slava@dubeyko.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=slava@dubeyko.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@dubeyko-com.20150623.gappssmtp.com header.s=20150623 header.b=Q4/QMRGz;
       spf=pass (google.com: domain of slava@dubeyko.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=slava@dubeyko.com
X-Google-Smtp-Source: AIpwx48mGYMlfxzKhH3iKKecGC17vCWC5LIMJv16ETqjr9X875Y5w6P6yF9cMkuXZXEG9M0kwC9cgA==
Message-ID: <1524071461.2606.8.camel@dubeyko.com>
Subject: Re: [PATCH 2/2] hfsplus: fix potential refcnt problem of nls module
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Chengguang Xu <cgxu519@gmx.com>, linux-fsdevel@vger.kernel.org
Cc: dhowells@redhat.com, kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, pombredanne@nexb.com,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 18 Apr 2018 10:11:01 -0700
In-Reply-To: <1523948733-8537-2-git-send-email-cgxu519@gmx.com>
References: <1523948733-8537-1-git-send-email-cgxu519@gmx.com>
	 <1523948733-8537-2-git-send-email-cgxu519@gmx.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597976104302734055?=
X-GMAIL-MSGID: =?utf-8?q?1598104758832390508?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-04-17 at 15:05 +0800, Chengguang Xu wrote:
> When specifying nls option multiple times in a mount,
> current option parsing will cause inaccurate refcount of nls
> module. Hence, call unload_nls for previous one in this case.
> 
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>


Looks good.

Reviewed-by: Vyacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Vyacheslav Dubeyko.


> ---
>  fs/hfsplus/options.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/hfsplus/options.c b/fs/hfsplus/options.c
> index 047e05c..068d4e2 100644
> --- a/fs/hfsplus/options.c
> +++ b/fs/hfsplus/options.c
> @@ -171,8 +171,10 @@ int hfsplus_parse_options(char *input, struct
> hfsplus_sb_info *sbi)
>  				return 0;
>  			}
>  			p = match_strdup(&args[0]);
> -			if (p)
> +			if (p) {
> +				unload_nls(sbi->nls);
>  				sbi->nls = load_nls(p);
> +			}
>  			if (!sbi->nls) {
>  				pr_err("unable to load nls mapping
> \"%s\"\n",
>  				       p);
