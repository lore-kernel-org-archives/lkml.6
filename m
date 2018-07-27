Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DB3C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5114D208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:55:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5114D208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732143AbeG0PRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:17:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55508 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730458AbeG0PRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:17:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D6E940216E7;
        Fri, 27 Jul 2018 13:55:33 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id F0E221102E29;
        Fri, 27 Jul 2018 13:55:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 27 Jul 2018 15:55:33 +0200 (CEST)
Date:   Fri, 27 Jul 2018 15:55:29 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        mhiramat@kernel.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, ananth@linux.vnet.ibm.com,
        alexis.berlemont@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Subject: Re: [PATCH v6 5/6] Uprobes/sdt: Prevent multiple reference counter
 for same uprobe
Message-ID: <20180727135528.GA3618@redhat.com>
References: <20180716084706.28244-1-ravi.bangoria@linux.ibm.com>
 <20180716084706.28244-6-ravi.bangoria@linux.ibm.com>
 <20180725110802.GA27325@redhat.com>
 <19d8abb0-44a3-cb26-405d-95f63fc01517@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19d8abb0-44a3-cb26-405d-95f63fc01517@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 27 Jul 2018 13:55:33 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 27 Jul 2018 13:55:33 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi,

On 07/27, Ravi Bangoria wrote:
>
> > I simply can't understand this "bool installed"....
>
>
> That boolean is needed because consumer_filter() returns false when this
> function gets called first time from uprobe_register().

Ah yes, I forgot about the (ugly) 2-stage TRACE_REG_PERF_REGISTER +
TRACE_REG_PERF_OPEN logic...

But then I think the whole idea of REF_CTR_OFF_RELOADED is even more broken.
Nevermind.

> I have a solution for this. Idea is, if reference counter is reloaded, save
> of all mms for which consumer_filter() denied to updated when being called
> from register_for_each_vma(). Use this list of mms as checklist next time
> onwards. I don't know if it's good to do that or not.

Sounds horrible ;) and I bet this is not enough.

> Please let me know if you have any better approach.

Just drop this patch.

If we can't make it per consumer, let it be global like it was in first version.

Oleg.

