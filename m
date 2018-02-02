Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225pZ3Acn5bZQrrvmboXF85tXUkviECUeErYPIoj91SXfy1Zv5gWsnaYGtTERl7eaGTlsYdh
ARC-Seal: i=1; a=rsa-sha256; t=1517590867; cv=none;
        d=google.com; s=arc-20160816;
        b=n1NdRYNuzrv7jtWk+wk1ljFJYgrmaWgAe9P5fl8sOlaBRPWeev7puc6CYZvkJa7L+M
         iO9P5kxkrUE+LuwQAUMET2heWu/Vsa3rmarecGCB/PKVADM8Y55WIFMVez7MIzBXRmTG
         +GL7VA6jWJ2gX1pdRoJzLwBA2gPtcFEON8pSyKVZ/CaBh5SJ4z2nII+1nBjcX+lfKWMf
         pw7IrLP8oi2KAjqEmx28u/HELKPwNT9SpEaH+3lJd+u8xN/s/r6O27OmnuAxB5LJaCJs
         hoFSKmQzvh+xaHHq/VB77z1e8hdVxDJbpHSWGlyqhaFF97PMimjCcZyZhpdnwznJNUAw
         zdjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nYddug4mnn7UiOBGMel6z5LgWbTbuVSEdTipZMtYoDg=;
        b=PPOXqxt+6DuJErZq/44YwbnOLjJvycK/K7g73Rm30EdmLrJ64nvCEN2UeY6+tNUPLO
         NNYzgqUfGL7/uibIy2QoZveN15Bpu4VBnhWIyf5JDIQXsAuGo3NsYK0eqyo4xf9jzXXC
         3155VpOcJb5KgpVF0cB8IfIdzWj8CUoAYa6lIefWY/0VdRF9u6T+DKVEHpHq2rQ2CVsB
         GmDPfrES2knAjcqXewMJUMR3SxmalzttOXO2ZSuoFvZIjMdZKVQH6WB9qwaB8ZS7IcId
         lola+1HIpPJCxZN2BqCne+H4JpmHwx0cep9mrM7NOKIIC9vbOI24udUi0KA5fWEmKxap
         c9Rg==
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
Subject: [PATCH 4.4 41/67] nfsd: check for use of the closed special stateid
Date: Fri,  2 Feb 2018 17:58:10 +0100
Message-Id: <20180202140820.048638109@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309361425299026?=
X-GMAIL-MSGID: =?utf-8?q?1591309361425299026?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4704,7 +4705,8 @@ static __be32 nfsd4_validate_stateid(str
 	struct nfs4_stid *s;
 	__be32 status = nfserr_bad_stateid;
 
-	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid))
+	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
+		CLOSE_STATEID(stateid))
 		return status;
 	/* Client debugging aid. */
 	if (!same_clid(&stateid->si_opaque.so_clid, &cl->cl_clientid)) {
@@ -4762,7 +4764,8 @@ nfsd4_lookup_stateid(struct nfsd4_compou
 	else if (typemask & NFS4_DELEG_STID)
 		typemask |= NFS4_REVOKED_DELEG_STID;
 
-	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid))
+	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
+		CLOSE_STATEID(stateid))
 		return nfserr_bad_stateid;
 	status = lookup_clientid(&stateid->si_opaque.so_clid, cstate, nn);
 	if (status == nfserr_stale_clientid) {
