Return-Path: <kernel-hardening-return-12398-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuxDbsajBe45C3JTpfjcXnoa/QIlVMD3kDGANLFLkmjJDJ6ql3e9d9j+b5djJ1j0yIj86AP
ARC-Seal: i=1; a=rsa-sha256; t=1520802049; cv=none;
        d=google.com; s=arc-20160816;
        b=KXqKEXHhhzr++f16rVEz9TOrzrHN7/iMzeDKlBsjfaJWxtiAYI/RmK6Ztgu6Hswjp1
         PZjLbSB4IQL4YaK6eFJK5ThGfhLsl4zoskiTgtQqDiT/HfNvDyoxY5xA9H6+o/UlCQkZ
         zhgtFU8jIfylF6jYS0v8xv/Bqaw0su8XSlxwmPPBtRgGmUzzf/7ceOV9BPx9XJHzcVlq
         XLrTIxWLjeyRuonxI6hlCPrG9hdBjHz/Ol1hsdBFwiXfD/EshjussmazGcoyB8tdIN5F
         0HQrMQIAoeGk0eAPtb0z4Ffy3vnhjHAjw7+Iu2SS4lese5mxxOAq97WzzApwOBgvtrml
         7Dvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=LPpA9o+31YNSCe2Z7J5+kMSX2uzBNjv5sK5gaN7WMAM=;
        b=MtYBpFxBTPBC1dWKz7dsplAZuJ5I5mxQX5Jd2FuKE5l9M4LtzL2OpmvWos7+PKnECn
         ssVIPP5bHLoqS6q8jfE4SXzfKFoh10LXRGY+e49iwJoOkvWO69UbFHEAX3YFHjzXOUqN
         GABVu/Oy3FwkfTPqEmlMYjmBNpAgNxfip5tnxTNlmWf5G1s0sBgUotQm668FnVcsFlYc
         CzpaPZ7CODA+/6wXXM9emOZNb9/NaDkkCizvgTAAHtWukYOga9oWRqeWraQx5Yrq72W0
         xjSNVPvQqKTcJRmXiFyVfINAphIe4PnBcsO2ZCqNCmdvHS+ZLctRiC6HV2vk9HF2343a
         DzTg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=gXi0bj3f;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=HozDIO+v;
       spf=pass (google.com: domain of kernel-hardening-return-12398-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12398-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=gXi0bj3f;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=HozDIO+v;
       spf=pass (google.com: domain of kernel-hardening-return-12398-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12398-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:7JilWv2ZWSart8xuoQcd6I5LPmVBF-nboXe4Ed9jlCZMc_yta4pZhA>
Date: Mon, 12 Mar 2018 08:00:24 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Kalle Valo <kvalo@codeaurora.org>
Cc: kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] rsi: Remove stack VLA usage
Message-ID: <20180311210024.GF16734@eros>
References: <1520577493-24603-1-git-send-email-me@tobin.cc>
 <87r2ota625.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r2ota625.fsf@codeaurora.org>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594441103492436943?=
X-GMAIL-MSGID: =?utf-8?q?1594676530348340928?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 09, 2018 at 12:37:06PM +0200, Kalle Valo wrote:
> "Tobin C. Harding" <me@tobin.cc> writes:
> 
> > The kernel would like to have all stack VLA usage removed[1].  rsi uses
> > a VLA based on 'blksize'.  Elsewhere in the SDIO code maximum block size
> > is defined using a magic number.  We can use a pre-processor defined
> > constant and declare the array to maximum size.  We add a check before
> > accessing the array in case of programmer error.
> >
> > [1]: https://lkml.org/lkml/2018/3/7/621
> >
> > Signed-off-by: Tobin C. Harding <me@tobin.cc>
> 
> Please CC linux-wireless list, otherwise patchwork won't see the patch
> and I can't apply it.

No worries Kelle can do, will repost as [RESEND]

thanks,
Tobin.
