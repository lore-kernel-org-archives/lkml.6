Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx494VIeYcc7D94V9Cy0DONo3bxBg3HA5AzA6JL0ZlMwd0cvY3tsLAVqjwlwUBLr/a4zW6+vU
ARC-Seal: i=1; a=rsa-sha256; t=1524406913; cv=none;
        d=google.com; s=arc-20160816;
        b=CABO7nXfOE1hKLohej1EbT6UvjcghP3rumFEI7v1fFc5ng7w4pdVrwyTQcj7H5cK2q
         4PAUpwnKcH1iFKHVN9XQ2t1tLz8dvWVn86YeMro6OJJgaWM+FF7QsWhMRQRrN7cUsyWw
         l47LeZHV6Sj5qaoPSPzbaih/Ft8Ujf7KHhSisfs7pGByk8BR4ZhSY7neXVBwPzbx51Za
         19G4b8VAWJH8sRUm9yyUp35TO4kPvO+12mpqrEKcBXK4hCyvgN29V2/hCUPy7hE2EOOc
         L+K6HWkYKeP2sIn96Ef71aJnSIlivfGRIZ0HJV8qdyqwHGp28/XvAlGyXwYJm6lwpzSR
         SPcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=j5CL+78oLj3B41+FY2UoGsMtyA0jOIF6loqMvG3QqVw=;
        b=sfbfMljOYsn30e4KoTqLMV4G7/N2nBSbHhIfZ763p3e0hsdYVK8QhCVF8fbEhH7ebE
         O5R+hc5LaR01dBhSCsAdoVfvgCDzZIwshxzR0Zy3hWh++JPmSS4LXyYNzEmNo3PUV2kL
         73FvI/NpLz6xjswTt5cnxLGY23JE6yZh9p0O4jAtL58wLeD7sQrQKHBrQPcawBp/sdf7
         bGxycCO5qhG9CfmU8ZadYHFtxFgmmdiJfgE+aZ3o9Huxo0XHYncFvsZR/5GuXeEDSb5l
         csFAh82n21Kbujluc9nLeh+Wcxk9YhSjyZ0PBQAZJBRHc2KJPhIThzJjX9Ok6zs6bQWn
         1/5g==
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
Subject: [PATCH 3.18 49/52] rpc_pipefs: fix double-dput()
Date: Sun, 22 Apr 2018 15:54:22 +0200
Message-Id: <20180422135317.595399449@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455307537426185?=
X-GMAIL-MSGID: =?utf-8?q?1598456503957090726?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
 	__rpc_rmpipe(clnt_dir->d_inode, pipe_dentry);
 	__rpc_depopulate(clnt_dir, gssd_dummy_info_file, 0, 1);
 	__rpc_depopulate(gssd_dir, gssd_dummy_clnt_dir, 0, 1);
