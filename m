Return-Path: <arvind.yadav.cs@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520747779; cv=none;
        d=google.com; s=arc-20160816;
        b=aLlws/aF6Uh4+GkfN8eKDitk1Am8k946vGAcasXLokUWsaMKl3vc+AI6Dk68Gkzja/
         3+AJjmZkoYUSK1hMl1lCngahz4jsjMOX6x2Ki7pWutSMz6dvbAu4T8/a/de9rGComqOH
         50AfTZkdS/QTTXSyC652xSWay0p/vQMQ8kR5R1OcM+LsaNls8wHlhJP2Vl4z2WY8KAsg
         kxL852FQ8aM2pDa2CYTvILUnviyBjinrDAHJuYT89vNNi+B0FM/bySpggvg05Sbr98t+
         2SFQhq9el85bQ5QFijnz/DqqsEk6mCSzS3SxB4Fg/zRMXYK3PMZjqJrHnSZ92xfrkW9g
         Hp4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=8rotcdPDVPzk+xgtW7Kp1q9KE228hCFS45Nk+YqJPdM=;
        b=CzpsY2P8qVmG9qMxVVlyqO5LsRsWJyf4TjBFmwd4FKf8av9Aq8bU/o7/3Y6uCWRCaR
         0DIzrzOT9+/QVQ7S6v3j6IZM33+YV9G5xYaM71XHn8BSFD/lD/tym3ib6QRiSQOHEDEw
         wZ05KY6i+E32m9vnEzhMAiRHY/iIGUZ3wYJkZB0nm2upmKu8uNbwm4k1Y5fRbg4Yynq6
         x7d8HKedr59xk8M0ysIwIV3qaQxZL7SwQJymjn9VRt22aeRJONK2v9HUu+jhUW0ZUDGS
         3s/MggP3SJ2cEe92W2zKZfJ0xmRvOUdXQX6syTf4tGp585Jg9eOOipvLXgOnSGM4Oa4x
         T4PQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RWQ+6CsK;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RWQ+6CsK;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELspg3pVQb/M4wZu51a0/b9425dwjfSQ9gvs3zGmariLmredMBib6CmKjBRRpMpgjB1glxNBqw==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] driver core: node: use put_device() if device_register fail
Date: Sun, 11 Mar 2018 11:25:50 +0530
Message-Id: <0511fce261db8e05ebdc58aa50558e208ae99ac6.1520747459.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1520747459.git.arvind.yadav.cs@gmail.com>
References: <cover.1520747459.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <cover.1520747459.git.arvind.yadav.cs@gmail.com>
References: <cover.1520747459.git.arvind.yadav.cs@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594619623976795792?=
X-GMAIL-MSGID: =?utf-8?q?1594619623976795792?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

if device_register() returned an error! Always use put_device()
to give up the reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/base/node.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index ee090ab..c5f81fc 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -315,7 +315,9 @@ static int register_node(struct node *node, int num)
 	node->dev.groups = node_dev_groups;
 	error = device_register(&node->dev);
 
-	if (!error){
+	if (error)
+		put_device(&node->dev);
+	else {
 		hugetlb_register_node(node);
 
 		compaction_register_node(node);
-- 
2.7.4
