Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751967AbeFAOKZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 10:10:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35298 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbeFAOKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 10:10:23 -0400
To: Mike Snitzer <snitzer@redhat.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
        Laurence Oberman <loberman@redhat.com>, Ewan Milne <emilne@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Martin George <marting@netapp.com>,
        John Meneghini <John.Meneghini@netapp.com>, axboe@kernel.dk
Subject: Re: [PATCH 0/3] Provide more fine grained control over multipathing
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180525125322.15398-1-jthumshirn@suse.de>
        <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com>
        <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me>
        <20180530220206.GA7037@redhat.com> <20180531163311.GA30954@lst.de>
        <20180531181757.GB11848@redhat.com> <yq17enjut3q.fsf@oracle.com>
        <20180601042441.GB14244@redhat.com>
Date: Fri, 01 Jun 2018 10:09:36 -0400
In-Reply-To: <20180601042441.GB14244@redhat.com> (Mike Snitzer's message of
        "Fri, 1 Jun 2018 00:24:41 -0400")
Message-ID: <yq136y6vbrz.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8910 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806010164
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Good morning Mike,

> This notion that only native NVMe multipath can be successful is utter
> bullshit.  And the mere fact that I've gotten such a reaction from a
> select few speaks to some serious control issues.

Please stop making this personal.

> Imagine if XFS developers just one day imposed that it is the _only_
> filesystem that can be used on persistent memory.

It's not about project X vs. project Y at all. This is about how we got
to where we are today. And whether we are making right decisions that
will benefit our users in the long run.

20 years ago there were several device-specific SCSI multipath drivers
available for Linux. All of them out-of-tree because there was no good
way to consolidate them. They all worked in very different ways because
the devices themselves were implemented in very different ways. It was a
nightmare.

At the time we were very proud of our block layer, an abstraction none
of the other operating systems really had. And along came Ingo and
Miguel and did a PoC MD multipath implementation for devices that didn't
have special needs. It was small, beautiful, and fit well into our shiny
block layer abstraction. And therefore everyone working on Linux storage
at the time was convinced that the block layer multipath model was the
right way to go. Including, I must emphasize, yours truly.

There were several reasons why the block + userland model was especially
compelling:

 1. There were no device serial numbers, UUIDs, or VPD pages. So short
 of disk labels, there was no way to automatically establish that block
 device sda was in fact the same LUN as sdb. MD and DM were existing
 vehicles for describing block device relationships. Either via on-disk
 metadata or config files and device mapper tables. And system
 configurations were simple and static enough then that manually
 maintaining a config file wasn't much of a burden.

 2. There was lots of talk in the industry about devices supporting
 heterogeneous multipathing. As in ATA on one port and SCSI on the
 other. So we deliberately did not want to put multipathing in SCSI,
 anticipating that these hybrid devices might show up (this was in the
 IDE days, obviously, predating libata sitting under SCSI). We made
 several design compromises wrt. SCSI devices to accommodate future
 coexistence with ATA. Then iSCSI came along and provided a "cheaper
 than FC" solution and everybody instantly lost interest in ATA
 multipath.

 3. The devices at the time needed all sorts of custom knobs to
 function. Path checkers, load balancing algorithms, explicit failover,
 etc. We needed a way to run arbitrary, potentially proprietary,
 commands from to initiate failover and failback. Absolute no-go for the
 kernel so userland it was.

Those are some of the considerations that went into the original MD/DM
multipath approach. Everything made lots of sense at the time. But
obviously the industry constantly changes, things that were once
important no longer matter. Some design decisions were made based on
incorrect assumptions or lack of experience and we ended up with major
ad-hoc workarounds to the originally envisioned approach. SCSI device
handlers are the prime examples of how the original transport-agnostic
model didn't quite cut it. Anyway. So here we are. Current DM multipath
is a result of a whole string of design decisions, many of which are
based on assumptions that were valid at the time but which are no longer
relevant today.

ALUA came along in an attempt to standardize all the proprietary device
interactions, thus obsoleting the userland plugin requirement. It also
solved the ID/discovery aspect as well as provided a way to express
fault domains. The main problem with ALUA was that it was too
permissive, letting storage vendors get away with very suboptimal, yet
compliant, implementations based on their older, proprietary multipath
architectures. So we got the knobs standardized, but device behavior was
still all over the place.

Now enter NVMe. The industry had a chance to clean things up. No legacy
architectures to accommodate, no need for explicit failover, twiddling
mode pages, reading sector 0, etc. The rationale behind ANA is for
multipathing to work without any of the explicit configuration and
management hassles which riddle SCSI devices for hysterical raisins.

My objection to DM vs. NVMe enablement is that I think that the two
models are a very poor fit (manually configured individual block device
mapping vs. automatic grouping/failover above and below subsystem
level). On top of that, no compelling technical reason has been offered
for why DM multipath is actually a benefit. Nobody enjoys pasting WWNs
or IQNs into multipath.conf to get things working. And there is no flag
day/transition path requirement for devices that (with very few
exceptions) don't actually exist yet.

So I really don't understand why we must pound a square peg into a round
hole. NVMe is a different protocol. It is based on several decades of
storage vendor experience delivering products. And the protocol tries to
avoid the most annoying pitfalls and deficiencies from the SCSI past. DM
multipath made a ton of sense when it was conceived, and it continues to
serve its purpose well for many classes of devices. That does not
automatically imply that it is an appropriate model for *all* types of
devices, now and in the future. ANA is a deliberate industry departure
from the pre-ALUA SCSI universe that begat DM multipath.

So let's have a rational, technical discussion about what the use cases
are that would require deviating from the "hands off" aspect of ANA.
What is it DM can offer that isn't or can't be handled by the ANA code
in NVMe? What is it that must go against the grain of what the storage
vendors are trying to achieve with ANA?

-- 
Martin K. Petersen	Oracle Linux Engineering
