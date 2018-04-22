Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+zcD2NNzvn1tZ+A/j/aRWFyL4TZQ72g9k5Sr3VUlPVxm3X++nboubl+hez3x339s2na9cw
ARC-Seal: i=1; a=rsa-sha256; t=1524406216; cv=none;
        d=google.com; s=arc-20160816;
        b=n8q2Wuwn100Pg2TDnDzdFO9xies79tpJgEtSKKAjabFWQZGVvAghzpB+qRMwoL/vEx
         Gfeve2djKwMmPg1eIon7qfxKKZrzg6IE9zMobzmyWwrHBHgZr2ocenRmZ4rlMAS1+ZG7
         dntFVm4X5LBhWxx49YRTi6d3NSA/qgiUVIfGQ3JN1dN+ICPP8+MdmIC4BEw4Fsmc26oE
         2JbIwbEp7/Nc5JNNAKcqJY/baAa+ePoYSccl7j7E/Ua++PZBWyuSEQQXAdNmpliJy5wA
         G0Y41dxUR1LGISIuZ7tU8ND8fceM6Gv+ucdKjpIDtg7rFFJ0xyleEvkkd3l+HLymPdGo
         6J4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=b/jKEUTp2lm/i+svNcyt+bWThEVHdyUDIAHUiG6uyHE=;
        b=t4HQDiudvLKSto0qSlfTTay1NzfHmqKpdrQb1wharBuycMmARN9z90QwPml3cB5DEU
         tHyTJsyc3d9O+gePERgQNDn++V+dcAHh+25SaeyIVeJcyyYFeHpnIqTc8fn86ETcL7oV
         OWDgoYlYIC4/82nc9MQgDAfAVNPQS+ekVws1gbBpgAlnVk61QTImAxDG8ynFgNHy5VMM
         jk37GMOcDVcg+lA4j/ho7d2FFhmFWsAhLgjM2MMoy24EWWBngzslm0QyVbG36+xl/2N4
         SOANCQOH0k56gHq4CmcrawEBgQ8TlFJd/eifXarMRlUUSKIwzLmywuJsvv5gEVLyhecZ
         4LtA==
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
Subject: [PATCH 4.14 155/164] rpc_pipefs: fix double-dput()
Date: Sun, 22 Apr 2018 15:53:42 +0200
Message-Id: <20180422135141.922552677@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455307537426185?=
X-GMAIL-MSGID: =?utf-8?q?1598455772121300059?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
