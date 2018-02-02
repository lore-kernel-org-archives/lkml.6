Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226vNkKu88x0KFU9JhEMEuwzEkP42Jj76i7FVppCd5tKL4zETBFbfioJeJwtIf6LQhKjqo4k
ARC-Seal: i=1; a=rsa-sha256; t=1517591082; cv=none;
        d=google.com; s=arc-20160816;
        b=lerJYbyt6wCvWAMGpeEitJAKkDNSO/W8hYf836MrRQ9tAuvD4ciE0ig1Twy9lAFIqi
         YwHFQqwndohLhJr3yzxVrnhFfRzgOxP9Bb6TE9CHIJ3o74kuzCOR8tar4qeVtN1YXPzI
         XpAsg64zXtWxmqQLpNenprK5cxAC82q5nqSqCzwpBOVY8p8Y6CT/tHeCBZOETeUOpUhK
         SVhpNBi+xIWL8GIiD1/hGe4BXragpOy4sCOEGvY9BVyGxMdC2hqj5TIPKh63viKmmTgi
         NQx/PfSOASTSrLxSHzvDtfeSEE9uJoxcIZB6nH0a3fzDlim2e6bHB8zkOoAy44+NAvQB
         C0bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9NI1nYJvIC1oqS5O8xxL9W2rV7eJN5X+R3vOOKJT0RQ=;
        b=BFwy4RxFgbOuZHp++6GrdnxMK5iPdhXt77em2zGR/kGT8MTbKYqQyfbUXfhvOilkEZ
         rVS32up4eSz9gVwpotZsSD7LnsNoj4wSLPFcZEcavS7bWCb+nr539Rbu7evk7JJ+nHnK
         xFj733H2F+043de1gCZVYLbiwF2BDRGOhxwAr0qGDmlFXL/bnw/m7/Wk3/4QKPETmmqP
         ORh/V1MZ4lMlPmYAHvcZOGiLFRwMCAkB6MKcR8Zjurqofm3su/z+MiOa+gU5MnYla/fl
         ES+Btwn26vVeTGrSm//7QXWegZkn/DVOSiEIHx4xggxL8DvZsmJxU8X6b7OCHXCQGb6/
         Rw3A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andrew Elble <aweits@rit.edu>,
	"J. Bruce Fields" <bfields@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 44/86] nfsd: check for use of the closed special stateid
Date: Fri,  2 Feb 2018 17:58:04 +0100
Message-Id: <20180202140826.425593154@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309361425299026?=
X-GMAIL-MSGID: =?utf-8?q?1591309587229737372?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -72,6 +72,7 @@ static u64 current_sessionid = 1;
 #define ZERO_STATEID(stateid) (!memcmp((stateid), &zero_stateid, sizeof(stateid_t)))
 #define ONE_STATEID(stateid)  (!memcmp((stateid), &one_stateid, sizeof(stateid_t)))
 #define CURRENT_STATEID(stateid) (!memcmp((stateid), &currentstateid, sizeof(stateid_t)))
+#define CLOSE_STATEID(stateid)  (!memcmp((stateid), &close_stateid, sizeof(stateid_t)))
 
 /* forward declarations */
 static bool check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner);
@@ -4869,7 +4870,8 @@ static __be32 nfsd4_validate_stateid(str
 	struct nfs4_stid *s;
 	__be32 status = nfserr_bad_stateid;
 
-	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid))
+	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
+		CLOSE_STATEID(stateid))
 		return status;
 	/* Client debugging aid. */
 	if (!same_clid(&stateid->si_opaque.so_clid, &cl->cl_clientid)) {
@@ -4927,7 +4929,8 @@ nfsd4_lookup_stateid(struct nfsd4_compou
 	else if (typemask & NFS4_DELEG_STID)
 		typemask |= NFS4_REVOKED_DELEG_STID;
 
-	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid))
+	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
+		CLOSE_STATEID(stateid))
 		return nfserr_bad_stateid;
 	status = lookup_clientid(&stateid->si_opaque.so_clid, cstate, nn);
 	if (status == nfserr_stale_clientid) {
