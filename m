Return-Path: <tom.hromatka@oracle.com>
X-Google-Smtp-Source: AB8JxZp2ugn0rAcikQ1+uUAc7VXT9n8CbEtuIOEytvTxPvZJDP/38hsKKRdzEM5yRUZj1+gP94/G
ARC-Seal: i=1; a=rsa-sha256; t=1524504822; cv=none;
        d=google.com; s=arc-20160816;
        b=AcJsgUI6xfn+AGmpcrdMPjmkE7l0SpjndOeO4VBcKtIecwQ+rjJ79O8dkluYxS533g
         EUIFKApnrKdWeRqys41SkzfbzXdiU+CPeaoQCh68gjQXWfCM4ucmx0KslxDhGKAC0TAN
         7HlfS7EuQmcqsL+fd7YTZfco3B8nUYh2vDrJVg0DOBmR753McPskZDcNqxiAqj8eGWL0
         gBsQx9+6z3mzW7h7XMsaKRBwznmMTRO4mSfTBNWDxQfZcYY8rkgHtp38OQl6QY960KFr
         zPR3VDwHFnFAhgVOQ6Okp4yApbNKwr/gfO3T/7Z6AeVMhQe3jo1jvVS692/FFfP5L/Iu
         rgDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=bE/LiSnew9CXx/v2cTEz9yVZkTotGMbOI5Z496V0n/w=;
        b=xFwUaqHyXgqy1uk/MOtQf1zJjf2jYzyJFUunuJ7dq2yaP2c5LWpGGPL9sROsX2zuvH
         LNAmadA/RbSkUW0Q+crxeeEUGH2UDhfvy1gFJvrh+jZ/Z+AUzAqZwX+nCTXDTxrBDiTG
         ReLCU55KllUTP3Nz9CLVdlsvQ6h13+dbvpak72xfrF95Z0OETwVhA0557mo4PSXfzl90
         eDuVZVcvIwSTdmBxr4jJoTQ/G7P9QTsyPMmv8qF2O32tBhmQ7vQzPiRL/5S9uJ4WDMul
         /4wKW/yz4k3v2AEYNFsOYxNXTjIOg/6sZdQS9crZVm7FJkALJ5NviD/WNIgGkPzt2E88
         OToA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=qkhjPiUi;
       spf=pass (google.com: domain of tom.hromatka@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=tom.hromatka@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=qkhjPiUi;
       spf=pass (google.com: domain of tom.hromatka@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=tom.hromatka@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Tom Hromatka <tom.hromatka@oracle.com>
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, tom.hromatka@oracle.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        allen.pais@oracle.com, khalid.aziz@oracle.com,
        shannon.nelson@oracle.com, anthony.yznaga@oracle.com
Subject: [PATCH v5 0/2] sparc64: Add privileged ADI driver
Date: Mon, 23 Apr 2018 11:33:30 -0600
Message-Id: <20180423173332.561489-1-tom.hromatka@oracle.com>
X-Mailer: git-send-email 2.15.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8872 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=609
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804230175
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598559168855051044?=
X-GMAIL-MSGID: =?utf-8?q?1598559168855051044?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ADI is a feature supported on SPARC M7 and newer processors to allow
hardware to catch rogue accesses to memory. ADI is supported for data
fetches only and not instruction fetches. An app can enable ADI on its
data pages, set version tags on them and use versioned addresses to
access the data pages. Upper bits of the address contain the version
tag. On M7 processors, upper four bits (bits 63-60) contain the version
tag. If a rogue app attempts to access ADI enabled data pages, its
access is blocked and processor generates an exception. Please see
Documentation/sparc/adi.txt for further details.

This patchset implements a char driver to read/write ADI versions from
privileged user space processes.  Intended consumers are makedumpfile
and crash.

v5:
  * Fixed MODULE_LICENSE() for adi.c
v4:
  * Fixed messed up subject lines.
v3:
  * Really fixed the copyright headers to use SPDX GPL v2.  Really.
v2:
  * Simplified copyright headers
  * Completely reworked sparc64 selftests Makefiles.  Used the
    android selftests Makefiles as an example
  * Added run.sh and drivers_test.sh to the sparc64 selftest
    directory.  Used bpf/test_kmod.sh and the android selftests
    as examples
  * Minor cleanups in the selftest adi-test.c
  * Added calls to ksft_test_*() in the adi-test.c

Tom Hromatka (2):
  char: sparc64: Add privileged ADI driver
  selftests: sparc64: char: Selftest for privileged ADI driver

 drivers/char/Kconfig                               |  12 +
 drivers/char/Makefile                              |   1 +
 drivers/char/adi.c                                 | 240 +++++++
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/sparc64/Makefile           |  46 ++
 tools/testing/selftests/sparc64/drivers/.gitignore |   1 +
 tools/testing/selftests/sparc64/drivers/Makefile   |  15 +
 tools/testing/selftests/sparc64/drivers/adi-test.c | 721 +++++++++++++++++++++
 .../selftests/sparc64/drivers/drivers_test.sh      |  30 +
 tools/testing/selftests/sparc64/run.sh             |   3 +
 10 files changed, 1070 insertions(+)
 create mode 100644 drivers/char/adi.c
 create mode 100644 tools/testing/selftests/sparc64/Makefile
 create mode 100644 tools/testing/selftests/sparc64/drivers/.gitignore
 create mode 100644 tools/testing/selftests/sparc64/drivers/Makefile
 create mode 100644 tools/testing/selftests/sparc64/drivers/adi-test.c
 create mode 100755 tools/testing/selftests/sparc64/drivers/drivers_test.sh
 create mode 100755 tools/testing/selftests/sparc64/run.sh

-- 
2.15.0
