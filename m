Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeB1FTW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 00:19:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:59837 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751003AbeB1FTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 00:19:20 -0500
Date: Wed, 28 Feb 2018 14:19:12 +0900
From: Benjamin Poirier <bpoirier@suse.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] e1000e: Fix link check race condition.
Message-ID: <20180228051912.cueusc3wn44ksdc3@f1.synalogic.ca>
References: <CAKgT0UffXiggXxC5x1vrtbnKPHzcy8+VTRvBGBH-7tCYmUi6LQ@mail.gmail.com>
 <20180226023118.17439-1-bpoirier@suse.com>
 <CAKgT0Ueyz9LPz4UwYVpgZJ+nW2YV2A-mYqUQbBP2RaDfgH91rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Ueyz9LPz4UwYVpgZJ+nW2YV2A-mYqUQbBP2RaDfgH91rA@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/02/26 08:14, Alexander Duyck wrote:
[...]
> 
> >
> >         switch (hw->mac.type) {
> >         case e1000_pch2lan:
> >                 ret_val = e1000_k1_workaround_lv(hw);
> >                 if (ret_val)
> > -                       return ret_val;
> > +                       goto out;
> >                 /* fall-thru */
> >         case e1000_pchlan:
> >                 if (hw->phy.type == e1000_phy_82578) {
> >                         ret_val = e1000_link_stall_workaround_hv(hw);
> >                         if (ret_val)
> > -                               return ret_val;
> > +                               goto out;
> >                 }
> >
> >                 /* Workaround for PCHx parts in half-duplex:
> > @@ -1595,7 +1596,7 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
> >         if (hw->phy.type > e1000_phy_82579) {
> >                 ret_val = e1000_set_eee_pchlan(hw);
> >                 if (ret_val)
> > -                       return ret_val;
> > +                       goto out;
> >         }
> >
> >         /* If we are forcing speed/duplex, then we simply return since
> > @@ -1618,10 +1619,14 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
> >         ret_val = e1000e_config_fc_after_link_up(hw);
> >         if (ret_val) {
> >                 e_dbg("Error configuring flow control\n");
> > -               return ret_val;
> > +               goto out;
> >         }
> 
> Technically these changes would be a change in behavior. For these we
> may just want to leave them as-is since I am not certain they would
> have any actual impact on the link state other than delaying the
> link-up. For example do we really care if we fail to negotiate flow
> control? We may not so we might report link up and just a debug
> message indicating we didn't negotiate that part of the link.

You're right and actually that raises yet another problem with commit
19110cfbb34d ("e1000e: Separate signaling for link check/link up").

Previously these errors which come after the "get_link_status = false"
would be ignored and the link considered up. After that commit, any
error implies that the link is down:

-			link_active = !hw->mac.get_link_status;
+			link_active = ret_val > 0;

I'll send a patch to fix that problem first and then get back to this
race.
