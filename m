Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AIpwx49yaTsp1fy45SNh8FMlJ/ctOMfQYRJuF8e8BmuQUCT9rNIAeKz1veO4zR11j5KVfKDCbKmh
ARC-Seal: i=1; a=rsa-sha256; t=1523931070; cv=none;
        d=google.com; s=arc-20160816;
        b=o0XYlUY6PhEqHNPj38/2ijT6Yt4ugady8yX8qkCSzPIBekxHTuMioHaNNXgN9wjf/o
         dqLmrpqFI59SuL/l59OB+RhVYvhHbxhh42tWvysQVsWTqB2Hk5UY2eduhdVOgDiuOVHf
         Pxh1IwBw+P4tFMMQsb+w2Og56vffg/rVyphRhLFGSrp55W6DV4h0YZHWsmDzRv26FbDo
         +h2LjKuo4itILz+KnDgp/iwZfB73TXGfoE4YczUEoFEuqxVoq8YACpCoZuk6EwyrFUtW
         Ya/lPa5Oa23sxU/s0nLmy2dBtvE5t1epJsuwD/01Au190tBWJEpeHvBwLa3nCH0PRTq0
         OP/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=+Gy6IeOQ95AB0ZwTTF2vCTVzQFiCchy7jLj2+VqsU28=;
        b=Z11kNTlUR7f3H43VnCcUBJgj+QjnypOvD8nprm6Rpt/9Fz/iTpWQp+X81zaJfaYNQI
         Vso5SHxMIIsloBoGycXdTVAoMRmhk1xQmxfjypLDKTSxwPYqVJ0izjATd745wRpBaG2Z
         armHThRpDHX57uHhAjMXno47wOrxEjVRS7QyVo5/gl+m8FYHCyHnHc8p7Nth3E1LHMrP
         eIeS0p8ugM1sOHDpmYum3YVdn8AyFQUj2HLCIXktbtnWDZci8EIew/O6MHZwggCibbkH
         9ffy1h1CpAWMsiEIcZd4nQEva94p1KUkTBB7KhQN5WGzNKB0b7aY0of93A+kCG6s+qrT
         Pnqg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
        vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
        sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
        corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
Subject: [PATCH 0/7] ocxl: Implement Power9 as_notify/wait for OpenCAPI
Date: Tue, 17 Apr 2018 12:09:43 +1000
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 18041702-0040-0000-0000-0000042FBD4C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041702-0041-0000-0000-00002633C4B3
Message-Id: <20180417020950.21446-1-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804170020
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957545708610208?=
X-GMAIL-MSGID: =?utf-8?q?1597957545708610208?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alastair D'Silva <alastair@d-silva.org>

The Power 9 as_notify/wait feature provides a lower latency way to
signal a thread that work is complete. This series enables the use of
this feature from OpenCAPI adapters, as well as addressing a potential
starvation issue when allocating thread IDs.

Alastair D'Silva (7):
  powerpc: Add TIDR CPU feature for Power9
  powerpc: Use TIDR CPU feature to control TIDR allocation
  powerpc: use task_pid_nr() for TID allocation
  ocxl: Rename pnv_ocxl_spa_remove_pe to clarify it's action
  ocxl: Expose the thread_id needed for wait on p9
  ocxl: Add an IOCTL so userspace knows which platform the kernel
    requires
  ocxl: Document new OCXL IOCTLs

 Documentation/accelerators/ocxl.rst   | 10 ++++
 arch/powerpc/include/asm/cputable.h   |  3 +-
 arch/powerpc/include/asm/pnv-ocxl.h   |  2 +-
 arch/powerpc/include/asm/switch_to.h  |  1 -
 arch/powerpc/kernel/dt_cpu_ftrs.c     |  1 +
 arch/powerpc/kernel/process.c         | 99 +----------------------------------
 arch/powerpc/platforms/powernv/ocxl.c |  4 +-
 drivers/misc/ocxl/context.c           |  5 +-
 drivers/misc/ocxl/file.c              | 78 +++++++++++++++++++++++++++
 drivers/misc/ocxl/link.c              | 38 +++++++++++++-
 drivers/misc/ocxl/ocxl_internal.h     |  1 +
 include/misc/ocxl.h                   |  9 ++++
 include/uapi/misc/ocxl.h              | 14 +++++
 13 files changed, 161 insertions(+), 104 deletions(-)

-- 
2.14.3
