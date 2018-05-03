Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AB8JxZpYhihDufiuXCbsZ49Hh43LyTHEt6+1Ai3shFo//TmI603TXC9hHdehd7LD9kwyOisf3F0H
ARC-Seal: i=1; a=rsa-sha256; t=1525319981; cv=none;
        d=google.com; s=arc-20160816;
        b=qQEngDIkbzsWCrbaehosCogIH5FDXwKDMaivjqHLgVpz9EPf1Hq+3ZESrtWeIx5m2i
         IUWuZ5i50wOMlquIH24DQzAR31F6MHJj02q5EiZB6YR7va1NCHTldF/TYgFO+o7aPNWc
         a0gm3uCkVDPpcBzyHkEYbWfATRrfsXgmLTVOCkC5G1XxL3TFbS/FkMpmD7L8lBc74lvM
         X2CZqlJ2Ql1+YcrmNCibkSc2KVhCNCOeF/co2bca/uwDWcdcCkOn08+W/FIUVLBHs+mp
         8iwxU4kYyccyrDezUyk97VGlvko1odgKlx93LXqX+t/hlYQm2VHPu1Fmbh2xZjq4vO/1
         uDYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:to:from:dkim-signature
         :arc-authentication-results;
        bh=BrshmQzgDwZ7kPwOKeuqfrd2j5sWpPJcPwsH+IPWX2U=;
        b=dLt3GTalMFTYXdGV8PQfjn4xFdIi45Hb4+g5YIBmLRitxux1IQr2ITyhzf8Bmh+yxO
         CXT/BpalbK5oT/i6aDLFXzP3HHyoMY5GI1Mt38KjvEneWvCJbm0eWlQwBru5XL5r+Ih+
         kP3BsUUQW6CtHCQMXw5eDWZf+4/Ni56cm56089xcjLVhtl3pRoNN9GBM9rdHK8iPnI9p
         zG2lEqtgHQ1XPmSEi4lepg2NV8KJBG60AqAR9HloqMFpWIF4kGZPu5jsSyJbVfCMSLwj
         obPsh2fr7sPlpg+IvB/l3EKy0Jr919GmNnzHc4aHMxKfJ7BHe5FsL8TGK8wrR9YGubrU
         lHxA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=qFg/tlwq;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=qFg/tlwq;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: pasha.tatashin@oracle.com, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, linux-kernel@vger.kernel.org,
        jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH 0/2] multi-threading device shutdown
Date: Wed,  2 May 2018 23:59:29 -0400
Message-Id: <20180503035931.22439-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.17.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8881 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=605
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805030034
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599413924479381086?=
X-GMAIL-MSGID: =?utf-8?q?1599413924479381086?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Do a faster shutdown by calling dev->*->shutdown(dev) in parallel.
device_shutdown() calls these functions for every single device but
only using one thread.

Since, nothing else is running on the machine by the device_shutdown()
s called, there is no reason not to utilize all the available CPU
resources.

Pavel Tatashin (2):
  ixgbe: release lock for the duration of ixgbe_suspend_close()
  drivers core: multi-threading device shutdown

 drivers/base/core.c                           | 238 ++++++++++++++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   9 +-
 2 files changed, 197 insertions(+), 50 deletions(-)

-- 
2.17.0
