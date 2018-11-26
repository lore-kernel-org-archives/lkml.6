Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630A4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC4121104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="DS7SzMyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC4121104
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbeK0JXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 04:23:39 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56604 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbeK0JXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 04:23:38 -0500
Received: from zn.tnic (p200300EC2BDEFE00DCA0409AA15535E1.dip0.t-ipconnect.de [IPv6:2003:ec:2bde:fe00:dca0:409a:a155:35e1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E15651EC04BC;
        Mon, 26 Nov 2018 23:28:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1543271281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iVjDIULdAQcu4memzGX26FFlxh+bp76sTqwM3pVm0dk=;
        b=DS7SzMyvQkCTV3S9C52qlYqJ3ta0bT+BL0jkoAtkoEFHISfYcGOnyaDOLwY6euqa2dpOgl
        c0VobQL+RjoBRLmFn0OIudPMDA3NizJdMMWb0yBokc6YQdHrqd8vNLtR1cSIv73bDoQuBQ
        +XVkvl8uVx2x7y9AWE1ZG/NHgnOJ/pA=
Date:   Mon, 26 Nov 2018 23:28:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     "Moger, Babu" <Babu.Moger@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "qianyue.zj@alibaba-inc.com" <qianyue.zj@alibaba-inc.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jannh@google.com" <jannh@google.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "rian@alum.mit.edu" <rian@alum.mit.edu>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v9 10/13] x86/resctrl: Fix the messages in
 rdt_last_cmd_printf and rdt_last_cmd_puts
Message-ID: <20181126222800.GR4843@zn.tnic>
References: <20181121202811.4492-1-babu.moger@amd.com>
 <20181121202811.4492-11-babu.moger@amd.com>
 <fe5c4f4b-e233-875c-1f33-f22c5986b041@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fe5c4f4b-e233-875c-1f33-f22c5986b041@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 02:16:24PM -0800, Reinette Chatre wrote:
> Hi Babu and Borislav,
> 
> Two typos seemed to have slipped through into the merged commit ...
> 
> On 11/21/2018 12:28 PM, Moger, Babu wrote:
> > @@ -163,14 +163,14 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
> >  	 * either is exclusive.
> >  	 */
> >  	if (rdtgroup_cbm_overlaps(r, d, cbm_val, rdtgrp->closid, true)) {
> > -		rdt_last_cmd_printf("overlaps with exclusive group\n");
> > +		rdt_last_cmd_printf("Overlaps with exclusive group\n");
> >  		return -EINVAL;
> >  	}
> >  
> >  	if (rdtgroup_cbm_overlaps(r, d, cbm_val, rdtgrp->closid, false)) {
> >  		if (rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
> >  		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
> > -			rdt_last_cmd_printf("overlaps with other group\n");
> > +			rdt_last_cmd_printf("0verlaps with other group\n");
> >  			return -EINVAL;
> >  		}
> >  	}
> 
> There is a zero instead of O used in second "Overlaps".

LOL!

That's so l337 :-)

> > @@ -1235,7 +1235,7 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
> >  			goto out;
> >  		rdtgrp->mode = RDT_MODE_PSEUDO_LOCKSETUP;
> >  	} else {
> > -		rdt_last_cmd_printf("unknown/unsupported mode\n");
> > +		rdt_last_cmd_printf("Unknown orunsupported mode\n");
> >  		ret = -EINVAL;
> >  	}
> 
> Missing a space.

Whoops, nice catch. Can you send a fix pls?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
