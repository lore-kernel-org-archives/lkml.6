Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49sed/NwvZhihET+YXRcGCOgJ2VsUcCG6cYcchAg78JQ1e6VyAtwk29jkeX8NBSW3WrwZEV
ARC-Seal: i=1; a=rsa-sha256; t=1523980915; cv=none;
        d=google.com; s=arc-20160816;
        b=xHY6nIRP9OH+Jo2wobJjl5WY4FhADu9nUXmEByYX1oPMyJR7s+gNzBRjrroVqHsJwo
         NCUYXdk4JfgZWJjYSfaXh1o3Bh/xcRymAq4iNhJMIpcxlYLos49EGXrgGV6tUALxE52M
         ENzq73kUwRslDIwUV4BljlirFo7NOAIiL3x6G68C2maQJRwrA+syFtQu5JCp5u5CzqxS
         raUq8OAoDoZmkIbmIuFRgZKD07H32W4r1RDhzgWFNznNInsm2GgxugNj5im0Hj9xwc/9
         YX9cffE93Vs5al9iprB07DEcCgk119NSamEqGuvnVTml8MYzH/c70mW59IU9HQHChEj8
         AeZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1zb4rtzV2w8TALktvbYxktRyvieWGwbcgPF77adn5yE=;
        b=iFi3JNa2sd6G6Xlhj0tIVQe7L3a4Zcz7dljveEI4tVz6qYGVNX7Bmxbu7HEgXkc3Rw
         3UTVNjJ7mRncFWa9zJYVkEJE72/l0sWDKbbxTUGG5b2i69x/yiEtRUzFa7U5ehX402EW
         t4tbccSvICmTA658b19rbog//YyF1cDEQOgUQm2ItE9JkoldWQ9W3xuodNV4vCCr1ERn
         vxlgovymbNwKMtEuo3MBMjFSjXekIQ5Emf1FzrmC7X8CxjQrhJRYGFVG0miNtFmtq7ZW
         kurGSAtllwxfXbvgmjyJL8T/hRpSzcWCZ2P8nBj3b1pv/YNRgpMDNdt7o3wbxl3f+YBL
         yvuw==
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
Subject: [PATCH 4.16 49/68] hugetlbfs: fix bug in pgoff overflow checking
Date: Tue, 17 Apr 2018 17:58:02 +0200
Message-Id: <20180417155751.346424626@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009812086723888?=
X-GMAIL-MSGID: =?utf-8?q?1598009812086723888?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -138,10 +138,14 @@ static int hugetlbfs_file_mmap(struct fi
 
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
