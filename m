Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC8AC46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4ED821C67
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mindspring.com header.i=@mindspring.com header.b="OQMp/8q0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4ED821C67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mindspring.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeHIE6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 00:58:18 -0400
Received: from elasmtp-galgo.atl.sa.earthlink.net ([209.86.89.61]:59448 "EHLO
        elasmtp-galgo.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725852AbeHIE6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 00:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
        s=dk12062016; t=1533782149; bh=lX3kU6reiEYmcDSzlU/MnOU+BeAXSrWuHBGI
        M+P9Dvk=; h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:
         Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
         X-Mailer:Content-Language:Thread-Index:X-ELNK-Trace:
         X-Originating-IP; b=OQMp/8q09z+Ke+tatS3UumehUzowhoEZkFxvPP/T5iR4K3
        GPI2LC0bjB3Ml/+A4hIROefN5XyMOpWOLq6EG6+fzOCCDgtgSiHn7ji8cb3Hi0V7nKi
        KExNHZOW8z0Y7h7siWXqeiqOU34h4UbETypXUswPzDOBvEih2vYeMjhOTp6nWHc1H19
        7zD0/1DByUprXg+U2ClmzPEsDuKUwlkoGgHJNSyR3UiNQFrHm2EE54o0J1H4P2ZqW7b
        yh4KwXCcm9CtK9Atp0xA3taMYm8ohZM2r5HOggw4AmvCqSEFC0LgH5hBm/xny6Hj4iR
        fg8M9hZwtwliz+zOsv8SFUXkUeDQ==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=mindspring.com;
  b=EYJtjs433sVE5yezZoIa5k/hZc+C62dlKcq7MFrgL28cYGBnFlVx9eqxJI2FrEmYV+G6CZrMosrRujaS4dSSE+nP6BqfO3MuEoLnjzHo+WklJxmt17Fpl53GqRgn0U63dXp6Q/+VJfWlm0qoi8G+yhc20JduKgwtDJUXQnvi2MmmjotfWnMKHfAaWNQ15EqQJoBtVReAhD3PdLDiMjENY4La8p52V5/0FRsQiSJrOepFIWp+syvLq1d8uo/9s1HQ/YyPBmaEWlt1VisWxecoxLe0ACMqiWbT0ROfoyKMX66bfnL0YcqxhsqFotsZfZibU/Hxv1dyQ8vA4gAox9FaMg==;
  h=Received:From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:Content-Language:Thread-Index:X-ELNK-Trace:X-Originating-IP;
Received: from [76.105.143.216] (helo=FRANKSTHINKPAD)
        by elasmtp-galgo.atl.sa.earthlink.net with esmtpa (Exim 4)
        (envelope-from <ffilzlnx@mindspring.com>)
        id 1fnVng-0000fx-TM; Wed, 08 Aug 2018 17:15:25 -0400
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     "'J. Bruce Fields'" <bfields@fieldses.org>,
        "'NeilBrown'" <neilb@suse.com>
Cc:     "'Jeff Layton'" <jlayton@kernel.org>,
        "'Alexander Viro'" <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Martin Wilck'" <mwilck@suse.de>
References: <153369219467.12605.13472423449508444601.stgit@noble> <20180808195445.GD23873@fieldses.org> <20180808200912.GE23873@fieldses.org>
In-Reply-To: <20180808200912.GE23873@fieldses.org>
Subject: RE: [PATCH 0/4] locks: avoid thundering-herd wake-ups
Date:   Wed, 8 Aug 2018 14:15:24 -0700
Message-ID: <01b001d42f5c$ed082e20$c7188a60$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQGA9keEcMCkmDAsuHSuCoEfEmhAOAG1/rx6AXpKEjmlQ0n5QA==
X-ELNK-Trace: 136157f01908a8929c7f779228e2f6aeda0071232e20db4d71ea602dab1a2e163e1494380c7f8fd4350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 76.105.143.216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Aug 08, 2018 at 03:54:45PM -0400, J. Bruce Fields wrote:
> > On Wed, Aug 08, 2018 at 11:51:07AM +1000, NeilBrown wrote:
> > > If you have a many-core machine, and have many threads all wanting
> > > to briefly lock a give file (udev is known to do this), you can get
> > > quite poor performance.
> > >
> > > When one thread releases a lock, it wakes up all other threads that
> > > are waiting (classic thundering-herd) - one will get the lock and
> > > the others go to sleep.
> > > When you have few cores, this is not very noticeable: by the time
> > > the 4th or 5th thread gets enough CPU time to try to claim the lock,
> > > the earlier threads have claimed it, done what was needed, and
released.
> > > With 50+ cores, the contention can easily be measured.
> > >
> > > This patchset creates a tree of pending lock request in which
> > > siblings don't conflict and each lock request does conflict with its
parent.
> > > When a lock is released, only requests which don't conflict with
> > > each other a woken.
> >
> > Are you sure you aren't depending on the (incorrect) assumption that
> > "X blocks Y" is a transitive relation?
> >
> > OK I should be able to answer that question myself, my patience for
> > code-reading is at a real low this afternoon....
> 
> In other words, is there the possibility of a tree of, say, exclusive
locks with
> (offset, length) like:
> 
> 	(0, 2) waiting on (1, 2) waiting on (2, 2) waiting on (0, 4)
> 
> and when waking (0, 4) you could wake up (2, 2) but not (0, 2), leaving a
process
> waiting without there being an actual conflict.

That implies that the order the locks were received in was:

(0,4)
(2,2)
(1,2)
(0,2)

But couldn't (0,2) have been made only dependent on (0,4)? Of course then
(1,2) is dependent on BOTH (2,2) and (0,2). Does this tree logic handle that
case?

On the other hand, there might be a fairness reason to make (0,2) wait for
(1,2) even though it could have been granted concurrently with (2,2) since
this dependency tree also preserves some of the order of lock requests.

Frank

