Return-Path: <jarkko.sakkinen@linux.intel.com>
X-Google-Smtp-Source: AG47ELuB5fCNkVNGXFed42ZIp4R4DQNuCBy3wNTdz0KddehjfqbUcBdG5751YTfK4zZd9yV0t7Zi
ARC-Seal: i=1; a=rsa-sha256; t=1521494685; cv=none;
        d=google.com; s=arc-20160816;
        b=NoIYfsO4y8KvQfPesPZf0d4e/GqgIM1nlSppiPys9bhg0kErEOvqFqHvGm20dh3Bft
         TxVrBOkkT59UHb9VE1u/KLtAhCWfV3t3hRl2eHKFDDmcnXcXZXjcjolmBBGq63MVBi/q
         9hE0cRW0yyG/Q9LiHSxVZcGsv66vjA6jSmudbIypNvUGVcPfSUqdCG7ipJgWJ7lTPT/m
         ZopzuYfPdRo7ENF6RboMiRRC3rnspshX7lA0E8BkJQOK6Qj1wXMCW/W7HZR0Mp7CU2yD
         AYYJKUDNOzJhSPa8Sme9gClL9y4qd74cm2Aq4t4HP8i4Hz3FVCM/UGi1hlekm4QCcDQv
         5lJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:organization:in-reply-to:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=OvZ6/Did77zgG23T9Swy3kJaH6BrypFZN1jg3aWaB9I=;
        b=lveGmSvl66kriCXv4GsZMGojJHuYdiD5PfrnOdHrdPLIqjM6z2PBVlwBnlVdzayS3Z
         mPtpXwtGPuDTkGdTBKWGDrog8bqVAZasZlwgAIkgBaHFY4MPqsUPpcZydU3hHjUHD5xb
         MZMba9KHvfBxFZUy3LtwdTmxmpG5NKdxM37As0FFM1ioS/hZApgt6DI5SJZh9x7H4tWa
         fQDBqgbEF+b1ZOdWIovnsFDN/yLp2LL9hrWTiCh2QXD9hHaQvc88nFtvxUb2j7f1l5a+
         LOAxFnIV6tEnvhlslX9gMX49jgYgrUKsPfR8tTb/YocOyW08pbtHBNHroJIuM/CvJ24Z
         9NHg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jarkko.sakkinen@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=jarkko.sakkinen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jarkko.sakkinen@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=jarkko.sakkinen@linux.intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,332,1517904000";
   d="scan'208";a="36355172"
Date: Mon, 19 Mar 2018 23:24:36 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Sahil Rihan <srihan@fb.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
	Alexei Starovoitov <ast@fb.com>, stable@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: allow TCPA log area to be empty
Message-ID: <20180319212436.GD14364@linux.intel.com>
References: <20180310161637.7723-1-jarkko.sakkinen@linux.intel.com>
 <20180312150231.GA24717@ziepe.ca>
 <20180316125525.GB5035@linux.intel.com>
 <20180319021323.GD27186@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319021323.GD27186@ziepe.ca>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594568062770347163?=
X-GMAIL-MSGID: =?utf-8?q?1595402811266265759?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 18, 2018 at 08:13:23PM -0600, Jason Gunthorpe wrote:
> On Fri, Mar 16, 2018 at 02:55:25PM +0200, Jarkko Sakkinen wrote:
> > On Mon, Mar 12, 2018 at 09:02:32AM -0600, Jason Gunthorpe wrote:
> > > On Sat, Mar 10, 2018 at 06:16:37PM +0200, Jarkko Sakkinen wrote:
> > > > TCPA log are can be empty when the TPM is disabled. This commit changes the
> > > > behavior of tpm_read_log_acpi() to return successfully in this case.
> > > 
> > > The commit should explain why we'd want this..
> > > 
> > > eg Why does it matter to create the extra sysfs files to report an empty
> > > log?
> > > 
> > > Jason
> > 
> > The initialization of the driver will fail otherwise. Not sure if I
> > understand your question.
> 
> Well, I mean in the sense of what is broken and why is this the right
> fix. Why not return -ENODEV?

Well, because then the device initialization would fail.

Just noticed that this is missing:

Reported-by: Sahil Rihan <srihan@fb.com>

Sahil, would you care to try if this fixes the issue that you are
having or not?

/Jarkko
