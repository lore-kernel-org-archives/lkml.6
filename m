Return-Path: <kernel-hardening-return-12507-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtEq5K18AlVRQONfGQMCSQ3qPjO9/UWC8fyqruPB7Opizai9RFVOKFeXBy/NovozbXFIGZ5
ARC-Seal: i=1; a=rsa-sha256; t=1520953211; cv=none;
        d=google.com; s=arc-20160816;
        b=wjx++p4Zz41FZW7etfnZls5rDBZbDc/TJPwhrW5t5qKPlEARiQYJzkLbMR4mOb2JJP
         JuV+esiGS9d6ikvMvUOrfq0AZwPK7aiKBorUV7EvuxvnHhbVJO4HgZxit9J3X4JzMnFT
         dsjNwZtlxfXvQA3cHOAgVgQk7MA1XcbYDHGVfYEXNwhLbP3ijtQ1iDjxZGKJR6xhD+Y+
         yFJCHv15Ty5+TP1vsGCpHj0MWcCZI1zSgVf839tycdKOSzemi9hgzE3Xbe2MFTbnShpR
         y/6WIxqwE1LKgYHtichC4vm6lRKkHfOo3BowZkXlEHCeYI0Hqouv3oo2XHNcJjW+uZQb
         NHKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=3NvITnLwJLOjM2P5OeUXjR75eMLPXNFV080Vlt0YJN4=;
        b=WuxZ4+6aRaK9XJK6+AvBXqT8WUoMkjlOm0BV6d5dolRFIkp0ocjvOGleCr0GXgOYoV
         tdnrOj6L5aHVrXnwV3RFz1hvX1HANb34gR50MWG4Ne8jpuKH51Per195SJ3R+nsray5m
         +JEz0rPRPk/RFy7zOUpzh6cN7vpK3DCBm4ircuD4P0qxlAzeRS36b2b7HXwDul3Jmw6J
         4lv3u1DhRLcDRL4CkSIJNujvwAoA8t3Q/R9OGyVwdboMG5XKPr0dNBcwgrLAY8Oa+pRh
         n96vOHlKb9Qi95CwOd2iascCifwKfj5FKPCZcKf5Auiadcx5qptGRSx9pP8RqGVdti7h
         CgFw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12507-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12507-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12507-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12507-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 13 Mar 2018 15:59:47 +0100
X-SMTPAUTHUS: auth mail.us.es
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Joe Perches <joe@perches.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] netfilter: cttimeout: remove VLA usage
Message-ID: <20180313145947.tpekwvyioaft5auc@salvia>
References: <20180312231442.GA22071@embeddedgus>
 <1520899118.2049.24.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520899118.2049.24.camel@perches.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594775688476268511?=
X-GMAIL-MSGID: =?utf-8?q?1594835034180607827?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 04:58:38PM -0700, Joe Perches wrote:
> On Mon, 2018-03-12 at 18:14 -0500, Gustavo A. R. Silva wrote:
> > In preparation to enabling -Wvla, remove VLA and replace it
> > with dynamic memory allocation.
> > 
> > From a security viewpoint, the use of Variable Length Arrays can be
> > a vector for stack overflow attacks. Also, in general, as the code
> > evolves it is easy to lose track of how big a VLA can get. Thus, we
> > can end up having segfaults that are hard to debug.
> > 
> > Also, fixed as part of the directive to remove all VLAs from
> []
> > diff --git a/net/netfilter/nfnetlink_cttimeout.c b/net/netfilter/nfnetlink_cttimeout.c
> []
> > @@ -51,19 +51,27 @@ ctnl_timeout_parse_policy(void *timeouts,
> >  			  const struct nf_conntrack_l4proto *l4proto,
> >  			  struct net *net, const struct nlattr *attr)
> >  {
> > +	struct nlattr **tb;
> >  	int ret = 0;
> >  
> > -	if (likely(l4proto->ctnl_timeout.nlattr_to_obj)) {
> > -		struct nlattr *tb[l4proto->ctnl_timeout.nlattr_max+1];
> > +	if (!l4proto->ctnl_timeout.nlattr_to_obj)
> > +		return 0;
> 
> Why not
> 	if unlikely(!...)

This is control plane code - not packet path - I think we should just
let the compiler decide on this one, not really need to provide an
explicit hint here.
