Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49wtbnm389lOo7IGWr7O+Zw+8DPdjGqILnPCNfGlAX9l4uEQHc6XSYx+Gu8YVjyEuyaBIhS
ARC-Seal: i=1; a=rsa-sha256; t=1522168957; cv=none;
        d=google.com; s=arc-20160816;
        b=HOBarIKf2x58hRzLQcJfJmqducX7tlZ8zGcXPoyFRYy+fmpm1HABPhA4lFFOZnLf5t
         CBCRZrVOI4eV04OHQKpUe8Lnq9iO8afBOkuywbWmDKanQslVsZZazXebLNMjr6yA/r6r
         1PpElPdU7BCFOrUoiMfHoLeqE15jafPOHmg4xvIphUCOaKm2/eLGTyQRO6YIOY9sEZ/L
         ylNPuNSv4BsWVE70Wx1zKpwqf5YvCMnjen0q1RyyGtal17xfaSX0U07kaLyWDQD6mWoM
         7XXudvSi1vQ+T/uaZkbg1movL2xZMK90MMisLdPB6wQhEUClj+qDZMMk06z8NEo6dJiA
         WqsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=72jCOWIsDYzQE4hqDOEUThbeE80+3Hmt+rO5Bmk7Hjk=;
        b=AZQjh4I52954tvz1WAe2VRYvC0O278sVz0+pVCI1fckrnFW+F94jEDleKQwWKcKYBw
         yeWxjY8Lur0K9E/ygtRgxtW/NrzuIhCXE7wLKRDJEnscNwKl8Dsfw2N/XuzRnbrksxE+
         4uFHO4iECjRhtYRcqZCRqPqgYXcgDdoOgxUbF07Ew0ktp3iavMeZYufK5ipUwk5k5yQS
         GrlCmG01jL6lmALn68RWPLvK7bHnJHOcDoeR64c9y2lR0MHmrSL68Djc/a5xPECM+ZZF
         BmF2xucDFDNbXNQJQtwt+31i2vxN1dZIqTsEs3680PVrvA/UHCJkdKgO+1EW4y131MSs
         XRIA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 4.15 074/105] staging: ncpfs: memory corruption in ncp_read_kernel()
Date: Tue, 27 Mar 2018 18:27:54 +0200
Message-Id: <20180327162802.508474143@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109021146013259?=
X-GMAIL-MSGID: =?utf-8?q?1596109836398497990?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
