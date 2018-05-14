Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AB8JxZoleS12SgFX/R8ZCJQ77Vgo7VIyVLwZRY30JNGoL2Ds/trnVZKiwQhCv1zx0QfQ4veL/s33
ARC-Seal: i=1; a=rsa-sha256; t=1526326987; cv=none;
        d=google.com; s=arc-20160816;
        b=qYjXFiNr7+3F61MmT6edetoknHJ7ABn0J6/n7uwu0hSsOLd2ody35wNyZcQXxisNTX
         t0vo3AYmjSKXdB7CD850IGdahzynUEB/qlCwLkLpJjHbuPNCfMgQoAEc6iM4uPEzsqKL
         AV2HxmIbq4EvXEqNeQmdfR/VC0X3vbfMBIfbAAGLC6OAPRIzDJm5u3w5QUV2+Ugc5jbJ
         84uvxadWdsw0AOnPmLL4Ah+NnuZYPYfRoIanpFWRnxqQ4seUZ7YKjeEhgJpyHlKIh//M
         nP/4pHCwFZ2D0mY+PZAk+ofQen5eTILlOXzFabpvlnfnvmYv/hTk7PGT6+Mi12aUwCat
         1F8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:to:from:dkim-signature
         :arc-authentication-results;
        bh=R/8xJXLNwx7jI7BMaS4HzN6TbAXrUDQGY3w2mVhvCOw=;
        b=QQnUWq+P7xAPDx+ZaqZVw30o28XwBZONeSvx4qKie8210S7baSVA+27nDqnJ8X+OgQ
         LdfBJJ8rmxhSDCHpmObZAMaYnXiK1XeQz0tqWTvKe0htGbmiSGhKz7WPGKGdUH659ZP3
         l6VZcB1/bAS4L0xnD/CXhvSA4ZIR28dqCCms9OtTYjpOjbZuK0+ccU7j8OaDQttJt6wR
         EzRPeerQ+iSkJop9FgdUZSJvh2tHQUro+Yz+HcfN5cL+dLKKdhOT9Kdvo6UOu5IWbnJj
         3ZZoIUU/tWuSPaBQ1v/UeWojap7XodvCYDk5ggVs9iSKvzUGOP/HVF2brYPfW2rHMrS9
         DPoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=LR0CoI1X;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=LR0CoI1X;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: pasha.tatashin@oracle.com, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, linux-kernel@vger.kernel.org,
        jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, gregkh@linuxfoundation.org,
        alexander.duyck@gmail.com, tobin@apporbit.com
Subject: [PATCH v4 0/1] multi-threading device shutdown
Date: Mon, 14 May 2018 15:42:53 -0400
Message-Id: <20180514194254.14748-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.17.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8893 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805140198
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599821267114231354?=
X-GMAIL-MSGID: =?utf-8?q?1600469846995920460?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Changelog
v3 - v4
	- Added device_shutdown_serial kernel parameter to disable
	  multi-threading as suggested by Greg Kroah-Hartman

v2 - v3
	- Fixed warning from kbuild test.
	- Moved device_lock/device_unlock inside device_shutdown_tree().

v1 - v2
	- It turns out we cannot lock more than MAX_LOCK_DEPTH by a single
	  thread. (By default this value is 48), and is used to detect
	  deadlocks. So, I re-wrote the code to only lock one devices per
	  thread instead of pre-locking all devices by the main thread.
	- Addressed comments from Tobin C. Harding.
	- As suggested by Alexander Duyck removed ixgbe changes. It can be
	  done as a separate work scaling RTNL mutex.

Do a faster shutdown by calling dev->*->shutdown(dev) in parallel.
device_shutdown() calls these functions for every single device but
only using one thread.

Since, nothing else is running on the machine by the time
device_shutdown() is called, there is no reason not to utilize all the
available CPU resources.

Pavel Tatashin (1):
  drivers core: multi-threading device shutdown

 drivers/base/core.c | 292 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 242 insertions(+), 50 deletions(-)

-- 
2.17.0
