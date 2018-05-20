Return-Path: <sam@ravnborg.org>
X-Google-Smtp-Source: AB8JxZrLFmOGM4vUJLybJmlCf5GtqVhI0bsPTh6tBmWQT95kHhVNy27b57//E4zEqtWcHlFwo2nl
ARC-Seal: i=1; a=rsa-sha256; t=1526810764; cv=none;
        d=google.com; s=arc-20160816;
        b=QPfKoz0KY47C2ElxTCby2X1ZwJ6LZ/76jorCjZgC9oiN2eBxoFug3l5T/ling6HcoE
         imkUIb/CT96KDWgRre6PVHnJA/DoXn65M5VeAnyP/5mRZc6XR5hJsZAuuauDKlfOaqru
         5Hl7G2vqSLa1kwOaVfpyLx/6H0W3WD2ORnYguRrNcsi2W1LdJokFQjMOBsRgjOGyZRaK
         AghIXz6ofgdrGQNxTjvQrqRE3YAKV+BNfeBTr8jwDwNJBpxBQwZo/WHAKTmVHYEotPue
         AemPyQtPgJ6yk9OZLylvY5dGlUqxX4+ocx7JFuzl8ZDZrOlbXQOd4FjU38sJqgDKoYrl
         2Mdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=KteYIjGkFlOWxybSU+K95v6mrtZkQuAoe8kLJWtlqiA=;
        b=mYk6OVEBs0BGvsCvwIMociNTFID7AToPrGHABtRonnoB8XfhOUrFKirOGdI1G2hmhX
         9AdukJCxawK8oL4iwVgtfr35pKobvrtkyAzrugfMXBF1ojG/CVRzMNff1Wb7n6T7Ruab
         aC/ADPimyUNblfsJ8qGg3S6eCyNkU4FZOdgJPatFMZP2luTc/5xISWa3sNXxlXwILwLV
         GWffkyQqvjiXRKT9DQ+38qcsH0CrOjniMfWDB3I1ExNPI9SGCMcoK1yIk+RbasXXkAXt
         nu8aWAtuWZ7fiet4hCYl0sD1Ro2se9q/8TaLTzbslTx6WR5Recw5rC6W1kCqtN9iulFL
         I2Jg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 109.247.116.14 is neither permitted nor denied by best guess record for domain of sam@ravnborg.org) smtp.mailfrom=sam@ravnborg.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 109.247.116.14 is neither permitted nor denied by best guess record for domain of sam@ravnborg.org) smtp.mailfrom=sam@ravnborg.org
Date: Sun, 20 May 2018 12:06:01 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, "Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ulf Magnusson <ulfalizer@gmail.com>, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arvind Prasanna <arvindprasanna@gmail.com>
Subject: Re: [PATCH v2 4/5] kconfig: refactor ncurses package checks for
 building mconf
Message-ID: <20180520100601.GB18441@ravnborg.org>
References: <1526804213-8238-1-git-send-email-yamada.masahiro@socionext.com>
 <1526804213-8238-5-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526804213-8238-5-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
	a=ddpE2eP9Sid01c7MzoqXPA==:117 a=ddpE2eP9Sid01c7MzoqXPA==:17
	a=kj9zAlcOel0A:10 a=c-n4J4-pAAAA:8 a=1MyxdhVDA8yp6fHGDwkA:9
	a=CjuIK1q_8ugA:10 a=L0NDqeB7ZLmQzAogN4cw:22
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600970303979180771?=
X-GMAIL-MSGID: =?utf-8?q?1600977124253896081?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Masahiro

On Sun, May 20, 2018 at 05:16:52PM +0900, Masahiro Yamada wrote:
> The mconf (or its infrastructure, lxdiaglog) depends on ncurses.
> Move and rename check-lxdialog.sh to mconf-cfg.sh to make it work in
> the same way as for qconf and gconf.
> 
> According to Randy's report, we still need to carry the fallback code
> in case the pkg-config fails to find ncurses.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> -
> -# Use recursively expanded variables so we do not call gcc unless
> -# we really need to do so. (Do not call gcc as part of make mrproper)
> -HOST_EXTRACFLAGS += $(shell $(CONFIG_SHELL) $(check-lxdialog) -ccflags) \
> -                    -DLOCALE
...

>  # Add environment specific flags
> -HOST_EXTRACFLAGS += $(shell $(CONFIG_SHELL) $(srctree)/$(src)/check.sh $(HOSTCC) $(HOSTCFLAGS))
> -HOST_EXTRACXXFLAGS += $(shell $(CONFIG_SHELL) $(srctree)/$(src)/check.sh $(HOSTCXX) $(HOSTCXXFLAGS))
> -
> +HOST_EXTRACFLAGS += $(shell $(CONFIG_SHELL) $(srctree)/$(src)/check.sh $(HOSTCC) $(HOSTCFLAGS)) \
> +		    -DLOCALE
> +HOST_EXTRACXXFLAGS += $(shell $(CONFIG_SHELL) $(srctree)/$(src)/check.sh $(HOSTCXX) $(HOSTCXXFLAGS)) \
> +		    -DLOCALE

Any chance that the ugly hack in check.sh could be ported over to use pkg-config?

There should be no need to specify both $(shell ...) AND $(CONFIG_SHELL)
This was not introduced by this commit, but as the Makefile is cleaned up include this too.

	Sam
