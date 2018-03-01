Return-Path: <kernel-hardening-return-12062-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuH5rhJnPvKu2AvM0rd8B13/48S4e7K4NiGf8w114GSCYIUptONXvvXUJV7PK6onxl1yx/T
ARC-Seal: i=1; a=rsa-sha256; t=1519938411; cv=none;
        d=google.com; s=arc-20160816;
        b=A9+ZEhW5HhjAc9x8Eo1WcIa5G1+IaZBmYBhfeRVJSqwxFHxG3dssctEXl7R28rbwaB
         9STjUTootuQ9QqYytbh4luJUvOv9K8UqCAm4uimBt+X6jlSD8jrVLwCo2nYdjd85tlid
         CqTvRZR+h+v345Zg/bFEDi3GKnW2l8d2S1lwADlYZeFdMAeArERv7CTDFbj0aijLU8JN
         auDBEkuo4s4fB4Mrpcd/DK2hxb17yUJkj+6axya8+Mf8r0AN4RZ3pgFSsLBHEkn5ZxUj
         EktroeKk2R4BvxRE+V8ahmn2LlFU8RcW8ERs/tT0b8hWksnEudo3qM7mepkZP/nEPmLH
         a3oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=viLmldWH8QBzleN79DMe7PMR+/dmwRGA+4gpiTrv4D0=;
        b=ubhOJAo1G9U1/rDRBPeOqpMgKkKEshL59nnfPHxYwx53PuJw72YkmiYSnvGQI7mYeP
         0F2w+25MquGsecRsF+2AvuZgOVzfCmVscbF2uGuAWQaK6PB9iJOVkiEyK4oEK/LLGG7c
         z6d/rlV4Nb3GVRoUrpfx5eO1tTfQyfwMoWZhJIL+2N+EvJCHAy3ShNa4ThkJ82L2cGnc
         Zz9lqMvBB703Q1haG7fP9GkySsD/Sb0ieZAP5Icp7DiwV/RvFlP42iHCs9wG5z2p9voW
         chceWzUVAHOxA+zuhZExpnKP4qXB+Lgp0XVBHV2OfXnFLdoWJuscNRhkKNa7vt3LsiAD
         dGdA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=DMS/YuPq;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=B8q5mYFu;
       spf=pass (google.com: domain of kernel-hardening-return-12062-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12062-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=DMS/YuPq;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=B8q5mYFu;
       spf=pass (google.com: domain of kernel-hardening-return-12062-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12062-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:UmuYWiEGixr43rmkLrhGAy67ujLHf02vAntIO9XCxH2Koagyb61LZw>
Date: Fri, 2 Mar 2018 08:06:23 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: Tycho Andersen <tycho@tycho.ws>, LKML <linux-kernel@vger.kernel.org>,
	Alexander Kapshuk <alexander.kapshuk@gmail.com>
Subject: Re: [PATCH 1/3] leaking_addresses: skip all /proc/PID except /proc/1
Message-ID: <20180301210623.GA15198@eros>
References: <1519706711-18580-1-git-send-email-me@tobin.cc>
 <1519706711-18580-2-git-send-email-me@tobin.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519706711-18580-2-git-send-email-me@tobin.cc>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593528026509077926?=
X-GMAIL-MSGID: =?utf-8?q?1593770939560675035?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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

Perhaps the intent of this is clearer?

			next if (($path =~ /^\/proc\/[0-9]+$/) &&
			     	 ($path !~ /^\/proc\/1$/));


thanks,
Tobin.
