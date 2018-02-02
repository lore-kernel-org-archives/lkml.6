Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227CYJFNtlZJNcPaFWiKE6WRA7YtkeopGPFwyAdre28RcNUwVOm6iVmMgMmm8e2iLXr0zmNl
ARC-Seal: i=1; a=rsa-sha256; t=1517590887; cv=none;
        d=google.com; s=arc-20160816;
        b=IJXFPgmTSnPS8qQIQI15K9X13DtveOCkCN7593qKh8hoel1MHzOODHKxxMhSK2rCD2
         ayg6kUUj84qs3hwmVdtG1viFLnaayMVavPTtdAL1J/TJxDxnZpOPE9nbLdYNZshJuMrc
         LUaZHhvsxCBZjp+IDGFOOgH0TbO1KK+HhT2pN0mN6BJBS9YI/pm0cAiiO1SBEgyyc/FN
         +JTuLUFMe847gpMJrsm47UIzfgry4V0hYxCWGBiQCRyIwQQZvK6dSIZ9c7PcAOqyP4p0
         GY7GvsBxm/hTkFfOnnec+P1jMKWYj2v2eaYlPDrJkgw7D5P3vq0Hi7jCYK+TmrRH7s72
         lHPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ad5aY8JiyQZLr3H/PrHdHozNY9L1tOg34j/rcqN9ocA=;
        b=LCAlEFFGT+p+mRVvfbdjZFCPffNTMcNnEymhdSMIfn/VzP3L/QqFf06RSDBRzM/dzu
         Ag5o7APYSbj5e990Vxz0NVNYPQ14gabQYjY7C7NaUMz+bjVGqwmQF371BnmvsOJS++Ec
         2/tAL6t/joaOzBdGyddRmBDuAyAG96GIrfm3opUnpoHstRDDzIQjDlmRrBhbrfCfgCMZ
         PNHbhTxigQQ++Mrl5fcv3NrrlWfX4te0T8qgus7RqqFuJuTNQ2JoCmlUiLD+F6lDEYIb
         n5h17pmoeajA6pKnak8Urkfsga3wrMop+2ElH0BVSswJzLrna2skTnMN1+7lYtwj2R85
         QuSg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yisheng Xie <xieyisheng1@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Michal Hocko <mhocko@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 47/67] kmemleak: add scheduling point to kmemleak_scan()
Date: Fri,  2 Feb 2018 17:58:16 +0100
Message-Id: <20180202140820.602701736@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309382786408029?=
X-GMAIL-MSGID: =?utf-8?q?1591309382786408029?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yisheng Xie <xieyisheng1@huawei.com>


[ Upstream commit bde5f6bc68db51128f875a756e9082a6c6ff7b4c ]

kmemleak_scan() will scan struct page for each node and it can be really
large and resulting in a soft lockup.  We have seen a soft lockup when
do scan while compile kernel:

  watchdog: BUG: soft lockup - CPU#53 stuck for 22s! [bash:10287]
 [...]
  Call Trace:
   kmemleak_scan+0x21a/0x4c0
   kmemleak_write+0x312/0x350
   full_proxy_write+0x5a/0xa0
   __vfs_write+0x33/0x150
   vfs_write+0xad/0x1a0
   SyS_write+0x52/0xc0
   do_syscall_64+0x61/0x1a0
   entry_SYSCALL64_slow_path+0x25/0x25

Fix this by adding cond_resched every MAX_SCAN_SIZE.

Link: http://lkml.kernel.org/r/1511439788-20099-1-git-send-email-xieyisheng1@huawei.com
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/kmemleak.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1394,6 +1394,8 @@ static void kmemleak_scan(void)
 			if (page_count(page) == 0)
 				continue;
 			scan_block(page, page + 1, NULL);
+			if (!(pfn % (MAX_SCAN_SIZE / sizeof(*page))))
+				cond_resched();
 		}
 	}
 	put_online_mems();
