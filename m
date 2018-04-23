Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755365AbeDWOUZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:20:25 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:38270 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755184AbeDWOUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:20:23 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] IB/core: Make ib_mad_client_id atomic
From: =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20180420153451.GF30433@ziepe.ca>
Date: Mon, 23 Apr 2018 16:19:57 +0200
Cc: Doug Ledford <dledford@redhat.com>, Don Hiatt <don.hiatt@intel.com>,
        Dasaratharaman Chandramouli
        <dasaratharaman.chandramouli@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Sean Hefty <sean.hefty@intel.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org, jackm <jackm@dev.mellanox.co.il>
Message-Id: <50E3FE4A-2C6E-4493-92E1-383C349FAE3A@oracle.com>
References: <20180418142450.15581-1-Haakon.Bugge@oracle.com>
 <1524196555.11756.30.camel@redhat.com> <20180420153451.GF30433@ziepe.ca>
To: Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3445.6.18)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8871 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=507
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804230144
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3NEKWSr013102


+Jack

> On 20 Apr 2018, at 17:34, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> On Thu, Apr 19, 2018 at 11:55:55PM -0400, Doug Ledford wrote:
>> On Wed, 2018-04-18 at 16:24 +0200, Håkon Bugge wrote:
>>> Two kernel threads may get the same value for agent.hi_tid, if the
>>> agents are registered for different ports. As of now, this works, as
>>> the agent list is per port.
>>> 
>>> It is however confusing and not future robust. Hence, making it
>>> atomic.
>>> 
>> 
>> People sometimes underestimate the performance penalty of atomic ops. 
>> Every atomic op is the equivalent of a spin_lock/spin_unlock pair.

Well, may be this holds true if the mutex and the variable is located in the same cacheline.

>>  This
>> is why two atomics are worse than taking a spin_lock, doing what you
>> have to do, and releasing the spin_lock.  Is this really what you want
>> for a "confusing, let's make it robust" issue?
> 
> But it is on the ib_register_mad_agent() path which is not a
> performance path..
> 
> This actually looks like a genuine bug, why is it described only as
> 'confusing'? ib_register_mad_agent is callable from userspace, so at
> least two userspace agents can race and get the same TID’s.

My understanding is that every lookup is using the {port, TID} tuple. As such, it is not a bug, but, very confusing.

> TIDs need to be globally unique on the entire machine.

If you are correct Jason, let me reword the commit message.


Thxs, Håkon
