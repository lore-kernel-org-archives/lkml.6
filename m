Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754258AbeD3Lv0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 07:51:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37050 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753414AbeD3LvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 07:51:23 -0400
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] IB/core: Make ib_mad_client_id atomic
From: =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <1524856116.11756.85.camel@redhat.com>
Date: Mon, 30 Apr 2018 13:50:57 +0200
Cc: jackm <jackm@dev.mellanox.co.il>, Jason Gunthorpe <jgg@ziepe.ca>,
        Don Hiatt <don.hiatt@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        Sean Hefty <sean.hefty@intel.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Message-Id: <DCABB189-F45C-487C-A78F-2F8441928E4B@oracle.com>
References: <20180418142450.15581-1-Haakon.Bugge@oracle.com>
 <1524196555.11756.30.camel@redhat.com> <20180420153451.GF30433@ziepe.ca>
 <50E3FE4A-2C6E-4493-92E1-383C349FAE3A@oracle.com>
 <20180423221618.0000795d@dev.mellanox.co.il>
 <C546E163-297B-438E-AF76-CC04247ABFBA@oracle.com>
 <20180426213250.0000515d@dev.mellanox.co.il>
 <9fdd3ec4-ee91-5442-e753-25d2ecd27ea9@xsintricity.com>
 <A58D5192-06E7-46A3-869C-273E9A2BC128@oracle.com>
 <1524856116.11756.85.camel@redhat.com>
To: Doug Ledford <dledford@redhat.com>
X-Mailer: Apple Mail (2.3445.6.18)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8878 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=965
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804300115
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3UBpVBs019350



> On 27 Apr 2018, at 21:08, Doug Ledford <dledford@redhat.com> wrote:
> 
> On Thu, 2018-04-26 at 20:51 +0200, Håkon Bugge wrote:
>>> Jason is out this week.  I'll end up processing this one (probably later
>>> today).  But I’ll fix up the commit message to suit my tastes when I do.
>> 
>> Thank you, Doug and Jack,
> 
> I reworded the commit message, let me know if you think I worded it
> wrong:
> 
> commit 69f01b81539c62f3dd96f9f02138ad7b839a0c70 (HEAD -> k.o/wip/dl-for-rc)
> Author: Håkon Bugge <haakon.bugge@oracle.com>
> Date:   Wed Apr 18 16:24:50 2018 +0200
> 
>    IB/core: Make ib_mad_client_id atomic
> 
>    Currently, kernel protects access to the agent ID allocator on a per
>    port basis using a spinlock, so it is impossible for two apps/threads on
>    the same port to get the same TID, but it is entirely possible for two
>    threads on different ports to end up with the same TID.  As this can be
>    confusing (regardless of it being legal according to the IB Spec 1.3,
>    C13-18.1.1, in section 13.4.6.4 - TransactionID usage: "Then initiating
>    a new operation, MADHeader:TransactionID shall be set to such a value
>    that within that MAD the combination of TIG, SGID, and MgmtClass is
>    different from that of any other currently executing operation. If the
>    MAD does not have a GRH, its SLID is used in the combination in place of
>    an SGID." which guarantees we are legal because our different ports will
>    have different SGID/SLID creating a unique tuple even if the TIDs are
>    identical), and as we might want to open the TID allocator up to more
>    parallel usage later, make the TID an atomic type so that no two
>    allocations, regardless of port number, will be the same.

The wording is OK per se, but the last sentence spans 12 lines - and as such - a little bit hard to comprehend. I suggest just to refer to IB Spec 1.3, clause C13-18.1.1 and not quote it and make the last sub-sentence (starting with “and as we might want to open”) a sentence by its own.


Thxs, Håkon

> 
>    Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
>    Reviewed-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
>    Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>    Reviewed-by: Zhu Yanjun <yanjun.zhu@oracle.com>
>    Signed-off-by: Doug Ledford <dledford@redhat.com>
> 
> -- 
> Doug Ledford <dledford@redhat.com>
>    GPG KeyID: B826A3330E572FDD
>    Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
