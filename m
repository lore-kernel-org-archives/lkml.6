Return-Path: <jarkko.sakkinen@linux.intel.com>
X-Google-Smtp-Source: AG47ELtqzt8eg/ldiaEvIvyzHsEqpl6IGnj8SKBiAyio4FC3Z27sZAu6RiH67oOAcvOeDqIUPR0u
ARC-Seal: i=1; a=rsa-sha256; t=1521470532; cv=none;
        d=google.com; s=arc-20160816;
        b=x4hn/mwPdRPzRAdxy5lSlIc4H4iqIUOv9dmRwX/rElWMayAjgNFYSK5GGjt9vZs4R7
         cEq+ktXymZINAkUcfdoRjODNw7hqEJ6og+xjXj/C6QhxdBB8KRDzgVaDwPGR45d5of5M
         0CG7WAO+Qt0lrpkC27gmbEjeXQOSaly0uoRmPFCn3YJ992NbJz98UuswHkFJLfleP8Le
         23pwUwsllFObOagAFuUfRWHP1Ejv4Ql1cmYRtKjSXSBJF2CE1jbIuo50G8ZATsI0F0Hy
         V951skqiQ4Ciwzv3kM7lpwajRWr3Vw5bSmLSy5Bepat60O8j+oH8HTRdzhaUbESDHBeu
         fkHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:organization:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=lWD6tulG9EUkWxHpWH1nHZRFoOpIyiybyhYdpU5peqk=;
        b=JvNr3rlchhUozGdWtKMe2Ec+KxDXp7a43JSz1aKsgnHMPTfsSI5sFpd5xf691EyiSj
         xkzaU9CDodMyTz3JOkaTeZ35lZ0Wjn2xa2HXmsv6NlfWe0TTHiaSv8324TA/s/j2H8Ub
         e7LsLGsrbTMG2Rqx1CE6l5/itq6i0yrXkaRPzbQrieL1bCOus4rc9t00mfRY+ma62X+n
         9o3eNBEvSutRbXZBNCTl5lM7P5QLHctK/XJZ1eAT1g8bAw7pdzzQErgpxeD9k5Jyry0Z
         JqUnxj7yp+eCwh+5g+hDApfQAPgnlyRvhh893BPQKtOaTPI9gT0l5Mfha2KC5dreFkkf
         DmsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jarkko.sakkinen@linux.intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=jarkko.sakkinen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jarkko.sakkinen@linux.intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=jarkko.sakkinen@linux.intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,330,1517904000";
   d="scan'208";a="212660090"
Date: Mon, 19 Mar 2018 16:42:05 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
	keyrings@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] tpm: migrate tpm2_probe() to use struct tpm_buf
Message-ID: <20180319144205.GA4619@linux.intel.com>
References: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
 <20180305165614.5469-4-jarkko.sakkinen@linux.intel.com>
 <1520290344.10396.357.camel@linux.vnet.ibm.com>
 <20180316122129.GA2458@linux.intel.com>
 <1521203812.3503.19.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1521203812.3503.19.camel@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676067717266056?=
X-GMAIL-MSGID: =?utf-8?q?1595377485142893626?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 08:36:52AM -0400, Mimi Zohar wrote:
> On Fri, 2018-03-16 at 14:21 +0200, Jarkko Sakkinen wrote:
> > On Mon, Mar 05, 2018 at 05:52:24PM -0500, Mimi Zohar wrote:
> > > Hi Jarrko,
> > > 
> > > On Mon, 2018-03-05 at 18:56 +0200, Jarkko Sakkinen wrote:
> > > > In order to make struct tpm_buf the first class object for constructing TPM
> > > > commands, migrate tpm2_probe() to use it.
> > > > 
> > > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > 
> > > With this patch, the Pi doesn't find the TPM.  I'm seeing the
> > > following line in dmesg.
> > > 
> > > [    1.087414] tpm_tis_spi: probe of spi0.0 failed with error 256
> > 
> > Thank you for reporting this Mimi. Does it have TPM1/TPM2?
> 
> The pi has a TPM 2.0 attached to the GPIO.  James pointed out the
> change in return codes.
> 
> 
> +       if (be16_to_cpu(out->tag) == TPM2_ST_NO_SESSIONS)
>                 chip->flags |= TPM_CHIP_FLAG_TPM2;
> -
> -       return 0;
> +out:
> +       tpm_buf_destroy(&buf);
> +       return rc;
>  }
>  EXPORT_SYMBOL_GPL(tpm2_probe);
> 
> Mimi

Oops, thank you James and Mimi for pointing this out. I'll refine
the patch set.

/Jarkko
