Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C7DC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 23:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4886B24D5E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 23:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4886B24D5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbeFWXek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 19:34:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751583AbeFWXei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 19:34:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3A92E7C6A9;
        Sat, 23 Jun 2018 23:34:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-238.rdu2.redhat.com [10.10.120.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 136E32026D69;
        Sat, 23 Jun 2018 23:34:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180622165715.GA5361@outlook.office365.com>
References: <20180622165715.GA5361@outlook.office365.com> <20180621184754.GB21326@outlook.office365.com> <152720682792.9073.14747437198191460035.stgit@warthog.procyon.org.uk> <29799.1529671936@warthog.procyon.org.uk> <20180622153029.GA3070@outlook.office365.com>
To:     Andrei Vagin <avagin@virtuozzo.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: Re: [16/32] kernfs, sysfs, cgroup, intel_rdt: Support fs_context [ver #8]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <16504.1529796876.1@warthog.procyon.org.uk>
Date:   Sun, 24 Jun 2018 00:34:36 +0100
Message-ID: <16505.1529796876@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Sat, 23 Jun 2018 23:34:38 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Sat, 23 Jun 2018 23:34:38 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrei Vagin <avagin@virtuozzo.com> wrote:

> > > >                 percpu_ref_reinit(&root->cgrp.self.refcnt);
> > > >                 mutex_unlock(&cgroup_mutex);
> > > >         }
> > > > +       cgroup_get(&root->cgrp);
> > > 
> > > This probably needs to be conditional on ret == 0.
> > 
> > yes, you are right
> 
> 
> I've read the code and I think it isn't obvious. A reference will be
> released id cgroup_fs_context_free() even if ret isn't zero here.
> 
> I look at do_new_mount()
> 
> vfs_new_fs_context()
> ...
> if (vfs_get_tree()) 
> 	goto out_fc;
> ....
> out_fc:
> put_fs_context(fc);
> 	fc->ops->free(fc);
> 		cgroup_fs_context_free()
> 			cgroup_put(&ctx->root->cgrp);

Yeah, you're right: ctx->root is set above, so the put will trigger anyway.
I'll fold both of these changes in.

David
