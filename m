Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B011C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC48F2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kjiIMrU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC48F2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388512AbeKFWqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:46:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47712 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388105AbeKFWqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:46:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XcYA4IlPewmqzQReOhJL/EqItgnt4Pv+AIP/cOQCXT0=; b=kjiIMrU6k8o+HgEiPPL6Nc6Mg
        aan5gZGWaa3L0+YZ5r+VIglQ7Y+MDRxCTgyTN8ou392ufr5wgovL2OhYKO7CODkQocYtoJF1shf6V
        KTduZAyI47vY8KlbHhGWJlxKYkDsfxap9VxEPh054UfnXcGXvckf3xQnu0EcLnUnZlaOdWoksunM/
        OfRtKKIp3VXVfU6vrfYH4sb1YYJrDWn4f4jRavV6GFwbvzbpjZxTcl4DDilxW4//tTRD1CnVC1kNO
        lZylZnvOZmIe/3B5sdVQqxK1mxt8YQTTv1WnlVMRoz9cTsNq8KPfap0tOSStP3YbhI5mzZ0gpiyHc
        jBnZiyWOQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gK1Hv-0002WG-JI; Tue, 06 Nov 2018 13:20:59 +0000
Date:   Tue, 6 Nov 2018 05:20:59 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Takashi Iwai <tiwai@suse.de>, Davidlohr Bueso <dbueso@suse.de>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH v10 1/4] ipc: Allow boot time extension of IPCMNI from
 32k to 8M
Message-ID: <20181106132059.GD3074@bombadil.infradead.org>
References: <1541432626-27780-1-git-send-email-longman@redhat.com>
 <1541432626-27780-2-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541432626-27780-2-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 10:43:43AM -0500, Waiman Long wrote:
> The maximum number of unique System V IPC identifiers was limited to
> 32k.  That limit should be big enough for most use cases.
> 
> However, there are some users out there requesting for more, especially
> those that are migrating from Solaris which uses 24 bits for unique
> identifiers. To satisfy the need of those users, a new boot time kernel
> option "ipcmni_extend" is added to extend the IPCMNI value to 8M. This
> is a 256X increase which hopefully is big enough for them.

Why go to 23 bits when people are coming from systems with 24 bits?
Let's just go to 24 bits.  This happens to fit well with the underlying
data structure which uses 6 bits per layer of the tree.

> The use of this new option will change the pattern of the IPC identifiers
> returned by functions like shmget(2). An application that depends on
> such pattern may not work properly.  So it should only be used if the
> users really need more than 32k of unique IPC numbers.

Are there applications out there that rely on the internal structure of
the IPC identifiers?!

How about scrapping all this and just doing the following:

Allocate 24 bits of the ID cyclically.  Increment the top 7 bits of the
ID every time the cursor wraps.  That's not going to give us a perfect
progression from 0-2 billion, because it'll skip the ones in use.
But it'll ensure the ID isn't reused particularly quickly unless the
application is really using millions of IDs.
