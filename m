Return-Path: <kernel-hardening-return-13102-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZoEWizYw73q0XkEq9iwKuLdmXJkSjXknu74/Hws4TjAUm7eBTEszLm1IhZv99IULNDhN5RW
ARC-Seal: i=1; a=rsa-sha256; t=1524539629; cv=none;
        d=google.com; s=arc-20160816;
        b=rSu4SfaDSrbOdmNiK8WYIgUqfgSgspxjFydtkknYhgaIcs0Sn9aQJrDRC3TM5wOSNe
         7+rMENM6V0FawGjXlFxM4Ny/9Vilxs1Ca50/oQgR3ShFHk3HHr5A0lX8db6fF7r8htkF
         Mw3ygfIuM48UYuImC1QNb/J+5rpGNkJbJ3CMQ/yPJaUuMPnC/zbTNb1JWrtkY6vLPn79
         DAQW4lLI7b8mIQ4mGLH/utPBDqi0dxexs0LglQGCgMsHpiE+zxid0qAVdqfWitaWXYeA
         AH0j2d7eMVW/IM4/ERlFew40DgMgYSMT6IBPDRGy5UJHSiYn0qvADp2LUpGUmyPoZNgk
         oVEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=OJqyR4OrhkcwYBtwzsSU8YLhkBfAj/+05OeJn6O3w7Q=;
        b=DGHLuognlfmCxPWhy2Psja3FoqAmnpmvjiXyYawTbPa66wRz9Y3WLvfJejuMeCgShq
         I5khu3HIlso1QG5GDIhwj9HaEZcx1cvlEVKY4b3yUuAjpC30CGhIldL+QqG/hadcBho5
         A++iOwFl+MGN2hUsS3w5KSBAscVRhXlwhLieNeTautDLdWmvtq0D/zEAU5nY6jcWvYhe
         uKQz3s849PVt6UATcXJ6poHCKJ0AhgsJeFL5rolI9GekpHn1MMUHyxpZAacmvYs6EMZb
         Lndjyvw7ddr8qfJAegG3L98KOt4p8SVLwbWk4pumjSyo9WKBpjZ8vvBTb+m5kydak+LK
         ezBQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=M0wY0HWW;
       spf=pass (google.com: domain of kernel-hardening-return-13102-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13102-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=M0wY0HWW;
       spf=pass (google.com: domain of kernel-hardening-return-13102-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13102-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 23 Apr 2018 21:13:24 -0600
From: Tycho Andersen <tycho@tycho.ws>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [PATCH 3/3] dh key: get rid of stack allocated array for zeroes
Message-ID: <20180424031324.GA3125@cisco>
References: <20180424010321.14739-1-tycho@tycho.ws>
 <20180424010321.14739-3-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424010321.14739-3-tycho@tycho.ws>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598589126678197761?=
X-GMAIL-MSGID: =?utf-8?q?1598595666577663120?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 07:03:21PM -0600, Tycho Andersen wrote:
> We're interested in getting rid of all of the stack allocated arrays in
> the kernel: https://lkml.org/lkml/2018/3/7/621
> 
> This case is interesting, since we really just need an array of bytes that
> are zero. The loop already ensures that if the array isn't exactly the
> right size that enough zero bytes will be copied in. So, instead of
> choosing this value to be the size of the hash, let's just choose it to be
> 256, since that is a common size, is not to big, and will not result in too
> many extra iterations of the loop.
> 
> v2: split out from other patch, just hardcode array size instead of
>     dynamically allocating something the right size
> 
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> CC: David Howells <dhowells@redhat.com>
> CC: James Morris <jmorris@namei.org>
> CC: "Serge E. Hallyn" <serge@hallyn.com>
> CC: Eric Biggers <ebiggers3@gmail.com>
> ---
>  security/keys/dh.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/security/keys/dh.c b/security/keys/dh.c
> index 9fecaea6c298..74f8a853872e 100644
> --- a/security/keys/dh.c
> +++ b/security/keys/dh.c
> @@ -162,8 +162,8 @@ static int kdf_ctr(struct kdf_sdesc *sdesc, const u8 *src, unsigned int slen,
>  			goto err;
>  
>  		if (zlen && h) {
> -			u8 tmpbuffer[h];
> -			size_t chunk = min_t(size_t, zlen, h);
> +			u8 tmpbuffer[256];

Whoops, this should be 32, not 256. That shouldn't make any runtime
difference, but it'll closer match the allocation patterns from
before.

I'll let this sit for a bit and send v3.

Tycho
