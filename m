Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224Z/K6OXQ/NGj7fsLNqxK/Vx9QeoZrbAMi1stj4Wgt9Ij880y+8NeU/pAyTCLWfEKJAR4/M
ARC-Seal: i=1; a=rsa-sha256; t=1517855176; cv=none;
        d=google.com; s=arc-20160816;
        b=UWtDGpc/huXeO1oWGsDAHVgufzq7/0EMYmVtN8Zi21msVIMYEZDH9nf5xdJWDbbkuM
         jw/6dm48eyIprlWJmWVDSoob34S45HFcBt7cBTh6Z24MiXaP+hMoxyvloC8r8w7LIpFs
         Ucm98FRC95DCVHgaw0Q9ofJrGKQK70BSdk1P/jSNTOcAPzqFwKB0PYUT5PN49R4y3EZI
         dT/BMacKgV6jhEzrKi0ZB9jm4iDBXWTzhc7Lob84LthbSETHAxE+4ZdzOXQ4myq1NEBg
         NywU/hqclExvOJ082eLSXv/k3w/PsUZ5xkwYlCxX03JuoCnGe4T+0R3tvIZAEAgeRKeD
         RyqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=sEwPz79Ghg6r59zw8dmqb9BZV1dJCUsMvWIohBqzzU8=;
        b=Art1Hl0/iwhrR1JqiEis2a2BH6wOG7kT4qdWOoHMILXMSgROQWpYEazSM7bysnGCX3
         +9VtI4P0Rq0EdUKtPhERjCuDnsbyaH5Lv3qsv1MY8Xi1jeo38iUm20nwRH7K8310DWho
         JrnIR3/P0ZldlWypiByZQzsIVcgJk7wAKUbZiteHhWwkRTWhleU1LMv/WBU4CVLo9Tu6
         L8bH2pFj2alEaKfPr4lqF/zHxixT2ma/MsinwuwahMZWWjVf7zw2yvWPuBWADepXYPB0
         W9+5BtDS7SQ6Ry1pWnLuSadXdA2xYRV8Q8PrBF/LG7vM321iUlopRhSYjUmuKxfYLjog
         /RNA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Trond Myklebust <trond.myklebust@primarydata.com>,
	"J. Bruce Fields" <bfields@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 16/36] nfsd: CLOSE SHOULD return the invalid special stateid for NFSv4.x (x>0)
Date: Mon,  5 Feb 2018 10:23:44 -0800
Message-Id: <20180205182352.444636113@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586509499085907?=
X-GMAIL-MSGID: =?utf-8?q?1591586509499085907?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@primarydata.com>


[ Upstream commit fb500a7cfee7f2f447d2bbf30cb59629feab6ac1 ]

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4state.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -62,6 +62,9 @@ static const stateid_t zero_stateid = {
 static const stateid_t currentstateid = {
 	.si_generation = 1,
 };
+static const stateid_t close_stateid = {
+	.si_generation = 0xffffffffU,
+};
 
 static u64 current_sessionid = 1;
 
@@ -4901,6 +4904,11 @@ nfsd4_close(struct svc_rqst *rqstp, stru
 
 	nfsd4_close_open_stateid(stp);
 
+	/* See RFC5661 sectionm 18.2.4 */
+	if (stp->st_stid.sc_client->cl_minorversion)
+		memcpy(&close->cl_stateid, &close_stateid,
+				sizeof(close->cl_stateid));
+
 	/* put reference from nfs4_preprocess_seqid_op */
 	nfs4_put_stid(&stp->st_stid);
 out:
