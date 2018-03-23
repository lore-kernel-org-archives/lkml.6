Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuPzZBF2iM3AesS8MvpBpRhpGLH/ZF9z64sorNX+aiAEXiCaN5ux5Tc/E7maWJzQyPPKoSZ
ARC-Seal: i=1; a=rsa-sha256; t=1521800401; cv=none;
        d=google.com; s=arc-20160816;
        b=JSATaIU7knkpSGqAb/jbewkOILe+zHCD++IVEc1k8vopvsIi2AwrqSlbBj1lohUezH
         Y38R2VU3clIDGr5k9jqbyQjgOwbFNP577whQZfZDt54JJ8wR+wDTwG69XO3pc9WUDoMT
         yf67XCxgHvlaKR2mZgpw38VsG4GOZ5RhcIiWEQcEZltUYCbki47fg16/ZwzDWS2w+ve4
         KwpcelvW9tdeYloBPERALpFDuUL2abtgPEnjB0MWY9xS+PFuWOzxQi/AxAOyTbkMTw7u
         ulXre/E2UHO0dcnlx1xC6jHK+d12hKsGV+4Kuq+qGn+yejRVI+pW/5a/aVR56FbwZJC4
         x9sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=u38D1Q1/OaZCSbWSFtTuLI1BVKhqK9/10mc4VuVuB6E=;
        b=APTd00TZ7o7B596gIRmqa3jhAdMtVzoFfTIloC1SiUHH9eOtkiYpEbREYoXbliCqvb
         qyh+Zo+EJ9k0w6MB/GYqiCSih7TZZOKiJLRvoYvUea50gJDCjRGkM6HQN7C7s8Hh7O0R
         uj3gpY7qJ0M1TkrSNUQz5caOgEbgIk0kQgaX/KxKI7yRoNISLops9jMgi24FLOm1LAga
         OAWAIh0/jEqWhAjRvskGj8ag0oKCpcJ59Me98ItMY/7/a2fg3mwX//cpZz5fn/WL+PBo
         pCqvFx85njRJXP6FXcTvd1VvMxeXqxuNoQoVg0TPAhNR9iFXUNlF8Qns3g7MlKStc8ad
         9Oww==
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
Subject: [PATCH 3.18 41/47] IB/ipoib: Avoid memory leak if the SA returns a different DGID
Date: Fri, 23 Mar 2018 10:55:32 +0100
Message-Id: <20180323094249.870367274@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722007480729726?=
X-GMAIL-MSGID: =?utf-8?q?1595723377795453515?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -488,6 +488,22 @@ static void path_rec_completion(int stat
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
