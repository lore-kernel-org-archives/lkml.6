Return-Path: <tom.hromatka@oracle.com>
X-Google-Smtp-Source: AIpwx48MxmhS1wl6SHYDIS2feAbCJEZWxrHzU2P2gioTEuEzOKh2/itCtfqkOXP5hdtafW6XCRhs
ARC-Seal: i=1; a=rsa-sha256; t=1524069007; cv=none;
        d=google.com; s=arc-20160816;
        b=QhMigEE5n79tkm6c4RZBkIo3O7uM0gPLKhcfkgltgy0IxXLIDXPnREh1jcFvb8r4tq
         wyIYxDMylb/e4dYnVCN0l9G6pZzzQEb181eH9j43Cc+xRMBwUqp7naeq3yrKlEby7sfV
         qUvfefXZSPMtU5sVEexpXy++gPLCYHSFwpRZjAJSMl63KpbfozfAkRmHrehkG4OSqQzG
         jvUtAiAXZldBh4GFSGgOJv55dRLVMZqQOWeNCfsw3tePXnWxlFi88iqffRv9K/NL6VXx
         S+jccP/CLZr9TeT0n6Ra1+PGE0pdkpTfaa7nPYW3dHiydtMLHsOtTJ92I/vbDcD2m7bt
         WKcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=zz9tZc/YhCNPqv4ToUVnn3NhqbvAxLDiNDL2UCdMhtY=;
        b=DlIzcR9b0UE3VROStJkuzMxaHgPhTgB8akw4/J19RWUlQUBQyi7m9ErM3kJdax+CYL
         YZ2q+fwkyhTN+qSHZQByNKPu3ZAnKkdGTtDG/uXo5BccmzqoJQ67U0i4qu4TzMBt5XU0
         GA9Gaj10W5vjtWXWzu1uhlpwxy0F1pLQxtGka0/ZAxC3kXsv0pe8dm/8YFxyx6g7MIR5
         vyCsdKGKZHQokM7vC1dT136Oc7XlTb0jdP6q+W6EwhTGkd9bC8gn7jte02EvKlrFzs1s
         4DXLiB4Y7ebl/IibYSe/2ZmgowPEyO2MEwXVv2wrBhm8OMo0koUOwm3pHZVc9Qc0ZgHw
         urUA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=hXftYhtO;
       spf=pass (google.com: domain of tom.hromatka@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=tom.hromatka@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=hXftYhtO;
       spf=pass (google.com: domain of tom.hromatka@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=tom.hromatka@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Tom Hromatka <tom.hromatka@oracle.com>
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, tom.hromatka@oracle.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        allen.pais@oracle.com, khalid.aziz@oracle.com,
        shannon.nelson@oracle.com, anthony.yznaga@oracle.com
Subject: [PATCH 0/2] sparc64: Add privileged ADI driver
Date: Wed, 18 Apr 2018 10:29:56 -0600
Message-Id: <20180418162958.442909-1-tom.hromatka@oracle.com>
X-Mailer: git-send-email 2.15.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8867 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=453
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804180148
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598102183295690143?=
X-GMAIL-MSGID: =?utf-8?q?1598102183295690143?=
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

Tom Hromatka (2):
  char: sparc64: Add privileged ADI driver
  selftests: sparc64: char: Selftest for privileged ADI driver

 drivers/char/Kconfig                               |  12 +
 drivers/char/Makefile                              |   1 +
 drivers/char/adi.c                                 | 262 ++++++++
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/sparc64/Makefile           |  52 ++
 tools/testing/selftests/sparc64/drivers/.gitignore |   1 +
 tools/testing/selftests/sparc64/drivers/Makefile   |  13 +
 tools/testing/selftests/sparc64/drivers/adi-test.c | 727 +++++++++++++++++++++
 8 files changed, 1069 insertions(+)
 create mode 100644 drivers/char/adi.c
 create mode 100644 tools/testing/selftests/sparc64/Makefile
 create mode 100644 tools/testing/selftests/sparc64/drivers/.gitignore
 create mode 100644 tools/testing/selftests/sparc64/drivers/Makefile
 create mode 100644 tools/testing/selftests/sparc64/drivers/adi-test.c

-- 
2.15.0
