Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELuuEDnIZBXDGRnUB+YmXdkv4u42/4Qh07x+AEVbG5HwcYoumBbJU3Lp2RX0Wu+7YffzvAfw
ARC-Seal: i=1; a=rsa-sha256; t=1520295994; cv=none;
        d=google.com; s=arc-20160816;
        b=p7BIjG9SsWFk+3/YxE+EDS0Pwoq7IDjZ6TUyMkRiao/MdfpvcQzKYqvNB964dObgN+
         0pd+mKLKtUHjgtzn/QvdWeenUSd4Z7x7xHKEC6qwohIb1mbfdezN1UhlhpMCM8PAhIs6
         ckiQB74DvC5BmiKsN5iCmXzKanWCjLndMyxVtWSaebymOpL6Y9281FtV+OhH05MzQgMP
         wzOeuiVuxnw7HCJ4P2vL032M7V/GWfYF1MeeOBrO8fCaMrIhk4jpZwlwgO2FoTNNoMqX
         MfBo2T2CuhTR3wjrKyvC0PrTovhY01cHyKRwt0h/XP9d11aKrKPDctynXVbxd2bvP5Yl
         Xn4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=cJNAWvuD/aNJT5KU8hw5bL0s8w9r98pBtgK50rGxgqk=;
        b=u1sSAyV/4jU/0CPoiHrVpnOVC8JyOf4hZWZfyYqxrCRgA9+reHEWot4mAZTahnznr+
         w0NGU1WnR+PlWCLxRqyXZqjAmLj1iC1/IHqdlkeZUzzv/UdQs3cwunv+WkQR6PenpOi9
         xu0ppKJL7D29dsT4GvGcIrJVfBxCriR1VwP5g2/Ex5vx+pAB99te7Q7umLOLlzkFuFk8
         hN2q8b4BcK7nF0oQgsQVhviyo06QnTSRHCR1OfAQr7I1o61ZAVhYsEe/vxdVWiebUY4+
         XJTkBvK3kNLjrNtgmyQjuaM4PMhSkfMUyAqUVg6PR7mvJkOzt7hdG5kcbDcRPY1TIAtx
         yuXg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=T+vYwGoT;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=T+vYwGoT;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 37/65] kaiser: kaiser_remove_mapping() move along the pgd
Date: Mon,  5 Mar 2018 19:25:10 -0500
Message-Id: <20180306002538.1761-38-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145892673771837?=
X-GMAIL-MSGID: =?utf-8?q?1594145892673771837?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

When removing the bogus comment from kaiser_remove_mapping(),
I really ought to have checked the extent of its bogosity: as
Neel points out, there is nothing to stop unmap_pud_range_nofree()
from continuing beyond the end of a pud (and starting in the wrong
position on the next).

Fix kaiser_remove_mapping() to constrain the extent and advance pgd
pointer correctly: use pgd_addr_end() macro as used throughout base
mm (but don't assume page-rounded start and size in this case).

But this bug was very unlikely to trigger in this backport: since
any buddy allocation is contained within a single pud extent, and
we are not using vmapped stacks (and are only mapping one page of
stack anyway): the only way to hit this bug here would be when
freeing a large modified ldt.

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit f127705d26b34c053e59b47aef84b3ea564dd743)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/mm/kaiser.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/kaiser.c b/arch/x86/mm/kaiser.c
index 190371071a02..8996f3292596 100644
--- a/arch/x86/mm/kaiser.c
+++ b/arch/x86/mm/kaiser.c
@@ -297,11 +297,13 @@ void kaiser_remove_mapping(unsigned long start, unsigned long size)
 	extern void unmap_pud_range_nofree(pgd_t *pgd,
 				unsigned long start, unsigned long end);
 	unsigned long end = start + size;
-	unsigned long addr;
+	unsigned long addr, next;
+	pgd_t *pgd;
 
-	for (addr = start; addr < end; addr += PGDIR_SIZE) {
-		pgd_t *pgd = native_get_shadow_pgd(pgd_offset_k(addr));
-		unmap_pud_range_nofree(pgd, addr, end);
+	pgd = native_get_shadow_pgd(pgd_offset_k(start));
+	for (addr = start; addr < end; pgd++, addr = next) {
+		next = pgd_addr_end(addr, end);
+		unmap_pud_range_nofree(pgd, addr, next);
 	}
 }
 
-- 
2.16.2
