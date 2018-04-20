Return-Path: <mgreer@animalcreek.com>
X-Google-Smtp-Source: AIpwx4/jxl8/m6gbAnhNFhiKnuYcBqkhWfQ/MepeHa4OkArxmDvqkflIOu0uZrIg1YybSH16LXrM
ARC-Seal: i=1; a=rsa-sha256; t=1524242711; cv=none;
        d=google.com; s=arc-20160816;
        b=x8RanFu3agLyAztN/amONcmRZyiqYFFg7M88GKPqkUlR6M9ymo7ia1HTJEmkom42vD
         o1TOljA0T7elQtpaz5pDaRzZKMXkXwvSQpJ9lD8kQ8T4N63RFOMdLWCZ6PZPOsSM68nY
         NI1n3IWVMpRJ6WZGno+0Djl9JlROqonilLcSWBpA8GbvqfTbETEqWcwCYqHTm4y0++R2
         dmwuTkrJWtr70eQitnw3qe2SOpGxGrLRKQJ5Y7iFKxpPumIOz1KNG/nrKavHSwt28QuR
         zfiFGM+WfpnucOAcoJzCWgZoWfCOAq3lVstCjuqdadD53l4rLo4tov3lnMWnh2S6XCVY
         NcHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:organization:in-reply-to:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=rg3kuljOeH3qq5cOJA1pHMrmASbk8HlMownpyqHx0VM=;
        b=y8teJX7S0AxZsUN50jDJNgeVaCWZMbk8nRKqq5JzSeOyqhYCUy8wdlqjW4wllDdYUU
         RIeoPNZhBTbKNEwUIZbEwFEhkU0ReYfax9xLOu6YegAKSWHNyefbrlVC/nz7icGzgz9b
         RNa8CxYjf+5uE489xoZxO+rtGdPuumc3MUT1df/fzT83p5/49zUTK2kCYN9XZfys36Eb
         96P39SFkBxQCC98L3BCcTgsXlxxd2e3A7i//NTzpuRvnHs2Ch18J3bAwrd7IZO0l9yFa
         SWdr8thl/yHP137XdAXSeWC0RjrQoxmwGf9PJS0KkZ4w0ToF4IdZDfFqEtlX/UQf9PM7
         7lYg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=temperror (no key for signature) header.i=@animalcreek.com header.s=mesmtp header.b=mzlj4lvs;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=KlQuJnmw;
       spf=neutral (google.com: 66.111.4.27 is neither permitted nor denied by best guess record for domain of mgreer@animalcreek.com) smtp.mailfrom=mgreer@animalcreek.com
Authentication-Results: mx.google.com;
       dkim=temperror (no key for signature) header.i=@animalcreek.com header.s=mesmtp header.b=mzlj4lvs;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=KlQuJnmw;
       spf=neutral (google.com: 66.111.4.27 is neither permitted nor denied by best guess record for domain of mgreer@animalcreek.com) smtp.mailfrom=mgreer@animalcreek.com
X-ME-Sender: <xms:FhnaWt21zHudPoz51im36TpNe2uPckILOL0-aVIYWX2U0_01y01fvw>
Date: Fri, 20 Apr 2018 09:45:07 -0700
From: Mark Greer <mgreer@animalcreek.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Amit Pundir <amit.pundir@linaro.org>,
	lkml <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org,
	Samuel Ortiz <sameo@linux.intel.com>,
	Christophe Ricard <christophe.ricard@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	John Stultz <john.stultz@linaro.org>,
	Dmitry Shmidt <dimitrysh@google.com>, Todd Kjos <tkjos@google.com>,
	Android Kernel Team <kernel-team@android.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RESEND][PATCH 2/4] NFC: st21nfca: Fix memory OOB and leak
 issues in connectivity events handler
Message-ID: <20180420164507.GA22666@animalcreek.com>
References: <1524045904-7005-1-git-send-email-amit.pundir@linaro.org>
 <1524045904-7005-3-git-send-email-amit.pundir@linaro.org>
 <1524227986.21176.467.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524227986.21176.467.camel@linux.intel.com>
Organization: Animal Creek Technologies, Inc.
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598077974606996222?=
X-GMAIL-MSGID: =?utf-8?q?1598284325375732924?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 03:39:46PM +0300, Andy Shevchenko wrote:
> On Wed, 2018-04-18 at 15:35 +0530, Amit Pundir wrote:
> 
> >  		if (skb->data[transaction->aid_len + 2] !=
> > -		    NFC_EVT_TRANSACTION_PARAMS_TAG)
> > +		    NFC_EVT_TRANSACTION_PARAMS_TAG ||
> > +		    skb->len < transaction->aid_len + transaction-
> > >params_len + 4) {
> 
> > +			devm_kfree(dev, transaction);
> 
> Oh, no.
> 
> This is not memory leak per se, this is bad choice of devm_ API where it
> should use plain kmalloc() / kfree().

Also, there is no check to see if the allocation worked at all.

Mark
--
