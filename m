Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A56C485C2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC632086E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Vd/iVz4O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC632086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732554AbeGLRbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:31:52 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38222 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727366AbeGLRbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:31:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6B6288EE3D1;
        Thu, 12 Jul 2018 10:21:22 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id v7uBKOlRvzJQ; Thu, 12 Jul 2018 10:21:22 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5BBF38EE02B;
        Thu, 12 Jul 2018 10:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1531416082;
        bh=zyZh5Q25EA/lJyDUxSqWTDBIZdVBeBvleUeq+/iF1G8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Vd/iVz4OhaEcWGVSmIO5ez/3XtdG3Yye4M/5n4vfDzAaK/aiO1uoOLyfwZZSP8MrR
         v8m2zJi66XuVeNmBZ2eIyjOhgo2Txqba4g/wy/DFU3BJaYRKDa3294EX5ddwdbBsVT
         yej0ibeMfuVBKfFguDGJEslWN/BRoI1cJoUuFHaY=
Message-ID: <1531416080.18255.8.camel@HansenPartnership.com>
Subject: Re: [PATCH v6 0/7] fs/dcache: Track & limit # of negative dentries
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Waiman Long <longman@redhat.com>, Michal Hocko <mhocko@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Larry Woodman <lwoodman@redhat.com>,
        "Wangkai (Kevin C)" <wangkai86@huawei.com>
Date:   Thu, 12 Jul 2018 10:21:20 -0700
In-Reply-To: <20180712164932.GA3475@bombadil.infradead.org>
References: <62275711-e01d-7dbe-06f1-bf094b618195@redhat.com>
         <20180710142740.GQ14284@dhcp22.suse.cz>
         <a2794bcc-9193-cbca-3a54-47420a2ab52c@redhat.com>
         <20180711102139.GG20050@dhcp22.suse.cz>
         <9f24c043-1fca-ee86-d609-873a7a8f7a64@redhat.com>
         <1531330947.3260.13.camel@HansenPartnership.com>
         <18c5cbfe-403b-bb2b-1d11-19d324ec6234@redhat.com>
         <1531336913.3260.18.camel@HansenPartnership.com>
         <4d49a270-23c9-529f-f544-65508b6b53cc@redhat.com>
         <1531411494.18255.6.camel@HansenPartnership.com>
         <20180712164932.GA3475@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-12 at 09:49 -0700, Matthew Wilcox wrote:
> On Thu, Jul 12, 2018 at 09:04:54AM -0700, James Bottomley wrote:
[...]
> > The question I'm trying to get an answer to is why does the dentry
> > cache need special limits when the mm handling of the page cache
> > (and other mm caches) just works?
> 
> I don't know that it does work.  Or that it works well.

I'm not claiming the general heuristics are perfect (in fact I know we
still have a lot of problems with dirty reclaim and writeback).  I am
willing to bet that any discussion of the heuristics will get a lot of
opposition if we try to introduce per-object limits for every object.

Our clean cache heuristics are simple: clean caches are easy to reclaim
and are thus treated like free memory (there's little cost to filling
them or reclaiming them again).  There is speculation that this
equivalence is problematic because the shrinkers reclaim objects but mm
is looking to reclaim pages and thus you can end up with a few objects
pinning many pages even if the shrinker freed a lot of them.

However, we haven't even reached that level yet ... I'm still
struggling to establish that we have a problem with the behaviour of
the dentry cache under current mm heuristics.  

James

