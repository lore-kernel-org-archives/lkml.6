Return-Path: <schwidefsky@de.ibm.com>
X-Google-Smtp-Source: AH8x226FWPss1kRWRSM6PupTu6ec4j4mhMjPUYAtWqX+ucRP0K8nsDJxJn3Y8TAbLptnujXBuzu2
ARC-Seal: i=1; a=rsa-sha256; t=1517986824; cv=none;
        d=google.com; s=arc-20160816;
        b=ORrWew0IkilB5aeyNRjqB157Kl5sa5JXj5gZVvfOJ9g8vbKZZ6rAaMU/YdeqXKI+37
         Pb5HzpOWRIZJnYPziWXAfwY+/EGSABt4ud9WZgMaqYeAazqyWIQHiEpP59FlW2cQuc1p
         FhAtprKv9P2PZIwE3k/u7NARDr2cHbcQXYafumsMymk+MTLFCYe0YmNV9ccU68LbIAtl
         Z2GuBBW0A6hKqweQmUv+HkxpaiT1TsuEwtlAXEsdG/jnzM1yq7525nPD4jP6QqEwD8pz
         N/REorsalmRPBkpMh6dKMYZJBTfuUCH2sXBrAMOaQufDYiN6HA81iKn34N4HcmPc82ke
         GisA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=U6S/lDKgix/iw85JcPe5SSXv0KIVTpntwUlqXLIg6bI=;
        b=tNcT3w8ViDfdyiBkPXkdZzK7wcD6DZuGc3DPpCYRdSfp13BTxXB1kDQkfNtLKwKRfp
         akMCTJjOX+bZu9/gSqr1YjYTUvjyEw1U770wJgvACqH/j2l9uTO/0XvlJ2epZ+gUDSmN
         h2kBdY2dIYIsr0o9ua0fN7GwWFgx8RJ1DxxZGXKcFJzfDRnSK5Ou6r0OucmbeEnTA9T+
         aMs+dnW7YBlwP730SrikmPrvF4SYmaVSRP9b75ExjlV+clsO2Tsvf43UHnsw5RYmM7ke
         V+yfLyRpW1R+RlyA/y3d91tYIr9RoasNMlKCvXMttlCXpT2zKl6xB9XuJFmMPcNXDsZP
         RXdA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of schwidefsky@de.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=schwidefsky@de.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of schwidefsky@de.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=schwidefsky@de.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>,
        Jiri Kosina <jkosina@suse.cz>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 0/6] s390: improve speculative execution handling v3
Date: Wed,  7 Feb 2018 08:00:05 +0100
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18020707-0016-0000-0000-0000052033DB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020707-0017-0000-0000-0000285CE856
Message-Id: <1517986811-27819-1-git-send-email-schwidefsky@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-07_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802070089
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591724552893910307?=
X-GMAIL-MSGID: =?utf-8?q?1591724552893910307?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Version 3 of the speculative execution improvements for s390.

Changes to v2:

* Dropped the prctl to introduce the PR_ISOLATE_BP control and simply
  added two exported functions s390_isolate_bp and s390_isolate_bp_guest.
  There is currently no caller for these functions, for now an out-of-tree
  module can be used until an acceptable upstream solution for the user
  space interface is found.

* Added an optimized version for the the array_index_mask_nospec
  function based on subtract with borrow for the spectre v1 defense.

* Introduce "expoline", the s390 version of a retpoline. As s390 does
  not have a return instruction and the associate return stack we use
  an execute-type instruction on an indirect branch to get unpredicatable
  branches. This requires gcc support for -mindirect-branch=thunk /
  -mfunction-return=thunk.  To be able to disable expolines there is
  another gcc option -mindirect-branch-table to keep a list of PC relative
  locations of calls to the execute thunks. With spectre_v2=off the call
  will be replaced with the original indirect branch and a nop.

Martin Schwidefsky (6):
  s390: scrub registers on kernel entry and KVM exit
  s390: add optimized array_index_mask_nospec
  s390/alternative: use a copy of the facility bit mask
  s390: add options to change branch prediction behaviour for the kernel
  s390: run user space and KVM guests with modified branch prediction
  s390: introduce execute-trampolines for branches

 arch/s390/Kconfig                     |  45 ++++++
 arch/s390/Makefile                    |  12 ++
 arch/s390/include/asm/barrier.h       |  24 ++++
 arch/s390/include/asm/facility.h      |  18 +++
 arch/s390/include/asm/lowcore.h       |   9 +-
 arch/s390/include/asm/nospec-branch.h |  18 +++
 arch/s390/include/asm/processor.h     |   4 +
 arch/s390/include/asm/thread_info.h   |   4 +
 arch/s390/kernel/Makefile             |   4 +
 arch/s390/kernel/alternative.c        |  26 +++-
 arch/s390/kernel/early.c              |   5 +
 arch/s390/kernel/entry.S              | 249 ++++++++++++++++++++++++++++++----
 arch/s390/kernel/ipl.c                |   1 +
 arch/s390/kernel/module.c             |  62 +++++++--
 arch/s390/kernel/nospec-branch.c      | 100 ++++++++++++++
 arch/s390/kernel/processor.c          |  18 +++
 arch/s390/kernel/setup.c              |   8 +-
 arch/s390/kernel/smp.c                |   7 +-
 arch/s390/kernel/vmlinux.lds.S        |  14 ++
 drivers/s390/char/Makefile            |   2 +
 20 files changed, 591 insertions(+), 39 deletions(-)
 create mode 100644 arch/s390/include/asm/nospec-branch.h
 create mode 100644 arch/s390/kernel/nospec-branch.c

-- 
2.7.4
