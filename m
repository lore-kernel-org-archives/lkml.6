Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756811AbeDZSdO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 14:33:14 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46551 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753830AbeDZScz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 14:32:55 -0400
X-Google-Smtp-Source: AIpwx4+2To0o6xk3Dh9WBvoQ21fvT+r2o6OZ+lDuH7GKPV0CHGsPuHwi+LUX/Pi03jLZSdaA0v3HXg==
Date: Thu, 26 Apr 2018 21:32:50 +0300
From: jackm <jackm@dev.mellanox.co.il>
To: =?ISO-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Don Hiatt <don.hiatt@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        Sean Hefty <sean.hefty@intel.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/core: Make ib_mad_client_id atomic
Message-ID: <20180426213250.0000515d@dev.mellanox.co.il>
In-Reply-To: <C546E163-297B-438E-AF76-CC04247ABFBA@oracle.com>
References: <20180418142450.15581-1-Haakon.Bugge@oracle.com>
        <1524196555.11756.30.camel@redhat.com>
        <20180420153451.GF30433@ziepe.ca>
        <50E3FE4A-2C6E-4493-92E1-383C349FAE3A@oracle.com>
        <20180423221618.0000795d@dev.mellanox.co.il>
        <C546E163-297B-438E-AF76-CC04247ABFBA@oracle.com>
Organization: Mellanox
X-Mailer: Claws Mail 3.15.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3QIXLpb023278

On Thu, 26 Apr 2018 18:06:10 +0200
Håkon Bugge <haakon.bugge@oracle.com> wrote:

> > On 23 Apr 2018, at 21:16, jackm <jackm@dev.mellanox.co.il> wrote:
> > 
> > On Mon, 23 Apr 2018 16:19:57 +0200
> > Håkon Bugge <haakon.bugge@oracle.com> wrote:
> > 
> >   
> >>> 
> >>> This actually looks like a genuine bug, why is it described only
> >>> as 'confusing'? ib_register_mad_agent is callable from userspace,
> >>> so at least two userspace agents can race and get the same
> >>> TID’s.    
> >> 
> >> My understanding is that every lookup is using the {port, TID}
> >> tuple. As such, it is not a bug, but, very confusing.  
> > Haakon, you are correct (see snippet from the IB spec, below).
> > 
> > We will NOT have a situation where there are 2 threads/apps
> > with the same agent ID on the *same port* (accessing the agent ID
> > allocator is protected by a per-port spinlock). Having the same
> > agent ID on DIFFERENT ports is OK.
> > Thus, there is NO bug here. (But as Haakon says, IMHO it is more
> > robust to avoid having the same agent ID for 2 agents even if those
> > agents are on different ports).
> >   
> >>   
> >>> TIDs need to be globally unique on the entire machine.    
> >>   
> > Jason, that is not exactly correct.
> > 
> > From the IB Spec 1.3, C13-18.1.1 (in section 13.4.6.4 -
> > TransactionID usage):
> > "When initiating a new operation, MADHeader:TransactionID
> > shall be set to such a value that within that MAD the combination of
> > TID, SGID, and MgmtClass is different from that of any other
> > currently executing operation. If the MAD does not have a GRH, its
> > SLID is used in the combination in place of an SGID."
> > 
> > Since the SGID/SLID is different for each port, the per-port
> > guarantee of no 2 agents receiving the same agent-ID value is
> > sufficient.
> > 
> > -Jack  
> 
> Shall I interpret this silence as my commit is good to go or that I
> should add Jack’s tangible information to the commit message?
> 
> 
Haakon, I think Jason is on vacation this week. Best to wait for his
response.

-Jack

> Thxs, Håkon
> 
