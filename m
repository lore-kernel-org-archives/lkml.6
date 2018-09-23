Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386DFECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 23:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D4E206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 23:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Nfo8qejq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D4E206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeIXFaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 01:30:06 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:40682 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbeIXFaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 01:30:06 -0400
Received: by mail-lf1-f41.google.com with SMTP id t22-v6so5383161lfb.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 16:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=5/0S7ZZuNL7DoRdL2DClTWnhoqsIKGVG4whpC4upEHA=;
        b=Nfo8qejqm+wT9diZh4z2RLa0Ign6qZV5D0tsU/rQ+K314+9hK2HI6BkzogEaSn1bKk
         KrUpa9RTYEfLC8SRcJZt5U9PM+q0FXLDFUrwiIq1S9GNuY7V+jGFHPsEXC7szU8gEuKa
         GbT8SVGcSWmUhTTIOLqtv5HQH0vdmkBUJNdVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=5/0S7ZZuNL7DoRdL2DClTWnhoqsIKGVG4whpC4upEHA=;
        b=jrDnT9ab1jJQC3PrRcwoQXeiA+37sSR9aq/iIJD5ZtAZdBYMg9tvE67Yoxnz24mlcL
         lLZTmy+4QFGJDQGFDKKAZ6a52SdB4ftHXcDMDpyh2DFYW/gZZ89qBj5n3KUsGzYzfPev
         yOBThF7h5cUW6jLBZvOpnRl66dFT7+eFV6sVflzqyyAW5ebzx+CI+YFm9JFw+N0iVueS
         aD/fIEciEYwxfX4cm4sFgOG2nViYks/1GjbZy5/Sy5qtg/BWAqGGerKIF++YxGhUVwXp
         mhWv3qTmMfLo+DCd3fZydOw7UvhmKcVAmkL9fXgbbNF8n7AymP45dS+rldhbeKVAhkQ8
         fXrQ==
X-Gm-Message-State: APzg51Cms6a9f0/sAqV+rHK+HqTlod0QqbEDJtRQEX3jRhaKc+zeGeL8
        aZEqrRsOoCrWGmGrmTThdPe0Epnjho0bVmjiTcVzFWH9GVs=
X-Google-Smtp-Source: ANB0Vda+45EaG1xXVgOPOpL4JteUy1t7dlgVjeLOIXIc62ewk2DtGn8gtFQG2K7zrRazZkrQIGwMFVafSqRBlFTLtho=
X-Received: by 2002:a19:e495:: with SMTP id x21-v6mr4386876lfi.29.1537745441713;
 Sun, 23 Sep 2018 16:30:41 -0700 (PDT)
MIME-Version: 1.0
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 23 Sep 2018 19:30:30 -0400
Message-ID: <CAEXW_YQd8s9GP-TACJCbT67ZCy5guTJMW+Jue3VsEX1777UhBQ@mail.gmail.com>
Subject: Question about ->head field of rcu_segcblist
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

I was parsing the Data-Structures document and had a question about
the following "Important note" text.

Could it be clarified in the below text better why "remaining
callbacks are placed back on the RCU_DONE_TAIL segment", is a reason
for not depending on ->head for determining if no callbacks are
associated with the rcu_segcblist? If callbacks are added back to the
DONE_TAIL segment, then I would think rcu_head should be != NULL.
Infact the "rsclp->head = *rsclp->tails[RCU_DONE_TAIL];" in
rcu_segcblist_extract_done_cbs should set the ->head to  NULL if I
understand correctly.

Important note: It is the ->len field that determines whether or not
there are callbacks associated with this rcu_segcblist structure, not
the ->head pointer. The reason for this is that all the
ready-to-invoke callbacks (that is, those in the RCU_DONE_TAIL
segment) are extracted all at once at callback-invocation time. If
callback invocation must be postponed, for example, because a
high-priority process just woke up on this CPU, then the remaining
callbacks are placed back on the RCU_DONE_TAIL segment. Either way,
the ->len and ->len_lazy counts are adjusted after the corresponding
callbacks have been invoked, and so again it is the ->lencount that
accurately reflects whether or not there are callbacks associated with
this rcu_segcblist structure. Of course, off-CPU sampling of the ->len
count requires the use of appropriate synchronization, for example,
memory barriers. This synchronization can be a bit subtle,
particularly in the case of rcu_barrier().

Thanks!

 - Joel
