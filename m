Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48cQ0a/j/hG7qRaVZNb8FnZ2eGXCEpuFyUadhq+raOpRRDQSPTNRZDEyPSBYrTd5LoxVtFR
ARC-Seal: i=1; a=rsa-sha256; t=1523473014; cv=none;
        d=google.com; s=arc-20160816;
        b=oDOE9qAkDJ9sw7Swukhug8xbIGpLtDtkeL6lounGjEaJQ+V/GugVWLZiqXPm9+fm8X
         c2/EgqOvbtLrTdAfYMpMnGKSPLQxvBwkItjrU3VCIPNjPHbRZTWlIhzcULpX+2HvY57N
         xBH7XTKv+YEay8loXfm8GBFnyIej/UduS5C66wHMN89/+5SEVoJ96zsW9B4oaKxYOBHu
         dxb4F9Bg4Bp3fjP7Ii1CF5D7Q/n/4kznPZgZnIV9nZth6BHDUGV8XqFgyTOqKpAJ2rA2
         5xSCeFbIqAqGGg1nC4mXZP2mLdokqP7alN7cE4q0wcynYeelasmAtwaus0Yq9b3lp1Zo
         nMDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uvbv5AAdTML9Xnz/eM5I4dpDasiizIxaw7imyOhtW2Y=;
        b=LcodS694O51+gvPJPZYron8tBTH9HD3gVHyQsbTQfsFhYGmoTeukwMynsHyLH7YXn3
         2JLPAFHZFmy5Y9iFuClePGG4E499LJBuhG4ovlifRMSB+aPPQhZVeaPs99Upp6nvztjJ
         HphjcaXAqpr8VNbLkvVseMcJhm5GzsS7v8NQxY87ydmELB9mm9AEEe1DCS0pLXAXBMEd
         OvmvYuMaoeu6pBeXv5IyKQ0jNYuToPVkCPeOedWwSLNL1gPG554zHntB/lVa70c5Ni75
         u9E50Pq4tx6S95anYp8nit8hb1QQnntF5JSZ4fXa0AAg/oR59ylrKneOeiAy7FjBQnyY
         8irA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Jens Axboe <axboe@fb.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 097/310] block: fix an error code in add_partition()
Date: Wed, 11 Apr 2018 20:33:56 +0200
Message-Id: <20180411183626.402145388@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476139969691984?=
X-GMAIL-MSGID: =?utf-8?q?1597477239892686125?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit 7bd897cfce1eb373892d35d7f73201b0f9b221c4 ]

We don't set an error code on this path.  It means that we return NULL
instead of an error pointer and the caller does a NULL dereference.

Fixes: 6d1d8050b4bc ("block, partition: add partition_meta_info to hd_struct")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/partition-generic.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -321,8 +321,10 @@ struct hd_struct *add_partition(struct g
 
 	if (info) {
 		struct partition_meta_info *pinfo = alloc_part_info(disk);
-		if (!pinfo)
+		if (!pinfo) {
+			err = -ENOMEM;
 			goto out_free_stats;
+		}
 		memcpy(pinfo, info, sizeof(*info));
 		p->info = pinfo;
 	}
