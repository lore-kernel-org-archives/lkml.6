Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+3wxk44kV5Hu4B+qUeWn4WxcXAHiuI4hDT5PSenZH9q9g7qA1ql16Fp8ImxidqrFNtPPBa
ARC-Seal: i=1; a=rsa-sha256; t=1524652937; cv=none;
        d=google.com; s=arc-20160816;
        b=lrW2DeV4xqemIjV5P5XvasQXaTrT9b/ARf/exo6FaduAd4C/dPM/EL/Yvs+m8Ml/Sg
         eD2K+NHvAbAN4wV09fkPcUmnH5U8C783b+uxwrH4S9c2Eo0I+D4z/BFuy7G53GoFE/eA
         P79DRlCgZebNGTi+FAGgB2DBCxzVny1UYdAoBr/oU1XqxCgTKfvEzdAHD8pXHrPR9gmH
         KyNTsrMtlwlONvEYhshDQA+9WovOvolQ9mWyK9MdO3z8kiiOvUhEl9MB8gVhzD97f0xf
         YgvIB9EZAM9OwynQPff2JMUBDqrtuBuRDoEGTFFRIDi+APEjtlzDtGfwbEWZh3oXKMED
         C2KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=057UN+xsyK/6jR4qSAwwiAh6XTJVUktYur8qVDtSdR4=;
        b=LY4+pG4AsSwPS0LfyDL+6gV3SBYDH71We4pOiMkO3DVBdkL85COXXqAQ49UFUnhygS
         QV5CSm4OcrvnMG2K+EyqiqS1HeGryC/oHyQTXItUS0fU8DomQzAy8a+DA1zEiu52GPlb
         IlMCfKQSTGZ6SggoqSGftClo5kdbW0nlMuA8DND7mGck/+nANNHVNwQOYyF5C9tLAovE
         YWUqowIKgsDl3m5v8qTzXVrosrSmMIsJ5jwqZCdPTbG+nMS4In49JY3UprZG+ELqOZeE
         PmWUjGoRmGW1MzMLAGrDpnL//gYMTxdq4+KMdzXonod1fkVZRYab18DBOJBj5K6BuOQh
         H9qw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"=?UTF-8?q?Jan=20H . =20Sch=C3=B6nherr?=" <jschoenh@amazon.de>,
	Ross Zwisler <ross.zwisler@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <mawilcox@microsoft.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 107/183] fs/dax.c: release PMD lock even when there is no PMD support in DAX
Date: Wed, 25 Apr 2018 12:35:27 +0200
Message-Id: <20180425103246.753797503@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714478709002871?=
X-GMAIL-MSGID: =?utf-8?q?1598714478709002871?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Jan H. Schönherr" <jschoenh@amazon.de>


[ Upstream commit ee190ca6516bc8257e3d36187ca6f0f71a9ec477 ]

follow_pte_pmd() can theoretically return after having acquired a PMD
lock, even when DAX was not compiled with CONFIG_FS_DAX_PMD.

Release the PMD lock unconditionally.

Link: http://lkml.kernel.org/r/20180118133839.20587-1-jschoenh@amazon.de
Fixes: f729c8c9b24f ("dax: wrprotect pmd_t in dax_mapping_entry_mkclean")
Signed-off-by: Jan H. SchÃ¶nherr <jschoenh@amazon.de>
Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/dax.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/dax.c
+++ b/fs/dax.c
@@ -630,8 +630,8 @@ static void dax_mapping_entry_mkclean(st
 			set_pmd_at(vma->vm_mm, address, pmdp, pmd);
 			mmu_notifier_invalidate_range(vma->vm_mm, start, end);
 unlock_pmd:
-			spin_unlock(ptl);
 #endif
+			spin_unlock(ptl);
 		} else {
 			if (pfn != pte_pfn(*ptep))
 				goto unlock_pte;
