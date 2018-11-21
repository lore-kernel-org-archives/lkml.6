Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D145FC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 01:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2D221479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 01:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cl5jJ6D9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2D221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbeKULxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 06:53:45 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44337 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeKULxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 06:53:44 -0500
Received: by mail-pl1-f193.google.com with SMTP id s5-v6so2912204plq.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 17:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=2D73gjRidyYQ/3FyXjZa4h5O4Q+am1oL7JNrgFkWp0o=;
        b=cl5jJ6D9G9fBFlUUph2l0Zwa0pqxtvCMMenC9DAXuUiurcNxPcGamhS4wQzQhx4F3d
         5rN82FohTLTliLyFFafj5EdgWEDAQ+3yrSfl3gm8uj6xRTFwmnb4RYS/IIPWTu5h9+oS
         uY80JX9xxTv6QVrbK2SONNnzYHyGZy+V7DOJisb6oZmFghKNz4dX7WV05W8DdeyEvuZU
         rx6AXbl4R1LZ0+dAUxemK+F9fALUQsrPBik1W6bAfI20Vn739kKOkziN4N9+sMEfiDFz
         Oi4FX7ClAvmRNYosQQqXkJn00244WnfRrYQXNYuN7g+nsDFMvZanSOER/u1NC3MUvtF2
         xuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=2D73gjRidyYQ/3FyXjZa4h5O4Q+am1oL7JNrgFkWp0o=;
        b=qQ/lT9MFni0JBb6YUs4YKYXaEa4UnyZxYi41xEiTaqpE5zGgz0x2zUH/zsicNP8Yoy
         ocyTUFe2z4O7D70wpUIdhSB8mWs1nEBJl/I0BYEcnoHOa0x7w0OoLiqMEfL0mw45m/ZN
         i7QbIUdrPamd9UnVisyqMPxK/Gd0G+1vH/ZHFINQqhroSsupLwxLQBtfgd9S6B1UAEiq
         4l7UioSxby1bH0T7NcO1FkAWq8FitKIyUH/Fi5ZbQ5R+C0ljqQTQtrpp+y8M346moN/6
         NJHU9Uz1tvTeMwtCaL06izF0ACurqMYUCTNuuD+IOsnc9iBbipIg//7x9oCPzuO9xBCt
         TrQQ==
X-Gm-Message-State: AGRZ1gK46HZO94H0K0xBGSwtLGtbQUXrWIbcESsYaveQuAg/D/rt8XYk
        eARqH0tV54s0Ik7br53zk8KIKQ==
X-Google-Smtp-Source: AJdET5c9cPqLziXRBTjbRxINFNEihC2YdVHhdyRfsSoHvZQWe972AfmkCobP4nyD+O+4etsp1bICrQ==
X-Received: by 2002:a62:8c11:: with SMTP id m17mr4651342pfd.224.1542763298445;
        Tue, 20 Nov 2018 17:21:38 -0800 (PST)
Received: from [100.112.89.103] ([104.133.8.103])
        by smtp.gmail.com with ESMTPSA id p6sm23987613pfn.53.2018.11.20.17.21.37
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Nov 2018 17:21:37 -0800 (PST)
Date:   Tue, 20 Nov 2018 17:21:36 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Baoquan He <bhe@redhat.com>
cc:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, pifang@redhat.com,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        aarcange@redhat.com, Mel Gorman <mgorman@suse.de>
Subject: Re: Memory hotplug softlock issue
In-Reply-To: <20181120135803.GA3369@MiWiFi-R3L-srv>
Message-ID: <alpine.LSU.2.11.1811201710410.2061@eggly.anvils>
References: <20181119105202.GE18471@MiWiFi-R3L-srv> <20181119124033.GJ22247@dhcp22.suse.cz> <20181119125121.GK22247@dhcp22.suse.cz> <20181119141016.GO22247@dhcp22.suse.cz> <20181119173312.GV22247@dhcp22.suse.cz> <alpine.LSU.2.11.1811191215290.15640@eggly.anvils>
 <20181119205907.GW22247@dhcp22.suse.cz> <20181120015644.GA5727@MiWiFi-R3L-srv> <alpine.LSU.2.11.1811192127130.2848@eggly.anvils> <3f1a82a8-f2aa-ac5e-e6a8-057256162321@suse.cz> <20181120135803.GA3369@MiWiFi-R3L-srv>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018, Baoquan He wrote:
> On 11/20/18 at 02:38pm, Vlastimil Babka wrote:
> > On 11/20/18 6:44 AM, Hugh Dickins wrote:
> > > [PATCH] mm: put_and_wait_on_page_locked() while page is migrated
> > > 
> > > We have all assumed that it is essential to hold a page reference while
> > > waiting on a page lock: partly to guarantee that there is still a struct
> > > page when MEMORY_HOTREMOVE is configured, but also to protect against
> > > reuse of the struct page going to someone who then holds the page locked
> > > indefinitely, when the waiter can reasonably expect timely unlocking.
> > > 
> > > But in fact, so long as wait_on_page_bit_common() does the put_page(),
> > > and is careful not to rely on struct page contents thereafter, there is
> > > no need to hold a reference to the page while waiting on it.  That does
> > 
> > So there's still a moment where refcount is elevated, but hopefully
> > short enough, right? Let's see if it survives Baoquan's stress testing.
> 
> Yes, I applied Hugh's patch 8 hours ago, then our QE Ping operated on
> that machine, after many times of hot removing/adding, the endless
> looping during mirgrating is not seen any more. The test result for
> Hugh's patch is positive. I even suggested Ping increasing the memory
> pressure to "stress -m 250", it still succeeded to offline and remove.
> 
> So I think this patch works to solve the issue. Thanks a lot for your
> help, all of you. 

Very good to hear, thanks a lot for your quick feedback.

> 
> High, will you post a formal patch in a separate thread?

Yes, I promise that I shall do so in the next few days, but not today:
some other things have to take priority.

And Vlastimil has raised an excellent point about the interaction with
PSI "thrashing": I need to read up and decide which way to go on that
(and add Johannes to the Cc when I post).

I think I shall probably post it directly to Linus (lists and other
people Cc'ed of course): not because I think it should be rushed in
too quickly, nor to sidestep Andrew, but because Linus was very closely
involved in both the PG_waiters and WQ_FLAG_BOOKMARK discussions:
it is an area of special interest to him.

Hugh
