Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D3BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 14:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4542A20866
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 14:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="FW8qMwA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4542A20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbeKLADQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 19:03:16 -0500
Received: from imap.thunk.org ([74.207.234.97]:39000 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbeKLADQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 19:03:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=2diJwel1IJO70Z7qyxwON0LE379exu3ORwdksOT4SrQ=; b=FW8qMwA4naVDuIzrbcc35teSEA
        TSzQ6S32pnGdKwmLLlH7awr48YUSbmQ1TqsR+ffumQFrIYFKD0PGCXGn/Z7v72i9hrPUavzk3OK/z
        YJZZ8MmbQ2Za8n90P6/OQfS3rNcyl95BncDKbcWuLVxr/MaOvj4kHgATfb0G2f2OKPRY=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gLqVS-0000Zw-5f; Sun, 11 Nov 2018 14:14:30 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A866C7A0486; Sun, 11 Nov 2018 09:14:26 -0500 (EST)
Date:   Sun, 11 Nov 2018 09:14:26 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH 0/3] SG_IO command filtering via sysfs
Message-ID: <20181111141426.GA7377@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <1541867733-7836-1-git-send-email-pbonzini@redhat.com>
 <20181110190521.GA2627@thunk.org>
 <566bc821-f12a-f7c1-e7c7-99092807ee27@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <566bc821-f12a-f7c1-e7c7-99092807ee27@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 02:26:45PM +0100, Paolo Bonzini wrote:
> 
> I'm not very eBPF savvy, the question I have is: what kind of
> information about the running process is available in an eBPF program?
> For example, even considering only the examples you make, would it be
> able to access the CDB, the capabilities and uid/gid of the task, the
> SCSI device type, the WWN?  Of course you also need the mode of the file
> descriptor in order to allow SANITIZE ERASE if the disk is opened for write.

The basic uid/gid of the task is certainly available.  For storage
stack specific things, it's a matter of what we make available to the
eBPF function.  For example, there is an experimental netfilter
replacement which uses eBPF; obviously that requires making the packet
which is being inspecting so it can be given a thumbs up or thumbs
down result.  That's going to require letting the eBPF function to
have access to the network header, access to the connection tracking
tables, etc.

You can basically think of it as passing arguments to a function
except it's it's written in eBPF instead of C.  You can also define
eBPF functions implemented in C which can be called from eBPF code.

						- Ted
