Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AB8JxZoTGTL6CRLJmDcQoqF4oPUNRQGn+IAeT2hwdZ7lr4ETj55oqx75GBzImgC+PfrypDMd/lKn
ARC-Seal: i=1; a=rsa-sha256; t=1525319982; cv=none;
        d=google.com; s=arc-20160816;
        b=gd0Mdx5gYB6AFqXx6D19wBVbg9lAmbLXGE7f1Eb2pcRavKx4n4mhtQv3O44mgwTVAI
         Q3x5w+1+NLcmBmMOkwFESBbZoLvlQRQhw++azJt1fSspvAhOxwhtQh2MFa+g43kaBHYI
         eC5GTt7Ymvaq7HSZRQD560mMy5oSHRyuVcVPYAF2ewcjWossjTktnME4NnMLXLBABQsR
         PSut5rC3C3bD02DujDGLcEKEv79BfafRVAsuaI5hnGOb++MELRdXWGn+71Yey999fgw6
         XAGo8llIy7YAhrQkzmcaPsPXsGvIFE8wbneItOYjwYguOyvloWPNI8XDO1SpRE5tI1EK
         CQKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=A7/dEoWk1iDkrlpuqltxj8FdRRRpYUXHRc+RH3CAjsk=;
        b=fRqp1zwpnjtpEBmTU0UXy4oIYiLQ7w4fe0jQqYLbSVhibKYsM6SEl7fLpGQiQxpyGS
         isnpJvlbnmSAUkWsmGILPN+0e9Orbk2JSW9S7epB9v680+ZGnGt4pqk1K9NNKfG8DYNQ
         alU5/bXcncY6N0j4I+hutS/twQ0e/VhMmh1Y0O/fW1IfjbYbAk27cukg4eYzj0wtqwNw
         LUUsBze8tzSNCHN7unyQ8i5K/vz+8yBTbPyaiv62xwA4oCdjrIQa9hqt+4ugFCo0ydIE
         un01SFfPG6NGhKy7hT83KBMHAYpjpwhUBAi7PEJ7T8ygFgYqCOow/Po3+ulwZSIYhVzj
         3rvA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=VUQfDchS;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=VUQfDchS;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: pasha.tatashin@oracle.com, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, linux-kernel@vger.kernel.org,
        jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, gregkh@linuxfoundation.org
Subject: [PATCH 1/2] ixgbe: release lock for the duration of ixgbe_suspend_close()
Date: Wed,  2 May 2018 23:59:30 -0400
Message-Id: <20180503035931.22439-2-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180503035931.22439-1-pasha.tatashin@oracle.com>
References: <20180503035931.22439-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8881 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=714
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805030034
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599413925684033451?=
X-GMAIL-MSGID: =?utf-8?q?1599413925684033451?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently, during device_shutdown() ixgbe holds rtnl_lock for the duration
of lengthy ixgbe_close_suspend(). On machines with multiple ixgbe cards
this lock prevents scaling if device_shutdown() function is multi-threaded.

It is not necessary to hold this lock during ixgbe_close_suspend()
as it is not held when ixgbe_close() is called also during shutdown but for
kexec case.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index afadba99f7b8..e7875b58854b 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6748,8 +6748,15 @@ static int __ixgbe_shutdown(struct pci_dev *pdev, bool *enable_wake)
 	rtnl_lock();
 	netif_device_detach(netdev);
 
-	if (netif_running(netdev))
+	if (netif_running(netdev)) {
+		/* Suspend takes a long time, device_shutdown may be
+		 * parallelized this function, so drop lock for the
+		 * duration of this call.
+		 */
+		rtnl_unlock();
 		ixgbe_close_suspend(adapter);
+		rtnl_lock();
+	}
 
 	ixgbe_clear_interrupt_scheme(adapter);
 	rtnl_unlock();
-- 
2.17.0
