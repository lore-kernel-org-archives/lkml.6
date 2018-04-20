Return-Path: <tom.hromatka@oracle.com>
X-Google-Smtp-Source: AIpwx48jBWWZv79gK++pL2/k/Bwj7fDjY/NB5Ig0KR/mjSnxsX8X6Dp4or+qJ55RRao2Z2f+28ip
ARC-Seal: i=1; a=rsa-sha256; t=1524245656; cv=none;
        d=google.com; s=arc-20160816;
        b=bTih16B+Gf6/61vWiKlVunRFow7O7jtUN0O7N2Uz+XnvfZz2qGShpfNaOCALXEkdzJ
         PFtgidDtIZtAM1iC7+Qbt5/D092UtPraQpe0GMFk8nRiUDkviJeF4fkdl0SpJhmQkHjc
         Blb0xdLL7MQuDDQoBQObK4ESl7bLMLjusIYjP77dOa8DNgxzPEBOuMkrh5Osv0ayrFQQ
         IaSIhHPRRj2qWZrQjYi8r5M5NEw16XPqQ9QCPNQmtwIGr+htsZDafgpE2vapnyk6+0pe
         vfEinfgJfdJDuZlLElER9+MRQfY8uCUS5D+DC3bNo41f1m7IuuAK19Oi06K+0bSUMZ6A
         C/UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=0dE6V++mi6CMeOaZGKFPjDZsTzurcvaHup+qlbP4hoM=;
        b=jE4Fxy3F9r/EXBf3go1cV3lRbeOYPVJ/UXbC81fqTLN0ALxCXTqD7+Vbs2M30LMTpS
         gvRoURkswft1NwPBJSgYtsPWR7LFMM7y2dBMYhXW1L07npeAD1ySUlBt/VpBiEEeF5d2
         sIy4JZVEtJGBaO0V81f6/ToGLhOL0sB5z9lKUP90dFEwQigjMdzxgt1DT1Mc5HvxSKnj
         euFIwu9xsZGUXxKHHdshvFzUiq2O2zOJk6qMb8NtFS6a8vWks6fE8AwVGKTX1unc3q6q
         HJmzuIk7zWYS6Y+ZvbpnsrtOPYGh/tbB8oWHDYyL0ELT2eWDPo8iAonIgehC/U0ym5ec
         dAPw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=kFgsisFD;
       spf=pass (google.com: domain of tom.hromatka@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=tom.hromatka@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=kFgsisFD;
       spf=pass (google.com: domain of tom.hromatka@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=tom.hromatka@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Tom Hromatka <tom.hromatka@oracle.com>
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, tom.hromatka@oracle.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        allen.pais@oracle.com, khalid.aziz@oracle.com,
        shannon.nelson@oracle.com, anthony.yznaga@oracle.com
Subject: [PATCH v2 0/2] sparc64: Add privileged ADI driver
Date: Fri, 20 Apr 2018 11:34:04 -0600
Message-Id: <20180420173406.485815-1-tom.hromatka@oracle.com>
X-Mailer: git-send-email 2.15.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8869 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=593
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804200175
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598287413064530122?=
X-GMAIL-MSGID: =?utf-8?q?1598287413064530122?=
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

v2:
  * Simplified copyright headers
  * Updated copyright headers to use GPL v3 or later
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
 drivers/char/adi.c                                 | 251 +++++++
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/sparc64/Makefile           |  46 ++
 tools/testing/selftests/sparc64/drivers/.gitignore |   1 +
 tools/testing/selftests/sparc64/drivers/Makefile   |  15 +
 tools/testing/selftests/sparc64/drivers/adi-test.c | 732 +++++++++++++++++++++
 .../selftests/sparc64/drivers/drivers_test.sh      |  30 +
 tools/testing/selftests/sparc64/run.sh             |   3 +
 10 files changed, 1092 insertions(+)
 create mode 100644 drivers/char/adi.c
 create mode 100644 tools/testing/selftests/sparc64/Makefile
 create mode 100644 tools/testing/selftests/sparc64/drivers/.gitignore
 create mode 100644 tools/testing/selftests/sparc64/drivers/Makefile
 create mode 100644 tools/testing/selftests/sparc64/drivers/adi-test.c
 create mode 100755 tools/testing/selftests/sparc64/drivers/drivers_test.sh
 create mode 100755 tools/testing/selftests/sparc64/run.sh

-- 
2.15.0
