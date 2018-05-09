Return-Path: <alastair@au1.ibm.com>
X-Google-Smtp-Source: AB8JxZqp7GlSemmTbX0vquipvstK0bz4hx3xRvGUWMTGvVyjSqf4SszSr/kjPCVF4qLYsQRmeFpp
ARC-Seal: i=1; a=rsa-sha256; t=1525844154; cv=none;
        d=google.com; s=arc-20160816;
        b=tnoJhhbaMv1ouRrj3FwAZmz2qrMsYn9c3uBKFwNTK8u+OXyz9cqI2zM9Io2NCR1cgh
         Md7pOeUTxBMQHmZ2ajfGmn6B4v6QpxWC3V6tjWKGfKIj7pPYtjXpb5dF09F2UrtNuevM
         PqE6jYdlmZ3l0jZRn3mSlR/1RDSri0bg4YcYXvEsSc7S7glcZbXr7V8W7Y2XuF8lRstb
         KxMPkkKlwyPiDzhQzXT/rzcuqxMoxIi5kRzg1g+psKI6CmugCIbIZ6yURSbOYl/QBqR3
         4TH/hkvZnPkhM0f5rqnp6g7PVerPCYS/XuincIg2kXR4z4S5Kj6n2YFenjbNzbkaQbnW
         zANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:message-id:references
         :in-reply-to:date:subject:cc:to:from:arc-authentication-results;
        bh=O7TOKUVQ6KvLAGfaN0o+5wH+bszKw1r8J7zgtEmTQnU=;
        b=WEW/wFBZQuda/MSz3Y6VTN/fSk2DIxQkr4WPNMzsGGGjRQ+IClfXKizg8L4k8dZxmj
         ZKIf0hM4sdHPiddqYPK6hSt2MLKaX/FOg7FQYAYz3Y82t9Lu0e/orSWu4K1DLDIRmSRG
         E8mDxIWf28oU2s+1+L3ee4bs2+zIGKwk2dqvY1eqM5NknxWaX43NIrVwdW8PfZ/sLagX
         8+AbCENH+KX+329rG2lt6pM4yIZSeslB+OKpQaedRUjiRu1i1oj+/SP5MDfMYdCThumg
         0KYZrlPJNwo0sAjwbSRVSv1eiKFSUvJFRUdTLTa8YHcs9J+pUSb2wKUfaeFUKJb/Tonr
         gUnQ==
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
Subject: [PATCH v4 0/7] ocxl: Implement Power9 as_notify/wait for OpenCAPI
Date: Wed,  9 May 2018 15:34:59 +1000
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180509004212.4506-1-alastair@au1.ibm.com>
References: <20180509004212.4506-1-alastair@au1.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18050905-0040-0000-0000-0000045791A3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050905-0041-0000-0000-000020FB9AD6
Message-Id: <20180509053506.9754-1-alastair@au1.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-09_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805090056
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957545708610208?=
X-GMAIL-MSGID: =?utf-8?q?1599963559533061775?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alastair D'Silva <alastair@d-silva.org>

The Power 9 as_notify/wait feature provides a lower latency way to
signal a thread that work is complete. This series enables the use of
this feature from OpenCAPI adapters, as well as addressing a potential
starvation issue when allocating thread IDs.

Changelog:
v4:
  Remove the "unique" statement from the set_thread_tidr function and
    move the text explaining why it is safe from the commit message
    to the function description
v3:
  Fix references to POWER9
  Remove stray whitespace edit from docs
  Add more details to commit message for "use task_pid_nr()"
  Retitle patch 6 to indicate OCXL rather than CPU features
v2:
  Rename get_platform IOCTL to get_features
  Move stray edit from patch 1 to patch 3

Alastair D'Silva (7):
  powerpc: Add TIDR CPU feature for POWER9
  powerpc: Use TIDR CPU feature to control TIDR allocation
  powerpc: use task_pid_nr() for TID allocation
  ocxl: Rename pnv_ocxl_spa_remove_pe to clarify it's action
  ocxl: Expose the thread_id needed for wait on POWER9
  ocxl: Add an IOCTL so userspace knows what OCXL features are available
  ocxl: Document new OCXL IOCTLs

 Documentation/accelerators/ocxl.rst   |  11 ++++
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
 13 files changed, 163 insertions(+), 105 deletions(-)

-- 
2.14.3
