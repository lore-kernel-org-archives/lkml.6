Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+GuCFTpWnvAxDz2CvQCgye6NIQSRVeBMO/DviCJkYBtcT+/ynBAYAQwObB57r1La+RJcOR
ARC-Seal: i=1; a=rsa-sha256; t=1523399715; cv=none;
        d=google.com; s=arc-20160816;
        b=gM4y/c7N4dOrJg6ERs5W4GGrueQtv7oA7StR+rBXbbZvAFHhmz5mpqzvtlD5qZBs+M
         EPOwia78gqnMhk3yYkdgXC0meKK6hQu3AjdDr2ylAQagqUdXmNPWY4EJrAB8MTf1MjMH
         1D+8dvMRwH8VeTpySp09Bwi/XVF9R5/+f7D6kDy+YnaHXLuYk47AhBIrz1ixYAZ9K1pi
         HgNZc1HA1gKKXDktk25O10+FQyTrva+O+XwX52ArOjKDQzm41J/9mfH6GQSFJWVROGs7
         KhH+yXO4hWDBLHRJkhQ1kJ9WKQr22y3jMwMH6l45eTJDgEN9TCYQW5+xD3k4iZRrL8UE
         eXtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wp+/TY2Rw/J8sCnCC+38uFqrVpSOkoKs6phpFbhU3fw=;
        b=NuNmdgAJlZrks6Fw6RHDSMIXD2SM15QDYaRyqTVcrBCEdO3RedxU+BGfSDPMA5Ox+J
         lAJWb4BzMWuOr2mExAHh4PIKRRLrRf6kLrvpPDPqp1EfZyNqKJ8iRFjaTV3t8O9xX5B1
         XYXamDEEEg5Oyu/oHGcabQ5dms6VVE4P2AEcus0323lZF+4ju+a5fexRPrkHi/SwAp0Q
         JyXEbgb8Bo+le2HN7l1tMJPN0liEB+rMW4qKwcPfBC8GjUqRZhG641RrIv9FPQTkyFJq
         FNB/67s4dPEcwYLp8bncBjVfdgPvtJDjXlUJzlpKvaC5xatOGVKK6RZEWcEcndR2zY6n
         DHTg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Sebastian Sanchez <sebastian.sanchez@intel.com>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	Dennis Dalessandro <dennis.dalessandro@intel.com>,
	Doug Ledford <dledford@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 038/138] IB/rdmavt: Allocate CQ memory on the correct node
Date: Wed, 11 Apr 2018 00:23:48 +0200
Message-Id: <20180410212906.508110410@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399930853720496?=
X-GMAIL-MSGID: =?utf-8?q?1597400380080097298?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Marciniszyn <mike.marciniszyn@intel.com>


[ Upstream commit db9a2c6f9b6196b889b98e961cb9a37617b11ccf ]

CQ allocation does not ensure that completion queue entries
and the completion queue structure are allocated on the correct
numa node.

Fix by allocating the rvt_cq and kernel CQ entries on the device node,
leaving the user CQ entries on the default local node.  Also ensure
CQ resizes use the correct allocator when extending a CQ.

Reviewed-by: Sebastian Sanchez <sebastian.sanchez@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/sw/rdmavt/cq.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/sw/rdmavt/cq.c
+++ b/drivers/infiniband/sw/rdmavt/cq.c
@@ -198,7 +198,7 @@ struct ib_cq *rvt_create_cq(struct ib_de
 		return ERR_PTR(-EINVAL);
 
 	/* Allocate the completion queue structure. */
-	cq = kzalloc(sizeof(*cq), GFP_KERNEL);
+	cq = kzalloc_node(sizeof(*cq), GFP_KERNEL, rdi->dparms.node);
 	if (!cq)
 		return ERR_PTR(-ENOMEM);
 
@@ -214,7 +214,9 @@ struct ib_cq *rvt_create_cq(struct ib_de
 		sz += sizeof(struct ib_uverbs_wc) * (entries + 1);
 	else
 		sz += sizeof(struct ib_wc) * (entries + 1);
-	wc = vmalloc_user(sz);
+	wc = udata ?
+		vmalloc_user(sz) :
+		vzalloc_node(sz, rdi->dparms.node);
 	if (!wc) {
 		ret = ERR_PTR(-ENOMEM);
 		goto bail_cq;
@@ -369,7 +371,9 @@ int rvt_resize_cq(struct ib_cq *ibcq, in
 		sz += sizeof(struct ib_uverbs_wc) * (cqe + 1);
 	else
 		sz += sizeof(struct ib_wc) * (cqe + 1);
-	wc = vmalloc_user(sz);
+	wc = udata ?
+		vmalloc_user(sz) :
+		vzalloc_node(sz, rdi->dparms.node);
 	if (!wc)
 		return -ENOMEM;
 
