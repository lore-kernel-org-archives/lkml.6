Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+jLPQb1GfEgGZIyGQ5rMfreZOkWrGFgLmfWmdLQoWN00wnnBE+v2z9Uei/6Roh1li/Dlxh
ARC-Seal: i=1; a=rsa-sha256; t=1523981078; cv=none;
        d=google.com; s=arc-20160816;
        b=lfCpSF8auSlg6QmIqr3ixECRJwO0EzSK873bIs1XvPaJJq4yjaFLA96s4JxkI4Ur3h
         o9X5ONyzBtrpws0KSdbYP4HsLMRQksZ/qKA+2SMFS+xkaSgb0KT5UQNuKm++EUTNrYBn
         E/KY4I9SXx1/4p3prAk0+7t/oUArIJ/pV65DMquOiTfC0hJTQX1UnCDUtKdGUoXzRQYz
         6JZJJyPhPodiTioLe++aLI9pc0rO4R99HC60i5xu5zDjqUK0XmVFe4l8yBXgi76UdbOg
         GZ1i9f6MrYC6KWeXt0eKVyA3ZuaIT7bJ40DFVv50W2Mr/k8cLl1ZlSodJNNSgD1IzRJH
         VHGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XcyuSLxRa7wYPP3Qng1iYWHmumMIOGZtErY22awf5Rg=;
        b=z3+hn+W544RS/6fdW9fyjGwSq+LOuLth/V3Mz1ZAqxaviPSm9jReg3BA3BosQDDHtc
         ku5VDnCmUc0Wy0qW/Kbpdu4MQOLurDrsnoe/PRzT/qJxmaJnIZ1Ip8BNtv7pbLobBuFk
         /UfdId8gUskZCqRUt14jmiNQTs4ZKmLVByU46ToKsot3xtWmGO8dC6MVYCAqA4mHHs9B
         A6NEEfyIYdFccHiD6fC/VB3YWBn1raosRbaNIrwWQ7Z5+m6m1gzvwiurV7mjhy2VU7/Q
         0GYhV/HO4FTHilhgZnWvUia0jDaLS9zA9H1b/lnnKeCXVYlWUPMQGShwL4dN/3umwH5B
         40TA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Rue <dan.rue@linaro.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Anders Roxell <anders.roxell@linaro.org>,
	Michal Hocko <mhocko@kernel.org>,
	Yisheng Xie <xieyisheng1@huawei.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Nic Losby <blurbdust@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.15 35/53] hugetlbfs: fix bug in pgoff overflow checking
Date: Tue, 17 Apr 2018 17:59:00 +0200
Message-Id: <20180417155724.841264329@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009812086723888?=
X-GMAIL-MSGID: =?utf-8?q?1598009983116114066?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Kravetz <mike.kravetz@oracle.com>

commit 5df63c2a149ae65a9ec239e7c2af44efa6f79beb upstream.

This is a fix for a regression in 32 bit kernels caused by an invalid
check for pgoff overflow in hugetlbfs mmap setup.  The check incorrectly
specified that the size of a loff_t was the same as the size of a long.
The regression prevents mapping hugetlbfs files at offsets greater than
4GB on 32 bit kernels.

On 32 bit kernels conversion from a page based unsigned long can not
overflow a loff_t byte offset.  Therefore, skip this check if
sizeof(unsigned long) != sizeof(loff_t).

Link: http://lkml.kernel.org/r/20180330145402.5053-1-mike.kravetz@oracle.com
Fixes: 63489f8e8211 ("hugetlbfs: check for pgoff value overflow")
Reported-by: Dan Rue <dan.rue@linaro.org>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Yisheng Xie <xieyisheng1@huawei.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Nic Losby <blurbdust@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/hugetlbfs/inode.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -148,10 +148,14 @@ static int hugetlbfs_file_mmap(struct fi
 
 	/*
 	 * page based offset in vm_pgoff could be sufficiently large to
-	 * overflow a (l)off_t when converted to byte offset.
+	 * overflow a loff_t when converted to byte offset.  This can
+	 * only happen on architectures where sizeof(loff_t) ==
+	 * sizeof(unsigned long).  So, only check in those instances.
 	 */
-	if (vma->vm_pgoff & PGOFF_LOFFT_MAX)
-		return -EINVAL;
+	if (sizeof(unsigned long) == sizeof(loff_t)) {
+		if (vma->vm_pgoff & PGOFF_LOFFT_MAX)
+			return -EINVAL;
+	}
 
 	/* must be huge page aligned */
 	if (vma->vm_pgoff & (~huge_page_mask(h) >> PAGE_SHIFT))
