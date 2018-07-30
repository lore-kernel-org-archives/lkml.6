Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E459613F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC2520881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC2520881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbeG3LvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:51:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726653AbeG3LvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:51:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 22AEE4000784;
        Mon, 30 Jul 2018 10:17:02 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.34.27.30])
        by smtp.corp.redhat.com (Postfix) with SMTP id 109B57C2F;
        Mon, 30 Jul 2018 10:17:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 30 Jul 2018 12:17:01 +0200 (CEST)
Date:   Mon, 30 Jul 2018 12:17:00 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     =?iso-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] prctl: add PR_[GS]ET_KILLABLE
Message-ID: <20180730101659.GA24781@redhat.com>
References: <20180730075241.24002-1-j@bitron.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180730075241.24002-1-j@bitron.ch>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 30 Jul 2018 10:17:02 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 30 Jul 2018 10:17:02 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'oleg@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/30, Jürg Billeter wrote:
>
> This is required for job control in a shell that uses CLONE_NEWPID for
> child processes.

Could you explain in more details?

> +	case PR_SET_KILLABLE:
> +		if (arg2 != 1 || arg3 || arg4 || arg5)
> +			return -EINVAL;
> +		me->signal->flags &= ~SIGNAL_UNKILLABLE;

this needs spin_lock_irq(me->sighand->siglock).

Oleg.

