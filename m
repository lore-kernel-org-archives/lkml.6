Return-Path: <tom.hromatka@oracle.com>
X-Google-Smtp-Source: AIpwx48lD+73clMSAWMOIEGn8VNOLBU5vzleNXoIVDCps2WtpCcsUBrqSAmk0pQSS8jkBvuWrYKo
ARC-Seal: i=1; a=rsa-sha256; t=1524257549; cv=none;
        d=google.com; s=arc-20160816;
        b=b4hzraqmmN2G8iHEEq+5Nx3m6D3zHfI9X+XrsYbm1vMDGPpxvD0y49+tmjHG7LouiS
         owbo/bhfNEJB/BkY3ku24Sd1wD+U2Ut5xn4QQNxbHPAwVUdtcHhOpLf1m9Gvxd/mptYj
         WXOoHmT1smfr8G5Ole4Wb98DDc7hZnJFRJezoMg4TjUXeVcB1sTpJKI5E9i3ze5MO7ev
         BFioDAXwnWGgUf2JWDPR51JYDPbvEpSH54ZE7kmwoYIZ6texvnR24O6s9Ue/NUm8g4WP
         5rb1WxlVgFgn+quagp+74MXLQ1c544Bmwn7kzEUM8IGjjIzey/VRicXBgl0LA1933YKH
         bWHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=7YHeYJCEDYGa+RYGn1S2AGpxi9R/FREo03jdzoW6Yzk=;
        b=njO6anPPpM/wIGBvfISy4CRYSwFhZLXRDetRY04hTWOxzz5vQTDMc37+5oRza6uPv6
         EmfVZOFWKNml7PRUfYirN0Rnih9pDVis2ayr6yVf4OAx8F0zGis0KPR8L7mcFTcM294Y
         CL/ldamzDawGGIaL65nytQkio4UJENpO32jj8PeOFAHGozYK4doOAwS4kE6LcGAtUpx6
         tIH1Kt/fzOjwkFYyf/SFWPTMOuKHTqW5ujjeJT64cvpoGP78B3SxntmCKNyh2f4fBjYC
         Po5NuRCqhYGULiEpH7Bw3Ul7KGix9bnbWLQX0OsFd8v5EftE3tkwIne5UBx9gKxzjr8f
         lUYw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=SCtgX9YO;
       spf=pass (google.com: domain of tom.hromatka@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=tom.hromatka@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=SCtgX9YO;
       spf=pass (google.com: domain of tom.hromatka@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=tom.hromatka@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Tom Hromatka <tom.hromatka@oracle.com>
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, tom.hromatka@oracle.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        allen.pais@oracle.com, khalid.aziz@oracle.com,
        shannon.nelson@oracle.com, anthony.yznaga@oracle.com
Subject: [PATCH v4 0/2] sparc64: Add privileged ADI driver
Date: Fri, 20 Apr 2018 14:52:19 -0600
Message-Id: <20180420205221.488589-1-tom.hromatka@oracle.com>
X-Mailer: git-send-email 2.15.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8869 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=563
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804200210
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598299884417445019?=
X-GMAIL-MSGID: =?utf-8?q?1598299884417445019?=
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
