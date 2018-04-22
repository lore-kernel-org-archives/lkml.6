Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48MDJYYMnTzbvogKgmYTINQFtEyBmj8Ob0afn2vdQRCQPVS5C25Le+lH35NNTnwiMTD2yrX
ARC-Seal: i=1; a=rsa-sha256; t=1524406489; cv=none;
        d=google.com; s=arc-20160816;
        b=he33zVx8/NREcuxtYpHScn8BgXE236UVByNVHQcEM2w2kh1kaJWyQwnumAQap+Y1ee
         2HkHo58yTigI7Uo97iEP30EJOkA0GdLNTgRz4l3OUmO+PMUXZbA1aCejg0+jNbaWJb1Y
         l0sU8JgJN8NwCecu2ymR2mA4/Bb+unSdWsb5tsmleVd+QQrikHYOJPkR9x2nBTeWTwQ2
         /z4dsFrj676ON5xdOpjHJETNxdvhk+2OBsv9Mmt6pmV0pbulKhLDK4HZxNRyjAt769pH
         14rljK2qJfrxPu9d/+fknKdZtnHUOxeMNcIk9kQPzDawXMaKRTSDlQrhhzoWIVyMrM/I
         Qfgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Czj8SMdKL4OV0WUXIT6eVVsHDtJOgUljPlh/okAlfTE=;
        b=EE70N39MRmflPYjtpudx0yZKYGShI04QxkumORiTaI36V/ploBMQ5BRkKq1XZy8c/2
         jbH4bUCHudGERYdvxRnd+bQ8tqc87Vnet0KFm6khtiOMiOAquN9D7YovYCYf5/dgHLEB
         wNDzFsykoEMUIGWFUXsXdUwdLsn0/BARGHz5L0lIWGYf8K+zfxEJWzZKYfNxMk6KbOkR
         946WsAXrMaRKKTcZZ8goZalmpthQ8K29Oe5s9/8Blk/qfsLQnAHl1n1RAX2+zqx7vfyJ
         wcAyDGvfnRa9WdzDeVM1z3syxtwl1ezOALw84WcxmXTcVX2IDHk/i+PVuMKURTuL8GuS
         fAGg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	stable@kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.9 89/95] rpc_pipefs: fix double-dput()
Date: Sun, 22 Apr 2018 15:53:58 +0200
Message-Id: <20180422135214.068435004@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455307537426185?=
X-GMAIL-MSGID: =?utf-8?q?1598456059294324755?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit 4a3877c4cedd95543f8726b0a98743ed8db0c0fb upstream.

if we ever hit rpc_gssd_dummy_depopulate() dentry passed to
it has refcount equal to 1.  __rpc_rmpipe() drops it and
dput() done after that hits an already freed dentry.

Cc: stable@kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/rpc_pipe.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -1375,6 +1375,7 @@ rpc_gssd_dummy_depopulate(struct dentry
 	struct dentry *clnt_dir = pipe_dentry->d_parent;
 	struct dentry *gssd_dir = clnt_dir->d_parent;
 
+	dget(pipe_dentry);
 	__rpc_rmpipe(d_inode(clnt_dir), pipe_dentry);
 	__rpc_depopulate(clnt_dir, gssd_dummy_info_file, 0, 1);
 	__rpc_depopulate(gssd_dir, gssd_dummy_clnt_dir, 0, 1);
