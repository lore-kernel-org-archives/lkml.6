Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750866AbeFACld (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 22:41:33 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:50804 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750728AbeFAClb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 22:41:31 -0400
To: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
        Laurence Oberman <loberman@redhat.com>, Ewan Milne <emilne@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Martin George <marting@netapp.com>,
        John Meneghini <John.Meneghini@netapp.com>, axboe@kernel.dk
Subject: Re: [PATCH 0/3] Provide more fine grained control over multipathing
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180525125322.15398-1-jthumshirn@suse.de>
        <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com>
        <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me>
        <20180530220206.GA7037@redhat.com> <20180531163311.GA30954@lst.de>
        <20180531181757.GB11848@redhat.com>
Date: Thu, 31 May 2018 22:40:41 -0400
In-Reply-To: <20180531181757.GB11848@redhat.com> (Mike Snitzer's message of
        "Thu, 31 May 2018 14:17:57 -0400")
Message-ID: <yq17enjut3q.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8910 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806010026
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mike,

> 1) container A is tasked with managing some dedicated NVMe technology
> that absolutely needs native NVMe multipath.

> 2) container B is tasked with offering some canned layered product
> that was developed ontop of dm-multipath with its own multipath-tools
> oriented APIs, etc. And it is to manage some other NVMe technology on
> the same host as container A.

This assumes there is something to manage. And that the administrative
model currently employed by DM multipath will be easily applicable to
ANA devices. I don't believe that's the case. The configuration happens
on the storage side, not on the host.

With ALUA (and the proprietary implementations that predated the spec),
it was very fuzzy whether it was the host or the target that owned
responsibility for this or that. Part of the reason was that ALUA was
deliberately vague to accommodate everybody's existing, non-standards
compliant multipath storage implementations.

With ANA the heavy burden falls entirely on the storage. Most of the
things you would currently configure in multipath.conf have no meaning
in the context of ANA. Things that are currently the domain of
dm-multipath or multipathd are inextricably living either in the storage
device or in the NVMe ANA "device handler". And I think you are
significantly underestimating the effort required to expose that
information up the stack and to make use of it. That's not just a
multipath personality toggle switch.

If you want to make multipath -ll show something meaningful for ANA
devices, then by all means go ahead. I don't have any problem with
that. But I don't think the burden of allowing multipathd/DM to inject
themselves into the path transition state machine has any benefit
whatsoever to the user. It's only complicating things and therefore we'd
be doing people a disservice rather than a favor.

-- 
Martin K. Petersen	Oracle Linux Engineering
