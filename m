Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48sxN8em4Wq2HM6DS0dVZz0vzfTV27J339g300rFfp4tG/ttALWQ0CT2F+FGLdNFOuMRoou
ARC-Seal: i=1; a=rsa-sha256; t=1523981139; cv=none;
        d=google.com; s=arc-20160816;
        b=Me47jAc4HTIb3IpQvvJsH9ZkIMEeXsjyfVBJWie0Z281awv+pX5xLQYSCKOGHHcLOX
         aLZm/rKyDCsU5SxtOz6TEcZIQ4BSSJF4DKFb2LS+TpvrjomYOK6qsI3tsmjVgUR6gULK
         3YtBUhcgHVG0n+93aF5D1vgYAgFL5MYlgGVnUtYujxUhXluWLGXLTOZeJIAY4hP5K69t
         gPR+iXFO6NFzh1dcK7JQCRJRUqk0viGRNPa5i/wo7zIw6ZqlG3Qh0DTPOGdMc+AxXpfq
         lXCh+sdLxyA53on5unBazun2TB72IT2A47Ufz/t7glfdp5wYvaDh3PmQmRYp5lay6zTx
         mbFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mWhENeRbQ+R+mqbRmjavP+zAun48ClE6CCm7AcK7RLY=;
        b=YieE8aUTQSIxONU5KCBo0D5u6xY1eNmLH2mO7e+TYUl6b4moq1E0mZpIS9VxiymDxc
         r8PTGamFLU1lOFJvICqcc4HWErAidn9FUuo269BTZdPh/6LM4exua5gzv+1b05aJRuKR
         QPFQqg5OURMVZ3ormwuPiZZSNpe2sYJB94OZ/U2ceQJJbMNhBwwIH52Ov9CgZD9zkl1b
         zS/JUI6XFWmCRUUnZBQMIRV4hFQw9k8V172/ZnbNM723HEo4LCwoGQ9oCaQYNiuikbrn
         iaXSGrzwpEmGYmcI7TDHnIaIYt442PASuaeowQTePZxJL8l1FZtbaHH7QufMG4zU73o6
         ceGw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.15 49/53] getname_kernel() needs to make sure that ->name != ->iname in long case
Date: Tue, 17 Apr 2018 17:59:14 +0200
Message-Id: <20180417155725.452747154@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009878581722556?=
X-GMAIL-MSGID: =?utf-8?q?1598010047009008481?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

commit 30ce4d1903e1d8a7ccd110860a5eef3c638ed8be upstream.

missed it in "kill struct filename.separate" several years ago.

Cc: stable@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/namei.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/namei.c
+++ b/fs/namei.c
@@ -222,9 +222,10 @@ getname_kernel(const char * filename)
 	if (len <= EMBEDDED_NAME_MAX) {
 		result->name = (char *)result->iname;
 	} else if (len <= PATH_MAX) {
+		const size_t size = offsetof(struct filename, iname[1]);
 		struct filename *tmp;
 
-		tmp = kmalloc(sizeof(*tmp), GFP_KERNEL);
+		tmp = kmalloc(size, GFP_KERNEL);
 		if (unlikely(!tmp)) {
 			__putname(result);
 			return ERR_PTR(-ENOMEM);
