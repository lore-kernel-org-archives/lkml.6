Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AFAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB4D20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388953AbfAOSoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:44:54 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55171 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731656AbfAOSoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:44:54 -0500
Received: from 79.184.255.239.ipv4.supernova.orange.pl (79.184.255.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 410fbbed9e4b4ce1; Tue, 15 Jan 2019 19:44:51 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Borislav Petkov <bp@alien8.de>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>
Subject: Re: [PATCH] ACPI / APEI: Fix parsing HEST that includes Deferred Machine Check subtable
Date:   Tue, 15 Jan 2019 19:44:00 +0100
Message-ID: <2404865.SsYJIrglaT@aspire.rjw.lan>
In-Reply-To: <20190114104350.GH2773@zn.tnic>
References: <20181112190029.41760-1-Yazen.Ghannam@amd.com> <20190114104350.GH2773@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, January 14, 2019 11:43:50 AM CET Borislav Petkov wrote:
> On Mon, Nov 12, 2018 at 07:00:55PM +0000, Ghannam, Yazen wrote:
> > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > 
> > ACPI 6.2 includes a new definition for a Deferred Machine Check "DMC"
> > subtable.
> > 
> > The definition of this subtable was included in following commit:
> > 
> > c042933df2b1 ("ACPICA: Add support for new HEST subtable")
> > 
> > However, the HEST parsing function was not updated to include this new
> > subtable. Therefore, Linux will fail to parse the HEST on systems that
> > include a DMC entry.
> > 
> > Add the length check for the new DMC subtable so that HEST parsing
> > doesn't fail on systems that include it.
> > 
> > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > ---
> >  drivers/acpi/apei/hest.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
> > index b1e9f81ebeea..0935a0ef37e5 100644
> > --- a/drivers/acpi/apei/hest.c
> > +++ b/drivers/acpi/apei/hest.c
> > @@ -53,6 +53,7 @@ static const int hest_esrc_len_tab[ACPI_HEST_TYPE_RESERVED] = {
> >  	[ACPI_HEST_TYPE_AER_BRIDGE] = sizeof(struct acpi_hest_aer_bridge),
> >  	[ACPI_HEST_TYPE_GENERIC_ERROR] = sizeof(struct acpi_hest_generic),
> >  	[ACPI_HEST_TYPE_GENERIC_ERROR_V2] = sizeof(struct acpi_hest_generic_v2),
> > +	[ACPI_HEST_TYPE_IA32_DEFERRED_CHECK] = -1,
> >  };
> >  
> >  static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
> > @@ -75,6 +76,11 @@ static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
> >  		mc = (struct acpi_hest_ia_machine_check *)hest_hdr;
> >  		len = sizeof(*mc) + mc->num_hardware_banks *
> >  			sizeof(struct acpi_hest_ia_error_bank);
> > +	} else if (hest_type == ACPI_HEST_TYPE_IA32_DEFERRED_CHECK) {
> > +		struct acpi_hest_ia_deferred_check *mc;
> > +		mc = (struct acpi_hest_ia_deferred_check *)hest_hdr;
> > +		len = sizeof(*mc) + mc->num_hardware_banks *
> > +			sizeof(struct acpi_hest_ia_error_bank);
> >  	}
> >  	BUG_ON(len == -1);
> >  
> 
> Reviewed-by: Borislav Petkov <bp@suse.de>

Patch applied, thanks!

