Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753973AbeD3Rtj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 13:49:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:53668 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752255AbeD3Rti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 13:49:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,346,1520924400";
   d="scan'208";a="37319176"
From: "Weiny, Ira" <ira.weiny@intel.com>
To: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        jackm <jackm@dev.mellanox.co.il>
CC: =?utf-8?B?SMOla29uIEJ1Z2dl?= <haakon.bugge@oracle.com>,
        "Hiatt, Don" <don.hiatt@intel.com>,
        Dasaratharaman Chandramouli
        <dasaratharaman.chandramouli@intel.com>,
        "Hefty, Sean" <sean.hefty@intel.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] IB/core: Make ib_mad_client_id atomic
Thread-Topic: [PATCH] IB/core: Make ib_mad_client_id atomic
Thread-Index: AQHT1yEVepSwssTlDUySP6Lhu4WvI6QJbUqAgADDR4CABKIRgIAAUs0AgAq1xwCAACd8gP//piHw
Date: Mon, 30 Apr 2018 17:49:34 +0000
Message-ID: <2807E5FD2F6FDA4886F6618EAC48510E67DF88D8@CRSMSX101.amr.corp.intel.com>
References: <20180418142450.15581-1-Haakon.Bugge@oracle.com>
         <1524196555.11756.30.camel@redhat.com> <20180420153451.GF30433@ziepe.ca>
         <50E3FE4A-2C6E-4493-92E1-383C349FAE3A@oracle.com>
         <20180423221618.0000795d@dev.mellanox.co.il>
         <20180430144930.GB26895@ziepe.ca> <1525108249.11756.93.camel@redhat.com>
In-Reply-To: <1525108249.11756.93.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiM2ZmODk4M2UtNWYxNy00NWYwLWI2MTAtMmZlZDRhZjg3ODkzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6IjVXNkhyWlZwRnY3TURjWGZjMXlKOWZGVHpNbjQ3U0pzbGN3SHg2K2NsQTA9In0=
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3UHnkJP030818

Looks fine to me.

> -----Original Message-----
> From: Doug Ledford [mailto:dledford@redhat.com]
> Sent: Monday, April 30, 2018 10:11 AM
> To: Jason Gunthorpe <jgg@ziepe.ca>; jackm <jackm@dev.mellanox.co.il>
> Cc: Håkon Bugge <haakon.bugge@oracle.com>; Hiatt, Don
> <don.hiatt@intel.com>; Dasaratharaman Chandramouli
> <dasaratharaman.chandramouli@intel.com>; Weiny, Ira <ira.weiny@intel.com>;
> Hefty, Sean <sean.hefty@intel.com>; OFED mailing list <linux-
> rdma@vger.kernel.org>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] IB/core: Make ib_mad_client_id atomic
> 
> On Mon, 2018-04-30 at 08:49 -0600, Jason Gunthorpe wrote:
> > On Mon, Apr 23, 2018 at 10:16:18PM +0300, jackm wrote:
> >
> > > > > TIDs need to be globally unique on the entire machine.
> > > Jason, that is not exactly correct.
> >
> > The expecation for /dev/umad users is that they all receive locally
> > unique TID prefixes. The kernel may be OK to keep things port-specific
> > but it is slightly breaking the API we are presenting to userspace to
> > allow them to alias..
> >
> > Jason
> 
> Would people be happier with this commit message then:
> 
> IB/core: Make ib_mad_client_id atomic
> 
> Currently, the kernel protects access to the agent ID allocator on a per port basis
> using a spinlock, so it is impossible for two apps/threads on the same port to get
> the same TID, but it is entirely possible for two threads on different ports to end
> up with the same TID.
> 
> As this can be confusing (regardless of it being legal according to the IB Spec 1.3,
> C13-18.1.1, in section 13.4.6.4 - TransactionID usage), and as the rdma-core user
> space API for /dev/umad devices implies unique TIDs even across ports, make
> the TID an atomic type so that no two allocations, regardless of port number, will
> be the same.
> 
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> Reviewed-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@oracle.com>
> Signed-off-by: Doug Ledford <dledford@redhat.com>
> 
> 
> --
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
