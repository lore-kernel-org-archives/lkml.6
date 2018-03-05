Return-Path: <jarkko.sakkinen@linux.intel.com>
X-Google-Smtp-Source: AG47ELsKytNYbxsntzAbAck8W99Kmby0mtV6a7pElw+57M4pFlkLZoq6hSMSJMQI2/UPD+dN+9G3
ARC-Seal: i=1; a=rsa-sha256; t=1520248273; cv=none;
        d=google.com; s=arc-20160816;
        b=pPkRX8Ivbc/EkmxI3TWyIaGq/n+oz0TwDsuI4slYuWgYZi2psJ/N9mJpgrzviL6pNH
         NwjYtrVn6djvobymQCkkSCjN37Io+DbUqwHJki9/4vM/HiLBxmjP9FNL4CrAXzT/eO1U
         fME2hH3fPFZcEgsAREVWa5o2pI/1LAWsFCJLSjOgNIjQzzQdIqlKLiutQshp6NbrCd6t
         k8yAi7JzDWt14fv6lgYP+JnWVfFqlHDInviwIYNTIhc+ueVbo892hkMyIbupiR+NjyP9
         sBil7BRID4ly9wqr+pvA/UMsu4onTw43DnH6tAj/WTu5So1JTLgeDDjbHTEXjBXE0XnL
         aUjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:organization:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=JBo4JvHCO6Dl7NiiMd81BRwUYH7g4dekkqV7jJNL1zE=;
        b=qs10/KQT77WwStT7fWUKDHPnBYZhuIK5nFyRSSMcOFqVmDQ4tjPm0194vaTV+VVreo
         mNYcAr2Zb1yZ2WT/SSTRWwjAt6ik90lKjQJn48MRMa+EjxQKG83I5n9nNnjE+uRzpq9K
         cpEFLIQDL4k/RZAgHyJT9eIUIjkhYD73g1E1v2jgfE9ggCV0XTqm3vahjcVSmfEOR3FD
         RDYP3wbYCvkbzIEfnncRrcf92f7jHx/c5K0Wv19FXnVd0w7qNK1yx6D/6L1kokqg0rPv
         sMP3P9PCsw3dc/7tA72d9yIHImBfeiSqwlcHJItiuJLaqVQi4aAo4FI+FSA5LHL6prFj
         zNVg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jarkko.sakkinen@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=jarkko.sakkinen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jarkko.sakkinen@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=jarkko.sakkinen@linux.intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,426,1515484800";
   d="scan'208";a="36009761"
Date: Mon, 5 Mar 2018 13:11:07 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: J Freyensee <why2jjj.linux@gmail.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
	keyrings@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] tpm: migrate tpm2_probe() to use struct tpm_buf
Message-ID: <20180305111107.GH25377@linux.intel.com>
References: <20180228195819.22231-1-jarkko.sakkinen@linux.intel.com>
 <20180228195819.22231-4-jarkko.sakkinen@linux.intel.com>
 <5d8921fb-f7e0-5498-99e2-d4d84aa597f3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d8921fb-f7e0-5498-99e2-d4d84aa597f3@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676067717266056?=
X-GMAIL-MSGID: =?utf-8?q?1594095853310011983?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 02:10:17PM -0800, J Freyensee wrote:
> .
> .
> .
> I'm new to this area of the kernel, but I'm not getting these lines:
> 
> > +	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0, NULL);
> > +	tpm_buf_destroy(&buf);
> >   	if (rc <  0)
> Why is this if() check not directly after the tpm_transmit_cmd() call that
> sets rc?  Is it correct you want to destroy buf regardless of the
> tpm_transmit_cmd() outcome?
> >   		return rc;
> > -
> > -	if (be16_to_cpu(cmd.header.out.tag) == TPM2_ST_NO_SESSIONS)
> > +	out = (struct tpm_output_header *)buf.data;
> 
> So buf has been destroyed, buf.data sill has something valid to assign to
> out?
> > +	if (be16_to_cpu(out->tag) == TPM2_ST_NO_SESSIONS)
> >   		chip->flags |= TPM_CHIP_FLAG_TPM2;
> >   	return 0;
> Thanks,
> Jay

Nope it is a regression in the patch. Thank you :-) tpm_buf_destroy()
can be called if the response data is not needed other than everything
went OK (tpm_transmit_cmd() already digs this info).

/Jarkko
