Return-Path: <tom.hromatka@oracle.com>
X-Google-Smtp-Source: AIpwx4/KMCigssfxJCwQokto4Nb3HWW6pbnO5KKATrDt3LMIMhe0f0amlBswTvzTnngojSgcLYrf
ARC-Seal: i=1; a=rsa-sha256; t=1524761658; cv=none;
        d=google.com; s=arc-20160816;
        b=r2J4I8C8eXBSVAqzKbq+2umMGCVxpZL2jSIQbceIyETeAeMHYjCBkhs59nrhZt1etc
         IT5O2upBDxYbwFvY1Fd7da2ZxMYBFCxUcbURktWaPbpK2mxxeWEK+3AAF/q63orxW8Yc
         pgpflgIG+OVWpHmcrTdgwpAu0G27ZLYFC8A7i3se2hBbgJuVefCK0pabwKl5j3tZnOdE
         b2WXeo8dOJjWY5pgd1Lbf0lhZjbX+LzjmTqPEim3giH3yEsRO4sU/IGCdBmtYAWQAVEa
         siBtAht9RPQDGHffqQbevAIEZxARJU8rLJ586B7V+tOgnsKR3sfuthcWFjMMpnSRKrEv
         aInQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=iFnoAs35Tacxef3SMac1BwOOlKg7TVCRs0qMx7ISPl0=;
        b=UKTXaMTxRieO/1u/juQ8aGIrfaiqu4I4iqdkY5rnHgdmRenElb8TKL/YG1FvufHC04
         wNB1hytKTBX7EsGlPM/Q1cB9kDXYmk6I4nWSffTRccyPf2sm5Fn8rPmzjC9TZFwSC+cT
         8OCak5jttrciUs20SkHkNNV9OMMWOARnw7rB4/W4fPfhC5YBwpHsYfjUKYAQ9C+xO1Jd
         OUv2eU2D6dpwf+4brPWwFyQqLAFPce5nOWlmYMygL9mPPj5tMlsMrwARx+Nr+e/mYI0o
         zgH860udjyqKs5clC6JAFhzi/5bSss2tGlr4Q1S3xx2cPFX7EZGnQIhnYneRs5bbN56I
         0USg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=qMzpqEaA;
       spf=pass (google.com: domain of tom.hromatka@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=tom.hromatka@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=qMzpqEaA;
       spf=pass (google.com: domain of tom.hromatka@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=tom.hromatka@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Tom Hromatka <tom.hromatka@oracle.com>
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, tom.hromatka@oracle.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        allen.pais@oracle.com, khalid.aziz@oracle.com,
        shannon.nelson@oracle.com, anthony.yznaga@oracle.com
Subject: [PATCH v6 0/2] sparc64: Add privileged ADI driver
Date: Thu, 26 Apr 2018 10:54:07 -0600
Message-Id: <20180426165409.716764-1-tom.hromatka@oracle.com>
X-Mailer: git-send-email 2.15.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8875 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=700
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804260157
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598828480711346055?=
X-GMAIL-MSGID: =?utf-8?q?1598828480711346055?=
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

v6:
  * Addressed a few action items from greg k-h
  * Added Reviewed-by Greg Kroah-Hartman and Shuah Khan
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
 drivers/char/adi.c                                 | 239 +++++++
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/sparc64/Makefile           |  46 ++
 tools/testing/selftests/sparc64/drivers/.gitignore |   1 +
 tools/testing/selftests/sparc64/drivers/Makefile   |  15 +
 tools/testing/selftests/sparc64/drivers/adi-test.c | 721 +++++++++++++++++++++
 .../selftests/sparc64/drivers/drivers_test.sh      |  30 +
 tools/testing/selftests/sparc64/run.sh             |   3 +
 10 files changed, 1069 insertions(+)
 create mode 100644 drivers/char/adi.c
 create mode 100644 tools/testing/selftests/sparc64/Makefile
 create mode 100644 tools/testing/selftests/sparc64/drivers/.gitignore
 create mode 100644 tools/testing/selftests/sparc64/drivers/Makefile
 create mode 100644 tools/testing/selftests/sparc64/drivers/adi-test.c
 create mode 100755 tools/testing/selftests/sparc64/drivers/drivers_test.sh
 create mode 100755 tools/testing/selftests/sparc64/run.sh

-- 
2.15.0
