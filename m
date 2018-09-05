Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56ABC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C47205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CzYbztGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C47205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeIEOOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:14:53 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:51400 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeIEOOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:14:53 -0400
Received: by mail-it0-f44.google.com with SMTP id e14-v6so9035809itf.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 02:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=PfPGwGLvJnysUc8C5bXebeQdV7w+CDfwfnVO5I1prEQ=;
        b=CzYbztGi4xq3zgkOAlTEelqqdkBZclSW2S0br8QSxRHHcBPgQyyMurP5NiNPz9iiA7
         XQqQNBdmyAFhBq94e0QRlfr8TpGI1T9NKgyShwcXvIFUXgChPxB+5cB6te+vcc1WOzHH
         O8cW8MNjEJ2nYoMZ7ao9G4JK/XpLv5jJKeIls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=PfPGwGLvJnysUc8C5bXebeQdV7w+CDfwfnVO5I1prEQ=;
        b=PiKUNeuEktWDva4GIflV7IyHTn2c/VrfOyyTaWJhlxilC8dWhUS5B1h6v+TLdKDfqy
         ynlmueCbWtv2SyBvkxrig3c2tMYezAY8ApAdrSxnAc1Og2HRruI6ie2Dzb/XpqWySjQ0
         Zs7qKt6+BlPRvtKN6nR6YEzr1EnHFL53DJSyJRTdaoS0d4VmC57suyCLEJJkXZveB6ba
         yeHPoTzlrU7qDdghHJBaYt+R6N37ZxLNVAlX58ANMT4FBPHCypd1kxW80LZUq2iTiMO3
         roa+RXjVXz/r4ZIy/C4/PZ+LTo31/tVhH8B/HIk4PUwH65XHeT3qecHzrxIDEnKmV1+c
         +Onw==
X-Gm-Message-State: APzg51BH3Q4dzrFsDpX83gn7esZ1vycv4VDN/vwio12c1os0DsNU/34S
        XPsFzGVaABBqlDbelV8fPR+H/HyE5O5m6udbxTdVUA==
X-Google-Smtp-Source: ANB0Vdb3K5Imx1ahECffasgKAhmpQ08Le0Mu1uIMRHio/8EU0OtnLwqneu+fREEisfROb876Ww4qKu40jr/KNgcx+x8=
X-Received: by 2002:a24:8203:: with SMTP id t3-v6mr2995821itd.150.1536140727799;
 Wed, 05 Sep 2018 02:45:27 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <eccc46e12890a1d033d9003837012502@mail.gmail.com>
 <20180829084618.GA24765@ming.t460p> <300d6fef733ca76ced581f8c6304bac6@mail.gmail.com>
 <CACVXFVM7nGxpyq0_jfshgBOTx5B+PuCDmN43SfPTCkENJRLpMg@mail.gmail.com>
 <615d78004495aebc53807156d04d988c@mail.gmail.com> <alpine.DEB.2.21.1808312207390.1349@nanos.tec.linutronix.de>
 <486f94a563d63c4779498fe8829a546c@mail.gmail.com> <alpine.DEB.2.21.1809010020520.1349@nanos.tec.linutronix.de>
 <602cee6381b9f435a938bbaf852d07f9@mail.gmail.com> <alpine.DEB.2.21.1809021357000.1349@nanos.tec.linutronix.de>
 <66256272c020be186becdd7a3f049302@mail.gmail.com> <alpine.DEB.2.21.1809031719460.1383@nanos.tec.linutronix.de>
 <dd1c5df55aa99cf4a37bcc58e77e840a@mail.gmail.com> <f436fa6a-b865-fadb-4f77-44309ff84405@163.com>
In-Reply-To: <f436fa6a-b865-fadb-4f77-44309ff84405@163.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQL9fTS7902n0VSYivL2AMCzXDd9xwGQx87UAiSubfsBGBaHbgI3aj7TAe+rdbUBJEp+nAJfSXIOAX62R1ABhljzHgIazpE8Asv00cwBl1+FOAMPYBbsocaohNA=
Date:   Wed, 5 Sep 2018 15:15:20 +0530
Message-ID: <c0f779f1d5ef131c39f9397f97d453e8@mail.gmail.com>
Subject: RE: Affinity managed interrupts vs non-managed interrupts
To:     Dou Liyang <dou_liyang@163.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        linux-block <linux-block@vger.kernel.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Thomas, Kashyap,
>
> At 09/04/2018 06:29 PM, Kashyap Desai wrote:
> >>> I am using " for-4.19/block " and this particular patch "a0c9259
> >>> irq/matrix: Spread interrupts on allocation" is included.
> >>
>
> IMO, this patch is just used for non-managed interrupts.
>
> >> So if all 16 have their effective affinity set to CPU0 then that's
> > strange
>
> But, all these 16 are managed interrupts, and will be assigned vectors
> by assign_managed_vector():
> {
>      cpumask_and(vector_searchmask, vector_searchmask, affmsk);
>      cpu = cpumask_first(vector_searchmask);
>
>      ...
>      vector = irq_matrix_alloc_managed(vector_matrix, cpu);
>      ...
> }
>
> Where we always used the *first* cpu in the vector_searchmask(0-71), not
> the suitable one. So I guess this situation happened.
>
> Shall we also spread the managed interrupts on allocation?


Hi Dou,

I tried your proposed patch. Using patch, It is not assigning effective irq
to CPU = 0 , but it pick *one* cpu from 0-71 range.
Eventually, effective cpu is always *one* logical cpu. Behavior is
different, but impact is still same.
