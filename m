Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpMwLi3CDO2YzYbGuWKSZvE5IYaATsOveVW0DnRFiUzp4ddDli0XVgGCdKFQ7gMvVaqaKSQ
ARC-Seal: i=1; a=rsa-sha256; t=1527156300; cv=none;
        d=google.com; s=arc-20160816;
        b=aKYoYm3A/TMwMO6uzQIWzNboD5UFbKK0EXFxkYHGfyu8EuzoMpTW0L1dIC14JKFqDh
         eWPD9fFevkNgMnVCAc5F68N5HKJmEVODFWIASxjKImZJ2gfx0mjYf3dJFUlRNx2ZsM6W
         yZJIMgqQiU+86zzydi+0MnvxCdCHwILAnSFe7mI4SvQnFHDC3XGij7H+kSv+7z7gRWJ/
         XHDloCJn6zriDhoKdBJiVK0+U6gJ14bHJwuWEIYUQEa3I9sb/kT6rtteLBgjDh5zRcBZ
         OJb2TLehubeaHcagCR2gWU5SWqDAR4c1lmpZ/wgKAgI93puCi7QICOqq0gz8Rg4MSFTN
         3ivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=MK9XvHJTmGrGdOk6tqeKcpWS5u+pZgG/G9R84c7sk8s=;
        b=jAYqMkKTtM/82U+a4/9xY+4Z0E52V4TKvmVEL8tdtStB3NMvOP9OilB+uDpCDXd5gQ
         WFBV0l329mXMCG8OXsAubOBPZ1rylTksemR8+burHqZWo3fXBh1VsDKwbosctBqAQb6l
         K4cMz7QLd74tkc8iSrT+yMo8fiAL56gE3WRmHJCGwkjAxG3v0ci9AHdqYEluLIrmUiwa
         qYRUcqYWLk/MzROPZH0szT8iK1YSeitZHbVuERAO73Yu5MaMRXQvepzbdXb/PQt5RIfV
         PAK40Ts+nLNoqxhCQgLveWx1gv+stG4Vjwa/4HETOjdBBjfKgxOD7FZEc1tV4s/d786S
         fZYg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=odTsD/CI;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=odTsD/CI;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Antoine Tenart <antoine.tenart@bootlin.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 101/161] crypto: inside-secure - do not process request if no command was issued
Date: Thu, 24 May 2018 11:38:46 +0200
Message-Id: <20180524093030.508867139@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338840351188002?=
X-GMAIL-MSGID: =?utf-8?q?1601339444224995361?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoine Tenart <antoine.tenart@bootlin.com>

[ Upstream commit 95831ceafc0de7d94a5fe86ebb1c2042317cc2cd ]

This patch adds a check in the SafeXcel dequeue function, to avoid
processing request further if no hardware command was issued. This can
happen in certain cases where the ->send() function caches all the data
that would have been send.

Fixes: 809778e02cd4 ("crypto: inside-secure - fix hash when length is a multiple of a block")
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/inside-secure/safexcel.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -490,6 +490,15 @@ handle_req:
 		if (backlog)
 			backlog->complete(backlog, -EINPROGRESS);
 
+		/* In case the send() helper did not issue any command to push
+		 * to the engine because the input data was cached, continue to
+		 * dequeue other requests as this is valid and not an error.
+		 */
+		if (!commands && !results) {
+			kfree(request);
+			continue;
+		}
+
 		spin_lock_bh(&priv->ring[ring].egress_lock);
 		list_add_tail(&request->list, &priv->ring[ring].list);
 		spin_unlock_bh(&priv->ring[ring].egress_lock);
