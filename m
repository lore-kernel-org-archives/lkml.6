Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EA7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F21F20883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547826403;
	bh=L25ti83ENXOpGfDeiE9QKBf/2CVNECajnyH5mmldHQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qzV//5opdqgW3hbj5E+pNO+2fHVhNan6LdRafmiykPIc5F/t0I+FkzeVfhT9nI41c
	 1Y2lDvFp+lbgXdYz+0+HKMck6Dvi4KFQeTvXQkWN60qry06ojKKX65eI/06sbD5yR6
	 SjUHYw2zdieJa80uB34ZoxsMJZyU5ESfkPUnL2d8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfARPql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:46:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:39816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfARPqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:46:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19D142087E;
        Fri, 18 Jan 2019 15:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547826399;
        bh=L25ti83ENXOpGfDeiE9QKBf/2CVNECajnyH5mmldHQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rlWtbnSa/qZNZMmnIEHI1LeTVfM1YVw1J9ErRVA27MORh+sGQS9vTT5AoDvuw0Tdk
         hcX0p/T2cBsk+FnlDsw8YWXHtGKizlxyizVyOCLo0JnIAZDi1SzF5ib+8k5eNrZf5f
         YRSMpLa7kwF9N3+ZIFkL1BsjUotAD7TgXFUSITyE=
Date:   Fri, 18 Jan 2019 16:46:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     jeremy.linton@arm.com, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        dave.martin@arm.com, shankerd@codeaurora.org,
        linux-kernel@vger.kernel.org, ykaukab@suse.de,
        julien.thierry@arm.com, mlangsdo@redhat.com, Steven.Price@arm.com,
        stefan.wahren@i2se.com, rafael@kernel.org, tglx@linutronix.de,
        jpoimboe@redhat.com, konrad.wilk@oracle.com, mingo@kernel.org,
        longman@redhat.com, ak@linux.intel.com, jkosina@suse.cz
Subject: Re: [PATCH v3 1/7] sysfs/cpu: Allow individual architectures to
 select vulnerabilities
Message-ID: <20190118154637.GA8564@kroah.com>
References: <20190109235544.2992426-1-jeremy.linton@arm.com>
 <20190109235544.2992426-2-jeremy.linton@arm.com>
 <901f2f29-aa06-13ad-1995-f9f22184e39d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <901f2f29-aa06-13ad-1995-f9f22184e39d@arm.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 10:02:21AM +0000, Suzuki K Poulose wrote:
> 
> 
> On 09/01/2019 23:55, Jeremy Linton wrote:
> > As suggested on the list, https://lkml.org/lkml/2019/1/4/282, there are
> > a number of cases where its useful for a system to avoid exporting a
> > sysfs entry for a given vulnerability. This set adds an architecture
> > specific callback which returns the bitmap of vulnerabilities the
> > architecture would like to advertise.
> > 
> > Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Rafael J. Wysocki <rafael@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Jiri Kosina <jkosina@suse.cz>
> > ---
> >   drivers/base/cpu.c  | 19 +++++++++++++++++++
> >   include/linux/cpu.h |  7 +++++++
> >   2 files changed, 26 insertions(+)
> > 
> > diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> > index eb9443d5bae1..35f6dfb24cd6 100644
> > --- a/drivers/base/cpu.c
> > +++ b/drivers/base/cpu.c
> > @@ -561,6 +561,11 @@ static struct attribute *cpu_root_vulnerabilities_attrs[] = {
> >   	NULL
> >   };
> > +uint __weak arch_supported_vuln_attr_fields(void)
> > +{
> > +	return VULN_MELTDOWN|VULN_SPECTREV1|VULN_SPECTREV2|VULN_SSB|VULN_L1TF;
> > +}
> > +
> >   static const struct attribute_group cpu_root_vulnerabilities_group = {
> >   	.name  = "vulnerabilities",
> >   	.attrs = cpu_root_vulnerabilities_attrs,
> > @@ -568,6 +573,20 @@ static const struct attribute_group cpu_root_vulnerabilities_group = {
> >   static void __init cpu_register_vulnerabilities(void)
> >   {
> > +	int fld;
> > +	int max_fields = ARRAY_SIZE(cpu_root_vulnerabilities_attrs) - 1;
> > +	struct attribute **hd = cpu_root_vulnerabilities_attrs;
> > +	uint enabled_fields = arch_supported_vuln_attr_fields();
> > +
> > +	/* only enable entries requested by the arch code */
> > +	for (fld = 0; fld < max_fields; fld++) {
> > +		if (enabled_fields & 1 << fld) {
> > +			*hd = cpu_root_vulnerabilities_attrs[fld];
> > +			hd++;
> > +		}
> > +	}
> > +	*hd = NULL;
> > +
> 
> nit: Could we use "is_visible" callback in the attribute group to check this
> dynamically ?

You should, that is what it is there for.

thanks,

greg k-h
