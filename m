Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B180ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CBE52150E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBE52150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387841AbeITS43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:56:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49102 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387656AbeITS43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:56:29 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9DA7D122F;
        Thu, 20 Sep 2018 13:13:00 +0000 (UTC)
Date:   Thu, 20 Sep 2018 15:12:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Frank Haverkamp <haver@linux.vnet.ibm.com>,
        Joerg-Stephan Vogt <jsvogt@de.ibm.com>,
        Michael Jung <mijung@gmx.net>,
        Michael Ruettger <michael@ibmra.de>,
        Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        "Eberhard S. Amann" <esa@linux.vnet.ibm.com>,
        Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>,
        "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Subject: Re: [PATCH] signal/GenWQE: Fix sending of SIGKILL
Message-ID: <20180920131258.GB18628@kroah.com>
References: <87a7olllkk.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7olllkk.fsf@xmission.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 12:48:43PM +0200, Eric W. Biederman wrote:
> 
> The genweq_add_file and genwqe_del_file by caching current without
> using reference counting embed the assumption that a file descriptor
> will never be passed from one process to another.  It even embeds the
> assumption that the the thread that opened the file will be in
> existence when the process terminates.   Neither of which are
> guaranteed to be true.
> 
> Therefore replace caching the task_struct of the opener with
> pid of the openers thread group id.  All the knowledge of the
> opener is used for is as the target of SIGKILL and a SIGKILL
> will kill the entire process group.
> 
> Rename genwqe_force_sig to genwqe_terminate, remove it's unncessary
> signal argument, update it's ownly caller, and use kill_pid
> instead of force_sig.
> 
> The work force_sig does in changing signal handling state is not
> relevant to SIGKILL sent as SEND_SIG_PRIV.  The exact same processess
> will be killed just with less work, and less confusion.  The work done
> by force_sig is really only needed for handling syncrhonous
> exceptions.
> 
> It will still be possible to cause genwqe_device_remove to wait 8
> seconds by passing a file descriptor to another process but the possible
> user after free is fixed.
> 
> Fixes: eaf4722d4645 ("GenWQE Character device and DDCB queue")
> Cc: stable@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Frank Haverkamp <haver@linux.vnet.ibm.com>
> Cc: Joerg-Stephan Vogt <jsvogt@de.ibm.com>
> Cc: Michael Jung <mijung@gmx.net>
> Cc: Michael Ruettger <michael@ibmra.de>
> Cc: Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
> Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>
> Cc: Eberhard S. Amann <esa@linux.vnet.ibm.com>
> Cc: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
> Cc: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
> 
> Greg I intend to take this through my signal tree, but if you would
> rather take this through your driver tree please feel free.

No objection from me for you to take it through your tree:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
