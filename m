Return-Path: <kernel-hardening-return-13015-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49+NE5RNptXaOEhbAPt8iWvvMv8PcV7QJBYoqMC34FabYSTplQyD0akckPE8ybI6l7NaFGM
ARC-Seal: i=1; a=rsa-sha256; t=1523916856; cv=none;
        d=google.com; s=arc-20160816;
        b=wXClT0eHZuyd/BCaR8JecXLqZHIRqtd59Qv2LDAcj2pKNyqrifFmFDqye+xcckW95Q
         ppHX491cuBHW9Z0wGpEsDSRSuccYFWlSIy0ZwTmcgS3vekod9/vTObtFwb070dFMPRRf
         fciyVqED440aHNwcgF29ftmTvljNjbiDqG9hMRx9vWVNGZW24qFpNWKaLMCX9aEdnYLR
         glLQZFAVHqUBHlyuEJXPFSZwwciky1brM2sD2a+f+QYpj+/J+hQir7wx0kyhO/0bRcFc
         PHAJ3bGL1OYOrMHvwqkr89Subc9/6BsDX8cUEpkEEC0NrSiBSd9mfXunt3GReISl3ahC
         I/NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=llKrn4HPwqtbssHYqK96FBWRjaXk83XIWScR+hn/JeY=;
        b=C38hhFSbEi068Mnzj2Q9VgS+Hoc+njg3jsyfZZgTqV4J62yiMw6STnReW3XK23bjYn
         euKH1bhrBeCRsn2fcRSEi/cQMD12QpGrD85ODS7jBTU2w0XXNdl6pb7SU1rrNdz2PnrP
         ABtXqm4x8eyNkSOCwzmS/kb1PC7PP7l00rD0b7QlUegHaeEYo705GSzfPhZn+wNhQyJE
         ja+tlEqSDFxjtbxV+iqxseReY4hsDDIbNzQzU9xsfhhodOnMC7wGyiDyJwAvZEUidTYc
         Klqy8AQFx/xHlIW9yeQdZ5CyIzpNXkHttiHc2E6hprDh/+OHA+a+ZGTMxPFLUfFdjEwL
         9LMw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13015-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13015-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13015-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13015-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 17 Apr 2018 00:13:48 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: Andreas Christoforou <andreaschristofo@gmail.com>
Cc: keescook@chromium.org, kernel-hardening@lists.openwall.com, Steffen
 Klassert <steffen.klassert@secunet.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI
 <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: ipv6: xfrm6_state: remove VLA usage
Message-ID: <20180417001348.5a2df7c7@epycfail>
In-Reply-To: <1520667645-21975-1-git-send-email-andreaschristofo@gmail.com>
References: <1520667645-21975-1-git-send-email-andreaschristofo@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594535997865166060?=
X-GMAIL-MSGID: =?utf-8?q?1597942641475411553?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Andreas,

On Sat, 10 Mar 2018 09:40:44 +0200
Andreas Christoforou <andreaschristofo@gmail.com> wrote:

> The kernel would like to have all stack VLA usage removed[1].
> Instead of dynamic allocation, just use XFRM_MAX_DEPTH
> as already done for the "class" array, but as per feedback,
> I will not drop maxclass because that changes the behavior.
> In one case, it'll do this loop up to 5, the other
> caller up to 6.
> 
> [1] https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Andreas Christoforou <andreaschristofo@gmail.com>
> ---
> v2:
> - use XFRM_MAX_DEPTH for "count" array (Steffen and Mathias).
> ---
>  net/ipv6/xfrm6_state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
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
>  

I hope this didn't get too confusing. In the end, the change I proposed
for this patch was simply to drop the memset and initialize 'count'
like:

	int count[XFRM_MAX_DEPTH] = { };

and perhaps, while at it, move this before 'int i', for coding style
reasons.

When you re-post, please also take care of Steffen's comment. He
proposed to change the subject to:

	xfrm: remove VLA usage in __xfrm6_sort()

Note that you should give an indication of which tree this patch should
be applied to, by including this in the subject. The current subject
doesn't specify it, it should have been:

	[PATCH v2 ipsec-next] ...

Please see Documentation/networking/netdev-FAQ.txt for the difference
between net and net-next, as the same distinction applies for ipsec and
ipsec-next trees. Thanks.

-- 
Stefano
