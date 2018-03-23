Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu2Y74miqUPDfQ53cZBblFBYXT1iW92vLRI0rMcOi9/YWhNc8f6Fn+GOIPRHK03zC9fCCNo
ARC-Seal: i=1; a=rsa-sha256; t=1521800231; cv=none;
        d=google.com; s=arc-20160816;
        b=XBXgtubzgfBgURdmFd3qxGhLuaYcYg62j1KuFgDAnxcUVBGGYQcNXRAolNOxVR6aW5
         /tnquoAV4TVMyh2H7f4AEEssQ9/VhYcuA2MlXh97/gVPeFCiigM1ZOpCfJr67TgXDvxY
         WsARN2d/ZGmc15eVziAK0sNDgE1jY5YTfIYtZ95BlG8mLicN7oE55b+5KRkgbTwyed1s
         Qka9oiPESQ7rjXhIMahUTnu6LgR9wFbW2h4sNRuiPuEpk5PJd58a3/K2Dq7oUZ0nokoh
         7eS+8chmbS7PyLlmRoolaU2/xE+SCMienFxwG7HU4K5DZIOjr6PuFGarBWZpjKWgEeYe
         2FiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DB5D5cxWCx+BuCMHGLYAd2k9bfDA8TyHn3ER8rpB7s0=;
        b=tlMW5W3cIQWfj0ct0qd9ih9WF8VDrbrLBjMXwQ5/Oa0BGzprUUw295MFXtmymFdINI
         QqffsqsAq1qW1+KTjMWU+hdq9fHjB+/eVtWlpBYwocLqVvdiETVyvBWkpLMIWfxnPkoP
         8ehLA7xc7Ba0P0s1+8XAdmciYdvnz70DHzRKocPFu4CBNbqt8nAUmR6ZmqPxaP6hxZSX
         WgBkE5knR5ROwxTmfDt3hroVflRjDY0DrEV5XhtcuhKi7RVUfLt4qOSvUiHe981KAxzR
         VY/UkcDUAREYT52DZtMTc4q/n1WkHieKJfn8eBuiJzoxTMBwl4HccyWKO9+0JYzT6jH2
         FVhg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Benjamin Coddington <bcodding@redhat.com>,
	"J. Bruce Fields" <bfields@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 94/97] nfsd4: permit layoutget of executable-only files
Date: Fri, 23 Mar 2018 10:55:21 +0100
Message-Id: <20180323094202.722483001@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722103920181598?=
X-GMAIL-MSGID: =?utf-8?q?1595723199711620495?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Coddington <bcodding@redhat.com>


[ Upstream commit 66282ec1cf004c09083c29cb5e49019037937bbd ]

Clients must be able to read a file in order to execute it, and for pNFS
that means the client needs to be able to perform a LAYOUTGET on the file.

This behavior for executable-only files was added for OPEN in commit
a043226bc140 "nfsd4: permit read opens of executable-only files".

This fixes up xfstests generic/126 on block/scsi layouts.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4proc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1245,14 +1245,14 @@ nfsd4_layoutget(struct svc_rqst *rqstp,
 	const struct nfsd4_layout_ops *ops;
 	struct nfs4_layout_stateid *ls;
 	__be32 nfserr;
-	int accmode;
+	int accmode = NFSD_MAY_READ_IF_EXEC;
 
 	switch (lgp->lg_seg.iomode) {
 	case IOMODE_READ:
-		accmode = NFSD_MAY_READ;
+		accmode |= NFSD_MAY_READ;
 		break;
 	case IOMODE_RW:
-		accmode = NFSD_MAY_READ | NFSD_MAY_WRITE;
+		accmode |= NFSD_MAY_READ | NFSD_MAY_WRITE;
 		break;
 	default:
 		dprintk("%s: invalid iomode %d\n",
