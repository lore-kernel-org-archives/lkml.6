Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbeDQIdG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 04:33:06 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39213 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751238AbeDQIcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 04:32:45 -0400
X-Google-Smtp-Source: AIpwx48qZyh1eR/+HjLAQ9whMM+uPfeGjbe1EyUiw0nlDCoPLSl9ALy+kyVLyDgEipJ+w9B4XheOYPB4Nhu4uR0Xs/I=
MIME-Version: 1.0
References: <20180412101350.210547-1-tweek@google.com> <20180412101350.210547-2-tweek@google.com>
 <20180417030202.GA30624@ziepe.ca>
In-Reply-To: <20180417030202.GA30624@ziepe.ca>
From: Thiebaud Weksteen <tweek@google.com>
Date: Tue, 17 Apr 2018 08:32:33 +0000
Message-ID: <CA+zpnLdU=t6eOY9GOLAyiXkZBw=NueckiejHSexd8P7MKYuRww@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] tpm: Add explicit endianness cast
To: jgg@ziepe.ca
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 5:02 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Thu, Apr 12, 2018 at 12:13:47PM +0200, Thiebaud Weksteen wrote:
> > Signed-off-by: Thiebaud Weksteen <tweek@google.com>
> >  drivers/char/tpm/tpm_eventlog_of.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm_eventlog_of.c
b/drivers/char/tpm/tpm_eventlog_of.c
> > index 96fd5646f866..d74568d58a66 100644
> > +++ b/drivers/char/tpm/tpm_eventlog_of.c
> > @@ -56,8 +56,8 @@ int tpm_read_log_of(struct tpm_chip *chip)
> >        * but physical tpm needs the conversion.
> >        */
> >       if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0) {
> > -             size = be32_to_cpup(sizep);
> > -             base = be64_to_cpup(basep);
> > +             size = be32_to_cpup((__be32 *)sizep);
> > +             base = be64_to_cpup((__be64 *)basep);

> Er, no.. change the definitions of sizep and basep to be __be

> Jason

Please read the comment before the condition. sizep and
basep may contain either little endian or big endian and this block is used
to adjust that. Let me know if there is a better way for handling this.
