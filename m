Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFD8ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 02:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E6D20874
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 02:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="V7Wb+hRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E6D20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeIXIZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 04:25:50 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:41543 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeIXIZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 04:25:50 -0400
Received: by mail-lf1-f43.google.com with SMTP id l26-v6so15311413lfc.8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 19:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DcGRGJ9NwQK3sueXhQJvkqJ+L4hKV0ez70Jn5RmNtVo=;
        b=V7Wb+hRI2AsJQYaxouuKRFhz3yJIOCiJcERCzpKbu8BjqXwACSSCyu0Cg6DSMUBQV4
         Wuo/+VczuV4p9UCqTXdASReiyHU4HSYW0jCMCFCTLX4UABQdk5L640wjB5USV4PNmvuJ
         aO2Ff4j1smgTpgsiD1JCUcLtwOwPZLcGUtkJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DcGRGJ9NwQK3sueXhQJvkqJ+L4hKV0ez70Jn5RmNtVo=;
        b=WMLKwp4j6Bkm4uMw/jVTovV2//v83a/lSBJD7fdEdo8OwiKdxn0oQp8PJN3z4L4UGz
         yHNLNFwOT33dN7X8EQeUI0x9weCoqNlrjfGYCDuCj8zd8N/pItW6778oVrTZXZA1GnX8
         NMPTLe+SuTJCdLne7Ev5JEYVgAy8kbdeX0E4FR+5Tc0PykICskmm2OVDhE14CNbG1iu7
         Cc5eVYvRW6LzbBFgGpwid38hLk/wLsSbyVDaQD0Xg52KW/B0YJ8Ox/fHYHIIiP37j6Sc
         qIvDZGPZndzRYuxyd5KKX0qu1aDc5RahC+9AVWowALwlkbkHlMTGVPtNIIS26nOdTgml
         KSFg==
X-Gm-Message-State: APzg51Bg+jEzIR/69OhZh7UahNsoZ3T2YqJnaHQuDn9uhIfz3r1nWMS7
        bVF7r5VAZQrzkmRv8hyP2i4afU2nromEUR/zLYlQYg==
X-Google-Smtp-Source: ANB0VdY9dIHml0OGehngPFiVqPDUNEYczYeww+lXLsHH5eU/Y6f098mDcipzRmp6WSpfKE4QOjuUMgqZy3EhkOJqpjY=
X-Received: by 2002:a19:e495:: with SMTP id x21-v6mr4598721lfi.29.1537755956700;
 Sun, 23 Sep 2018 19:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXW_YQd8s9GP-TACJCbT67ZCy5guTJMW+Jue3VsEX1777UhBQ@mail.gmail.com>
 <20180923235413.GA4222@linux.ibm.com>
In-Reply-To: <20180923235413.GA4222@linux.ibm.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 23 Sep 2018 22:25:44 -0400
Message-ID: <CAEXW_YRTeJHYtoxiTbX+cq3FCRTpigvzRpvApFtUL8HBEozpXA@mail.gmail.com>
Subject: Re: Question about ->head field of rcu_segcblist
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2018 at 7:54 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
>
> On Sun, Sep 23, 2018 at 07:30:30PM -0400, Joel Fernandes wrote:
> > Hi Paul,
> >
> > I was parsing the Data-Structures document and had a question about
> > the following "Important note" text.
> >
> > Could it be clarified in the below text better why "remaining
> > callbacks are placed back on the RCU_DONE_TAIL segment", is a reason
> > for not depending on ->head for determining if no callbacks are
> > associated with the rcu_segcblist? If callbacks are added back to the
> > DONE_TAIL segment, then I would think rcu_head should be != NULL.
> > Infact the "rsclp->head = *rsclp->tails[RCU_DONE_TAIL];" in
> > rcu_segcblist_extract_done_cbs should set the ->head to  NULL if I
> > understand correctly.
>
> The rcu_segcblist_extract_done_cbs() function will set rsclp->head
> to NULL only if there were no non-done callbacks on the rsclp list.
> Otherwise, if there are non-done callbacks, then rsclp->head will
> be set to the first non-done callback.
>
> Either way, the problem is that the done callbacks can be removed
> and re-added, but the count is not adjusted until the re-add.  So
> you have to look at the count to see if there are callbacks.
>
> Testing rsclp->head fails because it can be temporarily NULL, even
> though there are callbacks hanging off of a pointer in rcu_do_batch()'s
> stack frame.
>
> Or am I misunderstanding your question?

Thanks yes that clears it up, I see what you mean that that ->head
field is temporarily volatile and really the ->len tells the real
story :-)

- Joel
