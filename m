Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D24C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 06:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E638024B45
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 06:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E638024B45
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbeFWGY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 02:24:29 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:26289
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751377AbeFWGY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 02:24:28 -0400
X-IronPort-AV: E=Sophos;i="5.51,260,1526335200"; 
   d="scan'208";a="269708461"
Received: from abo-154-110-68.mrs.modulonet.fr (HELO [192.168.0.15]) ([85.68.110.154])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jun 2018 08:24:26 +0200
Date:   Sat, 23 Jun 2018 08:24:26 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Darren Hart <dvhart@infradead.org>
cc:     Colin King <colin.king@canonical.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: dell-smbios: make a function and a pointer
 static
In-Reply-To: <20180623002237.GG27466@fury>
Message-ID: <alpine.DEB.2.20.1806230823500.2696@hadrien>
References: <20180621181524.30550-1-colin.king@canonical.com> <20180623002237.GG27466@fury>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Jun 2018, Darren Hart wrote:

> On Thu, Jun 21, 2018 at 07:15:24PM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > The function dell_smbios_smm_call and pointer platform_device are
> > local to the source and do not need to be in global scope, so make
> > them static.
> >
> > Cleans up sparse warnings:
> > warning: symbol 'platform_device' was not declared. Should it be static?
> > warning: symbol 'dell_smbios_smm_call' was not declared. Should it be
> > static?
> >
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/platform/x86/dell-smbios-smm.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/platform/x86/dell-smbios-smm.c b/drivers/platform/x86/dell-smbios-smm.c
> > index e9e9da556318..97a90bebc360 100644
> > --- a/drivers/platform/x86/dell-smbios-smm.c
> > +++ b/drivers/platform/x86/dell-smbios-smm.c
> > @@ -24,7 +24,7 @@
> >  static int da_command_address;
> >  static int da_command_code;
> >  static struct calling_interface_buffer *buffer;
> > -struct platform_device *platform_device;
> > +static struct platform_device *platform_device;
> >  static DEFINE_MUTEX(smm_mutex);
> >
> >  static const struct dmi_system_id dell_device_table[] __initconst = {
> > @@ -82,7 +82,7 @@ static void find_cmd_address(const struct dmi_header *dm, void *dummy)
> >  	}
> >  }
> >
> > -int dell_smbios_smm_call(struct calling_interface_buffer *input)
> > +static int dell_smbios_smm_call(struct calling_interface_buffer *input)
>
> Hrm. So these are passed by pointer to dell_smbios_register_device(), which is in
> turn called by dell_smbios_call() from dell-smbios-base.c.
>
> So while it is valid to make these static, since we're not referencing the
> symbol, but the pointer value instead - I do worry about the "static" suggesting
> to someone reading the code that this data is not used outside of this file,
> when it is.

Static protects the name.  The name in this case is very generic.

julia

>
> I'm not finding a position on this in coding-style.
>
> Andy, do you care to weigh in on this?
>
> --
> Darren Hart
> VMware Open Source Technology Center
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
