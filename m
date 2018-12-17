Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DC2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7B5206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbeLQLn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:43:26 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:63168 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbeLQLn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:43:26 -0500
Received: from 79.184.255.25.ipv4.supernova.orange.pl (79.184.255.25) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id b62af5eb65ad5666; Mon, 17 Dec 2018 12:43:23 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>
Cc:     lorenzo.pieralisi@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] cpuidle: big.LITTLE: fix refcount leak
Date:   Mon, 17 Dec 2018 12:42:59 +0100
Message-ID: <5791255.IEhMFO6dfL@aspire.rjw.lan>
In-Reply-To: <ee49b2fc-f855-4406-8780-0638d5fe09a0@linaro.org>
References: <20181210162641.21029-1-tiny.windzz@gmail.com> <ee49b2fc-f855-4406-8780-0638d5fe09a0@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, December 10, 2018 6:00:12 PM CET Daniel Lezcano wrote:
> On 10/12/2018 17:26, Yangtao Li wrote:
> > of_find_node_by_path() acquires a reference to the node
> > returned by it and that reference needs to be dropped by its caller.
> > bl_idle_init() doesn't do that, so fix it.
> > 
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> > ---
> > changes in v4:
> > -update tile
> > -refactor code,suggested by Daniel
> > ---
> >  drivers/cpuidle/cpuidle-big_little.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
> > index db2ede565f1a..b44476a1b7ad 100644
> > --- a/drivers/cpuidle/cpuidle-big_little.c
> > +++ b/drivers/cpuidle/cpuidle-big_little.c
> > @@ -167,6 +167,7 @@ static int __init bl_idle_init(void)
> >  {
> >  	int ret;
> >  	struct device_node *root = of_find_node_by_path("/");
> > +	const struct of_device_id *match_id;
> >  
> >  	if (!root)
> >  		return -ENODEV;
> > @@ -174,7 +175,11 @@ static int __init bl_idle_init(void)
> >  	/*
> >  	 * Initialize the driver just for a compliant set of machines
> >  	 */
> > -	if (!of_match_node(compatible_machine_match, root))
> > +	match_id = of_match_node(compatible_machine_match, root);
> > +
> > +	of_node_put(root);
> > +
> > +	if (!match_id)
> >  		return -ENODEV;
> >  
> >  	if (!mcpm_is_available())
> > 
> 
> 
> 

Patch applied, thanks!


