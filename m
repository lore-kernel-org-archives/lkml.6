Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966366AbeCAGk3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 01:40:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:46767 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966279AbeCAGk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 01:40:27 -0500
Date: Thu, 1 Mar 2018 15:40:18 +0900
From: Benjamin Poirier <bpoirier@suse.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] e1000e: Fix link status in case of error.
Message-ID: <20180301064018.kdy34jixrsmwossf@f1.synalogic.ca>
References: <20180228052006.12074-1-bpoirier@suse.com>
 <CAKgT0Uc_Dur56FxJfqoh90E=pUYtiKJr20f3fado-GdL8yUi5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Uc_Dur56FxJfqoh90E=pUYtiKJr20f3fado-GdL8yUi5w@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/02/28 08:48, Alexander Duyck wrote:
> On Tue, Feb 27, 2018 at 9:20 PM, Benjamin Poirier <bpoirier@suse.com> wrote:
> > Before commit 19110cfbb34d ("e1000e: Separate signaling for link check/link
> > up"), errors which happen after "get_link_status = false" in the copper
> > check_for_link callbacks would be ignored and the link considered up. After
> > that commit, any error implies that the link is down. Since all
> > combinations of link up/down and error/no error are possible, do the same
> > thing as e1000e_phy_has_link_generic() and return the link status in a
> > separate variable.
> >
> > Fixes: 19110cfbb34d ("e1000e: Separate signaling for link check/link up")
> > Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> 
> This seems more like a refactor than a fix. There are valid cases
> where errors can be ignored after we set the link to up. For example
> if we cannot negotiate flow control we may not care as long as the
> link is established. In such a case we may see errors establishing
> flow control and they should be ignored.

Indeed, before commit 19110cfbb34d ("e1000e: Separate signaling for link
check/link up") a failure of e1000e_config_fc_after_link_up() in
e1000e_check_for_copper_link() would be ignored. After that commit,
there is an extra 2s delay before link up, like what was just fixed for
autoneg in commit d8ca384786c2 ("e1000e: Fix check_for_link return value
with autoneg off"). That was an unintended change in behavior. This is
what this patch purports to fix. The same is true for other failure
paths in e1000_check_for_copper_link_ich8lan() that happen after
get_link_status = false.

> 
> If there are cases where we are setting the link as up to early we
> should address that instead of changing all the functions to make them
> look like other ones.
> 
> > ---
[...]
