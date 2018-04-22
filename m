Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48te5FGrjM7mPdMMP7viXKzq5N7q7Ifn7aadO27AEnSU9X4lgUZC2Zt1mALgaBbedNfsh4v
ARC-Seal: i=1; a=rsa-sha256; t=1524406751; cv=none;
        d=google.com; s=arc-20160816;
        b=0xJ35oho41RQos10K23GUOgYOj7BJJGBKUtwERqtmEbgGfsVlbTOCDR71jxVGFPgyl
         jsmN8qO01SQaKuLunchCSf8QvgpYPTpLVX4tcNOyeobKgGVu9m8Zj97MNdPhpyTjHq5d
         M6wb3Wo5e/34CbEwKqSlLPPlYPYkeR//Lz7I0HvO+83KJzdo/Fg1obnBtaUDCqqYnxlq
         61S/rZ15Jp1rcQE5oHyWOvFnsBKzmKSYqlhgdbmpF64yFoa5QhVdZhoBcKhh3V6ihclY
         R00gd7PVN4+QQZ9PMNiIgPQTnSpbfdkEK9jZrp/2YZA3BMJjThxS6R/N8CPOISgDR+xB
         NXbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VCYO+twLtiVRwHhrlCIs/FyM1XB0BHYXwGb+gyQDKKM=;
        b=WIzq4tGANOjAyLa7LEu/yGPApILi8sHS4EClp9UWWxXMpTUUVsI30SqNYnwIoxC8N4
         Ch7ql3xaH/y5R7ZwLaDT5qqtSjnz6E+uFFlD6kIqLQd9IyHkA0p25mcIpXS46Rvi876K
         yEF9vBFFGv+xfUfKPtix8sYmDJQw152RhdCBVjFRupCPrebwBZ8Cr1eQOECaNyDUSrrm
         jaDsRwV5BE4/2HvwQnMu4zStESq6a/T1QjsEUGDBmubRWygt6ROVTGRuqvE0TvKBdChE
         n0eAZpDhZb0T5uPkJshhUML4YjcGBbz7gxktOwOYklTPTydanOyrfE968RRJ+EMPZbBj
         h3oQ==
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
Subject: [PATCH 4.4 90/97] rpc_pipefs: fix double-dput()
Date: Sun, 22 Apr 2018 15:54:08 +0200
Message-Id: <20180422135310.105770191@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455307537426185?=
X-GMAIL-MSGID: =?utf-8?q?1598456334148810265?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
