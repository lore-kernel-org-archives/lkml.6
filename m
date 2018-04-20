Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755839AbeDTPez (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 11:34:55 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37793 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755821AbeDTPex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 11:34:53 -0400
X-Google-Smtp-Source: AIpwx4+TLM7Bp4QK2z2UhAjmftJ0pZFHGvBm/mOrqtx5aOSG5oqUU83SRQdNUEJaPqwefpptf/btMg==
Date: Fri, 20 Apr 2018 09:34:51 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Doug Ledford <dledford@redhat.com>
Cc: =?utf-8?B?SMOla29u?= Bugge <Haakon.Bugge@oracle.com>,
        Don Hiatt <don.hiatt@intel.com>,
        Dasaratharaman Chandramouli
        <dasaratharaman.chandramouli@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Sean Hefty <sean.hefty@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/core: Make ib_mad_client_id atomic
Message-ID: <20180420153451.GF30433@ziepe.ca>
References: <20180418142450.15581-1-Haakon.Bugge@oracle.com>
 <1524196555.11756.30.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1524196555.11756.30.camel@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 11:55:55PM -0400, Doug Ledford wrote:
> On Wed, 2018-04-18 at 16:24 +0200, Håkon Bugge wrote:
> > Two kernel threads may get the same value for agent.hi_tid, if the
> > agents are registered for different ports. As of now, this works, as
> > the agent list is per port.
> > 
> > It is however confusing and not future robust. Hence, making it
> > atomic.
> > 
> 
> People sometimes underestimate the performance penalty of atomic ops. 
> Every atomic op is the equivalent of a spin_lock/spin_unlock pair.  This
> is why two atomics are worse than taking a spin_lock, doing what you
> have to do, and releasing the spin_lock.  Is this really what you want
> for a "confusing, let's make it robust" issue?

But it is on the ib_register_mad_agent() path which is not a
performance path..

This actually looks like a genuine bug, why is it described only as
'confusing'? ib_register_mad_agent is callable from userspace, so at
least two userspace agents can race and get the same TID's.

TIDs need to be globally unique on the entire machine.

Jason
