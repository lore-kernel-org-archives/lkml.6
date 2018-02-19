Return-Path: <ben.hutchings@codethink.co.uk>
X-Google-Smtp-Source: AH8x225WjVeLpFZAaZjUs2cZz9ksJBe29+SCCRESE89/S3/7hR8IRDzaQR3D/dM/Hl4NivcuFSEx
ARC-Seal: i=1; a=rsa-sha256; t=1519069581; cv=none;
        d=google.com; s=arc-20160816;
        b=hHewp2U09LbVv/v15ePpx24CsG3pG76xl/QMJDpW1iPx0bSqtku+0gXp1PVHZgT0Xz
         0PJ4OcZHq+KVEdy8cdPwCp8RoNhZ65cRGD1F4H4DFAEgquCk3pLfgOtN/mXfPJv2OYdq
         pBOT4zPFNCEJqIDu3xHEyVVUHQuqPNab01jaLOs+BPQfxRuMeyYALYTYdzeLocj+yPRC
         reVKBK8v1ocMdX5qhTnSW0rRYpHnQKpXDGvmYPAIluT49FMOqcNaiVRZ/QDsYKpzhCD0
         Wro5bV7Gmw8CPqQUMlOOxySYIurS1TAi/WBu1fNrjm3ViaXWhm89z30LUZ3tlXCapEg/
         Jk2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=SE7vWyAIXXfmRukYaNDNYycRwN1+aP2MrK5+GwZsRfk=;
        b=bA8YAcrr372zx24PNceHNuDA4mCmF8RHmtOaAuxH4WRRPRQgiTPTiF4mbWvqqVBXb1
         iDbsLtqTKm3N8FxmEhrBHKH/Bdw2S2J7CDVEMlIzDbaWB9qoTqX6H6de7QWxQF06YRSk
         Azq8OCEJIF9cXPoStC6evn9rhd+AFDqs2bA7eSOxp90u2rnkVqUtkArrzvptCofi5jNe
         DlQr3yvUAsGZmH3tbDscgwSI5gqqa8Ae13bqRVPxbEpaPg+wt96ZPg0KPWUhUQhmfo8C
         iICmnlT3AmB1xsHOwqj1WZdD+QFsenfdJE6uu3xjDfiZQ7Z6lLGXTrmK89xjnR5wjZPg
         roLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben.hutchings@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=ben.hutchings@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben.hutchings@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=ben.hutchings@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Message-ID: <1519069573.3422.63.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 60/74] ipv6: fix udpv6 sendmsg crash caused by too
 small MTU
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Mike Maloney <maloney@google.com>, Eric Dumazet <edumazet@google.com>
Cc: stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>, "David S.
 Miller" <davem@davemloft.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>
Date: Mon, 19 Feb 2018 20:46:13 +0100
In-Reply-To: <20180129123850.261403857@linuxfoundation.org>
References: <20180129123847.507563674@linuxfoundation.org>
	 <20180129123850.261403857@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590958513642109340?=
X-GMAIL-MSGID: =?utf-8?q?1592859904830603673?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-01-29 at 13:57 +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Mike Maloney <maloney@google.com>
> 
> 
> [ Upstream commit 749439bfac6e1a2932c582e2699f91d329658196 ]
[...]
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1246,14 +1246,16 @@ static int ip6_setup_cork(struct sock *s
>  	v6_cork->tclass = tclass;
>  	if (rt->dst.flags & DST_XFRM_TUNNEL)
>  		mtu = np->pmtudisc >= IPV6_PMTUDISC_PROBE ?
> -		      rt->dst.dev->mtu : dst_mtu(&rt->dst);
> +		      READ_ONCE(rt->dst.dev->mtu) : dst_mtu(&rt->dst);
>  	else
>  		mtu = np->pmtudisc >= IPV6_PMTUDISC_PROBE ?
> -		      rt->dst.dev->mtu : dst_mtu(rt->dst.path);
> +		      READ_ONCE(rt->dst.dev->mtu) : dst_mtu(rt->dst.path);
>  	if (np->frag_size < mtu) {
>  		if (np->frag_size)
>  			mtu = np->frag_size;
>  	}
> +	if (mtu < IPV6_MIN_MTU)
> +		return -EINVAL;

This error path appears to leak a reference to rt->dst.

Ben.

>  	cork->base.fragsize = mtu;
>  	if (dst_allfrag(rt->dst.path))
>  		cork->base.flags |= IPCORK_ALLFRAG;
> 
> 
> 
-- 
Ben Hutchings
Software Developer, Codethink Ltd.
