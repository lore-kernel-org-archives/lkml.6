Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvMyJ+iKdQU+C5rBofef5EtYBdHsYKJPantjmFV/R3NiRN66QNQD/ft7Hgm3toLT+QHF69S
ARC-Seal: i=1; a=rsa-sha256; t=1519981373; cv=none;
        d=google.com; s=arc-20160816;
        b=XKsgkbOr20GiIJB4GWr/W3ocwTyGWXbxo0r3qJrHkaO2FWGNpvrJf4XemiNJBlwL0v
         S3+inyN2h8E+eruoNJqcr3o6zub9WCalnrhI9/k5E2cWo/F5158Db4l70DIGVCfgmR1l
         RjMCqovcycPJYxOVQKWQU2Cv0zFdCJrWXyqJ/EzBLPx3GZCX76d06Ev0Yv3BIUtY1KMK
         o7SMn3wQOsu9cBEO0aKI47t+bCNRTSfMAOtklWrAYx+JIzjKz6qnaDALF3qmJmeA3eae
         ulGvHkafLRifOXqDJ5SmW9OeBvUF3n6zhEZTBc5KxDOBjSx+Anqv1EqMWcLg0xWzL31m
         Mt6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=G3fjWm2/CobaNrETly4QFmb79FjpfdYLYvf9z8hox14=;
        b=LmSJD7Hn+7kEVjn12Jkhb2gHQUYazQIu7XpHpnnyLcROoOeXsSo3UILlQZT48b9eFB
         LvhRHSk7Jnaw0bTPbPtpqH36xR3BQjvMpjhHrIykpCh5X7sGhuN4QFDs/LhXUYdxLrKY
         VphaBlPK0VVOIe9/qScVFY6F09xtCpZCW+53tjqlRUJtE2/oDrdR+POd2k621NJc6HRy
         hReRAdZs/s+Zpt2n+3gnUGusJ9Lv6B9WLiSLpnU+NFq7l8FsMVgOIRzqDqMvivKRvLGZ
         FMNP+q1psOQOdlQzvoyH2pQjYxRWyftbLu5Zn6fw8UWGMzsouRTpTjin0IEikIDyECgo
         R9mw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Aliaksei Karaliou <akaraliou.dev@gmail.com>,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 072/115] xfs: quota: fix missed destroy of qi_tree_lock
Date: Fri,  2 Mar 2018 09:51:15 +0100
Message-Id: <20180302084506.775852972@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815293886209224?=
X-GMAIL-MSGID: =?utf-8?q?1593815988677507001?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aliaksei Karaliou <akaraliou.dev@gmail.com>


[ Upstream commit 2196881566225f3c3428d1a5f847a992944daa5b ]

xfs_qm_destroy_quotainfo() does not destroy quotainfo->qi_tree_lock
while destroys quotainfo->qi_quotaofflock.

Signed-off-by: Aliaksei Karaliou <akaraliou.dev@gmail.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_qm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -736,6 +736,7 @@ xfs_qm_destroy_quotainfo(
 		IRELE(qi->qi_pquotaip);
 		qi->qi_pquotaip = NULL;
 	}
+	mutex_destroy(&qi->qi_tree_lock);
 	mutex_destroy(&qi->qi_quotaofflock);
 	kmem_free(qi);
 	mp->m_quotainfo = NULL;
