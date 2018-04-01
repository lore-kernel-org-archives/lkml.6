Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753661AbeDAOgm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 10:36:42 -0400
Received: from mail-ua0-f170.google.com ([209.85.217.170]:46474 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753400AbeDAOgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 10:36:06 -0400
X-Google-Smtp-Source: AIpwx4/KeyG0S0CHH9PUVurB7rjKYyKKtGEdQbTKpkr97oD90J35pc4BxCND7RvWayudRYsA0uUaZqedWLszsy1Y1qo=
MIME-Version: 1.0
From: Sitsofe Wheeler <sitsofe@gmail.com>
Date: Sun, 1 Apr 2018 15:35:35 +0100
Message-ID: <CALjAwxh-PVYFnYFCJpGOja+m5SzZ8Sa4J7ohxdK=r8NyOF-EMA@mail.gmail.com>
Subject: [BISECTED][REGRESSION] Hang while booting EeePC 900
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Asai Thambi SP <asamymuthupa@micron.com>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Jan Hoeppner <hoeppner@linux.vnet.ibm.com>,
        Bart Van Assche <Bart.VanAssche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While trying to boot an EeePC 900 on the latest git mainline kernel a
hang is encountered while systemd is starting services but this did
not happen with 4.15. A bisection narrowed it down to the commit
358f70da49d77c43f2ca11b5da584213b2add29c ("blk-mq: make
blk_abort_request() trigger timeout path"). Here's the bisection log:

git bisect start
# bad: [9829fcd7ae99d5955bb76a8fb8060e63339d7c9d] drm-tip:
2018y-03m-29d-19h-56m-48s UTC integration manifest
git bisect bad 9829fcd7ae99d5955bb76a8fb8060e63339d7c9d
# good: [bebc6082da0a9f5d47a1ea2edc099bf671058bd4] Linux 4.14
git bisect good bebc6082da0a9f5d47a1ea2edc099bf671058bd4
# skip: [68ae7424583b561c2fda2fb03726e56946b34b19] ixgbe: Drop
l2_accel_priv data pointer from ring struct
git bisect skip 68ae7424583b561c2fda2fb03726e56946b34b19
# good: [d8a5b80568a9cb66810e75b182018e9edb68e8ff] Linux 4.15
git bisect good d8a5b80568a9cb66810e75b182018e9edb68e8ff
# bad: [fe53d1443a146326b49d57fe6336b5c2a725223f] Merge tag
'armsoc-drivers' of
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
git bisect bad fe53d1443a146326b49d57fe6336b5c2a725223f
# bad: [a103950e0dd2058df5e8a8d4a915707bdcf205f0] Merge branch 'linus'
of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
git bisect bad a103950e0dd2058df5e8a8d4a915707bdcf205f0
# bad: [d8b91dde38f4c43bd0bbbf17a90f735b16aaff2c] Merge branch
'perf-core-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad d8b91dde38f4c43bd0bbbf17a90f735b16aaff2c
# bad: [9697e9da84299d0d715d515dd2cc48f1eceb277d] Merge tag
'edac_for_4.16' of git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp
git bisect bad 9697e9da84299d0d715d515dd2cc48f1eceb277d
# good: [7f3fdd40a7dfaa7405185250974b0fabd08c1f8b] Merge tag
'pm-4.16-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect good 7f3fdd40a7dfaa7405185250974b0fabd08c1f8b
# good: [0fc7e74663447682c904fe375bb680b004ddaa14] Merge tag
'mtd/for-4.16' of git://git.infradead.org/linux-mtd
git bisect good 0fc7e74663447682c904fe375bb680b004ddaa14
# good: [310eb252a78307fc2ac4c4c755290a578c0304d0] mmc: mmci: fix
error return code in mmci_probe()
git bisect good 310eb252a78307fc2ac4c4c755290a578c0304d0
# bad: [3eb2ce825ea1ad89d20f7a3b5780df850e4be274] Linux 4.16-rc7
git bisect bad 3eb2ce825ea1ad89d20f7a3b5780df850e4be274
# bad: [537433b6241e067de2d9da3bed5f4fed9c9eac58] Merge tag
'armsoc-dt' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
git bisect bad 537433b6241e067de2d9da3bed5f4fed9c9eac58
# bad: [a103950e0dd2058df5e8a8d4a915707bdcf205f0] Merge branch 'linus'
of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
git bisect bad a103950e0dd2058df5e8a8d4a915707bdcf205f0
# bad: [efd52b5d363e3e3b6224ad39949219c0df117c91] Merge tag
'nfs-for-4.16-1' of git://git.linux-nfs.org/projects/trondmy/linux-nfs
git bisect bad efd52b5d363e3e3b6224ad39949219c0df117c91
# bad: [6304672b7f0a5c010002e63a075160856dc4f88d] Merge branch
'x86-pti-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 6304672b7f0a5c010002e63a075160856dc4f88d
# bad: [a4b7fd7d34de5765dece2dd08060d2e1f7be3b39] Merge tag
'iversion-v4.16-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux
git bisect bad a4b7fd7d34de5765dece2dd08060d2e1f7be3b39
# skip: [8c7a8d1c4b9c30a2be3b31a2e6af1cefd45574eb] lib/scatterlist:
Fix chaining support in sgl_alloc_order()
git bisect skip 8c7a8d1c4b9c30a2be3b31a2e6af1cefd45574eb
# skip: [85ba3effc5a0836b9195f2010684062ad230cc23] blk-mq: add missing
RQF_STARTED to debugfs
git bisect skip 85ba3effc5a0836b9195f2010684062ad230cc23
# good: [73d8003749ebfd9617076213c0033e11aacf823c] Merge
remote-tracking branch 'regulator/topic/core' into regulator-next
git bisect good 73d8003749ebfd9617076213c0033e11aacf823c
# bad: [9b9c63f71bddf3dc897aaaa46c0593abc3e09932] Merge branch
'nvme-4.16' of git://git.infradead.org/nvme into for-4.16/block
git bisect bad 9b9c63f71bddf3dc897aaaa46c0593abc3e09932
# good: [b221fc130c49c50f4c2250d22e873420765a9fa2] bcache: ret IOERR
when read meets metadata error
git bisect good b221fc130c49c50f4c2250d22e873420765a9fa2
# bad: [e14575b3d457f5806d79b85886ef94d9c29e3b2a] block: convert
REQ_ATOM_COMPLETE to stealing rq->__deadline bit
git bisect bad e14575b3d457f5806d79b85886ef94d9c29e3b2a
# bad: [5a61c36398d0626bad377a7f5b9391b21e16e91d] blk-mq: remove
REQ_ATOM_STARTED
git bisect bad 5a61c36398d0626bad377a7f5b9391b21e16e91d
# good: [5138ac6748e381501894976f995fb7d1a63f80f4] bcache: fix
misleading error message in bch_count_io_errors()
git bisect good 5138ac6748e381501894976f995fb7d1a63f80f4
# good: [04ced159cec863f9bc27015d6b970bb13cfa6176] blk-mq: move hctx
lock/unlock into a helper
git bisect good 04ced159cec863f9bc27015d6b970bb13cfa6176
# good: [67818d25738b1c9ffb8541ca875b2ae3304869d5] blk-mq: use
blk_mq_rq_state() instead of testing REQ_ATOM_COMPLETE
git bisect good 67818d25738b1c9ffb8541ca875b2ae3304869d5
# bad: [358f70da49d77c43f2ca11b5da584213b2add29c] blk-mq: make
blk_abort_request() trigger timeout path
git bisect bad 358f70da49d77c43f2ca11b5da584213b2add29c
# first bad commit: [358f70da49d77c43f2ca11b5da584213b2add29c] blk-mq:
make blk_abort_request() trigger timeout path

-- 
Sitsofe | http://sucs.org/~sits/
