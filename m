Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACF4C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 03:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE07208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 03:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE07208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933083AbeGIDwo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 23:52:44 -0400
Received: from smtprelay0103.hostedemail.com ([216.40.44.103]:48639 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932842AbeGIDwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 23:52:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id EECDE1801D2E3;
        Mon,  9 Jul 2018 03:52:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: day81_348d9ce37994a
X-Filterd-Recvd-Size: 2582
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Mon,  9 Jul 2018 03:52:41 +0000 (UTC)
Message-ID: <75bfb54e1292e31830aafb8329e3cc81d1412ff5.camel@perches.com>
Subject: Re: [PATCH v3 1/2] powerpc: Detect the presence of big-cores via
 "ibm, thread-groups"
From:   Joe Perches <joe@perches.com>
To:     Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Sun, 08 Jul 2018 20:52:39 -0700
In-Reply-To: <20180708160334.GA6947@kermit-br-ibm-com>
References: <cover.1530867876.git.ego@linux.vnet.ibm.com>
         <abaea3bd2aa89c7c9f284e3a7beabb865d8e1050.1530867876.git.ego@linux.vnet.ibm.com>
         <20180708160334.GA6947@kermit-br-ibm-com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-07-08 at 13:03 -0300, Murilo Opsfelder Araujo wrote:
> On Fri, Jul 06, 2018 at 02:35:48PM +0530, Gautham R. Shenoy wrote:
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > 
> > On IBM POWER9, the device tree exposes a property array identifed by
> > "ibm,thread-groups" which will indicate which groups of threads share a
> > particular set of resources.
[]
> > diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
[]
> > @@ -1025,6 +1026,33 @@ static ssize_t show_physical_id(struct device *dev,
> >  }
> >  static DEVICE_ATTR(physical_id, 0444, show_physical_id, NULL);
> >  
> > +static ssize_t show_small_core_siblings(struct device *dev,
> > +					struct device_attribute *attr,
> > +					char *buf)
> > +{
> 
> Interesting enough, checkpatch.pl warned about this function name:
> 
>     WARNING: Consider renaming function(s) 'show_small_core_siblings' to 'small_core_siblings_show'
>     #354: FILE: arch/powerpc/kernel/sysfs.c:1053:
>     +}

It's to allow the DEVICE_ATTR below to be renamed to DEVICE_ATTR_RO 

> > +static DEVICE_ATTR(small_core_siblings, 0444, show_small_core_siblings, NULL);

So this becomes 

DEVICE_ATTR_RO(small_core_siblings)

