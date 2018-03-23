Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt//z1N2kPVIy5Wps+2qfUkJoagrrkCckq4gmRoH6hpTSklo+5VEk3lhmkpX1o/2LpWAJE0
ARC-Seal: i=1; a=rsa-sha256; t=1521800223; cv=none;
        d=google.com; s=arc-20160816;
        b=qJI7O2spA+pspIbb/DtixwSFhsVRPfsrT1Z8wM9fz5DLdRBWr7s4Hl+QT6Kk7uMJzY
         QPkJIoIo/Bm6OiwCQBlr7v/fKXdHOVGXAOEu7T9fYonauM+Wi/lQnq1K4lMnY/LM5jx5
         W87VAr6Zd9XAexTdOVZxidPvuyGZU7rAUoWbYBkdyUd73a5P3wS05aDpAO9eZybWHFJZ
         TLSMIiOHlSWq81kSQcNZv4m+oxKwMWwxvLA37Nx1lxth2bsdE036wDeNTkng8ETGB2v3
         lqsOaZn26udcGc1yxE0E4g6vf7r95408CPgOuObDWhK+7U1r0ElEw+S78CwbfuA4WLkJ
         xB4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kgyQB6lDAME4hQk8bGzUI+4duTLp8UC/11pkI4f+Z3I=;
        b=IV7Fu2IwZZbrRpI9vU3IVmpJ81uJ9AK194sC10aPFIPKgnk1sNU8ZKi5G3OH6j1Dwc
         lx2zYxiMUAzarvHQOn7UXSB53jJhOwBmaPqUyx86q5+69mAku+T31IjB47D/pj74VVT1
         bsO0cEoplvvtHUXeViG5g6W3zwABHUV/La/TsYsdQAa1EFt8owIWhyTxW82+rF/WKFoE
         7G7/WA+VB3+2CkDbttSDT9p9nWPLPMnyGnIuBEfq3Xd9zTp+J3u28nHNnNijUJ6npUCU
         DXXBfxg9IkptK1uksg5FFaYCe+9/pMFsNCjc3HRLHwl6/HhuDmOZbEzPPyqBMXJdy9XL
         pVKw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Erez Shitrit <erezsh@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 83/97] IB/ipoib: Avoid memory leak if the SA returns a different DGID
Date: Fri, 23 Mar 2018 10:55:10 +0100
Message-Id: <20180323094202.165259339@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722007480729726?=
X-GMAIL-MSGID: =?utf-8?q?1595723190682380470?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Erez Shitrit <erezsh@mellanox.com>


[ Upstream commit 439000892ee17a9c92f1e4297818790ef8bb4ced ]

The ipoib path database is organized around DGIDs from the LLADDR, but the
SA is free to return a different GID when asked for path. This causes a
bug because the SA's modified DGID is copied into the database key, even
though it is no longer the correct lookup key, causing a memory leak and
other malfunctions.

Ensure the database key does not change after the SA query completes.

Demonstration of the bug is as  follows
ipoib wants to send to GID fe80:0000:0000:0000:0002:c903:00ef:5ee2, it
creates new record in the DB with that gid as a key, and issues a new
request to the SM.
Now, the SM from some reason returns path-record with other SGID (for
example, 2001:0000:0000:0000:0002:c903:00ef:5ee2 that contains the local
subnet prefix) now ipoib will overwrite the current entry with the new
one, and if new request to the original GID arrives ipoib  will not find
it in the DB (was overwritten) and will create new record that in its
turn will also be overwritten by the response from the SM, and so on
till the driver eats all the device memory.

Signed-off-by: Erez Shitrit <erezsh@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -724,6 +724,22 @@ static void path_rec_completion(int stat
 	spin_lock_irqsave(&priv->lock, flags);
 
 	if (!IS_ERR_OR_NULL(ah)) {
+		/*
+		 * pathrec.dgid is used as the database key from the LLADDR,
+		 * it must remain unchanged even if the SA returns a different
+		 * GID to use in the AH.
+		 */
+		if (memcmp(pathrec->dgid.raw, path->pathrec.dgid.raw,
+			   sizeof(union ib_gid))) {
+			ipoib_dbg(
+				priv,
+				"%s got PathRec for gid %pI6 while asked for %pI6\n",
+				dev->name, pathrec->dgid.raw,
+				path->pathrec.dgid.raw);
+			memcpy(pathrec->dgid.raw, path->pathrec.dgid.raw,
+			       sizeof(union ib_gid));
+		}
+
 		path->pathrec = *pathrec;
 
 		old_ah   = path->ah;
