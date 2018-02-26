Return-Path: <kernel-hardening-return-11955-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELviOXfLwro/bhLwM2Q6Jvixq8gMYUUFfi58frz0elAVbNKTaBJfjKNwl10MR756pr7u+iE+
ARC-Seal: i=1; a=rsa-sha256; t=1519610514; cv=none;
        d=google.com; s=arc-20160816;
        b=yZlQ2o2136rQfxRm32bdPB5M397RUutmAhr5A64WYA260PXekS5Awy6RxLy4UTaRuy
         BVWR8PF8t+dj6Doylo5+bh3DF6dl7DW1YHgowSWNTuN5U4G5rj637kqh/DUbS7/cinlc
         F2RWf/Imo8JBqIE01kzi9kmmOF9yQb0HgPxsHMNr4VaoCrGCp2v21wnJnnJH6eQs4hJ1
         /UsKb7y4AeDrv5I0GPagZSUEw9FmXVZv1H/6U2hTRtiufK7b0zEnUxroB5JH5SaB3t5w
         5L9RL+dS5+qcF+XrOXo0ofhFLyPjDtUpcljib2V/FMyR0lZ3s/jddupULOeLNYBZ4Kwc
         QN5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=bn2TvKO69NbKdfqbrQA9wa9T4E5KsVDfameyBqIHyB8=;
        b=lOyNJAFGqo2UJUDO55M1jk2HGPzwv3QFC/+fbGp0zO99fujOoRNSZx1KQjWsSS6Buo
         YE6nyUk6JZxUuHnRZ9N9OXbTL5hjINI+v7kTH7V9Ew/dCs4Do2smkcOw28RMeuNyfQKK
         TwnK4UFy1XOLscOS8Hh4Hch1w6dhx97tx0uiLbkYtT3eX7eeB5v5GYZd8trz1F2cyZgD
         e3+Q3XDOqjPHtF4JHYSni4es809begSP/tgRet4G7GD7U4+4AgGx7YJUdoGwk/5Q6Y3W
         qK1MGoYtXqC3Z5S7f/n+RGXYDZDLpn+z3Wgm1kqn2Hz8H2aYicRecL6+OVSfhbD7V7SV
         GSTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=DfAol2/j;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=BYXR0TMZ;
       spf=pass (google.com: domain of kernel-hardening-return-11955-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11955-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=DfAol2/j;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=BYXR0TMZ;
       spf=pass (google.com: domain of kernel-hardening-return-11955-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11955-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:f2qTWrsF1T0XC24_qZM81lyGyYrlXlbr6ezfB0x_0Jh9m9R_PpdiHQ>
Date: Mon, 26 Feb 2018 13:01:32 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Tycho Andersen <tycho@tycho.ws>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] leaking_addresses: add scan_once array
Message-ID: <20180226020132.GF2808@eros>
References: <1519008649-15782-1-git-send-email-me@tobin.cc>
 <1519008649-15782-5-git-send-email-me@tobin.cc>
 <20180226010953.37z3sz3rwcnj426k@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226010953.37z3sz3rwcnj426k@cisco>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592796084722705424?=
X-GMAIL-MSGID: =?utf-8?q?1593427114552099653?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 25, 2018 at 06:09:53PM -0700, Tycho Andersen wrote:
> Hi Tobin,
> 
> On Mon, Feb 19, 2018 at 01:50:49PM +1100, Tobin C. Harding wrote:
> > +sub already_scanned
> > +{
> > +	my ($filename) = @_;
> > +	state %seen;
> > +
> > +	foreach (@once_only) {
> > +		if (/^$filename$/) {
> > +			if ($seen{$_} == 1) {
> 
> This should be something like,
> 
> if (($seen{$_} //= 0) == 1) {
> 
> otherwise I get a bunch of uninitialized warnings,
> 
> Use of uninitialized value in pattern match (m//) at /usr/share/perl/5.26/Math/BigInt.pm line 1199.
>     Math::BigInt::bcmp(Math::BigInt=HASH(0x55dc2f7e4580), undef) called at /usr/share/perl/5.26/Math/BigInt.pm line 1257
>     Math::BigInt::beq(Math::BigInt=HASH(0x55dc2f7e4580), undef) called at /usr/share/perl/5.26/Math/BigInt.pm line 105
>     Math::BigInt::__ANON__(Math::BigInt=HASH(0x55dc2f7e4580), undef, 1) called at ./leaking_addresses.pl line 422
>     main::already_scanned("smaps") called at ./leaking_addresses.pl line 448
>     main::skip("/proc/1/smaps") called at ./leaking_addresses.pl line 509
>     main::walk("/proc", "/sys") called at ./leaking_addresses.pl line 159
> 
> Tycho

Cool, thanks.  Will fix and re-spin.


	Tobin
