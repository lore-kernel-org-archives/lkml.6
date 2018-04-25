Return-Path: <kernel-hardening-return-13133-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49wtpyyMEh0b1p+o2QXB63+kPTsRur124bf6WGxVWSYmJ6n6IYMLYemF1JgGatKRUGRn+OD
ARC-Seal: i=1; a=rsa-sha256; t=1524647534; cv=none;
        d=google.com; s=arc-20160816;
        b=fUf/yl66pQgP618kwiwu33hebKqSUSCGkUkeFuhNsyv7TIbuzw4l9oHQSA+kPm2Dlf
         1xMollZqI9tNdo9WgZ+0ZPa4oA8aBVTsrKLL4V7BcdYlHtU5LtaqQfTvy1QDpjhWjQ2f
         by+aArDkKbOfKPVr0Uo8BnP+nteMihV/Bd4vWXIum5yd2z44l/GGboIVcRVI0adxUDAz
         0uQh272lezOx5LHRc4gWFl/y5r+bBjsq2aOJ3XoH0IpM/aVRR6Pj/28ZykC9q6iH0SG6
         sOQCB41juKijBlSy2Q13eK///tvDrMtQx6PEN9Q08Xg6BWmf/fYuJb+joMXZCqiLxVOX
         kbjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=UhrqaoHQqm710R/O1jNlrtUNeSpedUku1ALX1/8JGUE=;
        b=GN3LcvPv0SsV3OxV34LLijObB5zRf4Wyc4XMG84ZJQ8vCGmLX6GQiShgC7pu1ykwOW
         Ztl6KgEMPptR7GAB13OpcUCfQNTxqn8oDswaZgVP8g2p0FnObTII2s2xyTvG3+mnPW4c
         Tx1/G59TEatNTGaq1c8sjOXxZxWeY06EPsccbOrRLGPRSAgThOBhb+m7I0s+pbY8h2bB
         iCmarILoiFNHDW6QjvTJHFWkDr84KQksR6GbZiReyDLQzwcygxeiq2CuGhAEvsXXv3Rq
         cFiUtOveoaVCkmR4pnM3O2b66ylxUugPjGWCfIZKlhLht9IvWphMlSVw47oM6jhbyErf
         w5lA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13133-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13133-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13133-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13133-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 25 Apr 2018 11:11:47 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: Kees Cook <keescook@chromium.org>
Cc: Andreas Christoforou <andreaschristofo@gmail.com>,
 kernel-hardening@lists.openwall.com, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Alexey Kuznetsov
 <kuznet@ms2.inr.ac.ru>, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 ipsec-next] xfrm: remove VLA usage in __xfrm6_sort()
Message-ID: <20180425111147.1ad6d2e1@epycfail>
In-Reply-To: <20180424234651.GA30225@beast>
References: <20180424234651.GA30225@beast>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598673337526933945?=
X-GMAIL-MSGID: =?utf-8?q?1598708813459162218?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Kees,

On Tue, 24 Apr 2018 16:46:51 -0700
Kees Cook <keescook@chromium.org> wrote:

> In the quest to remove all stack VLA usage removed from the kernel[1],
> just use XFRM_MAX_DEPTH as already done for the "class" array. In one
> case, it'll do this loop up to 5, the other caller up to 6.
> 
> [1] https://lkml.org/lkml/2018/3/7/621
> 
> Co-developed-by: Andreas Christoforou <andreaschristofo@gmail.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v3:
> - adjust Subject and commit log (Steffen)
> - use "= { }" instead of memset() (Stefano)
> - reorder variables (Stefano)
> v2:
> - use XFRM_MAX_DEPTH for "count" array (Steffen and Mathias).
> ---
>  net/ipv6/xfrm6_state.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/xfrm6_state.c b/net/ipv6/xfrm6_state.c
> index 16f434791763..eeb44b64ae7f 100644
> --- a/net/ipv6/xfrm6_state.c
> +++ b/net/ipv6/xfrm6_state.c
> @@ -60,9 +60,9 @@ xfrm6_init_temprop(struct xfrm_state *x, const struct xfrm_tmpl *tmpl,
>  static int
>  __xfrm6_sort(void **dst, void **src, int n, int (*cmp)(void *p), int maxclass)
>  {
> -	int i;
> +	int count[XFRM_MAX_DEPTH] = { };
>  	int class[XFRM_MAX_DEPTH];
> -	int count[maxclass];
> +	int i;
>  
>  	memset(count, 0, sizeof(count));

I guess you forgot to remove the memset() here. Just to be clear, I
think this is how it should look like:

--- a/net/ipv6/xfrm6_state.c
+++ b/net/ipv6/xfrm6_state.c
@@ -60,11 +60,9 @@ xfrm6_init_temprop(struct xfrm_state *x, const struct xfrm_tmpl *tmpl,
 static int
 __xfrm6_sort(void **dst, void **src, int n, int (*cmp)(void *p), int maxclass)
 {
-       int i;
+       int count[XFRM_MAX_DEPTH] = { };
        int class[XFRM_MAX_DEPTH];
-       int count[maxclass];
-
-       memset(count, 0, sizeof(count));
+       int i;
 
        for (i = 0; i < n; i++) {
                int c;

-- 
Stefano
