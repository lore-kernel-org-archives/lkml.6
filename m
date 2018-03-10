Return-Path: <kernel-hardening-return-12382-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvHYuvzpnYUFM22OW6951qu7e4ugEm26pdbxTc+QF7saapPGKRXMmGFigFz868zrPjVQmuh
ARC-Seal: i=1; a=rsa-sha256; t=1520707317; cv=none;
        d=google.com; s=arc-20160816;
        b=lpipCkVFJd3jbAg1sS73/CpCUizbCI0wGwj3YTLebrD1aHjt+qIsLUqDstZJLrNyXe
         WP1EhNK5cJrR1WdZ0OJpr96/m7jkVptbvZdjoTRESA7X+0J17Z4VwVxpCod0rwuF2iAo
         CsISi9tF7vSYUb8fVr6RaytYHQd+tUAPX0RUXB+o8xxlvTRSjEaYbQATbOI44dfZgWxJ
         a2iN82zcJwNB3N109hZZcghijx37XTga40yB5sXHbjSm1GwfuXOcddrX7AJvJeGE+7CV
         OkYepkkj0a2QDpZjvWuQGro/4A+M/VG5Pu6qALfHJczAOZ5DOyyy+9iR/KE2qB2Be1ev
         TOdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:delivered-to
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=yq2M4pPUzUvJR6LfQjVlr4UMQbE3dnP8jQc3iNnoRfQ=;
        b=hOxGBvHY+fMRvvSxv/yon38FqXtITAFvbV5fHgZs2zyA95gWbqJ2XXTpCgGOsXfVlH
         UM5UE6FQy70skFzEKgfM3gX9gnwpvBZRce/mkzDYvxq1u3Lj/jd7mUY4xrHugc8AXwoZ
         mPkN+4/gu0XFGg/guzVrh9f2Pp4JiuEThi/rJYIB3D7gtr6VHzf14xiBoOCv36rV1TOw
         9zthNeMwe6Qen1Ij3F+I8ICWhowYd0HJwGVwSR7UIrK+96iDCBuaBOimu+jGYV/F9dku
         2sy9ccIiSb7GH7eGlqdQ7EBxq/bAzEOTuRncAZQlilQYKpini1BCpzv4tXaiaxI8pay/
         iY+A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12382-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12382-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12382-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12382-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Sat, 10 Mar 2018 09:43:27 +0100
From: Stefano Brivio <sbrivio@redhat.com>
To: Andreas Christoforou <andreaschristofo@gmail.com>
Cc: keescook@chromium.org, kernel-hardening@lists.openwall.com, Steffen
 Klassert <steffen.klassert@secunet.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI
 <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: ipv6: xfrm6_state: remove VLA usage
Message-ID: <20180310094327.685d181d@epycfail>
In-Reply-To: <1520667645-21975-1-git-send-email-andreaschristofo@gmail.com>
References: <1520667645-21975-1-git-send-email-andreaschristofo@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594535997865166060?=
X-GMAIL-MSGID: =?utf-8?q?1594577196649670266?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 10 Mar 2018 09:40:44 +0200
Andreas Christoforou <andreaschristofo@gmail.com> wrote:

> diff --git a/net/ipv6/xfrm6_state.c b/net/ipv6/xfrm6_state.c
> index b15075a..270a53a 100644
> --- a/net/ipv6/xfrm6_state.c
> +++ b/net/ipv6/xfrm6_state.c
> @@ -62,7 +62,7 @@ __xfrm6_sort(void **dst, void **src, int n, int (*cmp)(void *p), int maxclass)
>  {
>  	int i;
>  	int class[XFRM_MAX_DEPTH];
> -	int count[maxclass];
> +	int count[XFRM_MAX_DEPTH];
>  
>  	memset(count, 0, sizeof(count));

Can you perhaps initialize 'count' instead of calling memset(), now?

-- 
Stefano
