Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AB8JxZrarY8pbjNh+3TukoOcBy+UYaIuCMxD37VDm+Vqqg04rK12lN9oi0iDULBnklB1/0VXcZFZ
ARC-Seal: i=1; a=rsa-sha256; t=1525708453; cv=none;
        d=google.com; s=arc-20160816;
        b=x1o+4dpxeboQOTU1RkDy602zDuFxTCsss6B8GhfljVSRg7lZBw3H4NsI/oBzCaMRMd
         fqCxWCOigUxVTzhnRgf6IyQjMIoEnSvwrnPqkm66/4nltiaS7RBABAS53k+rJO2+B+/S
         2pjf/Z0BKInyLGWq3sO2quDtt0H9BFsUpZKNg6B1ir866baAQo3yoio1pqCQHtvIv8Rq
         k8tO+fnzIZGXUik+P2AebtYP7m9oIgWiH0eBnB6s0pur0ysc6ObWaiDVFcJrQUYcy7Js
         bphA4SQEBr+PkVwfcXofj6zH2BO9qWC0Hpl717ll9z0OQFALbkWRFcQ6WJlYfuYWucgV
         ubIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:to:from:dkim-signature
         :arc-authentication-results;
        bh=RIWByFSkhRTNh2mfZgd+oABBmGamAUaBpVbUN4a6n5A=;
        b=cS3vBdmIYDDNycmWZoBEGsdXAUpE4YBkZvZuSziJijSdaX187S50tMU1fMUyYx/k9t
         tiFZDquvXaBbYVudv1+JKtxcfhoWXU5mXzhXnHcFr5dNGMZmSr1Zi2uYMbI9MRBUT0GJ
         ZezITIBGo5+KNPwg3pcKpOKecV8/nWffHoKX0nHIczydNrMZRWRxqdTiC+uDB7rRjIGX
         u0iPyZZjQ+fbcUA+ZS+VQQKWOCb0UzlsmOSMN3WVhHvloEj98bimUX0Mjmtx5bVkRsfz
         0Reyjgd3dgKNw0w5z/SzyxYnKTSVeZhqjA0OIg6apHy5317TvLussyVZyPYbOYGMtLqE
         4Q7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=nwVeiQQv;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=nwVeiQQv;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: pasha.tatashin@oracle.com, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, linux-kernel@vger.kernel.org,
        jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, gregkh@linuxfoundation.org,
        alexander.duyck@gmail.com, tobin@apporbit.com
Subject: [PATCH v3 0/1] multi-threading device shutdown
Date: Mon,  7 May 2018 11:54:01 -0400
Message-Id: <20180507155402.10086-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.17.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8886 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=971
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805070161
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599821267114231354?=
X-GMAIL-MSGID: =?utf-8?q?1599821267114231354?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Changelog
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

Since, nothing else is running on the machine by the device_shutdown()
s called, there is no reason not to utilize all the available CPU
resources.

Pavel Tatashin (1):
  drivers core: multi-threading device shutdown

 drivers/base/core.c | 275 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 225 insertions(+), 50 deletions(-)

-- 
2.17.0
