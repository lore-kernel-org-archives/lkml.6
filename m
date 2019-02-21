Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3DBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44EC22086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfBUMMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:12:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfBUMMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:12:45 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C77D930821B3;
        Thu, 21 Feb 2019 12:12:44 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01BDB60933;
        Thu, 21 Feb 2019 12:12:42 +0000 (UTC)
Date:   Thu, 21 Feb 2019 13:12:40 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Harald Freudenberger <freude@linux.ibm.com>
Cc:     Sebastian Ott <sebott@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        oberpar@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com
Subject: Re: [PATCH] zcrypt: handle AP Info notification from CHSC SEI
 command
Message-ID: <20190221131240.0ab463d1.cohuck@redhat.com>
In-Reply-To: <d0e1ef87-8fc7-ea13-3dba-6abf1a28a446@linux.ibm.com>
References: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
        <alpine.LFD.2.21.1901301912380.2372@schleppi>
        <d0e1ef87-8fc7-ea13-3dba-6abf1a28a446@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 21 Feb 2019 12:12:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 11:42:25 +0100
Harald Freudenberger <freude@linux.ibm.com> wrote:

> On 30.01.19 19:32, Sebastian Ott wrote:
> > On Wed, 30 Jan 2019, Tony Krowiak wrote:  

> >>  /*
> >> +* A config change has happened, Force an ap bus rescan.
> >> +*/
> >> +void ap_bus_cfg_chg(void)
> >> +{
> >> +	AP_DBF(DBF_INFO, "%s config change, forcing bus rescan\n", __func__);
> >> +
> >> +	ap_bus_force_rescan();
> >> +}
> >> +EXPORT_SYMBOL(ap_bus_cfg_chg);  
> > There is no need for the export symbol - you don't call that function
> > from module code.  
> That's what I have learned now: You don't need to export a symbol
> as long as the symbol is only called in static code parts of the kernel.
> But you need to export it when it is intended to be used by code
> which sits in a kernel module. So now the big question:
> How does a provider of a function in the kernel know, if the caller is in static
> code or in module code ? And ... maybe this may even change over
> the time. So my recommendation is to always export the symbol with
> the EXPORT_SYMBOL macro. This way you don't need to change the
> code providing a function when the caller code changes or additional
> code uses the symbol.
> 
> Other opinions ?

Well, if you know it will be called from module code in upcoming
patches, export it. If not, I consider it the choice of the maintainer.
You can easily add the export later on, if needed, anyway, and I don't
consider changing the code a problem.

In this particular case, both exporting and not exporting looked like
reasonable choices to me.
