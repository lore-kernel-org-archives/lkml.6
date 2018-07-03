Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362AEC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD7621C66
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gt6JTKOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD7621C66
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934249AbeGCRIH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:08:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39583 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933677AbeGCRIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:08:05 -0400
Received: by mail-wm0-f67.google.com with SMTP id p11-v6so3057048wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 10:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Btgj+Fp1aw0ecYcMPqSZF3pvPjc45wcKuIDXd1bMbeM=;
        b=gt6JTKOGf25CL8ltr40Y5lfXADBTy2C5fQ8SzwcdsmKfTBqAifJjsu9ddbqomrCfMu
         M9dBqMvyZhZ5G1+6yqkoK1d0nF9p++fLcqAoB5iz+l+CwCty0grOJNdeM1Qlc0uiUqMt
         lzYQWdJ/JIhXGkF9uqtNm9Q+054vhQyvDMRCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Btgj+Fp1aw0ecYcMPqSZF3pvPjc45wcKuIDXd1bMbeM=;
        b=GtvxW9mSH6xJpUL6qBEx9Lnq3c3NggMdaNvEGQl4hNf4Sdo3sktf7N+oVZBJua25/D
         yAtZVvbxc7A3vVAiV4mUQLxt3Fc1WvXVx5FCNLvlqWX5fRXoTD4n+4touHmWvRNR7BZU
         qYh2CsadZw5IQTHroQYbX2t3XTpeAzB32B3DXNgZLclii8IKAouAmFjKfFja7RH8cEIY
         /PYApcIEuXJ2fwmiQR6eWR7w+pqk9E0K2TRygoGyrVnhqXDZoLK54gveu96UN0xUIjWd
         GVeGgzqQJW/U/kKGX6xAkWdzkI0i3uAzoik0TR7R4uN7GawSSx6b6RIpNCZhCeGAHJXw
         eSWQ==
X-Gm-Message-State: APt69E3E2mr5zDEIKb7M5GfrgtH+I5z8epy8KrrXxex7s54yGG5O7qtP
        +jhw4KRZfyYQl6lKKhba8OXpGg==
X-Google-Smtp-Source: AAOMgpeOCdA3M4P3Bo8F7CGf/+QnU/gNOueBqwUNuKnfYaHQuzSZeFVegI2smnSqOx4zjjJp3HR3qw==
X-Received: by 2002:a1c:3743:: with SMTP id e64-v6mr8239720wma.63.1530637684471;
        Tue, 03 Jul 2018 10:08:04 -0700 (PDT)
Received: from andrea ([94.230.152.15])
        by smtp.gmail.com with ESMTPSA id o42-v6sm4283818wrc.50.2018.07.03.10.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 10:08:03 -0700 (PDT)
Date:   Tue, 3 Jul 2018 19:07:57 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 2/3] locking: Clarify requirements for
 smp_mb__after_spinlock()
Message-ID: <20180703170757.GA3251@andrea>
References: <1530544315-14614-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1530629639-27767-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20180703153910.GZ3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703153910.GZ3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 08:39:10AM -0700, Paul E. McKenney wrote:

[...]

> > + * smp_mb__after_spinlock() provides the equivalent of a full memory barrier
> > + * between program-order earlier lock acquisitions and program-order later
> 
> Not just the earlier lock acquisition, but also all program-order earlier
> memory accesses, correct?

I understand: "but also all program-order earlier memory accesses program-order
before that lock acquisition(s) ...".  Yes, but:

  - I considered this as implied by the above (L ->mb M2 and M1 ->po L implies
    M1 ->mb M2, where M1, M2 are memory accesses and L is a lock acquisition);

  - my prose abilities are limited ;-), and I was/am unable to come up with an
    (to me) acceptable or readable enough way to make it explicit; some ideas?


> > + *	  WRITE_ONCE(X, 1);		WRITE_ONCE(Y, 1);
> > + *	  spin_lock(S);			smp_mb();
> > + *	  smp_mb__after_spinlock();	r1 = READ_ONCE(X);
> > + *	  r0 = READ_ONCE(Y);
> > + *	  spin_unlock(S);
> 
> Should we say that this is an instance of the SB pattern?  (Am OK either
> way, just asking the question.)

I don't think we *should* ;-),  but I'm also OK either way.

  Andrea
