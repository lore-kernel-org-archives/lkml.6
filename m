Return-Path: <kernel-hardening-return-13008-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx48Atgvy+ktcvVWwdhVXUpyPgPF7yuc2X1sOIsMpYUKpuE2ZK4CTQoPkbwEfy0ysa2RNYHfc
ARC-Seal: i=1; a=rsa-sha256; t=1523871630; cv=none;
        d=google.com; s=arc-20160816;
        b=zHEf6dyC3QyvN5Uhm+mKxbGDyNvLRiegvNkyENnhVzD7awFYV7R0WCR+I47SyYQIwZ
         VJCVXIhT+Ll8GYHfQcIXtWAiCNNDDUR0TVsuMxCv0Tuce5anAX8Vv5VumUzVQbXYkK0d
         GqVbQFbaH3+EGyDQgCqheXSO0jYF5LAYWX31Ojqm39/t/onhYalq6Yeox+GFRqpkZmZP
         +RKsiIEBp+LiDwI2VtHsDkjbuFj9EJoP1Du8qzi6Sjg8KsOsa5Kpa87kzZprSY+xlfGV
         8RjKHFPnGNI6fF3Ek6UX3y31wbFu6VjyCcT/4xGwLAIkN9q1JQgNPg2u9dvkAG9jS/Jc
         ebJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=tHLVbh7OfgkyX/fwEdPPeyWW9h8PuXa79SBPQId2mkY=;
        b=MXzQPoh2kSD3wdnjJ2wqZ3IQ4rcRdQLNY9QBojceTg572ukcNOtkVK6LFnM7AnT4Ij
         Gq6VSiXsC6uBece4j81N+T0tgGzMtDiDxYAUBQ3ic/7eZ9Or/6SvcEvroc3yqHUIR66X
         SqXD8KZUP3dE/CzDOF80Z2elUBzNPq5KiPdBTt/GS/ANY4PQIr/IDcfTwulEjqEhZKBS
         E19yce73Fow3nWLU8DG5y28GFFWdUIdxncaoamfR8qNRgVgKnH7+KoGcxd7WpSskT1qR
         ssOqHBRtZzFzuhiLjo8u60hSD3H4yvSgiSd2QzrXRc0y2qgW/YwSSV+Yy1RedJ4Fd+An
         QsJA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ws+RLAXO;
       spf=pass (google.com: domain of kernel-hardening-return-13008-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13008-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ws+RLAXO;
       spf=pass (google.com: domain of kernel-hardening-return-13008-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13008-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 16 Apr 2018 11:40:07 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Laura Abbott <labbott@redhat.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org, xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH] x86/xen: Remove use of VLAs
Message-ID: <20180416094007.diuobump2qxraybx@gmail.com>
References: <20180413221146.28476-1-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413221146.28476-1-labbott@redhat.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597670729617678421?=
X-GMAIL-MSGID: =?utf-8?q?1597895219048226986?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Laura Abbott <labbott@redhat.com> wrote:

> There's an ongoing effort to remove VLAs[1] from the kernel to eventually
> turn on -Wvla. The few VLAs in use have an upper bound based on a size
> of 64K. This doesn't produce an excessively large stack so just switch
> the upper bound.
> 
> [1] https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
>  arch/x86/xen/enlighten_pv.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> index c36d23aa6c35..d96a5a535cbb 100644
> --- a/arch/x86/xen/enlighten_pv.c
> +++ b/arch/x86/xen/enlighten_pv.c
> @@ -421,8 +421,7 @@ static void xen_load_gdt(const struct desc_ptr *dtr)
>  {
>  	unsigned long va = dtr->address;
>  	unsigned int size = dtr->size + 1;
> -	unsigned pages = DIV_ROUND_UP(size, PAGE_SIZE);
> -	unsigned long frames[pages];
> +	unsigned long frames[DIV_ROUND_UP(SZ_64K, PAGE_SIZE)];
>  	int f;
>  
>  	/*
> @@ -470,8 +469,7 @@ static void __init xen_load_gdt_boot(const struct desc_ptr *dtr)
>  {
>  	unsigned long va = dtr->address;
>  	unsigned int size = dtr->size + 1;
> -	unsigned pages = DIV_ROUND_UP(size, PAGE_SIZE);
> -	unsigned long frames[pages];
> +	unsigned long frames[DIV_ROUND_UP(SZ_64K, PAGE_SIZE)];
>  	int f;

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
