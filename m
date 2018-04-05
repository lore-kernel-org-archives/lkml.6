Return-Path: <jlee@suse.com>
X-Google-Smtp-Source: AIpwx4/HgluVLrUIynOAVT8pu1Uz1+BB7QNRz2szRsms2qpK/LFC6nzbF7Af80/mvRG9Eop9LUo7
ARC-Seal: i=1; a=rsa-sha256; t=1522944720; cv=none;
        d=google.com; s=arc-20160816;
        b=gTIANR2EfsHBt7qFxvoS17asnLB4zl/wHzeOURgjbK03kYGpJzevSeuD8CKIEfhARR
         oOHWss1v4TDE+I+bEL12EsAk7zyCV014K+GppfB+3qq/x3CoNPrNZWBOwtm5m5m1qJk0
         PYrfDOIi14tkq+RW0cbqZnRSD0KlAhRZhyg8RkuU3kobLQ3ZLzIjfmXmqDPVDjPSfcD8
         BU1U1y83KVXSMGTOVsFpL/R1nPMzdXpUfCBnmC31jysRnq+oI0nln5nQAGCqBkN6eoTu
         G5ycFpKCCBzYD8lJUJkhsWGf/ahsN0G3ZT8n7ef8Rodj5zjZt27VB8xjsTWsPy2tUhe/
         rAig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=t1qmGUOp5nEfZ/1tSQeSFh+NGJkqF/IQPwKRq5YvzSY=;
        b=AgWG5rbdIJcdwqKPb5ApW1Wasz6beSuWaHrKxN5goB9GxDaQM8zZ80n/cPsxtyG2ag
         iOfEyj8jaXeumX2H3wMvMa29QCK/UZVx2Rll7yL937K/XKEEYWbPmLXySp9xGyN91co+
         JhiFpBTibQwzFkMm/GPYS+w9DzQJKCh3pldBxon5BmHoXxXPl+cnfdAIgLNfaSidgcSI
         1nTJL6W6DSPUj89Acjo0Oobo8YZv7fSKb2JWT8vYRzgpoVEIq0JbgKl9bF7/vqVQaLmB
         4BBjTgxRn8YMcQhXenmu9H5uZIQAotSDniTTElYRkV1RweceeKwLLrTqdDGPf47xXBrf
         2dRg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jlee@suse.com designates 195.135.221.5 as permitted sender) smtp.mailfrom=jlee@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jlee@suse.com designates 195.135.221.5 as permitted sender) smtp.mailfrom=jlee@suse.com
Date: Fri, 6 Apr 2018 00:11:24 +0800
From: jlee@suse.com
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	Matthew Garrett <mjg59@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	James Morris <jmorris@namei.org>,
	Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Justin Forbes <jforbes@redhat.com>,
	linux-man <linux-man@vger.kernel.org>,
	LSM List <linux-security-module@vger.kernel.org>,
	Linux API <linux-api@vger.kernel.org>,
	Kees Cook <keescook@chromium.org>,
	linux-efi <linux-efi@vger.kernel.org>
Subject: Re: An actual suggestion (Re: [GIT PULL] Kernel lockdown for secure
 boot)
Message-ID: <20180405161124.y5jfe76lfqog7iiv@linux-rasp2>
References: <CALCETrUVQLDC6_VEvuAbdCOuGrmcxohqTB6P8eyNojm9AryNkg@mail.gmail.com>
 <1119.1522858644@warthog.procyon.org.uk>
 <20180405021650.GC7362@linux-l9pv.suse>
 <1522936869.16421.63.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522936869.16421.63.camel@linux.vnet.ibm.com>
User-Agent: Mutt/1.6.2 (2016-07-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596827498960319998?=
X-GMAIL-MSGID: =?utf-8?q?1596923282812623135?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Mimi,

On Thu, Apr 05, 2018 at 10:01:09AM -0400, Mimi Zohar wrote:
> On Thu, 2018-04-05 at 10:16 +0800, joeyli wrote:
> > Hi David, 
> > 
> > On Wed, Apr 04, 2018 at 05:17:24PM +0100, David Howells wrote:
> > > Andy Lutomirski <luto@kernel.org> wrote:
> > > 
> > > > Since this thread has devolved horribly, I'm going to propose a solution.
> > > > 
> > > > 1. Split the "lockdown" state into three levels:  (please don't
> > > > bikeshed about the names right now.)
> > > > 
> > > > LOCKDOWN_NONE: normal behavior
> > > > 
> > > > LOCKDOWN_PROTECT_INTEGREITY: kernel tries to keep root from writing to
> > > > kernel memory
> > > > 
> > > > LOCKDOWN_PROTECT_INTEGRITY_AND_SECRECY: kernel tries to keep root from
> > > > reading or writing kernel memory.
> > > 
> > > In theory, it's good idea, but in practice it's not as easy to implement as I
> > > think you think.
> > > 
> > > Let me list here the things that currently get restricted by lockdown:
> > > 
> > [...snip]
> > >  (5) Kexec.
> > >
> > 
> > About IMA with kernel module signing and kexec(not on x86_64 yet)...
> 
> Only carrying the measurement list across kexec is architecture
> specific, but everything else should work.  
> 
> > Because IMA can be used to verify the integrity of kernel module or even
> > the image for kexec. I think that the
> > IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY must be enabled at runtime
> > when kernel is locked-down.
> 
> I think we need to understand the problem a bit better.  Is the
> problem that you're using the secondary keyring and loading the UEFI
> keys onto the secondary keyring?
>

Sorry for my mistake. I want to write INTEGRITY_TRUSTED_KEYRING in
above but not IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY.

My brain is not clear when writing the mail.
 
> > Because the root can enroll master key to keyring then IMA trusts the ima key
> > derived from master key. It causes that the arbitrary signed module can be loaded
> > when the root compromised.
> 
> With only the builtin keyring, only keys signed by a builtin key can
> be added to the IMA keyring.
> 

Thanks for your description. I saw that the IMA_LOAD_X509 already depends
on IMA_TRUSTED_KEYRING (INTEGRITY_TRUSTED_KEYRING). Please ignore my concern.

Thanks a lot!
Joey Lee
