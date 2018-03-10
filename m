Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuEyk+lo1RpJRj9PGcEGC2jLO/g/jlDTM3kq+of+bVKEwqL9W1do94mKSc9Q8B4tsm0Gwu/
ARC-Seal: i=1; a=rsa-sha256; t=1520641268; cv=none;
        d=google.com; s=arc-20160816;
        b=h8UvxO88v7GgmLDgwJGl05443iKZlwnu/gJQJfoax5I5AXBt5QNXT+BN/pWV6JMAVG
         jy4+nMGc903lkeHcg0+zQfMWP//4EFD9e64IZnCfBvLu57H0DaoA/pG3bL9PJ36ppdjC
         s5EZXmI9u/cbuLB0oWSX34nh3gu6wFq2k2kGuvJUJGcFrh5MEH/DulVTux3Tz6hE+II8
         LgRlBbgiPB0V1je8jJHbimwY7X+jQJxyytsdAe3q3CILSSiAP5ym0XvtyHq0z0GPVriF
         jJcmx/c4rvIDCog5uJQA3aY7+PxXLAtEIWBBNAuxODF734cRMQ/CnbxJupjo5bLsx0wk
         rpjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UKrpAmQDHrI2xvGunUux5oND50EN2l3VPdjle7b335c=;
        b=My/y8RsOIDB+9zYlL8k0B6+q7uc/IX5A0gYk9Dl9UlCFMomAAOsmLriWCoHBLLvnf1
         zSYC9vTr4vKn8+oesGVV5bbillw0cFD2uFhdAcHGc54ULu5lRV58cLqxDwNXQj0D6HfC
         6FaJGK+nVIz9CxLP2oZM4HMydna8m08X+qCVYxEMH88j+RsX1MaInvnp03ct44HdSSrj
         aVM41c2Av8tegc+R+3bnVlOUNr4dEI6S4ZDkPsRm6fnTJohWFtPUwgjW42JHVMzqv968
         4ZuV+vyhYAFOQHxuwGQ5h8Wfv2/8v4xxhUJSbzc2ATHDzidodbuQu7QHEBbvCe3Qjr5b
         Zraw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Gerd Rausch <gerd.rausch@oracle.com>,
	Jane Chu <jane.chu@oracle.com>,
	Haozhong Zhang <haozhong.zhang@intel.com>,
	Jan Kara <jack@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.9 14/65] dax: fix vma_is_fsdax() helper
Date: Fri,  9 Mar 2018 16:18:14 -0800
Message-Id: <20180310001826.124371683@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507938109871202?=
X-GMAIL-MSGID: =?utf-8?q?1594507938109871202?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 230f5a8969d8345fc9bbe3683f068246cf1be4b8 upstream.

Gerd reports that ->i_mode may contain other bits besides S_IFCHR. Use
S_ISCHR() instead. Otherwise, get_user_pages_longterm() may fail on
device-dax instances when those are meant to be explicitly allowed.

Fixes: 2bb6d2837083 ("mm: introduce get_user_pages_longterm")
Cc: <stable@vger.kernel.org>
Reported-by: Gerd Rausch <gerd.rausch@oracle.com>
Acked-by: Jane Chu <jane.chu@oracle.com>
Reported-by: Haozhong Zhang <haozhong.zhang@intel.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/fs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3048,7 +3048,7 @@ static inline bool vma_is_fsdax(struct v
 	if (!vma_is_dax(vma))
 		return false;
 	inode = file_inode(vma->vm_file);
-	if (inode->i_mode == S_IFCHR)
+	if (S_ISCHR(inode->i_mode))
 		return false; /* device-dax */
 	return true;
 }
