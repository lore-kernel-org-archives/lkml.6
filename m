Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49aOGOd+IdwDKA9ILEiD4N0aMe9gY++za2Vzktonz8CaYALrkVzssp+gSg0HHI+t211n5sM
ARC-Seal: i=1; a=rsa-sha256; t=1524652747; cv=none;
        d=google.com; s=arc-20160816;
        b=hPcEwzmJKUQUnXd3ONQ9tX/DbTLVryKO10KOcxhKWV7hUJ+Dw11oy0f01JZHfIuUWi
         XYP7tGhJf56w6bwEVoXi4Cd5JdeHCy9ZHMX1EJmhs7MPQ7KyxcsxRgrTSrjscjrO9JnA
         2841dNumhar5ONZf9OFZtZgM74mHtvb/+g4xJnVKSKPZFxBYjNgCujrvS8QVTHH/xjD5
         GgeNkvfhY7vxkNxY5+7q8/Nnx3qRXlLuKOdBgAwDo0vN9VbkextaijSpMMdoACEq4jAq
         mtP35ewZ3I/Vn911nYaYDrH2TO1d9PCId/E/TM/S30K1G2knmCNFP304mgwbjBoQEGZp
         5/+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=liZQmUBJXuczseUeMXg4T6EtSA0oSyz6HwIWO1HITOs=;
        b=gZRx1PSLU842ZiiCjbtv+qjqxk28a3ybsJYD/Q+j5dD2kHUB4vMQT/CSDf1ZaKVa6c
         rs7lvWQdRCKcbdzbtCAb6Evny627DNxTasldN1S5svfqEzB8gPGqfP5jld3Kw8Bhd0AT
         sKxuHL1KgunY2f/IzYYBdGKdFL9Wm5tRbFBDA00Wkg/a9Y2ZETRdMVQlD1+NwyA4Ke/Z
         tQN90TyKHxzSxSWqlFN5UVZC9eQWNfs+gtI6GRm6xzsRbrk8cShMj3mo+JWmBjeM7UIq
         xvkTZ3X12E11kDSi9QcHbdoS66at7ke8kQ8rb6j5t1Te7tqCUrnMd1OEYmWVAyqUfoY0
         WAgw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jan Chochol <jan@chochol.info>,
	Trond Myklebust <trond.myklebust@primarydata.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 054/183] nfs: Do not convert nfs_idmap_cache_timeout to jiffies
Date: Wed, 25 Apr 2018 12:34:34 +0200
Message-Id: <20180425103244.718591963@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714279535347194?=
X-GMAIL-MSGID: =?utf-8?q?1598714279535347194?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Chochol <jan@chochol.info>


[ Upstream commit cbebc6ef4fc830f4040d4140bf53484812d5d5d9 ]

Since commit 57e62324e469 ("NFS: Store the legacy idmapper result in the
keyring") nfs_idmap_cache_timeout changed units from jiffies to seconds.
Unfortunately sysctl interface was not updated accordingly.

As a effect updating /proc/sys/fs/nfs/idmap_cache_timeout with some
value will incorrectly multiply this value by HZ.
Also reading /proc/sys/fs/nfs/idmap_cache_timeout will show real value
divided by HZ.

Fixes: 57e62324e469 ("NFS: Store the legacy idmapper result in the keyring")
Signed-off-by: Jan Chochol <jan@chochol.info>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/nfs4sysctl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nfs/nfs4sysctl.c
+++ b/fs/nfs/nfs4sysctl.c
@@ -32,7 +32,7 @@ static struct ctl_table nfs4_cb_sysctls[
 		.data = &nfs_idmap_cache_timeout,
 		.maxlen = sizeof(int),
 		.mode = 0644,
-		.proc_handler = proc_dointvec_jiffies,
+		.proc_handler = proc_dointvec,
 	},
 	{ }
 };
