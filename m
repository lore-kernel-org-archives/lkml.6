Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226b3HSPWp6FYgSeHWcB9HcBrIZhiy1qjZi+KBhkRvTzM73Hc5hBWxAoCwW0o+yqLyUE9X4p
ARC-Seal: i=1; a=rsa-sha256; t=1517855177; cv=none;
        d=google.com; s=arc-20160816;
        b=Tu8exc9xtEIvGZukdI4zN9bR5DxSpwRanwD5QBGU8I/oqj+Y1izgKvsYS+qBEvZZoW
         PvnLqCE+jU8GUWv7jqVi/wQ4Ii7tgr/+8DpM8UJ590mLoKZzHXs4/BuCrQeFdqz92uEn
         P8xh9KwuO2qMJDAW/DTvqfETJ5GJYEK5AHkLkAnnklou4jOL5of9QsuGdIroOBYlh50j
         +Kjb5Ohvlele2MrA/laTmS+ZabRRImemZbYS6L13hCAf6ROtHphePVEsVLPYeOh7T42Q
         OdJkLZOWZwmGTLDWtPRAjs6LvCE7s7Zz1I5Lfjl5HzCdRTurijfqbYtpQXfhcHP8P6DT
         EKwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4DiAwErhwRCpoNES4hM4vINKU7Ny/EMQCuR7TaJOoW0=;
        b=SK5gpkwU8nn24u/g2q6xsMFdPY8DBlS+SZ3QXyC/EPZ0n5Y2zILr4p5FaZfQljYinI
         MpIn+Drehd7R7TB1ZnQOujuEqdp82sj2XQP1ixvt+61kcs57FwCULQ2ANEB+hqcORhnX
         /94XxqQl4SAcFSrfMaV1uahkVcTScnpZf3oClfYq8U6XzEdUZHDURiua3RmY/jMcTHRX
         OAnxrcXfARvMQLTqBvlutCAWvy+F2Lnw8tfFCwaegipJ39oo2UFe18icVZoknEDzdidv
         YsCLaiKe6rqptKgEL/yzvckX/aRUuvO1G+j0XMpJWzPBtHO14B4h5TKw8zWLUCFogmj7
         czNg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andrew Elble <aweits@rit.edu>,
	"J. Bruce Fields" <bfields@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 17/36] nfsd: check for use of the closed special stateid
Date: Mon,  5 Feb 2018 10:23:45 -0800
Message-Id: <20180205182352.487845785@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586509815031429?=
X-GMAIL-MSGID: =?utf-8?q?1591586509815031429?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Elble <aweits@rit.edu>


[ Upstream commit ae254dac721d44c0bfebe2795df87459e2e88219 ]

Prevent the use of the closed (invalid) special stateid by clients.

Signed-off-by: Andrew Elble <aweits@rit.edu>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4state.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -71,6 +71,7 @@ static u64 current_sessionid = 1;
 #define ZERO_STATEID(stateid) (!memcmp((stateid), &zero_stateid, sizeof(stateid_t)))
 #define ONE_STATEID(stateid)  (!memcmp((stateid), &one_stateid, sizeof(stateid_t)))
 #define CURRENT_STATEID(stateid) (!memcmp((stateid), &currentstateid, sizeof(stateid_t)))
+#define CLOSE_STATEID(stateid)  (!memcmp((stateid), &close_stateid, sizeof(stateid_t)))
 
 /* forward declarations */
 static bool check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner);
@@ -4414,7 +4415,8 @@ static __be32 nfsd4_validate_stateid(str
 	struct nfs4_stid *s;
 	__be32 status = nfserr_bad_stateid;
 
-	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid))
+	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
+		CLOSE_STATEID(stateid))
 		return status;
 	/* Client debugging aid. */
 	if (!same_clid(&stateid->si_opaque.so_clid, &cl->cl_clientid)) {
@@ -4472,7 +4474,8 @@ nfsd4_lookup_stateid(struct nfsd4_compou
 	else if (typemask & NFS4_DELEG_STID)
 		typemask |= NFS4_REVOKED_DELEG_STID;
 
-	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid))
+	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
+		CLOSE_STATEID(stateid))
 		return nfserr_bad_stateid;
 	status = lookup_clientid(&stateid->si_opaque.so_clid, cstate, nn);
 	if (status == nfserr_stale_clientid) {
