Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs2H7IxLNDseud4GpDULTuxEb1cLREfnwRbFkIouqyetBey5N8Z4rvv6pkpbcfwRfTRjivH
ARC-Seal: i=1; a=rsa-sha256; t=1519981054; cv=none;
        d=google.com; s=arc-20160816;
        b=If8FsxNNIhqD72MgD+Y48B1AaP6m1X0CPHwULVpZ9kjUIFU7Sq96n1c+SE2ZUz60mk
         93g3BK49Dp7flYC88U6yeIqySbVbl9rrjcf7rs9VY93f22OgPad6BhYdD1tkjRHkLzL6
         mJ7VW422NH5DUYRyzIelIysE/JFHbCs7DEbNbv/xZkatEmf4/8VspVEn1FQ02uNmbGKh
         St1Gcd+E65FLXU+U2MQ4iU43U6VwhRm5moTtS6x4E8lghNfysbTAJlUBFRB3V1IORlNk
         0uvN8HTEdD85YfoZzGv/+UH/73NVCXhdPs52O3/5Fy6uMTqN6xDWv83DvcGpZRGK4xuO
         dLEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TxsEGwj1YeSYPdt8MhX2dFfsG9MPUD3OuiSc+nVjDf4=;
        b=CpxP92y66wbQMGiL99fjGo+QgkQpJ6a6kYnvSvM9DtfWzzfYSvRf9UpvO6hrHd8gCj
         P8ruyH3mszI4GZKP0P76EY0Yr43ASmH1C8wzS1svi2BaTEAYQIomhDo8uSp4Az5IglrO
         F/dWNR2beXjELbGt9sChZXQmiedhmYjJv02oWMJfyPJI36siL9fK5o0cN0LaL7yugYFa
         QXJhrQbygxb/0YqTUTfBIud/WTF0tXVTExOFvyT5xMwcOPQ2OVosNk8bUnsRgsObTgCs
         L2d9+uQRlkzSRUAWGPDN2o+BMzzU0Urclr72CaOgBquyvjop82FqmCONpWBfb5UNf7HF
         un1g==
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
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 36/56] xfs: quota: fix missed destroy of qi_tree_lock
Date: Fri,  2 Mar 2018 09:51:22 +0100
Message-Id: <20180302084451.405494748@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815293886209224?=
X-GMAIL-MSGID: =?utf-8?q?1593815654130722366?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aliaksei Karaliou <akaraliou.dev@gmail.com>


[ Upstream commit 2196881566225f3c3428d1a5f847a992944daa5b ]

xfs_qm_destroy_quotainfo() does not destroy quotainfo->qi_tree_lock
while destroys quotainfo->qi_quotaofflock.

Signed-off-by: Aliaksei Karaliou <akaraliou.dev@gmail.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_qm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -735,6 +735,7 @@ xfs_qm_destroy_quotainfo(
 		IRELE(qi->qi_pquotaip);
 		qi->qi_pquotaip = NULL;
 	}
+	mutex_destroy(&qi->qi_tree_lock);
 	mutex_destroy(&qi->qi_quotaofflock);
 	kmem_free(qi);
 	mp->m_quotainfo = NULL;
