Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2588CC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C828C2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C828C2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbeKBXlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 19:41:39 -0400
Received: from mail.hallyn.com ([178.63.66.53]:55046 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727668AbeKBXlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 19:41:39 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id D291B5D3; Fri,  2 Nov 2018 14:34:17 +0000 (UTC)
Date:   Fri, 2 Nov 2018 14:34:17 +0000
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Christian Brauner <christian.brauner@canonical.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Daniel Colascione <dancol@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>, ebiederm@xmission.com,
        luto@amacapital.net, serge@hallyn.com
Subject: Re: [RFC PATCH] Implement /proc/pid/kill
Message-ID: <20181102143417.GA19304@mail.hallyn.com>
References: <20181030204501.jnbe7dyqui47hd2x@yavin>
 <20181030214243.GB32621@google.com>
 <20181030222339.ud4wfp75tidowuo4@yavin>
 <20181030223343.GB105735@joelaf.mtv.corp.google.com>
 <CAKOZueuBdY_b=CVk29pzn0NAt9sJtzr6yqx9Y00WCppCm1JFWQ@mail.gmail.com>
 <CAPP7u0VQqDvFr=-52+Tmv_K=vT730wG7w9VQqJggsXTPFvaUBQ@mail.gmail.com>
 <20181031025655.yz7lfhswk7igb3ty@yavin>
 <CAEXW_YQxWcQGZHrwhwsyu7GCk+WSap=tb0-asTsG8sTFmjE--g@mail.gmail.com>
 <20181101204059.GA102756@google.com>
 <20181102094602.z5otkwrqtchpuhfm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102094602.z5otkwrqtchpuhfm@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christian Brauner (christian.brauner@canonical.com):
> On Thu, Nov 01, 2018 at 01:40:59PM -0700, Joel Fernandes wrote:
> > On Tue, Oct 30, 2018 at 09:24:00PM -0700, Joel Fernandes wrote:
> > > On Tue, Oct 30, 2018 at 7:56 PM, Aleksa Sarai <cyphar@cyphar.com> wrote:
> > > > On 2018-10-31, Christian Brauner <christian.brauner@canonical.com> wrote:
> > > >> > I think Aleksa's larger point is that it's useful to treat processes
> > > >> > as other file-descriptor-named, poll-able, wait-able resources.
> > > >> > Consistency is important. A process is just another system resource,
> > > >> > and like any other system resource, you should be open to hold a file
> > > >> > descriptor to it and do things to that process via that file
> > > >> > descriptor. The precise form of this process-handle FD is up for
> > > >> > debate. The existing /proc/$PID directory FD is a good candidate for a
> > > >> > process handle FD, since it does almost all of what's needed. But
> > > >> > regardless of what form a process handle FD takes, we need it. I don't
> > > >> > see a case for continuing to treat processes in a non-unixy,
> > > >> > non-file-descriptor-based manner.
> > > >>
> > > >> That's what I'm proposing in the API for which I'm gathering feedback.
> > > >> I have presented parts of this in various discussions at LSS Europe last week
> > > >> and will be at LPC.
> > > >> We don't want to rush an API like this though. It was tried before in
> > > >> other forms
> > > >> and these proposals didn't make it.
> > > >
> > > > :+1: on a well thought-out and generic proposal. As we've discussed
> > > > elsewhere, this is an issue that really would be great to (finally)
> > > > solve.
> > > 
> > > Excited to see this and please count me in for discussions around this. thanks.
> > > 
> > 
> > Just a quick question, is there a track planned at LPC for discussing this
> > new proposal or topics around/related to the proposal?
> > 
> > If not, should that be planned?
> 
> There isn't currently one planned but I'm happy to have a hallway track
> session around this.
> 
> But note, I think not all relevant people are going to be there (e.g.
> Andy). File descriptors for processes seems interesting to a lot of
> people so I'm going to send out a pitch of the idea I have and see how
> much I'm going to get yelled at latest on Tuesday. Even if it just
> triggers a design discussion.
> I have been urged by people I pitched this to to send it to lkml
> already. Sorry for the delay and the initial non-transparency. The only
> reason I didn't do it right away was to ensure that this idea is not
> completely crazy. :) (Eric probably still thinks I am though. :))
> It's just that I'm at a conference and I want to have a nicer writeup of
> this. Given the speed with which this is all coming I have given up on
> preparing a first set of patches. :)
> 
> Christian

Sounds good, thanks, looking forward to it.
