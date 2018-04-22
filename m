Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4//hfGoAEsURccvRPdX/8drPhwv1whSyDdaavcsGOUZVYcrL5a6dl8zpxaUu3ARVghLBxfF
ARC-Seal: i=1; a=rsa-sha256; t=1524405772; cv=none;
        d=google.com; s=arc-20160816;
        b=fBURcCsgwMCdar05DgVQaoAco+OKAJep0msf5xwh5FXYoh/BEQn/xM8T/UB92iHznT
         b4+NAh0BiWbXMHbDuUnCWfY5/IGBivuGInh5cBhHxALma+RKvMJTOnmTqs8C9ULEA8/W
         XcU9RDc8Z09c16m1tVVoM1PDcPg4+OxNUOt2UHSlS0c7xwAXPFeZXcEXPmy2/LCNEF1R
         TY5oN+DaI9K+Nv9xC2QHaEUQBlOP1jY5/KOM5D+Cuf7bcg1NB+/QQjT9JbOqZcipzEDt
         OPPufEZ3njuTr4L+OblS/8Nzvt7r7x+sGoLZAWUJLkVSnObybE/HOVzXZMjRwCJpxDzo
         5MZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=M0RzjC7KBLc0SyZHJ3tZUNgrs9vKlM1wv26o8ZMV7hA=;
        b=N93+hIaxUygJXdfCUWF3PCy7K5wE79XgocsYs4xJYRqQ7nsJL1HBO4CpgUo7JgkpG5
         ytAPbrG1zcZH0pPe13gLY1zEbvCz6Opd1gxU+ug6dwhpkOuhq3wZNBL45bjMQlvdNQbK
         6a6LogUM+7Dnn11PjqR/9AV5qQV5S9yUhTJECadnGmbilsTpzhjU8MNMgwac5CsWqG1N
         PqTFvCrjl9wR4bj4EzMAnOeoMKop1k8RfoElIWZKC/i2td3scPJBOMD5pEeCdA1tWE9K
         FG2DbBJe+Jge/XPbdJ0h6catimCpC2E1WxlFaDc84liP+lIdDkqRTtFJFqb7FK+Gahf6
         Wb4g==
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
Subject: [PATCH 4.16 188/196] rpc_pipefs: fix double-dput()
Date: Sun, 22 Apr 2018 15:53:28 +0200
Message-Id: <20180422135113.975744272@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455307537426185?=
X-GMAIL-MSGID: =?utf-8?q?1598455307537426185?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
