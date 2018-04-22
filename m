Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+zNuPg5GxR353Q1wGWO+C4X3gHDLnmxY1njTlg7JZS4pf/dr49zOhPzckEuwSkL84ZfcHn
ARC-Seal: i=1; a=rsa-sha256; t=1524405484; cv=none;
        d=google.com; s=arc-20160816;
        b=OQJ6b1eRGkiM6XUzRsZkol58ovGdliY97R7x2RSc5opAAXMwh3fmFIIQKi0ha7+tYM
         GlINF+K/k9h8OvqX62Jrg5XAzNPa6Bc166qT479q+BUkLZbl6XR7N252CsBbf6GLMT53
         SWX+I5CkdEauo9jlEqJfzQrNb3e/DwrtmofBaGCFRa4vRWym0iKiW3AGagg0EVg9K+sW
         dF3yjl/aOgr+/y/upow2itqN2sjwsAsUKrJiaZNSQbWcTyYmurhW8oqwGvolCtdxkgMC
         1shKbBPT00qSUJYm2YgS9trVwBpMyiCe/5rx/hNbYVdSsn/3P+BQ7dkGkg7++AHj4rNh
         20iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rH9jI40FsD13etsZIa1uMIMIreP0graKX0Whsi29Xf8=;
        b=J9YhOewVOsVL6KGMo+caM8rAJqKmQibCliMBt/N0q2LLO57VNhm9LNykrYAX2qB/SX
         fWxy/aifGgTwhCFsxr9GUIq0vy6G7NnXtD/fRMBblsXCEZypijAIuwQiF8TYmICvAw1n
         n7HTUJgBrlRdJzlxOOXaH8IhSutEjylR6E64IjMutx3O/NiYP8s26viU/i5/XnyslFAN
         hahgAmrwGFnSwSNZ36yr+CT+sL6d60IGxVXK3jkS3CbEd1AfYM6CHzXCUwxQWCOBF3cr
         8CvmOsYXcmiWzOl2zNQc918I6fHE6FCG/ZSw2o3mGtA4UJiQEFcCAlINJODa6GXW8RaV
         74Tg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Steve French <smfrench@gmail.com>,
	Pavel Shilovsky <pshilov@microsoft.com>
Subject: [PATCH 4.16 047/196] Tree connect for SMB3.1.1 must be signed for non-encrypted shares
Date: Sun, 22 Apr 2018 15:51:07 +0200
Message-Id: <20180422135106.507450484@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455004595849305?=
X-GMAIL-MSGID: =?utf-8?q?1598455004595849305?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <smfrench@gmail.com>

commit 6188f28bf608ddecc2377663b0f2f709440c19ba upstream.

SMB3.1.1 tree connect was only being signed when signing was mandatory
but needs to always be signed (for non-guest users).

See MS-SMB2 section 3.2.4.1.1

Signed-off-by: Steve French <smfrench@gmail.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2pdu.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1280,6 +1280,11 @@ SMB2_tcon(const unsigned int xid, struct
 	iov[1].iov_base = unc_path;
 	iov[1].iov_len = unc_path_len;
 
+	/* 3.11 tcon req must be signed if not encrypted. See MS-SMB2 3.2.4.1.1 */
+	if ((ses->server->dialect == SMB311_PROT_ID) &&
+	    !encryption_required(tcon))
+		req->sync_hdr.Flags |= SMB2_FLAGS_SIGNED;
+
 	rc = smb2_send_recv(xid, ses, iov, 2, &resp_buftype, flags, &rsp_iov);
 	cifs_small_buf_release(req);
 	rsp = (struct smb2_tree_connect_rsp *)rsp_iov.iov_base;
