Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbeENVCM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:02:12 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:40155 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752101AbeENVCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:02:07 -0400
X-Google-Smtp-Source: AB8JxZqbp7Au4Iq9GhtiMt5cLIIQGCJlCEJY4aR2pYmaY3zoCNSYCbcNhjAWPd+a3e3ZIc7E46fGgw==
Date: Mon, 14 May 2018 15:02:00 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc: Hal Rosenstock <hal@dev.mellanox.co.il>,
        Doug Ledford <dledford@redhat.com>, Don Hiatt <don.hiatt@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Sean Hefty <sean.hefty@intel.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH IB/core 2/2] IB/cm: Send authentic pkey in REQ msg and
 check eligibility of the pkeys
Message-ID: <20180514210200.GN21531@ziepe.ca>
References: <20180509093020.24503-1-Haakon.Bugge@oracle.com>
 <20180509093020.24503-3-Haakon.Bugge@oracle.com>
 <ab1f16cd-aa60-0c43-841c-aed301fd2a7e@dev.mellanox.co.il>
 <F9802EE9-4420-44EE-93DC-27CC799B427E@oracle.com>
 <3bee76df-49a6-cf3c-6df4-749a6309358e@dev.mellanox.co.il>
 <B3360947-5905-47BD-ABC4-6C4BB32F5DA6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B3360947-5905-47BD-ABC4-6C4BB32F5DA6@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 05:16:28PM +0200, Håkon Bugge wrote:

> We are talking about two things here. The PKey in the BTH and the
> PKey in the CM REQ payload. They differ.
> 
> I am out of office, but if my memory serves me correct, the PKey in
> the BTH in the MAD packet will be the default PKey. Further, we have
> per IBTA:

This sounds like a Linux bug.

Linux does not do a PR to get a reversible path dedicated to the GMP,
so it always uses the data flow path, thus the GMP path paramenters
and those in the REQ should always exactly match.

Where is Linux setting the BTH.PKey and how did it choose to use the
default pkey? Lets fix that at least for sure.

Once that is fixed the rest of the series makes no sense since a REQ
with invalid PKey will never arrive.

However...

This series seems inconsistent with the spec.

IIRC the spec doesn't say if a full or limited pkey should be placed
in the REQ (Hal?). It is designed so that the requestor can get a
single reversible path and put that results into the REQ without
additional processing, however the PR returns only one PKey and again,
itis not really specified if it should be the full or limited pkey
(Hal?).

Basically this means that any pkey in the REQ could randomly be the
full or limited value, and that in-of-itself has not bearing on the
connection.

So it is quite wrong to insist that the pkey be limited or full when
processing the REQ. The end port is expected to match against the
local table.

The real answer to your trap problem is to fix the SM to not create
paths that are non-functional, that is just flat out broken SM
behavior.

Jason
