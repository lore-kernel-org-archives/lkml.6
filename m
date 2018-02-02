Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227c7FjI2VJu0ZI1vFAO+EaZkrQ823zuZq0cu73jzyGKCmfHYBBLlYanTkXWHy5Mj1GSZKGV
ARC-Seal: i=1; a=rsa-sha256; t=1517591078; cv=none;
        d=google.com; s=arc-20160816;
        b=QRSZOKQLvzbaeXn9CLAgGgr+irOGWCaMNcnofraJvGVIzOaOMv+HG9ju2a34ivJWYb
         QlTjhoeLpsGhsxfs+yyi450eGFw4MrzaSkkYwsvFhAQiU5gfK8S2bv0lORmYWHZmd6UZ
         hr8MaDoXvLd7JMB65pCZ+iXv6uFATvjoT4UcQpIX1nGN85KdUL+BCe1vynlVtbtVHtpR
         GW36j4Qa6YIMPYxSdnP3V5Qv27a8bw7AHnQT2O1GYtZ1Qu7vlZGkRPedOL0v6rmlifJl
         bfEm05dxtgKkcPri3cw68eMD7QUXd9J1O1JhENO3Y01XNjvPmCHd+p7gFGEmO+hIhSux
         K6BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EGTuN8IfS5Oj5N5KaqvWamWFOQMgMrcQtj2C3ks1ffU=;
        b=wySKUvv/77kYjMEvgAnaiQQs5XqlOS79gS53h3pUuIkNJb0/3XIOVUtjkABSaP3YMo
         2i9QErAp+G+ugGUI8o9GY6ALpeUL7NwK2be68q9P+L6oXMPoSAY3BvAzObBhQs2w/SUa
         5CKM+jW88L4iaD+KYFy9X/txyealSkw/aGhuXBZlnc0xYNhGzevk0I+1QV+uS9aIhuZ2
         o+/ItF+u3LUVkz7+X6nmHQtje8VaNVwwRqw/1jXzSnfRBcWhECGbQ4ekhMaPQC4GN8+f
         PQbeUJU7h1bEL1b+30afrXMNIqah3UUrsl9uTJ2V7VyTGu+dEHiRIxBRsj3T28Qy4cHc
         Z+aQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vasily Averin <vvs@virtuozzo.com>,
	"J. Bruce Fields" <bfields@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 43/86] grace: replace BUG_ON by WARN_ONCE in exit_net hook
Date: Fri,  2 Feb 2018 17:58:03 +0100
Message-Id: <20180202140826.345747225@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309358674707017?=
X-GMAIL-MSGID: =?utf-8?q?1591309582916739555?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Averin <vvs@virtuozzo.com>


[ Upstream commit b872285751c1af010e12d02bce7069e2061a58ca ]

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs_common/grace.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/nfs_common/grace.c
+++ b/fs/nfs_common/grace.c
@@ -104,7 +104,9 @@ grace_exit_net(struct net *net)
 {
 	struct list_head *grace_list = net_generic(net, grace_net_id);
 
-	BUG_ON(!list_empty(grace_list));
+	WARN_ONCE(!list_empty(grace_list),
+		  "net %x %s: grace_list is not empty\n",
+		  net->ns.inum, __func__);
 }
 
 static struct pernet_operations grace_net_ops = {
