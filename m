Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756825AbeDZQFq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:05:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41884 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756519AbeDZQFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:05:44 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] IB/core: Make ib_mad_client_id atomic
From: =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20180423221618.0000795d@dev.mellanox.co.il>
Date: Thu, 26 Apr 2018 18:06:10 +0200
Cc: Don Hiatt <don.hiatt@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        Sean Hefty <sean.hefty@intel.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org, jackm <jackm@dev.mellanox.co.il>
Message-Id: <C546E163-297B-438E-AF76-CC04247ABFBA@oracle.com>
References: <20180418142450.15581-1-Haakon.Bugge@oracle.com>
 <1524196555.11756.30.camel@redhat.com> <20180420153451.GF30433@ziepe.ca>
 <50E3FE4A-2C6E-4493-92E1-383C349FAE3A@oracle.com>
 <20180423221618.0000795d@dev.mellanox.co.il>
To: Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
X-Mailer: Apple Mail (2.3445.6.18)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8875 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=848
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804260151
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3QG5rnR010646



> On 23 Apr 2018, at 21:16, jackm <jackm@dev.mellanox.co.il> wrote:
> 
> On Mon, 23 Apr 2018 16:19:57 +0200
> Håkon Bugge <haakon.bugge@oracle.com> wrote:
> 
> 
>>> 
>>> This actually looks like a genuine bug, why is it described only as
>>> 'confusing'? ib_register_mad_agent is callable from userspace, so at
>>> least two userspace agents can race and get the same TID’s.  
>> 
>> My understanding is that every lookup is using the {port, TID} tuple.
>> As such, it is not a bug, but, very confusing.
> Haakon, you are correct (see snippet from the IB spec, below).
> 
> We will NOT have a situation where there are 2 threads/apps
> with the same agent ID on the *same port* (accessing the agent ID
> allocator is protected by a per-port spinlock). Having the same agent ID
> on DIFFERENT ports is OK.
> Thus, there is NO bug here. (But as Haakon says, IMHO it is more robust
> to avoid having the same agent ID for 2 agents even if those agents are
> on different ports).
> 
>> 
>>> TIDs need to be globally unique on the entire machine.  
>> 
> Jason, that is not exactly correct.
> 
> From the IB Spec 1.3, C13-18.1.1 (in section 13.4.6.4 - TransactionID
> usage):
> "When initiating a new operation, MADHeader:TransactionID
> shall be set to such a value that within that MAD the combination of
> TID, SGID, and MgmtClass is different from that of any other currently
> executing operation. If the MAD does not have a GRH, its SLID is used
> in the combination in place of an SGID."
> 
> Since the SGID/SLID is different for each port, the per-port guarantee
> of no 2 agents receiving the same agent-ID value is sufficient.
> 
> -Jack

Shall I interpret this silence as my commit is good to go or that I should add Jack’s tangible information to the commit message?


Thxs, Håkon
