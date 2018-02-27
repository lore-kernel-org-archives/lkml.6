Return-Path: <kernel-hardening-return-11994-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELteuONwBIPuQo3r5/jKCxwxT19HnhXOug99FpcyFIbtDkmYdZeOUi42ZpkvJyD/9ix5HxyO
ARC-Seal: i=1; a=rsa-sha256; t=1519708192; cv=none;
        d=google.com; s=arc-20160816;
        b=fCZCejgS7jvXKB94bRkw2ASBjPLBliKwP+BCGz98nZXAe1T3cSxPalt9r3CuRg8/20
         MP4sJGvOh7X/8zCFu5WVm477kHLJLsJXCv9JzZELPi4nGLT6Wu4t1JLHqRCSmDIHGIfI
         j+LZ9/DUVtA4NiJGd8Zf3FhWesppwe+rwGaya4kgl9Eho0F2Evozmxwh3gihu9dE7i/r
         7v9GLcEDrQPvsT/5em9FDjN0rF6vRQm+u2TJhuoAt/vmiQUrxzwbR/QU+rVEak9Nnj3j
         nhizZBhwLChvC9e8cEn+IJSHN9lPiewM86y2o9TlIOirHCuQroVwCnMdM8PfcDsw2I9W
         q8aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=ghQZ83tV1SR1z/XIvoxkOlqP0dhkQIS0iOu0GTSwTu8=;
        b=o0dwXdkRyB2FN5CfyCOGeYYQdo+7cxz04u8Ixb4IvsPQDTQXAsEPU/ouaE/qGeYvmj
         g/kY4xY4DtRb297V9D7snFeKzT+pgvpuRgfU/7IyoyTTq27Ianm43jrbijVOqHDlXm0j
         +Kh5n4xpV6pgrS0UbdGYPSvjXc4LgVEzNqUAWjgbjQrBd+WNQn7/LSQiu2pBrp1J6Eyx
         qsYhyTwBwD9HiEF2+Gg++CKbvrDC1jucpoPdRx1HZn5YgHM/3l51DMUX49xXHggwsFZg
         BqG6vpM0zIvOb8+uBh/vSJeKvzHn00ETpDtAZilXo6jAyLz/kksEJRjzUOLCjL6A9p9Q
         95Sg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=wgWmQkSE;
       spf=pass (google.com: domain of kernel-hardening-return-11994-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11994-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=wgWmQkSE;
       spf=pass (google.com: domain of kernel-hardening-return-11994-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11994-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 26 Feb 2018 22:09:31 -0700
From: Tycho Andersen <tycho@tycho.ws>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] leaking_addresses: skip all /proc/PID except /proc/1
Message-ID: <20180227050931.4h64hkxglv3ekzsp@cisco>
References: <1519706711-18580-1-git-send-email-me@tobin.cc>
 <1519706711-18580-2-git-send-email-me@tobin.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519706711-18580-2-git-send-email-me@tobin.cc>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593528026509077926?=
X-GMAIL-MSGID: =?utf-8?q?1593529537407989126?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Tobin,

On Tue, Feb 27, 2018 at 03:45:09PM +1100, Tobin C. Harding wrote:
> When the system is idle it is likely that most files under /proc/PID
> will be identical for various processes.  Scanning _all_ the PIDs under
> /proc is unnecessary and implies that we are thoroughly scanning /proc.
> This is _not_ the case because there may be ways userspace can trigger
> creation of /proc files that leak addresses but were not present during
> a scan.  For these two reasons we should exclude all PID directories
> under /proc except '1/'
> 
> Exclude all /proc/PID except /proc/1.
> 
> Signed-off-by: Tobin C. Harding <me@tobin.cc>
> ---
>  scripts/leaking_addresses.pl | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
> index 6e5bc57caeaa..fb40e2828f43 100755
> --- a/scripts/leaking_addresses.pl
> +++ b/scripts/leaking_addresses.pl
> @@ -10,6 +10,14 @@
>  # Use --debug to output path before parsing, this is useful to find files that
>  # cause the script to choke.
>  
> +#
> +# When the system is idle it is likely that most files under /proc/PID will be
> +# identical for various processes.  Scanning _all_ the PIDs under /proc is
> +# unnecessary and implies that we are thoroughly scanning /proc.  This is _not_
> +# the case because there may be ways userspace can trigger creation of /proc
> +# files that leak addresses but were not present during a scan.  For these two
> +# reasons we exclude all PID directories under /proc except '1/'
> +
>  use warnings;
>  use strict;
>  use POSIX;
> @@ -472,6 +480,9 @@ sub walk
>  			my $path = "$pwd/$file";
>  			next if (-l $path);
>  
> +			# skip /proc/PID except /proc/1
> +			next if ($path =~ /\/proc\/(?:[2-9][0-9]*|1[0-9]+)/);

Can't we just do,

substr($path, 0, len("/proc/1/")) eq "/proc/1/" ?

seems much easier to read than the regex.

Cheers,

Tycho
