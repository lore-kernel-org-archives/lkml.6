Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqX+WKSOwx7SXdSB2pGSrqTCS6f+oqM//ZS/zl/u35VlfvdaivhhFb9GWraOMJViKNXJVPk
ARC-Seal: i=1; a=rsa-sha256; t=1525116509; cv=none;
        d=google.com; s=arc-20160816;
        b=kLKgFobCpHmELHXFopmBN5TuNNu5waCXfV7FtyEW/AJs7xubbsvyVYhK3EgMfsCAtB
         XvTQFORlTQckVxb2ROZnF45EY/6+AbaVdMJEVC2RHXBn6tdg8ZCRAh5W0JAMMEvAqhWD
         EUqRr8uPaQrFTN+JnA3pSuEKN/R/DwQauG1TrlrGXINRkPcFL+vKRBBI3bBziAllUuJt
         Zgat1TyhnPJea7SCFfJ307dkIehLGJHLfyi04HjmFcmV1mlsxUMnm7TZ3hYNhG5FxnNW
         1u1LfOBqFXEQilN3JfoGjtSmp/mHcwXXgkAxyKjEb9JpSVS71xPbCy0pZZT2bn5dpER5
         N5xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=rpfhf9yuIx8HQMhkLoh71FBcX0/QS4hmUReXCNT846w=;
        b=0BkBsIw2/lO+ZNrYwSd4HOv5tSYMSXMDo/NHWqX9Jy+Exq7mwafL/9C0yi/+t9iloi
         Z3CS0O9p2sN0zUNTTV/KMvJoflEdN46SfHuETmQExjzH5bFqKDXdqpFKn/1WRTHIrMBY
         L2hhvEcRqFza1wkaIJCbQ18CynqeDdrdfh+6/PWK1UMoiU5waeEshcGERlnZdglZ/dWY
         RjN74khTUPzeNgtKBECJ5PBN3WkGi9WDdgnG0xPjN4eBdKH3mMJVM+o00kUor7mcbTEk
         zT+VZpI0G3cIYS7/LXsBHnH+BNCpZYkUXmDWQuo+Gcx/z9ow4c2wjQf7+h+rO3Nf/oqs
         i/2w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CEC122DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Steve French <smfrench@gmail.com>,
	Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH 4.16 067/113] SMB311: Fix reconnect
Date: Mon, 30 Apr 2018 12:24:38 -0700
Message-Id: <20180430184018.050342778@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200569396678651?=
X-GMAIL-MSGID: =?utf-8?q?1599200569396678651?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <stfrench@microsoft.com>

commit 0d5ec281c0175d10f8d9be4d4a9c5fb37767ed00 upstream.

The preauth hash was not being recalculated properly on reconnect
of SMB3.11 dialect mounts (which caused access denied repeatedly
on auto-reconnect).

Fixes: 8bd68c6e47ab ("CIFS: implement v3.11 preauth integrity")

Signed-off-by: Steve French <smfrench@gmail.com>
CC: Stable <stable@vger.kernel.org>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/transport.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -753,7 +753,7 @@ cifs_send_recv(const unsigned int xid, s
 		goto out;
 
 #ifdef CONFIG_CIFS_SMB311
-	if (ses->status == CifsNew)
+	if ((ses->status == CifsNew) || (optype & CIFS_NEG_OP))
 		smb311_update_preauth_hash(ses, rqst->rq_iov+1,
 					   rqst->rq_nvec-1);
 #endif
@@ -797,7 +797,7 @@ cifs_send_recv(const unsigned int xid, s
 		*resp_buf_type = CIFS_SMALL_BUFFER;
 
 #ifdef CONFIG_CIFS_SMB311
-	if (ses->status == CifsNew) {
+	if ((ses->status == CifsNew) || (optype & CIFS_NEG_OP)) {
 		struct kvec iov = {
 			.iov_base = buf + 4,
 			.iov_len = get_rfc1002_length(buf)
