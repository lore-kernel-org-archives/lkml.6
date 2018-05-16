Return-Path: <mika.westerberg@linux.intel.com>
X-Google-Smtp-Source: AB8JxZp/+q7v9i3q59qYtW6aFTsleI9og3s/x0rYmh4eamlpZKlJXBGDH3mcTadzZO4LC5VX3T5b
ARC-Seal: i=1; a=rsa-sha256; t=1526463698; cv=none;
        d=google.com; s=arc-20160816;
        b=pzQR8wZsCZYmoKGFIW/Z3OITocjnXsiGd0GfdPcE4yD6Hf8v+RdBDAfJruxK2sR2mD
         lgiaCIMb+9zUsbf3yCs75ePBaIyhayhGpM/V9qJvMVMPbPwFxgI1MaJvv85g5Bf1Hn3j
         8zpRjDc6yDyXxZoc3AsR7qMySChPfZ65xXsiQHJtaoqO1+Vxr1cnAWXlYgHCLBDegKPk
         j+jhh2lB6hA+9+okBsY8Pvz1Jhe35FPSil2j55pTBZpTXb4X9XXCE4C9sgC/3+2hClL5
         eQXJIZ4Xs+E9igIeslnfCTgOKqaOa02sONfF0nNXx/82yfeWyTjjw09qDdu9Ps+4AQ8a
         7r5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:organization:in-reply-to:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=ZPWLaUX9r69LwF2yfTRWAwe7jxMQUvu4otO39DN1bOg=;
        b=BgQtHetSsDsWGV5AHpXPy1PGfmOpRVdJFDsk/s/ajRKS8sr63g/9292ttwCHI15YRJ
         A6Ko2QXPsZYETqI46iXM1ElsZdg1B51ojnvv6P2YipBNpbVu3P5m3rYUg4SHJnaeYPS3
         dhpL7T94jcMhlP6WJDq7VCvfhWCHE5se7JZ87R/Ib0gE35SbUycnpyeLM4MvIsrglM9n
         IH0/zsNTHVGmc9AWsLq2hGR4BXNvqjMa8lMYOp5Du0Rdf5LahJFDOnhIFJ6dI3uSflS6
         PTHOFfphGGLtLlQQ5w/kl9lhtn0jiqrLFoKfV3Fc2pUKxdVsGcPL72aVsOk5Ldn+KCUj
         ynZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="41677266"
Date: Wed, 16 May 2018 12:41:33 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	linux-efi@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3] device property: Get rid of union aliasing
Message-ID: <20180516094133.GN32438@lahna.fi.intel.com>
References: <20180515173202.84296-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515173202.84296-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600552202231950083?=
X-GMAIL-MSGID: =?utf-8?q?1600613199296308629?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 08:32:02PM +0300, Andy Shevchenko wrote:
> The commit
> 
>   318a19718261 ("device property: refactor built-in properties support")
> 
> went way too far and brought a union aliasing. Partially revert it here
> to get rid of union aliasing.
> 
> Note, all Apple properties are considered as u8 arrays. To get a value
> of any of them the caller must use device_property_read_u8_array().
> 
> What union aliasing is?
> ~~~~~~~~~~~~~~~~~~~~~~~
> The C99 standard in section 6.2.5 paragraph 20 defines union type as
> "an overlapping nonempty set of member objects". It also states in
> section 6.7.2.1 paragraph 14 that "the value of at most one of the
> members can be stored in a union object at any time'.
> 
> Union aliasing is a type punning mechanism using union members to store
> as one type and read back as another.
> 
> Why it's not good?
> ~~~~~~~~~~~~~~~~~~
> Section 6.2.6.1 paragraph 6 says that a union object may not be a trap
> representation, although its member objects may be.
> 
> Meanwhile annex J.1 says that "the value of a union member other than
> the last one stored into" is unspecified [removed in C11].
> 
> In TC3, a footnote is added which specifies that accessing a member of a
> union other than the last one stored causes "the object representation"
> to be re-interpreted in the new type and specifically refers to this as
> "type punning". This conflicts to some degree with Annex J.1.
> 
> While it's working in Linux with GCC, the use of union members to do
> type punning is not clear area in the C standard and might lead to
> unspecified behaviour.
> 
> More information is available in this [1] blog post.
> 
> [1]: https://davmac.wordpress.com/2010/02/26/c99-revisited/
> 
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
