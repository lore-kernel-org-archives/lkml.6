Return-Path: <kernel-hardening-return-12066-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsJqLCpU8NN58bgoKjjAIE5iKVvi4nfwRSbQ1UOO90lxPKA3PWLgYGJ38kZz1pgIApygvOd
ARC-Seal: i=1; a=rsa-sha256; t=1519944403; cv=none;
        d=google.com; s=arc-20160816;
        b=ers/9yVRFWUnqEvhnJg6D7eXaBzl01AMgvhhtdg5UhN+8DD1QIeWvCictatvWTYMBg
         OPIE8/DZvOLriKrRt+1kUm5KUVt54tpmwOjXl7wS0+Dflg+HMpodXzaasERSozS/x9bS
         ABiIlbKNQjVIkwGNmzhSEqyN/5h+O/Qmk3GTt4QqZkiYNrttIumz7f00hnKOm37L3bGL
         j/Zxlrt4uUI3Es7lfZduAWNfeSEE+WgdbiTqP7Bfdp9o1Q+ll1bMwat3NBvq9Sgzi0Pa
         nN3hARZ14L9PMLsE8LGS5D1W1vrY8aFgdvBiyJ20ykd1nlEBBq+E2NyojY15mCzB+tX6
         gfjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=GZSTPt8KsBoN0w0B2SU4YMAozuGNvMI/BR5xAR7cYh4=;
        b=nvXlRzo3pCBdrV4qZM0d9WzFPM9BZu2gp4RVia1e6YXs5n1Pwo8ENIcGVoYfvAga6G
         JEMds/9BUdBxvs84azype3hLGxZB51yTU7t47gS8SiTvWbay3wyDez3jyNVQ6JZZUyZs
         CC4baFt8g3O9Y9DN9exNcQ07necwhDcu17VdHtYOAYmtTaYp//yjQOs4G2+rVcpPcCf+
         /UR2H/73YWlLtXRBj5p3aOrE/Dpwk80y8srfCKW5Q+4J1uMQaIcDvRu3tW6CqSEo4L58
         91aE/hqI26z3DzzsTOkY+kALkKcgo9hUtXy8vreUCCyLHdw9n/RjzDtTb5ahqDTj1Wf+
         WwVA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=EbMmZp8l;
       spf=pass (google.com: domain of kernel-hardening-return-12066-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12066-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tycho-ws.20150623.gappssmtp.com header.s=20150623 header.b=EbMmZp8l;
       spf=pass (google.com: domain of kernel-hardening-return-12066-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12066-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 1 Mar 2018 15:46:23 -0700
From: Tycho Andersen <tycho@tycho.ws>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Alexander Kapshuk <alexander.kapshuk@gmail.com>
Subject: Re: [PATCH 1/3] leaking_addresses: skip all /proc/PID except /proc/1
Message-ID: <20180301224623.ehujx7gj26nu54ql@cisco>
References: <1519706711-18580-1-git-send-email-me@tobin.cc>
 <1519706711-18580-2-git-send-email-me@tobin.cc>
 <20180301210623.GA15198@eros>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301210623.GA15198@eros>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593528026509077926?=
X-GMAIL-MSGID: =?utf-8?q?1593777222992283134?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 08:06:23AM +1100, Tobin C. Harding wrote:
> On Tue, Feb 27, 2018 at 03:45:09PM +1100, Tobin C. Harding wrote:
> > When the system is idle it is likely that most files under /proc/PID
> > will be identical for various processes.  Scanning _all_ the PIDs under
> > /proc is unnecessary and implies that we are thoroughly scanning /proc.
> > This is _not_ the case because there may be ways userspace can trigger
> > creation of /proc files that leak addresses but were not present during
> > a scan.  For these two reasons we should exclude all PID directories
> > under /proc except '1/'
> > 
> > Exclude all /proc/PID except /proc/1.
> > 
> > Signed-off-by: Tobin C. Harding <me@tobin.cc>
> > ---
> >  scripts/leaking_addresses.pl | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
> > index 6e5bc57caeaa..fb40e2828f43 100755
> > --- a/scripts/leaking_addresses.pl
> > +++ b/scripts/leaking_addresses.pl
> > @@ -10,6 +10,14 @@
> >  # Use --debug to output path before parsing, this is useful to find files that
> >  # cause the script to choke.
> >  
> > +#
> > +# When the system is idle it is likely that most files under /proc/PID will be
> > +# identical for various processes.  Scanning _all_ the PIDs under /proc is
> > +# unnecessary and implies that we are thoroughly scanning /proc.  This is _not_
> > +# the case because there may be ways userspace can trigger creation of /proc
> > +# files that leak addresses but were not present during a scan.  For these two
> > +# reasons we exclude all PID directories under /proc except '1/'
> > +
> >  use warnings;
> >  use strict;
> >  use POSIX;
> > @@ -472,6 +480,9 @@ sub walk
> >  			my $path = "$pwd/$file";
> >  			next if (-l $path);
> >  
> > +			# skip /proc/PID except /proc/1
> > +			next if ($path =~ /\/proc\/(?:[2-9][0-9]*|1[0-9]+)/);
> 
> Perhaps the intent of this is clearer?
> 
> 			next if (($path =~ /^\/proc\/[0-9]+$/) &&
> 			     	 ($path !~ /^\/proc\/1$/));

+1, works for me.

Cheers,

Tycho
