Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AIpwx48Y8vXcmlSZzhzKH430c5A7Hv/UP+zIcQrRQQyC7Y6SGGhu6PGNJIsP9hbAdyMpq+5ibK3J
ARC-Seal: i=1; a=rsa-sha256; t=1524013869; cv=none;
        d=google.com; s=arc-20160816;
        b=rgPumSePGdtl+OMrs4Il/f5XepnNCDomYWIBnJ+wt4WE4UzMq7LoUSmogRXjEhghJu
         RQhK71Bmg0/6XVe27GzkMtR6uFdRssbVw2Gr1ELnkp2oPOT4cD/LyZO+YXPurYy5mtVk
         Xv34AJIvwT3MlJIdBGLM35qlohK4tXcdMOf1VS/Ymn2P430HXCLZ5W6E5RJhXHvlJJiP
         vJHoRxGAsLwN3auWY1hL+xE47b17nhoQsunnPZDDWQdENi4+QPQTGBt83H+oidXPa9+w
         t28c6m7ScJJWXHfUMW4r50uCbwP46fL7eGcbXNaC1WE6f5NTbK3Y2wCloeZVIXNnqOg8
         q9fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:references:in-reply-to:date:subject:cc:to:from
         :arc-authentication-results;
        bh=k0FVK6ODpp6paOU5ptI+KBwYVy3+ze5bhVZoQNjOlkA=;
        b=VaqPW7NBu3V+hFoI3ALgDDpfDiNRo70gyCf5MWO3nU2nD2SnIpqm/+LzfHnR8/fD+r
         GjDpsdBt6LzJUgVvcta1OkDdyuiPdto0LpRgB80pIQXRWPD5iAR0y0DeeffFaZSUocY+
         7bPJ3CbVtyele5+WreTOhDs0QMObdirSx/RaFnqX+IgiF09uvF7E8dSUvicgkWTGSk/I
         UIBgVZD5J/ycKLXdknyUz+Z7rAjxw+W1989PEce2b9BEUVFB0dUua+tiJvt3ZbKwpUQs
         jr9jDzBLPoYyJN1vtL29LO1H0EhlVxmwVcMORh8lIqYjFunHwlF2Q4jJGWx00D201ydP
         gyCA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alastair@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=alastair@au1.ibm.com;
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
Subject: [PATCH v2 0/7] ocxl: Implement Power9 as_notify/wait for OpenCAPI
Date: Wed, 18 Apr 2018 11:08:03 +1000
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180417020950.21446-1-alastair@au1.ibm.com>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041801-0012-0000-0000-000005CC01F5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041801-0013-0000-0000-000019484F7C
Message-Id: <20180418010810.30937-1-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804180008
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957545708610208?=
X-GMAIL-MSGID: =?utf-8?q?1598044367703785699?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alastair D'Silva <alastair@d-silva.org>

The Power 9 as_notify/wait feature provides a lower latency way to
signal a thread that work is complete. This series enables the use of
this feature from OpenCAPI adapters, as well as addressing a potential
starvation issue when allocating thread IDs.

Changelog:
v2:
  Rename get_platform IOCTL to get_features
  Move stray edit from patch 1 to patch 3

Alastair D'Silva (7):
  powerpc: Add TIDR CPU feature for Power9
  powerpc: Use TIDR CPU feature to control TIDR allocation
  powerpc: use task_pid_nr() for TID allocation
  ocxl: Rename pnv_ocxl_spa_remove_pe to clarify it's action
  ocxl: Expose the thread_id needed for wait on p9
  ocxl: Add an IOCTL so userspace knows what CPU features are available
  ocxl: Document new OCXL IOCTLs

 Documentation/accelerators/ocxl.rst   |  10 ++++
 arch/powerpc/include/asm/cputable.h   |   3 +-
 arch/powerpc/include/asm/pnv-ocxl.h   |   2 +-
 arch/powerpc/include/asm/switch_to.h  |   1 -
 arch/powerpc/kernel/dt_cpu_ftrs.c     |   1 +
 arch/powerpc/kernel/process.c         | 101 +---------------------------------
 arch/powerpc/platforms/powernv/ocxl.c |   4 +-
 drivers/misc/ocxl/context.c           |   5 +-
 drivers/misc/ocxl/file.c              |  78 ++++++++++++++++++++++++++
 drivers/misc/ocxl/link.c              |  38 ++++++++++++-
 drivers/misc/ocxl/ocxl_internal.h     |   1 +
 include/misc/ocxl.h                   |   9 +++
 include/uapi/misc/ocxl.h              |  14 +++++
 13 files changed, 162 insertions(+), 105 deletions(-)

-- 
2.14.3
