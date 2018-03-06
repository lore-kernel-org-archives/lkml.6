Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753928AbeCFOt2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:49:28 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37222 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753885AbeCFOtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:49:22 -0500
X-Google-Smtp-Source: AG47ELt9uOMM0VV4M0WAGqttH6sC8jLTd5Fge5CDEy7y2Oql+axmdlcpwJvhU8a+xFg6ZG/AehcK2AqDlgi67+4UCeU=
MIME-Version: 1.0
In-Reply-To: <20180306015553.10441-1-bpoirier@suse.com>
References: <20180306015553.10441-1-bpoirier@suse.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 6 Mar 2018 06:49:21 -0800
Message-ID: <CAKgT0UeuFy4CHZc0TinvFdMPPzBPY_T7bgNk29FiPAktgjm_=g@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "e1000e: Separate signaling for link
 check/link up"
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
> This reverts commit 19110cfbb34d4af0cdfe14cd243f3b09dc95b013.
> This reverts commit 4110e02eb45ea447ec6f5459c9934de0a273fb91.
> This reverts commit d3604515c9eda464a92e8e67aae82dfe07fe3c98.
>
> Commit 19110cfbb34d ("e1000e: Separate signaling for link check/link up")
> changed what happens to the link status when there is an error which
> happens after "get_link_status = false" in the copper check_for_link
> callbacks. Previously, such an error would be ignored and the link
> considered up. After that commit, any error implies that the link is down.
>
> Revert commit 19110cfbb34d ("e1000e: Separate signaling for link check/link
> up") and its followups. After reverting, the race condition described in
> the log of commit 19110cfbb34d is reintroduced. It may still be triggered
> by LSC events but this should keep the link down in case the link is
> electrically unstable, as discussed. The race may no longer be
> triggered by RXO events because commit 4aea7a5c5e94 ("e1000e: Avoid
> receiver overrun interrupt bursts") restored reading icr in the Other
> handler.
>
> Link: https://lkml.org/lkml/2018/3/1/789
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>

Personally I am not a fan of the !mac->autoneg causing us to return an
error, but that is how the code was before and the error return code
will be ignored anyway.

Thanks for doing all this.

Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>
