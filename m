Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9435FC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5D922407
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5D922407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030599AbeGBLjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:39:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59428 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030567AbeGBLjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:39:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BA76A308402F;
        Mon,  2 Jul 2018 11:39:03 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AA9DB6016F;
        Mon,  2 Jul 2018 11:39:03 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 9AB6C1800B68;
        Mon,  2 Jul 2018 11:39:03 +0000 (UTC)
Date:   Mon, 2 Jul 2018 07:39:03 -0400 (EDT)
From:   Rodrigo Freire <rfreire@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <1583797106.15227304.1530531543526.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180702112906.GH19043@dhcp22.suse.cz>
References: <7de14c6cac4a486c04149f37948e3a76028f3fa5.1530461087.git.rfreire@redhat.com> <20180702093043.GB19043@dhcp22.suse.cz> <1113748807.15224076.1530530533122.JavaMail.zimbra@redhat.com> <20180702112906.GH19043@dhcp22.suse.cz>
Subject: Re: [PATCH] mm: be more informative in OOM task list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.97.116.8, 10.4.195.4]
Thread-Topic: be more informative in OOM task list
Thread-Index: kWhy4UPh4UlUgHWt0Cdtg9onaXIWpg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 02 Jul 2018 11:39:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michal!

----- Original Message ----- 
> From: "Michal Hocko" <mhocko@kernel.org>
> To: "Rodrigo Freire" <rfreire@redhat.com>
> Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
> Sent: Monday, July 2, 2018 8:29:06 AM
> Subject: Re: [PATCH] mm: be more informative in OOM task list
>
> On Mon 02-07-18 07:22:13, Rodrigo Freire wrote:
> > Hello Michal,
> >
> > ----- Original Message -----
> > > From: "Michal Hocko" <mhocko@kernel.org>
> > > To: "Rodrigo Freire" <rfreire@redhat.com>
> > > Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
> > > Sent: Monday, July 2, 2018 6:30:43 AM
> > > Subject: Re: [PATCH] mm: be more informative in OOM task list
> > >
> > > On Sun 01-07-18 13:09:40, Rodrigo Freire wrote:
> > > > The default page memory unit of OOM task dump events might not be
> > > > intuitive for the non-initiated when debugging OOM events. Add
> > > > a small printk prior to the task dump informing that the memory
> > > > units are actually memory _pages_.
> > >
> > > Does this really help? I understand the the oom report might be not the
> > > easiest thing to grasp but wouldn't it be much better to actually add
> > > documentation with clarification of each part of it?
> >
> > That would be great: After a quick grep -ri for oom in Documentation,
> > I found several other files containing its own OOM behaviour modifier
> > configurations. But it indeed lacks a central and canonical Doc file
> > which documents the OOM Killer behavior and workflows.
> >
> > However, I still stand by my proposed patch: It is unobtrusive, infers
> > no performance issue and clarifying: I recently worked in a case (for
> > full disclosure: I am a far cry from a MM expert) where the sum of the
> > RSS pages made sense when interpreted as real kB pages. Reason: There
> > were processes sharing (a good amount of) memory regions, misleading
> > the interpretation and that misled not only me, but some other
> > colleagues a well: The pages was only sorted out after actually
> > inspecting the source code.
> >
> > This patch is user-friendly and can be a great time saver to others in
> > the community.
>
> Well, all other counters we print are in page units unless explicitly
> kB. 

Your statement is correct. And I thought about that too. And then the doubt:
* Maybe someone forgot to state that these values are in kB?

> So I am not sure we really need to do anything but document the
> output better. Maybe others will find it more important though.

The thing is, it also led some other colleagues (a few!) to think the
very same as me: That raised the flag and made me write the patch:
That was indeed misleading.
And you may not have a MM and OOM-versed specialist available all the 
time! ;-)

Still ask you to reconsider.

My best regards,

- RF.
