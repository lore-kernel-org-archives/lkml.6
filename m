Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3265DECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9408A208F7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9408A208F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731258AbeGPJOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:14:22 -0400
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:46228 "EHLO
        mail.osadl.at" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbeGPJOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:14:22 -0400
Received: by mail.osadl.at (Postfix, from userid 1001)
        id 5C0EA5C0F64; Mon, 16 Jul 2018 08:46:26 +0000 (UTC)
Date:   Mon, 16 Jul 2018 08:46:26 +0000
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Patrice CHOTARD <patrice.chotard@st.com>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Srinivas Kandagatla <srinivas.kandagatla@st.com>,
        Russell King <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: STi: at least warn if of_iomap fails
Message-ID: <20180716084626.GA28893@osadl.at>
References: <1531410530-24163-1-git-send-email-hofrat@osadl.org>
 <50a1ccc1-e64a-a35e-a7b5-eeb7082478e9@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50a1ccc1-e64a-a35e-a7b5-eeb7082478e9@st.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 07:55:08AM +0000, Patrice CHOTARD wrote:
> Hi Nicholas
> 
> On 07/12/2018 05:48 PM, Nicholas Mc Guire wrote:
> > The call to of_iomap() is unchecked but scu_enable(), which the returned
> > address is passed on to, assumes a valid mapping. If the mapping is
> > invalid this could probably lead to undefined system state so at least
> > a warning should be issued.
> > 
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > Fixes: commit 65ebcc115889 ("ARM: sti: Add STiH415 SOC support")
> > ---
> > Problem was found by an experimental coccinelle script
> > 
> > Patch was compile tested with: multi_v7_defconfig (implies
> > CONFIG_ARCH_STI=y, CONFIG_SMP=y)
> > 
> > Patch is against 4.18-rc3 (localversion-next is next-20180712)
> > 
> >   arch/arm/mach-sti/platsmp.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/mach-sti/platsmp.c b/arch/arm/mach-sti/platsmp.c
> > index 231f19e..89ae76f 100644
> > --- a/arch/arm/mach-sti/platsmp.c
> > +++ b/arch/arm/mach-sti/platsmp.c
> > @@ -109,6 +109,7 @@ static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
> >   
> >   	if (np) {
> >   		scu_base = of_iomap(np, 0);
> > +		WARN_ON(!scu_base);
> >   		scu_enable(scu_base);
> >   		of_node_put(np);
> >   	}
> > 
> 
> I should prefer to exit with an error to avoid unpredictable behavior,
> something like this is better :
> 
> scu_base = of_iomap(np, 0);
> of_node_put(np);
> if (!scu_base) {
> 	pr_err("No SCU remap\n");
> 	return;
> }
> 
> scu_enable(scu_base);
>
even though it would be possible to locate that then from that message
would it not be prefereable to provide the infos upfront like:

	pr_err("SCU remap failed at %s:%s():%d\n",
               __FILE__, __func__, __LINE__);

if that makes sense I´ll resend - or is that considered too verbouse ?

thx!
hofrat
 
