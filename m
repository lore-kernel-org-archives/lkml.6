Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeC1BeE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 21:34:04 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:49270 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752008AbeC1BeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 21:34:03 -0400
Date: Wed, 28 Mar 2018 01:26:37 +0000
From: Eric Wong <e@80x24.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] send-email: supply a --send-delay=1 by default
Message-ID: <20180328012637.GA12551@whir>
References: <20180325182803.30036-1-avarab@gmail.com>
 <20180325182803.30036-3-avarab@gmail.com>
 <20180325210132.GE74743@genre.crustytoothpaste.net>
 <87605jyfvi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87605jyfvi.fsf@evledraar.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Good point. I also see that (via git log --author=Ævar --grep='^\[PATCH
> ') that this series itself arrived out of order (0 -> 2 -> 1), but I
> don't know to what extent public-inbox itself might be batching things.

public-inbox doesn't batch, aside from when the
public-inbox-watch process gets restarted and needs to catch up
using readdir.  Once it's done catching up with readdir, it
gets into an inotify loop which injects messages in the order
the MTA (or offlineimap) puts them in a Maildir.

Right now, public-inbox only sorts by Date: header in the mail.

The next Xapian schema revision of public-inbox will use
internally sorts search results(*) by the date in the newest
Received: header.  That is analogous to git committer date.  The
displayed message date will still be sorted by the Date: header
(analogous to git author date); since git-send-email already
alters the Date: in a series for sorting.

This allow messages/threads which are actually new get bumped to
the top of the homepage; regardless of how wrong the original
sender's clock was.

It should help prevent kernel developers from crafting message
dates with optimization for classic^Wextra reviews in mind :)


(*) all the look-at-a-bunch-of-messages operations, including
    the landing page (e.g. https://public-inbox.org/git/)
    is a Xapian search query, nowadays; but "git log"
