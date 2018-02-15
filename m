Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x22788sX2Svr4c3IWGNpSRRdciLjkQfRLB0eoLdzwmKx32ncl0mnhbWkwlgG5ZWjSO8Ixc6T9
ARC-Seal: i=1; a=rsa-sha256; t=1518707968; cv=none;
        d=google.com; s=arc-20160816;
        b=A/Herb2h820wZHkc5U0Qh0fxYQTR4EvgNUOEmmZDvx855isLonBpZtcVucPh1z594Y
         Nv28Z8CkiOPa+SnqXxfmwxBXdqwjh5Ylr/+ubTuTtLIBRJTXq37nfiq/+2pNedLvJDR9
         2/FwSGyRyGzp7GelXf1EU5YnGbYdWrpu+T7ejsm1S8z4GBDx3Hz59L8ApT61vvbMctcl
         u8Q4JJMcFYd+TQ93o6lSEqSPTXTxWWUgE5AkDyBo5dKfMD/uGsCzVWNtyEDktJK4JrRA
         F9XMOutAgj/Wfz67rlvl/jytbnasJFz4vwvNj8UCrYFDDBDNELy9ePkPCHVEgIJmdCyZ
         SqkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=K77uZ6gOQsLzgMZYSl1hlWFixVhl0Qs/DtCidefUtp4=;
        b=GWejf1kjfhmt/4jW1Hdtj3i9xuzM4ErpA8DQRHCKIXX9SOI/kS6ECG7XsegfpaEoFI
         fbLiGrPpLUgIQ5FwOGBcvufWeol9TkRObl58gz7eHn8DXgTw2aCtvf1SvQlHpt4q2Wck
         MywaJtbuEkdHhsTi9vpYRpfwnMy4VFLjrBVDrnjKzZgKKTS5FKXuxGj+tpVU2i764O/Q
         lzg3WPRpKiFIyB2zSVFs2jAVzb7r5yFCccYOg80YVbMd1asgVGOcRWNGmXNdQ4UcMTGw
         amL355ZLVLgS6Fk53k4pRmkvoX19uYKSX4iibN+FWTM62TsIivN7RaGlCdXXJdYDpBBr
         ZavA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mike Galbraith <efault@gmx.de>,
	Trond Myklebust <trond.myklebust@primarydata.com>
Subject: [PATCH 3.18 28/45] NFS: Add a cond_resched() to nfs_commit_release_pages()
Date: Thu, 15 Feb 2018 16:17:19 +0100
Message-Id: <20180215144121.995411339@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480726935884245?=
X-GMAIL-MSGID: =?utf-8?q?1592480726935884245?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@primarydata.com>

commit 7f1bda447c9bd48b415acedba6b830f61591601f upstream.

The commit list can get very large, and so we need a cond_resched()
in nfs_commit_release_pages() in order to ensure we don't hog the CPU
for excessive periods of time.

Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/write.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1646,6 +1646,8 @@ static void nfs_commit_release_pages(str
 		set_bit(NFS_CONTEXT_RESEND_WRITES, &req->wb_context->flags);
 	next:
 		nfs_unlock_and_release_request(req);
+		/* Latency breaker */
+		cond_resched();
 	}
 	nfss = NFS_SERVER(data->inode);
 	if (atomic_long_read(&nfss->writeback) < NFS_CONGESTION_OFF_THRESH)
