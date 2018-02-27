Return-Path: <kernel-hardening-return-11998-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtvoAqAm8ZOgs6JqdTMRrvbZOKvJ58MTGqXaHqg6yUzhWPAvbvBiSFxDD9Z5+mA3fmOQXJE
ARC-Seal: i=1; a=rsa-sha256; t=1519715763; cv=none;
        d=google.com; s=arc-20160816;
        b=Yc94+5Gs7TyFzC8r0Argi0YN+WYaOrOQBf9ggZOPe0TnChsOGAZcZcapdSBPsv4+zH
         r5bA5fzs6SZowN1T4KNvW5ZNmFaCmv28gf3uOzSkvO8iGgL6q1r3rrezNCr6f79vbYXH
         iylUx2c2SejlGQOlFNvA9m6oyFCGRbKtTcUs8RgWjNoB58GNIc3sLR2p20a8XyXvTKTU
         QZSx00DlvmjW9Dk2vsP+amDYWSKcHlptNfhbw/IwfBFD+QMvYNWuzgt+oYsACAywtQ9R
         yqRiMIXVd6Ue1YgFOHxtO8SjjOmsfb+9Irf3PLTzJ4Kd9JJ9whhiQuafYQrtIGz9Ynd4
         Shhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=QXDMlRSW1MAHERXruYlOq1LBbtfirIBS/ZJ76dU+QOg=;
        b=dB4VpnCKaFTP+gaSNjTp5pr9Ov0V83WdanG22XpBJ5cjfPaEOYPUW70iScROX9ExR9
         0xtO9JAc6UqU7E8bQGbDUgYfMbHP7RKHGR6V9dzn/gAUNKIOLwRVYbWsX9qjVeFcB6Hb
         N+fFIEjTwommES9itdW5n/9coo+mWmznfug1Lr1mHQrJjbRBUVAwVk9+G9Bz3Be9xx3g
         dBowFr1l17muCWMe04A+2U0YeQwC89g/MmDLBDeStbYUgvG7D4e7kjIlkl4tX+w3Svr6
         8E/Gwno/r9vI6lj6HzuzZqSsPNb00HWG5ho7DWa/5wldoBbjyGG/eoaJ5Jz6QpdCHLRv
         XJSg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZciMRt9t;
       spf=pass (google.com: domain of kernel-hardening-return-11998-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11998-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZciMRt9t;
       spf=pass (google.com: domain of kernel-hardening-return-11998-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11998-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <1519706711-18580-2-git-send-email-me@tobin.cc>
References: <1519706711-18580-1-git-send-email-me@tobin.cc> <1519706711-18580-2-git-send-email-me@tobin.cc>
From: Alexander Kapshuk <alexander.kapshuk@gmail.com>
Date: Tue, 27 Feb 2018 09:15:03 +0200
Message-ID: <CAJ1xhMWfAZnQXoYVLLf6ABQ1+JsfLyJZmr95-33LH1DFJ5NjXA@mail.gmail.com>
Subject: Re: [PATCH 1/3] leaking_addresses: skip all /proc/PID except /proc/1
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>, Tycho Andersen <tycho@tycho.ws>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593528026509077926?=
X-GMAIL-MSGID: =?utf-8?q?1593537477075314639?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 6:45 AM, Tobin C. Harding <me@tobin.cc> wrote:
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
>                         my $path = "$pwd/$file";
>                         next if (-l $path);
>
> +                       # skip /proc/PID except /proc/1
> +                       next if ($path =~ /\/proc\/(?:[2-9][0-9]*|1[0-9]+)/);
> +
>                         next if (skip($path));
>
>                         if (-d $path) {
> --
> 2.7.4
>

Would something like this do the trick?
perl -e 'foreach my $dir (`ls -d /proc/[0-9]*`){next if($dir !~
"/proc/1\$"); print $dir}'
/proc/1
