Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AB8JxZpzbzpz9Q5WA3pfzqcs6nrTz77jWlajLxE45weMySWcWH6ONIM91D6nOs3VOQxIAbv1QNkH
ARC-Seal: i=1; a=rsa-sha256; t=1525534851; cv=none;
        d=google.com; s=arc-20160816;
        b=S8nZR+88bhcaF0Azcp9uaxvwCtzk2vky6PF3IsweWgJxuYB/wTd1DL9eFUhJK9lyrI
         AxJaZFKmMgleLRVNFPVgmEvvSZ6M8qI59RRXhlDkVqgIU7fFnbyFl1Ta+Vh7OHI+iV6q
         2W2cTprtiwMVRRXcDuq8ABlB2AGBf8AP7+jkpCcAROUZzbyQWmVK58Z0VPSnw0Tl49MC
         Vcmi7S/RjKPSXboEj1q314+6trAGxP/xpbnxei+8kpaEa2yVHt9EKj3Q5tzB29VlyxaU
         9xcIn3Aj3XCdgaW1ty/q9+PyXs4tZwL4djrY86WQSI7A1HxM7JWWvm8XIo/bUI/MO+9+
         DlqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:to:from:dkim-signature
         :arc-authentication-results;
        bh=tUNkougXXVEpV9NokOp656mu1i3zN2B/BaDZFgQHAk8=;
        b=IOeCuTSKipw/DhPBAJA6b80cbJSodIneSo8hHOwNU8MUkJ95/p9sn+Hs0GESwjnYv9
         pLl2IphauZsR6obKmVG/KMWEVRVpmC5FjezPdZfq54czY5o5x95RQg52aGVHHAv9XISO
         LK9IxLrSafxxFrpwmL/NBkhJKM59oOX2UZm6L0+bt83QGvUrH6Gu3M041TWaLjtGbyxG
         ZHqdodf56obFj2kHI4FkPP6bKuhcu3UwgEXd5p5LXhO3s92yCiYjOYBBEWzj92J4oMmv
         EfmIFjLtcJHW2yWjFk3alLCBgKciqZhmNgi1DHJ7jIl/YHY+L1xnNmLmZdMqG+8Xl70r
         Jahw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=uqV8oKZ3;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=uqV8oKZ3;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: pasha.tatashin@oracle.com, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, linux-kernel@vger.kernel.org,
        jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, gregkh@linuxfoundation.org,
        alexander.duyck@gmail.com, tobin@apporbit.com
Subject: [PATCH v2 0/1] multi-threading device shutdown
Date: Sat,  5 May 2018 11:40:39 -0400
Message-Id: <20180505154040.28614-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.17.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8884 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=916
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805050154
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599639232499348944?=
X-GMAIL-MSGID: =?utf-8?q?1599639232499348944?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Changelog

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
