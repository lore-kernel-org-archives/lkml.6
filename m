Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964945AbeE2Ptc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:49:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38081 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964830AbeE2Pt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:49:29 -0400
X-Google-Smtp-Source: ADUXVKIKC3k6hacyat4woKg0HWZQsdqqxwhXRA2JFKUiC/fSXC9hNNRnyJlu3O3TaKfzhuzElgI/nA==
Date: Tue, 29 May 2018 09:49:22 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Hans Westgaard Ry <hans.westgaard.ry@oracle.com>
Cc: Doug Ledford <dledford@redhat.com>,
        Hakon Bugge <haakon.bugge@oracle.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Daniel Jurgens <danielj@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/mad: Use ID allocator routines to allocate agent
 number
Message-ID: <20180529154922.GA18457@ziepe.ca>
References: <20180529073808.27735-1-hans.westgaard.ry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529073808.27735-1-hans.westgaard.ry@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 09:38:08AM +0200, Hans Westgaard Ry wrote:
> The agent TID is a 64 bit value split in two dwords.  The least
> significant dword is the TID running counter. The most significant
> dword is the agent number. In the CX-3 shared port model, the mlx4
> driver uses the most significant byte of the agent number to store the
> slave number, making agent numbers greater and equal to 2^24 (3 bytes)
> unusable.

There is no reason for this to be an ida, just do something like

 mad_agent_priv->agent.hi_tid = atomic_inc_return(&ib_mad_client_id) & mad_agent_priv->ib_dev->tid_mask;

And have the driver set tid_mask to 3 bytes of 0xFF

And no sysctl.

Jason
