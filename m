Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224D4NHMeNirXW9iQyhMb+DFnMPUiUIMK3YtiJ1wwFSkwHMXK4JSXqWh4kdZpEudCY7A+P0e
ARC-Seal: i=1; a=rsa-sha256; t=1517591451; cv=none;
        d=google.com; s=arc-20160816;
        b=k93HJbE4IiWCVZw7WyphzWaUDha3bCt20wlk98yZROWOSl4fHXXJ6Preub/528qAYv
         einmX/CuWkjojEeOXUNgeFhLZXHGHoCDOYUk22fgSMtwsK6yOvsLi1PQeSyKlO2u47Sy
         vxg0QRfIM/AASBu+uBR43s0bJV9oM/P6MI1e7kaAT3r5DL7Lj/XJSfHjxirHCm2faiif
         qOiciGvPGbXy6bpfYi4E+FHLVbqIrLEftOMlMXqbNpHSoGgjBY5SLf5pHRTC1uUlAyWh
         Er4WyLBVbWgE54u6IhFGXEfCrjsWvrq5su4N/ARbOOCymXlnod5yWNasqVucTyW+JHKa
         6PTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=BdRxI7Yw5luGOQLooGGJkUbVfXLAO2Lje+lDdl5kcB8=;
        b=0edXcu2+9Nt68wiOScXIE69ZXILkLDwk5iiiOqRbmSpGJXDrXo6eTNkuDYM942dcHQ
         TmkpefItmqkh32d++FyFKkSl7ExbN1/RsZ8/BRPKOcNYfw5Z8k8C8QVeBiD0PVZxRPBF
         nOy++mBcdjnGMU1oYwoGGM+fSy7tprTFJ54zQ5m8nGFhKvUZA8I29HbY2LoxaE3Tr695
         B+0nCGaCzlzrR8gEvWPT7aIjH1vLINtOSUuzBsubKUqkzWXO91OleOwNeD4C+I2tARs3
         15s2eCj1fKWECfaowfOnzHK8xp4dpoj21A01+m9634mTYJNSpO8mQ+JYHfEomq6fG6kw
         mddw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Trond Myklebust <trond.myklebust@primarydata.com>,
	"J. Bruce Fields" <bfields@redhat.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 085/156] nfsd: CLOSE SHOULD return the invalid special stateid for NFSv4.x (x>0)
Date: Fri,  2 Feb 2018 17:57:46 +0100
Message-Id: <20180202140844.103622201@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309350849289431?=
X-GMAIL-MSGID: =?utf-8?q?1591309973539289562?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@primarydata.com>


[ Upstream commit fb500a7cfee7f2f447d2bbf30cb59629feab6ac1 ]

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4state.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -63,6 +63,9 @@ static const stateid_t zero_stateid = {
 static const stateid_t currentstateid = {
 	.si_generation = 1,
 };
+static const stateid_t close_stateid = {
+	.si_generation = 0xffffffffU,
+};
 
 static u64 current_sessionid = 1;
 
@@ -5411,6 +5414,11 @@ nfsd4_close(struct svc_rqst *rqstp, stru
 	nfsd4_close_open_stateid(stp);
 	mutex_unlock(&stp->st_mutex);
 
+	/* See RFC5661 sectionm 18.2.4 */
+	if (stp->st_stid.sc_client->cl_minorversion)
+		memcpy(&close->cl_stateid, &close_stateid,
+				sizeof(close->cl_stateid));
+
 	/* put reference from nfs4_preprocess_seqid_op */
 	nfs4_put_stid(&stp->st_stid);
 out:
