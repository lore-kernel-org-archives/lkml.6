Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED32C46475
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205D920827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 06:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205D920827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbeKFPcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 10:32:22 -0500
Received: from mga02.intel.com ([134.134.136.20]:6978 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729342AbeKFPcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 10:32:21 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 22:08:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,470,1534834800"; 
   d="scan'208";a="88889799"
Received: from unknown (HELO localhost) ([10.249.254.149])
  by orsmga006.jf.intel.com with ESMTP; 05 Nov 2018 22:08:41 -0800
Date:   Tue, 6 Nov 2018 08:08:39 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 07/16] tpm: access command header through struct in
 tpm_try_transmit()
Message-ID: <20181106060839.GG15575@linux.intel.com>
References: <20181105014552.20262-1-jarkko.sakkinen@linux.intel.com>
 <20181105014552.20262-8-jarkko.sakkinen@linux.intel.com>
 <739339e6-4cd3-974d-617e-9e64cb2195cb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <739339e6-4cd3-974d-617e-9e64cb2195cb@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 05:26:30PM -0500, Stefan Berger wrote:
> On 11/4/18 8:45 PM, Jarkko Sakkinen wrote:
> > Instead of accessing fields of the command header through offsets to
> > the raw buffer, it is a better idea to use the header struct pointer
> > that is already used elsewhere in the function.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> >   drivers/char/tpm/tpm-interface.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> > index 0f343407daf8..422e3bb0bd3d 100644
> > --- a/drivers/char/tpm/tpm-interface.c
> > +++ b/drivers/char/tpm/tpm-interface.c
> > @@ -190,8 +190,8 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
> >   	if (bufsiz > TPM_BUFSIZE)
> >   		bufsiz = TPM_BUFSIZE;
> > 
> > -	count = be32_to_cpu(*((__be32 *) (buf + 2)));
> > -	ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
> > +	count = be32_to_cpu(header->length);
> > +	ordinal = be32_to_cpu(header->return_code);
> 
> Hm. This should use the proper type of header and use in_header->ordinal.

Well, the fuction has output header already declared. What I could do
as a prequel commit is to take these:

struct tpm_input_header {
	__be16	tag;
	__be32	length;
	__be32	ordinal;
} __packed;

struct tpm_output_header {
	__be16	tag;
	__be32	length;
	__be32	return_code;
} __packed;

and replace them with this:

struct tpm_header {
	__be16	tag;
	__be32	length;
	union {
		__be32 ordinal;
		__be32 return_code;
	};
} __packed;

/Jarkko
