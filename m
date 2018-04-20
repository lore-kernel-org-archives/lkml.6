Return-Path: <tom.hromatka@oracle.com>
X-Google-Smtp-Source: AIpwx49BcagdpeyirEg1er6mNibG1yxapnwHqywbZaJplkattV/qp4PjeYTP7G12eFseSGacH0JA
ARC-Seal: i=1; a=rsa-sha256; t=1524253188; cv=none;
        d=google.com; s=arc-20160816;
        b=LFrpvfCn4XRNa1dGL6MCnTofWyn2uoc9wu8mAe/bHxOVW9Pp50q+sXKYv08xvHuHlU
         JktegwOHeXvKVrSn9yik0W8OppEUo5PFFFw0HOxWsSjZnjOmz36BoxgAVo0MBVOS7pmZ
         DKqz7+ugD6S7EhAjiDHf+MBQahsHz/SbYJu82cYnPPdr1DCDaeuqaauhoypCZf9nQo+x
         7CaeJdh5gWccb5XUC7u8gPV83R8cs2sN6cuikEGeDR1mpt4Nv8b/Hk2ySqqZaJ9LDeKQ
         J+b2NA0UGyOEtN8FF0XwNQLP89s7p3OICvxZlXox5loiSsFKlaWoAMas00i0Xq3+TfXe
         e0lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=erfA20x/KzUluKzc+olIfYzUFNuI7oxsPA65WNN5Ngs=;
        b=xGuMXMf+QhthferBaBEEJhftvIZL0z7IwUA1meO8+dbegbtb9Bh93/+OSsjU+fSES6
         Z2KXRUL5HpIxpEPiFzodFiZxsBJd4gBV2whfBMIh3oCbhFM3xJ5C849WMMbuhnG6LlfU
         1DL84bhAU1Q4MEtj50tJTt6Nmjy614w4PUGC6SCjWuOw1c7X339u72GHqOEUYMDdMjTu
         4IUX6yTI9ZQGhqjvr7oV/Rf8VP5SPSZhaImxuRLl2L8JANswQGvuQfI7agBUpDCKYOJZ
         Wn3ZfhU0RTGTK9/SxSKuSMlah4FOk4JYCBTa5frwVkvDBZ6Bydle5OfjyGbCkOLLd6Lr
         ogmg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=YeLM9Efr;
       spf=pass (google.com: domain of tom.hromatka@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=tom.hromatka@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=YeLM9Efr;
       spf=pass (google.com: domain of tom.hromatka@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=tom.hromatka@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Tom Hromatka <tom.hromatka@oracle.com>
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, tom.hromatka@oracle.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        allen.pais@oracle.com, khalid.aziz@oracle.com,
        shannon.nelson@oracle.com, anthony.yznaga@oracle.com
Subject: [PATCH v3 0/2] sparc64: Add privileged ADI driver
Date: Fri, 20 Apr 2018 13:39:37 -0600
Message-Id: <20180420193939.487546-1-tom.hromatka@oracle.com>
X-Mailer: git-send-email 2.15.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8869 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=703
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804200197
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598287413064530122?=
X-GMAIL-MSGID: =?utf-8?q?1598295310976424071?=
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
  SPARC M7 and newer processors utilize ADI to version and protect
    memory.  This driver is capable of reading/writing ADI/MCD versions
    from privileged user space processes. Addresses in the adi file are
    mapped linearly to physical memory at a ratio of 1:adi_blksz.  Thus,
    a read (or write) of offset K in the file operates upon the ADI
    version at physical address K * adi_blksz.  The version information
    is encoded as one version per byte.  Intended consumers are
    makedumpfile and crash.
  Add a selftest for the sparc64 privileged ADI driver.  These tests
    verify the read(), pread(), write(), pwrite(), and seek()
    functionality of the driver.  The tests also report simple
    performance statistics:

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
