Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79748C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 19:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C5021104
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 19:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="tl6OAAIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C5021104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbeKKEv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 23:51:28 -0500
Received: from imap.thunk.org ([74.207.234.97]:36754 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbeKKEv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 23:51:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=iHY5ehNmGhgdfedairkMdWH2RZSxExFRl6CmvaFzQE4=; b=tl6OAAIpfDUtA2WpuvS2u3JysM
        SSfHrlMAINapqsG7B0T+QqU2j9tE/oLDuDLrlRp7sYGKrZfLDaXhuNpdFLi0z/HD1zdBi9HG/cwlw
        fc+0Nz2eo/BllT9iHnJN+pO1urPPcpoIorUqx/T9syGaBpdOquvAZDsiibSbgcY2HmaE=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gLYZO-0004sm-Cm; Sat, 10 Nov 2018 19:05:22 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2AE2B7A4EC9; Sat, 10 Nov 2018 14:05:21 -0500 (EST)
Date:   Sat, 10 Nov 2018 14:05:21 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH 0/3] SG_IO command filtering via sysfs
Message-ID: <20181110190521.GA2627@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <1541867733-7836-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541867733-7836-1-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder if a better way of adding SG_IO command filtering is via
eBPF?  We are currently carrying a inside Google a patch which allows
a specific of SCSI commands to non-root processes --- if the process
belonged to a particular Unix group id.

It's pretty specific to our use case, in terms of the specific SCSI
commands we want to allow through.  I can imagine people wanting
different filters based on the type of the SCSI device, or a HDD's
WWID, not just a group id.  For example, this might be useful for
people wanting to do crazy things with containers --- maybe you'd
want to allow container root to send a SANITIZE ERASE command to one
of its exclusively assigned disks, but not to other HDD's.

So having something that's more general than a flat file in sysfs
might be preferable to resurrecting an interface which we would then
after to support forever, even if we come up with a more general
interface.

					- Ted
