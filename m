Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/CRxMnAyKrtS9r6fw4D/fJ3fTc9ugL3dqUetpKNH6UW1EewpHttUwAVcSptSslZQ/YvY0x
ARC-Seal: i=1; a=rsa-sha256; t=1522168606; cv=none;
        d=google.com; s=arc-20160816;
        b=olsxIY1jrQO0WydNo3PWmRL4m7P/RGKKOHQKLokrNAsc8Ifppub8sNhdQGd9hfFR0k
         +3BCAjWylXue5tzAyVEvnG3nRJH0ApNc7fOrsilubNfg6jZ5JmW60cdGGMew/AJgUKgt
         UTcV9yvAOWtYsZG5MnaKIV7XxPhQH4BD7j8PAtzxUAjOnyIACof9YE4Q5n8NOj8eHA/R
         Cc/5jgUzb2V99F5Ydvq8Rnr2YGXzdiqClgEEIxBqetGi15cgJs594499AWhh5/iQ9Bsy
         BuCOhc4o4X/KNuqqXdJPfMIcm9dhrBlz16OHzBWVYpojdS22jwBZah5wIfVYJQFTTLVG
         9tOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TKO+d7a1Y/BxnoAUtnGr1jnB02PpNsBHO+loZJbFCsk=;
        b=mXR2jmH+EXXyVoTKfNP32IzM6loRqDbeM2FoPsT8xupAezFdVh3+md6fZLDxCRDQ8w
         mqZ+A9XuihAltWPykHf5AYnI5J1z7mQ/SQ1HO6QB8HiU8AWJwx8RHxs3rpc/hAntEfn5
         xuHyYjYHZeM19qdY6R5v0hzxWdghWmOJ4E6O0UTIPv0P0F8HwohbbSDTV6vTAvVavqNi
         LE2ZxxHg7AasKAMB8NoSZmn65vppmaIOEOW+vJ6V0kZAwhSW5kpH8Yaor7z0pgjXTNkL
         dqdE9Z99RG4ju/4rwa7/7O+bBKOQNA90nHU1gQxuRsjK0tNcoeli4XkyvvmcIlWmzqHc
         eZKw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 4.14 069/101] staging: ncpfs: memory corruption in ncp_read_kernel()
Date: Tue, 27 Mar 2018 18:27:41 +0200
Message-Id: <20180327162754.272066934@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109021146013259?=
X-GMAIL-MSGID: =?utf-8?q?1596109468777312598?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 4c41aa24baa4ed338241d05494f2c595c885af8f upstream.

If the server is malicious then *bytes_read could be larger than the
size of the "target" buffer.  It would lead to memory corruption when we
do the memcpy().

Reported-by: Dr Silvio Cesare of InfoSect <Silvio Cesare <silvio.cesare@gmail.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ncpfs/ncplib_kernel.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/ncpfs/ncplib_kernel.c
+++ b/fs/ncpfs/ncplib_kernel.c
@@ -981,6 +981,10 @@ ncp_read_kernel(struct ncp_server *serve
 		goto out;
 	}
 	*bytes_read = ncp_reply_be16(server, 0);
+	if (*bytes_read > to_read) {
+		result = -EINVAL;
+		goto out;
+	}
 	source = ncp_reply_data(server, 2 + (offset & 1));
 
 	memcpy(target, source, *bytes_read);
