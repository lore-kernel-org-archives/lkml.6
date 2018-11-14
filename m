Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE88C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F74208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F74208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387476AbeKOCJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:09:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbeKOCJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 21:09:55 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 982FE308FB94;
        Wed, 14 Nov 2018 16:06:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id CB31116D24;
        Wed, 14 Nov 2018 16:06:01 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 14 Nov 2018 17:06:05 +0100 (CET)
Date:   Wed, 14 Nov 2018 17:06:01 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     srikar@linux.vnet.ibm.com, rostedt@goodmis.org,
        mhiramat@kernel.org, liu.song.a23@gmail.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        ananth@linux.vnet.ibm.com, alexis.berlemont@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Subject: Re: [PATCH] Uprobes: Fix kernel oops with delayed_uprobe_remove()
Message-ID: <20181114160600.GD13885@redhat.com>
References: <20181114081921.26484-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114081921.26484-1-ravi.bangoria@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 14 Nov 2018 16:06:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14, Ravi Bangoria wrote:
>
> syzbot reported a kernel crash with delayed_uprobe_remove():
>   https://lkml.org/lkml/2018/11/1/1244
>
> Backtrace mentioned in the link points to a race between process
> exit and uprobe_unregister(). Fix it by locking delayed_uprobe_lock
> before calling delayed_uprobe_remove() from put_uprobe().

The patch looks good to me, but could you update the changelog?

Please explain that the exiting task calls uprobe_clear_state() which
can race with delayed_uprobe_remove(). IIUC this is the only problem
solved by this patch, right?

Oleg.

