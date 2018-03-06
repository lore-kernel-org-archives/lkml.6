Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932624AbeCFOye (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:54:34 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:46446 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbeCFOyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:54:32 -0500
X-Google-Smtp-Source: AG47ELuUwwWwLGaLTGnzrj+wt4k3IqhPs+4rpIFsRna3KEVHc4Cvp6/4p8XCUB9/IsB+7YGud5OMFtY9QWM/7h/AqwA=
MIME-Version: 1.0
In-Reply-To: <20180306015553.10441-2-bpoirier@suse.com>
References: <20180306015553.10441-1-bpoirier@suse.com> <20180306015553.10441-2-bpoirier@suse.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 6 Mar 2018 06:53:59 -0800
Message-ID: <CAKgT0UfVVA43gbEQSyJ3XithVun6UST+_-b-=tQiCugU=PPzfg@mail.gmail.com>
Subject: Re: [PATCH 2/2] e1000e: Fix link check race condition
To: Benjamin Poirier <bpoirier@suse.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 5, 2018 at 5:55 PM, Benjamin Poirier <bpoirier@suse.com> wrote:
> Alex reported the following race condition:
>
> /* link goes up... interrupt... schedule watchdog */
> \ e1000_watchdog_task
>         \ e1000e_has_link
>                 \ hw->mac.ops.check_for_link() === e1000e_check_for_copper_link
>                         \ e1000e_phy_has_link_generic(..., &link)
>                                 link = true
>
>                                          /* link goes down... interrupt */
>                                          \ e1000_msix_other
>                                                  hw->mac.get_link_status = true
>
>                         /* link is up */
>                         mac->get_link_status = false
>
>                 link_active = true
>                 /* link_active is true, wrongly, and stays so because
>                  * get_link_status is false */
>
> Avoid this problem by making sure that we don't set get_link_status = false
> after having checked the link.
>
> It seems this problem has been present since the introduction of e1000e.
>
> Link: https://lkml.org/lkml/2018/1/29/338
> Reported-by: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>

Looks good. Thanks.

Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>
