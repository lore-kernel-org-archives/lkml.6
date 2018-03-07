Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvjMeLFERFt+1cqbebt5WFD0bPMLHN9cD+VfmzCxuMUlrnRuIvEj1SAf69+RXIvdQNSaLla
ARC-Seal: i=1; a=rsa-sha256; t=1520451703; cv=none;
        d=google.com; s=arc-20160816;
        b=Hq8CUPZxXBZLYPGmuYg70n6cfxLD9w3VkNQvBOLSMhE62GLIkpm/+ucjT7mVVolFBq
         5LnAGqoCUsVOj+lDTYKVrnA1beVo8PbXUkMsC5PT6MNZ7kEBilHUGKebfzuuyI1lDvrb
         +e/9qWUqe1bZJqjixuEYSoOiOqrxw4VoEfVuDlzkc/Ijzxiwg+i6iq0Pxr7s3x4ykc4Z
         NxThnjUA2cQTB1EqKYqbRDYs/rZf/p9usaaiqYSAwz6VP9Ix4oWZDziFNnp3dM8Noy4S
         Zn9nHaSHWUXZ0KLQqVwdRedASX+jbD9QUm9wpYlP4ipCsc7dPaYkc4cMBOHFBl9i3jqZ
         doRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JBbT8dCMDFoTiOL0OWX4aGy+Pm7FlL67ebqzYRo/qPA=;
        b=UC5ROrJF3gXMjrbXoIJiNH/+UX82Ib9vsChaCCpjhKZb9Qs1pZKvJdT0PQxeJBS6FX
         eU+QJFTJLY9dWkIcEubzKAelXqn3XLUVmv4r8hFKoOXOEVYA/uE5IfTShfyDephAUsOn
         czGQVhu6J3b0SpbUUGNbtP5zjOt3+dg8ueUDGwhSvpEhy+69Ckj7BnKo6HSa9TGPQjaX
         ohncvcGeOj/wm2PXfF3un+6jAPX4c4yVHsrBxixdGyzlZ5kviTB2oJdv6EMV8tVTz/NM
         yBY7ld6Be/gLOVOIf+RPJas+iIeF3O5tNVO3bIVCj05oPqycV576cNTnBC/5IYK36yJ8
         pm/Q==
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
Subject: [PATCH 4.15 034/122] dax: fix vma_is_fsdax() helper
Date: Wed,  7 Mar 2018 11:37:26 -0800
Message-Id: <20180307191734.092421774@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309166179960390?=
X-GMAIL-MSGID: =?utf-8?q?1594309166179960390?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3204,7 +3204,7 @@ static inline bool vma_is_fsdax(struct v
 	if (!vma_is_dax(vma))
 		return false;
 	inode = file_inode(vma->vm_file);
-	if (inode->i_mode == S_IFCHR)
+	if (S_ISCHR(inode->i_mode))
 		return false; /* device-dax */
 	return true;
 }
